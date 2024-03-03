#pragma once

#include <string>

using namespace std;

class Shape {
   protected:
    int x;
    int y;

   public:
    Shape();
    Shape(int x, int y);

    virtual ~Shape();

    /**
     * Returns a newly allocated `Shape` with the same values for
     * its member variables.
     */
    virtual Shape* copy();

    int getX() const;
    int getY() const;
    void setX(int);
    void setY(int);

    /**
     * Converts the `Shape` to a string representation.
     *
     * For example,
     *
     * ```text
     * It's a Shape at x: 4, y: 6
     * ```
     */
    virtual string as_string() const;
};

class Circle : public Shape {
   private:
    int radius;

   public:
    Circle();
    Circle(int r);
    Circle(int x, int y, int r);

    virtual ~Circle();
    /**
     * Returns a newly allocated `Circle` with the same values for
     * its member variables.
     */
    virtual Circle* copy();

    int getRadius() const;
    void setRadius(int);

    /**
     * Converts the `Circle` to a string representation.
     *
     * For example,
     *
     * ```text
     * It's a Circle at x: 2, y: 4, radius: 3
     * ```
     */
    virtual string as_string() const;
};

class Rect : public Shape {
   private:
    int width;
    int height;

   public:
    Rect();
    Rect(int w, int h);
    Rect(int x, int y, int w, int h);

    virtual ~Rect();
    /**
     * Returns a newly allocated `Rect` with the same values for
     * its member variables.
     */
    virtual Rect* copy();

    int getWidth() const;
    int getHeight() const;
    void setWidth(int);
    void setHeight(int);

    /**
     * Converts the `Rect` to a string representation.
     *
     * For example,
     *
     * ```text
     * It's a Rectangle at x: 0, y: 0 with width: 0 and height: 10
     * ```
     */
    virtual string as_string() const;
};

class RightTriangle : public Shape {
   private:
    int base;
    int height;

   public:
    RightTriangle();
    RightTriangle(int b, int h);
    RightTriangle(int x, int y, int b, int h);

    virtual ~RightTriangle();
    /**
     * Returns a newly allocated `RightTriangle` with the same values for
     * its member variables.
     */
    virtual RightTriangle* copy();

    int getBase() const;
    int getHeight() const;
    void setBase(int);
    void setHeight(int);

    /**
     * Converts the `RightTriangle` to a string representation.
     *
     * For example,
     *
     * ```text
     * Right Triangle at x: 1, y: 2 with base: 3 and height: 4
     * ```
     */
    virtual string as_string() const;
};
