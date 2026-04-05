#include "../setup/template.h"

// snippet: begin
long long coin_change(vector<int>& coins, int X) {
   vector<long long> dp(X + 1, 0);
   dp[0] = 1; // una forma de formar 0

   for (int c : coins) {
       for (int x = c; x <= X; ++x) {
           dp[x] = (dp[x] + dp[x - c]) % MOD;
       }
   }
   return dp[X];
}
// snippet: end