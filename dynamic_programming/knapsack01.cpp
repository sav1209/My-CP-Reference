#include "../setup/template.h"

// snippet: begin
int knapsack01(vector<int>& w, vector<int>& v, int W) {
   int n = w.size();
   vector<vector<int>> dp(n + 1, vector<int>(W + 1, 0));


   for (int i = 1; i <= n; ++i) {
       for (int j = 0; j <= W; ++j) {
           dp[i][j] = dp[i-1][j]; // no tomar el objeto i
           if (w[i-1] <= j)
               dp[i][j] = max(dp[i][j], dp[i-1][j - w[i-1]] + v[i-1]);
       }
   }
   return dp[n][W];
}
// snippet: end