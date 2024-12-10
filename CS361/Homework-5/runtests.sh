#!/bin/bash

# usage: ./runtests.sh [test_dir_regex] (test_file_regex)
# where test_file_regex is optional
# example: ./runtests.sh 01-connect     // runs all tests in tests/01-connect/
#          ./runtests.sh 01-connect 01  // runs tests/01-connect/01.sh
#          ./runtests.sh 01 01          // runs tests/01-connect/01.sh

EXEC=hw5
DUMMY=test
OUTPUT=output
DIFF=output.diff

PORT=
PID=

RED='\033[41;37m'
GREEN='\033[42m'
BLUE='\033[44m'
RESET='\033[0m'

export ASAN_OPTIONS="detect_leaks=false"


function free_port
{
    SS_LINE=$(ss -tlnp | grep -P '127.0.0.1:'${PORT}'\s')
    if [[ $? -ne 0 ]]; then
        return 0
    fi
    printf "Found process listening on port ${PORT}\n"
    printf "${SS_LINE}\n"
    PID_STR=$(printf "${SS_LINE}" | grep -P -o 'pid=\d+')
    if [[ $? -ne 0 ]]; then
        printf "User $(whoami) does not own process on port ${PORT}\n"
        return 1
    fi
    PID=$(printf "${PID_STR}" | cut -d "=" -f 2)
    printf "Sending SIGKILL to process ${PID} on port ${PORT}\n"
    kill -9 ${PID}
    if [[ $? -ne 0 ]]; then
        printf "Could not send SIGKILL to process ${PID} on port ${PORT}\n"
        return 1
    fi
    return 0
}


function reset_server
{
    free_port
    if [[ $? -ne 0 ]]; then
        printf "Could not free port ${PORT}\n"
        return 1
    fi
    bash -c "printf \$\$ >pid; exec ./${EXEC} ${PORT}" &
    PID=$!

    printf "Checking if connection can be established\n"
    TRIES=0
    until nc -z 127.0.0.1 ${PORT};
    do
        ((TRIES++))
        sleep 0.1
        if [[ "$TRIES" -gt 10 ]]; then
            free_port
            rm -f pid
            printf "Could not find server listening on port ${PORT}\n"
            return 1
        fi
    done
    printf "Done\n"
}


# START OF AUTOGRADER

ulimit -n 100

printf "${BLUE} Preparing Tests ${RESET}\n"
make clean && make all

TEST_DIR=tests

TEST_DIR_PAT="*"
if [[ $# -ge 1 ]]; then
    TEST_DIR_PAT="*$1*"
fi

TEST_NAME_PAT="*"
if [[ $# -ge 2 ]]; then
    TEST_NAME_PAT="*$2*"
fi

PORT=$(cat port.txt)
if [[ $? -ne 0 ]]; then
    printf "port number could not be read from port.txt\n"
    printf "${RED} Failed to initialize test environment ${RESET}\n"
    exit 1
fi
if [[ ${PORT} -lt 1025 ]]; then
    printf "port number cannot be [0-1024]\n"
    printf "${RED} Failed to initialize test environment ${RESET}\n"
    exit 1
fi


for DIR in $(find ${TEST_DIR}/* -type d -name "${TEST_DIR_PAT}"); do
    for NAME in $(find ${DIR}/* -type f -name "${TEST_NAME_PAT}.sh" -exec basename {} \;|cut -d '.' -f1|sort --unique); do

        TESTNAME=$(basename ${DIR})
        printf "${BLUE} Preparing for Test ${TESTNAME} ${NAME} ${RESET}\n"
        reset_server # sets PID
        if [[ $? -ne 0 ]]; then
            printf "${RED} Test ${TESTNAME} ${NAME} FAILED ${RESET}\n"
            continue
        fi
        TESTFILE=${DIR}/${NAME}.sh
        EXPECTED=${DIR}/${NAME}.expected
        printf "${BLUE} Running Test ${TESTNAME} ${NAME} ${RESET}\n"
        ./${TESTFILE} ${PORT} >${OUTPUT} 2>&1
        RET=$?
        if [[ ${RET} -ne 0 ]]; then
            printf "Test script returned ${RET}\n"
            printf "${RED} Test ${TESTNAME} ${NAME} FAILED ${RESET}\n"
            continue
        fi
        kill -9 ${PID} >/dev/null 2>&1
        wait ${PID} >/dev/null 2>&1
        diff -y ${EXPECTED} ${OUTPUT} >${DIFF} 2>&1
        if [[ $? -eq 0 ]]; then
            printf "${GREEN} Test ${TESTNAME} ${NAME} PASSED ${RESET}\n"
        else
            cat ${DIFF}
            printf "${RED} Test ${TESTNAME} ${NAME} FAILED ${RESET}\n"
        fi
    done
done

# clean up
free_port
rm -f d pid actual expected output output.diff read file actual1 actual6 file2

exit 0

#START=$(date +%s%N | cut -b1-13 | sed s/N/000/g)
#END=$(date +%s%N | cut -b1-13 | sed s/N/000/g)
#echo "Finished in $((END-START))ms"
#killall -9 $EXEC &> /dev/null
#killall --user $(whoami) -9 ${EXEC} >/dev/null 2>&1
