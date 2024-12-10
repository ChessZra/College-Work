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
    long total = 0L;
    long actual_total = 0L;

    for (int i = 0 ; i < (sizeof(data)/sizeof(*data)) ; i++) {
        // Get a size at random
        int n = 128 + ((int) (random() % 1000));

        // Allocates memory with random size and saves it
        data[i] = malloc(n);

        // Skip stats of first and last
        if (i != 0 && i != ((sizeof(data)/sizeof(*data))-1)) {
            total += n;
            actual_total += block_size(data[i]);
        }
    }

    // Frees everything
    long stats[2];
    free_everything(data[0], data[(sizeof(data)/sizeof(*data))-1], 0, stats);

    // Should have free'd all entries but 2

    long expected = (sizeof(data)/sizeof(*data)) - 2;
    printf("Should have free'd %ld, counted %ld\n", expected, stats[0]);
    assert(stats[0] == expected);

    printf("Should have free'd at least %ld bytes, counted %ld\n", total, stats[1]);
    assert(stats[1] > expected);

    printf("Should have free'd exactly %ld bytes, counted %ld\n", actual_total, stats[1]);
    assert(stats[1] == actual_total);

    return 0;
}
