#include <utility>
#include <random>
#include <set>
#include "grid.h"
#include "maze.h"
#include <unordered_set>
using namespace std;

/* Change constant kYourNetID to store your netID 
 *    - your submission will be manually inspected to ensure
 *      you have used the exact string that is your netID
 *    - thus, it is vital you understand what your netID is
 *    - ex: Professor Reckinger's email is scotreck@uic.edu, so
 *          Professor Reckinger's netID is scotreck     
 *    - ex: Professor Kidane's email is ekidan2@uic.edu, so
 *          Professor Kidane's netID is ekidan2     
 *    - ex: Student Sparky's email is sspark211@uic.edu, so
 *          Student Sparky's netID is sspark211 
 * WARNING: Once you've set set this constant and started 
 * exploring your maze, do NOT edit the value of kYourNetID. 
 * Changing kYourNetID will change which maze you get back, 
 * which might invalidate all your hard work!
 */
const string kYourNetID = "jsee4";

/* Change these constants to contain the paths out of your mazes. */
const string kPathOutOfRegularMaze = "EEESNWWWSESSWNSENNESESW";
const string kPathOutOfTwistyMaze = "SSNEWEWNNSE";

bool isPathToFreedom(MazeCell *start, const string& moves) {
    
    if (start == NULL) return false;

    MazeCell* currentPosition = start;
    unordered_set<string> objectsCollected;
    int n = moves.size();
    int i = -1;
    // Check if the input string includes invalid characters:
    for (int idx = 0; idx < n; idx++) {
        if (moves[idx] != 'N' && moves[idx] != 'S' && moves[idx] != 'E' && moves[idx] != 'W') return false;
    }

    // Check if the maze is possible under two conditions:
    // 1. The path is valid.
    // 2. It picks up the Potion, Spellbook and the Wand (i.e the set size is 3).
    while (currentPosition != NULL && i++ < n) {
        // Store the objects in a set:
        string object = currentPosition->whatsHere;
        if (object.size() > 0) {
            objectsCollected.insert(object);
        }
        // Move the position by one:
        if (moves[i] == 'N') {
            if (currentPosition->north == NULL) return false;
            currentPosition = currentPosition->north;
        } else if (moves[i] == 'S') {
            if (currentPosition->south == NULL) return false;
            currentPosition = currentPosition->south;
        } else if (moves[i] == 'E') {
            if (currentPosition->east == NULL) return false;
            currentPosition = currentPosition->east;
        } else if (moves[i] == 'W') {
            if (currentPosition->west == NULL) return false;
            currentPosition = currentPosition->west;
        }
    }
    if (objectsCollected.size() >= 3) return true;

    return false;
}
