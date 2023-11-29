//-------------------------------------------------
// TODO:  Copy in your Grid class OR replace this 
//          file with grid.h from Project 06.
//          This class is needed for this Project,
//          but it is not tested independently.
//-------------------------------------------------

#pragma once

#include <iostream>
#include <exception>
#include <stdexcept>
#include <algorithm>

using namespace std;

template<typename T>
class Grid {
private:
  struct ROW {
    T*  Cols;     // array of column elements
    size_t NumCols;  // total # of columns (0..NumCols-1)
  };

  ROW* Rows;     // array of ROWs
  size_t  NumRows;  // total # of rows (0..NumRows-1)
    
public:
  //
  // default constructor:
  //
  // Called automatically by to construct a 4x4 Grid. 
  // All elements initialized to default value of T.
  //
  Grid() {
    Rows = new ROW[4];  // 4 rows
    NumRows = 4;

    // initialize each row to have 4 columns:
    for (size_t r = 0; r < NumRows; ++r) {
      Rows[r].Cols = new T[4];
      Rows[r].NumCols = 4;

      // initialize the elements to their default value:
      for (size_t c = 0; c < Rows[r].NumCols; ++c) {
        Rows[r].Cols[c] = T();  // default value for type T:
      }
    }
  }

  /** Constructor:                                                                    - -
      This function is the parameterized constructor for the Grid class which
      creates a RxC Grid. This initializes all the default value of T.                */
  Grid(size_t R, size_t C) {
    // Check if invalid R or C
    if (R < 1) {
        throw invalid_argument("LetterGrid::constructor: # of rows");
    }
    if (C < 1) {
        throw invalid_argument("LetterGrid::constructor: # of cols");
    }
    Rows = new ROW[R]; 
    NumRows = R;

    // initialize each row to have C columns:
    for (size_t r = 0; r < NumRows; ++r) {
      Rows[r].Cols = new T[C];
      Rows[r].NumCols = C;

      // initialize the elements to their default value:
      for (size_t c = 0; c < C; ++c) {
        Rows[r].Cols[c] = T();  // default value for type T:
      }
    }
  }
    
  /** Destructor:                                                                     - -
      This function frees the memory of the entire grid                               */
  virtual ~Grid() {
    for (size_t r = 0; r < NumRows; r++) {
        delete[] Rows[r].Cols;
    }
    delete[] Rows;
  }

  /** Copy Constructor:                                                               - -
      This function is the copy constructor which takes in a Grid of type T object then
      copies then attempts to deep copy the given grid - changes the subitems.        */
  Grid(const Grid<T>& other) {
    size_t R = other.NumRows;
    Rows = new ROW[R]; 
    NumRows = R;

    // initialize each row to have C columns:
    for (size_t r = 0; r < NumRows; ++r) {
      size_t C = other.Rows[r].NumCols;
      Rows[r].Cols = new T[C];
      Rows[r].NumCols = C;

      // initialize the elements to their copied value type:
      for (size_t c = 0; c < C; ++c) {
        Rows[r].Cols[c] = other.Rows[r].Cols[c];
      }
    }
  
  }

  /** Copy Operator:                                                                  - -
      This function returns a reference to a new Grid that is a clone of the given
      grid.                                                                           */
  Grid& operator=(const Grid& other) {
      // If other is the same object as what you're trying to create, just return the object:
      if (this == &other) { 
          return *this;
      }
      
      // Free up the old array before assigning a new object:
      for (size_t r = 0; r < NumRows; ++r) {
          delete[] Rows[r].Cols;
      }
      delete[] Rows;
      
      // Now, we make an exact copy below this line:
      // Sets up the attributes:
      Rows = new ROW[other.NumRows];  
      NumRows = other.NumRows;
      
      // Build the array (Rows):
      // Same logic as the constructors:
      for (size_t r = 0; r < other.NumRows; ++r) {
          size_t C = other.Rows[r].NumCols;
          
          Rows[r].Cols = new T[C];
          Rows[r].NumCols = C;
          
          for (size_t c = 0; c < C; ++c) {
              Rows[r].Cols[c] = other.Rows[r].Cols[c];
          }
      }
   
      return *this;
  }

  /** numrows:                                                                        - -
      This function returns the number of rows in the grid.                           */
  size_t numrows() const {
    return NumRows; 
  }
  
  /** numcols:                                                                        - -
      This function returns the number of columns in grid[r]                          */
  size_t numcols(size_t r) const {
      return Rows[r].NumCols;  
  }

  /** size:                                                                           - -
      This function returns the number of rows in the grid.                           */
  size_t size() const {
      size_t ret = 0;
      for (size_t r = 0; r < NumRows; r++) {
        ret += Rows[r].NumCols;
      }
      return ret;
  }

  /** () operator:                                                                    - -
      This function returns a reference to the element at location (r,c) in the grid.
      This will allow easier access or assignment to elements by doing:
        grid(r, c) = ...
        cout << grid(r, c);                               `                           */
  T& operator()(size_t r, size_t c) {
    if (r < 0 || r >= NumRows) {
        throw invalid_argument("Grid::constructor: # of rows");
    }
    if (c < 0 || c >= Rows[r].NumCols) {
        throw invalid_argument("Grid::constructor: # of cols");
    }
      T& ret = Rows[r].Cols[c];

      return ret; 
  }

  /** _output:                                                                        - -
      This function outputs.                                                          */
  void _output() {
      cout << "This is a test print function()" << endl;
  }
};
