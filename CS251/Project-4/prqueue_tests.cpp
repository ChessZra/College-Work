#include "prqueue.h"

#include "gtest/gtest.h"
#include "map"
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