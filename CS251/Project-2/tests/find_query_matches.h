#include <gtest/gtest.h>

#include <map>
#include <set>
#include <string>

#include "search.h"

using namespace std;

map<string, set<string>> INDEX = {
    {"hello", {"example.com", "uic.edu"}},
    {"there", {"example.com"}},
    {"according", {"uic.edu"}},
    {"to", {"uic.edu"}},
    {"all", {"example.com", "uic.edu", "random.org"}},
    {"known", {"uic.edu"}},
    {"laws", {"random.org"}},
    {"of", {"random.org"}},
    {"aviation", {"random.org"}},
    {"a", {"uic.edu", "random.org"}},
};

TEST(FindQueryMatches, SingleTerm) {
    set<string> expected;

    expected = {"example.com"};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "there"));

    expected = {"example.com", "uic.edu"};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "hello"));
    EXPECT_EQ(expected, findQueryMatches(INDEX, "Hello!"));
}

TEST(FindQueryMatches, Union) {
    set<string> expected;

    expected = {"uic.edu"};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "known to"));

    expected = {"example.com", "uic.edu", "random.org"};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "hello laws aviation"));
    EXPECT_EQ(expected, findQueryMatches(INDEX, "Hello, Laws, AVIATION!"));
}

TEST(FindQueryMatches, Intersection) {
    set<string> expected;

    expected = {"example.com"};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "all +there"));

    expected = {"example.com", "uic.edu"};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "hello +all"));

    expected = {"uic.edu"};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "hello +all +to"));

    expected = {};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "hello +aviation"));
}

TEST(FindQueryMatches, Difference) {
    set<string> expected;

    expected = {"example.com", "uic.edu"};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "all -laws"));

    expected = {"random.org"};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "all -hello"));

    expected = {"example.com"};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "all -of -a"));

    expected = {};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "known -to"));

    expected = {};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "to -all -a"));
}

TEST(FindQueryMatches, LongCombinedQueries) {
    set<string> expected;

    expected = {"example.com"};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "there laws aviation -to +hello"));

    expected = {};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "all -all +all"));

    expected = {"example.com", "uic.edu", "random.org"};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "all -all +all all"));
}

