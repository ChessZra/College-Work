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

typedef struct cell_struct {
    bool state[3]; // Active status for [left, me, right] cells 
    bool active;   // Current active status for this cell
} cell;

/**
 * @brief: Convert an 8-bit integer rule (0-255) to array of bits.
 *         (stored in reverse order)
 *         ex: rule = 6  = 00000110 -> [01100000] 
 *         ex: rule = 30 = 00011110 -> [01111000] 
 *         ex: rule = 65 = 01000001 -> [10000010]
 * 
 * @param bitArray: An array of boolean representing a byte (8 bits) in reversed form.
 * @param rule: An integer representing the rule number which is to be converted.
 * 
 * @return: true if input is valid (0-255) inclusive
 *         false if input is invalid
 */
bool setBitArray(bool bitArray[8], int rule) {
        // Case - invalid rule input:
        if (rule < 0x0 || rule > 0xFF) return false;
        
        // set bitArray[8]
        for (int i = 0; i < 8; rule >>= 1) {
            bitArray[i++] = (0x1 & rule);
        }

        return true;
}

/**
 * @brief: Convert a 3-bit state array to its 
 *         associated index of the rule# bit array.
 *         ex: {0 0 0} -> 0
 *         ex: {0 0 1} -> 1
 *         ex: {1 0 1} -> 5 
 * 
 * @param state: An array of boolean representing three bits.
 *
 * @return: An integer representing the decimal representation of state.
 */
int stateToIndex(bool state[3]) {
    int ret = 0;
    if (state[0]) ret += 4;
    if (state[1]) ret += 2;
    if (state[2]) ret += 1;
    return ret;
}

/**
 * @brief: Update the state array for each cell in the world array based on the
 *         Current status of active for the nearby [left,me,right] cells.
 *
 * This function updates the state array for each cell in the world array based
 * on the current status of active for the nearby [left,me,right] cells.
 * 
 * @param world: An array of cells with size WORLD_SIZE representing the world
 *               The array is assumed to be periodic/cyclic.
 *
 * @return: None
 */
void setStates(cell world[WORLD_SIZE]) {
    //  For every cell, check the activity of its left and right neighbors (with wrapping)
    for (int i = 0; i < WORLD_SIZE; i++) {
        int left = i - 1, right = i + 1;
        if (left == -1) left = WORLD_SIZE - 1;
        if (right == WORLD_SIZE) right = 0;

        world[i].state[0] = world[left].active;
        world[i].state[1] = world[i].active;
        world[i].state[2] = world[right].active;
    }
}

/**
 * @brief: Evolve each cell's active status to the next generation 
 *         using its state array.
 * 
 * @param world: An array of cells with size WORLD_SIZE representing the world
 *               The array is assumed to be periodic/cyclic.
 *
 * @param ruleBitArray: An array with bit representation in reversed form of the rule number
 *
 * @return: None
 */
void evolveWorld(cell world[WORLD_SIZE], bool ruleBitArray[8]) {
    // This loop will create the new generation world
    cell newWorld[WORLD_SIZE];
    for (int i = 0; i < WORLD_SIZE; i++) {
        bool states[3] = {world[i].state[0], world[i].state[1], world[i].state[2]};
        newWorld[i].active = ruleBitArray[stateToIndex(states)] ? true : false;
    }
    setStates(newWorld);
    
    // Update world to new generation
    for (int i = 0; i < WORLD_SIZE; i++) {
        world[i] = newWorld[i];
    }
}

/**
 * @brief: This function will keep on asking for a rule number
 *         that satisfies [0, 255] - modifies the parameter 
 *
 * @param ruleRef: the parameter subject to be modified
 * 
 * @return: None
 */
void readValidRule(int* ruleRef) {
    int rule = -1;
    while (rule < 0 || rule > 255) {
        printf("Enter the rule # (0-255): ");
        scanf("%d", &rule);
    }
    *ruleRef = rule;
}

/**
 * @brief: This prints the associated bit array for the read rule number.
 *         For example, "The bit array for rule #30 is 00011110".
 * 
 * @param bitArray: An array of boolean representing a byte (8 bits) in reversed form.
 * @param rule: An integer to be displayed to the user
 *
 * @return: None
 */
void printBitArray(bool bitArray[8], int rule) {
    printf("\nThe bit array for rule #%d is ", rule);
    for (int i = 7; i >= 0; i--) {
        printf("%d", bitArray[i]);
    }
    printf("\n\n");
}

/**
 * @brief: This prints all the possible states.
 *         This loops through the bit array (e.g [01] -> | |   |*|).
 *
 * @param bitArray: An array of boolean representing a byte (8 bits) in reversed form.
 *
 * @return: None
 */
void printPossibleStates(bool bitArray[8]) {
    for (int i = 7; i >= 0; i--) {
        printf(bitArray[i] ? "|*|     " : "| |     ");
    }
}


/**
 * @brief: The main function is the entry point or the driver
 * code for this program. It will ask the user for two inputs
 * which will be used to create the cellular automation.
 * 
 * @return: 0 to represent successful program execution.
 */
int main() {
    cell world[WORLD_SIZE];
    bool bitArray[8];
    int rule, numGenerations;

    printf("Welcome to the Elementary Cellular Automaton!\n");

    // Read rule -> create and output bitArray:
    readValidRule(&rule);
    setBitArray(bitArray, rule);
    printBitArray(bitArray, rule);

    // Output all possible states:
    printf("The evolution of all possible states are as follows:\n"
           "|***|   |** |   |* *|   |*  |   | **|   | * |   |  *|   |   |\n ");
    printPossibleStates(bitArray);

    // Read and initialize numGenerations:
    printf("\n\nEnter the number of generations: ");
    scanf("%d", &numGenerations);

    // Initialize the world at generation 0:
    printf("\nInitializing world & evolving...\n"
           "                                *                                \n");
    for (int i = 0; i < WORLD_SIZE;) world[i++].active = false;
    world[32].active = true; // mid point of world 
    setStates(world); // Update the states of each cell in world

    // Create the world:
    for (int i = 0; i < numGenerations - 1; i++) { 
        evolveWorld(world, bitArray); // evolution
        for (int j = 0; j < WORLD_SIZE; j++) { // this loop displays the world
            putchar(world[j].active ? '*' : ' ');
        }
        putchar('\n');
    }
    return 0;
}