int find(int v) {
    return parent[v] = (parent[v] == v ? v : find(parent[v]));
}