#import "../lib.typ": *

// Modular multiplicative inverse operator
#let inv = math.op("inv")

= Combinatoria

== Binomial Coefficients

#note-box[
  For $n < k$ the value of $binom(n, k)$ is assumed to be zero.
]

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