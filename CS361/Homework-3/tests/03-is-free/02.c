// Test 02: free a random block inbetween some others to prevent hard coding
#include "hw3.h"

#define _DEFAULT_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <time.h>


#define BSIZE 512
#define ASIZE 64


static void * blocks[ASIZE];

int main(void)
{
    for (int i = 0; i < ASIZE; i++) {
        blocks[i] = malloc(BSIZE);
        memset(blocks[i], 2*i+1, BSIZE);
    }

    for (int i = 0; i < ASIZE; i++)
        assert(is_block_free(blocks[i]) == 0);

    srandom(time(NULL));
    int id2free = 1 + random() % (ASIZE-2);
    printf("total blocks: %d\n", ASIZE);
    printf("freeing block %d\n", id2free);
    free(blocks[id2free]);

    for (int i = 1; i < ASIZE; i++) {
        if (i == id2free) {
            assert(is_block_free(blocks[i]) == 1);
        } else {
            assert(is_block_free(blocks[i]) == 0);
            free(blocks[i]);
        }
    }

    free(blocks[0]);
    return EXIT_SUCCESS;
}
