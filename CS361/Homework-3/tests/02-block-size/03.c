// Test 03: check a random size to ensure no hard coding
#include "hw3.h"

#define _DEFAULT_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>

#define ASIZE 2
#define BSIZE_SCALE 2400
#define HEADER_SIZE 8


static long calculate_size(int payload_size)
{
    static const long MIN_CHUNK_SIZE = 32;
    static const long M_ALIGNMENT = 16;
    int min_size = payload_size + HEADER_SIZE;
    if (min_size < MIN_CHUNK_SIZE)
        return MIN_CHUNK_SIZE;
    else if (min_size % M_ALIGNMENT == 0)
        return min_size;
    else
        return min_size / M_ALIGNMENT * M_ALIGNMENT + M_ALIGNMENT;
}


static void * blocks[ASIZE];

int main(void)
{
    srandom(time(NULL));
    int req_size = 16*(2 + random() % BSIZE_SCALE) - HEADER_SIZE;

    for (int i = 0; i < ASIZE; i++)
        blocks[i] = malloc(req_size);

    void * block2check = blocks[ASIZE-1];
    long expected_size = calculate_size(req_size);
    long size = block_size(block2check);
    printf("size requested: %d\n", req_size);
    printf("reported block size: %ld\n", size);
    printf("expected block size: %ld\n", expected_size);
    assert(size == expected_size);

    for (int i = 0; i < ASIZE; i++)
        free(blocks[i]);

    return EXIT_SUCCESS;
}
