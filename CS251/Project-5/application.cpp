#include "application.h"

#include <cassert>
#include <cstdlib>
#include <cstring>
#include <iomanip> /*setprecision*/
#include <iostream>
#include <map>
#include <queue>
#include <set>
#include <stack>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

#include "dist.h"
#include "graph.h"
#include "osm.h"
#include "tinyxml2.h"

using namespace std;
using namespace tinyxml2;

class prioritize {
   public:
    bool operator()(const pair<long long, double>& p1,
                    const pair<long long, double>& p2) const {
        return p1.second > p2.second;
    }
};

double INF = numeric_limits<double>::max();

graph<long long, double> buildGraph(
    const map<long long, Coordinates>& Nodes,
    const vector<FootwayInfo>& Footways,
    const vector<BuildingInfo>& Buildings) {
    graph<long long, double> G;

    // Build the vertices composed of the Node IDs and building IDs ::
    // Firstly, let's add the nodes.
    for (const auto pair: Nodes) {
        G.addVertex(pair.first);
    }
    // Then, we can add the buildings...
    for (size_t i = 0; i < Buildings.size(); i++) {
        G.addVertex(Buildings[i].Coords.ID);
    }

    // Build the edges ::
    // For each footway, build it such that it's bidirectional.
    for (size_t i = 0; i < Footways.size(); i++) {
        for (size_t j = 0; j < (Footways[i].Nodes.size() - 1); j++) {
            long long firstID = Footways[i].Nodes[j];
            long long secondID = Footways[i].Nodes[j + 1];
            double weight = distBetween2Points(Nodes.at(firstID).Lat, Nodes.at(firstID).Lon,
                                               Nodes.at(secondID).Lat, Nodes.at(secondID).Lon);
            G.addEdge(firstID, secondID, weight);
            G.addEdge(secondID, firstID, weight);
        }
    }
    // For each building, build an edge from a building node to
    // any node that is on a footway and 0.041 miles
    for (size_t i = 0; i < Buildings.size(); i++) {
        double lat2 = Buildings[i].Coords.Lat;
        double lon2 = Buildings[i].Coords.Lon;
        long long buildingID = Buildings[i].Coords.ID;
        for (const auto pair: Nodes) {
            double weight = distBetween2Points(pair.second.Lat, pair.second.Lon, lat2, lon2);
            if (pair.second.OnFootway && weight <= 0.041) {     
                G.addEdge(buildingID, pair.first, weight);
                G.addEdge(pair.first, buildingID, weight);
            }
        }
    }

    return G;
}

vector<long long> dijkstra(
    const graph<long long, double>& G,
    long long start,
    long long target,
    const set<long long>& ignoreNodes) {
    if (start == target) return {start};
    vector<long long> path;

    priority_queue<pair<long long, double>,
                    vector<pair<long long, double>>,
                    prioritize> pq;

    unordered_map<long long, double> distances;
    unordered_map<long long, long long> predecessors; // to: from
    vector<long long> vertices = G.getVertices();

    // Initialize all nodes to be infinity ::
    for (size_t i = 0; i < vertices.size(); i++) {
        distances[vertices[i]] = INF;
    }
    
    // Initialize the pq with start ::
    pq.push(make_pair(start, 0));
    distances[start] = 0;

    // Perform dikjstra's algorithm ::
    while (!pq.empty()) {
        // Dequeue the minimum element:
        long long currentNode = pq.top().first;
        pq.pop();

        // Update neighbor weights:
        for (const auto& nextNode: G.neighbors(currentNode)) {
            if (ignoreNodes.find(nextNode) != ignoreNodes.end() && nextNode != target) continue;
            double edgeWeight;
            G.getWeight(currentNode, nextNode, edgeWeight);
            double totalWeight = distances[currentNode] + edgeWeight;

            if (totalWeight < distances[nextNode]) {
                distances[nextNode] = totalWeight;
                predecessors[nextNode] = currentNode;
                // We insert even if nextNode's ID already exists there:
                pq.push(make_pair(nextNode, totalWeight));
            }
        }
    }
    
    if (distances[target] == INF) return {};

    // Format the path ::
    vector<long long> reversedPath;
    long long cur = target;
    while (cur != start) {
        long long next = predecessors[cur];
        reversedPath.push_back(cur);
        cur = next;
    }
    reversedPath.push_back(cur);
    for (int i = reversedPath.size() - 1; i >= 0; i--) {
        path.push_back(reversedPath[i]);
    }

    return path;
}

double pathLength(const graph<long long, double>& G, const vector<long long>& path) {
    double length = 0.0;
    double weight;
    for (size_t i = 0; i + 1 < path.size(); i++) {
        bool res = G.getWeight(path.at(i), path.at(i + 1), weight);
        assert(res);
        length += weight;
    }
    return length;
}

void outputPath(const vector<long long>& path) {
    for (size_t i = 0; i < path.size(); i++) {
        cout << path.at(i);
        if (i != path.size() - 1) {
            cout << "->";
        }
    }
    cout << endl;
}

void application(
    const vector<BuildingInfo>& Buildings,
    const graph<long long, double>& G) {
    string person1Building, person2Building;

    set<long long> buildingNodes;
    for (const auto& building : Buildings) {
        buildingNodes.insert(building.Coords.ID);
    }

    cout << endl;
    cout << "Enter person 1's building (partial name or abbreviation), or #> ";
    getline(cin, person1Building);

    while (person1Building != "#") {
        cout << "Enter person 2's building (partial name or abbreviation)> ";
        getline(cin, person2Building);

        //
        // find the building coordinates
        //
        bool foundP1 = false;
        bool foundP2 = false;
        Coordinates P1Coords, P2Coords;
        string P1Name, P2Name;

        for (const BuildingInfo& building : Buildings) {
            if (building.Abbrev == person1Building) {
                foundP1 = true;
                P1Name = building.Fullname;
                P1Coords = building.Coords;
            }
            if (building.Abbrev == person2Building) {
                foundP2 = true;
                P2Name = building.Fullname;
                P2Coords = building.Coords;
            }
        }

        for (const BuildingInfo& building : Buildings) {
            if (!foundP1 &&
                building.Fullname.find(person1Building) != string::npos) {
                foundP1 = true;
                P1Name = building.Fullname;
                P1Coords = building.Coords;
            }
            if (!foundP2 && building.Fullname.find(person2Building) != string::npos) {
                foundP2 = true;
                P2Name = building.Fullname;
                P2Coords = building.Coords;
            }
        }

        if (!foundP1) {
            cout << "Person 1's building not found" << endl;
        } else if (!foundP2) {
            cout << "Person 2's building not found" << endl;
        } else {
            cout << endl;
            cout << "Person 1's point:" << endl;
            cout << " " << P1Name << endl;
            cout << " (" << P1Coords.Lat << ", " << P1Coords.Lon << ")" << endl;
            cout << "Person 2's point:" << endl;
            cout << " " << P2Name << endl;
            cout << " (" << P2Coords.Lat << ", " << P2Coords.Lon << ")" << endl;

            string destName;
            Coordinates destCoords;

            Coordinates centerCoords = centerBetween2Points(
                P1Coords.Lat, P1Coords.Lon, P2Coords.Lat, P2Coords.Lon);

            double minDestDist = numeric_limits<double>::max();

            for (const BuildingInfo& building : Buildings) {
                double dist = distBetween2Points(
                    centerCoords.Lat, centerCoords.Lon,
                    building.Coords.Lat, building.Coords.Lon);
                if (dist < minDestDist) {
                    minDestDist = dist;
                    destCoords = building.Coords;
                    destName = building.Fullname;
                }
            }

            cout << "Destination Building:" << endl;
            cout << " " << destName << endl;
            cout << " (" << destCoords.Lat << ", " << destCoords.Lon << ")" << endl;

            vector<long long> P1Path = dijkstra(G, P1Coords.ID, destCoords.ID, buildingNodes);
            vector<long long> P2Path = dijkstra(G, P2Coords.ID, destCoords.ID, buildingNodes);

            // This should NEVER happen with how the graph is built
            if (P1Path.empty() || P2Path.empty()) {
                cout << endl;
                cout << "At least one person was unable to reach the destination building. Is an edge missing?" << endl;
                cout << endl;
            } else {
                cout << endl;
                cout << "Person 1's distance to dest: " << pathLength(G, P1Path);
                cout << " miles" << endl;
                cout << "Path: ";
                outputPath(P1Path);
                cout << endl;
                cout << "Person 2's distance to dest: " << pathLength(G, P2Path);
                cout << " miles" << endl;
                cout << "Path: ";
                outputPath(P2Path);
            }
        }

        //
        // another navigation?
        //
        cout << endl;
        cout << "Enter person 1's building (partial name or abbreviation), or #> ";
        getline(cin, person1Building);
    }
}
