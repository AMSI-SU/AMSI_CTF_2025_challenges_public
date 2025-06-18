#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

#define MAX_DOOR 256
#define STR_LEN 512
#define DB_IP "127.0.0.1"
#define DB_PORT 6789

struct passwords {
    char admin[STR_LEN];
    char user[STR_LEN];
};

struct session {
    char username[STR_LEN];
    char password[STR_LEN];
    char admin_level;
};

struct door {
    char name[STR_LEN];
    char zone[STR_LEN];
    char is_closed;
};

struct state {
    struct passwords passwords;
    struct session session;
    char door_nb;
    struct door doors[MAX_DOOR];
};

int db_socket = -1;
struct state my_state;

int ask_input(char *out_buff, int length) {
	fgets(out_buff, length, stdin);
    int a = strlen(out_buff);
    out_buff[a-1] = 0;
	return a;
}

void show_session() {
    printf("Current session :\n");
    printf("username : %s\n", my_state.session.username);
    printf("password : %s\n", my_state.session.password);
    printf("admin level : %d\n", my_state.session.admin_level);
}

void read_passwords_from_file(const char *filename) {
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        perror("Error can't open file\n");
        return;
    }
    // admin password
    char buffer[STR_LEN];
    fgets(buffer, STR_LEN, file);
    buffer[strcspn(buffer, "\n")] = '\0';
    strncpy(my_state.passwords.admin, buffer, STR_LEN);
    bzero(buffer, STR_LEN);
    // user password
    fgets(buffer, STR_LEN, file);
    buffer[strcspn(buffer, "\n")] = '\0';
    strncpy(my_state.passwords.user, buffer, STR_LEN);
    fclose(file);
    printf("Passwords has been retrieved.\n");
}
int check_access() {
    if (strcmp(my_state.session.username, "admin") == 0 && strcmp(my_state.session.password, my_state.passwords.admin) == 0) {
        printf("Admin user authenticated - Access level 0\n");
        my_state.session.admin_level = 0;
    } else if (strcmp(my_state.session.username, "user") == 0 && strcmp(my_state.session.password, my_state.passwords.user) == 0) {
        printf("Regular user authenticated - Access level 1\n");
        my_state.session.admin_level = 1;
    } else {
        printf("Anonymous user authenticated - Access level 2\n");
        my_state.session.admin_level = 2;
    }
    return my_state.session.admin_level;
}
int authenticate() {
    // read admin and user passwords from file.
    read_passwords_from_file("passwords.txt");
    printf("Please authenticate yourself :\n");
    printf("username> ");
    ask_input(my_state.session.username, STR_LEN);
    printf("password> ");
    ask_input(my_state.session.password, STR_LEN);
    return check_access();
}

int db_connect() {
    printf("Connecting to database %s:%d...", DB_IP, DB_PORT);
    struct sockaddr_in serv_addr;
    db_socket = socket(AF_INET, SOCK_STREAM, 0);
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(DB_PORT);
    inet_pton(AF_INET, DB_IP, &serv_addr.sin_addr);
    int r = connect(db_socket, (struct sockaddr*)&serv_addr, sizeof(serv_addr));
    if (r == 0) 
        printf("[OK]\n");
    if (r != 0) 
        printf("[NOK] !\n");
    return r;
}

// Inspect door
int inspect_door() {
    printf("Inspect a door :\n");
    char buff[STR_LEN];
    bzero(buff, STR_LEN);
    printf("which one> ");
    ask_input(buff, STR_LEN);
    int door_id = atoi(buff);
    if (door_id >= MAX_DOOR || door_id >= my_state.door_nb) {
        printf("This door doesn't exist.\n");
        return -1;
    }
    printf("Inspecting door #%d\n", door_id);
    printf("name : %s\n",   my_state.doors[door_id].name);
    printf("zone : %s\n",   my_state.doors[door_id].zone);
    printf("closed : %d\n", my_state.doors[door_id].is_closed);
    return door_id;
}
int db_request_get_door(int door_id) {
    if(db_connect() != 0)
        return -1;
    char buff[STR_LEN];
    bzero(buff, STR_LEN);
    sprintf(buff, "get door %d ", door_id);
    send(db_socket, buff, strlen(buff), 0);
    int r = recv(db_socket, &my_state.doors[door_id], sizeof(struct door), 0);
    close(db_socket);
    return r;
}
int sync_door_from_db() {
    for (int i = 0; i<MAX_DOOR; i++) {
        db_request_get_door(i);
        if (strncmp(my_state.doors[i].name, "unknown", 7)) {
            my_state.door_nb = i+1;
        }
    }
}

// Door modification
int modify_door() {
    printf("Modify a door :\n");
    char buff[STR_LEN];
    bzero(buff, STR_LEN);
    printf("which one> ");
    ask_input(buff, STR_LEN);
    int door_id = atoi(buff);
    if (door_id >= MAX_DOOR || door_id >= my_state.door_nb) {
        printf("This door doesn't exist.\n");
        return -1;
    }
    printf("name> ");
    bzero(buff, STR_LEN);
    ask_input(buff, STR_LEN);
    bzero(my_state.doors[door_id].name, STR_LEN);
    strcpy(my_state.doors[door_id].name, buff);

    printf("zone> ");
    bzero(buff, STR_LEN);
    ask_input(buff, STR_LEN);
    bzero(my_state.doors[door_id].zone, STR_LEN);
    strcpy(my_state.doors[door_id].zone, buff);

    while (1) {
        printf("is closed ? [y/n] ");
        ask_input(buff, STR_LEN);
        if (buff[0] == 'y') {
            my_state.doors[door_id].is_closed = 1;
            break;
        }
        else if (buff[0] == 'n') {
            my_state.doors[door_id].is_closed = 0;
            break;
        }
        printf("\n");
    }
    return door_id;
}
int db_request_mod_door() {
    int door_id = modify_door();
    if(db_connect() != 0)
        return -1;
    int r = -1;
    printf("Trying to apply modification of door #%d to database\n", door_id);
    printf("%s in %s\n", my_state.doors[door_id].name, my_state.doors[door_id].zone);
    if (check_access() < 2) {
        char buff[STR_LEN+sizeof(struct door)];
        bzero(buff, STR_LEN+sizeof(struct door));
        int n = sprintf(buff, "set door %d ", door_id);
        memcpy(&buff[n], &my_state.doors[door_id], sizeof(struct door));
        send(db_socket, buff, STR_LEN+sizeof(struct door), 0);
        bzero(buff, STR_LEN+sizeof(struct door));
        r = recv(db_socket, buff, 7, 0); // rcv "success" or "failure"
        printf("modification is %s", buff);
    }
    else {
        printf("You don't have rights to apply modification to database\n");
    }
    close(db_socket);
    return r;
}

// Add new door
int db_request_add_door(struct door *new_door) {
    int r = 0;
    if(db_connect() != 0)
        return -1;
    if (check_access() == 0) {
        char buff[STR_LEN+sizeof(struct door)];
        bzero(buff, STR_LEN+sizeof(struct door));
        memcpy(buff, "add door ", 9);
        memcpy(&buff[9], new_door, STR_LEN+sizeof(struct door)-9);
        send(db_socket, buff, STR_LEN+sizeof(struct door), 0);
        printf("Door has been added !\n");
        close(db_socket);
    }
    return r;
}
int add_door() {
    if (check_access() == 0) {
        printf("You have sufficient privilege to add a new door.\n");
        struct door new_door;
        char buff[STR_LEN+sizeof(struct door)];
        bzero(buff, STR_LEN+sizeof(struct door));
        printf("name> ");
        ask_input(buff, STR_LEN);
        printf("zone> ");
        ask_input(&buff[STR_LEN], STR_LEN);
        // printf("%s", &buff[STR_LEN]);
        memcpy(&new_door, buff, sizeof(struct door));
        while (1) {
            printf("is closed ? [y/n] ");
            bzero(buff, STR_LEN+sizeof(struct door));
            ask_input(buff, STR_LEN+sizeof(struct door));
            if (buff[0] == 'y') {
                new_door.is_closed = 1;
                break;
            }
            else if (buff[0] == 'n') {
                new_door.is_closed = 0;
                break;
            }
            printf("\n");
        }
        // send the new door to db
        return db_request_add_door(&new_door);
    }
    printf("You don't have privilege enough to add a new door. Exiting.\n");
    return -1;
}

void print_help() {
    printf("Commands : \n");
    printf("\t - help : show help.\n");
    printf("\t - session : show current session.\n");
    printf("\t - sync : synchronize datas from database.\n");
    printf("\t - inspect : inspect a door.\n");
    printf("\t - modif : modify a door.\n");
    printf("\t - add : add a new door.\n");
    printf("\t - auth : authenticate with username and password.\n");
}


int main(int argc, char **argv) {
    setvbuf(stdout, NULL, _IONBF, 0);

    printf("Welcome to GRID Security Panel.\n");
    authenticate();
    
    // command loop
    char buff[STR_LEN];
    while (1) {
        bzero(buff, STR_LEN);
        printf("$> ");
        ask_input(buff, STR_LEN);
        if (!strncmp(buff, "help", 4))
            print_help();
        if (!strncmp(buff, "session", 7))
            show_session();
        if (!strncmp(buff, "inspect", 7))
            inspect_door();  
        if (!strncmp(buff, "modif", 5))
            db_request_mod_door();  
        if (!strncmp(buff, "add", 3))
            add_door();  
        if (!strncmp(buff, "auth", 4))
            authenticate();  
        if (!strncmp(buff, "sync", 4))
            sync_door_from_db();  
    }
}


