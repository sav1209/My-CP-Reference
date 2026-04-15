#include<bits/stdc++.h>
using namespace std;

const int N = 3e5 + 9, LG = 18;

// adj[u] = lista de adyacencia del nodo u
vector<int> adj[N];
// up[i][j] = 2^j-ésimo ancestro de i
int up[N][LG + 1];
// depth[i] = profundidad del nodo i
int depth[N];
// subtree_size[i] = tamaño del subárbol con raíz en i
int subtree_size[N];

void dfs(int u, int p = 0) {
    up[u][0] = p;
    depth[u] = depth[p] + 1;
    subtree_size[u] = 1;

    for (int i = 1; i <= LG; i++) {
        up[u][i] = up[up[u][i - 1]][i - 1];
    }
  
    for (auto v: adj[u]) {
        if (v != p) {
            dfs(v, u);
            subtree_size[u] += subtree_size[v];
        }
    }
}

// LCA de u y v
int lca(int u, int v) {
    if (depth[u] < depth[v]) swap(u, v);

    for (int k = LG; k >= 0; k--) {
        if (depth[up[u][k]] >= depth[v]) u = up[u][k];
    }

    if (u == v) return u;

    for (int k = LG; k >= 0; k--) {
        if (up[u][k] != up[v][k]) u = up[u][k], v = up[v][k];
    }

    return up[u][0];
}

// k-ésimo ancestro de u, k >= 0
int kth(int u, int k) {
    assert(k >= 0);
    for (int i = 0; i <= LG; i++){
        if (k & (1 << i)) u = up[u][i];
    }
    return u;
}

// Distancia entre u y v
int dist(int u, int v) {
    int l = lca(u, v);
    return depth[u] + depth[v] - (depth[l] << 1);
}

// k-ésimo nodo en el camino de u a v, el nodo 0 es u
int go(int u, int v, int k) {
    int l = lca(u, v);
    int d = depth[u] + depth[v] - (depth[l] << 1);
    assert(k <= d);
    if (depth[l] + k <= depth[u]) return kth(u, k);
    k -= depth[u] - depth[l];
    return kth(v, depth[v] - depth[l] - k);
}