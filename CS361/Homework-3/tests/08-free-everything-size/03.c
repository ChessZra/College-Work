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

    int cutoff = 200;

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

    long total = 0L;
    long total_bytes = 0L;

    for (int i = start + 1 ; i < end ; i++) {
        int size = block_size(data[i]);
        if (size > cutoff) {
            total += 1;
            total_bytes += size;
        }
    }

    printf("Freeing everything sized %d between %d and %d\n", cutoff, start, end);

    // Frees everything between start and end
    long stats[2];
    free_everything(data[start], data[end], cutoff, stats);

    printf("Should have free'd %ld, counted %ld\n", total, stats[0]);
    assert(stats[0] == total);

    printf("Should have free'd exactly %ld bytes, counted %ld\n", total_bytes, stats[1]);
    assert(stats[1] == total_bytes);

    return 0;
}
