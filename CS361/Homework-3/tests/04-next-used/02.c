// Test 02: check two links between three allocated blocks but vary the block sizes
#include "hw3.h"

#define _DEFAULT_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#define BSIZE 256
#define ASIZE 4
#define STEP 64
#define BASE_CHAR 0x67

static void * blocks[ASIZE];


int main(void)
{
    for (int i = 0; i < ASIZE; i++) {
        int size = BSIZE + STEP*i;
        blocks[i] = malloc(size);
        memset(blocks[i], BASE_CHAR+i, size);
    }

    void * block1 = blocks[1];
    void * block2 = blocks[2];
    void * block3 = blocks[3];

    void * block1_next = next_used_mem(block1);
    void * block2_next = next_used_mem(block2);

    assert(block1_next == block2);
    assert(block2_next == block3);

    for (int i = 0; i < ASIZE; i++)
        free(blocks[i]);

    return EXIT_SUCCESS;
}
