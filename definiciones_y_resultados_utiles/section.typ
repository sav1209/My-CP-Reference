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
- Producto de divisores de un entero $n$:
  $ n^(tau(n) / 2) $

=== Aritmética modular

#definition(title: "Modular multiplicative inverse", width: 100%)[
  The _modular multiplicative inverse_ of $x$ with respect to $m$ is a value $inv_m (x)$ such that
  $ x dot inv_(m)(x) mod m = 1 $

  If $m$ is prime
  $ inv_(m) (x) = x^(m - 2) $
]

- Factorial inverso modular: $display(inv_(p)((x - 1)!) equiv (x dot inv_(p)(x!)) mod p)$


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

==== Estrellas y barras

#theorem[
  El número de formas de colocar $n$ objetos idénticos en $k$ cajas etiquetadas es
  $  binom(n + k - 1, n) $
]

Utilizando este resultado podemos contar el número de sumas de $k$ enteros acotados inferiormente, i.e, el número de soluciones para la ecuación
$ x_1 + x_2 + dots.c + x_k = n $
con $x_i >= a_i$.

La solución es:
$ binom(n - (a_1 + a_2 + dots.c + a_k) + k - 1, n) $

Cuando los $x_i$ están acotados superiormente, podemos usar el principio de inclusión-exclusión para contar el número de soluciones.

=== Principio de inclusión-exclusión

$
lr(|union.big_(i = 1)^n A_i|)
=
sum_(i = 1)^n | A_i |
- sum_(1 <= i < j <= n) | A_i inter A_j |
+ sum_(1 <= i < j < k <= n) | A_i inter A_j inter A_k |
- dots.c
+ (- 1)^(n - 1) | A_1 inter A_2 inter dots.c inter A_n |
$

=== Desarreglos (subfactorial)
$ D_n = sum_(i = 0)^n (-1)^i binom(n, i) (n - i)! approx (n!) / e $

$
  D_n = cases(
    0 & " si" n = 1,
    1 & " si" n = 2,
    (n - 1) (D_(n - 2) + D_(n - 1)) & " si" n >= 3
  )
$

$ D_n = n D_(n - 1) + (-1)^n " para " n >= 1 $

$
  !0 &= 1\
  !1 &= 0\
  !2 &= 1\
  !3 &= 2\
  !4 &= 9\
  !5 &= 44\
  !6 &= 265\
  !7 &= 1854\
  !8 &= 14833\
  !9 &= 133496\
  !10 &= 1334961
$