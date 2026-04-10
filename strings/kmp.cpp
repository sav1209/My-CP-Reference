// KMP — Knuth-Morris-Pratt
// Encuentra todas las ocurrencias de pat en txt
// Complejidad: O(n + m)

// snippet: kmp
vll buildPhi(const vll& pat) {
    ll m = pat.size();
    vll phi(m, 0);
    for (ll j = 1, i = 0; j < m; j++) {
        while (i > 0 && pat[i] != pat[j]) i = phi[i - 1];
        if (pat[i] == pat[j]) i++;
        phi[j] = i;
    }
    return phi;
}

ll KMP(const vll& pat, const vll& txt) {
    ll m = pat.size(), n = txt.size();
    if (m == 0) return 0;
    vll phi = buildPhi(pat);
    ll matches = 0;
    for (ll i = 0, j = 0; j < n; j++) {
        while (i > 0 && pat[i] != txt[j]) i = phi[i - 1];
        if (pat[i] == txt[j]) i++;
        if (i == m) { matches++; i = phi[i - 1]; }
    }
    return matches;
}
// snippet: end
