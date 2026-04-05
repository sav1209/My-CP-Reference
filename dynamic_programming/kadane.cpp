#include "../setup/template.h"

// snippet: begin
long long kadane(vector<long long>& arr) {
   long long max_ending_here = arr[0];
   long long max_so_far = arr[0];
   for (size_t i = 1; i < arr.size(); ++i) {
       max_ending_here = max(arr[i], max_ending_here + arr[i]);
       max_so_far = max(max_so_far, max_ending_here);
   }
   return max_so_far;
}
// snippet: end