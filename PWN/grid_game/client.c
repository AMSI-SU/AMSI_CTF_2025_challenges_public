#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

#define MAX_SIZE_MESSAGE 1024
#define MAX_SIZE_PSEUDO 64

int client_socket = -1;
int connected = 0;
pthread_t receive_thread;
char *players_pseudo[4];
int game_started = 0;
int current_turn = 0;

char map[256];

// Print informations
void show_banner() {
    printf("hello to grid game !\n");
}
void show_menu_help() {
    printf("Available commands are :\n");
    printf("- help : display this helper.\n");
    printf("- version : display the client version.\n");
    printf("- connect <hostname> <port> : connect to a game server.\n");
    printf("- quit : quit the game.\n");
}
void show_game_menu_help() {
    printf("Available commands are (don't forget to start with '$') :\n");
    printf("- $help : display this helper.\n");
    printf("- $version : display the client version.\n");
    printf("- $list_players : list connected players.\n");
    printf("- $quit : quit the game.\n");
}
void show_client_version() {
    printf("The client version is : 1.0\n");
}
void quit_game() {
    printf("Thank you for playing ! Good night netrunner ;)\n");
    close(client_socket);
    exit(0);
}

// utils
int input(char *buffer, int size) {
    printf("> ");
    bzero(buffer, size);
    int length = read(0, buffer, size-1);
    buffer[length] = 0;
    return length;
}

// Gameplay
void set_map_datas(char *map_datas) {
    memcpy(map, map_datas, 256);
}
void print_map() {
    printf("\n----------------------------------");
    for (int y = 0; y<16; y++) {
        printf("\n|");
        for (int x = 0; x<16; x++) {
            printf("%c ", map[y*16 + x]);
        }
        printf("|");
    }
    printf("\n----------------------------------\n");
}
void init_game() {
    set_map_datas("****************************************************************************************************************************************************************************************************************************************************************");
}
void draw_game() {
    if (game_started) {
        print_map();
        printf("Current turn is %d\n", current_turn);
    }
}

// Network
//      protocol : 
//          - encapsulation : 10 bytes header = "A_B_C_D":   
//                                                                      - A     = GRID
//                                                                      - B     = (int) type of message : command/broadcast message
//                                                                      - C     = (int) size of message
//                                                                      - D     = (string) message
//                                                                      - EOF   = (string) "_=&O#"
//
//      types of message : 
//                  - 1 = command
//                  - 2 = message
//                  - 3 = player is ready
//                  - 4 = go <direction> (Up down right left)
//                  - 5 = set pseudo (only the first message)
//                  - 6 = server error -> quitting
//                  - 7 = map datas (represented by a 256 chars string).
//                  - 8 = game started
//                  - 9 = turn number
//
int send_message(int type, char *message) {
    char packet[MAX_SIZE_MESSAGE+512];
    bzero(packet, MAX_SIZE_MESSAGE+512);
    int written = 5;
    strcpy(packet, "GRID_");
    written = sprintf(&packet[written], "%d_", type) + written;
    written = sprintf(&packet[written], "%d_", strlen(message)) + written;
    written = sprintf(&packet[written], "%s", message) + written;
    written = sprintf(&packet[written], "%s", "_=&O#") + written;
    // printf("Send to server : %s\n", packet);
    write(client_socket, packet, written);
    return written;
}

int recv_message(char *message, int *ltype, int *lmessage_size) {
    char buffer[MAX_SIZE_MESSAGE];
    char magic_bytes[10];
    int i = 0;
    int j = 0;
    int start_msg_offset = 0;
    memset(buffer, 0, MAX_SIZE_MESSAGE);
    memset(magic_bytes, 0, 10);

    while (1) {
        if (i >=5 && !strncmp(&buffer[i-5], "_=&O#", 5))
            break;
        if (read(client_socket, &buffer[i], 1) <= 0) {
            printf("\nConnection lost.\n");
            connected = 0;
        }
        if (buffer[i] == '_' && (++j) == 3)
            start_msg_offset = i+1;
        i++;
    }
    printf("i=%d \n", i);
    sscanf(buffer, "%4s_%d_%d_", magic_bytes, ltype, lmessage_size);
    return start_msg_offset;
}

// threads
void *receive_messages(void *arg) {
    char message[MAX_SIZE_MESSAGE];
    int ltype = 0;
    unsigned int lmessage_size = 0;
    int start_msg_offset = 0;

    while (connected) {
        memset(message, 0, MAX_SIZE_MESSAGE);

        start_msg_offset = recv_message(message, &ltype, &lmessage_size);

        if (ltype == 6) {
            printf("%s", &message[start_msg_offset]);
            quit_game();
        }
        else if(ltype == 2) {
            message[start_msg_offset+lmessage_size] = 0;
            printf("[!] %s", &message[start_msg_offset]);
        }
        else if(ltype == 3) { // player is ready
            init_game();
            message[start_msg_offset+lmessage_size] = 0;
            printf("[!] %s est prêt.", &message[start_msg_offset]);
        }
        else if(ltype == 7) { // receive map datas
            if (lmessage_size == 256)
                set_map_datas(&message[start_msg_offset]);
            draw_game();
        }
        else if(ltype == 8) { // game started
            // printf("STARTED GAME !\n");
            game_started = 1;
        }
        else if(ltype == 9) { // current_turn
            message[start_msg_offset+lmessage_size] = 0;
            sscanf(&message[start_msg_offset], "%d", &current_turn);
        }
    }
    
    return NULL;
}

int connect_to_server(const char *hostname, int port) {
    printf("Trying to connect to %s at port %d...\n", hostname, port);
    struct sockaddr_in server_addr;
    struct hostent *host_entry;
    client_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (client_socket < 0) {
        perror("Error : socket not created");
        return 0;
    }
    // Résoudre le nom d'hôte
    host_entry = gethostbyname(hostname);
    if (host_entry == NULL) {
        // Essayer de traiter comme une adresse IP
        if (inet_addr(hostname) == INADDR_NONE) {
            printf("Error : can't resolve '%s'\n", hostname);
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
    
    if (connect(client_socket, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        perror("Error : unable to connect\n");
        close(client_socket);
        return 0;
    }
    printf("Connected !\n");
    connected = 1;
    // Démarrer le thread de réception
    if (pthread_create(&receive_thread, NULL, receive_messages, NULL) != 0) {
        perror("Error : unable to create 'message reception socket'\n");
        connected = 0;
        close(client_socket);
        return 0;
    }
    return 1;
}

int main(int argc, char **argv) {
    setvbuf(stdout, NULL, _IONBF, 0);

    show_banner();
    show_menu_help();

    char buffer[MAX_SIZE_MESSAGE];
    char command[32], hostname[256];
    int port;
    bzero(command, 32); bzero(hostname, 256);

    // Game menu
    while (1) {
        input(buffer, MAX_SIZE_MESSAGE);

        // its a command
        if (!strncmp("help", buffer, 4)) {
            show_menu_help();
        }
        else if (!strncmp("version", buffer, 7)) {
            show_client_version();
        }
        else if (!strncmp("connect", buffer, 7)) {
            if (sscanf(buffer, "%s %s %d", command, hostname, &port) == 3 && port > 0 && port <= 65535 && connect_to_server(hostname, port)) {
                break;
            } 
            else {
                printf("Error : unable to connect to the server. Please verify your informations.\n");
            }
        }
        else if (!strncmp("quit", buffer, 4)) {
            quit_game();
        }
        else {
            printf("Invalid command\n");
        }
    }

    // Game playing
    printf("Enter your pseudo> ");
    int len = read(0, buffer, MAX_SIZE_PSEUDO);
    buffer[len-1] = 0;
    send_message(5, buffer);
    while (1) {
        input(buffer, MAX_SIZE_MESSAGE);
        printf("\n");
        // printf("your input : %s\n", buffer);
        if (buffer[0] == '$') {
            // its a command
            if (!strncmp("help", &buffer[1], 4)) {
                show_game_menu_help();
            }
            else if (!strncmp("version", &buffer[1], 7)) {
                show_client_version();
            }
            else if (!strncmp("quit", &buffer[1], 4)) {
                quit_game();
            }
            else {
                send_message(1, &buffer[1]);
            }
        }
        else {
            send_message(2, buffer);
        }
    }

}
