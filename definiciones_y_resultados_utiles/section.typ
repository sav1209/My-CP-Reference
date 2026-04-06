#import "../lib.typ": *

// Operador de inverso multiplicativo modular
#let inv = math.op("inv")

= Definiciones y resultados útiles

== Teoría de números
=== Primos
- Primeros 50 números primos:\
  2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229

- Para todo entero $n > 1$, existe una factorización prima única
  $ n = p_1^(alpha_1) p_2^(alpha_2) dots.c p_k^(alpha_k) $

- La función contadora de primos $pi(n)$ da el _número de primos hasta $n$_:
  $ pi(n) approx n / ln(n) $

- Número de divisores de un entero $n$:
  $ tau(n) = product_(i = 1)^k (alpha_i + 1) $

- Suma de divisores de un entero $n$:
  $ sigma(n) = product_(i = 1)^k (1 + p_i + dots.h + p_i^(alpha_i)) = product_(i = 1)^k (p_i^(alpha_i + 1) - 1)/(p_i - 1) $

=== Aritmética modular

#definition(title: "Modular multiplicative inverse", width: 100%)[
  The _modular multiplicative inverse_ of $x$ with respect to $m$ is a value $inv_m (x)$ such that
  $ x dot inv_(m)(x) mod m = 1 $

  If $m$ is prime
  $ inv_(m) (x) = x^(m - 2) $
]

- Factorial inverso modular: $ inv_(p)((x - 1)!) equiv x * inv_(p)((x!)) mod p $


== Combinatoria

=== Números de Fibonacci
$ F_0 = 0, F_1 = 1, F_n = F_(n - 1) + F_(n - 2) $
- Primeros 30 términos:\
  0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811, 514229

=== Coeficientes binomiales
- Pascal's Triangle: $ binom(n, k) = binom(n - 1, k - 1) + binom(n - 1, k) $
- Symmetry rule: $ binom(n, k) = binom(n, n - k) $
- Factoring in: $ binom(n, k) = n/k binom(n - 1, k - 1) $
- Sum over $k$: $ sum_(k = 0)^n binom(n, k) = 2^n $ 
- Sum over $n$: $ sum_(m = 0)^n binom(m, k) = binom(n + 1, k + 1) $
- Sum over $n$ and $k$: $ sum_(k = 0)^m binom(n + k, k) = binom(n + m + 1, m) $
- Sum of the squares: $ binom(n, 0)^2 + binom(n, 1)^2 + dots.c + binom(n, n)^2 = binom(2 n, n) $
- Weighted sum: $ 1 binom(n, 1) + 2 binom(n, 2) + dots.c + n binom(n, n) = n 2^(n - 1) $
- Connection with the Fibonacci numbers: $ binom(n, 0) + binom(n - 1, 1) + dots.c + binom(n - k, k) + dots.c + binom(0, n) = F_(n + 1) $
  #figure(
    image("/assets/images/fibonacci-pascal.png", width: 6cm)
  )

=== Desarreglos
