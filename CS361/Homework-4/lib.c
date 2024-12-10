#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#include "lib.h"

// Do not modify this file, changes will be overwritten by the autograder

// This file contains functions that you do not need to modify
// read_line is called in main to read one line from stdin
// print_result is for your convenience for implementing wc


void print_result(int bsize, int lsize, int wsize)
{
    printf("Num Bytes: %d\n", bsize);
    printf("Num Lines: %d\n", lsize);
    printf("Num Words: %d\n", wsize);
}


// read one line from fd to buf
// it preserves the trailing newline from the input
// it does not NULL terminate buf
// it returns the number of bytes read into the buffer

size_t read_line(int fd, char buf[], int max)
{
    if (max <= 0)
        return 0;

    static char c;
    static int pos;
    static ssize_t amt;

    pos = 0;
    while (pos < max) {
        amt = read(fd, &c, 1);
        if (amt != 1)
            break;
        buf[pos++] = c;
        if (c == '\n')
            break;
    }

    return pos;
}
