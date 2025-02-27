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

    int start[10];
    int end[10];
    int n = 1;

    // Pick a point at random to start freeing stuff
    assert(100 <= sizeof(data)/sizeof(*data));
    start[0]  = (int) (random() % 50) + 1;

    // Pick a point at random to stop freeing stuff
    end[0] = start[0] + 10 + (int) (random() % 40);

    for (int i = 1 ; i < sizeof(start)/sizeof(*start) ; i++) {
        // Pick a point at random to start freeing stuff
        do {
            start[i]  = end[i-1] + 10 + (int) (random() % 50);
        } while (start[i] - end[i-1] > 50);

        do {
            // Pick a point at random to stop freeing stuff
            end[i] = start[i] + 10 + (int) (random() % 50);
        } while (end[i] - start[i] > 50);

        if (end[i] > sizeof(data)/sizeof(*data))
            break;

        n += 1;
    }

    for (int i = 0 ; i < n ; i++) {
        printf("Freeing everything between %d and %d\n", start[i], end[i]);

        long expected_n = 0L;
        long expected_bytes = 0L;

        for (int j = start[i]+1 ; j < end[i] ; j++) {
            expected_n += 1;
            expected_bytes += block_size(data[j]);
        }

        // Frees everything between start and end
        long stats[2];
        free_everything(data[start[i]], data[end[i]], 0, stats);

        printf("Should have free'd %ld, counted %ld\n", expected_n, stats[0]);
        assert(stats[0] == expected_n);

        printf("Should have free'd exactly %ld bytes, counted %ld\n", expected_bytes, stats[1]);
        assert(stats[1] == expected_bytes);

    }

    return 0;
}
