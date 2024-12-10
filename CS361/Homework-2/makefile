OPTS=-fno-pie -no-pie -fno-builtin -fno-stack-protector -Wall -Wextra -Wno-unused-parameter -Wno-unused-variable -Wno-unused-but-set-variable -Werror -std=c17 -Wpedantic -O0


all: hw2

hw2: hw2.o lib.o
	gcc hw2.o lib.o $(OPTS) -o hw2

hw2.o: hw2.c
	gcc hw2.c $(OPTS) -c -o hw2.o

clean:
	rm -f hw2.o hw2
