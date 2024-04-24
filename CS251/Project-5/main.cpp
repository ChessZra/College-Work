#include <iostream>
#include <iomanip>  /*setprecision*/
#include <string>
#include <vector>
#include <map>
#include <cstdlib>
#include <cassert>

#include "tinyxml2.h"
#include "graph.h"
#include "osm.h"
#include "application.h"

using namespace std;
using namespace tinyxml2;


int main() {
  // maps a Node ID to it's coordinates (lat, lon)
  map<long long, Coordinates>  Nodes;
  // info about each footway, in no particular order
  vector<FootwayInfo>          Footways;
  // info about each building, in no particular order
  vector<BuildingInfo>         Buildings;
  XMLDocument                  xmldoc;

  cout << "** Navigating UIC open street map **" << endl;
  // cout << endl;
  cout << std::setprecision(8);

  string default_filename = "uic-2024.osm";
  string filename;

  // cout << "Enter map filename> ";
  // getline(cin, filename);

  if (filename == "") {
    filename = default_filename;
  }

  // Load XML-based map file
  if (!LoadOpenStreetMap(filename, xmldoc)) {
    cout << "**Error: unable to load open street map." << endl;
    cout << endl;
    return 0;
  }

  // Read the nodes, which are the various known positions on the map:
  int nodeCount = ReadMapNodes(xmldoc, Nodes);

  // Read the footways, which are the walking paths:
  int footwayCount = ReadFootways(xmldoc, Nodes, Footways);

  // Read the university buildings:
  int buildingCount = ReadUniversityBuildings(xmldoc, Nodes, Buildings);

  // Stats
  assert(nodeCount == (int)Nodes.size());
  assert(footwayCount == (int)Footways.size());
  assert(buildingCount == (int)Buildings.size());

  // cout << endl;
  cout << "# of nodes: " << Nodes.size() << endl;
  cout << "# of footways: " << Footways.size() << endl;
  cout << "# of buildings: " << Buildings.size() << endl;

  // Build graph from input data
  graph<long long, double> G = buildGraph(Nodes, Footways, Buildings);

  // More stats
  cout << "# of vertices: " << G.NumVertices() << endl;
  cout << "# of edges: " << G.NumEdges() << endl;
  application(Buildings, G);

  cout << "** Done **" << endl;
  return 0;
}