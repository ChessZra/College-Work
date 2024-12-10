#!/bin/bash

# usage: ./runtests.sh [test_dir_regex] (test_file_regex)
# where test_file_regex is optional
# example: ./runtests.sh 01-heap_size     // runs all tests in tests/01-heap_size/
#          ./runtests.sh 01-heap_size 01  // runs tests/01-heap_size/01.c
#          ./runtests.sh 01 1             // runs tests/01-heap_size/01.c

OUTPUT=output
TEST_DIR=tests

RED='\033[41;37m'
GREEN='\033[42m'
BLUE='\033[44m'
RESET='\033[0m'

function choose_single_test {
    if [ $# -eq 1 ]
    then
        grep -E "$1"
    else
        :
    fi
}

ALL_PASS=1

make clean && make all
START=$(date +%s%N | cut -b1-13 | sed s/N/000/g)
for T in $(ls $TEST_DIR | grep -E "$1" | sort)
do
    make -C $TEST_DIR/$T clean && make -C $TEST_DIR/$T all
    for F in $(ls $TEST_DIR/$T | choose_single_test "$2" | grep ".c$" | sort)
    do
        NAME=$(echo "${T}/${F}" | cut -d '.' -f1)
        echo -e "\n\n${BLUE} Running Test ${RESET} ${NAME}"

        TESTFILE="$TEST_DIR/$T/$F"
        EXEC=$(sed 's/.c$//g' <<<"$TESTFILE")

        mv $EXEC.exe $EXEC &> /dev/null
        T1=$(date +%s%N | cut -b1-13 | sed s/N/000/g)
        GLIBC_TUNABLES="glibc.malloc.tcache_count=0" ./$EXEC < $TESTFILE &> $OUTPUT
        RET=$?
        T2=$(date +%s%N | cut -b1-13 | sed s/N/000/g)
        TT=$((T2-T1))

        if [ $RET -eq 0 ]
        then
            echo -e "${GREEN} TEST ${NAME} PASSED in ${TT}ms ${RESET}"
            cat $OUTPUT
        else
            echo -e "${RED} TEST ${NAME} FAILED in ${TT}ms ${RESET}"
            cat $OUTPUT
            ALL_PASS=0
        fi
    done
done
END=$(date +%s%N | cut -b1-13 | sed s/N/000/g)
echo "Finished in $((END-START))ms"

make clean
rm output

if [ $ALL_PASS -eq 0 ]; then
    echo -e "${RED} Some test FAILED ${RESET}"
    exit 1
else
    echo -e "${GREEN} All tests PASSED ${RESET}"
    exit 0
fi
