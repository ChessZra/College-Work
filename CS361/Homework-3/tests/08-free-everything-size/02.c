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
    int status[500];
    long total = 0L;
    long actual_total = 0L;

    int cutoff = 500;

    for (int i = 0 ; i < (sizeof(data)/sizeof(*data)) ; i++) {
        // Get a size at random
        int n = 128 + ((int) (random() % 1000));

        // Allocates memory with random size and saves it
        data[i] = malloc(n);

        // Skip stats of first and last
        if (i != 0 && i != ((sizeof(data)/sizeof(*data))-1)) {
            long size = block_size(data[i]);
            if (size > cutoff) {
                total += 1;
                actual_total += size;
                status[i] = 1;
            } else {
                status[i] = 0;
            }
        }
    }

    // Pick a point at random to start freeing stuff
    int start = (int) 1 + (random() % ((sizeof(data)/sizeof(*data))-2));
    // Pick a point at random to stop freeing stuff
    int end = start + (int) (random() % ((sizeof(data)/sizeof(*data))-1-start));

    // Frees everything larger than cutoff
    printf("Freeing everything sized at least %d\n", cutoff);
    long stats[2];
    free_everything(data[0], data[(sizeof(data)/sizeof(*data))-1], cutoff, stats);

    void * ptr = data[0];

    // Checks that all data is free'd
    for (int i = 1 ; i < (sizeof(data)/sizeof(*data)-1) ; i++) {
        if (!status[i])
            continue;

        if (!is_block_free(data[i])) {
            printf("%d\n", i);
        }
        assert(is_block_free(data[i]));
    }

    // Should have free'd all entries but 2
    printf("Should have free'd %ld, counted %ld\n", total, stats[0]);
    assert(stats[0] == total);

    printf("Should have free'd exactly %ld bytes, counted %ld\n", actual_total, stats[1]);
    assert(stats[1] == actual_total);

    return 0;
}
