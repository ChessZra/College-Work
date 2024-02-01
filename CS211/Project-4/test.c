// File: test.c
// Description: A unit test file to test the functions located in MinPopVote.c
// Last modified: 10/15/2023

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>

#include "MinPopVote.h"

// Unit Test: Checks totalEVs() function:
bool test_totalEVs() {
    State aStates[10];
    int res;
    
    aStates[0].electoralVotes = 5;
    aStates[1].electoralVotes = 8;
    aStates[2].electoralVotes = 12;
    aStates[3].electoralVotes = 6;
    aStates[4].electoralVotes = 7;
    aStates[5].electoralVotes = 10;

    printf(" Checking totalEVs() for 5 States:\n");
    res = totalEVs(aStates,5);
    if (res != 38) {
        printf("  individual state EVs are 5, 8, 13, 6, 7\n");
        printf("  expected total EVs = 38, actual total EVs = %d\n",res);
        return 0;
    }

    aStates[0].electoralVotes = 5;
    aStates[1].electoralVotes = 8;
    aStates[2].electoralVotes = 12;
    aStates[3].electoralVotes = 6;
    aStates[4].electoralVotes = 7;
    aStates[5].electoralVotes = 15;
    aStates[6].electoralVotes = 12;
    aStates[7].electoralVotes = 8;
    aStates[8].electoralVotes = 14;
    aStates[9].electoralVotes = 13;
    
    printf(" Checking totalEVs() for 10 States:\n");
    res = totalEVs(aStates,10);
    if (res != 100) {
        printf("  expected total EVs = 100, actual total EVs = %d\n",res);
        return false;
    }

    return true;
}

// Unit Test: Checks totalPVs() function
// Utilizes the arithmetic sequence to predict the answer of 512 states:
bool test_totalPVs() {
    printf(" Checking totalPVs() for 512 States:\n");

    State aStates[512];
    int ret = 0;

    for (int i = 0; i < 512; i++) { 
        aStates[i].popularVotes = i;
    }
    ret = totalPVs(aStates, 512);

    // In the form n(n + 1)/2 where n = 511, arithmetic series
    int expected = (511 * 512) / 2;
    if (ret != expected) { 
        printf("  Individual state PVs are 0 1 2 3 ... 511");
        printf("  Expected value %d, actual: %d\n", expected, ret);
        return false;
    }

    return true; 
}

// Unit Test: Checks setSettings() function
// Checks for both valid and invalid inputs:
bool test_setSettings() {
    int year = 0;
    bool fastMode = false, quietMode = false;
    
    printf(" Checking setSettings() VALID Input:\n");
    // Valid setting configuration:
    char* config[] = {"./test.exe", "-f", "-q", "-y", "2020"};
    bool res = setSettings(5, config, &year, &fastMode, &quietMode);

    if (!res) {
        printf("  Expected return true.");
        return false;
    }

    printf(" Checking setSettings() INVALID Input:\n");
    // Invalid setting configuration:
    char* config2[] = {"./test.exe", "-f", "-v", "-y", "2020"};
    res = setSettings(5, config2, &year, &fastMode, &quietMode);
    if (res) {
        printf("  Expected return false.");
        return false;
    }

    return true; 
}

// Unit Test: Checks inFilename() function:
bool test_inFilename() {
    char fileName[15];
    
    printf(" Checking year 2048:\n");
    inFilename(fileName, 2048);
    if (strcmp(fileName, "data/2048.csv") == 0) {
        printf("  Expected: data/2048.csv, actual: %s\n", fileName);
    } else {
        printf("  Expected: data/2048.csv, actual: %s\n", fileName);
        return false;
    }

    printf(" Checking year 1844:\n");
    inFilename(fileName, 1844);
    if (strcmp(fileName, "data/1844.csv") == 0) {
        printf("  Expected: data/1844.csv, actual: %s\n", fileName);
    } else {
        printf("  Expected: data/1844.csv, actual: %s\n", fileName);
        return false;
    }

    return true;
}

// Unit Test: Checks outFilename() function:
bool test_outFilename() {
    char fileName[30];
    
    printf(" Checking year 2048:\n");
    outFilename(fileName, 2048);
    if (strcmp(fileName, "toWin/2048_win.csv") == 0) {
        printf("  Expected: toWin/2048_win.csv, actual: %s\n", fileName);
    } else {
        printf("  Expected: toWin/2048_win.csv, actual: %s\n", fileName);
        return false;
    }

    printf(" Checking year 1844:\n");
    outFilename(fileName, 1844);
    if (strcmp(fileName, "toWin/1844_win.csv") == 0) {
        printf("  Expected: toWin/1844_win.csv, actual: %s\n", fileName);
    } else {
        printf("  Expected: toWin/1844_win.csv, actual: %s\n", fileName);
        return false;
    }
    
    return true;
}

// Unit Test: Checks parseLine() function
// Checks for both valid and invalid inputs:
bool test_parseLine() {
    char invalidLine[] = "Virginia,VA 17,95539";
    char validLine[] = "Pennsylvania,PA,26,331572";

    State myState;
    bool res = parseLine(invalidLine, &myState);

    printf(" Testing input, Virginia,VA 17,95539\n");
    if (res) {
        printf("  Failed input Virginia,VA 17,95539: Expected false\n");
        return false;
    }

    State myState2;
    res = parseLine(validLine, &myState2);

    printf(" Testing input, Pennsylvania,PA,26,331572\n");
    if (!res) {
        printf("  Failed input Pennsylvania,PA,26,331572: Expected true\n");
        return false;
    }

    if (strcmp(myState2.name, "Pennsylvania") != 0) {
        printf("  Failed input Pennsylvania,PA,26,331572: Incorrect name.\n");
        return false;
    }
    if (strcmp(myState2.postalCode, "PA") != 0) {
        printf("  Failed input Pennsylvania,PA,26,331572: Incorrect postalCode.\n");
        return false;
    }
    if (myState2.electoralVotes != 26) {
        printf("  Failed input Pennsylvania,PA,26,331572: Incorrect electoral votes.\n");
        return false;
    } 
    if (myState2.popularVotes != 331572) {
        printf("  Failed input Pennsylvania,PA,26,331572: Incorrect popular votes.\n");
        return false;
    } 


    return true;
}

// Unit Test: Checks readElectionData() function
// Checks if the election data is read properly by analyzing States array:
bool test_readElectionData() {
    printf(" Testing input file data/1844.csv\n");
    State allStates[51];
    int nStates;
    char filename[] = "data/1844.csv";
    readElectionData(filename,allStates,&nStates);

    if (nStates != 26) {
        printf("  Incorrect nStates value. Expected 26, actual: %d\n", nStates);
        return false;
    }

    for (int i = 0; i < nStates; i++) {
        // The name characters should always be an alphabet or a space:
        for (int j = 0; allStates[i].name[j] != '\0'; j++) {
            if (!isalpha(allStates[i].name[j]) && allStates[i].name[j] != ' ') {
                printf("  Expected an alphabetical character, actual: %c\n", 
                        allStates[i].name[j]);
                return false;
            }
        }

        // The postalCode characters should always be an alphabet:
        for (int j = 0; allStates[i].postalCode[j] != '\0'; j++) {
            if (!isalpha(allStates[i].postalCode[j])) {
                printf("  Expected an alphabetical character, actual: %c\n", 
                        allStates[i].postalCode[j]);
                return false;
            }
        }
    }

    return true; 
}

// Unit Test: Checks minPopVoteToWin() function
// Checks the brute force algorithm:
bool test_minPVsSlow() {
    printf(" Testing input with three states:\n");
    State states[4];
    strcpy(states[0].name, "Illinois");
    strcpy(states[0].postalCode, "IL");
    states[0].electoralVotes = 5;
    states[0].popularVotes = 50;

    strcpy(states[1].name, "Alabama");
    strcpy(states[1].postalCode, "AL");
    states[1].electoralVotes = 8;
    states[1].popularVotes = 25;

    strcpy(states[2].name, "Texas");
    strcpy(states[2].postalCode, "TX");
    states[2].electoralVotes = 20;
    states[2].popularVotes = 85;

    MinInfo result = minPopVoteToWin(states, 3);
    if (result.subsetPVs != 43 || result.sufficientEVs == false) {
        printf("  Incorrect subsetPVs or sufficientEVs value.\n");
        printf("  Expected result.subsetPVs = 43, result.sufficientEVs = true.\n");
        printf("  Actual: result.subsetPVs = %d, result.sufficientEVs = %d\n",
                result.subsetPVs, result.sufficientEVs);
        return false;
    } 
    return true;
}

// Unit Test: Checks minPopVoteToWinFast() function
// Checks the optimized algorithm:
bool test_minPVsFast() {
    
    printf(" Testing input with four states:\n");
    State states2[4];
    strcpy(states2[0].postalCode, "AA");
    states2[0].electoralVotes = 5;
    states2[0].popularVotes = 60;

    strcpy(states2[1].postalCode, "BB");
    states2[1].electoralVotes = 2;
    states2[1].popularVotes = 20;

    strcpy(states2[2].postalCode, "CC");
    states2[2].electoralVotes = 8;
    states2[2].popularVotes = 70;

    strcpy(states2[3].postalCode, "DD");
    states2[3].electoralVotes = 3;
    states2[3].popularVotes = 30;

    MinInfo result = minPopVoteToWinFast(states2, 4);
    if (result.subsetPVs != 47 || result.sufficientEVs == false) {
        printf("  Incorrect subsetPVs or sufficientEVs value.\n");
        printf("  Expected result.subsetPVs = 47, result.sufficientEVs = true.\n");
        printf("  Actual: result.subsetPVs = %d, result.sufficientEVs = %d\n",
                result.subsetPVs, result.sufficientEVs);
        return false;
    } 
    
    return true;
}

int main() {
    printf("Welcome to the Popular Vote Minimizer Testing Suite!\n\n");
    
    printf("Testing totalEVs()...\n"); 
    if (test_totalEVs()) {
        printf("  All tests PASSED!\n");
    } else {
        printf("  test FAILED.\n");
    }

    printf("Testing totalPVs()...\n"); 
    if (test_totalPVs()) {
        printf("  All tests PASSED!\n");
    } else {
        printf("  test FAILED.\n");
    }

    printf("Testing setSettings()...\n"); 
    if (test_setSettings()) {
        printf("  All tests PASSED!\n");
    } else {
        printf("  test FAILED.\n");
    }
    
    printf("Testing inFilename()...\n"); 
    if (test_inFilename()) {
        printf("  All tests PASSED!\n");
    } else {
        printf("  test FAILED.\n");
    }

    printf("Testing outFilename()...\n"); 
    if (test_outFilename()) {
        printf("  All tests PASSED!\n");
    } else {
        printf("  test FAILED.\n");
    }

    printf("Testing parseLine()...\n"); 
    if (test_parseLine()) {
        printf("  All tests PASSED!\n");
    } else {
        printf("  test FAILED.\n");
    }

    printf("Testing readElectionData()...\n"); 
    if (test_readElectionData()) {
        printf("  All tests PASSED!\n");
    } else {
        printf("  test FAILED.\n");
    }
    
    printf("Testing minPopVoteToWin()...\n"); 
    if (test_minPVsSlow()) {
        printf("  All tests PASSED!\n");
    } else {
        printf("  test FAILED.\n");
    }

    printf("Testing minPopVoteToWinFast()...\n"); 
    if (test_minPVsFast()) {
        printf("  All tests PASSED!\n");
    } else {
        printf("  test FAILED.\n");
    }

    return 0;
}
