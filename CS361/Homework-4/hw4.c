#define  _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <assert.h>

#include "lib.h"
#include "hw4.h"


int main(int argc, char * argv[])
{
	printf("cs361sh> ");
	fflush(stdout);

	// make copies of file descriptors just in case
	int orig_in = dup(0);
	int orig_out = dup(1);
	int orig_err = dup(2);

	char line[BSIZE+1];

	size_t amt;
	while((amt = read_line(STDIN_FILENO, line, BSIZE)) > 0)  {
		line[amt] = '\0';
		run_cmd(line);
		printf("cs361sh> ");
		fflush(stdout);
   }

	printf("\n");
	fflush(stdout);
	fflush(stderr);
	return 0;
}

void wc(void)
{
	int size = 1024;
	char buffer[size + 1];
	size_t amt;
	int total_bytes = 0, lines = 0, words = 0;
	while ((amt = read_line(STDIN_FILENO, buffer, size)) > 0) {
		total_bytes += amt;
		lines++;
		buffer[amt] = '\0';
		int inWord = 0;
		for (size_t i = 0; (buffer[i] != '\0') && (buffer[i] != '\n'); i++) {
			if (buffer[i] != ' ') {
				if (inWord == 0) {
				words++;
				}
				inWord = 1;		
			} else {
				inWord = 0;
			}    
		}
   }
   print_result(total_bytes, lines, words); 
}

// Returns -1 if failed.
int run_command(char* cmd, char* fileout, char* filein, char* fileerr) 
{	
	// Create a child process where we can run exec on:
	pid_t cpid = fork();
	if (cpid == 0) { 
		
		if (fileout != NULL) {
			// Sample prompt: $ echo This is a test > text.txt
			// Get the file descriptor for the file path
			int fd = open(fileout, O_WRONLY | O_CREAT | O_TRUNC, 0644);
			// If fd is unsuccessful, return an error
			if (fd == -1) {
				perror("open");
				exit(1);
			}

			// Point STDOUT_FILENO to fd
			if (dup2(fd, STDOUT_FILENO) == -1) {
				perror("dup2");
				exit(1);	
			}
		}  
		if (filein != NULL) { 
			// Sample prompt: $ cat < test.txt
			int fd = open(filein, O_RDONLY);

			// If fd is unsuccessful, return an error
			if (fd == -1) {
				perror("open");
				exit(1);
			}

			// Point STDIN_FILENO to fd
			if (dup2(fd, STDIN_FILENO) == -1) {
				perror("dup2");
				exit(1);	
			}
		} 
		if (fileerr != NULL) {
			// Get the file descriptor for the file path
			int fd = open(fileerr, O_WRONLY | O_CREAT | O_TRUNC, 0644);

			// If fd is unsuccessful, return an error
			if (fd == -1) {
				perror("open");
				exit(1);
			}

			// Point STDOUT_FILENO to fd
			if (dup2(fd, STDERR_FILENO) == -1) {
				perror("dup2");
				exit(1);	
			}
		}

		// Build our argv array for the execv arguments
		char* argv[64];
		char* token = cmd;
		int index = 0;
		while (token != NULL) { 
			argv[index++] = token;	    
			token = strtok(NULL, " \n");
		}
		argv[index] = NULL;

		// Run the command
		execv(argv[0], argv);

		// Iterate through every path:
		char pathCopy[1024];
		strcpy(pathCopy, getenv("PATH"));
		char* path = strtok(pathCopy, ":");
		while (path != NULL) {
			char pathname[1024];
			strcpy(pathname, path);
			int len = strlen(pathname);
			pathname[len] = '/';
			pathname[len + 1] = '\0';
			strcat(pathname, argv[0]);
			execv(pathname, argv);
			path = strtok(NULL, ":");
		}
		// Exit with code 210: the command doesn't exist
		exit(210); 
	} else {
		int status;
		waitpid(cpid, &status, 0);
		if (WEXITSTATUS(status) != 210) {
			return 1;
		}
	}

	return -1;
}

void execute(char * input)
{
	char * sep = NULL;
	char* fileout = NULL;
	char* fileerr = NULL;
	char* filein = NULL;

	if ((sep=strstr(input, "2>"))) {
		*sep = 0;
		fileerr = sep + 2;
		// Parse the path filename:
		int i = 0;
		while (*fileerr == ' ') fileerr++; 
		for (i = 0; fileerr[i] != '\n' && fileerr[i] != '\0' && fileerr[i] != ' '; i++);
		fileerr[i] = '\0';
	}
	if ((sep=strstr(input,">"))) {
		*sep = 0; // input: /bin/echo This is a test
		fileout = sep + 1; // fileout: file.out
		// Parse the path filename:
		int i = 0;
		while (*fileout == ' ') fileout++; 
		for (i = 0; fileout[i] != '\n' && fileout[i] != '\0' && fileout[i] != ' '; i++);
		fileout[i] = '\0';
	}
	if ((sep=strstr(input,"<"))) {
		*sep = 0;
		filein = sep + 1;
		// Parse the path filename:
		int i = 0;
		while (*filein == ' ') filein++; 
		for (i = 0; filein[i] != '\n' && filein[i] != '\0' && filein[i] != ' '; i++);
		filein[i] = '\0';
	}

	char * cmd = strtok(input," \n");    
	if (cmd == NULL)
		return;

	if (strcmp(cmd, "wc") == 0) {
		wc();
	   return;
	} 
	
	if (run_command(cmd, fileout, filein, fileerr) == -1) {
		fprintf(stderr,"cs361sh: command not found: %s\n",cmd);
		fflush(stderr);	
	}
	return;
}

void run_cmd(char * line)
{
	char *sep = 0;
  
	if((sep=strstr(line,";"))) {
		*sep = 0;
		run_cmd(line);
		run_cmd(sep + 1);	
	}
	else if((sep=strstr(line,"|"))) {
		*sep = 0;
		char* nextLine = sep + 1;
		// Setup the pipes
		int fds[2];
		pipe(fds);
		
		// Left
		int cpid = fork();
		if (cpid == 0) {
			dup2(fds[1], STDOUT_FILENO);
			run_cmd(line);
			exit(0);
		} else {
			waitpid(cpid, NULL, 0);
		}
		close(fds[1]);

		// Right
		cpid = fork();
		if (cpid == 0) {
			dup2(fds[0], STDIN_FILENO);
			run_cmd(nextLine);
			exit(0);
		} else {
			waitpid(cpid, NULL, 0);
		}
		close(fds[0]);
	}
	else {
		execute(line);
	}
}

void pipeline(char * head, char * tail)
{
	assert(0);
}

void sequence(char * head, char * tail)
{
	fflush(stderr);
}
