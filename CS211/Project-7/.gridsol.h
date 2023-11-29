/*grid.h*/

// 
// Shanon Reckinger
// Univeristy of Illinois, Chicago
// CS 251, Spring 2021
//

//
// Grid
//
// The Grid class provides a grid (2D array) abstraction.
// The size is set in the constructor cannot change.  All elements
// are initialized to the default value for the given type T.  Example:
//
//   Grid<int>  M;  // 4x4 matrix, initialized to 0
//   
//   M(0, 0) = 123;
//   M(1, 1) = 456;
//   M(2, 2) = 789;
//   M(3, 3) = -99;

#ifndef _GRID_H
#define _GRID_H

#include <iostream>
#include <exception>
#include <stdexcept>
#include <algorithm>

using namespace std;

template<typename T>

class Grid {
private:
  struct ROW {
    T*  Cols;     // dynamic array of column elements
    size_t NumCols;  // total # of columns (0..NumCols-1)
  };

  ROW* Rows;     // dynamic array of ROWs
  size_t  NumRows;  // total # of rows (0..NumRows-1)
    
public:
  //
  // default constructor:
  //
  // Called automatically by C++ to construct a 4x4 grid.  All
  // elements are initialized to the default value of T.
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

  //
  // parameterized constructor:
  //
  // Called automatically by C++ to construct a matrix with R rows, 
  // where each row has C columns. All elements are initialized to 
  // the default value of T.
  //
  Grid(size_t R, size_t C)
  {
    if (R < 1)
      throw invalid_argument("Grid::constructor: # of rows");
    if (C < 1)
      throw invalid_argument("Grid::constructor: # of cols");

    Rows = new ROW[R];  // R rows
    NumRows = R;

    // initialize each row to have C columns:
    for (size_t r = 0; r < NumRows; ++r) {
      Rows[r].Cols = new T[C];
      Rows[r].NumCols = C;

      // initialize the elements to their default value:
      for (size_t c = 0; c < Rows[r].NumCols; ++c) {
        Rows[r].Cols[c] = T();  // default value for type T:
      }
    }
  }
    
//
// destructor:
//
// Called automatically by C++ to free the memory associated by the vector.
//
virtual ~Grid() {
    if (Rows != nullptr) {  // then we have something to free:
        //delete[] Rows;  // since we new'd an array, we delete[] the same array
    }
    for (size_t r = 0; r < NumRows; ++r) {
        delete[] Rows[r].Cols;
    }
    delete[] Rows;

}


  //
  // copy constructor:
  //
  // Called automatically by C++ to construct a matrix that contains a 
  // copy of an existing matrix.  Example: this occurs when passing 
  // Grid as a parameter by value
  //
  //   void somefunction(Grid<int> M2)  <--- M2 is a copy:
  //   { ... }
  //
  Grid(const Grid<T>& other)
  {
    this->Rows = new ROW[other.NumRows];  // same as other matrix:
    this->NumRows = other.NumRows;

    // initialize each row to have same # of columns as other matrix:
    for (size_t r = 0; r < other.NumRows; ++r) {
      size_t other_numcols = other.Rows[r].NumCols;

      this->Rows[r].Cols = new T[other_numcols];
      this->Rows[r].NumCols = other_numcols;

      // initialize our elements to same values as other matrix:
      for (size_t c = 0; c < other_numcols; ++c) {
        this->Rows[r].Cols[c] = other.Rows[r].Cols[c];
      }
    }
  }
    
    //
    // copy operator=
    //
    // Called when you assign one vector into another, i.e. this = other;
    //
    Grid& operator=(const Grid& other) {
        //
        // special case: are we assigning to ourself?
        //
        if (this == &other)
            return *this;
        
        //
        // unlike a copy constructor, *this* vector exists and so we first
        // have to free the memory associated with this vector:
        //
        //delete[] A;  // since we new'd an array, we delete[] an array
        for (size_t r = 0; r < NumRows; ++r) {
            delete[] Rows[r].Cols;
        }
        delete[] Rows;
        
        this->Rows = new ROW[other.NumRows];  // same as other matrix:
        this->NumRows = other.NumRows;
        
        // initialize each row to have same # of columns as other matrix:
        for (size_t r = 0; r < other.NumRows; ++r) {
            size_t other_numcols = other.Rows[r].NumCols;
            
            this->Rows[r].Cols = new T[other_numcols];
            this->Rows[r].NumCols = other_numcols;
            
            // initialize our elements to same values as other matrix:
            for (size_t c = 0; c < other_numcols; ++c) {
                this->Rows[r].Cols[c] = other.Rows[r].Cols[c];
            }
        }
        return *this;
    }

  //
  // numrows
  //
  // Returns the # of rows in the matrix.  The indices for these rows
  // are 0..numrows-1.
  //
  size_t numrows() const {
    return NumRows;
  }
  

  //
  // numcols
  //
  // Returns the # of columns in row r.  The indices for these columns
  // are 0..numcols-1.  Note that the # of columns can be different 
  // row-by-row since "jagged" rows are supported --- matrices are not
  // necessarily rectangular.
  //
  size_t numcols(size_t r) const {
    if (r < 0 || r >= NumRows)
      throw invalid_argument("Grid::numcols: row");

    return Rows[r].NumCols;
  }


  //
  // size
  //
  // Returns the total # of elements in the matrix.
  //
  size_t size() const {
    size_t count = 0;

    //
    // for each row, count the # of columns:
    //
    for (size_t r = 0; r < NumRows; ++r) {
      count += Rows[r].NumCols;
    }

    return count;
  }


  //
  // ()
  //
  // Returns a reference to the element at location (r, c); this
  // allows you to access the element or change it:
  //
  //    M(r, c) = ...
  //    cout << M(r, c) << endl;
  //
  T& operator()(size_t r, size_t c)
  {
    if (r < 0 || r >= NumRows)
      throw invalid_argument("Grid::(): row");
    if (c < 0 || c >= Rows[r].NumCols)
      throw invalid_argument("Grid::(): col");

    return Rows[r].Cols[c];
  }

  //
  // _output
  //
  // Outputs the contents of the matrix; for debugging purposes.
  //
  void _output()
  {
    for (size_t r = 0; r < this->NumRows; ++r)
    {
      for (size_t c = 0; c < this->Rows[r].NumCols; ++c)
      {
        cout << this->Rows[r].Cols[c] << " ";
      }
      cout << endl;
    }
  }

};

#endif //_GRID_H