
.PHONY: all

CFLAGS=-fno-pie -no-pie -fno-stack-protector -m32 -static
# CFLAGS=-fno-pie -no-pie -m32 -fstack-protector

.main: main.c
	gcc $(CFLAGS) main.c -o main

.database:database.c
	gcc $(CFLAGS) database.c -o database 

all: .main .database
