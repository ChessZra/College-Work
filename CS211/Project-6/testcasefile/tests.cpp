#include <gtest/gtest.h>
#include <vector>
#include <map>
#include "maze.h"
#include "grid.h"
#include "EscapeTheLabyrinth.h"
#include <sstream>
#include <set>

string RED= "\033[36m";

TEST(grid, defaultConstructor){
    //
    // creates 4x4 matrix by default:
    //
    Grid<int>  M;

    int R = 4;
    int C = 4;

    EXPECT_EQ(M.numrows(), R);

    for (int r = 0; r < R; ++r) {
        EXPECT_EQ(M.numcols(r), C);
    }

    EXPECT_EQ(M.size(), (R * C));
}

TEST(grid, paramConstructor){
    Grid<int>  M(8, 10);

    int R = 8;
    int C = 10;

    EXPECT_EQ(M.numrows(), R);

    for (int r = 0; r < R; ++r) {
        EXPECT_EQ(M.numcols(r), C);
    }

    EXPECT_EQ(M.size(), (R * C));
}

TEST(grid, defaultConstructorAllZero) {
    //
    // creates 4x4 matrix by default:
    //
    Grid<int>  M;

    int R = 4;
    int C = 4;

    EXPECT_EQ(M.numrows(), R);

    for (int r = 0; r < R; ++r) {
        EXPECT_EQ(M.numcols(r), C);
    }

    EXPECT_EQ(M.size(),  (R*C));

    //
    // all elements should be 0:
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M(r, c),  0);
        }
    }
}

TEST(grid, defaultConstructorAllZero2) {
    Grid<int>  M(11, 5);

    int R = 11;
    int C = 5;

    EXPECT_EQ(M.numrows(), R);

    for (int r = 0; r < R; ++r) {
        EXPECT_EQ(M.numcols(r), C);
    }

    EXPECT_EQ(M.size(), (R*C));

    //
    // all elements should be 0:
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M(r, c), 0);
        }
    }
}

TEST(grid, defaultConstructorStoreValues) {
    //
    // creates 4x4 matrix by default:
    //
    Grid<int>  M;

    int R = 4;
    int C = 4;

    EXPECT_EQ(M.numrows(), R);

    for (int r = 0; r < R; ++r) {
        EXPECT_EQ(M.numcols(r), C);
    }

    EXPECT_EQ(M.size(), (R * C));

    //
    // all elements should be 0:
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M(r, c), 0);
        }
    }

    //
    // now let's update the values:  1, 2, 3, ...
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            M(r, c) = -5 * ((r * C) + c + 1);
        }
    }

    //
    // now confirm the values were stored properly:
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M(r, c), (-5*((r * C) + c + 1)));
        }
    }

}

TEST(grid, defaultConstructorStoreValues2) {
    Grid<int>  M(10, 29);

    int R = 10;
    int C = 29;

    EXPECT_EQ(M.numrows(), R);

    for (int r = 0; r < R; ++r) {
        EXPECT_EQ(M.numcols(r), C);
    }

    EXPECT_EQ(M.size(), (R * C));

    //
    // all elements should be 0:
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M(r, c), 0);
        }
    }

    //
    // now let's update the values:  1, 2, 3, ...
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            M(r, c) = 8 * ((r * C) + c + 1);
        }
    }

    //
    // now confirm the values were stored properly:
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M(r, c), (8*((r * C) + c + 1)));
        }
    }

}

TEST(grid, differentTypes) {
    Grid<int>  M1;
    Grid<double> M2;
    Grid<char> M3;
    Grid<int>  M4;
    Grid<double> M5;
    Grid<char> M6;

    M1(0, 0) = 123;
    M2(1, 1) = 3.14159;
    M3(2, 2) = 'z';

    M1(0, 3) = 456;
    M2(1, 2) = -1.5;
    M3(2, 1) = 'a';

    EXPECT_EQ(M1.size(), 16);
    EXPECT_EQ(M2.size(), 16);
    EXPECT_EQ(M3.size(), 16);
    EXPECT_EQ(M4.size(), 16);
    EXPECT_EQ(M5.size(), 16);
    EXPECT_EQ(M6.size(), 16);
}

TEST(grid, invalidRowCols) {

    try
    {
        Grid<int>  M;

        M(-1, 0) = 123;

        EXPECT_TRUE(false);  // if we get here, exception was NOT thrown, error
    }
    catch (...)
    {
        EXPECT_TRUE(true);  // if we get here, exception was thrown --- correct
    }

    try
    {
        Grid<int>  M;

        M(1, -10) = 123;

        EXPECT_TRUE(false);  // if we get here, exception was NOT thrown, error
    }
    catch (...)
    {
        EXPECT_TRUE(true);  // if we get here, exception was thrown --- correct
    }

    try
    {
        Grid<int>  M;

        M(4, 1) = 123;

        EXPECT_TRUE(false);  // if we get here, exception was NOT thrown, error
    }
    catch (...)
    {
        EXPECT_TRUE(true);  // if we get here, exception was thrown --- correct
    }

    try
    {
        Grid<int>  M;

        M(2, 4) = 123;

        EXPECT_TRUE(false);  // if we get here, exception was NOT thrown, error
    }
    catch (...)
    {
        EXPECT_TRUE(true);  // if we get here, exception was thrown --- correct
    }
}


TEST(grid, copyConstructor) {
    //
    // creates 4x4 matrix by default:
    //
    Grid<int>  M;

    int R = 4;
    int C = 4;

    EXPECT_EQ(M.numrows(), R);

    for (int r = 0; r < R; ++r) {
        EXPECT_EQ(M.numcols(r), C);
    }

    EXPECT_EQ(M.size(), (R * C));

    //
    // all elements should be 0:
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M(r, c), 0);
        }
    }

    //
    // now let's update the values:
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            M(r, c) = (-9 * r * C) + (2*c) - 1;
        }
    }

    //
    // now confirm the values were stored properly:
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M(r, c), ((-9 * r * C) + (2 * c) - 1));
        }
    }

    //
    // let's now let's copy the matrix, and make sure it's a copy:
    //
    Grid<int> M2 = M;

    EXPECT_EQ(M2.numrows(), R);

    for (int r = 0; r < R; ++r)
        EXPECT_EQ(M2.numcols(r), C);

    EXPECT_EQ(M2.size(), (R * C));

    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M2(r, c), ((-9 * r * C) + (2 * c) - 1));
        }
    }

    //
    // M unchanged by copy:
    //
    EXPECT_EQ(M.numrows(), R);

    for (int r = 0; r < R; ++r)
        EXPECT_EQ(M.numcols(r), C);

    EXPECT_EQ(M.size(), (R * C));

    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M(r, c), ((-9 * r * C) + (2 * c) - 1));
        }
    }

    //
    // Okay, if it's a deep copy, I should be able to change M2
    // and not impact M:
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            M2(r, c) = M2(r, c) + 7;
        }
    }

    // M unchanged:
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M(r, c), ((-9 * r * C) + (2 * c) - 1));
        }
    }

    // M2 updated:
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M2(r, c), ((-9 * r * C) + (2 * c) - 1 + 7));
        }
    }
}

TEST(grid, copyConstructor2) {
    Grid<int>  M(9, 6);

    int R = 9;
    int C = 6;

    EXPECT_EQ(M.numrows(), R);

    for (int r = 0; r < R; ++r)
        EXPECT_EQ(M.numcols(r), C);

    EXPECT_EQ(M.size(), (R * C));

    //
    // all elements should be 0:
    //
    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            EXPECT_EQ(M(r, c), 0);

    //
    // now let's update the values:
    //
    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            M(r, c) = (-7 * r * C) + (2*c) - 1;

    //
    // now confirm the values were stored properly:
    //
    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            EXPECT_EQ(M(r, c), ((-7 * r * C) + (2 * c) - 1));

    //
    // let's now let's copy the matrix, and make sure it's a copy:
    //
    Grid<int> M2 = M;

    EXPECT_EQ(M2.numrows(), R);

    for (int r = 0; r < R; ++r)
        EXPECT_EQ(M2.numcols(r), C);

    EXPECT_EQ(M2.size(), (R * C));

    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            EXPECT_EQ(M2(r, c), ((-7 * r * C) + (2 * c) - 1));

    //
    // M unchanged by copy:
    //
    EXPECT_EQ(M.numrows(), R);

    for (int r = 0; r < R; ++r)
        EXPECT_EQ(M.numcols(r), C);

    EXPECT_EQ(M.size(), (R * C));

    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            EXPECT_EQ(M(r, c), ((-7 * r * C) + (2 * c) - 1));

    //
    // Okay, if it's a deep copy, I should be able to change M2
    // and not impact M:
    //
    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            M2(r, c) = M2(r, c) - 2;

    // M unchanged:
    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            EXPECT_EQ(M(r, c), ((-7 * r * C) + (2 * c) - 1));

    // M2 updated:
    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            EXPECT_EQ(M2(r, c), ((-7 * r * C) + (2 * c) - 1 - 2));
}

TEST(grid, copyOperator) {
    //
    // creates 4x4 matrix by default:
    //
    Grid<int>  M;

    int R = 4;
    int C = 4;

    EXPECT_EQ(M.numrows(), R);

    for (int r = 0; r < R; ++r) {
        EXPECT_EQ(M.numcols(r), C);
    }

    EXPECT_EQ(M.size(), (R * C));

    //
    // all elements should be 0:
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M(r, c), 0);
        }
    }

    //
    // now let's update the values:
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            M(r, c) = (-9 * r * C) + (2*c) - 1;
        }
    }

    //
    // now confirm the values were stored properly:
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M(r, c), ((-9 * r * C) + (2 * c) - 1));
        }
    }

    //
    // let's now let's copy the matrix, and make sure it's a copy:
    //
    Grid<int> M2;
    M2 = M;

    EXPECT_EQ(M2.numrows(), R);

    for (int r = 0; r < R; ++r)
        EXPECT_EQ(M2.numcols(r), C);

    EXPECT_EQ(M2.size(), (R * C));

    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M2(r, c), ((-9 * r * C) + (2 * c) - 1));
        }
    }

    //
    // M unchanged by copy:
    //
    EXPECT_EQ(M.numrows(), R);

    for (int r = 0; r < R; ++r)
        EXPECT_EQ(M.numcols(r), C);

    EXPECT_EQ(M.size(), (R * C));

    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M(r, c), ((-9 * r * C) + (2 * c) - 1));
        }
    }

    //
    // Okay, if it's a deep copy, I should be able to change M2
    // and not impact M:
    //
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            M2(r, c) = M2(r, c) + 7;
        }
    }

    // M unchanged:
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M(r, c), ((-9 * r * C) + (2 * c) - 1));
        }
    }

    // M2 updated:
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            EXPECT_EQ(M2(r, c), ((-9 * r * C) + (2 * c) - 1 + 7));
        }
    }
}

TEST(grid, copyOperator2) {
    Grid<int>  M(9, 6);

    int R = 9;
    int C = 6;

    EXPECT_EQ(M.numrows(), R);

    for (int r = 0; r < R; ++r)
        EXPECT_EQ(M.numcols(r), C);

    EXPECT_EQ(M.size(), (R * C));

    //
    // all elements should be 0:
    //
    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            EXPECT_EQ(M(r, c), 0);

    //
    // now let's update the values:
    //
    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            M(r, c) = (-7 * r * C) + (2*c) - 1;

    //
    // now confirm the values were stored properly:
    //
    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            EXPECT_EQ(M(r, c), ((-7 * r * C) + (2 * c) - 1));

    //
    // let's now let's copy the matrix, and make sure it's a copy:
    //
    Grid<int> M2;
    M2 = M;

    EXPECT_EQ(M2.numrows(), R);

    for (int r = 0; r < R; ++r)
        EXPECT_EQ(M2.numcols(r), C);

    EXPECT_EQ(M2.size(), (R * C));

    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            EXPECT_EQ(M2(r, c), ((-7 * r * C) + (2 * c) - 1));

    //
    // M unchanged by copy:
    //
    EXPECT_EQ(M.numrows(), R);

    for (int r = 0; r < R; ++r)
        EXPECT_EQ(M.numcols(r), C);

    EXPECT_EQ(M.size(), (R * C));

    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            EXPECT_EQ(M(r, c), ((-7 * r * C) + (2 * c) - 1));

    //
    // Okay, if it's a deep copy, I should be able to change M2
    // and not impact M:
    //
    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            M2(r, c) = M2(r, c) - 2;

    // M unchanged:
    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            EXPECT_EQ(M(r, c), ((-7 * r * C) + (2 * c) - 1));

    // M2 updated:
    for (int r = 0; r < R; ++r)
        for (int c = 0; c < C; ++c)
            EXPECT_EQ(M2(r, c), ((-7 * r * C) + (2 * c) - 1 - 2));
}

TEST(maze, param) {
    Maze m(10, 10);
}

TEST(maze, basic) {
    vector<string> textMaze;

    textMaze.push_back("* *-W *");
    textMaze.push_back("| |   |");
    textMaze.push_back("*-* * *");
    textMaze.push_back("  | | |");
    textMaze.push_back("S *-*-*");
    textMaze.push_back("|   | |");
    textMaze.push_back("*-*-* P");

    Maze m(textMaze);

    MazeCell* start = m.getStart(2, 2);

    /* These paths are the ones in the handout. They all work. */
    EXPECT_TRUE(isPathToFreedom(start, "ESNWWNNEWSSESWWN"));
    EXPECT_TRUE(isPathToFreedom(start, "SWWNSEENWNNEWSSEES"));
    EXPECT_TRUE(isPathToFreedom(start, "WNNEWSSESWWNSEENES"));

    /* These paths don't work, since they don't pick up all items. */
    EXPECT_FALSE(isPathToFreedom(start, "ESNW"));
    EXPECT_FALSE(isPathToFreedom(start, "SWWN"));
    EXPECT_FALSE(isPathToFreedom(start, "WNNE"));

    /* These paths don't work, since they aren't legal paths. */
    EXPECT_FALSE(isPathToFreedom(start, "WW"));
    EXPECT_FALSE(isPathToFreedom(start, "NN"));
    EXPECT_FALSE(isPathToFreedom(start, "EE"));
    EXPECT_FALSE(isPathToFreedom(start, "SS"));
}

TEST(maze, tryingToGoThroughWalls) {
    vector<string> textMaze;

    textMaze.push_back("* S *");
    textMaze.push_back("     ");
    textMaze.push_back("W * P");
    textMaze.push_back( "     ");
    textMaze.push_back( "* * *");

    Maze m(textMaze);

    MazeCell* start = m.getStart(1, 1);

    EXPECT_FALSE(isPathToFreedom(start, "WNEES"));
    EXPECT_FALSE(isPathToFreedom(start, "NWSEE"));
    EXPECT_FALSE(isPathToFreedom(start, "ENWWS"));
    EXPECT_FALSE(isPathToFreedom(start, "SWNNEES"));
}

// Provided Test: Works when starting on an item
TEST(maze, startOnItem) {
    vector<string> textMaze;

    textMaze.push_back("P-S-W");

    Maze m(textMaze);
    MazeCell* start = m.getStart(0, 0);

    EXPECT_TRUE(isPathToFreedom(start, "EE"));
    start = m.getStart(0, 1);
    EXPECT_TRUE(isPathToFreedom(start, "WEE"));
    start = m.getStart(0, 2);
    EXPECT_TRUE(isPathToFreedom(start, "WW"));

}

//Provided Test: Reports errors if given illegal characters.
TEST(maze, invalidChar) {
    vector<string> textMaze;

    textMaze.push_back("* *-W *");
    textMaze.push_back("| |   |");
    textMaze.push_back("*-* * *");
    textMaze.push_back("  | | |");
    textMaze.push_back("S *-*-*");
    textMaze.push_back("|   | |");
    textMaze.push_back("*-*-* P");

    Maze m(textMaze);
    MazeCell* start = m.getStart(0, 0);

    /* These paths contain characters that aren't even close to permissible. */
    EXPECT_FALSE(isPathToFreedom(start, "Q"));
    EXPECT_FALSE(isPathToFreedom(start, "X"));
    EXPECT_FALSE(isPathToFreedom(start, "!"));
    EXPECT_FALSE(isPathToFreedom(start, "?"));

    EXPECT_FALSE(isPathToFreedom(start, "n"));
    EXPECT_FALSE(isPathToFreedom(start, "s"));
    EXPECT_FALSE(isPathToFreedom(start, "e"));
    EXPECT_FALSE(isPathToFreedom(start, "w"));
//
///* These are tricky - they're legal paths that happen to have an unexpected
// * character at the end.
// */
    start = m.getStart(2, 2);
    EXPECT_FALSE(isPathToFreedom(start, "ESNWWNNEWSSESWWNQ"));
    EXPECT_FALSE(isPathToFreedom(start, "SWWNSEENWNNEWSSEES!!!"));
    EXPECT_FALSE(isPathToFreedom(start, "WNNEWSSESWWNSEENES??"));

}


TEST(maze, escapeRegularMaze) {
    Maze m(4, 4);
    MazeCell* start = m.mazeFor(kYourNetID);
    EXPECT_TRUE(isPathToFreedom(start, kPathOutOfRegularMaze));
}

TEST(maze, escapeTwistyMaze) {
    Maze m(4, 4);
    MazeCell* start = m.twistyMazeFor(kYourNetID);
    EXPECT_TRUE(isPathToFreedom(start, kPathOutOfTwistyMaze));
}

