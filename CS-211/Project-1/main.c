/*-------------------------------------------
Program 1: Elementary Cellular Automaton
Course: CS 211, Fall 2023, UIC
System: Advanced zyLab
Author: John Ezra See
------------------------------------------- */

#include <stdio.h>
#include <stdbool.h> 
#include <math.h> 

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
        if (rule < 0 || rule > 255) return false;

        //TODO: Task 1 - write the setBitArray() function
        int idx = 0;
        for (int i = 0; i < 8; i++) {
            bitArray[idx] = (1 & rule) == 1;
            rule >>= 1;
            idx++;
        }
  
        return true;
}

//convert a 3-bit state array to its 
//associated index of the rule# bit array
//   ex: {0 0 0} -> 0
//   ex: {0 0 1} -> 1
//   ex: {1 0 1} -> 5
int stateToIndex(bool state[3]) {

    //TODO: Task 4 - write the stateToIndex() function
    // Since there are only three bits, for-loop is not necessary.
    int ret = 0;
    if (state[0]) {
        ret += 4;
    }
    if (state[1]) {
        ret += 2;
    }
    if (state[2]) {
        ret += 1;
    }

    return ret;
}

//update the state array for each cell in the world array based on the
//current status of active for the nearby [left,me,right] cells
//note: world is assumed periodic/cyclic,
//with front-to-back and back-to-front wrapping 
void setStates(cell world[WORLD_SIZE]) {

    //TODO: Task 5 - write the setStates() function
    // This loop traverses the cell from left to right
    // For every cell, check its left and right neighbors (w/ wrapping)
    // Then update the state array
    for (int i = 0; i < WORLD_SIZE; i++) {
        int left = i - 1;
        int right = i + 1;
        if (left == -1) 
            left = WORLD_SIZE - 1;
        if (right == WORLD_SIZE)
            right = 0;
        
        world[i].state[0] = world[left].active;
        world[i].state[1] = world[i].active;
        world[i].state[2] = world[right].active;
    }
    return;
}

//evolve each cell's active status to the next generation 
//  using its state array
//ruleBitArray contains the 8-bits for the rule#, 
//  stored in reverse order
void evolveWorld(cell world[WORLD_SIZE], bool ruleBitArray[8]) {

    //TODO: Task 7 - write the evolveWorld() function
    // This loop will create the new generation world
    // based on the rule and states
    cell newWorld[WORLD_SIZE];
    for (int i = 0; i < WORLD_SIZE; i++) {
        bool states[3] = {world[i].state[0], world[i].state[1], world[i].state[2]};
        newWorld[i].active = false;
        if (ruleBitArray[stateToIndex(states)]) 
            newWorld[i].active = true;
    }
    setStates(newWorld);
    
    // This for-loop simply copies newWorld to world
    // since newWorld = world is not permitted in C
    for (int i = 0; i < WORLD_SIZE; i++) {
        world[i] = newWorld[i];
    }

    return;
}

// This function will keep on asking for a rule number
// that satisfies [0, 255] - modifies the parameter
void readValidRule(int* ruleRef) {
    int rule = -1;
    while (rule < 0 || rule > 255) {
        printf("Enter the rule # (0-255): ");
        scanf("%d", &rule);
    }
    *ruleRef = rule;
}

// This prints the associated bit array for the read rule number
// For example, "The bit array for rule #30 is 00011110"
void printBitArray(bool bitArray[8], int rule) {
    printf("\nThe bit array for rule #%d is ", rule);
    for (int i = 7; i >= 0; i--) {
        printf("%d", bitArray[i]);
    }
    printf("\n\n");
}

// This prints the possible states
// by looping through the bit array (e.g [01] -> | |   |*|)
void printPossibleStates(bool bitArray[8]) {
    printf(" ");
    for (int i = 7; i >= 0; i--) {
        if (bitArray[i]) {
            printf("|*|");
        } else {
            printf("| |");
        }
        if (i > 0) {
            printf("     ");
        }
    }
    printf(" \n\n");
}

int main() {
    cell world[WORLD_SIZE];

    printf("Welcome to the Elementary Cellular Automaton!\n");

    //TODO: Task 2 - read in a valid rule# and
    //      generate the rule's 8-bit rule bit array 
    //      print the bit array in correct binary number order
    bool bitArray[8] = {0};
    int rule;
    readValidRule(&rule);
    setBitArray(bitArray, rule);
    printBitArray(bitArray, rule);

    //TODO: Task 3 - use the rule bit array to report the evolution 
    //      step for all possible cell states.
    //      follow the format of the sample output exactly
    printf("The evolution of all possible states are as follows:\n"
           "|***|   |** |   |* *|   |*  |   | **|   | * |   |  *|   |   |\n");
    printPossibleStates(bitArray);

    //TODO: Task 6 - read in the total number of generation evolution 
    //      steps from the user and initialize the world with ONLY the 
    //      middle cell active, all other cells should be inactive; 
    //      make sure to set the state array for each cell.
    int numGenerations;
    printf("Enter the number of generations: ");
    scanf("%d", &numGenerations);
    for (int i = 0; i < WORLD_SIZE; i++) {
        if (i == 32) {
            world[i].active = true;
        } else {
            world[i].active = false;
        }
    }
    setStates(world);
    printf("\nInitializing world & evolving...\n");
    printf("                                *                                \n");

    //TODO: Task 8 - evolve the world the user-specified number  
    //      of generations, printing each active cell as '*' and
    //      each non-active cell as ' ' (whitespace) after each
    //      evolution step to the next generation

    // repeat the evolution by the given number of times 
    for (int i = 0; i < numGenerations - 1; i++) { 
        evolveWorld(world, bitArray); // evolve to get the modified and updated world

        // print the resulting world
        for (int j = 0; j < WORLD_SIZE; j++) {
            if (world[j].active) {
                printf("*");
            }
            else {
                printf(" ");
            }
        }

        printf("\n");
    }
    
    return 0;
}