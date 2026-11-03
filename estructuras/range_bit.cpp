// BIT con actualización de rango y suma de rango. 0-indexado.
// update(l,r,x): a[l..r] += x. query(l,r): suma de a[l..r]. O(log n).
// Úsese cuando: "suma x a un rango" y "suma de un rango" intercalados.
struct RBit {
    int n; vector<ll> b1, b2;
    RBit(int n = 0) : n(n), b1(n + 2), b2(n + 2) {}
    void add(vector<ll>& b, int i, ll x) {
        for (i++; i <= n; i += i & -i) b[i] += x;
    }
    ll get(vector<ll>& b, int i) {
        ll r = 0;
        for (i++; i > 0; i -= i & -i) r += b[i];
        return r;
    }
    void update(int l, int r, ll x) {
        add(b1, l, x);     add(b1, r + 1, -x);
        add(b2, l, x * l); add(b2, r + 1, -x * (r + 1));
    }
    ll pref(int i) { return get(b1, i) * (i + 1) - get(b2, i); }
    ll query(int l, int r) { return pref(r) - pref(l - 1); }
};
// Ej.: RBit b(3); b.update(0,2,5); b.update(1,1,5);
//      b.query(1,1) == 10; b.query(0,2) == 20
