#import "../lib.typ": *

= Number Theory

The _prime-counting function_ $pi(n)$ gives the number of primes up to $n$.
$ pi(n) approx n / ln(n) $

== Primes and Factors
For every integer $n > 1$, there is a unique prime factorization
$ n = p_1^(alpha_1) p_2^(alpha_2) dots.c p_k^(alpha_k) $

Number of factors of an integer $n$
$ tau(n) = product_(i = 1)^k (alpha_i + 1) $

Sum of factors of an integer $n$
$
  sigma(n) = product_(i = 1)^k (1 + p_i + dots.h + p_i^(alpha_i)) = product_(i = 1)^k (p_i^(alpha_i + 1) - 1)/(p_i - 1)
$

== Sieve of Eratosthenes

#code-entry(
  title: "Sieve with basic optimizations",
  time: $O(n log log n)$,
  space: $O(n)$,
  description: [
    Find all the prime numbers in $[1, n]$. This code uses the next optimizations:
    - Sieving till root
    - Sieving by the odd numbers only
  ],
  source-file: "number_theory/sieve_with_basic_optimizations.cpp"
)

== Euclid’s Algorithm
The algorithm is based on the formula
$
  gcd(a, b) = cases(
    a & quad b = 0,
    gcd(b, a mod b) & quad b != 0
  )
$

=== Extended Euclid’s Algorithm:
Euclid’s algorithm can also be extended so that it gives integers $x$ and $y$ for which
$ a x + b y = gcd(a, b) $

#code-entry(
  title: "Iterative version",
  time: $O(log min(a, b))$,
  source-file: "number_theory/extended_euclid_algorithm.cpp"
)

== Euler’s Theorem
Euler’s totient function $phi(n)$ gives the number of integers between $1, dots, n$ that are coprime to $n$.

Any value of $phi(n)$ can be calculated from the prime factorization of $n$ using the formula
$ phi(n) = product_(i = 1)^k p_i^(alpha_i - 1) (p_i - 1) $

#theorem(title: "Euler’s theorem", width: 100%)[
  For all positive coprime integers $x$ and $m$
  $ x^(phi(m)) mod m = 1 $
]

If $m$ is prime, $phi(m) = m − 1$, so the formula becomes
$ x^(m - 1) mod m = 1 $
which is known as _Fermat’s little theorem_. This also implies that
$ x^n mod m = x^(n mod (m - 1)) mod m $
which can be used to calculate values of $x^n$ if $n$ is very large.

#definition(title: "Modular multiplicative inverse", width: 100%)[
  The _modular multiplicative inverse_ of $x$ with respect to $m$ is a value $inv_m (x)$ such that
  $ x dot inv_(m)(x) mod m = 1 $
]

A modular multiplicative inverse exists exactly when $x$ and $m$ are coprime. In this case it can be calculated using the formula
$ inv_(m)(x) = x^(phi(m) - 1) $

In particular, if $m$ is prime, $phi(m) = m − 1$ and the formula becomes
$ inv_(m) (x) = x^(m - 2) $

The above formula allows us to efficiently calculate modular multiplicative inverses using the modular exponentiation algorithm.

== Solving Equations
#definition(title: "Diophantine equation", width: 100%)[
  A _Diophantine equation_ is an equation of the form
  $ a x + b y = c $
  where $a$, $b$ and $c$ are constants and the values of $x$ and $y$ should be found. Each number in the equation has to be an integer.
]
We can efficiently solve a Diophantine equation by using the extended Euclid’s algorithm which gives integers $x$ and $y$ that satisfy the equation
$ a x + b y = gcd(a, b) $

A Diophantine equation can be solved exactly when $c$ is divisible by $gcd(a, b)$.

If a pair $(x, y)$ is a solution, then also all pairs
$ (x + (k b)/(gcd(a, b)), y - (k a)/(gcd(a, b))) $
are solutions, where $k$ is any integer.
