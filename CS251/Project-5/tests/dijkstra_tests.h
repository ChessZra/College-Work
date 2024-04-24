#pragma once

#include <gtest/gtest.h>

#include <iostream>
#include <map>
#include <set>
#include <string>
#include <vector>

#include "application.h"
#include "graph.h"

// Global variables to avoid multiple expensive loads/parses
graph<long long, double> UIC_GRAPH;
set<long long> BUILDING_NODES;

void fillUicGraph() {
    if (UIC_GRAPH.NumVertices()) return;

    map<long long, Coordinates> Nodes;
    vector<FootwayInfo> Footways;
    vector<BuildingInfo> Buildings;
    XMLDocument xmldoc;

    ASSERT_TRUE(LoadOpenStreetMap("uic-2024.osm", xmldoc)) << "Unable to load OSM file";

    ReadMapNodes(xmldoc, Nodes);
    ReadFootways(xmldoc, Nodes, Footways);
    ReadUniversityBuildings(xmldoc, Nodes, Buildings);

    UIC_GRAPH = buildGraph(Nodes, Footways, Buildings);
    for (const auto& b : Buildings) {
        BUILDING_NODES.insert(b.Coords.ID);
    }
}

/// Produce a graph that is a line of nodes (i.e. singly linked list)
graph<long long, double> lineGraph(int n) {
    graph<long long, double> g;

    for (int i = 0; i < n; i++) {
        g.addVertex(i);
    }

    for (int i = 0; i < n - 1; i++) {
        g.addEdge(i, i + 1, i + 1);
    }
    return g;
}

TEST(Dijkstra, StartTargetSame) {
    graph<long long, double> g = lineGraph(3);

    vector<long long> expected = {0};
    ASSERT_EQ(expected, dijkstra(g, 0, 0, {})) << "Path from node to itself should be the node";
}

TEST(Dijkstra, Unreachable) {
    graph<long long, double> g = lineGraph(3);

    vector<long long> expected = {};
    ASSERT_EQ(expected, dijkstra(g, 2, 0, {})) << "Unreachable nodes have an empty path";
}

TEST(Dijkstra, BasicLineGraph) {
    graph<long long, double> g = lineGraph(3);
    vector<long long> expected = {0, 1, 2};
    ASSERT_EQ(expected, dijkstra(g, 0, 2, {})) << "Wrong shortest path in line graph";
}

TEST(Dijkstra, BasicLineGraphWithEndNodesExcluded) {
    graph<long long, double> g = lineGraph(3);

    vector<long long> expected = {0, 1, 2};
    ASSERT_EQ(expected, dijkstra(g, 0, 2, {0, 2})) << "Wrong shortest path in line graph." << endl
                                                   << "The start and target nodes may be in skipNodes.";
}

TEST(Dijkstra, BasicLineGraphSkipNodes) {
    graph<long long, double> g = lineGraph(3);
    g.addVertex(10);
    g.addEdge(0, 10, 0.01);
    g.addEdge(10, 2, 0.01);

    vector<long long> expected = {0, 1, 2};
    ASSERT_EQ(expected, dijkstra(g, 0, 2, {0, 2, 10})) << "Wrong shortest path in line graph." << endl
                                                       << "The shortest path shouldn't go through skipped nodes (except for the ends).";
}

TEST(Dijkstra, SmallTest) {
    graph<long long, double> g;
    for (long long i = 0; i < 5; i++) {
        g.addVertex(i);
    }
    g.addEdge(0, 1, 100.0);
    g.addEdge(1, 2, 100.0);
    g.addEdge(2, 3, 100.0);
    g.addEdge(3, 4, 100.0);
    g.addEdge(0, 4, 700.0);

    vector<long long> expected = {0, 1, 2, 3, 4};
    ASSERT_EQ(expected, dijkstra(g, 0, 4, {})) << "Wrong shortest path in graph. See test." << endl;
}

TEST(Dijkstra, ThatOneGraphFromLecture_Maybe) {
    graph<long long, double> g;
    for (long long i = 0; i < 8; i++) {
        g.addVertex(i);
    }
    g.addEdge(0, 1, 2.0);
    g.addEdge(0, 2, 1.0);
    g.addEdge(0, 3, 4.0);

    g.addEdge(1, 5, 2.0);
    g.addEdge(1, 4, 8.0);
    g.addEdge(1, 2, 5.0);

    g.addEdge(2, 0, 9.0);
    g.addEdge(2, 4, 11.0);

    g.addEdge(3, 2, 2.0);

    g.addEdge(4, 7, 3.0);

    g.addEdge(5, 6, 3.0);

    g.addEdge(6, 7, 1.0);

    g.addEdge(7, 5, 2.0);
    g.addEdge(7, 4, 1.0);

    vector<long long> expected = {0, 1, 5, 6, 7, 4};
    ASSERT_EQ(expected, dijkstra(g, 0, 4, {})) << "Wrong shortest path in graph. See test." << endl;
}

TEST(Dijkstra, YetAnotherSmallTest) {
    graph<long long, double> g;
    for (long long i = 0; i < 6; i++) {
        g.addVertex(i);
    }
    g.addEdge(0, 1, 1.0);
    g.addEdge(1, 2, 1.0);
    g.addEdge(2, 3, 1.0);
    g.addEdge(3, 4, 1.0);
    g.addEdge(0, 5, 90.0);
    g.addEdge(1, 5, 80.0);
    g.addEdge(2, 5, 70.0);
    g.addEdge(3, 5, 60.0);
    g.addEdge(4, 5, 50.0);

    vector<long long> expected = {0, 1, 2, 3, 4, 5};
    ASSERT_EQ(expected, dijkstra(g, 0, 5, {})) << "Wrong shortest path in graph. See test." << endl;
}

TEST(Dijkstra, YouThoughtItWasDoneDidntYou) {
    graph<long long, double> g;
    for (long long i = 0; i < 7; i++) {
        g.addVertex(i);
    }
    g.addEdge(0, 2, 2.0);
    g.addEdge(0, 3, 1.0);
    g.addEdge(1, 0, 2.0);
    g.addEdge(2, 3, 1.0);
    g.addEdge(2, 5, 2.0);
    g.addEdge(3, 4, 1.0);
    g.addEdge(3, 6, 5.0);
    g.addEdge(3, 1, 5.0);
    g.addEdge(4, 1, 1.0);
    g.addEdge(5, 6, 10.0);
    g.addEdge(6, 4, 3.0);

    vector<long long> expected = {4, 1, 0, 3, 6};
    ASSERT_EQ(expected, dijkstra(g, 4, 6, {})) << "Wrong shortest path in graph. See test." << endl;
}

TEST(Dijkstra, Full) {
    fillUicGraph();

    long long arc = 664275388;  // Person 1: ARC
    long long seo = 151960667;  // Person 2: SEO
    long long sh = 151676521;   // Midpoint: SH

    vector<long long> expectedArcToSh = {664275388, 2412572929, 1645208827, 464345369,
                                         463814052, 464748194, 462010750, 462010751,
                                         9862302685, 9870872111, 151676521};
    vector<long long> expectedSeoToSh = {151960667, 1647971930, 462010746, 462010758,
                                         11257988853, 464345492, 462010740, 9870872102,
                                         462010759, 151676521};
    ASSERT_EQ(
        expectedArcToSh,
        dijkstra(UIC_GRAPH, arc, sh, BUILDING_NODES))
        << "Wrong shortest path in UIC graph from ARC to SH.";
    ASSERT_EQ(
        expectedSeoToSh,
        dijkstra(UIC_GRAPH, seo, sh, BUILDING_NODES))
        << "Wrong shortest path in UIC graph from SEO to SH.";
}

TEST(Dijkstra, FullSkipNodes) {
    fillUicGraph();

    long long arc = 664275388;  // Person 1: ARC
    long long erf = 151960677;  // Person 2: ERF
    long long lcb = 151672203;  // Midpoint: LCB

    // ARC-->ERF can shortcut across buildings incorrectly
    // So this path is longer than the
    vector<long long> expectedArcToLcb = {664275388, 2412572929, 1645208827, 464345369,
                                          463814052, 464748194, 462010750, 462010751,
                                          9862302685, 9870872111, 7511858534, 9870872110,
                                          462010753, 9870872084, 462010766, 9870872109,
                                          9870872108, 462010765, 9870872105, 462010742,
                                          151672203};

    ASSERT_EQ(
        expectedArcToLcb,
        dijkstra(UIC_GRAPH, arc, lcb, BUILDING_NODES))
        << "Wrong shortest path in UIC graph from ARC to LCB. May be shortcutting across buildings (skipNodes).";

    vector<long long> expectedErfToLcb = {151960677, 1647971942, 1647971957, 462014176,
                                          9870872090, 462010748, 9862302460, 462010745,
                                          10930768589, 11757616192, 151672203};
    ASSERT_EQ(
        expectedErfToLcb,
        dijkstra(UIC_GRAPH, erf, lcb, BUILDING_NODES))
        << "Wrong shortest path in UIC graph from ERF to LCB.";
}
