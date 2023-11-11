// File: MinPopVote.c
// Description: A helper module for app.c
// Last modified: 10/15/2023

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include "MinPopVote.h"

// Initializes the settings for the program:
bool setSettings(int argc, char** argv, int* year, bool* fastMode, bool* quietMode) {
    // Sample processing of command-line arg...
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
            if (atoi(argv[i + 1]) % 4 == 0 && atoi(argv[i + 1]) >= 1828 && 
                atoi(argv[i + 1]) <= 2020) {
                *year = atoi(argv[i + 1]);
            } else {
                *year = 0;
            }
            i += 1;
        } else {
            return false;
        }
    }
    return true; 
}

// Changes the input filename parameter based on the given year:
void inFilename(char* filename, int year) {
    snprintf(filename, 50, "data/%d.csv", year);
    return;
}

// Changes the output filename parameter based on the given year:
void outFilename(char* filename, int year) {
    snprintf(filename, 50, "toWin/%d_win.csv", year);
    return;
}

// A helper function: parses a singular line to create the struct State:
bool parseLine(char* line, State* myState) {
    // General variables:
    int idx = 0, numberOfCommas = 0, i; 
    // Temporary variables:
    char nameOfState[50], postCode[3], electVotes[5], popVotes[15];

    // Check if line is valid:
    for (i = 0; line[i] != '\0'; i++) {
        if (line[i] == ',') {
            numberOfCommas += 1;
        }
    }
    if (numberOfCommas != 3) return false;

    for (i = 0; line[idx] != ','; i++) { // Parse name, (e.g Illinois):
        nameOfState[i] = line[idx];
        idx += 1;
    }
    nameOfState[i] = '\0';
    idx += 1;

    for (i = 0; line[idx] != ','; i++) { // Parse code, (e.g IL):
        postCode[i] = line[idx];
        idx += 1;
    }
    postCode[i] = '\0';
    idx += 1;

    for (i = 0; line[idx] != ','; i++) { // Parse electoral votes, (e.g 15):
        electVotes[i] = line[idx];
        idx += 1;
    } 
    electVotes[i] = '\0';
    idx += 1;

    for (i = 0; line[idx] != '\0' && line[idx] != '\n'; i++) { // Parse popular
                                                        // votes, (e.g 512521):
        popVotes[i] = line[idx];
        idx += 1;
    }    
    popVotes[i] = '\0';

    strcpy(myState->name, nameOfState);
    strcpy(myState->postalCode, postCode);
    myState->electoralVotes = atoi(electVotes);
    myState->popularVotes = atoi(popVotes);

    return true;
}

// The function to build the array of states called allStates by reading the election
// data located in data/...:
bool readElectionData(char* filename, State* allStates, int* nStates) {
    FILE* inputFile = fopen(filename, "r");
    
    if (inputFile == NULL) 
        return false;

    char buffer[1024];
    *nStates = 0;
    while (fgets(buffer, 1024, inputFile)) {
        parseLine(buffer, &allStates[*nStates]);
        *nStates += 1;
    }
    fclose(inputFile);
    return true; 
}

// Returns the total electoral votes in the states array:
int totalEVs(State* states, int szStates) {
    int ret = 0;
    for (int i = 0; i < szStates; i++) {
        ret += states[i].electoralVotes;
    }
    return ret;
}

// Returns the total popular votes in the states array:
int totalPVs(State* states, int szStates) {
    int ret = 0;
    for (int i = 0; i < szStates; i++) {
        ret += states[i].popularVotes;
    }
    return ret;
}

// A helper recursive function: utilizes the backtracking algorithm to find the
// minimum popular vote using the brute force approach:
MinInfo minPopVoteAtLeast(State* states, int szStates, int start, int EVs) {
    // Base case: we reached the end of the tree:
    if (start == szStates || EVs <= 0) {
        MinInfo emptySubset;
        emptySubset.szSomeStates = 0;
        emptySubset.subsetPVs = 0;
        emptySubset.sufficientEVs = (EVs <= 0);
        return emptySubset;
    }

    // Include the current state in the subset:
    MinInfo include = minPopVoteAtLeast(states, szStates, start + 1,
                                        EVs - states[start].electoralVotes);
    include.someStates[include.szSomeStates] = states[start];
    include.szSomeStates += 1;
    include.subsetPVs += states[start].popularVotes / 2 + 1;

    // Exclude the current state from the subset:
    MinInfo exclude = minPopVoteAtLeast(states, szStates, start + 1, EVs);
    
    // Compare and return the subset with the minimum popular vote:
    if (include.sufficientEVs && 
       (!exclude.sufficientEVs || include.subsetPVs < exclude.subsetPVs)) {
        return include;
    } else {
        return exclude;
    }
}

// A wrapper function that gets called to find the minimum popular vote:
MinInfo minPopVoteToWin(State* states, int szStates) {
    int totEVs = totalEVs(states,szStates);
    int reqEVs = totEVs/2 + 1; // required EVs to win election
    return minPopVoteAtLeast(states, szStates, 0, reqEVs);
}

// A helper memo function: utilizes dynamic programming (memoization) to efficiently
// calculate the minimum popular vote:
MinInfo minPopVoteAtLeastFast(State* states, int szStates, int start, int EVs, 
                              MinInfo** memo) {
    // Base case: we reached the end of the tree:
    if (start == szStates || EVs <= 0) {
        MinInfo emptySubset;
        emptySubset.szSomeStates = 0;
        emptySubset.subsetPVs = 0;
        emptySubset.sufficientEVs = (EVs <= 0);
        return emptySubset;
    }

    // Memoization:
    if (memo[start][EVs].subsetPVs != -1) return memo[start][EVs];

    // Include the current state in the subset:
    MinInfo include = minPopVoteAtLeastFast(states, szStates, start + 1,
                                            EVs - states[start].electoralVotes, 
                                            memo);
    include.someStates[include.szSomeStates] = states[start];
    include.szSomeStates += 1;
    include.subsetPVs += states[start].popularVotes / 2 + 1;
    
    // Exclude the current state from the subset:
    MinInfo exclude = minPopVoteAtLeastFast(states, szStates, start + 1, EVs, memo);

    if (include.sufficientEVs && 
       (!exclude.sufficientEVs || include.subsetPVs < exclude.subsetPVs)) {
        memo[start][EVs] = include;
        return include;
    } else {
        memo[start][EVs] = exclude;
        return exclude;
    }
}

// A wrapper function that gets called to find the minimum popular vote:
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
    for (int i = 0; i < szStates+1; ++i) {
        free(memo[i]);
    }
    free(memo);

    return res;
}

// Writes the output data after the program execution:
bool writeSubsetData(char* filenameW, int totEVs, int totPVs, int wonEVs, 
                     MinInfo toWin) {
    FILE* outputFile = fopen(filenameW, "w");
    fprintf(outputFile, "%d,%d,%d,%d\n", totEVs, totPVs, wonEVs, toWin.subsetPVs);
    for (int i = toWin.szSomeStates - 1; i >= 0; i--) {
        fprintf(outputFile, "%s,%s,%d,%d\n", toWin.someStates[i].name, 
                toWin.someStates[i].postalCode, toWin.someStates[i].electoralVotes,
                toWin.someStates[i].popularVotes / 2 + 1);
    }
    fclose(outputFile);
    return true;
}
