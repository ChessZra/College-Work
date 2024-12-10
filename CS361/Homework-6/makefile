CFLAGS=-lpthread -lncurses -g -O0
FILES=hw6

all: hw6

hw6: main.c hw6.c
	gcc $^ -o $@ $(CFLAGS)

clean:
	rm -f $(FILES) *.o
