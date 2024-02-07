#include <gtest/gtest.h>

#include <map>
#include <set>
#include <string>

#include "search.h"

using namespace std;

TEST(BuildIndex, TinierTxt) {
    string filename = "tinier.txt";
    map<string, set<string>> expected = {
        {"to", {"www.example.com", "www.otherexample.com"}},
        {"be", {"www.example.com", "www.otherexample.com"}},
        {"ora", {"www.example.com"}},
        {"not", {"www.example.com"}},
        {"want", {"www.otherexample.com"}},
        {"free", {"www.otherexample.com"}},
    };
    map<string, set<string>> studentIndex;
    int studentNumProcesed = buildIndex(filename, studentIndex);

    string indexTestFeedback = "buildIndex(\"" + filename + "\", ...) index incorrect\n";
    EXPECT_EQ(expected, studentIndex) << indexTestFeedback;

    string retTestFeedback = "buildIndex(\"" + filename + "\", ...) return value incorrect\n";
    EXPECT_EQ(2, studentNumProcesed) << retTestFeedback;
}
