#include "prqueue.h"

#include "gtest/gtest.h"
#include "map"
#include <vector>
using namespace std;

TEST(EMPTYTEST, Test) {
    prqueue<int> pq;
}

TEST(SIZE, Size) {
    // Empty PQ:
    prqueue<string> emptyPQ;

    // One element in PQ:
    prqueue<string> singlePQ;
    singlePQ.enqueue("LonelyGuy", 5);

    // Multiple elements in PQ:
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    names.enqueue("Bernard", 4);
    names.enqueue("Arnold", 8);
    names.enqueue("Ford", 2);
    names.enqueue("Jasmine", 6);
    names.enqueue("Carlos", 11);

    EXPECT_EQ(0, emptyPQ.size());
    EXPECT_EQ(1, singlePQ.size());
    EXPECT_EQ(6, names.size());
}

TEST(ENQUEUE, Enqueue) {
    // One element in PQ:
    prqueue<string> singlePQ;
    singlePQ.enqueue("LonelyGuy", 5);

    // Multiple elements in PQ:
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    names.enqueue("Bernard", 4);
    names.enqueue("Arnold", 8);
    names.enqueue("Ford", 2);
    names.enqueue("Jasmine", 6);
    names.enqueue("Carlos", 11);

    EXPECT_EQ("LonelyGuy", singlePQ.peek());
    EXPECT_EQ("Ford", names.peek());
}

TEST(ASSTRING, AsString) {
    // Empty PQ:
    prqueue<string> emptyPQ;

    // One element in PQ:
    prqueue<string> singlePQ;
    singlePQ.enqueue("LonelyGuy", 5);

    // Multiple elements in PQ:
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    names.enqueue("Bernard", 4);
    names.enqueue("Arnold", 8);
    names.enqueue("Ford", 2);
    names.enqueue("Jasmine", 6);
    names.enqueue("Carlos", 11);

    EXPECT_EQ("", emptyPQ.as_string());
    EXPECT_EQ("5 value: LonelyGuy\n", singlePQ.as_string());

    string expectedOutput =
    "2 value: Ford\n"
    "4 value: Bernard\n"
    "5 value: Dolores\n"
    "6 value: Jasmine\n"
    "8 value: Arnold\n"
    "11 value: Carlos\n";
    EXPECT_EQ(expectedOutput, names.as_string());
}

TEST(CLEAR, Clear) {
    // Empty PQ:
    prqueue<string> emptyPQ;

    // One element in PQ:
    prqueue<string> singlePQ;
    singlePQ.enqueue("LonelyGuy", 5);

    // Multiple elements in PQ:
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    names.enqueue("Bernard", 4);
    names.enqueue("Arnold", 8);
    names.enqueue("Ford", 2);
    names.enqueue("Jasmine", 6);
    names.enqueue("Carlos", 11);

    emptyPQ.clear();
    singlePQ.clear();
    names.clear();

    EXPECT_EQ(nullptr, emptyPQ.getRoot());
    EXPECT_EQ(nullptr, singlePQ.getRoot());
    EXPECT_EQ(nullptr, names.getRoot());

    EXPECT_EQ(0, emptyPQ.size());
    EXPECT_EQ(0, singlePQ.size());
    EXPECT_EQ(0, names.size());
}

TEST(DEQUEUE, Dequeue) {
    // Empty PQ:
    prqueue<string> emptyPQ;

    // One element in PQ:
    prqueue<string> singlePQ;
    singlePQ.enqueue("LonelyGuy", 5);

    // Multiple elements in PQ:
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    names.enqueue("Bernard", 4);
    names.enqueue("Arnold", 8);
    names.enqueue("Ford", 2);
    names.enqueue("Jasmine", 6);
    names.enqueue("Carlos", 11);

    EXPECT_EQ(string(), emptyPQ.dequeue());
    EXPECT_EQ(0, emptyPQ.size());

    EXPECT_EQ("LonelyGuy", singlePQ.dequeue());
    EXPECT_EQ(0, singlePQ.size());

    // Do assertions for multiple-element-PQ:
    map<int, string> mp = {
        {5, "Dolores"},
        {4, "Bernard"},
        {8, "Arnold"},
        {2, "Ford"},
        {6, "Jasmine"},
        {11, "Carlos"}
    };
    size_t curSize = 6;
    for (const auto& it: mp) {
        EXPECT_EQ(it.second, names.dequeue());
        EXPECT_EQ(curSize - 1, names.size());
        curSize--;
    }
    EXPECT_EQ(0, names.size());

    // Complete binary tree:
    prqueue<string> completeBST;
    completeBST.enqueue("root", 3);
    completeBST.enqueue("left", 2);
    completeBST.enqueue("right", 4);

    // Do assertions for complete-BST-PQ:
    map<int, string> mp2 = {
        {3, "root"},
        {2, "left"},
        {4, "right"},
    };
    curSize = 3;
    for (const auto& it: mp2) {
        EXPECT_EQ(it.second, completeBST.dequeue());
        EXPECT_EQ(curSize - 1, completeBST.size());
        curSize--;
    }
    EXPECT_EQ(0, completeBST.size());

    // Some random tree to test it EVEN MORE!
    prqueue<string> random;
    random.enqueue("r4", 4);
    random.enqueue("r2", 2);
    random.enqueue("r5", 5);
    random.enqueue("r6", 6);
    random.enqueue("r1", 1);
    random.enqueue("r3", 3);
    map<int, string> mp3 = {
        {1, "r1"},
        {2, "r2"},
        {3, "r3"},
        {4, "r4"},
        {5, "r5"},
        {6, "r6"}
    };

    curSize = 6;
    for (const auto& it: mp3) {
        EXPECT_EQ(it.second, random.dequeue());
        EXPECT_EQ(curSize - 1, random.size());
        curSize--;
    }
    EXPECT_EQ(0, random.size());
}

TEST(PEEK, Peek) {
    // Empty PQ:
    prqueue<string> emptyPQ;

    // One element in PQ:
    prqueue<string> singlePQ;
    singlePQ.enqueue("LonelyGuy", 5);

    // Multiple elements in PQ:
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    names.enqueue("Bernard", 4);
    names.enqueue("Arnold", 8);
    names.enqueue("Ford", 2);
    names.enqueue("Jasmine", 6);
    names.enqueue("Carlos", 11);

    EXPECT_EQ(string(), emptyPQ.peek());
    EXPECT_EQ("LonelyGuy", singlePQ.peek());
    EXPECT_EQ("Ford", names.peek());

    EXPECT_EQ(0, emptyPQ.size());
    EXPECT_EQ(1, singlePQ.size());
    EXPECT_EQ(6, names.size());
}

TEST(DUPLICATES, DuplicateEnqueueAsString) {
    // One linked list in PQ:
    prqueue<string> singlePQ;
    singlePQ.enqueue("LonelyGuy", 5);
    singlePQ.enqueue("LonelySuccessor", 5);

    // Multiple elements in PQ:
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    names.enqueue("Bernard", 4);
    names.enqueue("Arnold", 8);
    names.enqueue("Ford", 2);
    names.enqueue("Jasmine", 6);
    names.enqueue("Carlos", 11);
    names.enqueue("William", 8);
    names.enqueue("Teddy", 8);

    string expectedOutput =
    "2 value: Ford\n"
    "4 value: Bernard\n"
    "5 value: Dolores\n"
    "6 value: Jasmine\n"
    "8 value: Arnold\n"
    "8 value: William\n"
    "8 value: Teddy\n"
    "11 value: Carlos\n";
    EXPECT_EQ(expectedOutput, names.as_string());

    expectedOutput =
    "5 value: LonelyGuy\n"
    "5 value: LonelySuccessor\n";
    EXPECT_EQ(expectedOutput, singlePQ.as_string());
}

TEST(DUPLICATES, DuplicateDequeue) {
    // One linked list in PQ:
    prqueue<string> singlePQ;
    singlePQ.enqueue("LonelyGuy", 5);
    singlePQ.enqueue("LonelySuccessor", 5);

    vector<string> expectedOutput = {"LonelyGuy", "LonelySuccessor"};
    for (size_t i = 0; i < expectedOutput.size(); i++) {
        EXPECT_EQ(expectedOutput[i], singlePQ.dequeue());
    }

    // Multiple elements in PQ:
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    names.enqueue("Bernard", 4);
    names.enqueue("Arnold", 8);
    names.enqueue("Ford", 2);
    names.enqueue("Jasmine", 6);
    names.enqueue("Carlos", 11);
    names.enqueue("William", 8);
    names.enqueue("Teddy", 8);

    vector<string> expectedOutput2 = {"Ford", "Bernard", "Dolores", "Jasmine", "Arnold", "William", "Teddy", "Carlos"};
    for (size_t i = 0; i < expectedOutput2.size(); i++) {
        EXPECT_EQ(expectedOutput2[i], names.dequeue());
    }
}

TEST(COPY, OneItemCopyAssignmentOperator) {
    // One element in PQ:
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    prqueue<string> clone;
    clone = names;

    string expectedOutput =
    "5 value: Dolores\n";
    EXPECT_EQ(expectedOutput, clone.as_string());
}

TEST(COPY, EmptyAssignmentOperator) {
    // Empty elements in PQ:
    prqueue<string> names;
    prqueue<string> clone;
    clone = names;
    EXPECT_EQ(nullptr, clone.getRoot());
}

TEST(COPY, MultipleElementsAssignmentOperator) {
    // Multiple elements in PQ:
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    names.enqueue("Bernard", 4);
    names.enqueue("Arnold", 8);
    names.enqueue("Ford", 2);
    names.enqueue("Jasmine", 6);
    names.enqueue("Carlos", 11);
    names.enqueue("William", 8);
    names.enqueue("Teddy", 8);

    prqueue<string> clone;
    clone = names;

    string expectedOutput =
    "2 value: Ford\n"
    "4 value: Bernard\n"
    "5 value: Dolores\n"
    "6 value: Jasmine\n"
    "8 value: Arnold\n"
    "8 value: William\n"
    "8 value: Teddy\n"
    "11 value: Carlos\n";
    EXPECT_EQ(expectedOutput, clone.as_string());
    EXPECT_EQ(names.size(), clone.size());

    prqueue<string> clone2;
    clone2.enqueue("A", 11);
    clone2.enqueue("B", 8);
    clone2.enqueue("C", 8);

    clone2 = names;
    EXPECT_EQ(expectedOutput, clone2.as_string());
    EXPECT_EQ(names.size(), clone2.size());
}

TEST(COPY, SelfAssignmentOperator) {
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    names.enqueue("Bernard", 4);
    names.enqueue("Arnold", 8);
    names.enqueue("Ford", 2);
    names.enqueue("Jasmine", 6);
    names.enqueue("Carlos", 11);
    names.enqueue("William", 8);
    names.enqueue("Teddy", 8);

    names = names;
    string expectedOutput =
    "2 value: Ford\n"
    "4 value: Bernard\n"
    "5 value: Dolores\n"
    "6 value: Jasmine\n"
    "8 value: Arnold\n"
    "8 value: William\n"
    "8 value: Teddy\n"
    "11 value: Carlos\n";
    EXPECT_EQ(expectedOutput, names.as_string());
}

TEST(COPY, CopyConstructor) {
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    names.enqueue("Bernard", 4);
    names.enqueue("Arnold", 8);
    names.enqueue("Ford", 2);
    names.enqueue("Jasmine", 6);
    names.enqueue("Carlos", 11);
    names.enqueue("William", 8);
    names.enqueue("Teddy", 8);

    prqueue<string> clone(names);
    string expectedOutput =
    "2 value: Ford\n"
    "4 value: Bernard\n"
    "5 value: Dolores\n"
    "6 value: Jasmine\n"
    "8 value: Arnold\n"
    "8 value: William\n"
    "8 value: Teddy\n"
    "11 value: Carlos\n";
    EXPECT_EQ(expectedOutput, clone.as_string());
}

TEST(OPERATOREQUALEQUAL, SameTree) {
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    names.enqueue("Bernard", 4);
    names.enqueue("Arnold", 8);
    names.enqueue("Ford", 2);
    names.enqueue("Jasmine", 6);
    names.enqueue("Carlos", 11);
    names.enqueue("William", 8);
    names.enqueue("Teddy", 8);

    prqueue<string> names2;
    names2.enqueue("Dolores", 5);
    names2.enqueue("Bernard", 4);
    names2.enqueue("Arnold", 8);
    names2.enqueue("Ford", 2);
    names2.enqueue("Jasmine", 6);
    names2.enqueue("Carlos", 11);
    names2.enqueue("William", 8);
    names2.enqueue("Teddy", 8);

    prqueue<string> names3;
    names3.enqueue("Dolores", 11);
    names3.enqueue("Arnold", 9);
    names3.enqueue("Carlos", 22);
    names3.enqueue("Ford", 2);
    
    prqueue<string> emptyPQ;
    prqueue<string> emptyPQ2;

    prqueue<string> pq;
    pq.enqueue("10", 10);
    pq.enqueue("5", 5);
    pq.enqueue("30", 30);
    pq.enqueue("40", 40);
    pq.enqueue("-2", -2);
    pq.enqueue("6", 6);
    pq.enqueue("8", 8);
    pq.enqueue("2", 2);
    pq.enqueue("-1", -1);

    prqueue<string> pq2;
    pq2.enqueue("10", 10);
    pq2.enqueue("5", 5);
    pq2.enqueue("30", 30);
    pq2.enqueue("40", 40);
    pq2.enqueue("-2", -2);
    pq2.enqueue("6", 6);
    pq2.enqueue("8", 8);
    pq2.enqueue("2", 2);
    pq2.enqueue("-1", 0);

    prqueue<string> pq3;
    pq3.enqueue("10", 10);
    pq3.enqueue("5", 5);
    pq3.enqueue("30", 30);
    pq3.enqueue("40", 40);
    pq3.enqueue("-2", -2);
    pq3.enqueue("6", 6);
    pq3.enqueue("8", 8);
    pq3.enqueue("2", 2);
    pq3.enqueue("1", 0);

    EXPECT_EQ(true, names == names2);
    EXPECT_EQ(false, names == names3);
    EXPECT_EQ(true, names == names);
    EXPECT_EQ(false, emptyPQ == names);
    EXPECT_EQ(true, emptyPQ == emptyPQ2);
    EXPECT_EQ(false, pq == names3);
    EXPECT_EQ(true, pq == pq);
    EXPECT_EQ(false, pq == pq2);
    EXPECT_EQ(false, pq3 == pq2);
}

TEST(BEGINNEXT, BeginNextNoDuplicates) {
    int i = 0;
    string value; int priority;

    // No duplicates:
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    names.enqueue("Bernard", 4);
    names.enqueue("Arnold", 8);
    names.enqueue("Ford", 2);
    names.enqueue("Jasmine", 6);
    names.enqueue("Carlos", 11);
    vector<string> expectedValue = {"Ford", "Bernard", "Dolores", "Jasmine", "Arnold", "Carlos"};
    vector<int> expectedPriority = {2, 4, 5, 6, 8, 11};
    names.begin();
    i = 0;
    while (names.next(value, priority)) {
        EXPECT_EQ(expectedPriority[i], priority);
        EXPECT_EQ(expectedValue[i], value);  
        i += 1;
    }
    EXPECT_EQ(expectedValue.size(), i);

    // A different priority queue! 10, 5, 30, 40, -2, 6, 8, 2, -1
    prqueue<string> pq;
    pq.enqueue("10", 10);
    pq.enqueue("5", 5);
    pq.enqueue("30", 30);
    pq.enqueue("40", 40);
    pq.enqueue("-2", -2);
    pq.enqueue("6", 6);
    pq.enqueue("8", 8);
    pq.enqueue("2", 2);
    pq.enqueue("-1", -1);
    vector<string> expectedValue2 = {"-2", "-1", "2", "5", "6", "8", "10", "30", "40"};
    vector<int> expectedPriority2 = {-2, -1, 2, 5, 6, 8, 10, 30, 40};
    pq.begin();
    i = 0;
    while (pq.next(value, priority)) {
        EXPECT_EQ(expectedPriority2[i], priority);
        EXPECT_EQ(expectedValue2[i], value);  
        i += 1;
    }
    EXPECT_EQ(expectedValue2.size(), i);

    prqueue<string> emptyPQ;
    emptyPQ.begin();
    emptyPQ.next(value, priority);
}

TEST(NEXT, NextDuplicatesEnd) {
    string value; int priority;
    int i = 0;
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    names.enqueue("Bernard", 4);
    names.enqueue("Arnold", 8);
    names.enqueue("Ford", 2);
    names.enqueue("Jasmine", 6);
    names.enqueue("William", 8);
    names.enqueue("Teddy", 8);

    // Now handle duplicates!
    vector<string> expectedValue2 = {"Ford", "Bernard", "Dolores", "Jasmine", "Arnold", "William", "Teddy"};
    vector<int> expectedPriority2 = {2, 4, 5, 6, 8, 8, 8};
    names.begin();
    while(names.next(value, priority)) {
        EXPECT_EQ(expectedValue2[i], value);
        EXPECT_EQ(expectedPriority2[i], priority);
        i++;
    }
    EXPECT_EQ(expectedValue2.size(), i);
}

TEST(NEXT, MoreDuplicates) {
    string value; int priority;
    int i = 0;
    vector<string> expectedValue = {"Ford", "Bernard", "Dolores", "Jasmine", "Arnold", "William", "Teddy", "Carlos"};
    vector<int> expectedPriority = {2, 4, 5, 6, 8, 8, 8, 11};
    prqueue<string> names;
    names.enqueue("Dolores", 5);
    names.enqueue("Bernard", 4);
    names.enqueue("Arnold", 8);
    names.enqueue("Ford", 2);
    names.enqueue("Jasmine", 6);
    names.enqueue("Carlos", 11);
    names.enqueue("William", 8);
    names.enqueue("Teddy", 8);
    names.begin();
    while (names.next(value, priority)) {
        EXPECT_EQ(expectedValue[i], value);
        EXPECT_EQ(expectedPriority[i], priority);
        i++;
    }
    EXPECT_EQ(expectedValue.size(), i);
}

