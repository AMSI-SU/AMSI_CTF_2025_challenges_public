#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <pthread.h>
#include <signal.h>
#include <time.h>

#define MAX_CLIENTS 4
#define BOARD_SIZE 8
#define BUFFER_SIZE 1024
#define MAX_MESSAGE_SIZE 512

typedef struct {
    int x, y;
} Position;

typedef struct {
    int id;
    char symbol;
    int socket;
    char name[32];
    Position *owned_cells;
    int cell_count;
    int is_active;
    pthread_t thread;
} Player;

typedef struct {
    int owner_id;
    int visible_to[MAX_CLIENTS];
} Cell;

typedef struct {
    Cell board[BOARD_SIZE][BOARD_SIZE];
    Player players[MAX_CLIENTS];
    int player_count;
    int game_started;
    int current_turn;
    pthread_mutex_t game_mutex;
} GameState;

GameState game_state;
int server_socket;

void init_game_state() {
    memset(&game_state, 0, sizeof(GameState));
    pthread_mutex_init(&game_state.game_mutex, NULL);
    
    // Initialiser le plateau
    for (int i = 0; i < BOARD_SIZE; i++) {
        for (int j = 0; j < BOARD_SIZE; j++) {
            game_state.board[i][j].owner_id = -1;
            memset(game_state.board[i][j].visible_to, 0, sizeof(int) * MAX_CLIENTS);
        }
    }
    
    // Initialiser les symboles des joueurs
    char symbols[] = {'@', '&', 'X', '#'};
    for (int i = 0; i < MAX_CLIENTS; i++) {
        game_state.players[i].symbol = symbols[i];
        game_state.players[i].id = i;
        game_state.players[i].is_active = 0;
        game_state.players[i].owned_cells = malloc(sizeof(Position) * BOARD_SIZE * BOARD_SIZE);
        game_state.players[i].cell_count = 0;
    }
}

void broadcast_message(const char *message, int exclude_socket) {
    pthread_mutex_lock(&game_state.game_mutex);
    for (int i = 0; i < game_state.player_count; i++) {
        if (game_state.players[i].is_active && game_state.players[i].socket != exclude_socket) {
            send(game_state.players[i].socket, message, strlen(message), 0);
        }
    }
    pthread_mutex_unlock(&game_state.game_mutex);
}

void send_to_player(int socket, const char *message) {
    send(socket, message, strlen(message), 0);
}

void update_visibility(int player_id) {
    Player *player = &game_state.players[player_id];
    
    // Réinitialiser la visibilité
    for (int i = 0; i < BOARD_SIZE; i++) {
        for (int j = 0; j < BOARD_SIZE; j++) {
            game_state.board[i][j].visible_to[player_id] = 0;
        }
    }
    
    // Rendre visibles les cases possédées et adjacentes
    for (int c = 0; c < player->cell_count; c++) {
        int x = player->owned_cells[c].x;
        int y = player->owned_cells[c].y;
        
        for (int dx = -1; dx <= 1; dx++) {
            for (int dy = -1; dy <= 1; dy++) {
                int nx = x + dx;
                int ny = y + dy;
                if (nx >= 0 && nx < BOARD_SIZE && ny >= 0 && ny < BOARD_SIZE) {
                    game_state.board[nx][ny].visible_to[player_id] = 1;
                }
            }
        }
    }
}

void send_board_to_player(int player_id) {
    char board_msg[2048] = "\n=== PLATEAU DE JEU ===\n   ";
    
    // En-tête avec numéros de colonnes
    for (int j = 0; j < BOARD_SIZE; j++) {
        char col[4];
        sprintf(col, " %d ", j);
        strcat(board_msg, col);
    }
    strcat(board_msg, "\n");
    
    // Affichage du plateau
    for (int i = 0; i < BOARD_SIZE; i++) {
        char row[256];
        sprintf(row, "%d  ", i);
        strcat(board_msg, row);
        
        for (int j = 0; j < BOARD_SIZE; j++) {
            if (game_state.board[i][j].visible_to[player_id]) {
                if (game_state.board[i][j].owner_id >= 0) {
                    char cell[4];
                    sprintf(cell, " %c ", game_state.players[game_state.board[i][j].owner_id].symbol);
                    strcat(board_msg, cell);
                } else {
                    strcat(board_msg, " . ");
                }
            } else {
                strcat(board_msg, " ? ");
            }
        }
        strcat(board_msg, "\n");
    }
    
    // Informations sur la partie
    char info[256];
    sprintf(info, "\nTour: Joueur %c | Vos cases: %d\n", 
            game_state.players[game_state.current_turn].symbol,
            game_state.players[player_id].cell_count);
    strcat(board_msg, info);
    strcat(board_msg, "========================\n");
    
    send_to_player(game_state.players[player_id].socket, board_msg);
}

int is_adjacent(int player_id, int x, int y) {
    Player *player = &game_state.players[player_id];
    
    for (int c = 0; c < player->cell_count; c++) {
        int px = player->owned_cells[c].x;
        int py = player->owned_cells[c].y;
        
        if (abs(px - x) <= 1 && abs(py - y) <= 1 && !(px == x && py == y)) {
            return 1;
        }
    }
    return 0;
}

void buy_cell(int player_id, int x, int y) {
    char response[256];
    
    if (!game_state.game_started) {
        sprintf(response, "ERREUR: La partie n'est pas encore commencée.\n");
        send_to_player(game_state.players[player_id].socket, response);
        return;
    }
    
    if (game_state.current_turn != player_id) {
        sprintf(response, "ERREUR: Ce n'est pas votre tour.\n");
        send_to_player(game_state.players[player_id].socket, response);
        return;
    }
    
    if (x < 0 || x >= BOARD_SIZE || y < 0 || y >= BOARD_SIZE) {
        sprintf(response, "ERREUR: Coordonnées invalides.\n");
        send_to_player(game_state.players[player_id].socket, response);
        return;
    }
    
    if (game_state.board[x][y].owner_id >= 0) {
        sprintf(response, "ERREUR: Cette case appartient déjà à quelqu'un.\n");
        send_to_player(game_state.players[player_id].socket, response);
        return;
    }
    
    if (!is_adjacent(player_id, x, y)) {
        sprintf(response, "ERREUR: Vous ne pouvez acheter que des cases adjacentes aux vôtres.\n");
        send_to_player(game_state.players[player_id].socket, response);
        return;
    }
    
    // Acheter la case
    game_state.board[x][y].owner_id = player_id;
    Player *player = &game_state.players[player_id];
    player->owned_cells[player->cell_count].x = x;
    player->owned_cells[player->cell_count].y = y;
    player->cell_count++;
    
    // Mettre à jour la visibilité pour tous les joueurs
    for (int i = 0; i < game_state.player_count; i++) {
        if (game_state.players[i].is_active) {
            update_visibility(i);
        }
    }
    
    sprintf(response, "Vous avez acheté la case (%d, %d)!\n", x, y);
    send_to_player(game_state.players[player_id].socket, response);
    
    // Notifier les autres joueurs
    char notification[256];
    sprintf(notification, "Le joueur %c a acheté une case.\n", player->symbol);
    broadcast_message(notification, game_state.players[player_id].socket);
    
    // Passer au joueur suivant
    game_state.current_turn = (game_state.current_turn + 1) % game_state.player_count;
    
    // Envoyer le plateau mis à jour à tous les joueurs
    for (int i = 0; i < game_state.player_count; i++) {
        if (game_state.players[i].is_active) {
            send_board_to_player(i);
        }
    }
}

void start_game() {
    if (game_state.player_count < 2) {
        return;
    }
    
    game_state.game_started = 1;
    game_state.current_turn = 0;
    
    srand(time(NULL));
    
    // Assigner une case aléatoire à chaque joueur
    for (int i = 0; i < game_state.player_count; i++) {
        if (game_state.players[i].is_active) {
            int x, y;
            do {
                x = rand() % BOARD_SIZE;
                y = rand() % BOARD_SIZE;
            } while (game_state.board[x][y].owner_id >= 0);
            
            game_state.board[x][y].owner_id = i;
            game_state.players[i].owned_cells[0].x = x;
            game_state.players[i].owned_cells[0].y = y;
            game_state.players[i].cell_count = 1;
            
            update_visibility(i);
        }
    }
    
    broadcast_message("=== PARTIE COMMENCÉE ===\n", -1);
    
    // Envoyer le plateau initial à tous les joueurs
    for (int i = 0; i < game_state.player_count; i++) {
        if (game_state.players[i].is_active) {
            send_board_to_player(i);
        }
    }
}

void list_players(int requester_socket) {
    char player_list[512] = "=== JOUEURS CONNECTÉS ===\n";
    
    pthread_mutex_lock(&game_state.game_mutex);
    for (int i = 0; i < game_state.player_count; i++) {
        if (game_state.players[i].is_active) {
            char player_info[64];
            sprintf(player_info, "%c - Joueur %d (%d cases)\n", 
                    game_state.players[i].symbol, i + 1, game_state.players[i].cell_count);
            strcat(player_list, player_info);
        }
    }
    strcat(player_list, "========================\n");
    pthread_mutex_unlock(&game_state.game_mutex);
    
    send_to_player(requester_socket, player_list);
}

void send_help(int socket) {
    char help_msg[] = "=== AIDE ===\n"
                     "$play - Lance la partie\n"
                     "$buy <x> <y> - Acheter une case\n"
                     "$list_players - Liste les joueurs\n"
                     "$music_on - Active la musique\n"
                     "$music_off - Éteint la musique\n"
                     "$quit - Quitte le jeu\n"
                     "$help - Affiche cette aide\n"
                     "Sans $ : Envoie un message\n"
                     "============\n";
    send_to_player(socket, help_msg);
}

void handle_command(int player_id, const char *command) {
    char cmd[32], arg1[16], arg2[16];
    int args = sscanf(command, "%s %s %s", cmd, arg1, arg2);
    
    if (strcmp(cmd, "$play") == 0) {
        if (!game_state.game_started) {
            start_game();
        } else {
            send_to_player(game_state.players[player_id].socket, "La partie est déjà en cours.\n");
        }
    }
    else if (strcmp(cmd, "$buy") == 0 && args == 3) {
        int x = atoi(arg1);
        int y = atoi(arg2);
        buy_cell(player_id, x, y);
    }
    else if (strcmp(cmd, "$list_players") == 0) {
        list_players(game_state.players[player_id].socket);
    }
    else if (strcmp(cmd, "$music_on") == 0) {
        system("pkill -f mus1k.mp4 2>/dev/null");
        system("nohup mpv --loop=inf mus1k.mp4 >/dev/null 2>&1 &");
        send_to_player(game_state.players[player_id].socket, "♪ Musique activée ♪\n");
    }
    else if (strcmp(cmd, "$music_off") == 0) {
        system("pkill -f mus1k.mp4 2>/dev/null");
        send_to_player(game_state.players[player_id].socket, "Musique désactivée.\n");
    }
    else if (strcmp(cmd, "$help") == 0) {
        send_help(game_state.players[player_id].socket);
    }
    else if (strcmp(cmd, "$quit") == 0) {
        send_to_player(game_state.players[player_id].socket, "Au revoir ! :(\n");
        close(game_state.players[player_id].socket);
        game_state.players[player_id].is_active = 0;
    }
    else {
        send_to_player(game_state.players[player_id].socket, "Commande inconnue. Tapez $help pour l'aide.\n");
    }
}

void *handle_client(void *arg) {
    int player_id = *(int*)arg;
    int client_socket = game_state.players[player_id].socket;
    char buffer[BUFFER_SIZE];
    
    send_to_player(client_socket, "=== BIENVENUE DANS LE JEU ===\n");
    send_to_player(client_socket, "Tapez $help pour voir les commandes disponibles.\n");
    send_to_player(client_socket, "Tapez $play pour commencer la partie.\n");
    send_to_player(client_socket, "==============================\n");
    
    char join_msg[128];
    sprintf(join_msg, "Le joueur %c s'est connecté !\n", game_state.players[player_id].symbol);
    broadcast_message(join_msg, client_socket);
    
    while (1) {
        memset(buffer, 0, BUFFER_SIZE);
        int bytes_received = recv(client_socket, buffer, BUFFER_SIZE - 1, 0);
        
        if (bytes_received <= 0) {
            break;
        }
        
        // Supprimer le caractère de nouvelle ligne
        buffer[strcspn(buffer, "\n")] = 0;
        
        if (strlen(buffer) == 0) continue;
        
        pthread_mutex_lock(&game_state.game_mutex);
        
        if (buffer[0] == '$') {
            handle_command(player_id, buffer);
        } else {
            // Message de chat
            char chat_msg[MAX_MESSAGE_SIZE + 64];
            sprintf(chat_msg, "[%c]: %s\n", game_state.players[player_id].symbol, buffer);
            broadcast_message(chat_msg, -1);
        }
        
        pthread_mutex_unlock(&game_state.game_mutex);
    }
    
    // Nettoyage à la déconnexion
    pthread_mutex_lock(&game_state.game_mutex);
    game_state.players[player_id].is_active = 0;
    char leave_msg[128];
    sprintf(leave_msg, "Le joueur %c s'est déconnecté.\n", game_state.players[player_id].symbol);
    broadcast_message(leave_msg, -1);
    pthread_mutex_unlock(&game_state.game_mutex);
    
    close(client_socket);
    return NULL;
}

void cleanup_and_exit(int sig) {
    printf("\nArrêt du serveur...\n");
    system("pkill -f mus1k.mp4 2>/dev/null");
    close(server_socket);
    exit(0);
}

int main(int argc, char *argv[]) {
    setvbuf(stdout, NULL, _IONBF, 0);
    
    if (argc != 2) {
        printf("Usage: %s <port>\n", argv[0]);
        return 1;
    }
    
    int port = atoi(argv[1]);
    struct sockaddr_in server_addr, client_addr;
    socklen_t client_len = sizeof(client_addr);
    
    signal(SIGINT, cleanup_and_exit);
    
    init_game_state();
    
    server_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket < 0) {
        perror("Erreur lors de la création du socket");
        return 1;
    }
    
    int opt = 1;
    setsockopt(server_socket, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
    
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(port);
    
    if (bind(server_socket, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        perror("Erreur lors du bind");
        return 1;
    }
    
    if (listen(server_socket, MAX_CLIENTS) < 0) {
        perror("Erreur lors du listen");
        return 1;
    }
    
    printf("Serveur de jeu démarré sur le port %d\n", port);
    printf("En attente de joueurs... (max %d)\n", MAX_CLIENTS);
    
    while (1) {
        int client_socket = accept(server_socket, (struct sockaddr*)&client_addr, &client_len);
        if (client_socket < 0) {
            perror("Erreur lors de l'accept");
            continue;
        }
        
        pthread_mutex_lock(&game_state.game_mutex);
        
        if (game_state.player_count >= MAX_CLIENTS) {
            send(client_socket, "Serveur plein. Connexion refusée.\n", 34, 0);
            close(client_socket);
            pthread_mutex_unlock(&game_state.game_mutex);
            continue;
        }
        
        int player_id = game_state.player_count;
        game_state.players[player_id].socket = client_socket;
        game_state.players[player_id].is_active = 1;
        game_state.player_count++;
        
        pthread_create(&game_state.players[player_id].thread, NULL, handle_client, &player_id);
        pthread_detach(game_state.players[player_id].thread);
        
        pthread_mutex_unlock(&game_state.game_mutex);
        
        printf("Nouveau joueur connecté (%c) - Total: %d/%d\n", 
               game_state.players[player_id].symbol, game_state.player_count, MAX_CLIENTS);
    }
    
    return 0;
}