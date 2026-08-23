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
