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

    // Frees everything
    free_everything(data[0], data[(sizeof(data)/sizeof(*data))-1], 0, NULL);

    void * ptr = data[0];

    // Checks that all data after 0 is free
    for (int i = 1 ; i < ((sizeof(data)/sizeof(*data)) - 1) ; i++) {
        if (!is_block_free(data[i])) {
            printf("%d\n", i);
        }
        assert(is_block_free(data[i]));
    }

    return 0;
}
