// do not modify this file changes will be overwritten by the autograder

#ifndef HW4_H
#define HW4_H

#define exit(N) {fflush(stdout); fflush(stderr); _exit(N); }
#define BSIZE 1024

void run_cmd(char * line);
void execute(char * input);
void pipeline(char* head, char* tail);
void sequence(char *head, char *tail);

void wc(void);
#endif
