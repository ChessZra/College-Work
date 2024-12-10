// Test 01: free a block inbetween some others
#include "hw3.h"

#define _DEFAULT_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>


#define BSIZE 2048
#define ASIZE 4


static void * blocks[ASIZE];

int main(void)
{
    for (int i = 0; i < ASIZE; i++)
        blocks[i] = malloc(BSIZE);

    void * block1 = blocks[1];
    void * block2free = blocks[2];
    void * block3 = blocks[3];

    memset(block1, 0xff, BSIZE);
    memset(block2free, 0xdd, BSIZE);
    memset(block3, 0xbb, BSIZE);

    assert(is_block_free(block1) == 0);
    assert(is_block_free(block2free) == 0);
    assert(is_block_free(block3) == 0);

    free(block2free);

    assert(is_block_free(block1) == 0);
    assert(is_block_free(block2free) != 0);
    assert(is_block_free(block3) == 0);

    free(blocks[0]);
    free(block1);
    free(block3);
    return EXIT_SUCCESS;
}
