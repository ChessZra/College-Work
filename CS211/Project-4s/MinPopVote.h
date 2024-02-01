/* template for .h file */

/* put any #define statements here */
#ifndef MINPOPVOTE_H_
#define MINPOPVOTE_H_

/* put any structure declarations here */
typedef struct State_struct {
    char name[50];      // the name of the state, e.g. Illinois
    char postalCode[3]; // the postal code of state, e.g. IL
    int electoralVotes; // how many electors the state has
    int popularVotes;   // number of people who voted
} State;

typedef struct MinInfo_struct {
    State someStates[51]; // a subset of states
    int szSomeStates;     // number of states in this subset
    int subsetPVs;     // number of popular votes for subset
    bool sufficientEVs; // true = subset has enough electoral votes to win
} MinInfo;

/* list any needed function prototypes here */
void inFilename(char* filename, int year);
void outFilename(char* filename, int year);
bool setSettings(int argc, char** argv, int* year, bool* fastMode, bool* quietMode);
bool parseLine(char* line, State* myState);
bool readElectionData(char* filename, State* allStates, int* nStates);
bool writeSubsetData(char* filenameW, int totEVs, int totPVs, int wonEVs, MinInfo toWin);
int totalEVs(State* states, int szStates);
int totalPVs(State* states, int szStates);
MinInfo minPopVoteAtLeast(State* states, int szStates,  int start, int EVs);
MinInfo minPopVoteToWin(State* states, int szStates);
MinInfo minPopVoteAtLeastFast(State* states, int szStates, int start, int EVs, MinInfo** memo);
MinInfo minPopVoteToWinFast(State* states, int szStates); 

#endif