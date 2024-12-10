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

    int cutoff = 400;

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

    long total = 0L;
    long total_bytes = 0L;

    for (int i = 0 ; i < n ; i++) {
        for (int j = start[i]+1 ; j < end[i] ; j++) {
            int size = block_size(data[j]);
            if (size > cutoff) {
                status[j] = 1;
                total += 1;
                total_bytes += size;
            } else {
                status[j] = 0;
            }
        }
    }

    long actual = 0L;
    long actual_bytes = 0L;

    for (int i = 0 ; i < n ; i++) {
        printf("Freeing everything sized at least %d between %d and %d\n", cutoff, start[i], end[i]);
        // Frees everything between start and end
        long stats[2];
        free_everything(data[start[i]], data[end[i]], cutoff, stats);
        actual += stats[0];
        actual_bytes += stats[1];
    }


    // Checks that all data before start[0] is not free
    for (int i = 1 ; i <= start[0] ; i++) {
        if (is_block_free(data[i])) {
            printf("%d\n", i);
        }
        assert(!is_block_free(data[i]));
    }

    for (int j = 0 ; j < n ; j++) {
        // Checks all data between start[j] and end[j]
        for (int i = start[j] + 1 ; i < end[j] ; i++) {
            if (status[i] == 1) {
                // Should be free
                if (!is_block_free(data[i]))
                {
                    printf("%d\n", i);
                }
                assert(is_block_free(data[i]));
            } else {
                // Should be used
                if (is_block_free(data[i]))
                {
                    printf("%d\n", i);
                }
                assert(!is_block_free(data[i]));
            }
        }

    }

    for (int j = 0 ; j < n-1 ; j++) {
        // Checks that all data between end[j] and start[j+1] is used
        for (int i = end[j] ; i < start[j+1] ; i++) {
            // Should be used
            if (is_block_free(data[i]))
            {
                printf("%d\n", i);
            }
            assert(!is_block_free(data[i]));
        }
    }

    // Checks that all data after end[n-1] is not free
    for (int i = end[n-1] ; i < (sizeof(data)/sizeof(*data)) ; i++) {
        if (is_block_free(data[i])) {
            printf("%d\n", i);
        }
        assert(!is_block_free(data[i]));
    }

    printf("Should have free'd %ld, counted %ld\n", total, actual);
    assert(actual == total);

    printf("Should have free'd exactly %ld bytes, counted %ld\n", total_bytes, actual_bytes);
    assert(actual_bytes == total_bytes);

    return 0;
}
