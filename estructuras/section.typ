#import "../lib.typ": *

= Estructuras de Datos

== Contenedores de la STL

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

If we want to create a priority queue that supports _finding and removing the smallest element_, we can do it as follows:
```
priority_queue<int, vector<int>, greater<int>> q;
```


== Prefix Sums

#let prefix = raw("prefix")
#let arr = raw("arr")

=== 2D Prefix Sums
To process $Q$ queries for the sum over a subrectangle of a 2D matrix with $N$ rows and $M$ columns

$ prefix[a][b] = sum_(i = 1)^a sum_(j = 1)^b arr[i][j] $

This can be calculated as follows for row index $1 <= i <= n$ and column index $1 <= j <= m$:
$ prefix[i][j] = prefix[i - 1][j] + prefix[i][j - 1] - prefix[i-1][j-1] + arr[i][j] $

The submatrix sum between rows $a$ and $A$ and columns $b$ and $B$, can thus be expressed as follows:
$ sum_(i = a)^A sum_(j = b)^B arr[i][j] = prefix[A][B] - prefix[a - 1][B] - prefix[A][b-1] + prefix[a - 1][b - 1] $


== Segment tree
#code-entry(
  title: "Segment tree",
  source-file: "estructuras/segment-tree.cpp",
  range: (6, 41),
  time: [
    - $O(n)$ for building
    - $O(log n)$ for queries and updates
  ]
)


== Policy-based data structures

The g++ compiler also supports some data structures that are not part of the C++ standard library. Such structures are called policy-based data structures. To use these structures, the following lines must be added to the code:

```
#include <ext/pb_ds/assoc_container.hpp>
using namespace __gnu_pbds;
```

=== Ordered Set

We can define a data structure `indexed_set` that is like set but can be indexed like an array. The definition for int values is as follows:

```
using ordered_set = tree<
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