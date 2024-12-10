CFLAGS = -Wno-unused-result -std=c17 -g -O0
SRCS=$(wildcard *.c)

OBJS=$(SRCS:.c=.o)

all: hw3.o $(OBJS)

hw3.o: ../../hw3.c
	make -C ../..
	cp ../../hw3.o .

%.o : %.c hw3.o
	gcc $(CFLAGS) $< -c -o $@
	gcc $(CFLAGS) $@ hw3.o -o $(basename $@)

clean:
	rm -rf $(OBJS) hw3.o $(basename $(OBJS))
