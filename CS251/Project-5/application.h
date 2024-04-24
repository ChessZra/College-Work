#pragma once

#include <map>
#include <set>
#include <vector>

#include "graph.h"
#include "osm.h"

/// @brief Build a `graph` from the given map data. Building centers that are
///        "close to" footway nodes are manually linked.
/// @param Nodes OSM nodes in the graph
/// @param Footways OSM footways, to be converted to edges
/// @param Buildings OSM building centers, to be linked to nodes on footways
/// @return constructed graph; edge weights are distances
graph<long long, double> buildGraph(
    const map<long long, Coordinates>& Nodes,
    const vector<FootwayInfo>& Footways,
    const vector<BuildingInfo>& Buildings);

/// @brief Run Dijkstra's algorithm on G to find the shortest path from `start` to
///        `target` that does not include any ignored nodes.
/// @param G graph
/// @param start starting node ID
/// @param target ending node ID
/// @param ignoreNodes node IDs to skip; may contain `start` / `target`
/// @return node IDs on shortest path from `start` to `target`
vector<long long> dijkstra(
    const graph<long long, double>& G,
    long long start,
    long long target,
    const set<long long>& ignoreNodes);

/// Command loop to request input
void application(
    const vector<BuildingInfo>& Buildings,
    const graph<long long, double>& G);
