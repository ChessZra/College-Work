#include <iostream>

#include "prqueue.h"

using namespace std;

int main()
{
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

	cout << names.as_string();
}
