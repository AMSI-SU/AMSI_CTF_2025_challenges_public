#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <pthread.h>
#include <signal.h>
#include <termios.h>

#define BUFFER_SIZE 1024
#define MESSAGE_SIZE 512

int client_socket = -1;
int connected = 0;
pthread_t receive_thread;

struct termios old_termios;

void restore_terminal() {
    tcsetattr(STDIN_FILENO, TCSANOW, &old_termios);
}

void setup_terminal() {
    struct termios new_termios;
    tcgetattr(STDIN_FILENO, &old_termios);
    new_termios = old_termios;
    new_termios.c_lflag |= ICANON | ECHO;
    tcsetattr(STDIN_FILENO, TCSANOW, &new_termios);
    atexit(restore_terminal);
}

void cleanup_and_exit(int sig) {
    if (connected && client_socket >= 0) {
        send(client_socket, "$quit\n", 6, 0);
        close(client_socket);
    }
    printf("\nDéconnexion... Au revoir ! :(\n");
    exit(0);
}

void *receive_messages(void *arg) {
    char buffer[BUFFER_SIZE];
    
    while (connected) {
        memset(buffer, 0, BUFFER_SIZE);
        int bytes_received = recv(client_socket, buffer, BUFFER_SIZE - 1, 0);
        
        if (bytes_received <= 0) {
            if (connected) {
                printf("\nConnexion perdue avec le serveur.\n");
                connected = 0;
            }
            break;
        }
        printf("message recu !");
        printf("%s", buffer);
        fflush(stdout);
    }
    
    return NULL;
}

int connect_to_server(const char *hostname, int port) {
    struct sockaddr_in server_addr;
    struct hostent *host_entry;
    
    client_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (client_socket < 0) {
        perror("Erreur lors de la création du socket");
        return 0;
    }
    
    // Résoudre le nom d'hôte
    host_entry = gethostbyname(hostname);
    if (host_entry == NULL) {
        // Essayer de traiter comme une adresse IP
        if (inet_addr(hostname) == INADDR_NONE) {
            printf("Erreur: Impossible de résoudre '%s'\n", hostname);
            close(client_socket);
            return 0;
        }
    }
    
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(port);
    
    if (host_entry != NULL) {
        memcpy(&server_addr.sin_addr, host_entry->h_addr_list[0], host_entry->h_length);
    } else {
        server_addr.sin_addr.s_addr = inet_addr(hostname);
    }
    
    printf("Connexion au serveur %s:%d...\n", hostname, port);
    
    if (connect(client_socket, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        perror("Erreur lors de la connexion");
        close(client_socket);
        return 0;
    }
    
    printf("Connecté avec succès !\n\n");
    connected = 1;
    
    // Démarrer le thread de réception
    if (pthread_create(&receive_thread, NULL, receive_messages, NULL) != 0) {
        perror("Erreur lors de la création du thread");
        connected = 0;
        close(client_socket);
        return 0;
    }
    
    return 1;
}

void show_welcome() {
    printf("╔══════════════════════════════════════════════╗\n");
    printf("║          🎮 JEU MULTIJOUEUR TERMINAL 🎮       ║\n");
    printf("╠══════════════════════════════════════════════╣\n");
    printf("║  Bienvenue dans le jeu de conquête de cases! ║\n");
    printf("║                                              ║\n");
    printf("║  Pour commencer, connectez-vous à un serveur ║\n");
    printf("║  avec la commande 'connect'.                 ║\n");
    printf("║                                              ║\n");
    printf("║  Commandes disponibles:                      ║\n");
    printf("║  • connect <adresse> <port> - Se connecter   ║\n");
    printf("║  • help - Afficher cette aide               ║\n");
    printf("║  • quit - Quitter le programme               ║\n");
    printf("╚══════════════════════════════════════════════╝\n\n");
}

void show_help() {
    printf("\n╔══════════════════════════════════════════════╗\n");
    printf("║                    AIDE                      ║\n");
    printf("╠══════════════════════════════════════════════╣\n");
    printf("║ AVANT CONNEXION:                             ║\n");
    printf("║  connect <adresse> <port> - Se connecter     ║\n");
    printf("║  help - Afficher cette aide                 ║\n");
    printf("║  quit - Quitter                             ║\n");
    printf("║                                              ║\n");
    printf("║ APRÈS CONNEXION:                             ║\n");
    printf("║  $play - Lancer la partie                   ║\n");
    printf("║  $buy <x> <y> - Acheter une case            ║\n");
    printf("║  $list_players - Lister les joueurs         ║\n");
    printf("║  $music_on - Activer la musique             ║\n");
    printf("║  $music_off - Désactiver la musique         ║\n");
    printf("║  $help - Aide des commandes du jeu          ║\n");
    printf("║  $quit - Quitter le jeu                     ║\n");
    printf("║                                              ║\n");
    printf("║  Messages sans '$' = chat avec les joueurs  ║\n");
    printf("╚══════════════════════════════════════════════╝\n\n");
}

void show_game_interface() {
    printf("\n╔══════════════════════════════════════════════╗\n");
    printf("║              INTERFACE DE JEU                ║\n");
    printf("╠══════════════════════════════════════════════╣\n");
    printf("║ Vous êtes maintenant connecté au serveur !   ║\n");
    printf("║                                              ║\n");
    printf("║ Le plateau de jeu s'affichera ici une fois   ║\n");
    printf("║ qu'un joueur aura lancé la partie ($play).   ║\n");
    printf("║                                              ║\n");
    printf("║ Tapez vos commandes ci-dessous:              ║\n");
    printf("║ • $ pour les commandes                       ║\n");
    printf("║ • Texte normal pour le chat                  ║\n");
    printf("╚══════════════════════════════════════════════╝\n");
    printf("\n[CHAT ET COMMANDES]\n");
    printf("--------------------------------------------------\n");
}

int main() {
    char input[MESSAGE_SIZE];
    char command[32], hostname[256];
    int port;
    
    signal(SIGINT, cleanup_and_exit);
    setup_terminal();
    
    show_welcome();
    
    while (1) {
        if (!connected) {
            // Mode déconnecté - interface d'accueil
            printf("Client> ");
            fflush(stdout);
            
            if (!fgets(input, sizeof(input), stdin)) {
                break;
            }
            
            // Supprimer le caractère de nouvelle ligne
            input[strcspn(input, "\n")] = 0;
            
            if (strlen(input) == 0) {
                continue;
            }
            
            if (sscanf(input, "%s", command) != 1) {
                continue;
            }
            
            if (strcmp(command, "quit") == 0) {
                printf("Au revoir ! :(\n");
                break;
            }
            else if (strcmp(command, "help") == 0) {
                show_help();
            }
            else if (strcmp(command, "connect") == 0) {
                if (sscanf(input, "%s %s %d", command, hostname, &port) == 3) {
                    if (port > 0 && port <= 65535) {
                        if (connect_to_server(hostname, port)) {
                            show_game_interface();
                        }
                    } else {
                        printf("Erreur: Port invalide (1-65535)\n");
                    }
                } else {
                    printf("Usage: connect <adresse/hostname> <port>\n");
                    printf("Exemple: connect localhost 8080\n");
                    printf("Exemple: connect 192.168.1.100 8080\n");
                }
            }
            else {
                printf("Commande inconnue. Tapez 'help' pour voir les commandes disponibles.\n");
            }
        } else {
            // Mode connecté - chat et commandes de jeu
            printf("> ");
            fflush(stdout);
            
            if (!fgets(input, sizeof(input), stdin)) {
                break;
            }
            
            // Supprimer le caractère de nouvelle ligne
            input[strcspn(input, "\n")] = 0;
            
            if (strlen(input) == 0) {
                continue;
            }
            
            // Envoyer le message/commande au serveur
            char message[MESSAGE_SIZE + 2];
            snprintf(message, sizeof(message), "%s\n", input);
            
            if (send(client_socket, message, strlen(message), 0) < 0) {
                printf("Erreur lors de l'envoi du message.\n");
                connected = 0;
                close(client_socket);
                printf("Connexion fermée.\n\n");
                show_welcome();
                continue;
            }
            


            // Si c'est la commande quit, on se déconnecte
            if (strncmp(input, "$quit", 5) == 0) {
                printf("Fermeture de la connexion...\n");
                connected = 0;
                
                // Attendre que le thread de réception se termine
                pthread_join(receive_thread, NULL);
                close(client_socket);
                
                printf("Déconnecté du serveur.\n\n");
                show_welcome();
            }
        }
    }
    
    // Nettoyage final
    if (connected) {
        send(client_socket, "$quit\n", 6, 0);
        pthread_cancel(receive_thread);
        pthread_join(receive_thread, NULL);
        close(client_socket);
    }
    
    printf("Merci d'avoir joué ! Au revoir ! 👋\n");
    return 0;
}