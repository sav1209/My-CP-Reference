void unite(int a, int b) {
    a = find(a);
    b = find(b);
    if (a == b) return;
    if (rank[a] < rank[b])
        swap(a, b);
    parent[b] = a;
    if (rank[a] == rank[b])
        rank[a]++;
}