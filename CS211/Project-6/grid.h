//-------------------------------------------------
// TODO:  Write file header.
//-------------------------------------------------

//-------------------------------------------------
// TODO:  Update the member function comments in 
//        your own style.
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

  //
  // parameterized constructor:
  //
  // Called automatically to construct a Grid 
  // with R rows, where each row has C columns. 
  // All elements initialized to default value of T.
  //
  Grid(size_t R, size_t C) {
    //-------------------------------------------------
    // TODO:  Write this parameterized constructor.
    //-------------------------------------------------

  }
    
  //
  // destructor:
  //
  // Called automatically to free memory for this Grid.
  //
  virtual ~Grid() {

      //-------------------------------------------------
      // TODO:  Write this destructor.
      //-------------------------------------------------


  }


  //
  // copy constructor:
  //
  // Called automatically to construct a Grid that contains a
  // copy of an existing Grid.  Example: this occurs when passing
  // Grid as a parameter by value
  //
  //   void somefunction(Grid<int> G2)  <--- G2 is a copy:
  //   { ... }
  //
  Grid(const Grid<T>& other) {
      
      //-------------------------------------------------
      // TODO:  Write this copy constructor.
      //-------------------------------------------------

  
  }
    
  //
  // copy operator=
  //
  // Called when one Grid is assigned into another, i.e. this = other;
  //
  Grid& operator=(const Grid& other) {
      Grid<T> temp;
      
      //-------------------------------------------------
      // TODO:  Write this copy operator.
      //-------------------------------------------------
    return temp;  // TODO: update this, it is only here so code compiles.
      
  }

  //
  // numrows
  //
  // Returns the # of rows in the Grid.  
  // The indices for these rows are 0..numrows-1.
  //
  size_t numrows() const {
      
    //-------------------------------------------------
    // TODO:  Write this function.
    //-------------------------------------------------
        
    return 0;  // TODO:  update this, it is only here so code compiles.
  }
  

  //
  // numcols
  //
  // Returns the # of columns in row r.  
  // The indices for these columns are 0..numcols-1.  
  // For now, each row has the same number of columns.
  //
  size_t numcols(size_t r) const {
      
      //-------------------------------------------------
      // TODO:  Write this function.
      //-------------------------------------------------
      
      return 0;  // TODO: update this, it is only here so code compiles.

  }


  //
  // size
  //
  // Returns the total # of elements in the Grid.
  //
  size_t size() const {
      
      //-------------------------------------------------
      // TODO:  Write this function.
      //-------------------------------------------------
      
      return 0;  // TODO: update this, it is only here so code compiles.
  }


  //
  // ()
  //
  // Returns a reference to the element at location (r, c);
  // this allows you to access or assign the element:
  //
  //    grid(r, c) = ...
  //    cout << grid(r, c) << endl;
  //
  T& operator()(size_t r, size_t c) {
      T temp;
      
    
      //-------------------------------------------------
      // TODO:  Write the parentheses overloaded operator
      //-------------------------------------------------
      


      return temp;  // TODO: update this, it is only here so code compiles.
  }

  //
  // _output
  //
  // Outputs the contents of the grid; for debugging purposes.  
  // This is not tested.
  //
  void _output() {

      //-------------------------------------------------
      // TODO:  Write this function.
      //-------------------------------------------------
      
      
  }

};
