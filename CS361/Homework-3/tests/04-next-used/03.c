// Test 03: check links between two allocated and one unallocated block
#include "hw3.h"

#define _DEFAULT_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#define BSIZE 512
#define ASIZE 4

static void * blocks[ASIZE];


int main(void)
{
    for (int i = 0; i < ASIZE; i++)
        blocks[i] = malloc(BSIZE);

    void * block1 = blocks[1];
    void * block2 = blocks[2];
    void * block3 = blocks[3];

    memset(block1, 0xff, BSIZE);
    memset(block3, 0xbb, BSIZE);

    free(block2);

    void * block1_next = next_used_mem(block1);
    void * block2_next = next_used_mem(block2);

    assert(block1_next == block3);
    assert(block2_next == block3);

    free(blocks[0]);
    free(block1);
    free(block3);

    return EXIT_SUCCESS;
}
