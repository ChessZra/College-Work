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

    // TODO_STUDENT: add private helper function definitions here ::
    // This is a helper function for as_string.
    // This is an in-order traversal, so it is the same as dequeuing order.
    void asStringHelper (NODE* cur, ostream& output) const {
        if (cur == nullptr) return;

        this->asStringHelper(cur->left, output);

        NODE* temp = cur;
        while (temp) {
            output << temp->priority << " value: " << temp->value << endl;
            temp = temp->link;
        }

        this->asStringHelper(cur->right, output); 
    }

    // Helper function for ~prqueue():
    // Helper function for the destructor which frees all the nodes.
    // This runs a post-order traversal.
    void freeAllNodes(NODE* cur) {
        if (cur == nullptr) return;

        this->freeAllNodes(cur->left);
        this->freeAllNodes(cur->right);

        // For every node, treat it as a linked list and delete them iteratively:
        while (cur) {
            NODE* temp = cur->link;
            delete cur;
            cur = temp;
        }
    }

    // Helper function for enqueue():
    // Recursive function that inserts the new node in the priority queue.
    // This helper function gets called when the priority queue is non-empty.
    void enqueueHelper(NODE* newNode, NODE* cur) {
        // Iterate while you haven't inserted the node.
        while (true) {
            // If the new node is less, go left:
            if (newNode->priority < cur->priority) {
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
            } else { // There is a duplicate in the current head:
                while (cur->link != nullptr) cur = cur->link;
                cur->link = newNode;

                break;
            }
        }
    }

    NODE* getCopy(NODE* root) {
        if (root == nullptr) return nullptr;
        NODE* newNode = new NODE;
        newNode->priority = root->priority;
        newNode->value = root->value;
        newNode->parent = nullptr;
        newNode->link = nullptr;

        NODE* cur = root->link;
        NODE* newLL = newNode;
        while (cur) {
            NODE* temp = new NODE;
            temp->priority = cur->priority;
            temp->value = cur->value; 
            temp->parent = nullptr;
            temp->link = nullptr;
            newLL->link = temp;
            newLL = newLL->link;
            cur = cur->link;
        }

        newNode->left = this->getCopy(root->left);
        newNode->right = this->getCopy(root->right);
    
        if (newNode->left != nullptr) newNode->left->parent = newNode;
        if (newNode->right != nullptr) newNode->right->parent = newNode;
        return newNode;
    }

    void sameTree(NODE* root1, NODE* root2, bool& ret) const {
        if ((!root1 && !root2) || ret == false) return;
        if ((root1 && !root2) || (!root1 && root2)) {
            ret = false;
            return;
        }
        // by this line, they are both valid nodes:
        // now check if they are the same linked list...
        NODE* l1 = root1;
        NODE* l2 = root2;
        while (l1 || l2) {
            if ((l1 && !l2) || (!l1 && l2)) {
                ret = false;
                break;
            }
            if (l1->priority != l2->priority || l1->value != l2->value) {
                ret = false;
                break;
            }
            l1 = l1->link;
            l2 = l2->link;
        }

        sameTree(root1->left, root2->left, ret);
        sameTree(root1->right, root2->right, ret);
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
        // Important step: assign the values before calling the assignment operator!
        // This function gets called and it will have only garbage values, the pointer might be invalid..
    
        this->sz = 0;
        this->root = nullptr;

        *this = other;
    }

    /// Assignment operator; `operator=`.
    ///
    /// Clears `this` tree, and copies the value-priority pairs from the
    /// provided `prqueue`. The internal tree structure must be copied exactly.
    ///
    /// Runs in O(N + O), where N is the number of values in `this`, and O is
    /// the number of values in `other`.
    prqueue& operator=(const prqueue& other) {
        if (this == &other) return *this;

        this->clear();
        if (other.root == nullptr) {
            this->root = nullptr;
            this->sz = 0;
        } else {
            this->sz = other.size();
            this->root = this->getCopy(other.root);
        }

        return *this;
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
        newNode->link = nullptr;

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
        // Get the left most node, which is essentially the node with the least 
        // priority (the node to dequeue):
        while (cur->left) {
            cur = cur->left;
        }
        // -- cur is now the node to dequeue in this line --

        if (cur == this->root) { // Case 1: cur (the node to be removed) is the root
            if (cur->link) {                    // Case 1: cur is a linked list
                // There is no parent:
                this->root = cur->link;
                cur->link->parent = nullptr;

                // Establish link and cur's right child relationship:
                cur->link->right = cur->right;
                if (cur->right)
                    cur->right->parent = cur->link;
            } else if (cur->right) {            // Case 2: cur has right children
                this->root = cur->right;
                cur->right->parent = nullptr;
            } else {                            // Case 3: cur has no children
                this->root = nullptr;
            }
        } else { // Case 2: cur is not the root
            if (cur->link) {    // Case 1: cur is a linked list

                // Establish link and cur's parent relationship:
                cur->parent->left = cur->link; 
                cur->link->parent = cur->parent;

                // Establish link and cur's right child relationship:
                cur->link->right = cur->right;
                if (cur->right)
                    cur->right->parent = cur->link; // Set cur->right's parent to predecessor:

            } else {            // Case 2: cur is not the linked list
                cur->parent->left = cur->right; // Set its predecessor's child to cur->right:
                if (cur->right)
                    cur->right->parent = cur->parent; // Set cur->right's parent to predecessor:
            }
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
    /// O(1), simply sets the curr to nullptr, to get ready for the first next() call.
    void begin() {
        this->curr = nullptr;
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
        // Base case: the first call to this function is always the minimum value.

        if (curr == nullptr) {
            if (this->sz == 0) return false;
            curr = root;
            while (curr->left) curr = curr->left;
            value = curr->value;
            priority = curr->priority;
            return true;
        }
        if (curr->link) { // the next link will be the next node..
            // Per the instruction, "The other pointers for these remaining nodes are not checked. 
                                    // This is a design decision for you to make!" 
            // Our original design:
            curr->link->right = curr->right; 
            curr->link->parent = curr->parent;

            curr = curr->link;
            value = curr->value;
            priority = curr->priority;
            return true;
        } 

        if (curr->right != nullptr) { // If the right subtree exists:
            NODE* newNode = curr->right;
            while (newNode->left) newNode = newNode->left;

            curr = newNode;
            value = newNode->value;
            priority = newNode->priority;
        } else { // If not, then we gotta go back up to the parent
            temp = curr;
            while (temp->parent && temp->parent->right && temp->parent->right->priority == temp->priority) { 
                // While the current node is a right child:
                temp = temp->parent;
            }
            temp = temp->parent;
            curr = temp;

            // We reached the end here!
            if (!curr) return false;

            value = curr->value;
            priority = curr->priority;
        }

        return true; 
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
        if (other.sz != this->sz) return false;
        bool ret = true;
        NODE* root1 = this->root;
        sameTree(root1, other.root, ret);
        return ret;
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
