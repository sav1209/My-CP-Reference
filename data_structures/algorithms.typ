#let algorithms = (
  kadane: (
    title: "Kadane's algorithm",
    time: $O(n)$,
    source-file: "data_structures/kadane.cpp",
  ),
  difference_array: (
    title: "Naive implementation",
    time: $O(n)$,
    source-file: "data_structures/difference_array.cpp",
  ),
  dsu_find_set: (
    title: "Find representative with path compression",
    time: $O(log n)$,
    source-file: "data_structures/dsu_find_set.cpp"
  ),
  dsu_union_by_size: (
    title: "Union by size",
    time: $O(alpha(m, n))$,
    source-file: "data_structures/dsu_union_by_size.cpp",
  ),
  dsu_union_by_rank: (
    title: "Union by rank",
    time: $O(alpha(m, n))$,
    source-file: "data_structures/dsu_union_by_rank.cpp",
  ),
  segment-tree: (
    title: "Implementation",
    source-file: "data_structures/segment-tree.cpp",
  )
)