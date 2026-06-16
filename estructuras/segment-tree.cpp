#include <bits/stdc++.h>
using namespace std;

using ll = long long;

const int MAXN = 2e5;
ll a[MAXN];
struct segtree {
    int n;
    vector<ll> tree;

    segtree(int n) : n(n) {
        tree.resize(4 * n);
        build(1, 0, n - 1);
    }

    void build(int v, int lx, int rx) {
        if (lx == rx) {
            tree[v] = a[lx];
            return;
        }

        int m = (lx + rx) / 2;
        build(2 * v, lx, m);
        build(2 * v + 1, m + 1, rx);
        tree[v] = tree[2 * v] + tree[2 * v + 1];
    }

    void update(int idx, int new_val, int v, int lx, int rx) {
        if (lx == rx) {
            tree[v] = a[idx] = new_val;
            return;
        }

        int m = (lx + rx) / 2;
        if (idx <= m) update(idx, new_val, 2 * v, lx, m);
        else          update(idx, new_val, 2 * v + 1, m + 1, rx);
        tree[v] = tree[2 * v] + tree[2 * v + 1];
    }

    ll query(int l, int r, int v, int lx, int rx) {
        if (l > rx or r < lx or l > r) return 0;
        if (l <= lx and rx <= r) return tree[v];

        int m = (lx + rx) / 2;
        return    query(l, r, 2 * v, lx, m)
                + query(l, r, 2 * v + 1, m + 1, rx);
    }

    void update(int pos, int new_val) {
        update(pos, new_val, 1, 0, n - 1);
    }

    ll query(int l, int r) {
        return query(l, r, 1, 0, n - 1);
    }
};
