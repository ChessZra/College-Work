#! /bin/bash

TEST_DIR=tests/
EXEC=hw2
OUTPUT=out
TEMP=temp
DIFF=diff_file

RED='\033[41;37m'
GREEN='\033[42m'
BLUE='\033[44m'
RESET='\033[0m'

make clean && make all

# check if running sub test

if [ $# -eq 1 ]; then
    TEST_DIR=tests/$1
fi

# run tests

for IN in $(ls -1 -d ${TEST_DIR}*.in | sort)
do
    PASS=1
    NAME=$(echo ${IN} | cut -d '.' -f1 | cut -d '/' -f2)
    # inform which test will run
    echo -e "\n\n${BLUE} Running Test ${RESET} ${NAME}"

    # exec
    T1=$(date +%s%N | cut -b1-13 | sed s/N/000/g)
    ./${EXEC} $(cat ${IN}) &> $OUTPUT
    RET=$?
    T2=$(date +%s%N | cut -b1-13 | sed s/N/000/g)
    TT=$((T2-T1))

    # identify expected file
    TITLE="DIFF"
    EXPECTED=$(sed 's/.in$/.expected/g' <<< ${IN})
    MD5=$(sed 's/.in/.md5/g' <<< ${IN})
    if test -f "$MD5"; then
        EXPECTED=$(echo ${MD5})
        cat $OUTPUT | md5sum > $TEMP
        mv $TEMP $OUTPUT
        TITLE="MD5"
    fi

    # determine if run failed
    if [ $RET -eq 0 ]; then
        echo -e "${GREEN} exec OK in ${TT}ms ${RESET}"
    else
        echo -e "${RED} exec FAIL in ${TT}ms ${RESET}"
        PASS=0
    fi

    # determine if output matches
    diff -y $EXPECTED $OUTPUT &> $DIFF
    DIFF_RET=$?
    if [ $DIFF_RET -eq 0 ]; then
        echo -e "${GREEN} ${TITLE} OK ${RESET}"
    else
        echo -e "${RED} ${TITLE} FAILED ${RESET}"
        echo "diff -y \$EXPECTED \$OUTPUT"
        cat $DIFF
        PASS=0
    fi

    # determine if test was passed
    if [ $PASS -eq 0 ]; then
        echo -e "${RED} TEST ${NAME} FAILED ${RESET}"
    else
        echo -e "${GREEN} TEST ${NAME} PASSED ${RESET}"
    fi
done

rm -f $DIFF $TEMP $OUTPUT
make clean
