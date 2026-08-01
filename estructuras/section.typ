#import "../lib.typ": *

= Estructuras de Datos

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


== Segment tree
#code-entry(
  source-file: "estructuras/segment-tree.cpp",
  time: [
    - $O(n)$ for building
    - $O(log n)$ for queries and updates
  ]
)


== Fenwick tree

#code-entry(
  tag: "bit",
  source-file: "estructuras/bit.cpp",
)