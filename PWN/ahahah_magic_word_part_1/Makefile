
.PHONY: all

.clean:
	-rm main
	-rm ./public/GRID_security_panel_cli

.main:
	gcc spoil/main.c -o main -fno-PIE -no-pie -m32 -static

all: .clean .main
	cp ./main ./public/GRID_security_panel_cli
	cp ./main ./chall/GRID_security_panel_cli


