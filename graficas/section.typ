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
    source-file: "graficas/floodfill_recursive.cpp",
)

#code-entry(
    title: "Example (iterative implementation)",
    source-file: "graficas/floodfill_iterative.cpp",
)

== Disjoin Set Union

#code-entry(
    title: "Disjoint Set Union",
    time: [
        - `find`: $O(log n)$
        - Con path compression y union by size/rank: $O(alpha(n))$, donde $alpha$ es la inversa de la función de Ackermann (amortizada).
        - Con union by size/rank, peros sin path compression: $O(log n)$ por consulta.
    ],
    source-file: "graficas/dsu.cpp"
)

== Topological Sort

A topological sort of a directed acyclic graph is a linear ordering of its vertices such that for every directed edge $u -> v$ from vertex $u$ to vertex $v$, $u$ comes before $v$ in the ordering.

#code-entry(
    title: "DFS Version",
    source-file: "graficas/topological_sort_dfs.cpp",
)

#code-entry(
    title: "BFS Version (Kahn's Algorithm)",
    source-file: "graficas/topological_sort_bfs.cpp",
)