#import "../lib.typ": *

= Ordenamiento y Búsqueda

== Two Pointers
Some uses:

/ Subarray sum: Given an array of $n$ positive integers and a target sum $x$, and we want to find a subarray whose sum is $x$ or report that there is no such subarray.

/ 2SUM Problem: Given an array of $n$ numbers and a target sum $x$, find two array values such that their sum is $x$, or report that no such values exist.

/ Merging two sorted arrays: Given two arrays, sorted in ascending order combine the elements of these arrays into one big array.
  ```txt
  while i < a.size() || j < b.size():
    if a[i] < b[j]:
      c[i + j] = a[i]
      i++
    else:
      c[i + j] = b[j]
      j++
  ```

/ Number of Smaller: We have two arrays $a$ and $b$. We want to calculate for each element $b_j$ how many such $i$ exist that $a_i < b_j$.
  ```txt
  i = 0
  for j = 0..b.size()-1:
    while i < a.size() && a[i] < b[j]:
        i++
    res[j] = i
  ```


== Binary Search on Monotonic Functions

#code-entry(
  title: [Finding The Maximum $x$ Such That $f(x) = "true"$],
  time: $O(log n)$,
  source-file: "ordenamiento_busqueda/last_true.cpp",
)

#code-entry(
    title: [Finding The Minimum $x$ Such That $f(x) = "true"$],
    time: $O(log n)$,
    source-file: "ordenamiento_busqueda/first_true.cpp",
)