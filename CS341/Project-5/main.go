// John Ezra See
// Project 5 -- Geometry Using Go Interfaces
// 05/01/25
// main.go -> driver code for the program

package main

import (
	"fmt"
)

var display Display

func getColor(str string) Color {	
	switch str {
		case "red":
			return Color{255, 0, 0}
		case "green":
			return Color{0, 255, 0}
		case "blue":
			return Color{0, 0, 255}
		case "yellow":
			return Color{255, 255, 0}
		case "orange":
			return Color{255, 164, 0}
		case "purple":
			return Color{128, 0, 128}
		case "brown":
			return Color{165, 42, 42}
		case "black":
			return Color{0, 0, 0}
		case "white":
			return Color{255, 255, 255}
		default:
			return Color{-1, -1, -1} // unknown color
	}	
}

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

	// Ask for x - this will be our rows 
	fmt.Print("Enter the number of rows (x) that you would like the display to have: ")
	fmt.Scanln(&xdim)

	// Ask for y - this will be our columns
	fmt.Print("Enter the number of columns (y) that you would like the display to have: ")
	fmt.Scanln(&ydim)
	
	// Allocate memory for our 2D matrix
	matrix := make([][]Color, xdim) // x size - rows
	for i := 0; i < xdim; i++ {
		matrix[i] = make([]Color, ydim) // y size - columns
	}

	display = Display{xdim, ydim, matrix} // x, y is actually rows by columns (counter intuitive)
	display.initialize(xdim, ydim)

	// Queue the main loop
	for {
		// Menu options
		fmt.Println("")
		fmt.Println("Select a shape to draw: ")
		fmt.Println("	 R for a rectangle")
		fmt.Println("	 T for a triangle")
		fmt.Println("	 C for a circle")
		fmt.Println(" or X to stop drawing shapes.")
		fmt.Print("Your choice --> ")

		var userChoice string
		fmt.Scanln(&userChoice)
		
		if userChoice == "R" { // R -> draw a rectangle
			//
			// Drawing a rectangle
			
			// Gather input values
			fmt.Print("Enter the X and Y values of the lower left corner of the rectangle: ")
			var lx, ly int
			fmt.Scanln(&lx, &ly)
			
			fmt.Print("Enter the X and Y values of the upper right corner of the rectangle: ")
			var ux, uy int
			fmt.Scanln(&ux, &uy)
			
			fmt.Print("Enter the color of the rectangle: ")
			var color string
			fmt.Scanln(&color)
			
			// Print shape
			rectangle := Rectangle{Point{lx, ly}, Point{ux, uy}, getColor(color)}
			fmt.Println(rectangle.printShape())

			// Draw shape
			err := rectangle.draw(&display)
			
			if err == outOfBoundsErr { // check for error after drawing
				fmt.Println(outOfBoundsErr)
			} else if err == colorUnknownErr {
				fmt.Println(colorUnknownErr)
			} else {
				fmt.Println("Rectangle drawn successfully.")
			}
		} else if userChoice == "T" { // T -> draw a triangle
			//
			// Drawing a triangle

			// Gather input values
			fmt.Print("Enter the X and Y values of the first point of the triangle: ")
			var pt0x, pt0y int
			fmt.Scanln(&pt0x, &pt0y)

			fmt.Print("Enter the X and Y values of the second point of the triangle: ")
			var pt1x, pt1y int
			fmt.Scanln(&pt1x, &pt1y)

			fmt.Print("Enter the X and Y values of the third point of the triangle: ")
			var pt2x, pt2y int
			fmt.Scanln(&pt2x, &pt2y)

			fmt.Print("Enter the color of the triangle: ")
			var color string
			fmt.Scanln(&color)
			
			// Print shape
			triangle := Triangle{Point{pt0x, pt0y}, Point{pt1x, pt1y}, Point{pt2x, pt2y}, getColor(color)}
			fmt.Println(triangle.printShape())
			
			// Draw shape
			err := triangle.draw(&display)
			
			if err == outOfBoundsErr { // check for error after drawing
				fmt.Println(outOfBoundsErr)
			} else if err == colorUnknownErr {
				fmt.Println(colorUnknownErr)
			} else {
				fmt.Println("Triangle drawn successfully.")
			}

		} else if userChoice == "C" { // C -> draw a circle
			//
			// Drawing a circle

			// Gather input values
			fmt.Print("Enter the X and Y values of the center of the circle: ")
			var x, y int
			fmt.Scanln(&x, &y)

			fmt.Print("Enter the value of the radius of the circle: ")
			var r int
			fmt.Scanln(&r)

			fmt.Print("Enter the color of the circle: ")
			var color string
			fmt.Scanln(&color)

			// Print shape
			circle := Circle{Point{x, y}, r, getColor(color)}
			fmt.Println(circle.printShape())
			
			// Draw shape
			err := circle.draw(&display)

			if err == outOfBoundsErr { // check for error after drawing
				fmt.Println(outOfBoundsErr)
			} else if err == colorUnknownErr {
				fmt.Println(colorUnknownErr)
			} else {
				fmt.Println("Circle drawn successfully.")
			}

		} else if userChoice == "X" { // X -> terminate
			break
		} else {
			fmt.Println("**Error, unknown command. Try again.")
			continue
		}
	}
	//
	//
	// Saving the results in a file
	fmt.Print("Enter the name of the .ppm file in which the results should be saved: ")
	var outputFile string
	fmt.Scanln(&outputFile)
	display.screenShot(outputFile)

	//
	// Exiting program
	fmt.Println("Done. Exiting program...")
}