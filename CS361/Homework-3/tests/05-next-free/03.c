// Test 03: free followed by allocated repeated
#include "hw3.h"

#define _DEFAULT_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#define BSIZE 256
#define ASIZE 5

static void * blocks[ASIZE];


int main(void)
{
    for (int i = 0; i < ASIZE; i++)
        blocks[i] = malloc(BSIZE);

    void * block1 = blocks[1];
    void * block2 = blocks[2];
    void * block3 = blocks[3];
    void * block4 = blocks[4];

    memset(block3, 0xbb, BSIZE);
    memset(block4, 0xdd, BSIZE);

    free(block1);
    free(block3);

    void * block1_next_free = next_free_mem(block1);
    void * block2_next_free = next_free_mem(block2);

    assert(block1_next_free == block3);
    assert(block2_next_free == block3);

    free(blocks[0]);
    free(block2);
    free(block4);

    return EXIT_SUCCESS;
}
