/* Test 01: ensure distance to brk is positive */

#include "hw3.h"

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define ASIZE 2
#define BSIZE 128


int main(void)
{
    void * blocks[ASIZE];
    for (int i = 0; i < ASIZE; i++)
        blocks[i] = malloc(BSIZE);

    void * block2check = blocks[1];
    long dist = brk_dist(block2check);
    printf("block2check dist: %lu\n", dist);
    assert(dist != 0);
    assert(dist > 0);

    for (int i = 0; i < ASIZE; i++)
        free(blocks[i]);
    return EXIT_SUCCESS;
}
