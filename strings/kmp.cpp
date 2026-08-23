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
// Bordes de un string (usando su phi)
// Devuelve todas las longitudes de bordes no triviales, de mayor a menor
// (borde = prefijo que también es sufijo, distinto del string completo)
// Complejidad: O(n) en el peor caso (cadena de bordes)
// snippet: kmp-borders
vll getBorders(const vll& phi) {
    ll n = phi.size();
    vll borders;
    for (ll i = phi[n - 1]; i; i = phi[i - 1])
        borders.push_back(i);
    return borders;
}
// snippet: end

// Conteo de ocurrencias de cada prefijo como substring de pat
// cnt[L] = cuántas veces aparece pat[0..L-1] dentro de todo pat
// (incluye la ocurrencia como el propio prefijo)
// Complejidad: O(n)
// snippet: kmp-prefix-count
vll countPrefixOccurrences(const vll& phi) {
    ll n = phi.size();
    vll cnt(n + 1, 0);
    for (ll i = 0; i < n; i++)
        cnt[phi[i]]++;
    for (ll i = n - 1; i > 0; i--)
        cnt[phi[i - 1]] += cnt[i];
    for (ll i = 0; i <= n; i++)
        cnt[i]++;
    return cnt;
}
// snippet: end
