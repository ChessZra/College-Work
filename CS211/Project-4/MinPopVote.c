#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include "MinPopVote.h"

bool setSettings(int argc, char** argv, int* year, bool* fastMode, bool* quietMode) {
    //------------------------------------------------   
    // TODO: Task 1 - write the setSettings() function
    //------------------------------------------------
    //sample processing of command-line arg...
    // Data files include: [1828, 2020].csv inclusive

    // Set settings to default value:
    *year = 0;
    *fastMode = false;
    *quietMode = false;

    for (int i = 1; i < argc; i++) {
        if (strcmp("-f", argv[i]) == 0) {
            *fastMode = true;
        } else if (strcmp("-q", argv[i]) == 0) {
            *quietMode = true;
        } else if (strcmp("-y", argv[i]) == 0 && i != (argc - 1)) {
            if (atoi(argv[i + 1]) % 4 == 0 && atoi(argv[i + 1]) >= 1828 && atoi(argv[i + 1]) <= 2020) {
                *year = atoi(argv[i + 1]);
            } else {
                *year = 0;
            }
            i += 1;
        } else {
            return false;
        }
    }
    return true; //modify or replace this
}

void inFilename(char* filename, int year) {
    //------------------------------------------------   
    // TODO: Task 2 - write the inFilename() function
    //------------------------------------------------
    return;
}

void outFilename(char* filename, int year) {
    //------------------------------------------------   
    // TODO: Task 2 - write the outFilename() function
    //------------------------------------------------
    return;
}

bool parseLine(char* line, State* myState) {
    //------------------------------------------------   
    // TODO: Task 4 - write the parseLine() function
    //------------------------------------------------
    return false; //modify or replace this
}

bool readElectionData(char* filename, State* allStates, int* nStates) {
    //-----------------------------------------------------   
    // TODO: Task 5 - write the readElectionData() function
    //-----------------------------------------------------
    return true; //modify or replace this
}

int totalEVs(State* states, int szStates) {
    //----------------------------------------------   
    // TODO: Task 6 - write the totalEVs() function;
    //                note test_totalEVs() is 
    //                provided in test.c to test
    //                the functionality of totalEVs()
    //                   >> make build_test
    //                   >> make run_test 
    //----------------------------------------------
    return 0; // modify or replace this line
}

int totalPVs(State* states, int szStates) {
    //--------------------------------------------------   
    // TODO: Task 6 - write the totalPVs() function;
    //                then, write your own test function 
    //                test_totalPVs() in test.c
    //                   >> make build_test
    //                   >> make run_test 
    //--------------------------------------------------
    return 0; // modify or replace this line
}

MinInfo minPopVoteAtLeast(State* states, int szStates, int start, int EVs) {
    //----------------------------------------------   
    // TODO: Task 7 - write minPopVoteAtLeast();
    //                a recursive helper function;
    //                returns MinInfo for the subset
    //                of [states] from index [start]
    //                to the end with the minimum
    //                popular vote total that has 
    //                sufficient [EVs] to win
    //---------------------------------------------- 
    MinInfo res; // modify or replace this line
    return res; // modify or replace this line
}

MinInfo minPopVoteToWin(State* states, int szStates) {
    int totEVs = totalEVs(states,szStates);
    int reqEVs = totEVs/2 + 1; // required EVs to win election
    return minPopVoteAtLeast(states, szStates, 0, reqEVs);
}

MinInfo minPopVoteAtLeastFast(State* states, int szStates, int start, int EVs, MinInfo** memo) {
    //----------------------------------------------   
    // TODO: Task 8 - write minPopVoteAtLeastFast();
    //                start by copying in fully
    //                functioning code from 
    //                minPopVoteAtLeast() and make
    //                additions for memoization
    //---------------------------------------------- 
    MinInfo res; // modify or replace this line
    return res; // modify or replace this line
}

MinInfo minPopVoteToWinFast(State* states, int szStates) {
    int totEVs = totalEVs(states,szStates);
    int reqEVs = totEVs/2 + 1; // required EVs to win election

    MinInfo** memo = (MinInfo**)malloc((szStates+1)*sizeof(MinInfo*));
    for (int i = 0; i < szStates+1; ++i) {
        memo[i] = (MinInfo*)malloc((reqEVs+1)*sizeof(MinInfo));
        for (int j = 0; j < reqEVs+1; ++j) {
            memo[i][j].subsetPVs = -1;
        }
    }
    MinInfo res = minPopVoteAtLeastFast(states, szStates, 0, reqEVs, memo);
    
    //----------------------------------------------   
    // TODO: Task 8 - [memo] will go out of scope 
    //                upon return, so free all
    //                heap-allocated memory for 
    //                [memo] before return 
    //---------------------------------------------- 

    return res;
}

bool writeSubsetData(char* filenameW, int totEVs, int totPVs, int wonEVs, MinInfo toWin) {
    //-----------------------------------------------------   
    // TODO: Task 9 - write the writeSubsetData() function
    //-----------------------------------------------------
    return false; //modify or replace this
}
