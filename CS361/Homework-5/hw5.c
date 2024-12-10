#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/epoll.h>
#include <assert.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>

#define RMAX 4096 // Request size (from client) 
#define HMAX 1024 // Header size (HTTP protocol)
#define BMAX 1024 // Body size (HTTP protocol)
#define EMAX 10

static char request[RMAX+1];

static int HSIZE = 0;
static char header[HMAX];

static int BSIZE = 0;
static char body[BMAX];

static int WSIZE = 0;
static char writeBuffer[1024];

static int clientToFd[512]; // Adjacency list => (clientId: fd)

static int listenfd;

void clearVariables() {
    memset(request, 0, sizeof(request));

    HSIZE = 0;
    memset(header, 0, sizeof(header));

    BSIZE = 0;
    memset(body, 0, sizeof(body));
}

void clearWriteBuffer() {
    WSIZE = 0;
    memset(writeBuffer, 0, sizeof(writeBuffer));
}

// Helper function for send_response
static void send_data(int clientfd, char buf[], int size) {
    ssize_t amt, total = 0;
    do {
        amt = send(clientfd, buf + total, size - total, 0);
        total += amt;
    } while (total < size);
}

// Function to send response to the client:
// This writes the response (including the header & the body)
// to the client file descriptor
static void send_response(int clientfd) {
    send_data(clientfd, header, HSIZE);
    send_data(clientfd, body, BSIZE);
}

// Create the server socket:
static int open_listenfd(int port) {
    int listenfd = socket(AF_INET, SOCK_STREAM, 0);

    static struct sockaddr_in server;
    server.sin_family = AF_INET;
    server.sin_port = htons(port);
    inet_pton(AF_INET, "127.0.0.1", &(server.sin_addr));

    // Important for the autograder:
    int optval = 1;
    setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, &optval, sizeof(optval));

    bind(listenfd, (struct sockaddr*)&server, sizeof(server));

    listen(listenfd, 10);

    return listenfd;
}

// This function blocks the current thread until a client joins:
static int accept_connection() {
    static struct sockaddr_in client;
    static socklen_t csize;

    memset(&client, 0x00, sizeof(client));
    memset(&csize, 0x00, sizeof(csize));
    clearVariables();

    return accept(listenfd, (struct sockaddr*)&client, &csize); 
}

void add_fd_epollin(int epoll_fd, int fd) {
    static struct epoll_event Event;
    memset(&Event, 0x00, sizeof(Event));
    Event.events = EPOLLIN;     // Event for reading
    Event.data.fd = fd;   // Data to be returned
    epoll_ctl(epoll_fd, EPOLL_CTL_ADD, fd, &Event);
}

void add_fd_epollout(int epoll_fd, int fd) {
    static struct epoll_event Event;
    memset(&Event, 0x00, sizeof(Event));
    Event.events = EPOLLOUT;     // Event for writing
    Event.data.fd = fd;   // Data to be returned
    epoll_ctl(epoll_fd, EPOLL_CTL_ADD, fd, &Event);
}

void remove_fd_from_epoll(int epoll_fd, int fd) {
    epoll_ctl(epoll_fd, EPOLL_CTL_DEL, fd, NULL);
}

void handle_error_400(int clientfd, char* method, char* uri, char* version, char* request) {
    snprintf(header, HMAX, "%s 400 Bad Request\r\n\r\n", version);
    HSIZE = strlen(header);
    send_response(clientfd);
    close(clientfd);
}

void handle_error_413(int clientfd, char* method, char* uri, char* version, char* request) {
    clearVariables();
    snprintf(header, HMAX, "%s 413 Request Entity Too Large\r\n\r\n", version);
    HSIZE = strlen(header);
    send_response(clientfd);
    close(clientfd);
}

void handle_bad_request(int clientfd) {
    snprintf(header, HMAX, "HTTP/1.1 400 Bad Request\r\n\r\n");
    HSIZE = strlen(header);
    send_data(clientfd, header, HSIZE);
    close(clientfd);
}

// Parses the request line using our HTTP protocol:
int parse_request_line(char* request, char* method, char* uri, char* version) {
    int i = 0;
    // Get method
    int j = 0;
    while (request[i] != ' ') {
        method[j++] = request[i++];

        if (request[i] == '\r') return -1;
    }
    method[j] = '\0';
    i++;

    if (strcmp("GET", method) != 0 && strcmp("POST", method) != 0) {
        return -1;
    }

    // Get URI
    j = 0;
    while (request[i] != ' ') {
        uri[j++] = request[i++];
        if (request[i] == '\r') return -1;
    }
    uri[j] = '\0';
    i++;

    // Get version until \r
    j = 0;
    while (request[i] != '\r') {
        version[j++] = request[i++];
    }
    version[j] = '\0';

    return 0;
}

// 0 if good, -1 if bad:
int handle_ping(int clientfd, char* method, char* uri, char* version, char* request) {
    char* response = "pong";
    snprintf(body, BMAX, "%s", response);
    BSIZE = strlen(body);
    snprintf(header, HMAX, "%s 200 OK\r\nContent-Length: %d\r\n\r\n", version, BSIZE);
    HSIZE = strlen(header);
    return 0;
}

// 0 if good, -1 if bad:
int handle_echo(int clientfd, char* method, char* uri, char* version, char* request) {

    char* first = request;
    while (*first != '\r') first++; // Skip the request line
    first += 2; // Skip the \r\n

    // Find the first occurence of \r\n\r\n
    char* end = strstr(request, "\r\n\r\n");
    
    if (end == NULL) {
        handle_error_400(clientfd, method, uri, version, request);
        return -1;
    }

    BSIZE = end - first;

    for (int i = 0; i < BSIZE; i++) {
        body[i] = *first;
        first++;
    }
    body[BSIZE] = '\0';

    if (BSIZE > BMAX) {
        handle_error_413(clientfd, method, uri, version, request);
        return -1;
    }

    snprintf(header, HMAX, "%s 200 OK\r\nContent-Length: %d\r\n\r\n", version, BSIZE);
    HSIZE = strlen(header);
    return 0;
}

// 0 if good, -1 if bad:
int handle_read(int clientfd, char* method, char* uri, char* version, char* request) {

    // Edge case - empty buffer:
    if (WSIZE == 0) {
        WSIZE = 7;
        strcpy(writeBuffer, "<empty>");

        snprintf(header, HMAX, "%s 200 OK\r\nContent-Length: %d\r\n\r\n", version, WSIZE);
        HSIZE = strlen(header);
        strcpy(body, writeBuffer);
        body[WSIZE] = '\0';
        BSIZE = WSIZE;

        // Reset back
        WSIZE = 0;
        return 0;
    }

    snprintf(header, HMAX, "%s 200 OK\r\nContent-Length: %d\r\n\r\n", version, WSIZE);
    HSIZE = strlen(header);
    memcpy(body, writeBuffer, WSIZE);
    BSIZE = WSIZE;

    return 0;
}

void send_chunk(int epoll_fd, int clientfd) {

    // Send the remaining body:
    int amt_read;
    if ((amt_read = read(clientToFd[clientfd], body, 1024)) > 0) {
        BSIZE = amt_read;
        // body[BMAX] = '\0';
        send_data(clientfd, body, BSIZE);
    } else {
        remove_fd_from_epoll(epoll_fd, clientfd); // Remove client from the epoll
        close(clientToFd[clientfd]);              // Close the output file
        clientToFd[clientfd] = -1;                // Reset adjacency list
        close(clientfd);                          // Close the client
    }
}

// 0 if good, -1 if bad (Common GET request)
int handle_path(int clientfd, char* method, char* uri, char* version, char* request, int epoll_fd) {

    // Read the file:
    struct stat st;

    int fd = open(uri + 1, O_RDONLY);
    if (fd == -1) {
        snprintf(header, HMAX, "%s 404 Not Found\r\n\r\n", version);
        HSIZE = strlen(header);
        send_data(clientfd, header, HSIZE);
        close(clientfd);
        return -1;
    }

    if (fstat(fd, &st) == -1) {
        perror("fstat");
        return -1;
    }

    // If it's not regular, then it's probably a directory
    if (!S_ISREG(st.st_mode)) {
        close(fd);
        snprintf(header, HMAX, "%s 404 Not Found\r\n\r\n", version);
        HSIZE = strlen(header);
        send_data(clientfd, header, HSIZE);
        close(clientfd);
        return -1;
    }

    // Send the header first:
    snprintf(header, HMAX, "%s 200 OK\r\nContent-Length: %ld\r\n\r\n", version, st.st_size);
    HSIZE = strlen(header);
    send_data(clientfd, header, HSIZE);

    // Add the client for writing:
    clientToFd[clientfd] = fd;
    add_fd_epollout(epoll_fd, clientfd);

    // send_chunk(epoll_fd, clientfd);
    return 0;
}

// 0 if good, -1 if bad:
int handle_write(int clientfd, char* method, char* uri, char* version, char* request) {
    
    // Read the content length:
    char* content_length = strstr(request, "Content-Length");
    int length;
    sscanf(content_length, "Content-Length: %d", &length);

    if (length > 1024) {
        handle_error_413(clientfd, method, uri, version, request);
        return -1;
    }

    snprintf(header, HMAX, "%s 200 OK\r\nContent-Length: %d\r\n\r\n", version, length);
    HSIZE = strlen(header);

    // Find the first occurence of \r\n\r\n and add 4 to get the beginning of the body:
    char* beginning = strstr(request, "\r\n\r\n") + 4;
    
    // Save the first length bytes to a buffer:
    clearWriteBuffer();
    memcpy(writeBuffer, beginning, length);
    WSIZE = length;

    // Copy the constructed write buffer to the body response
    memcpy(body, writeBuffer, length);
    BSIZE = WSIZE;

    return 0;
}

// Helper function for handle_request
void handle_get_request(int clientfd, char* method, char* uri, char* version, char* request, int epoll_fd) {

    if (strcmp("/ping", uri) == 0) {
        if (handle_ping(clientfd, method, uri, version, request) == -1) return;
        send_response(clientfd);
    } else if (strcmp("/echo", uri) == 0) {
        if (handle_echo(clientfd, method, uri, version, request) == -1) return;
        send_response(clientfd);
    } else if (strcmp(uri, "/read") == 0) {
        if (handle_read(clientfd, method, uri, version, request) == -1) return;
        send_response(clientfd);
    } else { // given a path probably (common request)
        if (handle_path(clientfd, method, uri, version, request, epoll_fd) == -1) return;
    }
}

// Helper function for handle_request
void handle_post_request(int clientfd, char* method, char* uri, char* version, char* request) {
    if (strcmp(uri, "/write") == 0) {
        if (handle_write(clientfd, method, uri, version, request) == -1) return;
        send_response(clientfd);
    } else {
        handle_bad_request(clientfd);
    }
}

// This function is called when a client instantly connects:
void handle_request(int clientfd, int epoll_fd) {
    ssize_t amt_a = recv(clientfd, request, RMAX, 0);
    request[amt_a] = '\0';
    if (amt_a == 0) {
        close(clientfd);
        return;
    }

    char method[256], uri[256], version[256];
    if (parse_request_line(request, method, uri, version) == -1) {
        handle_bad_request(clientfd);
        return;
    }

    if (strcmp("GET", method) == 0) {
        handle_get_request(clientfd, method, uri, version, request, epoll_fd);
    } else if (strcmp("POST", method) == 0) {
        handle_post_request(clientfd, method, uri, version, request);
    } 

    // Only close it when it's not generic:
    if (strcmp("/ping", uri) == 0 || strcmp("/echo", uri) == 0 || strcmp("/read", uri) == 0 || strcmp("/write", uri) == 0) {
        close(clientfd); // (THIS LINE CAUSED ME 2 HOURS)
    }
}

void epoll_main_loop(int epoll_fd) {
    struct epoll_event event_list[EMAX];
    while (1) {
        int nfds = epoll_wait(epoll_fd, event_list, EMAX, -1);
        for (int i = 0; i < nfds; i++) {
            int fd = event_list[i].data.fd;
            if (event_list[i].events == EPOLLIN) { 
                // Ready for reading:
                if (fd == listenfd) {
                    // Accept the client and them to the interest list:
                    //printf("New client detected\n");
                    int clientId = accept_connection();
                    add_fd_epollin(epoll_fd, clientId);
                } else {
                    // Client ready for reading (request)
                    //printf("The client is ready for reading.\n");
                    remove_fd_from_epoll(epoll_fd, fd);
                    handle_request(fd, epoll_fd);
                }
            } else {
                // Client ready for writing (response)
                //printf("The client is ready for writing.\n");
                send_chunk(epoll_fd, fd);
            }
        }
    }
}

int main(int argc, char * argv[])
{
    assert(argc == 2);
    int port = atoi(argv[1]);
    listenfd = open_listenfd(port);

    // Initialize our map
    memset(clientToFd, -1, sizeof(clientToFd));

    // Create an e poll instance
    int epoll_fd = epoll_create1(0);

    // Add listen FD to interest list
    add_fd_epollin(epoll_fd, listenfd);

    epoll_main_loop(epoll_fd);

    return 0;
}
