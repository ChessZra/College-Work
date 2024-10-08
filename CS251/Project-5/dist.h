/*dist.h*/

//
// Adam T Koehler, PhD
// University of Illinois Chicago
// CS 251, Fall 2023
//
// Project Original Variartion By:
// Joe Hummel, PhD
// University of Illinois at Chicago
//

#include <cmath>
#include <iostream>

#include "osm.h"

using namespace std;

double distBetween2Points(double lat1, double long1, double lat2, double long2);
Coordinates centerBetween2Points(double lat1, double long1, double lat2, double long2);
