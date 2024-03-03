#pragma once

#include "shape.h"

using namespace std;

class ShapeNode {
   public:
    Shape* value;
    ShapeNode* next;
};

class CanvasList {
   private:
    int list_size;
    ShapeNode* list_front;

   public:
    /**
     * Default constructor. Creates an empty `CanvasList`.
     */
    CanvasList();
    /**
     * Copy constructor. Creates a deep copy of the given `CanvasList`, where
     * each `Shape` is copied as well.
     */
    CanvasList(const CanvasList&);

    /**
     * Assignment operator. Sets the current `CanvasList` to a deep copy of the
     * given `CanvasList`.
     */
    CanvasList& operator=(const CanvasList&);

    /**
     * Destructor. Clears all allocated memory.
     */
    virtual ~CanvasList();

    /**
     * Empties the `CanvasList`, releasing all allocated memory (both
     * `ShapeNode` and `Shape`), and resetting member variables
     * appropriately.
     */
    void clear();

    /**
     * Inserts the given `Shape*` as a new element in the `CanvasList` after
     * the given index. If the index is invalid, does nothing.
     *
     * Takes ownership of the given `Shape*`.
     */
    void insert_after(int, Shape*);

    /**
     * Adds the given `Shape*` to the front of the `CanvasList`.
     *
     * Takes ownership of the given `Shape*`.
     */
    void push_front(Shape*);

    /**
     * Adds the given `Shape*` to the back of the `CanvasList`.
     *
     * Takes ownership of the given `Shape*`.
     */
    void push_back(Shape*);

    /**
     * Removes the element at the specified index in this list.
     *
     * If the index is invalid, does nothing.
     */
    void remove_at(int);

    /**
     * Remove every other element (alternating) from the `CanvasList`, starting
     * at index 1.
     *
     * For example, if a list was `[0, 1, 2, 3, 4]`, removing every other element
     * would change the list to `[0, 2, 4]`.
     */
    void remove_every_other();

    /**
     * Removes the element at the front of the `CanvasList`.
     *
     * The `CanvasList` gives up ownership of the returned `Shape*`, and does
     * not free it. If the `CanvasList` is empty, returns `nullptr`.
     */
    Shape* pop_front();

    /**
     * Removes the element at the back of the `CanvasList`.
     *
     * The `CanvasList` gives up ownership of the returned `Shape*`, and does
     * not free it. If the `CanvasList` is empty, returns `nullptr`.
     */
    Shape* pop_back();

    /**
     * Returns a pointer to the node at the front of the `CanvasList`.
     *
     * Used for testing. The caller must not delete the returned pointer.
     */
    ShapeNode* front() const;

    /**
     * Returns whether the `CanvasList` is empty (i.e. whether its
     * size is 0).
     */
    bool empty() const;

    /**
     * Returns the number of elements in the `CanvasList`.
     */
    int size() const;

    /**
     * Searches the `CanvasList` for the first `Shape` with the given `x`, `y`
     * coordinate values, and returns its index. If no matching `Shape` is
     * found, returns -1.
     */
    int find(int x, int y) const;

    /**
     * Returns the `Shape*` at the given index in the `CanvasList`.
     * The `CanvasList` retains ownership of the `Shape*`; the caller must
     * not delete it.
     *
     * If the index is invalid, returns `nullptr`.
     */
    Shape* shape_at(int) const;

    /**
     * For each `Shape` in the `CanvasList`, outputs its `to_string`, with one
     * `Shape` on each line.
     */
    void draw() const;

    /**
     * For each node in the `CanvasList`, prints the node's address, and the
     * node's shape's addresss. Each node is on one line.
     *
     * Example output:
     *
     * ```text
     * Node Address: 0x562ac60e82a0	Shape Address: 0x562ac60e8280
     * Node Address: 0x562ac60e81d0	Shape Address: 0x562ac60e81b0
     * Node Address: 0x562ac60e8260	Shape Address: 0x562ac60e8240
     * Node Address: 0x562ac60e8150	Shape Address: 0x562ac60e8130
     * Node Address: 0x562ac60e80e0	Shape Address: 0x562ac60e80c0
     * Node Address: 0x562ac60e8190	Shape Address: 0x562ac60e8170
     * ```
     *
     * The character between the node's address and "Shape" on each line is a
     * tab character.
     */
    void print_addresses() const;
};
