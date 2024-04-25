#pragma once

#include <iostream>
#include <map>
#include <set>
#include <unordered_map>
#include <vector>

using namespace std;

/// @brief Simple directed graph using an adjacency list.
/// @tparam VertexT vertex type
/// @tparam WeightT edge weight type
template <typename VertexT, typename WeightT>
class graph {
   private:
        map<VertexT, map<VertexT, WeightT>> mp;
        size_t numVertices;

   public:
    /// Default constructor
    graph() {
        this->numVertices = 0;
    }

    /// @brief Add the vertex `v` to the graph, must run in at most O(log |V|).
    /// @param v
    /// @return true if successfully added; false if it existed already
    bool addVertex(VertexT v) {
        // If the vertex already exists, return false.
        if (mp.count(v) > 0) return false;
        mp[v] = {};
        this->numVertices++;
        return true;
    }

    /// @brief Add or overwrite directed edge in the graph, must run in at most O(log |V|).
    /// @param from starting vertex
    /// @param to ending vertex
    /// @param weight edge weight / label
    /// @return true if successfully added or overwritten;
    ///         false if either vertices isn't in graph
    bool addEdge(VertexT from, VertexT to, WeightT weight) {
        if (mp.count(from) == 0 || mp.count(to) == 0) return false;
        mp[from][to] = weight;
        return true;
    }

    /// @brief Maybe get the weight associated with a given edge, must run in at most O(log |V|).
    /// @param from starting vertex
    /// @param to ending vertex
    /// @param weight output parameter
    /// @return true if the edge exists, and `weight` is set;
    ///         false if the edge does not exist
    bool getWeight(VertexT from, VertexT to, WeightT& weight) const {
        if (mp.count(from) > 0 && mp.at(from).count(to) > 0) {
            weight = mp.at(from).at(to);
            return true;
        }
        return false;
    }

    /// @brief Get the out-neighbors of `v`. Must run in at most O(|V|).
    /// @param v
    /// @return vertices that v has an edge to
    set<VertexT> neighbors(VertexT v) const {
        set<VertexT> S; 
        const map<VertexT, WeightT>& neighborNodes = mp.at(v);
        for (const auto it: neighborNodes) S.insert(it.first);
        return S;
    }

    /// @brief Return a vector containing all vertices in the graph
    vector<VertexT> getVertices() const {
        vector<VertexT> ret;
        for (const auto& pair: mp) ret.push_back(pair.first);
        return ret;
    }

    /// @brief Get the number of vertices in the graph. Runs in O(1).
    size_t NumVertices() const {
        return this->numVertices;
    }

    /// @brief Get the number of directed edges in the graph. Runs in at most O(|V|).
    size_t NumEdges() const {
        size_t ret = 0;
        for (auto pair: mp) ret += pair.second.size();
        return ret;
    }
};
