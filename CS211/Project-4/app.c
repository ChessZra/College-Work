//-----------------------------------------
// Popular Vote Minimizer Application
// Author: Prof. Scott Reckinger
// Course: CS 211 - Programming Practicuum
// Term: Fall 2023
// Assignment: Project 04
//-----------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include "MinPopVote.h"

// printing State data members, all items on one line 
// Ex: Illinois (IL): 20 EVs, 6033744 PVs
void printState(State myState) {
    printf("  %s (%s): %d EVs, %d PVs\n",myState.name,myState.postalCode,myState.electoralVotes,myState.popularVotes);
}

// printing State data members, all items on one line 
//  PVs printed here are minimum number of popular votes  
//  needed to win the state's electoral votes
// Ex: Illinois (IL): 20 EVs, 3016873 PVs
void printStatePVsToWin(State myState) {
    printf("  %s (%s): %d EVs, %d PVs\n",myState.name,myState.postalCode,myState.electoralVotes,myState.popularVotes/2+1);
}

// helpful function for printing the status of a bool input
void printONorOFF(bool flag) {
    if (flag) {
        printf("ON\n");
    } else {
        printf("OFF\n");
    }
}

int main(int argc, char* argv[]) {
    printf("Welcome to the Popular Vote Minimizer Application!\n\n");
    
    bool fastMode = false;
    bool quietMode = false;
    int year = 0;

    // command-line argument settings
    // [-y year] = sets the election year for the program
    //                  valid [year] values are perfect multiples of 4,
    //                  between 1828 and 2020, inclusively; 
    //                  default is 0 ([year] then set by user-input later)   
    // [-q] = quiet mode; if ON, do not print the full State list read-in
    //                    from file AND do no print the subset of States
    //                    needed to win with minimum popular votes
    //                    default is OFF
    // [-f] = fast mode; if ON, use the "fast" version of the functions
    //                   that include memoization to find the minimum 
    //                   number of popular votes to win the election
    //                   default is OFF
    // these arguments are optional to run program; if any is absent,
    //  then use the default value
    if (!setSettings(argc, argv, &year, &fastMode, &quietMode)) {
        printf("Invalid command-line argument.\n");
        printf("Terminating program...\n");
        return -1;
    }

    // if year is not set by command-line arguments, 
    //  then set it using interactive user-input;
    //  year must be between 1828 and 2020, inclusive
    if (year == 0) {
        printf("Enter the year: \n");
        scanf("%d",&year);
        while (year < 1828 || year > 2020 || year % 4 != 0) {
            if (year == 1789 || ((year % 4 == 0) && (year >= 1792) && (year <= 1824))) {
                printf("  Insufficient election data for the U.S. Presidential Election held in %d.\n",year);            
            } else {
                printf("  There was no U.S. Presidential Election held in %d.\n",year);
            }
            printf("Enter the year: \n");
            scanf("%d",&year);
        }
    }
    
    // generate filepath for the input election data file for reading
    //  format for filename = "data/[year].csv"
    char filename[100];
    inFilename(filename,year); 

    // generate filepath for the output election data file for writing
    //  format for filename = "toWin/[year]_win.csv"
    char filenameW[100];
    outFilename(filenameW,year); 
    
    // display the program settings   
    printf("\n");
    printf("Settings:\n");
    printf("  year = %d\n", year);
    printf("  quiet mode = ");
    printONorOFF(quietMode);
    printf("  fast mode = ");
    printONorOFF(fastMode);
    printf("  input data file = %s\n", filename);
    printf("  output data file = %s\n", filenameW);

    // read election data file to create [allStates] array, 
    //  which is a static array with capacity 51, but the
    //  actual size of the array is [nStates] 
    State allStates[51];
    int nStates;
    if(!readElectionData(filename,allStates,&nStates)) {
        printf("Invalid filename %s. \nNo file found. \nTerminating program...\n",filename);
        return -1;
    } 
        
    // display full list of States (only if not in quiet mode)
    if (!quietMode) {
        printf("\n");
        printf("Election data for all states:\n");
        for (int i = 0; i < nStates; ++i) {
            printState(allStates[i]);
        }
    }

    // solve the "central question" by calculating the minimum
    //  number of popular votes to win the election
    printf("\n");
    printf("Calculating Minimum Popular Votes to Win...\n");
    MinInfo toWin;
    if (fastMode) {
        toWin = minPopVoteToWinFast(allStates, nStates);
    } else {
        toWin = minPopVoteToWin(allStates, nStates);
    }

    // display the list of States in the subset that produces
    //  the minimum total popular votes, but still wins election.
    //  Note: PVs printed here are the required number of popular
    //  votes needed in each state to win its electoral votes.
    if (!quietMode) {
        printf("\n");
        printf("States in the minimum-PV, sufficient-EV subset:\n");
        for (int i = 0; i < toWin.szSomeStates; ++i) {
            printStatePVsToWin(toWin.someStates[toWin.szSomeStates-i-1]);
        }
    }   
    int totEVs = totalEVs(allStates,nStates);
    int wonEVs = totalEVs(toWin.someStates,toWin.szSomeStates);
    int reqEVs = totEVs/2 + 1;
    int totPVs = totalPVs(allStates,nStates);
    
    // display statistics winning the election 
    //  with minimum number of popular votes
    printf("\n");
    printf("Statistical Summary: \n");
    printf("  Total EVs = %d\n",totEVs);
    printf("  Required EVs = %d\n",totEVs/2+1);
    printf("  EVs won = %d\n",wonEVs);
    printf("  Total PVs = %d\n",totPVs);
    printf("  PVs Won = %d\n",toWin.subsetPVs);
    printf("  Minimum Percentage of Popular Vote to Win Election = %0.2lf%%\n\n",100.0*toWin.subsetPVs/totPVs);

    printf("\n");
    printf("Writing the minimum-PV winning subset of States data to %s...\n",filenameW);
    
    // write the minimum-PV winning subset of States file, 
    //  format is one State per line: 
    //      [name],[postalCode],[EVs],[minPVsToWin]
    //  Note that minPVsToWin is the minimum popular votes
    //  needed to win the state's electoral votes
    writeSubsetData(filenameW, totEVs, totPVs, wonEVs, toWin);

    printf("\n");

    return 0;
}
