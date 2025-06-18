#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

char secure_flag[1024];

int process_command(char *command) {
	if (!strcmp(command, "quit"))
		return 0;
	if (!strcmp(command, "access security"))
		return 1;
	if (!strcmp(command, "access security grid"))
		return 2;
	if (!strcmp(command, "access main security grid"))
		return 3;
	if (!strncmp(command, "access main security grid password:", 35))
		return 4;
	if (!strcmp(command, "list files"))
		return 5;
	if (!strcmp(command, "print flag"))
		return 6;
	if (!strcmp(command, "help"))
		return 7;
	return -1;
}

int ask_input(char *prefix, char *out_buff) {
	printf(prefix);
	fflush(stdout);
	fgets(out_buff, 512, stdin);
	int length = strlen(out_buff);
	out_buff[length-1] = 0;
	return length;
}

int list_files() {
	return system("ls -al ./files/");
}

int print_flag(){
	printf("This functionality is not implemented yet\n");
}

int print_flag_secure() {
	char flag[1024];
	int fd = open(secure_flag, O_RDONLY);
	int size = read(fd, flag, 1024);
	printf("%s", flag);
	close(fd);
	return size;
}

int print_help() {
	printf("Available commands are : \n");
	printf("- help\n");
	printf("- quit\n");
	printf("- access security\n");
	printf("- access security grid\n");
	printf("- access main security grid\n");
	printf("- list files\n");
	printf("- print flag\n");
	return 0;
}

int access_security() {
        printf("access: PERMISSION DENIED.\n");
}

int access_main_security() {
	printf("access: PERMISSION DENIED.");
	fflush(stdout);
	sleep(1);
	printf("...and....");
	fflush(stdout);
	sleep(1);
	printf("\n");
	while (1) {
		printf("YOU DIDN'T SAY THE MAGIC WORD!\n");
		printf("YOU DIDN'T SAY THE MAGIC WORD!\n");
		printf("YOU DIDN'T SAY THE MAGIC WORD!\n");
		usleep(600*1000);
		fflush(stdout);
	}
}

int access_main_security_grid_pass(char *password) {
	if (!strcmp(password, "M4g1K_W0rD")) {
		print_flag_secure();
	}
	return 0;
}

int main(int argc, char **argv, char **envp) {

	memcpy(secure_flag, "./files/secure_flag.txt", 24);
	secure_flag[23] = 0;

	printf("Grid Park, System Security Interface\n");
	printf("Version 4.0.5, Alpha E\n");
	printf("Ready...\n");
	fflush(stdout);

	int running = 1;
	char prefix[256];
	bzero(prefix, 256);
	char user_input[256];
	bzero(user_input, 256);

	memcpy(prefix, "> ", 2);
	prefix[2] = 0;
	while (running) {
		ask_input(prefix, user_input);
		// printf("You write : %s\n", user_input);
		int p = process_command(user_input);
		if (!p)
			running = 0;
		if (p == 1 || p == 2)
			access_security();
		if (p == 3)
			access_main_security();
		if (p == 4) {
			char *password = user_input+35;
			access_main_security_grid_pass(password);
		}
		if (p == 5)
			list_files();
		if (p == 6)
			print_flag();
		if (p == 7)
			print_help();

	}
	return running;
}

