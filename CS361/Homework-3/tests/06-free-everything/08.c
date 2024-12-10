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
        // Frees everything between start and end
        free_everything(data[start[i]], data[end[i]], 0, NULL);
    }

    void * ptr = data[0];

    // Checks that all data before start[0] is not free
    for (int i = 1 ; i <= start[0] ; i++) {
        if (is_block_free(data[i])) {
            printf("%d\n", i);
        }
        assert(!is_block_free(data[i]));
    }

    for (int j = 0 ; j < n ; j++) {
        // Checks that all data between start[j] and end[j] is free
        for (int i = start[j] + 1 ; i < end[j] ; i++) {
            if (!is_block_free(data[i])) {
                printf("%d\n", i);
            }
            assert(is_block_free(data[i]));
        }

    }

    for (int j = 0 ; j < n-1 ; j++) {
        // Checks that all data between end[j] and start[j+1] is not free
        for (int i = end[j] ; i < start[j+1] ; i++) {
            if (is_block_free(data[i])) {
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

    return 0;
}
