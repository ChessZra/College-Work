/* -----------------------------------------------------------------------------------
Program 2: Search Project
Course: CS 251, Spring 2024, UIC
System: Advanced zyLab
Author: ChessZra
- -               - -
Description: This one was a bit hard. Plenty of edge cases - this program essentially
gathers all the texts and cleans it in a very specific way. So specific that it has to
be exactly the same as the reference solution. 
>> Given a text file, you can use this program as a search engine with built-in 
modifiers.
------------------------------------------------------------------------------------- */
// Preproccesor directives:
#pragma once

#include <iostream>
#include <map>
#include <set>
#include <string>
#include <sstream>
#include <fstream>
#include <vector>

using namespace std;

/**
 * Cleans a specific token by:
 * - Removing leading and trailing punctuation
 * - Converting to lowercase
 * If the token has no letters, returns the empty string.
 */
string cleanToken(string s) {
    // Initialize indices to trim leading and trailing punctuation
    size_t start = 0;
    size_t end = s.length();

    // Remove trailing and leading punctuations:
    while (start < end && ispunct(s[start])) start++;
    while (end > start && ispunct(s[end - 1])) end--;

    bool has_letter = false;
    for (size_t i = start; i < end; ++i) {
        if (isalpha(s[i])) {
            has_letter = true;
            break;
        }
    }

    if (!has_letter) return "";

    // Convert to lowercase and return the trimmed token
    string cleaned_token;
    for (size_t i = start; i < end; ++i) {
        cleaned_token += tolower(s[i]);
    }

    return cleaned_token;
}

/**
 * Returns a set of the cleaned tokens in the given text.
 */
set<string> gatherTokens(string text) {
    vector<string> words;
    string buffer;
    istringstream textStream(text);
    // Convert to vectors of "words" separated by whitespaces:
    while (textStream >> buffer) {
        words.push_back(buffer);
    }

    set<string> ret;
    for (string token: words) {
        string cleanedToken = cleanToken(token);
        if (cleanedToken == "") continue;
        ret.insert(cleanToken(token));
    }

    return ret;
}

/**
 * Builds the inverted index from the given data file. The existing contents
 * of `index` are left in place.
 */
int buildIndex(string filename, map<string, set<string>>& index) {
    string webPage, contents;
    int numberOfWebPages = 0;
    ifstream inFile;
    inFile.open(filename);

    if (!inFile.is_open()) {
        cout << "Invalid filename." << endl;
        return 0;
    }
    while (getline(inFile, webPage) && getline(inFile, contents)) {
        numberOfWebPages++;
        set<string> setOfTokens = gatherTokens(contents);
        for (string token: setOfTokens) {
            index[token].insert(webPage);
        }
    }
    inFile.close();
    return numberOfWebPages;
}

/**
 * Runs a search query on the provided index, and returns a set of results.
 *
 * Search terms are processed using set operations (union, intersection, difference).
 */
set<string> findQueryMatches(map<string, set<string>>& index, string sentence) {
    set<string> result;
    istringstream queryStream(sentence);
    string query;
    while (queryStream >> query) {
        char modifier = query[0];
        if (modifier == '-') {                          // Set difference:
            string newQuery = cleanToken(query);
            set<string> set1(result.begin(), result.end());
            set<string> set2(index[newQuery].begin(), index[newQuery].end());
            result.clear();
            set_difference(set1.begin(), set1.end(),
                           set2.begin(), set2.end(),
                           inserter(result, result.begin()));
        } else if (modifier == '+') {                   // Set intersection:
            string newQuery = cleanToken(query);
            set<string> set1(result.begin(), result.end());
            set<string> set2(index[newQuery].begin(), index[newQuery].end());
            result.clear();
            set_intersection(set1.begin(), set1.end(),
                             set2.begin(), set2.end(),
                             inserter(result, result.begin()));
        } else {                                        // Set union:
            string newQuery = cleanToken(query);
            set<string> set1(result.begin(), result.end());
            set<string> set2(index[newQuery].begin(), index[newQuery].end());
            result.clear();
            set_union(set1.begin(), set1.end(),
                      set2.begin(), set2.end(),
                      inserter(result, result.begin()));
        }
    }
    return result;
}

/**
 * Runs the main command loop for the search program
 */
void searchEngine(string filename) {
    
    map<string, set<string>> index;
    int numberofWebPages = buildIndex(filename, index);
    cout << "Stand by while building index..." << endl;
    int numberOfUniqueTerms = index.size();

    cout << "Indexed " << numberofWebPages << " pages containing " << numberOfUniqueTerms << " unique terms\n\n";

    while (true) {
        cout << "Enter query sentence (press enter to quit): ";
        string buffer;
        getline(cin, buffer);
        if (!buffer.size()) {
            cout << "Thank you for searching!";
            break;
        }
        set<string> results = findQueryMatches(index, buffer);
        cout << "Found " << results.size() << " matching pages" << endl;
        for (string web: results) cout << web << endl;
        cout << endl;
    }
}
