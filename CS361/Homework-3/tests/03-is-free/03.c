// Test 03: free a block inbetween some others but vary size of blocks
#include "hw3.h"

#define _DEFAULT_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>


#define BSIZE 1024
#define ASIZE 4
#define STEP 32
#define BASE_CHAR 0x61

static void * blocks[ASIZE];

int main(void)
{
    for (int i = 0; i < ASIZE; i++) {
        int size = BSIZE + STEP*i;
        blocks[i] = malloc(size);
        memset(blocks[i], BASE_CHAR+i, size);
    }

    void * block1 = blocks[1];
    void * block2free = blocks[2];
    void * block3 = blocks[3];

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
