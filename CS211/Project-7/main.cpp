#include <cstdlib>
#include <iostream>
#include <string>
#include <ctime>

using namespace std;

#include "gameboard.h"

char getHeroNextMove() {
    char HeroNextMove;
    cout << "Your move. Where to? ['s' to stay, etc.]: " ;
    cin >> HeroNextMove;
    cout << endl;
    return HeroNextMove;
}

int main( ) {
	
    int numrows = 0; //15
    int numcols = 0; //40
    while (numrows < 10 || numrows > 30) {
        cout << "Enter the number of rows (10-30) for the board: ";
        cin >> numrows;
        cout << endl;
    }
    while (numcols < 15 || numcols > 100) {
        cout << "Enter the number of columns (15-100) for the board: ";
        cin >> numcols;
        cout << endl;
    }
    GameBoard myBoard(numrows, numcols);
    
    int numA = -1;
    while (numA < 0 || numA > 200) {
        cout << "Enter the number of abyss cells (0-200) on the board: ";
        cin >> numA;
        cout << endl;
    }
    myBoard.setNumAbysses(numA);
    
    int numM = -1;
    while (numM < 0 || numM > 30) {
        cout << "Enter the number of monsters (0-30) on the board, ~1/3 will be super monsters: ";
        cin >> numM;
        cout << endl;
    }
    myBoard.setNumMonsters(numM);

    int numB = -1;
    while (numB < 0 || numB > 10) {
        cout << "Enter the number of bats (0-10) on the board: ";
        cin >> numB;
        cout << endl;
    }
    myBoard.setNumBats(numB);

    int seed = -1;
    cout << "Enter a seed for the random number generator (-1 to use system time): ";
    cin >> seed;
    cout << endl;
    
    if (seed < 0) {
        myBoard.setupBoard(time(0));
    } else {
        myBoard.setupBoard(seed);
    }
    myBoard.display();
        
    bool gameOver = false;
    char nextMove;
    while (!gameOver) {
        nextMove = getHeroNextMove();
        gameOver = !(myBoard.makeMoves(nextMove));
        myBoard.display();
    }  

    if (myBoard.getWonGame()) {
        cout << "Hero Escaped!" << endl;
    } else {
        cout << "Hero did not escape..." << endl;
    }
    cout << "Game Over." << endl;
	
	return 0;
	
} // main
