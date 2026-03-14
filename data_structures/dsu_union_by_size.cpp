void unite(int a, int b) {
    a = find(a);
    b = find(b);
    if (a == b) return;
    if (size[a] < size[b])
        swap(a, b);
    parent[b] = a;
    size[a] += size[b];
}