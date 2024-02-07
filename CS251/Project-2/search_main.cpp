#include <iostream>
#include <string>

#include "search.h"

using namespace std;

int main() {
    string filename;
    getline(cin, filename);

    // cout << "DEBUG: Reading " << filename << endl;
    // This will not work until we're done with the project!
    searchEngine(filename);
    return 0;
}
