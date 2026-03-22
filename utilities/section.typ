#import "../lib.typ": *

#set page(columns: 1)

= Utilities

== Strings
#table(
  columns: 4,
  align: (left, left, center, left),
  stroke: 1pt+palette.crust.rgb,
  [*Method/Syntax*], [*Description*], [*Complexity*], [*Example*],
  
  [`s.size()` / `s.length()`], [Returns the number of characters], [O(1)], [`int n = s.size();`],
  
  [`s.empty()`], [Checks if string is empty], [O(1)], [`if (s.empty()) { ... }`],
  
  [`s[i]` / `s.at(i)`], [Access character at position i], [O(1)], [`char c = s[0];`],
  
  [`s.front()` / `s.back()`], [Access first/last character], [O(1)], [`char first = s.front();`],
  
  [`s.push_back(c)`], [Appends character to end], [O(1) amortized], [`s.push_back('x');`],
  
  [`s.pop_back()`], [Removes last character], [O(1)], [`s.pop_back();`],
  
  [`s += str` / `s.append(str)`], [Concatenates string/character], [O(m)], [`s += "hello";`],
  
  [`s.insert(pos, str)`], [Inserts string at position], [O(n+m)], [`s.insert(2, "abc");`],
  
  [`s.erase(pos, len)`], [Removes len characters from pos], [O(n)], [`s.erase(2, 3);`],
  
  [`s.substr(pos, len)`], [Returns substring from pos with len chars], [O(len)], [`string sub = s.substr(2, 5);`],
  
  [`s.find(str, pos)`], [Finds first occurrence of str from pos], [O(n*m)], [`size_t pos = s.find("abc");`],
  
  [`s.rfind(str, pos)`], [Finds last occurrence of str before pos], [O(n*m)], [`size_t pos = s.rfind("abc");`],
  
  [`s.find_first_of(chars)`], [Finds first occurrence of any char in chars], [O(n*m)], [`s.find_first_of("aeiou");`],
  
  [`s.find_last_of(chars)`], [Finds last occurrence of any char in chars], [O(n*m)], [`s.find_last_of("aeiou");`],
  
  [`s.find_first_not_of(chars)`], [Finds first char not in chars], [O(n*m)], [`s.find_first_not_of(" \t");`],
  
  [`s.find_last_not_of(chars)`], [Finds last char not in chars], [O(n*m)], [`s.find_last_not_of(" \t");`],
  
  [`s.replace(pos, len, str)`], [Replaces len chars at pos with str], [O(n+m)], [`s.replace(2, 3, "xyz");`],
  
  [`s.compare(str)`], [Lexicographically compares strings], [O(min(n,m))], [`int cmp = s.compare("abc");`],
  
  [`s.c_str()`], [Returns C-style null-terminated string], [O(1)], [`const char* cstr = s.c_str();`],
  
  [`s.data()`], [Returns pointer to character array], [O(1)], [`char* ptr = s.data();`],
  
  [`s.reserve(n)`], [Reserves capacity for n characters], [O(1)], [`s.reserve(1000);`],
  
  [`s.resize(n, c)`], [Changes size to n, filling with c if needed], [O(n)], [`s.resize(10, 'x');`],
  
  [`s.clear()`], [Removes all characters], [O(n)], [`s.clear();`],
  
  [`s.swap(other)`], [Swaps contents with another string], [O(1)], [`s.swap(t);`],
  
  [`getline(cin, s)`], [Reads entire line including spaces], [O(n)], [`getline(cin, s);`],
  
  [`getline(cin, s, delim)`], [Reads until delimiter character], [O(n)], [`getline(cin, s, ',');`],
  
  [`stoi(s)` / `stol(s)` / `stoll(s)`], [Converts string to int/long/long long], [O(n)], [`int num = stoi("123");`],
  
  [`stof(s)` / `stod(s)`], [Converts string to float/double], [O(n)], [`double d = stod("3.14");`],
  
  [`to_string(num)`], [Converts number to string], [O(log num)], [`string s = to_string(42);`],
  
  [`isalpha(c)` / `isdigit(c)`], [Checks if char is letter/digit], [O(1)], [`if (isalpha(s[i])) { ... }`],
  
  [`islower(c)` / `isupper(c)`], [Checks if char is lowercase/uppercase], [O(1)], [`if (islower(s[i])) { ... }`],
  
  [`tolower(c)` / `toupper(c)`], [Converts char to lowercase/uppercase], [O(1)], [`s[i] = tolower(s[i]);`],
  
  [`isspace(c)`], [Checks if char is whitespace], [O(1)], [`if (isspace(s[i])) { ... }`],
  
  [`isalnum(c)`], [Checks if char is alphanumeric], [O(1)], [`if (isalnum(s[i])) { ... }`],
)

=== Important Notes:

- *String indexing*: Use `s[i]` for fast access, `s.at(i)` for bounds checking
- *Find functions*: Return `string::npos` if not found (usually -1 or large value)
- *Character functions*: `isalpha`, `isdigit`, etc. are in `<cctype>` header
- *Conversion functions*: `stoi`, `to_string`, etc. are in `<string>` header
- *Amortized complexity*: `push_back` is O(1) on average due to capacity doubling

=== Useful Patterns:
```cpp
// Check if substring exists
if (s.find("pattern") != string::npos) { ... }

// Convert string to lowercase
transform(s.begin(), s.end(), s.begin(), [](char c) { return tolower(c); });

// Split string by delimiter
stringstream ss(s); string token;
while (getline(ss, token, ',')) { ... }

// Remove leading/trailing whitespace
s.erase(0, s.find_first_not_of(" \t"));
s.erase(s.find_last_not_of(" \t") + 1);

// Reverse string
reverse(s.begin(), s.end());
```

== STL Algorithm
#table(
  columns: 4,
  align: (left, left, center, left),
  stroke: 1pt+palette.crust.rgb,
  [*Function/Syntax*], [*Description*], [*Complexity*], [*Example*],
  
  [`sort(begin, end)`], [Sorts elements in ascending order], [O(n log n)], [`sort(v.begin(), v.end())`],
  
  [`stable_sort(begin, end)`], [Sorts maintaining relative order of equal elements], [O(n log n)], [`stable_sort(v.begin(), v.end())`],
  
  [`reverse(begin, end)`], [Reverses the order of elements], [O(n)], [`reverse(v.begin(), v.end())`],
  
  [`binary_search(begin, end, val)`], [Searches for value in sorted range (returns bool)], [O(log n)], [`binary_search(v.begin(), v.end(), x)`],
  
  [`lower_bound(begin, end, val)`], [Finds first element ≥ val], [O(log n)], [`lower_bound(v.begin(), v.end(), x)`],
  
  [`upper_bound(begin, end, val)`], [Finds first element > val], [O(log n)], [`upper_bound(v.begin(), v.end(), x)`],
  
  [`equal_range(begin, end, val)`], [Returns pair of iterators \[lower_bound, upper_bound\]], [O(log n)], [`equal_range(v.begin(), v.end(), x)`],
  
  [`min_element(begin, end)`], [Finds iterator to minimum element], [O(n)], [`min_element(v.begin(), v.end())`],
  
  [`max_element(begin, end)`], [Finds iterator to maximum element], [O(n)], [`max_element(v.begin(), v.end())`],
  
  [`minmax_element(begin, end)`], [Returns pair {min_iter, max_iter}], [O(n)], [`minmax_element(v.begin(), v.end())`],
  
  [`next_permutation(begin, end)`], [Generates next lexicographic permutation], [O(n)], [`next_permutation(v.begin(), v.end())`],
  
  [`prev_permutation(begin, end)`], [Generates previous lexicographic permutation], [O(n)], [`prev_permutation(v.begin(), v.end())`],
  
  [`unique(begin, end)`], [Removes consecutive duplicate elements], [O(n)], [`unique(v.begin(), v.end())`],
  
  [`count(begin, end, val)`], [Counts occurrences of a value], [O(n)], [`count(v.begin(), v.end(), x)`],
  
  [`count_if(begin, end, pred)`], [Counts elements satisfying condition], [O(n)], [`count_if(v.begin(), v.end(), [](int x){return x%2==0;})`],
  
  [`find(begin, end, val)`], [Finds first occurrence of value], [O(n)], [`find(v.begin(), v.end(), x)`],
  
  [`find_if(begin, end, pred)`], [Finds first element satisfying condition], [O(n)], [`find_if(v.begin(), v.end(), [](int x){return x>5;})`],
  
  [`rotate(begin, middle, end)`], [Rotates elements (middle becomes new begin)], [O(n)], [`rotate(v.begin(), v.begin()+k, v.end())`],
  
  [`random_shuffle(begin, end)`], [Shuffles elements randomly], [O(n)], [`random_shuffle(v.begin(), v.end())`],
  
  [`shuffle(begin, end, rng)`], [Shuffles with specific random generator], [O(n)], [`shuffle(v.begin(), v.end(), rng)`],
  
  [`fill(begin, end, val)`], [Fills range with a value], [O(n)], [`fill(v.begin(), v.end(), 0)`],
  
  [`iota(begin, end, val)`], [Fills with consecutive values starting from val], [O(n)], [`iota(v.begin(), v.end(), 1)`],
  
  [`accumulate(begin, end, init)`], [Sums elements (requires `<numeric>`)], [O(n)], [`accumulate(v.begin(), v.end(), 0)`],
  
  [`partial_sum(begin, end, out)`], [Calculates partial sums], [O(n)], [`partial_sum(v.begin(), v.end(), prefix.begin())`],
  
  [`merge(begin1, end1, begin2, end2, out)`], [Merges two sorted ranges], [O(n+m)], [`merge(a.begin(), a.end(), b.begin(), b.end(), c.begin())`],
  
  [`inplace_merge(begin, middle, end)`], [Merges two sorted parts of same range], [O(n log n)], [`inplace_merge(v.begin(), v.begin()+k, v.end())`],
  
  [`set_union(begin1, end1, begin2, end2, out)`], [Union of two sorted sets], [O(n+m)], [`set_union(a.begin(), a.end(), b.begin(), b.end(), c.begin())`],
  
  [`set_intersection(begin1, end1, begin2, end2, out)`], [Intersection of two sorted sets], [O(n+m)], [`set_intersection(a.begin(), a.end(), b.begin(), b.end(), c.begin())`],
  
  [`set_difference(begin1, end1, begin2, end2, out)`], [Difference of two sorted sets], [O(n+m)], [`set_difference(a.begin(), a.end(), b.begin(), b.end(), c.begin())`],
  
  [`nth_element(begin, nth, end)`], [Partitions so nth element is in correct position], [O(n) avg], [`nth_element(v.begin(), v.begin()+k, v.end())`],
  
  [`partition(begin, end, pred)`], [Partitions elements by predicate], [O(n)], [`partition(v.begin(), v.end(), [](int x){return x%2==0;})`],
  
  [`is_sorted(begin, end)`], [Checks if range is sorted], [O(n)], [`is_sorted(v.begin(), v.end())`],
  
  [`is_permutation(begin1, end1, begin2)`], [Checks if one range is permutation of another], [O(n²)], [`is_permutation(a.begin(), a.end(), b.begin())`],
)

=== Important Notes:

- *Sorted ranges required*: `binary_search`, `lower_bound`, `upper_bound`, `equal_range`, `merge`, `set_*` require sorted ranges
- *`<numeric>` functions*: `accumulate`, `partial_sum`, `iota` are in `<numeric>`, not `<algorithm>`
- *Iterators*: Many functions return iterators. To get indices: `distance(v.begin(), iter)`
- *Predicates*: Functions like `count_if`, `find_if` accept lambdas or functors
- *Custom comparators*: Most accept custom comparators as third parameter

=== Useful Combinations:
```cpp
// Sort and remove duplicates
sort(v.begin(), v.end());
v.erase(unique(v.begin(), v.end()), v.end());
```


== STL containers

=== Deques
A *_deque_* is a dynamic array that can be efficiently manipulated at both ends of the structure.

```
deque<int> d;
d.push_back(5); // [5]
d.push_back(2); // [5,2]
d.push_front(3); // [3,5,2]
d.pop_back(); // [3,5]
d.pop_front(); // [5]
```
The operations of a deque also work in $O(1)$ average time. Deques should be used only if there is a need to manipulate both ends of the array.


=== Set Structures
The basic operations of sets are element insertion, search and removal. Sets are implemented so that all the above operations are efficient.

==== Sets and Multisets

*Basic functions*
- `insert` adds an element to the set
- `count` returns the number of occurrences of an element in the set
- `erase` removes an element from the set
- `find(x)` returns an iterator that points to an element whose value is $x$. However, if the set does not contain $x$, the iterator will be `end()`.

#codly(header: [Prints the number of elements in a set])
```
cout << s.size() << "\n";
for (auto x : s) {
    cout << x << "\n";
}
```

#codly(header: [Use of find])
```
auto it = s.find(x);
if (it == s.end()) {
    // x is not found
}
```

/ Multisets: A _multiset_ is a set that can have several copies of the same value. C++ has the structures `multiset` and `unordered_multiset`.
  ```
  multiset<int> s;
  s.insert(5);
  s.insert(5);
  s.insert(5);
  cout << s.count(5) << "\n"; // 3
  ```
  
  The function erase removes all copies of a value from a multiset:
  ```
  s.erase(5);
  cout << s.count(5) << "\n"; // 0
  ```

  Often, only one value should be removed, which can be done as follows:
  ```
  s.erase(s.find(5));
  cout << s.count(5) << "\n"; // 2
  ```
  Note that the functions `count` and `erase` have an additional $O(k)$ factor where $k$ is the number of elements counted/removed. In particular, it is _not_ efficient to count the number of copies of a value in a multiset using the `count` function.


=== Priority Queues
Insertion and removal take $O(log n)$ time, and retrieval takes $O(1)$ time.

If we only need to efficiently find minimum or maximum elements, it is a good idea to use a priority queue instead of a set or multiset.

By default, the elements in a C++ priority queue are sorted in decreasing order, and it is possible to find and remove the largest element in the queue.

```
priority_queue<int> q;
q.push(3);
q.push(5);
q.push(7);
q.push(2);
cout << q.top() << "\n"; // 7
q.pop();
cout << q.top() << "\n"; // 5
q.pop();
q.push(6);
cout << q.top() << "\n"; // 6
q.pop();
```

If we want to create a priority queue that supports finding and removing the smallest element, we can do it as follows:
```
priority_queue<int,vector<int>,greater<int>> q;
```


=== Policy-based data structures

The g++ compiler also supports some data structures that are not part of the C++ standard library. Such structures are called policy-based data structures. To use these structures, the following lines must be added to the code:

```
#include <ext/pb_ds/assoc_container.hpp>
using namespace __gnu_pbds;
```

After this, we can define a data structure `indexed_set` that is like set but can be indexed like an array. The definition for int values is as follows:

```
using indexed_set = tree<
    int,
    null_type,
    less<int>,
    rb_tree_tag,
    tree_order_statistics_node_update
>;
```

This data structure supports all the operations as a set in C++ in addition to the following:

- `find_by_order(k)`: returns an iterator to the $k$-th smallest element (0-based indexing)
- `order_of_key(x)`: returns the number of elements in the set that are strictly less than $x$