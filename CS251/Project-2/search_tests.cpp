#include <gtest/gtest.h>

#include "search.h"
#include "tests/build_index.h"
#include "tests/clean_token.h"
#include "tests/find_query_matches.h"
#include "tests/gather_tokens.h"

TEST(CleanToken, ExampleEmptyTest) {
    cout << "Hi! This shows up in the terminal." << endl;
}

// Tokens with punctuation at both the beginning and end
TEST(CleanToken, PrefixSuffixCleaning) {
    map<string, set<string>> tests;

    tests["hello"].insert(".hello..!?");
    tests["hello"].insert("...hello?!,");
    tests["hello"].insert(".\"!?hello!?!/,");

    tests["timesheet"].insert(";timesheet?!");
    tests["timesheet"].insert(";.!timesheet?**\"");
    tests["timesheet"].insert(".,.!?timesheet?!()");

    testCleanToken(tests);
}

// Tokens with punctuation in the middle, as well as possibly at the ends
TEST(CleanToken, middleCleaning) {
    map<string, set<string>> tests;

    tests["hel!?lo"].insert("hel!?lo..!?");
    tests["hel..lo"].insert("...hel..lo");
    tests["hel.?*lo"].insert(".\"hel.?*lo");

    tests["ti!mes*he?et"].insert("ti!mes*he?et;*");
    tests["time(shee)t"].insert(";.!time(shee)t");
    tests["time!sheet"].insert("time!sheet");

    testCleanToken(tests);
}

// Text with leading spaces
TEST(GatherTokens, LeadingSpaces) {
    string text = "                    red ~gre-en~ orange, yellow + blue (indigo) &violet";
    set<string> expected = {"red", "gre-en", "orange", "blue", "indigo", "violet", "yellow"};
    set<string> studentResult = gatherTokens(text);

    string testFeedback = "gatherTokens(\"" + text + "\") incorrect\n";

    EXPECT_EQ(expected, studentResult) << testFeedback;
}

// Text with leading numbers
TEST(GatherTokens, LeadingNumbers) {
    string text = "                    red ~gre-en~ orange, yellow + blue (indigo) &violet5125";
    set<string> expected = {"red", "gre-en", "orange", "blue", "indigo", "violet5125", "yellow"};
    set<string> studentResult = gatherTokens(text);

    string testFeedback = "gatherTokens(\"" + text + "\") incorrect\n";

    EXPECT_EQ(expected, studentResult) << testFeedback;
}

// Text with trailing spaces
TEST(GatherTokens, TrailingSpaces) {
    string text = "red ~gre-en~ orange, yellow + blue (indigo) &violet                 ";
    set<string> expected = {"red", "gre-en", "orange", "blue", "indigo", "violet", "yellow"};
    set<string> studentResult = gatherTokens(text);

    string testFeedback = "gatherTokens(\"" + text + "\") incorrect\n";

    EXPECT_EQ(expected, studentResult) << testFeedback;
}

// Text with multiple spaces between words
TEST(GatherTokens, SpacesBetweenWords) {
    string text = "red      ~gre-en~       orange,     yellow  +      blue      (indigo)    &violet";
    set<string> expected = {"red", "gre-en", "orange", "blue", "indigo", "violet", "yellow"};
    set<string> studentResult = gatherTokens(text);

    string testFeedback = "gatherTokens(\"" + text + "\") incorrect\n";

    EXPECT_EQ(expected, studentResult) << testFeedback;
}

// Text with a custom analyzed data for Tiny.txt
TEST(BuildIndex, TinyTxt) {
    string filename = "tiny.txt";
    map<string, set<string>> expected = {
        {"eggs", {"www.shoppinglist.com"}},
        {"milk", {"www.shoppinglist.com"}},
        {"fish", {"www.shoppinglist.com", "www.dr.seuss.net"}},
        {"bread", {"www.shoppinglist.com"}},
        {"cheese", {"www.shoppinglist.com"}},

        {"red", {"www.rainbow.org", "www.dr.seuss.net"}},
        {"green", {"www.rainbow.org"}},
        {"orange", {"www.rainbow.org"}},
        {"yellow", {"www.rainbow.org"}},
        {"blue", {"www.rainbow.org", "www.dr.seuss.net"}},
        {"indigo", {"www.rainbow.org"}},
        {"violet", {"www.rainbow.org"}},
        {"one", {"www.dr.seuss.net"}},
        {"two", {"www.dr.seuss.net"}},
        {"i'm", {"www.bigbadwolf.com"}},
        {"not", {"www.bigbadwolf.com"}},
        {"trying", {"www.bigbadwolf.com"}},
        {"to", {"www.bigbadwolf.com"}},
        {"eat", {"www.bigbadwolf.com"}},
        {"you", {"www.bigbadwolf.com"}},
    };
    map<string, set<string>> studentIndex;
    int studentNumProcesed = buildIndex(filename, studentIndex);

    string indexTestFeedback = "buildIndex(\"" + filename + "\", ...) index incorrect\n";
    EXPECT_EQ(expected, studentIndex) << indexTestFeedback;

    string retTestFeedback = "buildIndex(\"" + filename + "\", ...) return value incorrect\n";
    EXPECT_EQ(4, studentNumProcesed) << retTestFeedback;
}

// Text with invalid file name.
TEST(BuildIndex, InvalidFileName) {
    string filename = "invalidFileName.txt";
    map<string, set<string>> expected = {};
    map<string, set<string>> studentIndex;
    int studentNumProcesed = buildIndex(filename, studentIndex);

    string indexTestFeedback = "buildIndex(\"" + filename + "\", ...) index incorrect\n";
    EXPECT_EQ(expected, studentIndex) << indexTestFeedback;

    string retTestFeedback = "buildIndex(\"" + filename + "\", ...) return value incorrect\n";
    EXPECT_EQ(0, studentNumProcesed) << retTestFeedback;
}

// The first query term does not appear in the index
TEST(FindQueryMatches, InvalidFirstQuery) {
    set<string> expected;
    expected = {};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "nonexistent"));

    expected = {"uic.edu"};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "to nonexistent"));
}

// A later query term, possibly with a modifier, does not appear in the index
TEST(FindQueryMatches, InvalidModifier) {
    set<string> expected;
    expected = {"uic.edu"};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "to -nonexistent"));

    expected = {};
    EXPECT_EQ(expected, findQueryMatches(INDEX, "to +nonexistent"));
}
