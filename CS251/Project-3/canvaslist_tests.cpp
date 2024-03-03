#include <gtest/gtest.h>

#include "canvaslist.h"
#include "shape.h"


TEST(SHAPE, Shape) {
  Shape c1;

  EXPECT_EQ(0, c1.getX());
  EXPECT_EQ(0, c1.getY());

  c1.setX(5);
  c1.setY(6);

  EXPECT_EQ(5, c1.getX());
  EXPECT_EQ(6, c1.getY());
  EXPECT_EQ("It's a Shape at x: 5, y: 6", c1.as_string());
}

TEST(SHAPE, Circle) {
  // Default Constructor:
  Circle c1;

  EXPECT_EQ(0, c1.getX());
  EXPECT_EQ(0, c1.getY());
  EXPECT_EQ(0, c1.getRadius());

  c1.setX(5);
  c1.setY(6);
  c1.setRadius(3);

  EXPECT_EQ(5, c1.getX());
  EXPECT_EQ(6, c1.getY());
  EXPECT_EQ(3, c1.getRadius());
  EXPECT_EQ("It's a Circle at x: 5, y: 6, radius: 3", c1.as_string());

  // Overloaded constructors:
  Circle c2(5);
  EXPECT_EQ(0, c2.getX());
  EXPECT_EQ(0, c2.getY());
  EXPECT_EQ(5, c2.getRadius());

  Circle c3(10, 15, 20);
  EXPECT_EQ(10, c3.getX());
  EXPECT_EQ(15, c3.getY());
  EXPECT_EQ(20, c3.getRadius());
}

TEST(SHAPE, Rect) {
  // Default Constructor:
  Rect c1;

  EXPECT_EQ(0, c1.getX());
  EXPECT_EQ(0, c1.getY());
  EXPECT_EQ(0, c1.getWidth());
  EXPECT_EQ(0, c1.getHeight());

  c1.setX(5);
  c1.setY(6);
  c1.setWidth(0);
  c1.setHeight(10);

  EXPECT_EQ(5, c1.getX());
  EXPECT_EQ(6, c1.getY());
  EXPECT_EQ(0, c1.getWidth());
  EXPECT_EQ(10, c1.getHeight());
  EXPECT_EQ("It's a Rectangle at x: 5, y: 6 with width: 0 and height: 10", c1.as_string());

  // Overloaded Constructors:
  Rect c2(5, 10);
  EXPECT_EQ(0, c2.getX());
  EXPECT_EQ(0, c2.getY());
  EXPECT_EQ(5, c2.getWidth());
  EXPECT_EQ(10, c2.getHeight());

  Rect c3(5, 10, 15, 20);
  EXPECT_EQ(5, c3.getX());
  EXPECT_EQ(10, c3.getY());
  EXPECT_EQ(15, c3.getWidth());
  EXPECT_EQ(20, c3.getHeight());
}

TEST(SHAPE, RightTriangle) {
  // Default Constructor:
  RightTriangle c1;

  EXPECT_EQ(0, c1.getX());
  EXPECT_EQ(0, c1.getY());
  EXPECT_EQ(0, c1.getBase());
  EXPECT_EQ(0, c1.getHeight());

  c1.setX(5);
  c1.setY(6);
  c1.setBase(0);
  c1.setHeight(10);

  EXPECT_EQ(5, c1.getX());
  EXPECT_EQ(6, c1.getY());
  EXPECT_EQ(0, c1.getBase());
  EXPECT_EQ(10, c1.getHeight());
  EXPECT_EQ("It's a Right Triangle at x: 5, y: 6 with base: 0 and height: 10", c1.as_string());
  
  // Overloaded Constructors:
  RightTriangle c2(5, 10);
  EXPECT_EQ(0, c2.getX());
  EXPECT_EQ(0, c2.getY());
  EXPECT_EQ(5, c2.getBase());
  EXPECT_EQ(10, c2.getHeight());

  RightTriangle c3(5, 10, 15, 20);
  EXPECT_EQ(5, c3.getX());
  EXPECT_EQ(10, c3.getY());
  EXPECT_EQ(15, c3.getBase());
  EXPECT_EQ(20, c3.getHeight());
}

TEST(SHAPE, AllCopyFunctions) {
  // Circle copy():
  Circle c1(10, 15, 20);
  Circle* c2 = c1.copy();
  EXPECT_EQ(10, c2->getX());
  EXPECT_EQ(15, c2->getY());
  EXPECT_EQ(20, c2->getRadius());
  delete c2;

  // Rect copy():
  Rect c3(10, 15, 20, 25);
  Rect* c4 = c3.copy();
  EXPECT_EQ(10, c4->getX());
  EXPECT_EQ(15, c4->getY());
  EXPECT_EQ(20, c4->getWidth());
  EXPECT_EQ(25, c4->getHeight());
  delete c4;

  // Right Triangle copy():
  RightTriangle c5(10, 15, 20, 25);
  RightTriangle* c6 = c5.copy();
  EXPECT_EQ(10, c6->getX());
  EXPECT_EQ(15, c6->getY());
  EXPECT_EQ(20, c6->getBase());
  EXPECT_EQ(25, c6->getHeight());
  delete c6;

}

TEST(CANVASLIST, Size) {
  // Empty Canvas:
  CanvasList myList = CanvasList();
  EXPECT_EQ(0, myList.size());
  EXPECT_EQ(true, myList.empty());

  // Non-empty Canvas:
  CanvasList myCanvas2;
  Shape *s = new Shape(1, 3);
  myCanvas2.push_front(s);
  Shape *p = new Shape(4, 6);
  myCanvas2.push_front(p);
  Shape *b = new Shape(4, 6);
  myCanvas2.push_back(b);

  EXPECT_EQ(3, myCanvas2.size());
}

TEST(CANVASLIST, Front) {
  // Empty Canvas:
  CanvasList myList = CanvasList();
  EXPECT_EQ(nullptr, myList.front());
  EXPECT_EQ(true, myList.empty());

  // Non-empty Canvas:
  CanvasList myCanvas2;
  Shape *s = new Shape(1, 3);
  myCanvas2.push_front(s);
  Shape *p = new Shape(4, 6);
  myCanvas2.push_front(p);
  Shape *b = new Shape(4, 6);
  myCanvas2.push_back(b);

  EXPECT_EQ(p, myCanvas2.front()->value);
}

TEST(CANVASLIST, PushFrontBack) {
  CanvasList myList = CanvasList();
  Shape* shape = new Shape();

  // Pushing front:
  myList.push_front(shape);
  EXPECT_EQ(1, myList.size());
  EXPECT_EQ(shape, myList.front()->value);

  // Pushing back:
  Shape* shape2 = new Shape();
  myList.push_back(shape2);
  EXPECT_EQ(2, myList.size());
  EXPECT_EQ(shape, myList.front()->value);
}

TEST(CANVASLIST, CopyConstructor) {
  // Canvas that has multiple elements:
  CanvasList ToBeCopied;
  Shape *s = new Shape(1, 3);
  ToBeCopied.push_front(s);
  Shape *p = new Shape(4, 6);
  ToBeCopied.push_front(p);
  Shape *b = new Shape(4, 6);
  ToBeCopied.push_back(b);

  CanvasList myCanvas(ToBeCopied);
  EXPECT_EQ(3, myCanvas.size());
}

TEST(CANVASLIST, Find) {
  // Three shapes in the linked list:
  CanvasList myCanvas;
  Shape *s = new Shape(1, 3);
  myCanvas.push_front(s);
  Shape *p = new Shape(4, 6);
  myCanvas.push_front(p);
  Shape *b = new Shape(4, 6);
  myCanvas.push_back(b);
  EXPECT_EQ(1, myCanvas.find(1, 3));

  // Zero shapes in the linked list:
  CanvasList myCanvas2;
  EXPECT_EQ(-1, myCanvas2.find(1, 3));

  // One shape in the linked list:
  CanvasList myCanvas3;
  Shape *s3 = new Shape(4, 6);
  myCanvas3.push_back(s3);
  EXPECT_EQ(0, myCanvas3.find(4, 6));
}

TEST(CANVASLIST, ShapeAt) {
  CanvasList myCanvas;
  Shape *s = new Shape(1, 3);
  myCanvas.push_front(s);
  Shape *p = new Shape(4, 6);
  myCanvas.push_front(p);
  Shape *b = new Shape(4, 6);
  myCanvas.push_back(b);

  EXPECT_EQ(s, myCanvas.shape_at(1));

  CanvasList myCanvas2;
  EXPECT_EQ(nullptr, myCanvas2.shape_at(-1));
  EXPECT_EQ(nullptr, myCanvas2.shape_at(0));
}

TEST(CANVASLIST, InsertAfter) {
  // A canvas with multiple elements:
  CanvasList myCanvas;
  Shape *s = new Shape(1, 3);
  myCanvas.push_front(s);
  Shape *p = new Shape(4, 6);
  myCanvas.push_front(p);
  Shape *b = new Shape(4, 6);
  myCanvas.push_back(b);

  // Insert after invalid index
  myCanvas.insert_after(-1, new Shape(50, 50));
  myCanvas.insert_after(3, new Shape(50, 50));

  // Insert after valid index
  myCanvas.insert_after(2, new Shape(50, 50));
  EXPECT_EQ("It's a Shape at x: 50, y: 50", myCanvas.shape_at(3)->as_string());

  // Insert in an empty canvas:
  CanvasList myEmptyCanvas;
  myEmptyCanvas.insert_after(0, new Shape(50, 50));
  EXPECT_EQ(0, myEmptyCanvas.size());

  // Insert in a canvas with one element:
  CanvasList myLonelyCanvas;
  Shape *tmp = new Shape(11, 22);
  myLonelyCanvas.push_back(tmp);
  myLonelyCanvas.insert_after(0, new Shape(50, 50));
  EXPECT_EQ(2, myLonelyCanvas.size());
}

TEST(CANVASLIST, PopBack) {
  // EMPTY LIST:
  CanvasList myEmptyCanvas;
  EXPECT_EQ(nullptr, myEmptyCanvas.pop_back());
  EXPECT_EQ(0, myEmptyCanvas.size());

  // ONE ITEM IN THE LIST:
  CanvasList myCanvas;
  Shape *s = new Shape(1, 3);
  myCanvas.push_front(s);
  
  Shape* retrieved = myCanvas.pop_back();
  EXPECT_EQ(s, retrieved);
  EXPECT_EQ(0, myCanvas.size());
  delete retrieved;

  // MULTIPLE ITEMS IN THE LIST:
  CanvasList myCanvas2;
  Shape *snp = new Shape(1, 3);
  myCanvas2.push_front(snp);
  Shape *p = new Shape(4, 6);
  myCanvas2.push_front(p);
  Shape *b = new Shape(4, 6);
  myCanvas2.push_back(b);
  EXPECT_EQ(b, myCanvas2.pop_back());
  EXPECT_EQ(2, myCanvas2.size());

  delete b;
}

TEST(CANVASLIST, PopFront) {
  // EMPTY LIST:
  CanvasList myEmptyCanvas;
  EXPECT_EQ(nullptr, myEmptyCanvas.pop_front());
  EXPECT_EQ(0, myEmptyCanvas.size());

  // ONE ITEM IN THE LIST:
  CanvasList myCanvas;
  Shape *s = new Shape(1, 3);
  myCanvas.push_front(s);
  EXPECT_EQ(s, myCanvas.pop_front());
  EXPECT_EQ(0, myCanvas.size());

  // MULTIPLE ITEMS IN THE LIST:
  CanvasList myCanvas2;
  Shape *snp = new Shape(1, 3);
  myCanvas2.push_front(snp);
  Shape *p = new Shape(4, 6);
  myCanvas2.push_front(p);
  Shape *b = new Shape(4, 6);
  myCanvas2.push_back(b);
  EXPECT_EQ(p, myCanvas2.pop_front());
  EXPECT_EQ(2, myCanvas2.size());

  delete s;
  delete p;
}

TEST(CANVASLIST, Clear) {
  CanvasList myCanvas;
  Shape *s = new Shape(1, 3);
  myCanvas.push_front(s);
  Shape *p = new Shape(4, 6);
  myCanvas.push_front(p);
  Shape *b = new Shape(4, 6);
  myCanvas.push_back(b);

  myCanvas.clear();

  EXPECT_EQ(0, myCanvas.size());
  EXPECT_EQ(nullptr, myCanvas.front());
}

TEST(CANVASLIST, AssignmentOperator) {
  CanvasList myCanvas;
  Shape *s = new Shape(1, 3);
  myCanvas.push_front(s);
  Shape *p = new Shape(10, 15);
  myCanvas.push_front(p);
  Shape *b = new Shape(4, 6);
  myCanvas.push_back(b);

  CanvasList myCopiedCanvas;
  myCopiedCanvas = myCanvas;
  EXPECT_EQ(3, myCopiedCanvas.size());
  EXPECT_EQ(10, myCopiedCanvas.front()->value->getX());
  EXPECT_EQ(15, myCopiedCanvas.front()->value->getY());

  // Self-assign:
  myCopiedCanvas = myCopiedCanvas;
  EXPECT_EQ(3, myCopiedCanvas.size());
  EXPECT_EQ(10, myCopiedCanvas.front()->value->getX());
  EXPECT_EQ(15, myCopiedCanvas.front()->value->getY());
}

TEST(CANVASLIST, RemoveAt) {
  CanvasList myCanvas;
  Shape *s = new Shape(1, 3);
  myCanvas.push_front(s);
  Shape *p = new Shape(10, 15);
  myCanvas.push_front(p);
  Shape *b = new Shape(4, 6);
  myCanvas.push_back(b);

  // Remove with invalid index:
  myCanvas.remove_at(-1);
  myCanvas.remove_at(3);
  EXPECT_EQ(3, myCanvas.size());

  // Remove with three items in the list:
  myCanvas.remove_at(0);
  EXPECT_EQ(2, myCanvas.size());
  EXPECT_EQ(1, myCanvas.shape_at(0)->getX());
  EXPECT_EQ(3, myCanvas.shape_at(0)->getY());

  // Remove with only one item in the list:
  CanvasList myCanvas2;
  Shape *t = new Shape(1, 3);
  myCanvas2.push_front(t);
  myCanvas2.remove_at(0);
  EXPECT_EQ(0, myCanvas2.size());

  // Remove without an item in the list:
  CanvasList myCanvas3;
  myCanvas3.remove_at(0);
  EXPECT_EQ(0, myCanvas3.size());
}

TEST(CANVASLIST, RemoveEveryOther) {
  // Remove with nothing on the list:
  CanvasList myEmptyCanvas;
  myEmptyCanvas.remove_every_other();
  EXPECT_EQ(0, myEmptyCanvas.size());

  // Remove with only one thing on the list:
  CanvasList myLonelyList;
  Shape *s = new Shape(1, 3);
  myLonelyList.push_back(s);
  myLonelyList.remove_every_other();
  EXPECT_EQ(1, myLonelyList.size());

  // Remove with multiple elements:
  CanvasList myCanvas;
  Shape *a = new Shape(0, 0);
  Shape *b = new Shape(1, 1);
  Shape *c = new Shape(2, 2);
  Shape *d = new Shape(3, 3);
  Shape *e = new Shape(4, 4);
  myCanvas.push_front(e);
  myCanvas.push_front(d);
  myCanvas.push_front(c);
  myCanvas.push_front(b);
  myCanvas.push_front(a);
  //myCanvas.draw();
  myCanvas.remove_every_other();
  //myCanvas.draw();
  EXPECT_EQ(3, myCanvas.size());
}