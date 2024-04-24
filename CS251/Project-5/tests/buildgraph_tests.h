#pragma once

#include <gtest/gtest.h>

#include <iostream>
#include <map>
#include <set>
#include <string>
#include <vector>

#include "application.h"
#include "dist.h"
#include "graph.h"

using namespace std;

// graph<long long, double> buildGraph(
//     const map<long long, Coordinates>& Nodes,
//     const vector<FootwayInfo>& Footways,
//     const vector<BuildingInfo>& Buildings);

Coordinates intToCoords(int n) {
    // :)
    return Coordinates(n, n, n);
}

TEST(BuildGraph, BasicNodesInGraph) {
    map<long long, Coordinates> nodes;
    vector<long long> expectedVertices;

    for (int i = 0; i < 5; i++) {
        nodes.emplace(i, intToCoords(i));
        expectedVertices.push_back(i);
    }

    graph<long long, double> g = buildGraph(nodes, {}, {});
    vector<long long> actualVertices = g.getVertices();
    sort(actualVertices.begin(), actualVertices.end());

    ASSERT_EQ(nodes.size(), g.NumVertices());
    ASSERT_EQ(expectedVertices, actualVertices);
    ASSERT_EQ(0, g.NumEdges());
}

TEST(BuildGraph, BasicFootway) {
    map<long long, Coordinates> nodes;
    vector<long long> expectedVertices;

    for (int i = 0; i < 4; i++) {
        nodes.emplace(i, intToCoords(i));
    }

    vector<FootwayInfo> footways;
    FootwayInfo fi;
    fi.Nodes = {0, 1, 2, 3, 0};
    footways.push_back(fi);

    graph<long long, double> g = buildGraph(nodes, footways, {});
    ASSERT_EQ(8, g.NumEdges()) << "Wrong number of edges. You might be off by one when iterating, or you might not be adding undirected edges";

    double weight;
    ASSERT_TRUE(g.getWeight(0, 1, weight));
    ASSERT_TRUE(g.getWeight(1, 0, weight));
    ASSERT_TRUE(g.getWeight(1, 2, weight));
    ASSERT_TRUE(g.getWeight(2, 1, weight));
    ASSERT_TRUE(g.getWeight(2, 3, weight));
    ASSERT_TRUE(g.getWeight(3, 2, weight));
    ASSERT_TRUE(g.getWeight(3, 0, weight));
    ASSERT_TRUE(g.getWeight(0, 3, weight));

    ASSERT_FALSE(g.getWeight(0, 2, weight));
    ASSERT_FALSE(g.getWeight(2, 0, weight));
    ASSERT_FALSE(g.getWeight(1, 3, weight));
    ASSERT_FALSE(g.getWeight(3, 1, weight));
}

TEST(BuildGraph, BasicNodesWithBuildings) {
    map<long long, Coordinates> nodes;
    vector<long long> expectedVertices;

    for (int i = 0; i < 5; i++) {
        nodes.emplace(i, intToCoords(i));
        expectedVertices.push_back(i);
    }

    vector<BuildingInfo> buildingInfo;
    buildingInfo.push_back(BuildingInfo("fake", "FAKE", 10, 0, 0));
    expectedVertices.push_back(10);

    graph<long long, double> g = buildGraph(nodes, {}, buildingInfo);
    vector<long long> actualVertices = g.getVertices();
    sort(actualVertices.begin(), actualVertices.end());

    ASSERT_EQ(nodes.size() + 1, g.NumVertices()) << "Wrong number of vertices, did you add the building to the graph?";
    ASSERT_EQ(expectedVertices, actualVertices);
    ASSERT_EQ(0, g.NumEdges()) << "Should not be any edges, none of the nodes are on footways";
}

TEST(BuildGraph, SmallWithEverything) {
    map<long long, Coordinates> nodes;
    vector<long long> expectedVertices;

    for (int i = 0; i < 5; i++) {
        nodes.emplace(i, intToCoords(i));
        expectedVertices.push_back(i);
    }

    nodes.at(0).OnFootway = true;
    nodes.at(4).OnFootway = true;

    vector<BuildingInfo> buildingInfo;
    buildingInfo.push_back(BuildingInfo("fake", "FAKE", 10, 0.000001, 0.000003));
    expectedVertices.push_back(10);

    graph<long long, double> g = buildGraph(nodes, {}, buildingInfo);
    vector<long long> actualVertices = g.getVertices();
    sort(actualVertices.begin(), actualVertices.end());

    ASSERT_EQ(nodes.size() + 1, g.NumVertices()) << "Wrong number of vertices, did you add the building to the graph?";
    ASSERT_EQ(expectedVertices, actualVertices);
    ASSERT_EQ(2, g.NumEdges()) << "Building should be linked to 1 node; use OnFootway instead of footway vectors";

    double weight;
    ASSERT_TRUE(g.getWeight(0, 10, weight));
    ASSERT_TRUE(g.getWeight(10, 0, weight));
}

TEST(BuildGraph, FootwayEdgeSymmetry) {
    map<long long, Coordinates> nodes;
    nodes[0] = Coordinates(0, 41.8725285, -87.6482622);
    nodes[1] = Coordinates(1, 41.8725300, -87.6481384);

    vector<FootwayInfo> footways;
    FootwayInfo fi;
    fi.Nodes = {0, 1};
    footways.push_back(fi);

    graph<long long, double> g = buildGraph(nodes, footways, {});

    double dist_0_1;
    double dist_1_0;
    ASSERT_TRUE(g.getWeight(0, 1, dist_0_1)) << "Edge should be present";
    ASSERT_TRUE(g.getWeight(1, 0, dist_1_0)) << "Edge should be present";

    ASSERT_EQ(dist_0_1, dist_1_0) << "Edges between the same nodes should have the exact same weight." << endl
                                  << "Check that you're only making one call to distBetween2Points for footway edges.";
}

TEST(BuildGraph, BuildingEdgeSymmetry) {
    map<long long, Coordinates> nodes;
    nodes[0] = Coordinates(0, 41.8725285, -87.6482622);
    nodes[0].OnFootway = true;

    vector<BuildingInfo> buildingInfo;
    buildingInfo.push_back(BuildingInfo("fake", "FAKE", 10, 41.8725300, -87.6481384));
    nodes[1] = Coordinates(1, 41.8725300, -87.6481384);

    graph<long long, double> g = buildGraph(nodes, {}, buildingInfo);

    double dist_0_10;
    double dist_10_0;
    ASSERT_TRUE(g.getWeight(0, 10, dist_0_10)) << "Edge should be present, weight ~0.0064";
    ASSERT_TRUE(g.getWeight(10, 0, dist_10_0)) << "Edge should be present, weight ~0.0064";

    ASSERT_EQ(dist_0_10, dist_10_0) << "Edges between the same nodes should have the exact same weight." << endl
                                    << "Check that you're only making one call to distBetween2Points for building edges.";
}

TEST(BuildGraph, Full) {
    map<long long, Coordinates> Nodes;
    vector<FootwayInfo> Footways;
    vector<BuildingInfo> Buildings;
    XMLDocument xmldoc;

    // Load XML-based map file
    ASSERT_TRUE(LoadOpenStreetMap("uic-2024.osm", xmldoc)) << "Unable to load OSM file";

    ReadMapNodes(xmldoc, Nodes);
    ReadFootways(xmldoc, Nodes, Footways);
    ReadUniversityBuildings(xmldoc, Nodes, Buildings);

    // Magic numbers
    int expectedVertices = 23505;
    int expectedEdges = 12592;

    graph<long long, double> g = buildGraph(Nodes, Footways, Buildings);
    EXPECT_EQ(expectedVertices, g.NumVertices());
    EXPECT_EQ(expectedEdges, g.NumEdges());

    // IMO -- no need to check specific edges if we look at count
}
