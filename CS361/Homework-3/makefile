all: hw3.o

hw3.o: hw3.c
	gcc -Wall -Wextra -Wno-unused-parameter -Wno-unused-variable -Wno-unused-but-set-variable -Wno-pointer-arith -Werror -std=c17 -Wpedantic -O0 -g hw3.c -c -o hw3.o

clean:
	rm -rf *.o d
	make -C tests/01-brk-dist clean
	make -C tests/02-block-size clean
	make -C tests/03-is-free clean
	make -C tests/04-next-used clean
	make -C tests/05-next-free clean
	make -C tests/06-free-everything clean
	make -C tests/07-free-everything-stats clean
	make -C tests/08-free-everything-size clean
