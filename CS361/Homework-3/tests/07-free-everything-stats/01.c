#include "hw3.h"

#define _DEFAULT_SOURCE
#include<unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>


int main() {
    int m_size = 128;

    // Allocates something so that the  heap doesn't become empty
    // Empty heaps can be weird...
    malloc(1000);

    // Allocates one chunk and fills it with 'a'
    char * p1 = malloc(m_size);

    for (int i = 0 ; i < m_size ; i++)
        p1[i] = 'a';

    // Allocates one chunk and fills it with 'b'
    char * p2 = malloc(m_size);

    for (int i = 0 ; i < m_size ; i++)
        p2[i] = 'b';

    // Allocates one chunk and fills it with 'c'
    char * p3 = malloc(m_size);

    for (int i = 0 ; i < m_size ; i++)
        p3[i] = 'c';

    // End marker
    void * p4 = malloc(m_size);

    // Frees everything between p1 and p4
    long stats[2];
    free_everything(p1, p4, 0, stats);

    // Should have free'd 2 chunks (p2 and p3)
    assert(stats[0] == 2);

    // Should have free'd more memory than 2x m_size
    assert(stats[1] >= (m_size << 1));

    // Should have free'd less memory than 4x m_size
    assert(stats[1] < (m_size << 2));

    return 0;
}
