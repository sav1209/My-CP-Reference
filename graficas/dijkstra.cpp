#include "../setup/template.h"

// snippet: dijkstra
// Dijkstra: distancias mínimas desde s. Pesos w >= 0. O((n + m) log n).
// g[u] = lista de {v, w}. dist[v] == INF si v es inalcanzable.
// Ojo: con pesos negativos da respuestas incorrectas (usar Bellman-Ford).
// Úsese cuando: camino mínimo con pesos no negativos, N, M hasta ~2e5.
vector<ll> dijkstra(int s, const vector<vector<pair<int, ll>>>& g) {
    vector<ll> dist(g.size(), INF);
    priority_queue<pair<ll, int>, vector<pair<ll, int>>, greater<>> pq;
    dist[s] = 0;
    pq.push({0, s});
    while (!pq.empty()) {
        auto [d, u] = pq.top(); pq.pop();
        if (d > dist[u]) continue;          // entrada vieja
        for (auto [v, w] : g[u])
            if (d + w < dist[v]) {
                dist[v] = d + w;
                pq.push({dist[v], v});
            }
    }
    return dist;
}
// Ej.: n=3, aristas 0-1 (w=5), 1-2 (w=2), 0-2 (w=9), no dirigido:
//   g[0]={{1,5},{2,9}}, g[1]={{0,5},{2,2}}, g[2]={{0,9},{1,2}}
//   dijkstra(0, g) -> {0, 5, 7}
// snippet: end
