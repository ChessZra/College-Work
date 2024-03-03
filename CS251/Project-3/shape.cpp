#include "shape.h"

#include <string>

using namespace std;

Shape::Shape() {
    this->x = 0;
    this->y = 0;
}

Shape::Shape(int x, int y) {
    this->x = x;
    this->y = y;
}

Shape::~Shape() {
    // Nothing allocated.
}

Shape* Shape::copy() {
    Shape* ret = new Shape(this->getX(), this->getY());
    return ret;
}

int Shape::getX() const {
    return this->x;
}

int Shape::getY() const {
    return this->y;
}

void Shape::setX(int x) {
    this->x = x;
}

void Shape::setY(int y) {
    this->y = y;
}

string Shape::as_string() const {
    string ret = "It's a Shape at x: " + to_string(this->getX()) + ", y: " + 
                 to_string(this->getY());
    return ret;
}

Circle::Circle() {
    this->x = 0;
    this->y = 0;
    this->radius = 0;
}

Circle::Circle(int r) {
    this->x = 0;
    this->y = 0;
    this->radius = r;
}

Circle::Circle(int x, int y, int r) {
    this->x = x;
    this->y = y;
    this->radius = r;
}

Circle::~Circle() {
    // Nothing allocated.
}

Circle* Circle::copy() {
    Circle* ret = new Circle(this->x, this->y, this->radius);
    return ret;
}

int Circle::getRadius() const {
    return this->radius;
} 

void Circle::setRadius(int r) {
    this->radius = r;
}

string Circle::as_string() const {
    string ret = "It's a Circle at x: " + to_string(this->getX()) + ", y: " + 
                to_string(this->getY()) + ", radius: " + to_string(this->getRadius());
    return ret;
}

Rect::Rect() {
    this->x = 0;
    this->y = 0;
    this->width = 0;
    this->height = 0;
}

Rect::Rect(int w, int h) {
    this->x = 0;
    this->y = 0;
    this->width = w;
    this->height = h;
}

Rect::Rect(int x, int y, int w, int h) {
    this->x = x;
    this->y = y;
    this->width = w;
    this->height = h;
}

Rect::~Rect() {
    // Nothing allocated.
}

Rect* Rect::copy() {
    Rect* ret = new Rect(this->x, this->y, this->width, this->height);
    return ret;
}

int Rect::getWidth() const {
    return this->width;
} 

int Rect::getHeight() const {
    return this->height;
} 

void Rect::setWidth(int w) {
    this->width = w;
}

void Rect::setHeight(int h) {
    this->height = h;
}

string Rect::as_string() const {
    string ret = "It's a Rectangle at x: " + to_string(this->getX()) + ", y: " + 
                  to_string(this->getY()) + " with width: " + 
                  to_string(this->getWidth()) +" and height: " + 
                  to_string(this->getHeight());
    return ret;
}

RightTriangle::RightTriangle() {
    this->x = 0;
    this->y = 0;
    this->base = 0;
    this->height = 0;
}

RightTriangle::RightTriangle(int b, int h) {
    this->x = 0;
    this->y = 0;
    this->base = b;
    this->height = h;
}

RightTriangle::RightTriangle(int x, int y, int b, int h) {
    this->x = x;
    this->y = y;
    this->base = b;
    this->height = h;  
}

RightTriangle::~RightTriangle() {
    // Nothing allocated.
}

RightTriangle* RightTriangle::copy() {
    RightTriangle* ret = new RightTriangle(this->x, this->y, this->base, this->height);
    return ret;
}

int RightTriangle::getBase() const {
    return this->base;
} 

int RightTriangle::getHeight() const {
    return this->height;
} 

void RightTriangle::setBase(int b) {
    this->base = b;
}

void RightTriangle::setHeight(int h) {
    this->height = h;
}

string RightTriangle::as_string() const {
    string ret = "It's a Right Triangle at x: " + to_string(this->getX()) + ", y: " + 
                  to_string(this->getY()) + " with base: " + 
                  to_string(this->getBase()) +" and height: " + 
                  to_string(this->getHeight());
    return ret;
}