#! /bin/bash
# Authors: George Maratos and Ke Du

# usage: [SOURCE=hw6.c] ./runtests.sh [TEST_NUM]

# if SOURCE is not set, use hw6.c
if [[ -z $SOURCE ]]; then
    SOURCE=./hw6.c
fi

EXEC=hw6
OUTPUT=elevator.log

RED='\033[41;37m'
GREEN='\033[42m'
BLUE='\033[44m'
RESET='\033[0m'

EXEC_TIMEOUT=18s
BASE_CFLAGS="-lpthread -lncurses -g -O0 -fsanitize=address -DNODISPLAY"

declare -a config # (MAX_CAPACITY ELEVATORS FLOORS PASSENGERS TRIPS_PER_PASSENGER)

ONLY_RUN_TEST=-1 # 0->run every test; other number-> only run that test
if [ $# -eq 1 ]; then
    ONLY_RUN_TEST=$1
fi


function compile_and_run
{
    # arg1: test id
    # arg2: total score for this test
    # arg3: 0 -> correctness test; 1 -> performance test
    # arg4: timeout in seconds

    # check if running designated test
    if (( ONLY_RUN_TEST != -1 && $1 != ONLY_RUN_TEST )); then
        return;
    fi

    printf "\n"

    MAX_CAPACITY=${config[0]}
    ELEVATORS=${config[1]}
    FLOORS=${config[2]}
    PASSENGERS=${config[3]}
    TRIPS_PER_PASSENGER=${config[4]}
    DELAY=${config[5]}

    printf "${BLUE} Running Test $1${RESET}\n"
    printf "MAX_CAPACITY = $MAX_CAPACITY\tFLOORS = $FLOORS\n"
    printf "ELEVATORS = $ELEVATORS\t\tPASSENGERS = $PASSENGERS\n"
    printf "TRIPS_PER_PASSENGER = $TRIPS_PER_PASSENGER\n"
    printf "DELAY = $DELAY\n"

    IS_PERFORMANCE=$3

    # approximated upper bound for performance test

    NUM_TRIPS=$(( PASSENGERS * TRIPS_PER_PASSENGER ))
    AVG_DISTANCE=$(( 2 * FLOORS ))

    SINGLE_TRIP_DELAY=$(( $AVG_DISTANCE + 40 )) # adjust this slightly

    TOTAL_DELAYS=$(( NUM_TRIPS * SINGLE_TRIP_DELAY))
    MAX_TIME=$(( TOTAL_DELAYS * DELAY / ELEVATORS )) # microseconds
    MAX_TIME=$(( MAX_TIME / 1000 )) # milliseconds

    TOLERANCE=$(( MAX_TIME / 5 ))
    MAX_TIME=$(( MAX_TIME + TOLERANCE ))

    if [[ $IS_PERFORMANCE -eq 1 ]]; then
        printf "MAX_TIME = ${MAX_TIME} ms (upper bound for performance test)\n"
    fi

    CFLAGS="-DDELAY=${DELAY} -DMAX_CAPACITY=$MAX_CAPACITY -DELEVATORS=$ELEVATORS -DFLOORS=$FLOORS -DPASSENGERS=$PASSENGERS -DTRIPS_PER_PASSENGER=$TRIPS_PER_PASSENGER $BASE_CFLAGS"

    # compile and run solution

    printf "${BLUE} Compiling for Test $1 ${RESET}\n"
    make -s clean
    make CFLAGS="$CFLAGS" $EXEC

    if [[ ! -x $EXEC ]]; then
        printf "${RED} No executable ${EXEC} produced after compiling.${RESET}\n"
        printf "Cannot evaluate correctness. Halting All Tests\n"
        exit 1
    else
        printf "${GREEN} Compile successful.${RESET}\n"
    fi

    printf "${BLUE} Running Test $1 Correctness${RESET}\n"

    rm -f ${OUTPUT}
    timeout ${EXEC_TIMEOUT} ./$EXEC >/dev/null
    EXIT_CODE=$?

    # make sure test ran successfully

    if [[ $EXIT_CODE -eq 124 ]]; then
        printf "${RED} ./${EXEC} timed out after ${EXEC_TIMEOUT}${RESET}\n"
        printf "VIOLATION: Autograder Test $1 Timeout\n" >> ${OUTPUT}
    fi

    if [[ ! -f ${OUTPUT} ]]; then
        printf "${RED} Log file ${OUTPUT} is missing after run.${RESET}\n"
        printf "Cannot evaluate correctness. Halting All Tests\n"
        exit 1
    fi

    # report and check violations, test halts if there are violations

    grep "VIOLATION" ${OUTPUT}

    if [[ $? -eq 0 ]]; then
        printf "${RED} TEST $1 FAILED - Violations detected${RESET}\n"
        printf "${RED} Showing end of log below${RESET}\n"
        tail -30 ${OUTPUT}
        return
    fi

    # check if test terminated as expected
    # "Total time elapsed" is present <-> program terminates normally
    # if no violations then pass for correctness

    tail -1 ${OUTPUT} | grep "Total time elapsed:"

    if [[ ! $? -eq 0 ]]; then
        printf "${RED} TEST $1 FAILED - Simulation did not terminate as expected${RESET}\n"
        printf "Could not find final log message 'Total time elapsed ...'\n"
        printf "Note: You CANNOT add this message. It comes from main.c!\n"
        return
    else
        printf "No violations detected.\n"
        printf "${GREEN} TEST $1 CORRECTNESS PASSED${RESET}\n"
    fi

    # run performance test if required

    RUNTIME=$(tail -1 ${OUTPUT} | grep -o -P '[0-9]+ ms' | grep -o -P '[0-9]+')

    if [[ $IS_PERFORMANCE -eq 1 ]]; then
        printf "${BLUE} Running Test $1 Performance${RESET}\n"
        printf "Is RUNTIME < ${MAX_TIME} ms ?\n"
        if [[ $RUNTIME -le $MAX_TIME ]]; then
            printf "${GREEN} TEST $1 PERFORMANCE PASSED${RESET}\n"
        else
            printf "${RED} TEST $1 PERFORMANCE FAILED${RESET}\n"
        fi
    fi

}

cp $SOURCE ${EXEC}.c

START=$(date +%s%N | cut -b1-13 | sed s/N/000/g)

# config=(MAX_CAPACITY ELEVATORS FLOORS PASSENGERS TRIPS_PER_PASSENGER DELAY)
# compile_and_run test_id points_for_this_test 0=correctness/1=performance timeout


# test 0
# starter code test 1 elevator 1 passenger
# worth 0 points

config=(1 1 28 1 1 1000)
compile_and_run 0 0 0


# test 1
# can the elevator handle multiple trips?

config=(1 1 28 1 2 1000)
compile_and_run 1 10 0


# test 2
# many trips (performance, does the elevator serve one passenger efficiencly)

config=(1 1 28 1 200 300)
compile_and_run 2 10 1


# test 3
# two passenger test

config=(1 1 28 2 2 1000)
compile_and_run 3 10 0


# test 4
# many passengers (performance, too much lock contention can affect performance)
# this is where inefficient synchronization should fail

config=(1 1 28 50 1 200)
compile_and_run 4 10 1


# test 5
# two elevator test

config=(1 2 28 20 1 1000)
compile_and_run 5 10 1


# test 6
# four elevator test multiple trips (performance, should have similar time)

config=(1 4 28 75 2 300)
compile_and_run 6 10 1


# test 7
# high elevator to passenger ratio

config=(5 30 28 20 10 1000)
compile_and_run 7 10 0


# many elevators (performance, too much lock contention can affect performance)

config=(5 30 28 60 10 1000)
compile_and_run 8 10 1


## LONG trips to tests (are you only serving one passenger at a time?)
#config=(15 1 28 30 1 5000)
#compile_and_run 8 5 1

END=$(date +%s%N | cut -b1-13 | sed s/N/000/g)
printf "Test suite finished in $((END-START))ms\n"


killall -9 $EXEC &> /dev/null


#    # time limit is a worst case scenario estimate, where the elevator has to travel the longest distance to pick every passenger up
#    # and the longest distance to drop every passenger off
#    # consider the strategy where each elevator serves MAX_CAPACITY passengers: it picks up MAX_CAPACITY passengers and then drop them
#    # off one by one. We call these passengers a group.
#
#    # the total number of groups to serve is approx. total passenger trips divided by capacity. The division is rounded down so we add 1
#    # for estimating an upperbound.
#    # estimates for worst case
#    NUM_GROUP=$(( config[3] * config[4] / MAX_CAPACITY + 1))
#    # the total number of groups that one elevator needs to serve is approx. NUM_GROUP divided by the number of elevators
#    NUM_GROUP_PER_ELEVATOR=$(( NUM_GROUP / ELEVATORS + 1 ))
#    # to server each group, the elevator travel from the bottom floor to the top floor to pick every passenger up, and then travel from the
#    # top floor to the bottom floor to drop them off. This is (2 * FLOORS) floors to travel, and it takes DELAY μs to travel a floor.
#    # And for every passenger in the group, the elevator has to open and close the door each time it picks up or drops off a passenger.
#    # Opening and closing the door takes 10 * DELAY μs, so the total time to serve a group is:
#    ELEVATOR_TRIPS_PER_GROUP_WORST=$(( 2 * FLOORS * DELAY + 40 * DELAY ))
#    # the total time to serve all groups (in microseconds) is:
#    TOTAL_TIME_WORST=$(( NUM_GROUP_PER_ELEVATOR * ELEVATOR_TRIPS_PER_GROUP_WORST ))
#    # The time limit is the total time to serve all groups in milliseconds, plus 10% of the time limit as allowance.
#    TIME_LIMIT=$(( TOTAL_TIME_WORST / 1000 ))
#    TENTH_OF_TIME_LIMIT=$(( TIME_LIMIT / 10 ))
#    TIME_LIMIT=$(( TIME_LIMIT + TENTH_OF_TIME_LIMIT ))
#    printf "Time limit for test $1: ${BLUE}$TIME_LIMIT${RESET} ms\n"

