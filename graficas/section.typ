#import "../lib.typ": *

= Teoría de gráficas

== Graph Traversal

=== Floodfill

Flood fill is an algorithm that identifies and labels the connected component that a particular cell belongs to in a multidimensional array.

#warning-box[
    Recursive implementations of flood fill sometimes lead to
    - Memory limit exceeded if you run the recursive implementation on a really big grid (i.e., running the above code on a $4000 times 4000$ grid may exceed 256 MB)
        - Non-recursive implementations generally use less memory than recursive ones.
]

#code-entry(
    title: "Example (recursive implementation)",
    source-file: "graphs/floodfill_recursive.cpp",
)

#code-entry(
    title: "Example (iterative implementation)",
    source-file: "graphs/floodfill_iterative.cpp",
)

== Disjoin Set Union
#code-entry(
  title: "Find representative with path compression",
  time: $O(log n)$,
  source-file: "graphs/dsu_size.cpp",
  range: (11, 15),
)

#code-entry(
  title: "Union by size",
  time: $O(alpha(m, n))$,
  source-file: "graphs/dsu_size.cpp",
  range: (17, 33),
)

#code-entry(
  title: "Union by rank",
  time: $O(alpha(m, n))$,
  source-file: "graphs/dsu_rank.cpp",
  range: (17, 34),
)


== Topological Sort

A topological sort of a directed acyclic graph is a linear ordering of its vertices such that for every directed edge $u -> v$ from vertex $u$ to vertex $v$, $u$ comes before $v$ in the ordering.

#code-entry(
    title: "DFS Version",
    source-file: "graphs/topological_sort_dfs.cpp",
)

#code-entry(
    title: "BFS Version (Kahn's Algorithm)",
    source-file: "graphs/topological_sort_bfs.cpp",
)