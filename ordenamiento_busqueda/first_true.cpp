#include <bits/stdc++.h>
using namespace std;

// snippet: first_true
int first_true(int lo, int hi, function<bool(int)> f) {
	hi++;
	while (lo < hi) {
		int mid = lo + (hi - lo) / 2;
		if (f(mid)) {
			hi = mid;
		} else {
			lo = mid + 1;
		}
	}
	return lo;
}
// snippet: end

int main() {
	// outputs 2
	cout << first_true(2, 10, [](int x) { return true; }) << endl;
	// outputs 6
	cout << first_true(2, 10, [](int x) { return x * x >= 30; }) << endl;
	// outputs 11
	cout << first_true(2, 10, [](int x) { return false; }) << endl;
}
