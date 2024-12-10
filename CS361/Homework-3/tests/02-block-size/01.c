// Test 01: check if minimum chunk size can be detected
#include "hw3.h"

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define ASIZE 2
#define BSIZE 16
#define MIN_CHUNK_SIZE 32

static void * blocks[ASIZE];

int main(void)
{
    for (int i = 0; i < ASIZE; i++)
        blocks[i] = malloc(BSIZE);
    void * block2check = blocks[ASIZE-1];

    long size = block_size(block2check);

    printf("Requested size: %d\n", BSIZE);
    printf("Reported block size: %ld\n", size);
    printf("Expected block size: %d\n", MIN_CHUNK_SIZE);

    assert(size > 0);
    assert(size != 0);
    assert(size == MIN_CHUNK_SIZE);

    for (int i = 0; i < ASIZE; i++)
        free(blocks[i]);
    return EXIT_SUCCESS;
}
