#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>


static void print_functions()
{   
	printf("display_usage\n");
	printf("fingerprint\n");
	printf("handle_error\n");
    	printf("validate\n");
}


void print_vars()
{ 
	printf("ERR_LIST\n");
	printf("EXTENDED\n");
	printf("FERR_LIST\n");
	printf("MODE\n");
	printf("STANDARD\n");
	printf("STATUS\n");
}


extern void display_usage(void);
extern int fingerprint(char* input, int len);
extern int STATUS;
extern int STANDARD;
extern int EXTENDED;
extern int* MODE;
extern void handle_error(void);
extern int validate(char* input, int len);

int main(int argc, char ** argv)
{
    if (argc != 2) {
        fprintf(stderr, "Program needs at least one argument\n");
        return 1;
    }

    char * arg = argv[1];

    if (!strcmp(arg, "functions")) {
        print_functions();
    } else if (!strcmp(arg, "objects")) {
        print_vars();
    } else if (!strcmp(arg, "usage")) {
	display_usage();
    } else {
	int valid = validate(arg, strlen(arg));	
	if (!valid) {;
		MODE = &EXTENDED;
		int get = fingerprint(arg, strlen(arg));	
		if (STATUS == 0) {
			printf("%d", get);
		} else {
			printf("%s", arg);
		}
		return 0;
	} else {
		MODE = &STANDARD;
        	int get = fingerprint(arg, strlen(arg));    
        	if (STATUS == 0) {
                	printf("%d", get);
        	} else {
                	printf("%s", arg);
        	}
	}
    }
    return 0;
}
