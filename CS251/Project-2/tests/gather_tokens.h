#include <gtest/gtest.h>

#include <map>
#include <set>
#include <string>

#include "search.h"

using namespace std;

TEST(GatherTokens, BasicTest) {
    string text = "to be ora not to be";
    set<string> expected = {"to", "be", "ora", "not"};
    set<string> studentResult = gatherTokens(text);

    string testFeedback = "gatherTokens(\"" + text + "\") incorrect\n";

    EXPECT_EQ(expected, studentResult) << testFeedback;
}

TEST(GatherTokens, Nom) {
    string text = "I'm not trying to eat you!";
    set<string> expected = {"i'm", "not", "trying", "to", "eat", "you"};
    set<string> studentResult = gatherTokens(text);

    string testFeedback = "gatherTokens(\"" + text + "\") incorrect\n";

    EXPECT_EQ(expected, studentResult) << testFeedback;
}

TEST(GatherTokens, Colors) {
    string text = "red ~gre-en~ orange, yellow + blue (indigo) &violet";
    set<string> expected = {"red", "gre-en", "orange", "blue", "indigo", "violet", "yellow"};
    set<string> studentResult = gatherTokens(text);

    string testFeedback = "gatherTokens(\"" + text + "\") incorrect\n";

    EXPECT_EQ(expected, studentResult) << testFeedback;
}

