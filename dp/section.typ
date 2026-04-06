#import "../lib.typ": *

= Programación Dinámica

#code-entry(
  title: "Kadane's algorithm",
  time: $O(n)$,
  tag: "begin",
  description: "Given an array of integers, find the maximum sum subarray.",
  source-file: "dp/kadane.cpp",
)

#code-entry(
  title: "Knapsack 0/1",
  time: $O(n W)$,
  description: [
    Given weights and values of $n$ items, put these items in a knapsack of capacity $W$ to get the maximum total value in the knapsack.
  ],
  tag: "begin",
  source-file: "dp/knapsack01.cpp",
)

#code-entry(
  title: "Coin Change",
  tag: "begin",
  source-file: "dp/coin_change.cpp",
)