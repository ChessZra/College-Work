// Test 02: check the distance between two blocks

#include "hw3.h"

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define BSIZE 128
#define ASIZE 3


static void * blocks[ASIZE];


int main(void)
{
    for (int i = 0; i < ASIZE; i++)
        blocks[i] = malloc(BSIZE);
    void * block1 = blocks[1];
    void * block2 = blocks[2];

    long dist1 = brk_dist(block1);
    long dist2 = brk_dist(block2);
    long block_diff = dist1 - dist2;
    long ptr_diff = (long)block2 - (long)block1;

    printf("block1 dist: %lu\n", dist1);
    printf("block2 dist: %lu\n", dist2);
    printf("distance between blocks: %lu\n", block_diff);
    printf("distance between malloc pointers: %lu\n", ptr_diff);

    assert(block_diff == ptr_diff);

    for (int i = 0; i < ASIZE; i++)
        free(blocks[i]);
    return EXIT_SUCCESS;
}
