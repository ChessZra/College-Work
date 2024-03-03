#include <iostream>

#include "canvaslist.h"
#include "shape.h"

using namespace std;

int main()
{
	CanvasList myCanvas;
	cout << "List size: " << myCanvas.size() << endl;
	cout << "Front: " << myCanvas.front() << endl;

	cout << endl << endl << "Adding Shape to the front" << endl;
	Shape *s = new Shape(1, 3);
	myCanvas.push_front(s);
	cout << "List size: " << myCanvas.size() << endl;
	myCanvas.draw();

	cout << endl << endl << "Adding Shape to the front" << endl;
	Shape *p = new Shape(4, 6);
	myCanvas.push_front(p);
	cout << "List size: " << myCanvas.size() << endl;
	myCanvas.draw();


	cout << endl << endl << "Adding Shape to the back" << endl;
	Shape *b = new Shape(4, 6);
	myCanvas.push_back(b);
	cout << "List size: " << myCanvas.size() << endl;
	myCanvas.draw();

	// comment out the circle, rectangle, and right triangle calls
	// until you have those classes implemented
	cout << endl << endl << "Adding Circle to the front" << endl;
	s = new Circle(2, 4, 3);
	myCanvas.push_front(s);
	cout << "List size: " << myCanvas.size() << endl;
	myCanvas.draw();

	cout << endl << endl << "Adding Rectangle to the back" << endl;
	s = new Rect(0, 10);
	myCanvas.push_back(s);
	cout << "List size: " << myCanvas.size() << endl;
	myCanvas.draw();

	cout << endl << endl << "Adding Right Triangle to the front" << endl;
	s = new RightTriangle(1, 2, 3, 4);
	myCanvas.push_front(s);
	cout << "List size: " << myCanvas.size() << endl;
	myCanvas.draw();

	cout << endl << endl << "Deleting last element" << endl;
	delete myCanvas.pop_back();
	cout << "List size: " << myCanvas.size() << endl;
	myCanvas.draw();

	cout << endl << endl << "Inserting Shape after index 1" << endl;
	cout << "Original:" << endl;
	myCanvas.draw();
	myCanvas.insert_after(1, new Shape(3,4));
	cout << "Updated Original:" << endl;
	myCanvas.draw();


	cout << endl << endl;
	cout << "Addresses:" << endl;
	myCanvas.print_addresses();
	return 0;
}