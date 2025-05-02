// John Ezra See
// Project 5 -- Geometry Using Go Interfaces
// 05/01/25
// draw.go -> supporting file, defines geometry interfaces and structs

package main

import (
	"errors"
	"fmt"
	"math"
	"os"
)

// ----------------------------------------------------------------------
//
// Define Color type
type Color struct {
	r, g, b int
}

// Point struct
//
//	x: the x position of the point
//	y: the y position of the point
type Point struct {
	x, y int
}

// Rectangle struct
//
//	ll: a Point representing the lower-left corner of the rectangle
//	ur: a Point representing the upper-right corner of the rectangle
//	c: the color of the rectangle
type Rectangle struct {
	ll, ur Point
	c      Color
}

// Triangle struct
//
//	pt0: a Point representing the first point of the triangle
//	pt1: a Point representing the second point of the triangle
//	pt2: a Point representing the third point of the triangle
//	c: the color of the triangle
type Triangle struct {
	pt0, pt1, pt2 Point
	c             Color
}

// Circle struct
//
//	center: a Point representing the center of the circle
//	r: an integer representing the radius of the circle
//	c: the color of the circle
type Circle struct {
	center Point
	r      int
	c      Color
}

// Display struct
//
//	maxX: the dimension of the display on the X-axis
//	maxY: the dimension of the display on the Y-axis
//	matrix: a slice of slices in which each element represents
//			the current color on the display for the given pixel
type Display struct {
	maxX, maxY int
	matrix     [][]Color
}

// Geometry interface
// Each type that implements this interface should implement the following methods:
//
//	draw() - Draw the filled-in shape on the screen
//	printShape() - Print the type of the object
type geometry interface {
	draw(scn screen) (err error)
	printShape() (s string)
}

// Screen interface
// Each type that implements this interface should implement the following methods:
//
//	initialize() - 	Initialize a screen of maxX times maxY
//				   	Called before any other method in screen interface
//				   	Clears the screen so that it is all white
//	getMaxXY() - 	Retrieve and return the maxX and maxY dimensions of the screen
//	drawPixel() -	Draw the pixel with a given color at a given location
//	getPixel() - 	Retrieve and return the color of the pixel at a given location
//	clearScreen() - Clear the whole screen by setting each pixel to white
//	screenShot() - 	Write the screen to a .ppm file
//					(which you can then view graphically with an image viewer)
type screen interface {
	initialize(x, y int)
	getMaxXY() (x, y int)
	drawPixel(x, y int, c Color) (err error)
	getPixel(x, y int) (c Color, err error)
	clearScreen()
	screenShot(f string) (err error)
}

// Package level variables for errors
//
//	outOfBoundsErr - Thrown when the figure is out of bounds of the screen
//	colorUnknownErr - Thrown when a Color is not valid
var outOfBoundsErr error
var colorUnknownErr error

// ----------------------------------------------------------------------
//
// init()
// Called before main(), sets the package level variables for errors
func init() {
	outOfBoundsErr = errors.New("**Error: Attempt to draw a figure out of bounds of the screen.")
	colorUnknownErr = errors.New("**Error: Attempt to use an invalid color.")
}

// ----------------------------------------------------------------------
//
// outOfBounds()
// Check if a given point would go out of bounds of the screen (return true)
// or not (return false)
func outOfBounds(p Point, scn screen) bool {
	maxX, maxY := scn.getMaxXY()
	// maxX and maxY are inclusive because that's 0-indexed
	if p.x < 0 || p.y < 0 || p.x >= maxX || p.y >= maxY {
		return true
	} else { // otherwise, false
		return false;
	}
}

// ----------------------------------------------------------------------
//
// colorUnknown()
// Check if a given color is unknown (return true) or known (return false)
func colorUnknown(c Color) bool {
	knowns := []Color{ // Initialize an array of known colors
		{255, 0, 0},    
		{0, 255, 0},    
		{0, 0, 255},    
		{255, 255, 0},  
		{255, 164, 0},  
		{128, 0, 128},  
		{165, 42, 42},  
		{0, 0, 0},      
		{255, 255, 255},
	}

	// loop through all the known colors
	for _, color := range knowns {
		// check if our given parameter matches any known color, then it's NOT unknown.
		if color.r == c.r && color.g == c.g && color.b == c.b {
			return false;
		}
	}
	return true
}

// ----------------------------------------------------------------------
//
// draw() method with Rectangle receiver
// Draws a filled in rectangle
func (rect Rectangle) draw(scn screen) (err error) {
	// validate
	// Check if drawing this rectangle would cause either error
	if outOfBounds(rect.ll, scn) || outOfBounds(rect.ur, scn) {
		return outOfBoundsErr
	}
	if colorUnknown(rect.c) {
		return colorUnknownErr
	}

	// make changes
	for x := rect.ll.x; x <	rect.ur.x; x++ {
		for y := rect.ll.y; y < rect.ur.y; y++ {
			scn.drawPixel(x, y, rect.c)
		}
	} 

	return 
}

// ----------------------------------------------------------------------
//
// printShape() method with Rectangle receiver
// Prints the type (a Rectangle)
func (rect Rectangle) printShape() string {
	return fmt.Sprintf("Rectangle: (%d,%d) to (%d,%d)", rect.ll.x, rect.ll.y, rect.ur.x, rect.ur.y)
}

// ----------------------------------------------------------------------
//
// draw() method with Triangle receiver
// Draws a filled in triangle
// Reference: https://gabrielgambetta.com/computer-graphics-from-scratch/07-filled-triangles.html
//
// interpolate() is a helper function
func interpolate(l0, d0, l1, d1 int) (values []int) {
	a := float64(d1-d0) / float64(l1-l0)
	d := float64(d0)

	count := l1 - l0 + 1
	for ; count > 0; count-- {
		values = append(values, int(d))
		d = d + a
	}
	return
}

func (tri Triangle) draw(scn screen) (err error) {
	// Check if drawing this triangle would cause either error
	if outOfBounds(tri.pt0, scn) || outOfBounds(tri.pt1, scn) || outOfBounds(tri.pt2, scn) {
		return outOfBoundsErr
	}
	if colorUnknown(tri.c) {
		return colorUnknownErr
	}
	y0 := tri.pt0.y
	y1 := tri.pt1.y
	y2 := tri.pt2.y

	// Sort the points so that y0 <= y1 <= y2
	if y1 < y0 {
		tri.pt1, tri.pt0 = tri.pt0, tri.pt1
	}
	if y2 < y0 {
		tri.pt2, tri.pt0 = tri.pt0, tri.pt2
	}
	if y2 < y1 {
		tri.pt2, tri.pt1 = tri.pt1, tri.pt2
	}
	x0, y0, x1, y1, x2, y2 := tri.pt0.x, tri.pt0.y, tri.pt1.x, tri.pt1.y, tri.pt2.x, tri.pt2.y

	x01 := interpolate(y0, x0, y1, x1)
	x12 := interpolate(y1, x1, y2, x2)
	x02 := interpolate(y0, x0, y2, x2)

	// Concatenate the short sides
	x012 := append(x01[:len(x01)-1], x12...)

	// Determine which is left and which is right
	var x_left, x_right []int
	m := len(x012) / 2
	if x02[m] < x012[m] {
		x_left = x02
		x_right = x012
	} else {
		x_left = x012
		x_right = x02
	}

	// Draw the horizontal segments
	for y := y0; y <= y2; y++ {
		for x := x_left[y-y0]; x <= x_right[y-y0]; x++ {
			scn.drawPixel(x, y, tri.c)
		}
	}
	return
}

// ----------------------------------------------------------------------
//
// printShape() method with Triangle receiver
// Prints the type (a Triangle)
func (tri Triangle) printShape() string {
	return fmt.Sprintf("Triangle: (%d,%d), (%d,%d), (%d,%d)", tri.pt0.x, tri.pt0.y, tri.pt1.x, tri.pt1.y, tri.pt2.x, tri.pt2.y)
}

// ----------------------------------------------------------------------
//
// draw() method with Circle receiver
// Draws a filled in circle
// Reference: https://www.redblobgames.com/grids/circle-drawing/
//
// insideCircle() is a helper function
func insideCircle(center, tile Point, r float64) (inside bool) {
	var dx float64 = float64(center.x - tile.x)
	var dy float64 = float64(center.y - tile.y)
	var distance float64 = math.Sqrt(dx*dx + dy*dy)
	return distance <= r
}

func (circ Circle) draw(scn screen) (err error) {
	// Check if drawing this circle would cause either error
	if outOfBounds(Point{circ.center.x - circ.r, circ.center.y}, scn) || // left
	   outOfBounds(Point{circ.center.x + circ.r, circ.center.y}, scn) || // right
	   outOfBounds(Point{circ.center.x, circ.center.y - circ.r}, scn) || // top
	   outOfBounds(Point{circ.center.x, circ.center.y + circ.r}, scn) {  // bottom
		return outOfBoundsErr
 	}
	if colorUnknown(circ.c) {
		return colorUnknownErr
	}
	
	height := circ.center.y + circ.r
	width := circ.center.x + circ.r
	for y := 0; y < height; y++ {
		for x := 0; x < width; x++ {
			if insideCircle(circ.center, Point{x, y}, float64(circ.r)) {
				scn.drawPixel(x, y, circ.c)
			}
		}
	}
	return
}

// ----------------------------------------------------------------------
//
// printShape() method with Circle receiver
// Prints the type (a Circle)
func (circ Circle) printShape() string {
	return fmt.Sprintf("Circle: centered around (%d,%d) with radius %d", circ.center.x, circ.center.y, circ.r)
}

// ----------------------------------------------------------------------
//
// clearScreen() method with Display pointer receiver
// Clears the screen by resetting it to white
func (display *Display) clearScreen() {
	// Loop through every cell in the matrix and set colors to white.
	for x := 0; x < display.maxX; x++ {
		for y := 0; y < display.maxY; y++ {
			display.matrix[x][y].r = 255
			display.matrix[x][y].g = 255
			display.matrix[x][y].b = 255
		}
	}
}

// ----------------------------------------------------------------------
//
// initialize() method with Display pointer receiver
// Initializes a screen of maxX times maxY
// Clears the screen so that it is all white
func (display *Display) initialize(x, y int) {
	maxX := x
	maxY := y
	// Loop through every cell in the matrix and set colors to white.
	for x := 0; x < maxX; x++ {
		for y := 0; y < maxY; y++ {
			// Make default screen white
			display.matrix[x][y].r = 255
			display.matrix[x][y].g = 255
			display.matrix[x][y].b = 255
		}
	}
}

// ----------------------------------------------------------------------
//
// getMaxXY() method with Display pointer receiver
// Retrieve and return the maxX and maxY dimensions of the screen
func (display *Display) getMaxXY() (x, y int) {
	return display.maxX, display.maxY
}

// ----------------------------------------------------------------------
//
// drawPixel() method with Display pointer receiver
// Draw the pixel with a given color at a given location
func (display *Display) drawPixel(x, y int, c Color) (err error) {
	display.matrix[x][y] = c
	return
}

// ----------------------------------------------------------------------
//
// getPixel() method with Display pointer receiver
// Retrieve and return the color of the pixel at a given location
func (display *Display) getPixel(x, y int) (c Color, err error) {
	if x < 0 || x >= display.maxX || y < 0 || y >= display.maxY {
		return Color{0, 0, 0}, outOfBoundsErr
	}
	return display.matrix[y][x], nil
}

// ----------------------------------------------------------------------
//
// screenShot() method with Display pointer receiver
// Write the screen to a .ppm file
// (which you can then view graphically with an image viewer)
func (display *Display) screenShot(f string) (err error) {
	file, e := os.Create(f + ".ppm")
	err = e
	if err != nil {
		fmt.Println("**Error creating ppm file: ", err)
		return
	}

	fmt.Fprintln(file, "P3")
	fmt.Fprintf(file, "%d %d\n", display.maxX, display.maxY)
	fmt.Fprintln(file, "255") // Maximum color value

	for x := 0; x < display.maxX; x++ {
		for y := 0; y < display.maxY; y++ {
			c := display.matrix[x][y]
			fmt.Fprintf(file, "%d %d %d ", c.r, c.g, c.b)
		}
		fmt.Fprintln(file)
	}
	return nil
}