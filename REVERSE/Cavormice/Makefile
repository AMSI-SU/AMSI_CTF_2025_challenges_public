
.PHONY: all

.clean:
	-rm *.gb

.clean_obj:
	-rm *.asm
	-rm *.lst
	-rm *.ihx
	-rm *.sym
	-rm *.o

.main: 
	./gbdk/bin/lcc -c -o datas.o datas.c
	./gbdk/bin/lcc -c -o LaroldsJubilantJunkyard.o LaroldsJubilantJunkyard.c

	./gbdk/bin/lcc -c -o main.o main.c
	./gbdk/bin/lcc -o main.gb main.o

all: .clean .clean_obj .main
	cp ./main.gb ./public/Cavormice.gb
