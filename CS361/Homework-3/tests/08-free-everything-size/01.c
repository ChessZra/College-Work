#include "hw3.h"

#define _DEFAULT_SOURCE
#include<unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

int main() {
    int m_size1 = 128;
    int m_size2 = 512;

    // Allocates something so that the  heap doesn't become empty
    // Empty heaps can be weird...
    malloc(1000);

    // Allocates one chunk and fills it with 'a'
    char * p1 = malloc(m_size1);

    for (int i = 0 ; i < m_size1 ; i++)
        p1[i] = 'a';

    // Allocates one chunk and fills it with 'b'
    char * p2 = malloc(m_size1);

    for (int i = 0 ; i < m_size1 ; i++)
        p2[i] = 'b';

    // Allocates one chunk and fills it with 'c'
    char * p3 = malloc(m_size2);

    for (int i = 0 ; i < m_size2 ; i++)
        p3[i] = 'c';

    // End marker
    void * p4 = malloc(m_size1);

    // Frees everything between p1 and p4 less than 128 (i.e., p3 only)
    free_everything(p1, p4, 200, NULL);

    // p1 and p4 should not be free
    assert(!is_block_free(p1));
    assert(!is_block_free(p4));

    // p2 should not be free
    assert(!is_block_free(p2));

    // p3 should be free
    assert(is_block_free(p3));

    {
        // Calls the API
        void * i3 = next_free_mem(p1);
        void * i2 = next_used_mem(p1);

        // Makes sure we got the right pointers
        assert(i2 == p2);
        assert(i3 == p3);
    }

    return 0;
}
