#import "../lib.typ": *

= Data structures

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



=== Max Subarray Sum

Given an array of integers, find the maximum sum subarray
#code-entry(
  title: "Kadane's algorithm",
  time: $O(n)$,
  range: (6, 23),
  source-file: "data_structures/kadane.cpp",
)


== Disjoin Set Union
#code-entry(
  title: "Find representative with path compression",
  time: $O(log n)$,
  source-file: "data_structures/dsu_size.cpp",
  range: (11, 15),
)

#code-entry(
  title: "Union by size",
  time: $O(alpha(m, n))$,
  source-file: "data_structures/dsu_size.cpp",
  range: (17, 33),
)

#code-entry(
  title: "Union by rank",
  time: $O(alpha(m, n))$,
  source-file: "data_structures/dsu_rank.cpp",
  range: (17, 34),
)


== Segment tree
#code-entry(
  title: "Implementation",
  source-file: "data_structures/segment-tree.cpp",
  range: (6, 41),
  time: [
    - $O(n)$ for building
    - $O(log n)$ for queries and updates
  ]
)