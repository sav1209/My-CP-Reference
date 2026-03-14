#import "algorithms.typ": algorithms
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
#show-algorithm(algorithms.kadane)


=== Difference Arrays
Used to increases all elements in a range $[a, b]$ by $x$.

We increase the value at position $a$ by $x$ and decrease the value at position $b + 1$ by $x$ of the difference array. Each element of the updated array corresponds to the prefix sum array of the updated difference array.

#show-algorithm(algorithms.difference_array)


== Disjoin Set Union

#show-algorithm(algorithms.dsu_find_set)
#show-algorithm(algorithms.dsu_union_by_size)
#show-algorithm(algorithms.dsu_union_by_rank)


// TODO: Agregar Fenwick tree (BIT)
== Segment tree
#show-algorithm(algorithms.segment-tree)