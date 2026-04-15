#import "../lib.typ": *

= Estructuras de Datos

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