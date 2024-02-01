// maze.h
//
// Scott Reckinger
// University of Illinois at Chicago
// CS 211
//
// The class completes all the functionality for building pointer mazes.
// Source:  Keith Schwarz, Stanford University, 2020

#pragma once

#include <iostream>
#include <exception>
#include <stdexcept>
#include <algorithm>
#include <string>
#include "grid.h"
#include <utility>
#include <random>
#include <set>
#include <queue>
#include "hashcode.h"

using namespace std;

struct MazeCell {
    string whatsHere; // One of "", "Potion", "Spellbook", and "Wand"
    MazeCell* north;
    MazeCell* south;
    MazeCell* east;
    MazeCell* west;
};


/* Type representing a possible edge in a maze. Two MazeCells are each
 * included here, along with the fields that would link them.
 */
struct EdgeBuilder {
    /* Which two edges to link. */
    MazeCell* first;
    MazeCell* second;
    
    /* How to link them. */
    MazeCell* MazeCell::* firstField;
    MazeCell* MazeCell::* secondField;
};


class Maze {
private:
    Grid<MazeCell*> grid;
    size_t numRows;
    size_t numCols;
    
    
public:
    /* param constructor */
    Maze(size_t numRows, size_t numCols) {
        this -> numRows = numRows;
        this -> numCols = numCols;
        
        Grid<MazeCell*> gridnew(numRows, numCols);
        grid = gridnew;
        
        blankMaze(grid);
    }
    
    /* constructor from string */
    Maze(vector<string>& textMaze){
        this -> numRows = (1 + textMaze.size() / 2);
        this -> numCols = (1 + textMaze[0].size() / 2);
        
        Grid<MazeCell*> gridnew(numRows, numCols);
        grid = gridnew;
        
        blankMaze(grid);
        
        fillItems(grid, textMaze);
        addWalls(grid, textMaze);
    }
    
    /* destructor */
    virtual ~Maze() {
        for (size_t row = 0; row < grid.numrows(); row++) {
            for (size_t col = 0; col < grid.numcols(row); col++) {
                delete grid(row, col);
            }
        }
    }
    
    /* Copies items from the text maze over to the grid maze. */
    void fillItems(Grid<MazeCell*>& maze, const vector<string>& textMaze) {
        for (size_t row = 0; row < maze.numrows(); row++) {
            for (size_t col = 0; col < maze.numcols(row); col++) {
                /* Odd-numbered positions are interstitial positions. */
                switch (textMaze[2 * row][2 * col]) {
                    case 'S':
                        maze(row, col)->whatsHere = "Spellbook";
                        break;
                    case 'P':
                        maze(row, col)->whatsHere = "Potion";
                        break;
                    case 'W':
                        maze(row, col)->whatsHere = "Wand";
                        break;
                    case '*':
                        /* Do nothing. */
                        maze(row, col)->whatsHere = "";
                        break;
                    default:
                        cout << "Unknown character found when copying items.";
                        cout << endl;
                }
            }
        }
    }
    
    /* Creates a blank grid maze of the given size. */
    void blankMaze(Grid<MazeCell*>& maze) {
        for (size_t row = 0; row < maze.numrows(); row++) {
            for (size_t col = 0; col < maze.numcols(row); col++) {
                maze(row, col) = new MazeCell();
            }
        }
    }
    
    /* Fills in the walls in maze given a text pattern. */
    void addWalls(Grid<MazeCell*>& maze, const vector<string>& textMaze) {
        for (size_t row = 0; row < maze.numrows(); row++) {
            for (size_t col = 0; col < maze.numcols(row); col++) {
                /* Look down if that's possible. */
                if (row + 1 < maze.numrows() && textMaze[2 * row + 1][2 * col] == '|') {
                    maze(row, col)->south = maze(row + 1, col);
                    maze(row + 1, col)->north = maze(row, col);
                }
                /* Look left if that's possible. */
                if (col + 1 < maze.numcols(row) && textMaze[2 * row][2 * col + 1] == '-') {
                    maze(row, col)->east = maze(row, col + 1);
                    maze(row, col + 1)->west = maze(row, col);
                }
            }
        }
    }
    
    /*Return the MazeCell* at row, col. */
    MazeCell* getStart(size_t row, size_t col) {
        return grid(row, col);
    }
    
    /* Returns all possible edges that could appear in a grid maze. */
    vector<EdgeBuilder> allPossibleEdgesFor() {
        vector<EdgeBuilder> result;
        for (size_t row = 0; row < grid.numrows(); row++) {
            for (size_t col = 0; col < grid.numcols(row); col++) {
                if (row + 1 < grid.numrows()) {
                    EdgeBuilder e;
                    e.first = grid(row, col);
                    e.second = grid(row + 1, col);
                    e.firstField = &MazeCell::south;
                    e.secondField = &MazeCell::north;
                    result.push_back(e);
                }
                if (col + 1 < grid.numcols(row)) {
                    EdgeBuilder e;
                    e.first = grid(row, col);
                    e.second = grid(row, col + 1);
                    e.firstField = &MazeCell::east;
                    e.secondField = &MazeCell::west;
                    result.push_back(e);
                }
            }
        }
        return result;
    }
    
    /* Generates a random number in the specified range. We use this instead of
     * std::uniform_int_distribution because std::uniform_int_distribution is
     * not cross-platform compatible.
     */
    size_t mtRandomBetween(size_t low, size_t high, mt19937& generator) {
        return (size_t) (low + generator() % (high - low + 1));
    }
    
    /* Shuffles the edges using the Fischer-Yates shuffle. We provide our own
     * implementation because the std::shuffle implementations on Windows, Mac,
     * and Linux are not guaranteed to work in the same way.
     */
    void shuffleEdges(vector<EdgeBuilder>& edges, mt19937& generator) {
        for (size_t i = 0; i < edges.size(); i++) {
            size_t j = mtRandomBetween(i, edges.size() - 1, generator);
            swap(edges[i], edges[j]);
        }
    }
    
    
    /* Union-find FIND operation. */
    MazeCell* repFor(const map<MazeCell*, MazeCell*>& reps, MazeCell* cell) {
        while (reps.at(cell) != cell) {
            cell = reps.at(cell);
        }
        return cell;
    }
    
    
    //
    ///* Creates a random maze of the given size using a randomized Kruskal's
    // * algorithm. Edges are shuffled and added back in one at a time, provided
    // * that each insertion links two disconnected regions.
    // */
    void makeMaze(mt19937& generator) {
        auto edges = allPossibleEdgesFor();
        shuffleEdges(edges, generator);
        
        /* Union-find structure, done without path compression because
         * N is small.
         */
        map<MazeCell*, MazeCell*> representatives;
        for (size_t row = 0; row < grid.numrows(); row++) {
            for (size_t col = 0; col < grid.numcols(row); col++) {
                representatives[grid(row, col)] = grid(row, col);
            }
        }
        
        /* Run a randomized Kruskal's algorithm to build the maze. */
        size_t edgesLeft = numRows * numCols - 1;
        for (size_t i = 0; edgesLeft > 0 && i < edges.size(); i++) {
            auto edge = edges[i];
            
            /* See if they're linked already. */
            auto* rep1 = repFor(representatives, edge.first);
            auto* rep2 = repFor(representatives, edge.second);
            
            /* If not, link them. */
            if (rep1 != rep2) {
                representatives[rep1] = rep2;
                
                edge.first->*edge.firstField   = edge.second;
                edge.second->*edge.secondField = edge.first;
                
                edgesLeft--;
            }
        }
        if (edgesLeft != 0) {
            cout << "Unable to build maze." << endl;;
        }
    }
    
    /* Returns if two nodes are adjacent. */
    bool areAdjacent(MazeCell* first, MazeCell* second) {
        return first->east  == second ||
        first->west  == second ||
        first->north == second ||
        first->south == second;
    }
    
    /* Uses the Floyd-Warshall algorithm to compute the shortest paths between
     * all pairs of nodes in the maze. The result is a table where table[i][j]
     * is the shortest path distance between maze[i] and maze[j].
     */
    void allPairsShortestPaths(const vector<MazeCell*>& maze,
                               Grid<size_t> &result) {
        /* Floyd-Warshall algorithm. */
        
        /*Fill the grid with "infinity" values. */
        for (size_t row = 0; row < result.numrows(); row++) {
            for (size_t col = 0; col < result.numcols(row); col++) {
                result(row, col) = maze.size() + 100;
            }
        }
        
        /* Set distances of nodes to themselves at 0. */
        for (size_t i = 0; i < maze.size(); i++) {
            result(i, i) = 0;
        }
        
        /* Set distances of edges to 1. */
        for (size_t i = 0; i < maze.size(); i++) {
            for (size_t j = 0; j < maze.size(); j++) {
                if (areAdjacent(maze[i], maze[j])) {
                    result(i, j) = 1;
                }
            }
        }
        
        /* Dynamic programming step. Keep expanding paths by allowing for paths
         * between nodes.
         */
        for (size_t i = 0; i < maze.size(); i++) {
            Grid<size_t> next(result.numrows(), result.numcols(0));
            for (size_t j = 0; j < maze.size(); j++) {
                for (size_t k = 0; k < maze.size(); k++) {
                    next(j, k) = min(result(j, k), result(j, i) + result(i, k));
                }
            }
            result = next;
        }
    }
    
    
    /* Given a list of distinct nodes, returns the "score" for their distances,
     * which is a sequence of numbers representing pairwise distances in sorted
     * order.
     */
    vector<size_t> scoreOf(vector<size_t>& nodes, Grid<size_t>& distances) {
        vector<size_t> result;
        
        for (size_t i = 0; i < nodes.size(); i++) {
            for (size_t j = i + 1; j < nodes.size(); j++) {
                result.push_back(distances(nodes[i], nodes[j]));
            }
        }
        
        sort(result.begin(), result.end());
        return result;
    }
    
    /* >operator for two vectors.*/
    bool compareTwoVecs(vector<size_t> vec1, vector<size_t> vec2) {
        for (size_t i = 0; i < vec1.size(); i++) {
            if (vec1[i] <= vec2[i]) {
                return false;
            }
        }
        return true;
    }
    
    /* Given a grid, returns a combination of four nodes whose overall score
     * (sorted list of pairwise distances) is as large as possible in a
     * lexicographical sense.
     */
    vector<size_t> remoteLocationsIn(Grid<size_t>& distances) {
        size_t init[] = {0, 1, 2, 3};
        vector<size_t> result(init, init + sizeof(init) / sizeof(size_t));
        /* We could do this recursively, but since it's "only" four loops
         * we'll just do that instead. :-)
         */
        for (size_t i = 0; i < distances.numrows(); i++) {
            for (size_t j = i + 1; j < distances.numrows(); j++) {
                for (size_t k = j + 1; k < distances.numrows(); k++) {
                    for (size_t l = k + 1; l < distances.numrows(); l++) {
                        size_t init2[] = {i, j, k, l};
                        vector<size_t> curr(init2, init2 + sizeof(init2) / sizeof(size_t));
                        if (compareTwoVecs(scoreOf(curr, distances), scoreOf(result, distances))) {
                            result = curr;
                        }
                    }
                }
            }
        }
        
        return result;
    }
    
    MazeCell* mazeFor(string name) {
        /* Seed a generator using the provided seed. From this point forward,
         * only use random numbers from this source.
         */
        mt19937 generator((unsigned)hashCode(name, (int)numRows, (int)numCols));
        makeMaze(generator);
        
        /* Place the items and start locations far away from one another. */
        vector<MazeCell*> linearMaze;
        for (size_t row = 0; row < grid.numrows(); row++) {
            for (size_t col = 0; col < grid.numcols(row); col++) {
                linearMaze.push_back(grid(row, col));
            }
        }
        
        Grid<size_t> distances(linearMaze.size(), linearMaze.size());
        allPairsShortestPaths(linearMaze, distances);
        vector<size_t> locations = remoteLocationsIn(distances);
        
        /* Place the items. */
        linearMaze[locations[1]]->whatsHere = "Spellbook";
        linearMaze[locations[2]]->whatsHere = "Potion";
        linearMaze[locations[3]]->whatsHere = "Wand";
        
        return linearMaze[locations[0]];
    }
    
    /* Clears all the links between the given group of nodes. */
    void clearGraph(vector<MazeCell*>& nodes) {
        for (auto* node: nodes) {
            *node = MazeCell();
        }
    }
    
    /* Generates a random real number between 0 and 1. We use this instead of
     * std::uniform_real_distribution because std::uniform_real_distribution is
     * not cross-platform compatible.
     */
    double mtRandomProbability(mt19937& generator) {
        while (true) {
            uint32_t value = generator();
            uint32_t max   = numeric_limits<decltype(value)>::max();
            
            if (value != max) {
                return double(value) / max;
            }
        }
    }
    
    /* Returns a random unassigned link from the given node, or nullptr if
     * they are all assigned.
     */
    MazeCell* MazeCell::* randomFreePortOf(MazeCell* cell, mt19937& generator) {
        vector<MazeCell* MazeCell::*> ports;
        if (cell->east  == nullptr) ports.push_back(&MazeCell::east);
        if (cell->west  == nullptr) ports.push_back(&MazeCell::west);
        if (cell->north == nullptr) ports.push_back(&MazeCell::north);
        if (cell->south == nullptr) ports.push_back(&MazeCell::south);
        if (ports.empty()) return nullptr;
        
        size_t port = mtRandomBetween(0, ports.size() - 1, generator);
        return ports[port];
    }
    
    
    /* Use a variation of the Erdos-Renyi random graph model. We set the
     * probability of any pair of nodes being connected to be ln(n) / n,
     * then artificially constrain the graph so that no node has degree
     * four or more. We generate mazes this way until we find one that's
     * conencted.
     */
    bool erdosRenyiLink(vector<MazeCell*>& nodes, mt19937& generator) {
        /* High probability that everything is connected. */
        double threshold = log(nodes.size()) / nodes.size();
        
        for (size_t i = 0; i < nodes.size(); i++) {
            for (size_t j = i + 1; j < nodes.size(); j++) {
                if (mtRandomProbability(generator) <= threshold) {
                    auto iLink = randomFreePortOf(nodes[i], generator);
                    auto jLink = randomFreePortOf(nodes[j], generator);
                    
                    /* Oops, no free links. */
                    if (iLink == nullptr || jLink == nullptr) {
                        return false;
                    }
                    
                    nodes[i]->*iLink = nodes[j];
                    nodes[j]->*jLink = nodes[i];
                }
            }
        }
        
        return true;
    }
    
    /* Returns whether the given maze is fully connected. */
    bool isConnected(const vector<MazeCell*>& maze) {
        set<MazeCell*> visited;
        queue<MazeCell*> frontier;
        frontier.push(maze[0]);
        
        while (!frontier.empty()) {
            auto* curr = frontier.front();
            frontier.pop();
            
            if (visited.count(curr) == 0) {
                visited.insert(curr);
                
                if (curr->east  != nullptr) frontier.push(curr->east);
                if (curr->west  != nullptr) frontier.push(curr->west);
                if (curr->north != nullptr) frontier.push(curr->north);
                if (curr->south != nullptr) frontier.push(curr->south);
            }
        }
        
        return visited.size() == maze.size();
    }
    
    
    /* Generates a random twisty maze. This works by repeatedly generating
     * random graphs until a connected one is found.
     */
    vector<MazeCell*> makeTwistyMaze(int numNodes, mt19937& generator) {
        vector<MazeCell*> result;
        for (int i = 0; i < numNodes; i++) {
            MazeCell* m =  new MazeCell();
            result.push_back(m);
        }
        
        /* Keep generating mazes until we get a connected one. */
        do {
            clearGraph(result);
        } while (!erdosRenyiLink(result, generator) || !isConnected(result));
        
        return result;
    }
    
    const int kNumTwistyRooms = 12;
    
    MazeCell* twistyMazeFor(const string& name) {
        /* Seed a generator using the provided seed. From this point forward, only
         * use random numbers from this source.
         */
        mt19937 generator((unsigned)hashCode(name, kNumTwistyRooms));
        vector<MazeCell*> maze = makeTwistyMaze(kNumTwistyRooms, generator);
        
        /* Find the distances between all pairs of nodes. */
        Grid<size_t> distances(maze.size(), maze.size());
        allPairsShortestPaths(maze, distances);
        
        /* Select a 4-tuple maximizing the minimum distances between points,
         * and use that as our item/start locations.
         */
        vector<size_t>  locations = remoteLocationsIn(distances);
        
        /* Place the items there. */
        maze[locations[1]]->whatsHere = "Spellbook";
        maze[locations[2]]->whatsHere = "Potion";
        maze[locations[3]]->whatsHere = "Wand";
        
        return maze[locations[0]];
    }
};

