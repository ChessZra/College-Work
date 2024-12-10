#! /bin/bash
# Authors: George Maratos

RED='\033[41;37m'
GREEN='\033[42m'
BLUE='\033[44m'
RESET='\033[0m'

TARGET=hw1.o
SYMTAB=symtab
SECTIONS=sections

declare -A sections


# important functions for running tests


function print_extract_sections
{
    # extract sections
    readelf -S ${TARGET} | grep -P -o '\[\s*[0-9]+\]\s+\S+' |
            sed 's/\s//g' | sed 's/\[//g' | sed 's/\]/ /g' >${SECTIONS}

    cat ${SECTIONS}

    while read -r NDX SEC; do
        sections["${SEC}"]="${NDX}"
    done <${SECTIONS}
}


function run_test
{
    TEST_NUM=$1
    TGT_NAME=$2
    TGT_SEC=$3
    TGT_BND=$4
    TGT_TYP=$5
    TGT_SIZ=$6
    IS_SUFFIX=$7

    printf "${BLUE} Running Test ${TEST_NUM} ${RESET}\n"

    printf "Extracting symtab entry ${TGT_NAME}\n"
    readelf -s ${TARGET} >${SYMTAB}

    # set the REGEX for finding target entry in .symtab

    if [[ ${IS_SUFFIX} -eq 1 ]]; then
        REGEX="\s+${TGT_NAME}(\.\d+)$"
    else
        REGEX="\s+${TGT_NAME}$"
    fi
    grep -P ${REGEX} ${SYMTAB}

    # fail test if symbol not in table

    if [[ ! $? -eq 0 ]]; then
        printf "No symbol named %s found.\n" "${TGT_NAME}"
        printf "${RED} Test ${TGT_NUM} FAILED ${RESET}\n"
        return
    fi

    # read values in entry and print to stdout

    read -r _ _ SIZ TYP BND _ SEC NAME <<<$(grep -P ${REGEX} ${SYMTAB})
    printf "SIZE=${SIZ}, TYPE=${TYP}, BIND=${BND}, SECTION=${SEC}, NAME=${NAME}\n"


    # fail test if symbol is in wrong section

    if [[ ${TGT_SEC} == UND ]]; then
        TGT_NDX=UND
    else
        TGT_NDX=${sections[${TGT_SEC}]}
    fi

    if [[ ! ${TGT_NDX} == ${SEC} ]]; then
        printf "Section of ${TGT_NAME} is not ${SEC}\n"
        printf "Symbol ${TGT_NAME} is not in ${TGT_SEC}\n"
        printf "${RED} Test ${TEST_NUM} FAILED ${RESET}\n"
        return
    fi

    # fail test if symbol has wrong binding

    if [[ ! ${TGT_BND} == ${BND} ]]; then
        printf "Binding of ${TGT_NAME} is not ${BND}\n"
        printf "${RED} Test ${TEST_NUM} FAILED ${RESET}\n"
        return
    fi

    # fail test if symbol has wrong type

    if [[ ! ${TGT_TYP} == ${TYP} ]]; then
        printf "Type of ${TGT_NAME} is not ${TYP}\n"
        printf "${RED} Test ${TEST_NUM} FAILED ${RESET}\n"
        return
    fi

    # fail test if symbol is of type OBJECT and has wrong size

    if [[ ${TYP} == OBJECT ]]; then
        if [[ ! ${TGT_SIZ} -eq ${SIZ} ]]; then
            printf "Size of ${TGT_NAME} is not ${SIZ}\n"
            printf "${RED} Test ${TEST_NUM} FAILED ${RESET}\n"
            return
        fi
    else
        printf "Skipping size test for non-OBJECT\n"
    fi
    printf "${GREEN} Test ${TEST_NUM} PASSED ${RESET}\n"
}


# BEGIN OF TESTS


# compile


printf "${BLUE} Compiling $TARGET ${RESET}\n"

make clean && make $TARGET


# check if relocatable file was produced


if [[ ! -f $TARGET ]]; then
    printf "${RED} No relocatable object file ${EXEC} produced after compiling.${RESET}\n"
    printf "Cannot evaluate correctness. Halting All Tests\n"
    exit 1
fi

printf "checking if ${TARGET} is a relocatable\n"

readelf -h ${TARGET} | grep -P 'Type:\s+\S+'
readelf -h ${TARGET} | grep -P 'Type:\s+\S+' | grep -P 'REL' >/dev/null 2>&1

if [[ ! $? -eq 0 ]]; then
    printf "${RED} ${TARGET} is not a relocatable object file! ${RESET}\n"
    printf "Halting all tests\n"
    exit 1
fi

printf "${GREEN} Compile successful. ${RESET}\n"


# print sections


printf "\nSections\n"
print_extract_sections

printf "\n$ readelf -s ${TARGET}\n"
readelf -s ${TARGET}


run_test 1 desert .text GLOBAL FUNC 0
run_test 2 main .text GLOBAL FUNC 0
run_test 3 good .text LOCAL FUNC 0

run_test 4 demure .data GLOBAL OBJECT 4 0
run_test 5 important .data GLOBAL OBJECT 8 0
run_test 6 wades .rodata GLOBAL OBJECT 8 0
run_test 7 fuzzy .bss GLOBAL OBJECT 4 0

run_test 8 needler .bss LOCAL OBJECT 1 0
run_test 9 unlatch .data LOCAL OBJECT 4 0
run_test 10 optional .data LOCAL OBJECT 21 0
run_test 11 elbow .rodata LOCAL OBJECT 4 0

run_test 12 extrude UND GLOBAL NOTYPE 1 0
run_test 13 redraw UND GLOBAL NOTYPE 1 0

run_test 14 zephyr .data GLOBAL OBJECT 8 0
run_test 15 zine .data LOCAL OBJECT 8 0

run_test 16 vow .bss LOCAL OBJECT 4 1
run_test 17 vote .bss LOCAL OBJECT 8 1
run_test 18 deface .data LOCAL OBJECT 7 1

run_test 19 leak .rodata LOCAL OBJECT 4 1

run_test 20 puts UND GLOBAL NOTYPE 1 0

rm -f ${SYMTAB} ${SECTIONS}


#Symbol table '.symtab' contains 22 entries:
#   Num:    Value          Size Type    Bind   Vis      Ndx Name
#     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
#     1: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS hw2.c
#     2: 0000000000000000     0 SECTION LOCAL  DEFAULT    1 .text
#     3: 0000000000000000     0 SECTION LOCAL  DEFAULT    6 .rodata
#     4: 0000000000000004     1 OBJECT  LOCAL  DEFAULT    5 needler
#     5: 0000000000000010     4 OBJECT  LOCAL  DEFAULT    3 unlatch
#     6: 0000000000000020    21 OBJECT  LOCAL  DEFAULT    3 optional
#     7: 0000000000000008     4 OBJECT  LOCAL  DEFAULT    6 elbow
#     8: 0000000000000040     8 OBJECT  LOCAL  DEFAULT    3 zine
#     9: 000000000000000b     7 FUNC    LOCAL  DEFAULT    1 good
#    10: 0000000000000014     4 OBJECT  LOCAL  DEFAULT    6 leak.2
#    11: 0000000000000008     8 OBJECT  LOCAL  DEFAULT    5 vote.1
#    12: 0000000000000010     4 OBJECT  LOCAL  DEFAULT    5 vow.0
#    13: 0000000000000000     4 OBJECT  GLOBAL DEFAULT    5 fuzzy
#    14: 0000000000000000     4 OBJECT  GLOBAL DEFAULT    3 demure
#    15: 0000000000000008     8 OBJECT  GLOBAL DEFAULT    3 important
#    16: 0000000000000000     8 OBJECT  GLOBAL DEFAULT    6 wades
#    17: 0000000000000038     8 OBJECT  GLOBAL DEFAULT    3 zephyr
#    18: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND extrude
#    19: 0000000000000000    11 FUNC    GLOBAL DEFAULT    1 desert
#    20: 0000000000000012    21 FUNC    GLOBAL DEFAULT    1 main
#    21: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND lean