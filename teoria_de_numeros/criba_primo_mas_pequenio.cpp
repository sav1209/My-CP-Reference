#include "setup/template.h"
// snippet: start
vector<int> lowestPrimeSieve(int n) {
    vector<int> lp(n + 1);
    iota(lp.begin(), lp.end(), 0);
    for (int i = 4; i <= n; i += 2)
        lp[i] = 2;
    for (int i = 3; i * i <= n; i += 2)
        if (lp[i] == i)
            for (int j = i * i; j <= n; j += 2 * i)
                lp[j] = min(lp[j], i);
    return lp;
}
// snippet: end