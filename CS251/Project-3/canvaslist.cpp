#include "canvaslist.h"

#include <iostream>

using namespace std;

CanvasList::CanvasList() {
    this->list_size = 0;
    this->list_front = nullptr;
}

CanvasList::CanvasList(const CanvasList& other) {
    if (&other == this) return;
    ShapeNode* cur = other.front();
    this->list_size = 0;
    this->list_front = nullptr;
    while (cur != nullptr) {    
        Shape* newShape = cur->value->copy();
        this->push_back(newShape);
        cur = cur->next;
    }
}

CanvasList& CanvasList::operator=(const CanvasList& other) {
    if (&other == this) return *this;
    this->clear();
    ShapeNode* cur = other.front();
    while (cur != nullptr) {    
        Shape* newShape = cur->value->copy();
        this->push_back(newShape);
        cur = cur->next;
    }
    return *this;
}

CanvasList::~CanvasList() {
    this->clear();
}

void CanvasList::clear() {
    ShapeNode* cur = this->list_front;
    while (cur != nullptr) {
        ShapeNode* tempNext = cur->next;
        delete cur->value;
        delete cur;
        cur = tempNext;
        this->list_size--;
    }
    this->list_front = nullptr;
}

void CanvasList::insert_after(int index, Shape* s) {
    if (index < 0 || index >= this->list_size) return;
    ShapeNode* cur = this->list_front;
    while (index--) {
        cur = cur->next;
    }

    ShapeNode* newNode = new ShapeNode();
    newNode->value = s;
    newNode->next = cur->next;
    cur->next = newNode;
    this->list_size++;
}

void CanvasList::push_front(Shape* s) {
    ShapeNode* node = new ShapeNode();
    node->value = s;
    node->next = this->list_front;

    this->list_front = node;
    this->list_size++;
}

void CanvasList::push_back(Shape* s) {
    ShapeNode* node = new ShapeNode();
    node->value = s;
    node->next = nullptr;
    
    ShapeNode* cur = this->list_front;
    if (cur == nullptr) { // If there's no item in the list:
                          // then simply set front of the list to the new node.
        this->list_front = node;
    } else {
        while (cur->next != nullptr) cur = cur->next;
        cur->next = node;
    }
    this->list_size++;
}

void CanvasList::remove_at(int index) {
    if (index < 0 || index >= this->list_size) return;

    ShapeNode* cur = this->list_front;
    ShapeNode* dummy = new ShapeNode();
    dummy->next = cur;
    ShapeNode* prev = dummy;

    while (index--) {
        prev = prev->next;
        cur = cur->next;
    }
    prev->next = cur->next;
    this->list_front = dummy->next;
    this->list_size--;
    delete dummy;
    delete cur->value;
    delete cur;
}

void CanvasList::remove_every_other() {
    // [0, 1, 2, 3, 4, 5, 6, 7] -> [0, 2, 4, 6] # remove index 1
    int start = 1;
    while (start < this->list_size) {
        this->remove_at(start);
        start++;
    }
}

Shape* CanvasList::pop_front() {
    if (this->empty()) return nullptr;
    ShapeNode* cur = this->list_front;
    this->list_front = cur->next;
    this->list_size--;

    Shape* ret = cur->value;
    delete cur;
    return ret;
}

Shape* CanvasList::pop_back() {
    if (this->empty()) return nullptr;
    ShapeNode* cur = this->list_front;
    ShapeNode* prev;
    if (cur->next == nullptr) { // If there's only one item in the list, then just
                                // set front to nullptr.
        this->list_front = cur->next;
    } else {
        while (cur->next != nullptr) {
            prev = cur;
            cur = cur->next;
        }
        prev->next = cur->next;
    }
    this->list_size--;
    Shape* ret = cur->value;
    delete cur;
    return ret;
}

ShapeNode* CanvasList::front() const {
    return this->list_front;
}

bool CanvasList::empty() const {
    if (this->list_size == 0) return true;
    return false;
}

int CanvasList::size() const {
    return this->list_size;
}

int CanvasList::find(int x, int y) const {
    ShapeNode* cur = this->list_front;
    int i = 0;
    while (cur != nullptr) {
        if (cur->value->getX() == x && cur->value->getY() == y) return i;
        i++;
        cur = cur->next;
    }
    return -1;
}

Shape* CanvasList::shape_at(int index) const {
    if (index < 0 || index >= this->list_size) return nullptr;
    ShapeNode* cur = this->list_front;
    while (index--) {
        cur = cur->next;
    }
    return cur->value;
}

void CanvasList::draw() const {
    ShapeNode* cur = this->list_front;
    while (cur != nullptr) {
        cout << cur->value->as_string() << endl;
        cur = cur->next;
    }
}

void CanvasList::print_addresses() const {
    ShapeNode* cur = this->list_front;
    while (cur != nullptr) {
        printf("Node Address: %p	Shape Address: %p\n", cur, cur->value);
        cur = cur->next;
    }
}