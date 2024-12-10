OPTS=-fno-pie -no-pie -fno-builtin -Wall -Wextra -Wno-unused-parameter -Wno-unused-variable -Wno-unused-but-set-variable -Werror -std=c17 -Wpedantic -O0 -g


all: hw5

hw5: hw5.o
	gcc $^ -o $@ $(OPTS)

hw5.o: hw5.c
	gcc $< -c -o $@ $(OPTS)

clean:
	rm -f *.o hw5
