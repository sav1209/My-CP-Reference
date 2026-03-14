#include <bits/stdc++.h>

using namespace std;

int main() {
	int n, m;
	cin >> n >> m;

	vector<vector<int>> graph(n);
	for (int i = 0; i < m; i++) {
		int a, b;
		cin >> a >> b;
		graph[a - 1].push_back(b - 1);
	}

	vector<int> in_degree(n);
	for (const vector<int> &nodes : graph) {
		for (int node : nodes) { in_degree[node]++; }
	}

	queue<int> queue;
	for (int i = 0; i < n; i++) {
		if (in_degree[i] == 0) { queue.push(i); }
	}
	vector<int> top_sort;
	while (!queue.empty()) {
		int curr = queue.front();
		queue.pop();
		top_sort.push_back(curr);
		for (int next : graph[curr]) {
			if (--in_degree[next] == 0) { queue.push(next); }
		}
	}

	if (top_sort.size() == n) {
		for (int i = 0; i < n - 1; i++) { cout << top_sort[i] + 1 << ' '; }
		cout << top_sort.back() + 1 << endl;
	} else {
		cout << "IMPOSSIBLE" << endl;
	}
}