// Test 03: check dist2block between allocations which should increase dist

#include "hw3.h"

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define BSIZE 128
#define ASIZE 8192


static void * blocks[ASIZE];

int main(void)
{
    for (int i = 0; i < ASIZE/2; i++)
        blocks[i] = malloc(BSIZE);

    void * block2check = blocks[2];
    long dist1 = brk_dist(block2check);

    for (int i = ASIZE/2; i < ASIZE; i++)
        blocks[i] = malloc(BSIZE);

    long dist2 = brk_dist(block2check);
    long diff = dist2 - dist1;

    printf("first recorded dist: %lu\n", dist1);
    printf("second recorded dist: %lu\n", dist2);
    printf("recorded change in dist: %lu\n", diff);

    assert(diff > 0);

    for (int i = 0; i < ASIZE; i++)
        free(blocks[i]);

    return EXIT_SUCCESS;
}
