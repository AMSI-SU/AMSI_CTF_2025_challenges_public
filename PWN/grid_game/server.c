#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <pthread.h>
#include <signal.h>
#include <time.h>

#define MAX_CLIENTS 4
#define BOARD_SIZE 16
#define BUFFER_SIZE 1024
#define MAX_SIZE_MESSAGE 1024
#define MAX_SIZE_PSEUDO 64

typedef struct {
    int x, y;
} Position;

char map[256];

typedef struct {
    int id;
    char symbol;
    char pseudo[MAX_SIZE_PSEUDO];
    int socket;
    int cell_count;
    int is_active;
    int is_ready;
    int turn_is_done;
    pthread_t thread;
    int pos_x;
    int pos_y;
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
    
    // Initialiser les symboles des joueurs
    char symbols[] = {'@', '&', 'X', '#'};
    for (int i = 0; i < MAX_CLIENTS; i++) {
        game_state.players[i].symbol = symbols[i];
        game_state.players[i].id = i;
        game_state.players[i].is_active = 0;
        game_state.players[i].cell_count = 0;
    }
}

void send_to_player(int socket, const char *message) {
    send(socket, message, strlen(message), 0);
}

int is_adjacent(int player_id, int x, int y) {
    return 0;
}

void buy_cell(int player_id, int x, int y) {
    
    // update and send the map
    for (int i = 0; i < game_state.player_count; i++) {
        if (game_state.players[i].is_active) {
            send_message(game_state.players[i].socket, 7, map, -1);
        }
    }
}

void start_game() {
    game_state.game_started = 1;
    game_state.current_turn = 0;
    
    // reset map
    memcpy(map, "****************************************************************************************************************************************************************************************************************************************************************", 256);

    // Random pos for player 1
    game_state.players[0].pos_x = 0; game_state.players[0].pos_y = 1;
    map[game_state.players[0].pos_y*16 + game_state.players[0].pos_x] = game_state.players[0].symbol;

    game_state.players[1].pos_x = 12; game_state.players[1].pos_y = 5;
    map[game_state.players[1].pos_y*16 + game_state.players[1].pos_x] = game_state.players[1].symbol;

    game_state.players[2].pos_x = 4; game_state.players[2].pos_y = 11;
    map[game_state.players[2].pos_y*16 + game_state.players[2].pos_x] = game_state.players[2].symbol;

    game_state.players[3].pos_x = 13; game_state.players[3].pos_y = 14;
    map[game_state.players[3].pos_y*16 + game_state.players[3].pos_x] = game_state.players[3].symbol;
    
    // send map
    for (int i = 0; i < game_state.player_count; i++) {
        if (game_state.players[i].is_active) {
            send_message(game_state.players[i].socket, 7, map, -1);
        }
    }
    // send go !
    broadcast_message(8, "Go !\n", -1, -1);
}

int get_number_of_active_players() {
    int j = 0;
    for (int i = 0; i < game_state.player_count; i++) {
        if (game_state.players[i].is_active) {
            j++;
        }
    }
    return j;
}

int are_all_players_ready() {
    int j = 1;
    for (int i = 0; i < MAX_CLIENTS; i++) {
        if (!game_state.players[i].is_active || !game_state.players[i].is_ready) {
            j = 0;
        }
    }
    return j;
}
int are_all_players_turn_done() {
    int j = 1;
    for (int i = 0; i < MAX_CLIENTS; i++) {
        if (!game_state.players[i].turn_is_done) {
            j = 0;
        }
    }
    return j;
}

void list_players(int requester_socket) {
    char player_list[512] = "";
    
    pthread_mutex_lock(&game_state.game_mutex);
    for (int i = 0; i < game_state.player_count; i++) {
        if (game_state.players[i].is_active) {
            char player_info[64];
            sprintf(player_info, "%c - Joueur %d (%d cases)\n", 
                    game_state.players[i].symbol, i + 1, game_state.players[i].cell_count);
            strcat(player_list, player_info);
        }
    }
    pthread_mutex_unlock(&game_state.game_mutex);
    send_message(requester_socket, 2, player_list, -1);
}

void send_help(int socket) {
    char help_msg[] = "=== AIDE ===\n"
                     "$play - Lance la partie\n"
                     "$go <x> <y> - Acheter une case\n"
                     "$list_players - Liste les joueurs\n"
                     "$music_on - Active la musique\n"
                     "$music_off - Éteint la musique\n"
                     "$quit - Quitte le jeu\n"
                     "$help - Affiche cette aide\n"
                     "Sans $ : Envoie un message\n"
                     "============\n";
    send_message(socket, 2, help_msg, -1);
}

int send_message(int client_socket, int type, char *message, int message_size) {
    char packet[MAX_SIZE_MESSAGE+512];
    bzero(packet, MAX_SIZE_MESSAGE+512);
    int written = 5;
    if (message_size <= 0) {
        message_size = strlen(message);
    }
    
    strcpy(packet, "GRID_");
    written = sprintf(&packet[written], "%d_", type) + written;
    written = sprintf(&packet[written], "%d_", message_size) + written;
    written = sprintf(&packet[written], "%s", message) + written;
    written = sprintf(&packet[written], "%s", "_=&O#") + written;
    printf("Send (%d) to %d : %s\n", written, client_socket, packet);
    write(client_socket, packet, written);
    return written;
}
void broadcast_message(int type, char *message, int exclude_socket, int message_size) {
    pthread_mutex_lock(&game_state.game_mutex);
    for (int i = 0; i < game_state.player_count; i++) {
        if (game_state.players[i].is_active && game_state.players[i].socket != exclude_socket) {
            send_message(game_state.players[i].socket, type, message, message_size);
        }
    }
    pthread_mutex_unlock(&game_state.game_mutex);
}

int recv_message(int client_socket, int *message_size, int *type, char *message) {
    char packet[MAX_SIZE_MESSAGE+512];
    char packet2[MAX_SIZE_MESSAGE+512];
    bzero(packet, MAX_SIZE_MESSAGE+512);
    bzero(packet2, MAX_SIZE_MESSAGE+512);
    int i = 0;
    int j = 0;
    int start_msg_offset = 0;
    while (i < MAX_SIZE_MESSAGE+512) {
        if (i >=5 && !strncmp(&packet[i-5], "_=&O#", 5)) {
            packet[i-5] = 0;
            break;
        }
        if (read(client_socket, &packet[i], 1) <= 0)
            return -2;
        // printf("read : %c", packet[i]);
        if (packet[i] == '_' && (++j) == 3)
            start_msg_offset = i+1;
        i++;
    }
    printf("packet recv is : %s", packet);
    int ltype = 0;
    unsigned int lmessage_size = 0;
    if (sscanf(packet, "%4s_%d_%d_", packet2, &ltype, &lmessage_size) == 0) {
        printf("Error message receive is incorrect\n");
        return -1;
    }
    // printf("packet recv is 2");
    if (strncmp("GRID", packet2, 4)) {
        printf("Error message receive is incorrect\n");
        return -1;
    }
    printf("packet type is : %d", ltype);
    // printf("packet recv is 3");
    if (ltype >= 10) {
        printf("Error message receive is incorrect\n");
        return -1;
    }
    // printf("packet recv is 4");
    printf("message size is : %d", lmessage_size);
    if (lmessage_size >= MAX_SIZE_MESSAGE+512) {
        printf("Error message receive is incorrect\n");
        return -1;
    }
    memcpy(message, &packet[start_msg_offset], lmessage_size);
    // printf("Msg recv : %d %d %s    %d \n", ltype, lmessage_size, &packet[start_msg_offset], start_msg_offset);
    *message_size = lmessage_size;
    *type = ltype;
    return lmessage_size;
}

void handle_command(int player_id, char *command) {
    int client_socket = game_state.players[player_id].socket;
    
    if (strncmp(command, "play", 4) == 0) { // player is ready
        broadcast_message(3, game_state.players[player_id].pseudo, client_socket, -1);
        pthread_mutex_lock(&game_state.game_mutex);
        game_state.players[player_id].is_ready = 1;
        pthread_mutex_unlock(&game_state.game_mutex);
    }
    else if (strncmp(command, "go", 2) == 0) {
        pthread_mutex_lock(&game_state.game_mutex);
        if (!game_state.players[player_id].turn_is_done) {
            char dir = '0';
            int args = sscanf(&command[2], " %c", &dir);
            // printf("player %d go %c pos_y=%d pos_x=%d\n", player_id, dir, game_state.players[player_id].pos_y, game_state.players[player_id].pos_x);
            if (dir == 'u' || dir == 'U' && (game_state.players[player_id].pos_y > 0 && map[(game_state.players[player_id].pos_y-1)*16 + game_state.players[player_id].pos_x] == '*')) { // go up
                // printf("player %s go up\n");
                game_state.players[player_id].pos_y--;
                map[game_state.players[player_id].pos_y*16 + game_state.players[player_id].pos_x] = game_state.players[player_id].symbol;
                game_state.players[player_id].turn_is_done = 1;
            }
            else if (dir == 'd' || dir == 'D' && (game_state.players[player_id].pos_y < 15 && map[(game_state.players[player_id].pos_y+1)*16 + game_state.players[player_id].pos_x] == '*')) {
                game_state.players[player_id].pos_y++;
                map[game_state.players[player_id].pos_y*16 + game_state.players[player_id].pos_x] = game_state.players[player_id].symbol;
                game_state.players[player_id].turn_is_done = 1;
            } 
            else if (dir == 'l' || dir == 'L' && (game_state.players[player_id].pos_x > 0 && map[(game_state.players[player_id].pos_y)*16 + game_state.players[player_id].pos_x-1] == '*')) {
                game_state.players[player_id].pos_x--;
                map[game_state.players[player_id].pos_y*16 + game_state.players[player_id].pos_x] = game_state.players[player_id].symbol;
                game_state.players[player_id].turn_is_done = 1;
            } 
            else if (dir == 'r' || dir == 'R' && (game_state.players[player_id].pos_x < 15 && map[(game_state.players[player_id].pos_y)*16 + game_state.players[player_id].pos_x+1] == '*')) {
                game_state.players[player_id].pos_x++;
                map[game_state.players[player_id].pos_y*16 + game_state.players[player_id].pos_x] = game_state.players[player_id].symbol;
                game_state.players[player_id].turn_is_done = 1;
            }
            else {
                send_message(client_socket, 2, "You can't go here !", -1);
            }
        }
        pthread_mutex_unlock(&game_state.game_mutex);
        if (are_all_players_turn_done()) { // Turn is done
            game_state.current_turn++;
            char turn_number[MAX_SIZE_MESSAGE]; bzero(turn_number, MAX_SIZE_MESSAGE); sprintf(turn_number, "%d", game_state.current_turn);
            printf("Turn number is %s", turn_number);
            broadcast_message(9, turn_number, -1, -1);
            broadcast_message(7, map, -1, -1);
            pthread_mutex_lock(&game_state.game_mutex);
            for (int i = 0; i < MAX_CLIENTS; i++) { game_state.players[i].turn_is_done = 0; }
            pthread_mutex_unlock(&game_state.game_mutex);
        }
    }
    else if (strncmp(command, "list_players", 12) == 0) {
        char player_list[MAX_SIZE_MESSAGE] = "=== Connected players ===\n";
        pthread_mutex_lock(&game_state.game_mutex);
        for (int i = 0; i < game_state.player_count; i++) {
            if (game_state.players[i].is_active) {
                char player_info[64];
                sprintf(player_info, "- %s (%c)\n", game_state.players[i].pseudo, game_state.players[i].symbol);
                strcat(player_list, player_info);
            }
        }
        strcat(player_list, "========================\n");
        pthread_mutex_unlock(&game_state.game_mutex);
        send_message(client_socket, 2, player_list, -1);
    }
}

void cleanup_and_exit() {
    printf("Stopping server...\n");
    close(server_socket);
    exit(0);
}

void *handle_client(void *arg) {
    int player_id = *(int*)arg;
    int client_socket = game_state.players[player_id].socket;
    char message[MAX_SIZE_MESSAGE+512];
    int message_type;
    int message_size;
    int running = 1;
    
    // Receive pseudo
    int r = recv_message(client_socket, &message_size, &message_type, message);
    if (r <= -1 || message_type != 5 || message_size > 64)
        running = 0;
    memcpy(game_state.players[player_id].pseudo, message, message_size);

    if (running) {
        char join_msg[MAX_SIZE_MESSAGE];
        sprintf(join_msg, "Le joueur %s (%c) s'est connecté !\n", game_state.players[player_id].pseudo, game_state.players[player_id].symbol);
        printf("%s", join_msg);
        broadcast_message(2, join_msg, client_socket, -1);
    }
    
    while (running) {
        bzero(message, MAX_SIZE_MESSAGE+512);
        // Get message from client
        r = recv_message(client_socket, &message_size, &message_type, message);
        if (r == -1)
            continue;
        if (r == -2)
            break;

        printf("Message received from %c : %s\n", game_state.players[player_id].symbol, message);

        // Manage message
        // command
        if (message_type == 1) {
            handle_command(player_id, message);
        }
        // message to other player
        else if (message_type == 2) {
            broadcast_message(2, message, client_socket, message_size);
        }

        // start game ?
        int pready = are_all_players_ready();
        if (pready && !game_state.game_started) { start_game(); }
        
        if (!pready && game_state.game_started) { 
            printf("Error : a player is down ! Quitting the game...\n");
            broadcast_message(6, "Error : a player is down ! Quitting the game...\n", -1, -1);
            cleanup_and_exit();
        }

    }
    
    printf("déconnexion...\n");
    // Nettoyage à la déconnexion
    game_state.players[player_id].is_active = 0;
    char leave_msg[MAX_SIZE_MESSAGE+512];
    sprintf(leave_msg, "Player %s left the game ;(\n", game_state.players[player_id].pseudo);
    broadcast_message(2, leave_msg, -1, -1);
    close(client_socket);
    // printf("number of active player : %d\n", get_number_of_active_players());
    return NULL;
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
        
        printf("Nouveau joueur connecté (%c) - Total: %d/%d\n", game_state.players[player_id].symbol, game_state.player_count, MAX_CLIENTS);
    }
    
    return 0;
}