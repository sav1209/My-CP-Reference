#include <bits/stdc++.h>
using namespace std;

class DSU_size {
    private:
    vector<int> parent;
    vector<int> size;

    public:

    int find(int v) {
        if (v == parent[v])
            return v;
        return parent[v] = find(parent[v]);
    }

    DSU_size(int n) : parent(n), size(n, 1) {
        for (int i = 0; i < n; i++) { parent[i] = i; }
    }

    bool unite(int a, int b) {
        a = find(a);
        b = find(b);

        if (a == b) return false;
        
        if (size[a] < size[b])
            swap(a, b);
        parent[b] = a;
        size[a] += size[b];
        
        return true;
    }

    bool connected(int a, int b) { return find(a) == find(b); }
};