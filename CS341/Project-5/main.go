// John Ezra See
// Project 5 -- Geometry Using Go Interfaces
// 04/29/25

package main

import (
	"fmt"
)

var display Display

func main() {
	// Print intro message
	fmt.Println("Project 5: Geometry Using Go Interfaces")
	fmt.Println("CS 341, Spring 2025")
	fmt.Println("")
	fmt.Println("This application allows you to draw various shapes")
	fmt.Println("of different colors via interfaces in Go.")
	fmt.Println("")

	//
	// SOME PRINT STATEMENTS YOU WILL NEED CAN BE FOUND BELOW
	//
	// Ask user for dimensions for display
	var xdim, ydim int

	fmt.Print("Enter the number of rows (x) that you would like the display to have: ")
	fmt.Scanln(&xdim)

	fmt.Print("Enter the number of columns (y) that you would like the display to have: ")
	fmt.Scanln(&ydim)
	
	matrix := make([][]Color, ydim)
	for i := 0; i < ydim; i++ {
		matrix[i] = make([]Color, xdim)
	}

	display = Display{xdim, ydim, &matrix}
	for {
		// Menu options
		fmt.Println("")
		fmt.Println("Select a shape to draw: ")
		fmt.Println("	 R for a rectangle")
		fmt.Println("	 T for a triangle")
		fmt.Println("	 C for a circle")
		fmt.Println(" or X to stop drawing shapes.")
		fmt.Print("Your choice --> ")
		fmt.Println("**Error, unknown command. Try again.")
		//
		// Drawing a rectangle
		fmt.Print("Enter the X and Y values of the lower left corner of the rectangle: ")
		fmt.Print("Enter the X and Y values of the upper right corner of the rectangle: ")
		fmt.Print("Enter the color of the rectangle: ")
		fmt.Println("Rectangle drawn successfully.")
		//
		// Drawing a triangle
		fmt.Print("Enter the X and Y values of the first point of the triangle: ")
		fmt.Print("Enter the X and Y values of the second point of the triangle: ")
		fmt.Print("Enter the X and Y values of the third point of the triangle: ")
		fmt.Print("Enter the color of the triangle: ")
		fmt.Println("Triangle drawn successfully.")
		//
		// Drawing a circle
		fmt.Print("Enter the X and Y values of the center of the circle: ")
		fmt.Print("Enter the value of the radius of the circle: ")
		fmt.Print("Enter the color of the circle: ")
		fmt.Println("Circle drawn successfully.")
		//
		// Saving the results in a file
		fmt.Print("Enter the name of the .ppm file in which the results should be saved: ")
	}
	//
	//
	// Exiting program
	fmt.Println("Done. Exiting program...")
}
