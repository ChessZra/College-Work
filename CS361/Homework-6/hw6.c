#include "elevator.h"

#include <assert.h>
#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define NSLOTS 200 // max number of elevators and passengers

struct queue {
    pthread_mutex_t lock;
    pthread_cond_t ready; // condition when an item is added
    int buffer[NSLOTS];
    int nitems;
    int front;
    int rear;
};

struct passenger {
    pthread_mutex_t lock;
    pthread_cond_t passenger_ready_for_pickup_cond;
    pthread_cond_t passenger_in_elevator_cond;
    pthread_cond_t passenger_exited_elevator_cond;
    pthread_cond_t elevator_at_pickup_cond;
    pthread_cond_t elevator_at_destination_cond;
    pthread_cond_t elevator_id_cond;

    int from_floor;
    int to_floor;
    int passenger_ready_for_pickup;
    int passenger_in_elevator;
    int passenger_exited_elevator;
    int elevator_at_pickup;
    int elevator_at_destination;
    int elevator_id;
};

struct queue JOBQ;
struct passenger Passengers[NSLOTS];

void qinsert(int item) {
    pthread_mutex_lock(&JOBQ.lock);
    
    // Check for queue full condition
    if (JOBQ.nitems == NSLOTS) {
        pthread_mutex_unlock(&JOBQ.lock);
        return;
    }
    
    JOBQ.buffer[JOBQ.rear] = item;
    JOBQ.rear = (JOBQ.rear + 1) % NSLOTS;
    JOBQ.nitems += 1;
    
    pthread_cond_signal(&JOBQ.ready);
    pthread_mutex_unlock(&JOBQ.lock);
}

int qremove(void) {
    pthread_mutex_lock(&JOBQ.lock);
    
    if (JOBQ.nitems == 0) {
        pthread_mutex_unlock(&JOBQ.lock);
        return -1;
    }
    
    int item = JOBQ.buffer[JOBQ.front];
    JOBQ.front = (JOBQ.front + 1) % NSLOTS;
    JOBQ.nitems -= 1;
    
    pthread_mutex_unlock(&JOBQ.lock);
    return item;
}

void scheduler_init(void) {
    // Clear the queue structure to ensure no garbage values
    memset(&JOBQ, 0, sizeof(struct queue));
    
    pthread_mutex_init(&JOBQ.lock, NULL);
    pthread_cond_init(&JOBQ.ready, NULL);
    
    JOBQ.nitems = 0;
    JOBQ.front = 0;
    JOBQ.rear = 0;
}

void passenger_init(int id) {
    memset(&Passengers[id], 0x00, sizeof(Passengers[id]));

    pthread_mutex_init(&Passengers[id].lock, NULL);
    pthread_cond_init(&Passengers[id].passenger_ready_for_pickup_cond, NULL);
    pthread_cond_init(&Passengers[id].passenger_in_elevator_cond, NULL);
    pthread_cond_init(&Passengers[id].passenger_exited_elevator_cond, NULL);
    pthread_cond_init(&Passengers[id].elevator_at_pickup_cond, NULL);
    pthread_cond_init(&Passengers[id].elevator_at_destination_cond, NULL);
    pthread_cond_init(&Passengers[id].elevator_id_cond, NULL);

    Passengers[id].passenger_ready_for_pickup = 0;
    Passengers[id].passenger_in_elevator = 0;
    Passengers[id].passenger_exited_elevator = 0;
    Passengers[id].elevator_at_pickup = 0;
    Passengers[id].elevator_at_destination = 0;
    Passengers[id].elevator_id = -1;
}

void passenger_request(int passenger, int from_floor, int to_floor,
                       void (*enter)(int, int), void (*exit)(int, int)) {
    passenger_init(passenger);

    qinsert(passenger);

    int id = passenger;

    // inform elevator of floor
    pthread_mutex_lock(&Passengers[id].lock);
    Passengers[id].from_floor = from_floor;
    Passengers[id].to_floor = to_floor;
    
    // signal ready and wait
    Passengers[id].passenger_ready_for_pickup = 1;
    pthread_cond_signal(&Passengers[id].passenger_ready_for_pickup_cond);

    while (!Passengers[id].elevator_at_pickup) {
        pthread_cond_wait(&Passengers[id].elevator_at_pickup_cond, &Passengers[id].lock);
    }
    // get elevator id
    while (Passengers[id].elevator_id == -1) {
        pthread_cond_wait(&Passengers[id].elevator_id_cond, &Passengers[id].lock);
    }
    int elevator_id = Passengers[id].elevator_id;
    pthread_mutex_unlock(&Passengers[id].lock);

    // enter elevator and wait
    enter(id, elevator_id);

    pthread_mutex_lock(&Passengers[id].lock);
    Passengers[id].passenger_in_elevator = 1;
    pthread_cond_signal(&Passengers[id].passenger_in_elevator_cond);
    while (!Passengers[id].elevator_at_destination) {
        pthread_cond_wait(&Passengers[id].elevator_at_destination_cond, &Passengers[id].lock);
    }
    pthread_mutex_unlock(&Passengers[id].lock);

    // exit elevator and signal
    exit(id, elevator_id);
    
    pthread_mutex_lock(&Passengers[id].lock);
    Passengers[id].passenger_exited_elevator = 1;
    pthread_cond_signal(&Passengers[id].passenger_exited_elevator_cond);
    pthread_mutex_unlock(&Passengers[id].lock);
}


// example procedure that makes it easier to work with the API
// move elevator from source floor to destination floor
// you will probably have to modify this in the future ...

static void move_elevator(int source, int destination, void (*move_direction)(int, int), int elevator)
{
    int direction, steps;
    int distance = destination - source;
    if (distance > 0) {
        direction = 1;
        steps = distance;
    } else {
        direction = -1;
        steps = -1*distance;
    }
    for (; steps > 0; steps--)
        move_direction(elevator, direction);
}

void elevator_ready(int elevator, int at_floor,
                    void (*move_direction)(int, int), void (*door_open)(int),
                    void (*door_close)(int))
{
    int id = qremove();
    if (id == -1) return;

    /* Wait for passenger thread start */
    // wait for passenger to press button and move
    pthread_mutex_lock(&Passengers[id].lock);
    while (!Passengers[id].passenger_ready_for_pickup) {
        pthread_cond_wait(&Passengers[id].passenger_ready_for_pickup_cond, &Passengers[id].lock);
    }
    pthread_mutex_unlock(&Passengers[id].lock);
    /* Wait for passenger thread end */
    
    move_elevator(at_floor, Passengers[id].from_floor, move_direction, elevator);

    // open door and signal passenger
    door_open(elevator);
    
    /* Wait for passenger thread start */
    pthread_mutex_lock(&Passengers[id].lock);
    Passengers[id].elevator_at_pickup = 1;
    pthread_cond_signal(&Passengers[id].elevator_at_pickup_cond);

    Passengers[id].elevator_id = elevator;
    pthread_cond_signal(&Passengers[id].elevator_id_cond);

    // wait for passenger to enter then close and move
    while (!Passengers[id].passenger_in_elevator) {
        pthread_cond_wait(&Passengers[id].passenger_in_elevator_cond, &Passengers[id].lock);
    }
    pthread_mutex_unlock(&Passengers[id].lock);
    /* Wait for passenger thread end */

    door_close(elevator);
    move_elevator(Passengers[id].from_floor, Passengers[id].to_floor, move_direction, elevator);

    // open door the signal
    door_open(elevator);

    /* Wait for passenger thread start */
    pthread_mutex_lock(&Passengers[id].lock);
    Passengers[id].elevator_at_destination = 1;
    pthread_cond_signal(&Passengers[id].elevator_at_destination_cond);
    // wait for passenger to leave and close door
    while (!Passengers[id].passenger_exited_elevator) {
        pthread_cond_wait(&Passengers[id].passenger_exited_elevator_cond, &Passengers[id].lock);
    }

    pthread_mutex_unlock(&Passengers[id].lock);

    door_close(elevator);
}