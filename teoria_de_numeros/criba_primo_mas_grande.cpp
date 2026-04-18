#include "setup/template.h"
// snippet: start
vector<int> greatestPrimeSieve(int n)
{
    vector<int> gp(n + 1);
    iota(gp.begin(), gp.end(), 0);
    for (int i = 2; i <= n; i++)
        if (gp[i] == i)
            for (int j = 2 * i; j <= n; j += i)
                gp[j] = i;
    return gp;
}
// snippet: end