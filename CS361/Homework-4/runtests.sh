#! /bin/bash

TEST_DIR=tests
EXEC=hw4
OUTPUT=out
DIFF_FILE=diff_file

RED='\033[41;37m'
GREEN='\033[42m'
BLUE='\033[44m'
RESET='\033[0m'




# check if running sub test
function run_test
{
    pref=$1
    tnum=$2
    ENVFILE=${pref}/${tnum}.env
    IN=${pref}/${tnum}.in
    EXPECTED=${pref}/${tnum}.expected
    TNAME=$(basename ${pref});

    printf "\n\n${BLUE} Running Test ${RESET} ${TNAME} ${tnum}\n"

    T1=$(date +%s%N | cut -b1-13 | sed s/N/000/g)
    (source $ENVFILE && ./${EXEC} <${IN} >$OUTPUT 2>&1)

    RET=$?
    T2=$(date +%s%N | cut -b1-13 | sed s/N/000/g)
    TT=$((T2-T1))

    # determine if run failed
    if [ $RET -eq 0 ]; then
        echo -e "${GREEN} exec OK in ${TT}ms ${RESET}"
    else
        echo -e "${RED} exec FAIL in ${TT}ms ${RESET}"
        return
    fi

    # determine if output matches (passed test)
    diff -y $EXPECTED $OUTPUT >"$DIFF_FILE" 2>&1
    DIFF_RET=$?

    if [ $DIFF_RET -eq 0 ]; then
        printf "${GREEN} TEST ${pref}/${tnum} PASSED ${RESET}\n"
    else
        echo -e "${RED} TEST ${pref}/${tnum} FAILED ${RESET}"
        echo "diff -y \$EXPECTED \$OUTPUT"
        cat "$DIFF_FILE"
    fi

}

make clean && make all

TEST_DIR_PAT="*"
if [[ $# -ge 1 ]]; then
    TEST_DIR_PAT="*$1*"
fi

TEST_NAME_PAT="*"
if [[ $# -ge 2 ]]; then
    TEST_NAME_PAT="*$2*"
fi

for DIR in $(find ${TEST_DIR}/* -type d -name "${TEST_DIR_PAT}"); do
    for NAME in $(find ${DIR}/* -type f -name "${TEST_NAME_PAT}.in" -exec basename {} \;|cut -d '.' -f1|sort --unique); do
        run_test $DIR $NAME
    done
done

rm -f $DIFF_FILE $OUTPUT
printf "\n"
