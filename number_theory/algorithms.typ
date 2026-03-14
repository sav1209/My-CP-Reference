#let algorithms = (
  sieve_with_basic_optimizations: (
    title: "Sieve with basic optimizations",
    time: $O(n log log n)$,
    space: $O(n)$,
    description: [
      Find all the prime numbers in $[1, n]$. This code use the next optimizations:
      - Sieving till root
      - Sieving by the odd numbers only
    ],
    source-file: "number_theory/sieve_with_basic_optimizations.cpp"
  ),
  extended_euclid_algorithm: (
    title: "Iterative version",
    time: $O(log min(a, b))$,
    source-file: "number_theory/extended_euclid_algorithm.cpp"
  ),
)