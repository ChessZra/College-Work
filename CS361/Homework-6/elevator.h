#include <pthread.h>
#include <ncurses.h>

/* Change these experiment settings to try different scenarios. Parameters can
     also be passed in using gcc flags, e.g. -DELEVATORS=5 */

#ifndef MAX_CAPACITY
#define MAX_CAPACITY 3
#endif

#ifndef ELEVATORS
#define ELEVATORS 3
#endif

#ifndef FLOORS
#define FLOORS 28
#endif

#ifndef PASSENGERS
#define PASSENGERS 5
#endif

#ifndef TRIPS_PER_PASSENGER
#define TRIPS_PER_PASSENGER 3
#endif


// these settings affect only the 'looks', will be tested at log level 1


#ifndef DELAY
#define DELAY 50000
#endif


extern pthread_mutex_t log_lock;
extern WINDOW * logwin;
extern FILE * logfile;


#ifndef LOG_LEVEL
#define LOG_LEVEL 9
#endif


#define log(level,format,...) do{ if(level<=LOG_LEVEL) { pthread_mutex_lock(&log_lock); fprintf(logfile,format,__VA_ARGS__); fflush(logfile); wprintw(logwin,format,__VA_ARGS__); wrefresh(logwin); pthread_mutex_unlock(&log_lock);} }while(0);


/* called once on initialization */


void scheduler_init();


/* called whenever a passenger pushes a button in the elevator lobby.
     call enter / exit to move passengers into / out of elevator
     return only when the passenger is delivered to requested floor
*/


void passenger_request(int passenger, int from_floor, int to_floor,
                       void (*enter)(int, int), void(*exit)(int, int));


/* called whenever the elevator needs to know what to do next
     call move_direction with direction -1 to descend, 1 to ascend.
     must call door_open before letting passengers in, and door_close before moving the elevator
*/

void elevator_ready(int elevator, int at_floor,
            void(*move_direction)(int, int), void(*door_open)(int), void(*door_close)(int));

