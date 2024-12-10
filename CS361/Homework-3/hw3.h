#ifndef _HW3_H_
#define _HW3_H_

long brk_dist(void * ptr);

long block_size(void * ptr);

int is_block_free(void * ptr);

void * next_used_mem(void * ptr);

void * next_free_mem(void * ptr);

void free_everything(void * start, void * end, int size, long * stats);

#endif
