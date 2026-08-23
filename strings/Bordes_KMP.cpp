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


