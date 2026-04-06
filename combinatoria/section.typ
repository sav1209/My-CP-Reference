#import "../lib.typ": *

// Modular multiplicative inverse operator
#let inv = math.op("inv")

= Combinatoria

== Modular Multiplicative Inverse
#definition(title: "Modular multiplicative inverse", width: 100%)[
  The _modular multiplicative inverse_ of $x$ with respect to $m$ is a value $inv_m (x)$ such that
  $ x dot inv_(m)(x) mod m = 1 $

  If $m$ is prime
  $ inv_(m) (x) = x^(m - 2) $
]


== Binomial Coefficients

#note-box[
  For $n < k$ the value of $binom(n, k)$ is assumed to be zero.
]

=== Properties

/ Pascal's Triangle: $ binom(n, k) = binom(n - 1, k - 1) + binom(n - 1, k) $
/ Symmetry rule: $ binom(n, k) = binom(n, n - k) $
/ Factoring in: $ binom(n, k) = n/k binom(n - 1, k - 1) $
/ Sum over  $bold(k)$ : $ sum_(k = 0)^n binom(n, k) = 2^n $ 
/ Sum over  $bold(n)$ : $ sum_(m = 0)^n binom(m, k) = binom(n + 1, k + 1) $
/ Sum over  $ bold(n)$  and  $bold(k)$ : $ sum_(k = 0)^m binom(n + k, k) = binom(n + m + 1, m) $
/ Sum of the squares: $ binom(n, 0)^2 + binom(n, 1)^2 + dots.c + binom(n, n)^2 = binom(2 n, n) $
/ Weighted sum: $ 1 binom(n, 1) + 2 binom(n, 2) + dots.c + n binom(n, n) = n 2^(n - 1) $
/ Connection with the Fibonacci numbers: $ binom(n, 0) + binom(n - 1, 1) + dots.c + binom(n - k, k) + dots.c + binom(0, n) = F_(n + 1) $

=== Calculation

#codly(header: [Basic Improved Implementation])
```
int C(int n, int k) {
    double res = 1;
    for (int i = 1; i <= k; ++i)
        res = res * (n - k + i) / i;
    return (int)(res + 0.01);
}
```

#codly(header: [Table of binomial coefficients using Pascal's Triangle identity])
```
const int maxn = ...;
int C[maxn + 1][maxn + 1];
C[0][0] = 1;
for (int n = 1; n <= maxn; ++n) {
    C[n][0] = C[n][n] = 1;
    for (int k = 1; k < n; ++k)
        C[n][k] = C[n - 1][k - 1] + C[n - 1][k];
}
```

==== Binomial coefficient modulo prime power

$ binom(n, k) mod p equiv (n!) inv_(p)((n - k)!) inv_(p)(k!) mod p $
$ inv_(p)((x - 1)!) equiv x * inv_(p)((x!)) mod p $