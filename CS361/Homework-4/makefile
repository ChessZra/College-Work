OPTS=-fsanitize=address -Wall -Wextra -Wno-unused-parameter -Wno-unused-variable -Wno-unused-but-set-variable -Werror -std=c17 -Wpedantic -O0 -g


all: hw4

hw4: hw4.o lib.o
	gcc $^ -o $@ $(OPTS)

hw4.o: hw4.c hw4.h lib.h
	gcc $< -c -o $@ $(OPTS)

lib.o: lib.c lib.h
	gcc $< -c -o $@ $(OPTS)

gdb-child: all
	/usr/bin/gdb -q -ex "set follow-fork-mode child" hw4


clean:
	rm -f *.o hw4
