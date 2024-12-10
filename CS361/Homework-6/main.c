#include <ncurses.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <sys/time.h>
#include <pthread.h>
#include <unistd.h>
#include <sched.h>
#include "elevator.h"


void elevator_check(int elevator);
static void elevator_move_direction_check(int elevator, int direction);
static void elevator_open_door_check(int elevator);
static void passenger_enter_check(int passenger, int elevator);
static void passenger_exit_check(int passenger, int elevator);

void log_msg(int level, char * message);
void elevator_move_direction(int elevator, int direction);
void elevator_open_door(int elevator);
void elevator_close_door(int elevator);

void * start_elevator(void *arg);
void passenger_enter(int passenger, int elevator);
void passenger_exit(int passenger, int elevator);
void * start_passenger(void *arg);
void * draw_state(void *ptr);


WINDOW * displaywin;
WINDOW * logwin;
FILE * logfile;

// when stop == 1, all threads quit voluntarily
static int stop = 0;

pthread_mutex_t log_lock;
pthread_barrier_t passengers_ready;

pthread_mutex_t state_lock;

// internal struct for "enforcement system"

static struct Elevator
{
    int floor;
    int open;
    int passengers;
    int trips;
} elevators[ELEVATORS];

__thread enum { PASSENGER=1, ELEVATOR=2 } type;
__thread int id;

// state_lock must be held when calling


static char EEOP[] = "VIOLATION: elevator %d operation attempted on wrong thread!\n";
static char EEPC[] = "VIOLATION: elevator %d over capacity, or negative passenger count %d!\n";


void elevator_check(int elevator)
{
    if(type != ELEVATOR || id != elevator) {
        log(0, EEOP, elevator);
        exit(1);
    }
    static int pnum;
    pnum = elevators[elevator].passengers;
    if(pnum > MAX_CAPACITY || pnum < 0) {
        log(0, EEPC, elevator, pnum);
            exit(1);
    }
}


void log_msg(int level, char * message)
{
    log(level, "%s", message);
}


static char LME[] = "Moving elevator %d %s from %d\n";
static char EEDO[] = "VIOLATION: attempted to move elevator %d with door open.\n";
static char EEMO[] = "VIOLATION: attempted to move elevator %d outside of building!\n";


static void elevator_move_direction_check(int elevator, int direction)
{
    pthread_mutex_lock(&state_lock);

    elevator_check(elevator);
    static int floor;
    floor = elevators[elevator].floor;

    log(8, LME, elevator, (direction==-1 ? "down": "up"), floor);

    if(elevators[elevator].open) {
        log(0, EEDO, elevator);
        exit(1);
    }
    if(floor >= FLOORS || floor < 0) {
        log(0, EEMO, elevator);
        exit(1);
    }

    pthread_mutex_unlock(&state_lock);
}


void elevator_move_direction(int elevator, int direction)
{
    elevator_move_direction_check(elevator, direction);

    sched_yield();
    usleep(DELAY);

    elevator_move_direction_check(elevator, direction);

    pthread_mutex_lock(&state_lock);
    elevators[elevator].floor += direction;
    pthread_mutex_unlock(&state_lock);
}


static char LOD[] = "Opening elevator %d at floor %d\n";
static char EOOD[] = "VIOLATION: attempted to open elevator %d door when already open.\n";


static void elevator_open_door_check(int elevator)
{
    pthread_mutex_lock(&state_lock);

    elevator_check(elevator);
    log(9, LOD, elevator, elevators[elevator].floor);
    if(elevators[elevator].open) {
        log(0, EOOD, elevator);
        exit(1);
    }
    pthread_mutex_unlock(&state_lock);
}


void elevator_open_door(int elevator)
{
    elevator_open_door_check(elevator);
    usleep(10*DELAY);
    elevator_open_door_check(elevator);

    pthread_mutex_lock(&state_lock);
    elevators[elevator].open = 1;
    pthread_mutex_unlock(&state_lock);
}


static char LCED[] = "Closing elevator %d at floor %d\n";
static char ECED[] = "VIOLATION: attempted to close elevator %d door when already closed.\n";


void elevator_close_door(int elevator)
{
    pthread_mutex_lock(&state_lock);
    elevator_check(elevator);
    log(9, LCED, elevator, elevators[elevator].floor);
    if(!elevators[elevator].open) {
        log(0, ECED, elevator);
        exit(1);
    }
    pthread_mutex_unlock(&state_lock);

    pthread_mutex_lock(&state_lock);
    elevators[elevator].open = 0;
    pthread_mutex_unlock(&state_lock);

    sched_yield();
    usleep(10*DELAY);
}


void * start_elevator(void * arg)
{
    size_t elevator = (size_t)arg;
    id = elevator;
    type = ELEVATOR;
    struct Elevator * e = &elevators[elevator];
    e->passengers = 0;
    e->trips = 0;
    log(6, "Starting elevator %lu\n", elevator);
    e->floor = 0;//elevator % (FLOORS-1);
    while(!stop) {
        elevator_ready(elevator, e->floor, elevator_move_direction,
                                        elevator_open_door, elevator_close_door);
        sched_yield();
    }
}

/* This is an internal struct used by the enforcement system
     - there is no access to this from hw6.c. */


static struct Passenger {
    int id;
    int from_floor;
    int to_floor;
    int in_elevator;
    int at_floor;
    enum {WAITING, ENTERED, EXITED} state;
} passengers[PASSENGERS];


static char EPERT[] = "VIOLATION: passenger enter for %d attempted on wrong thread!\n";
static char EPRF[] = "VIOLATION: let passenger %d on on wrong floor %d!=%d.\n";
static char EPCD[] = "VIOLATION: passenger %d walked into a closed door entering elevator %d.\n";
static char EPFE[] = "VIOLATION: passenger %d attempted to board full elevator %d.\n";
static char EPNW[] = "VIOLATION: passenger %d told to board elevator %d, was not waiting.\n";

static char XDWTF[] = "VIOLATION: passenger %d enter for attempted on wrong thread.\n";
static void passenger_enter_check(int passenger, int elevator)
{
    pthread_mutex_lock(&state_lock);

    if(type != PASSENGER || id != passenger) {
        log(0, XDWTF, passengers[passenger].id, elevator);
        log(0, EPERT, passenger);
        exit(1);
    }

    if(passengers[passenger].from_floor != elevators[elevator].floor) {
        log(0, EPRF, passengers[passenger].id,
                        passengers[passenger].from_floor, elevators[elevator].floor);
        exit(1);
    }

    if(!elevators[elevator].open) {
        log(0, EPCD, passengers[passenger].id, elevator);
        exit(1);
    }
    if(elevators[elevator].passengers == MAX_CAPACITY) {
        log(0, EPFE, passengers[passenger].id, elevator);
        exit(1);
    }
    if(passengers[passenger].state!=WAITING) {
        log(0, EPNW, passengers[passenger].id, elevator);
        exit(1);
    }
    pthread_mutex_unlock(&state_lock);
}


static char LPOE[] = "Passenger %d got on elevator %d at %d, requested %d\n";


void passenger_enter(int passenger, int elevator)
{
    passenger_enter_check(passenger,elevator);
    sched_yield();
    usleep(DELAY);
    passenger_enter_check(passenger,elevator);

    pthread_mutex_lock(&state_lock);
    log(6, LPOE, passengers[passenger].id, elevator,
                passengers[passenger].from_floor, elevators[elevator].floor);

    elevators[elevator].passengers++;
    passengers[passenger].in_elevator = elevator;
    passengers[passenger].state = ENTERED;
    pthread_mutex_unlock(&state_lock);
}


static char EPEWT[] = "VIOLATION: passenger exit for %d attempted on wrong thread!\n";
static char EPWE[] = "VIOLATION: passenger %d told to get off elevator %d, was in elevator %d.\n";
static char EPWF[] = "VIOLATION: let passenger %d off on wrong floor %d!=%d.\n";
static char EPCE[] = "VIOLATION: passenger %d walked into a closed door leaving elevator %d.\n";


static void passenger_exit_check(int passenger, int elevator)
{
    pthread_mutex_lock(&state_lock);

    if(type != PASSENGER || id != passenger) {
        log(0, EPEWT, passenger);
        exit(1);
    }
    if(passengers[passenger].in_elevator != elevator) {
        log(0, EPWE, passengers[passenger].id, elevator,
                                    passengers[passenger].in_elevator);
        exit(1);
    }

    if(passengers[passenger].to_floor != elevators[elevator].floor) {
        log(0, EPWF, passengers[passenger].id,
                        passengers[passenger].to_floor, elevators[elevator].floor);
        exit(1);
    }
    if(!elevators[elevator].open) {
        log(0, EPCE, passengers[passenger].id, elevator);
        exit(1);
    }
    if(passengers[passenger].state != ENTERED) {
        log(0, EPNW, passengers[passenger].id, elevator);
        exit(1);
    }

    pthread_mutex_unlock(&state_lock);
}


static char LPEE[] = "Passenger %d got off elevator %d at %d, requested %d\n";


void passenger_exit(int passenger, int elevator)
{
    passenger_exit_check(passenger,elevator);
    sched_yield();
    usleep(DELAY);
    passenger_exit_check(passenger,elevator);

    pthread_mutex_lock(&state_lock);
    log(6, LPEE, passengers[passenger].id, elevator,
                passengers[passenger].to_floor, elevators[elevator].floor);

    elevators[elevator].passengers--;
    elevators[elevator].trips++;
    passengers[passenger].in_elevator = -1;
    passengers[passenger].at_floor = elevators[elevator].floor;
    passengers[passenger].state = EXITED;
    pthread_mutex_unlock(&state_lock);
}


static char EPWD[] = "VIOLATION: Passenger %d wanted to get to floor %d but ended up on floor %d\n";
static char LPTD[] = "Passenger %lu trip duration %d ms, %d slots\n";


void * start_passenger(void * arg)
{
    size_t passenger=(size_t)arg;
    id = passenger;
    type = PASSENGER;

    struct Passenger * p = &passengers[passenger];
    log(6, "Starting passenger %lu\n", passenger);
    p->from_floor = random() % FLOORS;
    p->at_floor = p->from_floor;
    p->in_elevator = -1;
    p->id = passenger;
    int trips = TRIPS_PER_PASSENGER;

    pthread_barrier_wait(&passengers_ready);

    while(!stop && trips-- > 0) {
        pthread_mutex_lock(&state_lock);

        // make sure a passenger does not request the floor it's on
        int dest = random() % FLOORS;
        while (dest == p->from_floor)
            dest = random() % FLOORS;

        p->to_floor = dest;
        log(6,"Passenger %lu requesting %d->%d\n",
                        passenger, p->from_floor, p->to_floor);

        struct timeval before;
        gettimeofday(&before, 0);
        passengers[passenger].state = WAITING;
        pthread_mutex_unlock(&state_lock);

        passenger_request(passenger, p->from_floor, p->to_floor,
                                    passenger_enter, passenger_exit);
        if (p->at_floor != p->to_floor){
            log(0, EPWD, p->id, p->to_floor, p->at_floor);
            exit(1);
        }
        struct timeval after;
        gettimeofday(&after,0);
        int ms = (after.tv_sec - before.tv_sec)*1000 + (after.tv_usec - before.tv_usec)/1000;
        log(1, LPTD, passenger, ms, ms*1000/DELAY);

        pthread_mutex_lock(&state_lock);
        p->from_floor = p->to_floor;
        pthread_mutex_unlock(&state_lock);

        usleep(DELAY); // sleep for some time
    }
}

void * draw_state(void * ptr) {

    while(1) {
        pthread_mutex_lock(&state_lock);
        pthread_mutex_lock(&log_lock);

        //printf("\033[2J\033[1;1H");
        //wclear(displaywin);
        wmove(displaywin,0,0);

        for(int floor = FLOORS-1; floor >= 0; floor--) {
            wprintw(displaywin,"%d\t",floor);
            for(int el=0;el<ELEVATORS;el++) {
                if(elevators[el].floor ==floor)
                    wprintw(displaywin," %c ",(elevators[el].open?'O':'_'));
                else
                    wprintw(displaywin," %c ",elevators[el].floor>floor?'|':' ');
            }
            wprintw(displaywin,"    ");
            int align = 15*ELEVATORS;
            for(int p=0;p<PASSENGERS;p++)
                if((passengers[p].state==ENTERED && elevators[passengers[p].in_elevator].floor==floor)) {
                    align-=5;
                    wprintw(displaywin,"->%02d ",passengers[p].to_floor);
                }
            while(align-->0) wprintw(displaywin," ");
            wprintw(displaywin,"X ");
            for(int p=0;p<PASSENGERS;p++)
                if((passengers[p].from_floor==floor && passengers[p].state==WAITING)) {
                    wprintw(displaywin,"->%d ",passengers[p].to_floor);
                }
            wprintw(displaywin,"\n");
        }
        wrefresh(displaywin);
        pthread_mutex_unlock(&state_lock);
        pthread_mutex_unlock(&log_lock);

        usleep(DELAY);
    }
}


static char LAD[] = "All %d passengers finished their %d trips each.\n";
static char TTE[] = "Total time elapsed: %d ms, %d slots\n";


int main(int argc, char** argv)
{
    logfile = fopen("elevator.log","w");

#ifndef NODISPLAY
    WINDOW *mainwin = initscr();
    cbreak(); noecho();
    displaywin = subwin(mainwin, FLOORS+2,0,0,0);
    logwin = subwin(mainwin, LINES-FLOORS-2, 0, FLOORS+2, 0);
    scrollok(logwin,true);
    refresh();
#endif

    struct timeval before;
    gettimeofday(&before,0);
    pthread_mutex_init(&log_lock,0);
    pthread_mutex_init(&state_lock,0);

    pthread_barrier_init(&passengers_ready, 0, PASSENGERS+1);

    scheduler_init();

    pthread_t passenger_t[PASSENGERS];
    for(size_t i=0;i<PASSENGERS;i++)  {
        pthread_create(&passenger_t[i], NULL, start_passenger, (void*)i);
    }

    // this is not necessary for a correct solution, it is just here to keep things orderly.
    pthread_barrier_wait(&passengers_ready);

    pthread_t elevator_t[ELEVATORS];
    for(size_t i=0;i<ELEVATORS;i++) {
        pthread_create(&elevator_t[i], NULL, start_elevator, (void*)i);
    }


#ifndef NODISPLAY
    pthread_t draw_t;
    if(pthread_create(&draw_t, NULL, draw_state, NULL)) {
        perror("creating display thread");
        exit(1);
    }
#endif

    /* wait for all trips to complete */
    for(int i=0;i<PASSENGERS;i++)
        pthread_join(passenger_t[i],NULL);
    stop = 1;
    for(int i=0;i<ELEVATORS;i++)
        pthread_join(elevator_t[i],NULL);

    struct timeval after;
    gettimeofday(&after,0);

    log(0, LAD, PASSENGERS,TRIPS_PER_PASSENGER);
    int ms = (after.tv_sec-before.tv_sec)*1000+(after.tv_usec-before.tv_usec)/1000;
    log(0, TTE, ms, ms*1000/DELAY);

    endwin();
}

