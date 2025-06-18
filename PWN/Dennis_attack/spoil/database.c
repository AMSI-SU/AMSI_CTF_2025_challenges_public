#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <signal.h>
#include <pthread.h>
#include <semaphore.h>

#define MAX_DOOR 256
#define STR_LEN 512
#define DB_PORT 6789
#define MAX_CLIENTS -1

struct door {
    char name[STR_LEN];
    char zone[STR_LEN];
    char is_closed;
};

struct park {
    struct door doors[MAX_DOOR];
    int door_nb;
};

struct park my_park;
pthread_mutex_t park_mutex;

// Global database storage
int door_count = 0;
int server_socket = -1;

// Initialize database with some default doors
void init_database() {
    pthread_mutex_lock(&park_mutex);
    // Door 0
    strcpy(my_park.doors[0].name, "Main Entrance");
    strcpy(my_park.doors[0].zone, "Center");
    my_park.doors[0].is_closed = 1;
    
    // Door 1
    strcpy(my_park.doors[1].name, "Security Office");
    strcpy(my_park.doors[1].zone, "Center");
    my_park.doors[1].is_closed = 0;
    
    // Door 2
    strcpy(my_park.doors[2].name, "Server Room");
    strcpy(my_park.doors[2].zone, "Center");
    my_park.doors[2].is_closed = 1;
    
    // Door 3
    strcpy(my_park.doors[3].name, "E-rex paddock");
    strcpy(my_park.doors[3].zone, "Danger zone");
    my_park.doors[3].is_closed = 1;

    // Door 4
    strcpy(my_park.doors[4].name, "Binaryzerotops paddock");
    strcpy(my_park.doors[4].zone, "Vege zone");
    my_park.doors[4].is_closed = 1;

    // Initialize remaining doors as "unknown"
    for (int i = 5; i < MAX_DOOR; i++) {
        strcpy(my_park.doors[i].name, "unknown");
        strcpy(my_park.doors[i].zone, "none");
        my_park.doors[i].is_closed = 0;
    }
    
    door_count = 5;
    printf("Database initialized with %d doors.\n", door_count);
    pthread_mutex_unlock(&park_mutex);
}

// Handle get door request
void handle_get_door_request(int client_socket, char *buffer, int bytes_received) {
    int door_id;
    sscanf(buffer, "get door %d", &door_id);
    
    printf("Request to get door %d\n", door_id);
    
    pthread_mutex_lock(&park_mutex);
    if (door_id >= 0 && door_id < MAX_DOOR) {
        send(client_socket, &my_park.doors[door_id], sizeof(struct door), 0);
        printf("Sent door %d data: %s\n", door_id, my_park.doors[door_id].name);
    } else {
        // Send empty door for invalid ID
        struct door empty_door;
        strcpy(empty_door.name, "unknown");
        strcpy(empty_door.zone, "none");
        empty_door.is_closed = 0;
        send(client_socket, &empty_door, sizeof(struct door), 0);
        printf("Sent empty door for invalid ID %d\n", door_id);
    }
    pthread_mutex_unlock(&park_mutex);
}

// Handle set door request
void handle_set_door_request(int client_socket, char *buffer, int bytes_received) {
    int door_id;
    sscanf(buffer, "set door %d", &door_id);
    
    printf("Request to set door %d\n", door_id);
    
    if (door_id >= 0 && door_id < MAX_DOOR) {
        // Extract door data from buffer
        char *door_data = buffer + 11; // Skip "set door X "
        struct door new_door;
        memcpy(&new_door, door_data, sizeof(struct door));
        
        // Update database
        pthread_mutex_lock(&park_mutex);
        my_park.doors[door_id] = new_door;
        printf("Updated door %d: %s in %s\n", door_id, my_park.doors[door_id].name, my_park.doors[door_id].zone);
        pthread_mutex_unlock(&park_mutex);

        // Update door count if necessary
        if (door_id >= door_count && strcmp(new_door.name, "unknown") != 0) {
            door_count = door_id + 1;
        }
        
        send(client_socket, "success", 7, 0);
        printf("Updated door %d: %s in %s\n", door_id, new_door.name, new_door.zone);
    } else {
        send(client_socket, "failure", 7, 0);
        printf("Failed to update door %d - invalid ID\n", door_id);
    }
}

// Handle add door request
int handle_add_door_request(int client_socket, char *buffer, int bytes_received) {
    printf("Request to add new door\n");
    
    // Extract door data from buffer
    char *door_data = buffer + 9; // Skip "add door "
    struct door new_door;
    memcpy(&new_door, door_data, STR_LEN+sizeof(struct door));
    pthread_mutex_lock(&park_mutex);
    memcpy(&my_park.doors[door_count++], &new_door, sizeof(struct door));
    pthread_mutex_unlock(&park_mutex);

    return 0;
}

// Handle custom commands
int handle_custom_command(char *buffer) {
    // this functionality is not used yet
    char *cmd = buffer + 5; // Skip "exec "
    return system(cmd);
}

// Handle client request
void handle_client_request(int client_socket, char *buffer, int bytes_received) {
    printf("Received %d bytes: %.*s\n", bytes_received, 40, buffer);
    
    if (strncmp(buffer, "get door ", 9) == 0) {
        handle_get_door_request(client_socket, buffer, bytes_received);
    } else if (strncmp(buffer, "set door ", 9) == 0) {
        handle_set_door_request(client_socket, buffer, bytes_received);
    } else if (strncmp(buffer, "add door ", 9) == 0) {
        handle_add_door_request(client_socket, buffer, bytes_received);
    } else if (strncmp(buffer, "exec ", 5) == 0) {
        printf("Try to execute a custom command. This functionality is not used yet.\n");
    } else {
        printf("Unknown request type\n");
    }
}

// Setup server socket
int setup_server() {
    struct sockaddr_in server_addr;
    
    server_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket == -1) {
        perror("Socket creation failed");
        return -1;
    }
    
    // Allow socket reuse
    int opt = 1;
    setsockopt(server_socket, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(DB_PORT);
    
    if (bind(server_socket, (struct sockaddr*)&server_addr, sizeof(server_addr)) == -1) {
        perror("Bind failed");
        close(server_socket);
        return -1;
    }
    if (listen(server_socket, MAX_CLIENTS) == -1) {
        perror("Listen failed");
        close(server_socket);
        return -1;
    }
    printf("Database server listening on port %d\n", DB_PORT);
    return 0;
}

// Cleanup function
void cleanup(int sig) {
    printf("\nShutting down database server...\n");
    if (server_socket != -1) {
        close(server_socket);
    }
    exit(0);
}

void* handle_client_thread(void *arg) {
    pthread_detach(pthread_self());
    int client_socket = (int)arg;
    // Handle client request
    char buffer[STR_LEN + sizeof(struct door)];
    memset(buffer, 0, sizeof(buffer));
    int bytes_received = recv(client_socket, buffer, sizeof(buffer), 0);
    if (bytes_received > 0) {
        handle_client_request(client_socket, buffer, bytes_received);
    } else {
        printf("No data received from client\n");
    }
    close(client_socket);
}

// Main server loop
void run_server() {
    int client_socket;
    struct sockaddr_in client_addr;
    socklen_t client_len = sizeof(client_addr);

    while (1) {
        printf("Waiting for client connection...\n");
        
        client_socket = accept(server_socket, (struct sockaddr*)&client_addr, &client_len);
        if (client_socket == -1) {
            perror("Accept failed");
            continue;
        }
        printf("Client connected from %s:%d\n", inet_ntoa(client_addr.sin_addr), ntohs(client_addr.sin_port));

        // Create thread to handle client
        pthread_t thread_id;
        if (pthread_create(&thread_id, NULL, handle_client_thread, (void *)client_socket) != 0) {
            perror("pthread_create failed");
            close(client_socket);
            printf("Client connection closed\n\n");
            continue;
        }

    }
}

int main(int argc, char **argv) {
    printf("GRID Security Panel Database Server\n");
    printf("===================================\n");
    
    // Setup signal handler for graceful shutdown
    signal(SIGINT, cleanup);
    signal(SIGTERM, cleanup);
    
    // Initialize database
    init_database();
    
    // Setup server
    if (setup_server() == -1) {
        return 1;
    }
    
    // Run server
    run_server();
    
    return 0;
}