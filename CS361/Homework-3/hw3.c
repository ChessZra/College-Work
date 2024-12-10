#define _POSIX_C_SOURCE 200809L
#define _DEFAULT_SOURCE

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdint.h>
#include "hw3.h"

#define exit(N) {fflush(stdout); fflush(stderr); _exit(N); }

// For the following functions:
// Assume that void* ptr is a pointer given by malloc, which signifies the start of the payload.
long brk_dist(void * ptr)
{
    void *initial = sbrk(0);
    long diff = (char*)initial - (char*)ptr; 
    return diff;
}

// Return the total size of the block in bytes.
long block_size(void * ptr)
{ 
    char* header_ptr = ptr - 8;
    long header_value = *(long *)header_ptr; 
    header_value = header_value & 0xFFFFFFFFFFFFFFF8; // make the first 3 bits zero
    return header_value;
}

// Returns 0 if the block is not free, returns a non-zero if it's free
int is_block_free(void * ptr)
{
   long size = block_size(ptr);
   char* next_header = ptr + size - 8;
   long next_header_value = *(long *)next_header;
   return !(next_header_value & 0x1);
}

// Return the next allocated block (the address at the beginning of the payload).
void * next_used_mem(void * ptr)
{
    long size = block_size(ptr);
    char* next_payload = ptr + size;

    while (is_block_free(next_payload)) {
	size = block_size(next_payload);
	next_payload = next_payload + size;
    }
    return next_payload;
}

// Return the next free'd block (the address at the beginning of the payload).
void * next_free_mem(void * ptr)
{
    long size = block_size(ptr);
    char* next_payload = ptr + size;
    
    while (!is_block_free(next_payload)) {
	size = block_size(next_payload);
	next_payload = next_payload + size; 
    }
    return next_payload;
}

void free_everything(void * start, void * end, int size, long * stats)
{
    // ignoring stats is enough to pass test 06
    // stats are tests 07 and 08
    // finally only free things larger than size
    // PDF -> Free Everything

    long how_many_freed = 0;
    long how_many_bytes = 0;

    char* cur = start + block_size(start);
    while (cur != end) {
	   long bsize = block_size(cur);
	   if (bsize > size) {
		free(cur);	   
		how_many_freed += 1;
		how_many_bytes += bsize;
	   };
	   cur = cur + bsize;
    }
    if (stats != NULL) {
        stats[0] = how_many_freed;
        stats[1] = how_many_bytes;
    }    
}
