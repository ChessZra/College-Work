#pragma once

#include <gtest/gtest.h>

#include <set>
#include <string>
#include <vector>

#include "graph.h"

using namespace std;

// I'm not super happy with the monomorphization --> compile times here, but eh

void tournamentGraph(int n, graph<int, int>& g) {
    for (int i = 0; i < n; i++) {
        ASSERT_TRUE(g.addVertex(i));
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < i; j++) {
            // Edge from i to j iff i > j
            ASSERT_TRUE(g.addEdge(i, j, i));
        }
    }
}

void completeGraph(int n, graph<int, int>& g) {
    for (int i = 0; i < n; i++) {
        ASSERT_TRUE(g.addVertex(i));
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (i == j) continue;
            ASSERT_TRUE(g.addEdge(i, j, i));
        }
    }
}

TEST(Graph, EmptyGraph) {
    graph<string, string> g;
    EXPECT_EQ(0, g.NumVertices()) << "Empty graph should have 0 vertices";
    EXPECT_EQ(vector<string>{}, g.getVertices()) << "Empty graph should have 0 vertices";
    EXPECT_EQ(0, g.NumEdges()) << "Empty graph should have 0 edges";
}

TEST(Graph, BadEdges) {
    graph<string, int> g;

    ASSERT_TRUE(g.addVertex("0"));

    ASSERT_FALSE(g.addEdge("missing_1", "missing_2", 1)) << "addEdge when both `from` and `to` are missing should be false";
    ASSERT_FALSE(g.addEdge("0", "missing", 1)) << "addEdge when `to` is missing should be false";
    ASSERT_FALSE(g.addEdge("missing", "0", 1)) << "addEdge when `from` is missing should be false";

    ASSERT_EQ(0, g.NumEdges()) << "Edge count changed when adding invalid edges";
}

TEST(Graph, BuildSmall) {
    graph<string, int> g;
    vector<string> expectedVertices = {"0", "1", "2", "3"};

    ASSERT_TRUE(g.addVertex("0")) << "Should be able to add a new vertex";
    ASSERT_TRUE(g.addVertex("1")) << "Should be able to add a new vertex";
    ASSERT_TRUE(g.addVertex("2")) << "Should be able to add a new vertex";
    ASSERT_TRUE(g.addVertex("3")) << "Should be able to add a new vertex";

    ASSERT_TRUE(g.addEdge("0", "1", 2)) << "Should be able to add a new edge";
    ASSERT_TRUE(g.addEdge("2", "1", 4)) << "Should be able to add a new edge";
    ASSERT_TRUE(g.addEdge("1", "2", 3)) << "Should be able to add a new edge";
    ASSERT_TRUE(g.addEdge("1", "3", 1)) << "Should be able to add a new edge";
    ASSERT_TRUE(g.addEdge("3", "1", -1)) << "Should be able to add a new edge";
    ASSERT_TRUE(g.addEdge("0", "0", -2)) << "Should be able to add a new self-edge";

    vector<string> actualVertices = g.getVertices();
    sort(actualVertices.begin(), actualVertices.end());
    ASSERT_EQ(expectedVertices, actualVertices);
    ASSERT_EQ(4, g.NumVertices());
    ASSERT_EQ(6, g.NumEdges());

    int actualWeight;
    ASSERT_TRUE(g.getWeight("0", "1", actualWeight)) << "Edge should exist in graph";
    ASSERT_EQ(2, actualWeight) << "Edge has wrong weight";
    ASSERT_TRUE(g.getWeight("2", "1", actualWeight)) << "Edge should exist in graph";
    ASSERT_EQ(4, actualWeight) << "Edge has wrong weight";
    ASSERT_TRUE(g.getWeight("1", "2", actualWeight)) << "Edge should exist in graph";
    ASSERT_EQ(3, actualWeight) << "Edge has wrong weight";
    ASSERT_TRUE(g.getWeight("1", "3", actualWeight)) << "Edge should exist in graph";
    ASSERT_EQ(1, actualWeight) << "Edge has wrong weight";
    ASSERT_TRUE(g.getWeight("3", "1", actualWeight)) << "Edge should exist in graph";
    ASSERT_EQ(-1, actualWeight) << "Edge has wrong weight";
    ASSERT_TRUE(g.getWeight("0", "0", actualWeight)) << "Edge should exist in graph";
    ASSERT_EQ(-2, actualWeight) << "Edge has wrong weight";

    ASSERT_FALSE(g.getWeight("1", "0", actualWeight)) << "Edge should not exist in graph";
    ASSERT_FALSE(g.getWeight("2", "3", actualWeight)) << "Edge should not exist in graph";
}

TEST(Graph, EdgeOverwrite) {
    graph<string, int> g;

    ASSERT_TRUE(g.addVertex("0"));
    ASSERT_TRUE(g.addEdge("0", "0", 1)) << "addEdge should succeed";
    ASSERT_TRUE(g.addEdge("0", "0", 2)) << "addEdge replacing an edge should succeed";

    int weight;
    ASSERT_TRUE(g.getWeight("0", "0", weight));
    ASSERT_EQ(2, weight);
    ASSERT_EQ(1, g.NumEdges()) << "Edge count changed when overwriting edges";
}

TEST(Graph, CompleteEdgesStress) {
    int n = 400;
    graph<int, int> g;
    completeGraph(n, g);
    int weight;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (i != j) {
                ASSERT_TRUE(g.getWeight(i, j, weight)) << "Edge should be present in complete graph";
                ASSERT_EQ(i, weight) << "Edge has wrong weight";
            } else {
                ASSERT_FALSE(g.getWeight(i, j, weight)) << "Self-edge should not be present in complete graph";
            }
        }
    }
}

TEST(Graph, NeighborsStress) {
    int n = 100;
    graph<int, int> g;
    tournamentGraph(n, g);
    if (HasFatalFailure()) return;

    set<int> expectedNeighbors;
    vector<int> expectedVertices;

    for (int i = 0; i < n; i++) {
        ASSERT_EQ(expectedNeighbors, g.neighbors(i));
        // In a tournament graph, vertices have edges to smaller ones
        expectedNeighbors.emplace(i);
        expectedVertices.push_back(i);
    }

    vector<int> actualVertices = g.getVertices();
    sort(actualVertices.begin(), actualVertices.end());
    ASSERT_EQ(expectedVertices, actualVertices);
}

TEST(Graph, DefaultCopies) {
    graph<int, int> g;
    completeGraph(4, g);
    if (HasFatalFailure()) return;

    graph<int, int> copy = g;
    graph<int, int> opEq;
    opEq = g;
}

TEST(Graph, ManyVertices) {
    graph<int, int> g;
    int N = 500000;
    for (int i = 0; i < N; i++) {
        ASSERT_TRUE(g.addVertex(i));
    }
    for (int i = 0; i < N; i++) {
        ASSERT_FALSE(g.addVertex(N-1));
    }
    for (int i = 0; i < N-1; i++) {
        ASSERT_TRUE(g.addEdge(i, i+1, 2 * i));
    }
    for (int i = 2; i < N; i++) {
        ASSERT_TRUE(g.addEdge(0, i, i));
    }
    int weight;
    for (int i = 0; i < N-1; i++) {
        ASSERT_TRUE(g.getWeight(i, i+1, weight));
        ASSERT_EQ(i * 2, weight);
    }
    for (int i = 2; i < N; i++) {
        ASSERT_TRUE(g.getWeight(0, i, weight));
        ASSERT_EQ(i, weight);
    }
}

TEST(Graph, BigCompleteGraph) {
    int N = 1000;
    graph<int, int> g;
    completeGraph(N, g);
    if (HasFatalFailure()) return;

    int weight;
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (i == j) ASSERT_FALSE(g.getWeight(i, j, weight));
            else        ASSERT_TRUE(g.getWeight(i, j, weight));
        }
    }
}
