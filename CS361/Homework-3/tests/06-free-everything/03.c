#include "hw3.h"

#define _DEFAULT_SOURCE
#include<unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>

int main() {
    int m_size = 128;

    srandom(time(NULL));

    // Allocates something so that the  heap doesn't become empty
    // Empty heaps can be weird...
    malloc(1000);

    void * data[500];

    for (int i = 0 ; i < (sizeof(data)/sizeof(*data)) ; i++) {
        // Get a size at random
        int n = 128 + ((int) (random() % 1000));

        // Allocates memory with random size and saves it
        data[i] = malloc(n);
    }

    // Pick a point at random to start freeing stuff
    int start = (int) 1 + (random() % ((sizeof(data)/sizeof(*data))-2));
    // Pick a point at random to stop freeing stuff
    int end = start + (int) (random() % ((sizeof(data)/sizeof(*data))-1-start));

    printf("Freeing everything between %d and %d\n", start, end);

    // Frees everything between start and end
    free_everything(data[start], data[end], 0, NULL);

    void * ptr = data[0];

    // Checks that all data before start is not free
    for (int i = 1 ; i <= start ; i++) {
        if (is_block_free(data[i])) {
            printf("%d\n", i);
        }
        assert(!is_block_free(data[i]));
    }

    // Checks that all data between start and end is free
    for (int i = start + 1 ; i < end ; i++) {
        if (!is_block_free(data[i])) {
            printf("%d\n", i);
        }
        assert(is_block_free(data[i]));
    }

    // Checks that all data after end is not free
    for (int i = end ; i < (sizeof(data)/sizeof(*data)) ; i++) {
        if (is_block_free(data[i])) {
            printf("%d\n", i);
        }
        assert(!is_block_free(data[i]));
    }

    return 0;
}
