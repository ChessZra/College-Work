#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>

#include "MinPopVote.h"

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

bool test_minPVsSlow() {
    //----------------------------------------------------------------- 
    // TODO: Task 7 - write your own test case for minPopVoteAtLeast();
    //                make sure to test all components
    //-----------------------------------------------------------------
    return false; //modify this
}

bool test_minPVsFast() {
    //--------------------------------------------------------------------- 
    // TODO: Task 8 - write your own test case for minPopVoteAtLeastFast();
    //                make sure to test all components
    //---------------------------------------------------------------------
    return false; //modify this
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
