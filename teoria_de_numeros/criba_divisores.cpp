#include "setup/template.h"

// snippet: start
vector<ll> divsSum;
vector<vector<int>> divs;

void divisorsSieve(int n) {
    divsSum.resize(n + 1, 0);
    divs.resize(n + 1);
    for (int i = 1; i <= n; ++i) {
        for (int j = i; j <= n; j += i) {
            divsSum[j] += i;
            divs[j].push_back(i);
        }
    }
}
// snippet: end