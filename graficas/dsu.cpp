#include "setup/template.h"

struct DSU {
    vector<int> parent, rank, size;
    int components;

    DSU(int n) : parent(n + 1), rank(n + 1, 0), size(n + 1, 1), components(n) {
        iota(all(parent), 0);
    }

    // Retorna el representante de la componente de "x"
    int find(int x) {
        return parent[x] = (parent[x] == x ? x : find(parent[x]));
    }

    // Retorna si "x" y "y" se encuentran en la misma componente
    bool connected(int x, int y) {
        return find(x) == find(y);
    }

    // Retorna el tamaño de la componente de "x"
    int get_size(int x) {
        return size[find(x)];
    }

    // Retorna la cantidad de componentes
    int count() {
        return components;
    }

    // Une dos componentes y retorna el nuevo representante o retorna -1 si ya son parte de la misma componente
    int merge(int x, int y) {
        x = find(x);
        y = find(y);

        if (x == y) return -1;

        components--;
    
        if (rank[x] > rank[y]) swap(x, y);
        parent[x] = y;
        size[y] += size[x];

        if (rank[x] == rank[y]) rank[y]++;
        return y;
    }
};