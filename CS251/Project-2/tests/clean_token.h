#include <gtest/gtest.h>

#include <map>
#include <set>
#include <sstream>
#include <string>

#include "search.h"

using namespace std;

void testCleanToken(const map<string, set<string>>& tests) {
    for (const auto& [expected, tokens] : tests) {
        for (const auto& toClean : tokens) {
            string studentResult = cleanToken(toClean);
            string testFeedback = "cleanToken(\"" + toClean + "\") incorrect\n";
            EXPECT_EQ(expected, studentResult) << testFeedback;
        }
    }
}

// Tokens without any punctuation or special characters
TEST(CleanToken, NoCleaning) {
    map<string, set<string>> tests;
    tests["same"].insert("same");
    tests["wander"].insert("wander");
    tests["l33tcode"].insert("l33tcode");

    testCleanToken(tests);
}

// Tokens with punctuation at the beginning
TEST(CleanToken, PrefixCleaning) {
    map<string, set<string>> tests;

    tests["hello"].insert(".hello");
    tests["hello"].insert("...hello");
    tests["hello"].insert(".\"!?hello");

    tests["timesheet"].insert(";timesheet");
    tests["timesheet"].insert(";.!timesheet");
    tests["timesheet"].insert(".,.!?timesheet");

    testCleanToken(tests);
}

// Tokens with punctuation at the end
TEST(CleanToken, SuffixCleaning) {
    map<string, set<string>> tests;

    tests["hello"].insert("hello.");
    tests["hello"].insert("hello...");
    tests["hello"].insert("hello.\"!?");

    tests["timesheet"].insert("timesheet;");
    tests["timesheet"].insert("timesheet;.!");
    tests["timesheet"].insert("timesheet.,.!?");

    testCleanToken(tests);
}

// Tokens without any letters
TEST(CleanToken, Empty) {
    map<string, set<string>> tests;

    tests[""].insert("23432423");
    tests[""].insert("2343098765432345678998765434567892423");
    tests[""].insert("....$$$$......");
    tests[""].insert("....2312^#@@@....");
    tests[""].insert("");

    testCleanToken(tests);
}

// Tokens with uppercase letters and punctuation
TEST(CleanToken, Uppercase) {
    map<string, set<string>> tests;

    tests["hello"].insert("HELLO.");
    tests["hello"].insert("heLlo...");
    tests["hello"].insert("hellO.\"!?");
    tests["hello"].insert(".HELLO");
    tests["hello"].insert("...Hello");
    tests["hello"].insert(".\"!?heLLo");

    testCleanToken(tests);
}
