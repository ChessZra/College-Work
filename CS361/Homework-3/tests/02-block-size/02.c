// Test 02: check multiple varying sizes

#include "hw3.h"

#define _DEFAULT_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>

#define ASIZE 4
#define HEADER_SIZE 8


static const int sizes[] = { 16, 40, 52, 71 };


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

    for (int i = 0; i < ASIZE; i++)
        blocks[i] = malloc(sizes[i]);

    for (int i = 1; i < ASIZE; i++) {
        void * block2check = blocks[i];
        int req_size = sizes[i];
        long expected_size = calculate_size(req_size);
        long size = block_size(block2check);
        printf("size requested: %d\n", req_size);
        printf("reported block size: %ld\n", size);
        printf("expected block size: %ld\n", expected_size);
        assert(size == expected_size);
    }

    for (int i = 0; i < ASIZE; i++)
        free(blocks[i]);

    return EXIT_SUCCESS;
}
