#include <bits/stdc++.h>
using namespace std;

class DSU_rank {
    private:
    vector<int> parent;
    vector<int> rank;

    public:

    int find(int v) {
        if (v == parent[v])
            return v;
        return parent[v] = find(parent[v]);
    }

    DSU_rank(int n) : parent(n), rank(n, 0) {
        for (int i = 0; i < n; i++) { parent[i] = i; }
    }

    bool unite(int a, int b) {
        a = find(a);
        b = find(b);

        if (a == b) return false;
        
        if (rank[a] < rank[b])
            swap(a, b);
        parent[b] = a;
        if (rank[a] == rank[b])
            rank[a]++;
        
        return true;
    }

    bool connected(int a, int b) { return find(a) == find(b); }
};