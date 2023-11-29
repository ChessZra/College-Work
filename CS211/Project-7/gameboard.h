/* -----------------------------------------------------------------------------------
Program 7: Outlast the Baddies & Avoid the Abyss
Course: CS 211, Fall 2023, UIC
Author: ChessZra
System: Advanced zyLab
- -               - -
Description: This is the header file for the Gameboard class - where the whole game
takes place.
------------------------------------------------------------------------------------- */

#ifndef _GAMEBOARD_H
#define _GAMEBOARD_H

#include <cstdlib>
#include <iostream>
#include <string>
#include <ctime>
#include <stdexcept>

#include "boardcell.h"
#include "grid.h"

using namespace std;

class GameBoard {
	private: 
	    Grid<BoardCell*> board;
        size_t numRows;
        size_t numCols;
        size_t HeroRow; // Hero's position row
	    size_t HeroCol; // Hero's position column
        int numMonsters;
        int numSuperMonsters;
        int numAbysses;
        int numBats;
        bool wonGame; // false, unless the Hero reached the exit successfully

	public: 
		/* default constructor */
        GameBoard() {
            numMonsters = 4;
            numSuperMonsters = 2;
            numAbysses = 50;
            numBats = 2;
            wonGame = false;
            
            this -> numRows = 15;
            this -> numCols = 40;
            
            Grid<BoardCell*> boardnew(numRows, numCols);
            board = boardnew;
            
            blankBoard();
        }
        
        /* param constructor */
        GameBoard(size_t numRows, size_t numCols) {
            numMonsters = 4;
            numSuperMonsters = 2;
            numAbysses = 20;
            numBats = 3;
            wonGame = false;
            
            this -> numRows = numRows;
            this -> numCols = numCols;
            
            Grid<BoardCell*> boardnew(numRows, numCols);
            board = boardnew;
            
            blankBoard();
        }
        
        /* destructor */
        virtual ~GameBoard() {
            for (size_t row = 0; row < board.numrows(); row++) {
                for (size_t col = 0; col < board.numcols(row); col++) {
                    delete board(row, col);
                }
            }
        }

        void blankBoard() {
            for (size_t row = 0; row < board.numrows(); row++) {
                for (size_t col = 0; col < board.numcols(row); col++) {
                    board(row, col) = new Nothing(row,col);
                }
            }
        }

        char getCellDisplay(size_t r, size_t c) {
            return board(r,c)->display();
        }

        void setCell(BoardCell* myCell, size_t r, size_t c) {
            board(r,c) = myCell;
        }
    
        void freeCell(size_t r, size_t c) {
            delete board(r,c);
        }

        // fills board with by randomly placing...
        //  - Hero (H) in the first three columns
        //  - EscapeLadder (*) in last three columns
        //  - 3 vertical Walls (+), each 1/2 of board height, in middle segment
        //  - Abyss cells (#), quantity set by numAbysses, in middle segment
        //  - Baddies [Monsters (m), Super Monsters (M), & Bats (~)] in middle segment;
        //    number of Baddies set by numMonsters, numSuperMonsters, & numBats
        void setupBoard(int seed) {
            srand(seed);
            size_t r,c;

            r = rand() % numRows;
            c = rand() % 3;
            delete board(r,c);
            board(r,c) = new Hero(r,c);
            HeroRow = r;
            HeroCol = c;

            r = rand() % numRows;
            c = numCols - 1 - (rand() % 3);
            delete board(r,c);
            board(r,c) = new EscapeLadder(r,c);
            
            int sizeMid = numCols - 6;

            c = 3 + (rand() % sizeMid);
            for (r = 0; r < numRows/2; ++r) {
                delete board(r,c);
                board(r,c) = new Wall(r,c);
            }
            size_t topc = c;

            while (c == topc || c == topc-1 || c == topc+1) {
                c = 3 + (rand() % sizeMid);
            }
            for (r = numRows-1; r > numRows/2; --r) {
                delete board(r,c);
                board(r,c) = new Wall(r,c);           
            }
            size_t botc = c;

            while (c == topc || c == topc-1 || c == topc+1 || c == botc || c == botc-1 || c == botc+1) {
                c = 3 + (rand() % sizeMid);
            }
            for (r = numRows/4; r < 3*numRows/4; ++r) {
                delete board(r,c);
                board(r,c) = new Wall(r,c);
            }

            for (int i = 0; i < numMonsters; ++i) {
                r = rand() % numRows;
                c = 3 + (rand() % sizeMid);
                while (board(r,c)->display() != ' ') {
                    r = rand() % numRows;
                    c = 3 + (rand() % sizeMid);
                }
                delete board(r,c);
                board(r,c) = new Monster(r,c);  
                board(r,c)->setPower(1);        
            }

            for (int i = 0; i < numSuperMonsters; ++i) {
                r = rand() % numRows;
                c = 3 + (rand() % sizeMid);
                while (board(r,c)->display() != ' ') {
                    r = rand() % numRows;
                    c = 3 + (rand() % sizeMid);
                }
                delete board(r,c);
                board(r,c) = new Monster(r,c); 
                board(r,c)->setPower(2);               
            }

            for (int i = 0; i < numBats; ++i) {
                r = rand() % numRows;
                c = 3 + (rand() % sizeMid);
                while (board(r,c)->display() != ' ') {
                    r = rand() % numRows;
                    c = 3 + (rand() % sizeMid);
                }
                delete board(r,c);
                board(r,c) = new Bat(r,c); 
            }

            for (int i = 0; i < numAbysses; ++i) {
                r = rand() % numRows;
                c = 3 + (rand() % sizeMid);
                while (board(r,c)->display() != ' ') {
                    r = rand() % numRows;
                    c = 3 + (rand() % sizeMid);
                }
                delete board(r,c);
                board(r,c) = new Abyss(r,c);              
            }
        }

        // neatly displaying the game board 
		void display( ) {
            cout << '-';
            for (size_t col = 0; col < board.numcols(0); col++) {
                cout << '-';
            }
            cout << '-';
            cout << endl;
            for (size_t row = 0; row < board.numrows(); row++) {
                cout << '|';
                for (size_t col = 0; col < board.numcols(row); col++) {
                    cout << board(row,col)->display();
                }
                cout << '|';
                cout << endl;
            }
            cout << '-';
            for (size_t col = 0; col < board.numcols(0); col++) {
                cout << '-';
            }
            cout << '-';
            cout << endl;
            
        }
		
        bool getWonGame() {
            return wonGame;
        }
        
        // distributing total number of monsters so that 
        //  ~1/3 of num are Super Monsters (M), and
        //  ~2/3 of num are Regular Monsters (m)
        void setNumMonsters(int num) {
            numSuperMonsters = num/3;
            numMonsters = num - numSuperMonsters;
        }

        void setNumAbysses(int num) {
            numAbysses = num;
        }

        void setNumBats(int num) {
            numBats = num;
        }

        size_t getNumRows() {
            return numRows;
        }

        size_t getNumCols() {
            return numCols;
        }

        //---------------------------------------------------------------------------------
        // void getHeroPosition(size_t& row, size_t& col)
        //
        // getter for Hero's position, which are private data members
        //      int HeroRow;
	    //      int HeroCol;
        // note: row and col are passed-by-reference
        //---------------------------------------------------------------------------------
        void getHeroPosition(size_t& row, size_t& col) {
            row = this->HeroRow;
            col = this->HeroCol;
        }
        
        //---------------------------------------------------------------------------------
        // void setHeroPosition(size_t row, size_t col)
        //
        // setter for Hero's position, which are private data members
        //      int HeroRow;
	    //      int HeroCol;
        //---------------------------------------------------------------------------------
        void setHeroPosition(size_t row, size_t col) {
            this->HeroRow = row;
            this->HeroCol = col;
        }

        //---------------------------------------------------------------------------------
        // findHero()
        //
        // updater for Hero's position, which are private data members
        //      int HeroRow;
	    //      int HeroCol;
        // this function should find Hero in board and update
        //      HeroRow and HeroCol with the Hero's updated position;
        // if Hero cannot be found in board, then set Hero's position to (-1,-1)
        //---------------------------------------------------------------------------------
        void findHero() {
            for (size_t i = 0; i < this->numRows; i++) {
                for (size_t j = 0; j < this->numCols; j++) {
                    if (board(i, j)->isHero()) {
                        this->HeroRow = i;
                        this->HeroCol = j;
                        return;
                    }
                }
            }
            this->HeroRow = -1;
            this->HeroCol = -1;
        }

        //---------------------------------------------------------------------------------
        // makeMoves
        // Parameters: HeroNextMove - character representing the Hero's next move
        // Description: Executes a single round of the game, handling the moves of the Hero
        //              and baddies on the game board. Resolves collisions and updates 
        //              positions based on attempted moves. Ensures baddies move only once 
        //              per round. Resets moved status for all board cells. Updates Hero's 
        //              position on the game board.
        //
        // Returns:
        // - true if Hero is still on the board at the end of the round.
        // - false if Hero is not on the board at the end of the round.
        //---------------------------------------------------------------------------------
        bool makeMoves(char HeroNextMove) {
            size_t newR, newC;
            board(HeroRow,HeroCol)->setNextMove(HeroNextMove);
            board(HeroRow,HeroCol)->attemptMoveTo(newR,newC,HeroRow,HeroCol);

            try { // hero attempts to move out-of-bounds in rows
                if (newR < 0 || newR >= numRows) { 
                    throw runtime_error("Hero trying to move out-of-bounds with an invalid row");
                } 
            } catch (runtime_error& excpt) {
                cout << excpt.what() << endl;
                newR = HeroRow;
                cout << "Changing row for Hero position to stay in-bounds" << endl;
            }

            try { // hero attempts to move out-of-bounds in columns
                if (newC < 0 || newC >= numCols) { 
                    throw runtime_error("Hero trying to move out-of-bounds with an invalid column");
                } 
            } catch (runtime_error& excpt) {
                cout << excpt.what() << endl;
                newC = HeroCol;
                cout << "Changing column for Hero position to stay in-bounds" << endl;
            }

            try { // hero attempts to move into a barrier
                if (board(newR, newC)->isBarrier()) { 
                    throw runtime_error("Hero trying to move into a barrier");
                } 
            } catch (runtime_error& excpt) {
                cout << excpt.what() << endl;
                newC = HeroCol;
                cout << "Changing Hero position to stay off barrier" << endl;
            }
            if (board(newR, newC)->isExit()) { // hero moves to the exit ladder
                cout << "Hero has reached the exit!\nHero has escaped!" << endl;
                // Remove the hero from the board:
                delete board(HeroRow, HeroCol);
                board(HeroRow, HeroCol) = new Nothing(HeroRow, HeroCol);
                this->wonGame = true;
                return false;
            }

            try { // hero runs into a hole or a baddie
                if (board(newR, newC)->isHole() || board(newR, newC)->isBaddie()) {
                    throw runtime_error("Uh Oh! Hero has moved into a Baddie or the Abyss...");
                } 
            } catch (runtime_error& excpt) {
                cout << excpt.what() << endl;
                cout << "Be more careful next time..." << endl;
                // Remove the hero from the board:
                delete board(HeroRow, HeroCol);
                board(HeroRow, HeroCol) = new Nothing(HeroRow, HeroCol);
                this->wonGame = false;
                return false;
            }

            // Finally, move the hero to (newR, newC)
            // Remove the hero from the board:
            delete board(HeroRow, HeroCol);
            board(HeroRow, HeroCol) = new Nothing(HeroRow, HeroCol);
            // Move the hero:
            delete board(newR, newC);
            board(newR, newC) = new Hero(newR, newC);
            setHeroPosition(newR, newC);

            // Clear the baddie <moved> subitem before updating:
            for (size_t r = 0; r < numRows; r++) {
                for (size_t c = 0; c < numCols; c++) {
                    if (board(r, c)->isBaddie()) {
                        board(r, c)->setMoved(false);
                    }
                }
            }

            // Update all the baddies' moves:
            bool gameOver = false;
            for (size_t r = 0; r < numRows; r++) {
                for (size_t c = 0; c < numCols; c++) {
                    if (!board(r, c)->isBaddie() || board(r, c)->getMoved()) {
                        continue;
                    }
                    size_t newR = r;
                    size_t newC = c;
                    // Attempt to move every baddie:
                    board(r, c)->attemptMoveTo(newR,newC,HeroRow,HeroCol);
                    // Row bounds:
                    if (newR < 0 || newR >= numRows) { 
                        newR = r;
                    } 
                    // Column bounds:
                    if (newC < 0 || newC >= numCols) { 
                        newC = c;
                    } 
                    // Baddie runs through a barrier
                    if (board(newR, newC)->isBarrier()) { 
                        newC = c;
                    } 
                    // Baddie runs through an exit
                    if (board(newR, newC)->isExit()) {
                        newC = c;
                        newR = r;
                    }
                    // Baddie falls down into a hole:
                    if (board(newR, newC)->isHole()) {
                        // Remove the baddie from the board:
                        delete board(r, c);
                        board(r, c) = new Nothing(r, c);
                        continue;
                    }
                    // Baddie eats the Hero:
                    if (board(newR, newC)->isHero()) { 
                        gameOver = true;
                    }
                    // Baddie runs through another baddie:
                    if (board(newR, newC)->isBaddie()) {
                        newC = c;
                        newR = r;
                    }
                    char baddieType = board(r, c)->display();

                    // Finally, move the baddie to (newR, newC)
                    // Remove the baddie from the board:
                    delete board(r, c);
                    board(r, c) = new Nothing(r, c);

                    // Move the baddie:
                    delete board(newR, newC);
                    if (baddieType == 'M') {
                        board(newR, newC) = new Monster(newR, newC);
                        board(newR, newC)->setPower(2);
                        board(newR, newC)->setMoved(true);
                    } else if (baddieType == 'm') {
                        board(newR, newC) = new Monster(newR, newC);
                        board(newR, newC)->setPower(1);
                        board(newR, newC)->setMoved(true);
                    } else if (baddieType == '~') {
                        board(newR, newC) = new Bat(newR, newC);
                        board(newR, newC)->setMoved(true);
                    }
                }
            }
            if (gameOver) {
                this->wonGame = false;
                return false;
            }
            return true;
        }
};

#endif //_GAMEBOARD_H