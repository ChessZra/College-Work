// Test 02: two allocated followed by an unallocated
#include "hw3.h"

#define _DEFAULT_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#define BSIZE 1024
#define ASIZE 5

static void * blocks[ASIZE];


int main(void)
{
    for (int i = 0; i < ASIZE; i++)
        blocks[i] = malloc(BSIZE);

    void * block1 = blocks[1];
    void * block2 = blocks[2];
    void * block3 = blocks[3];

    memset(block1, 0xff, BSIZE);
    memset(block2, 0xbb, BSIZE);

    free(block3);

    void * block1_next_free = next_free_mem(block1);
    void * block2_next_free = next_free_mem(block2);

    assert(block1_next_free == block3);
    assert(block2_next_free == block3);

    free(blocks[0]);
    free(block1);
    free(block2);
    free(blocks[ASIZE-1]);

    return EXIT_SUCCESS;
}
