#pragma once

#include <iostream>  // For debugging
#include <sstream>   // For as_string

using namespace std;

template <typename T>
class prqueue {
   private:
    struct NODE {
        int priority;
        T value;
        NODE* parent;
        NODE* left;
        NODE* right;
        NODE* link;  // Link to duplicates -- Part 2 only
    };

    NODE* root;
    size_t sz;

    // Utility pointers for begin and next.
    NODE* curr;
    NODE* temp;  // Optional

    // TODO_STUDENT: add private helper function definitions here
    void asStringHelper (NODE* cur, ostream& output) const {
        if (cur == nullptr) return;

        this->asStringHelper(cur->left, output);

        output << cur->priority << " value: " << cur->value << endl;

        this->asStringHelper(cur->right, output); 
    }

    // Helper function for ~prqueue():
    // Helper function for the destructor which frees all the nodes.
    // This runs a post-order traversal.
    void freeAllNodes(NODE* cur) {
        if (cur == nullptr) return;

        this->freeAllNodes(cur->left);
        this->freeAllNodes(cur->right);

        delete cur;
    }

    // Helper function for enqueue():
    // Recursive function that inserts the new node in the priority queue.
    // This helper function gets called when the priority queue is non-empty.
    void enqueueHelper(NODE* newNode, NODE* cur) {
        // Iterate while you haven't inserted the node.
        while (true) {
            // If the new node is less, go left:
            if (newNode->priority <= cur->priority) {
                if (cur->left == nullptr) {
                    newNode->parent = cur;
                    cur->left = newNode;
                    break;
                }
                cur = cur->left;
            } else if (newNode->priority > cur->priority) { // If the new node
                                                            // is greater, go right:
                if (cur->right == nullptr) {
                    newNode->parent = cur;
                    cur->right = newNode;
                    break;
                }
                cur = cur->right;
            }
        }
    }

   public:
    /// Creates an empty `prqueue`.
    ///
    /// Runs in O(1).
    prqueue() { 
        this->sz = 0;
        this->root = nullptr;
    }

    /// Copy constructor.
    ///
    /// Copies the value-priority pairs from the provided `prqueue`.
    /// The internal tree structure must be copied exactly.
    ///
    /// Runs in O(N), where N is the number of values in `other`.
    prqueue(const prqueue& other) {
        // TODO_STUDENT
    }

    /// Assignment operator; `operator=`.
    ///
    /// Clears `this` tree, and copies the value-priority pairs from the
    /// provided `prqueue`. The internal tree structure must be copied exactly.
    ///
    /// Runs in O(N + O), where N is the number of values in `this`, and O is
    /// the number of values in `other`.
    prqueue& operator=(const prqueue& other) {
        // TODO_STUDENT
    }

    /// Empties the `prqueue`, freeing all memory it controls.
    ///
    /// Runs in O(N), where N is the number of values.
    void clear() {
        NODE* cur = root;
        this->freeAllNodes(cur);
        this->sz = 0;
        this->root = nullptr;
    }

    /// Destructor, cleans up all memory associated with `prqueue`.
    ///
    /// Runs in O(N), where N is the number of values.
    ~prqueue() {
        this->clear();
    }
    
    /// Adds `value` to the `prqueue` with the given `priority`.
    ///
    /// Uses the priority to determine the location in the underlying tree.
    ///
    /// Runs in O(H + M), where H is the height of the tree, and M is
    /// the number of duplicate priorities.
    void enqueue(T value, int priority) {
        NODE* newNode = new NODE;
        newNode->priority = priority;
        newNode->value = value;
        newNode->left = nullptr;
        newNode->right = nullptr;
        newNode->parent = nullptr;

        if (this->sz == 0) {
            newNode->parent = nullptr;
            this->root = newNode;
        } else {
            NODE* cur = root;
            this->enqueueHelper(newNode, cur);
        }

        this->sz++;
    }

    /// Returns the value with the smallest priority in the `prqueue`, but does
    /// not modify the `prqueue`.
    ///
    /// If the `prqueue` is empty, returns the default value for `T`.
    ///
    /// Runs in O(H + M), where H is the height of the tree, and M is
    /// the number of duplicate priorities.
    T peek() const {
        if (this->sz == 0) return T{};
        NODE* cur = root;
        while (cur->left) {
            cur = cur->left;
        }
        return cur->value;
    }

    /// Returns the value with the smallest priority in the `prqueue` and
    /// removes it from the `prqueue`.
    ///
    /// If the `prqueue` is empty, returns the default value for `T`.
    ///
    /// Runs in O(H + M), where H is the height of the tree, and M is
    /// the number of duplicate priorities.
    T dequeue() {
        if (this->sz == 0) return T{};
        NODE* cur = root;
        while (cur->left) {
            cur = cur->left;
        }

        if (cur == this->root) {
            if (cur->right) {
                this->root = cur->right;
                cur->right->parent = nullptr;
            } else {
                this->root = nullptr;
            }
        } else {
            cur->parent->left = cur->right; // Set its predecessor's child to cur->right.
            if (cur->right)
                cur->right->parent = cur->parent; // Set cur->right's parent to predecessor.
        }
        T ret = cur->value;
        delete cur;

        this->sz--;
        return ret;
    }

    /// Returns the number of elements in the `prqueue`.
    ///
    /// Runs in O(1).
    size_t size() const {
        return this->sz;
    }

    /// Resets internal state for an iterative inorder traversal.
    ///
    /// See `next` for usage details.
    ///
    /// O(H), where H is the maximum height of the tree.
    void begin() {
        // TODO_STUDENT
    }

    /// Uses the internal state to return the next in-order value and priority
    /// by reference, and advances the internal state. Returns true if the
    /// reference parameters were set, and false otherwise.
    ///
    /// Example usage:
    ///
    /// ```c++
    /// pq.begin();
    /// T value;
    /// int priority;
    /// while (pq.next(value, priority)) {
    ///   cout << priority << " value: " << value << endl;
    /// }
    /// ```
    ///
    /// Runs in worst-case O(H + M) or O(H), depending on implementation, where
    /// H is the height of the tree, and M is the number of duplicate
    /// priorities.
    bool next(T& value, int& priority) {
        // TODO_STUDENT
    }

    /// Converts the `prqueue` to a string representation, with the values
    /// in-order by priority.
    ///
    /// Example:
    ///
    /// ```c++
    /// prqueue<string> names;
    /// names.enqueue("Gwen", 3);
    /// names.enqueue("Jen", 2);
    /// names.enqueue("Ben", 1);
    /// names.enqueue("Sven", 2);
    /// ```
    ///
    /// Calling `names.as_string()` would return the following multi-line
    /// string:
    ///
    /// ```text
    /// 1 value: Ben
    /// 2 value: Jen
    /// 2 value: Sven
    /// 3 value: Gwen
    /// ```
    ///
    /// Runs in O(N), where N is the number of values.
    string as_string() const {
        NODE* cur = this->root;
        ostringstream output;
        this->asStringHelper(cur, output);

        return output.str();
    }

    /// Checks if the contents of `this` and `other` are equivalent.
    ///
    /// Two `prqueues` are equivalent if they have the same priorities and
    /// values, as well as the same internal tree structure.
    ///
    /// These two `prqueue`s would be considered equivalent, because
    /// they have the same internal tree structure:
    ///
    /// ```c++
    /// prqueue<string> a;
    /// a.enqueue("2", 2);
    /// a.enqueue("1", 1);
    /// a.enqueue("3", 3);
    /// ```
    ///
    /// and
    ///
    /// ```c++
    /// prqueue<string> b;
    /// a.enqueue("2", 2);
    /// a.enqueue("3", 3);
    /// a.enqueue("1", 1);
    /// ```
    ///
    /// While this `prqueue`, despite containing the same priority-value pairs,
    /// would not be considered equivalent, because the internal tree structure
    /// is different.
    ///
    /// ```c++
    /// prqueue<string> c;
    /// a.enqueue("1", 1);
    /// a.enqueue("2", 2);
    /// a.enqueue("3", 3);
    /// ```
    ///
    /// Runs in O(N) time, where N is the maximum number of nodes in
    /// either `prqueue`.
    ///
    bool operator==(const prqueue& other) const {
        // TODO_STUDENT
    }

    /// Returns a pointer to the root node of the BST.
    ///
    /// Used for testing the internal structure of the BST. Do not edit or
    /// change.
    ///
    /// Runs in O(1).
    void* getRoot() {
        return root;
    }
};
