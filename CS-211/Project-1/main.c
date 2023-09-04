/*-------------------------------------------
Program 1: Elementary Cellular Automaton
Course: CS 211, Fall 2023, UIC
System: Advanced zyLab
Author: John Ezra See
------------------------------------------- */

#include <stdio.h>
#include <stdbool.h> 

const int WORLD_SIZE = 65;

typedef struct cell_struct{
    bool state[3]; //active status for [left, me, right] cells 
    bool active; //current active status for this cell
} cell;

//convert an 8-bit integer rule (0-255) to array of bits 
//(stored in reverse order)
//   ex: rule = 6  = 00000110 -> [01100000] 
//   ex: rule = 30 = 00011110 -> [01111000] 
//   ex: rule = 65 = 01000001 -> [10000010]
//return true if input rule is valid (0-255)
//return false if input rule is invalid
bool setBitArray(bool bitArray[8], int rule) {

        //TODO: Task 1 - write the setBitArray() function

        return false;
}

//convert a 3-bit state array to its 
//associated index of the rule# bit array
//   ex: {0 0 0} -> 0
//   ex: {0 0 1} -> 1
//   ex: {1 0 1} -> 5
int stateToIndex(bool state[3]) {

    //TODO: Task 4 - write the stateToIndex() function

    return 0;
}

//update the state array for each cell in the world array based on the
//current status of active for the nearby [left,me,right] cells
//note: world is assumed periodic/cyclic,
//with front-to-back and back-to-front wrapping 
void setStates(cell world[WORLD_SIZE]) {

    //TODO: Task 5 - write the setStates() function

    return;
}

//evolve each cell's active status to the next generation 
//  using its state array
//ruleBitArray contains the 8-bits for the rule#, 
//  stored in reverse order
void evolveWorld(cell world[WORLD_SIZE], bool ruleBitArray[8]) {

    //TODO: Task 7 - write the evolveWorld() function

    return;
}


int main() {
    cell world[WORLD_SIZE];

    printf("Welcome to the Elementary Cellular Automaton!\n");

    //TODO: Task 2 - read in a valid rule# and
    //      generate the rule's 8-bit rule bit array 
    //      print the bit array in correct binary number order
    int ruleNum = -1;
    while (ruleNum < 0 || ruleNum > 255) {
        printf("Enter the rule # (0-255): ");
        scanf("%d", &ruleNum);
    }
    printf("Success %d\n", ruleNum);

    //TODO: Task 3 - use the rule bit array to report the evolution 
    //      step for all possible cell states.
    //      follow the format of the sample output exactly


    //TODO: Task 6 - read in the total number of generation evolution 
    //      steps from the user and initialize the world with ONLY the 
    //      middle cell active, all other cells should be inactive; 
    //      make sure to set the state array for each cell.
    
    printf("Initializing world & evolving...\n");


    //TODO: Task 8 - evolve the world the user-specified number  
    //      of generations, printing each active cell as '*' and
    //      each non-active cell as ' ' (whitespace) after each
    //      evolution step to the next generation

    return 0;
}