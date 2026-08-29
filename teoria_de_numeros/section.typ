#import "../lib.typ": *

= Teoría de números

== Cribas

#code-entry(
  title: "Criba de primos con optimizaciones básicas",
  time: $O(n log log n)$,
  space: $O(n)$,
  description: [
    Find all the prime numbers in $[1, n]$. This code uses the next optimizations:
    - Sieving till root
    - Sieving by the odd numbers only
  ],
  source-file: "teoria_de_numeros/sieve_with_basic_optimizations.cpp"
)

#code-entry(
  title: "Criba de divisores",
  description: [Produce una criba para obtener la suma de todos los divisores de cada número en $[1, n]$ y otra para dichos divisores.],
  tag: "start",
  source-file: "teoria_de_numeros/criba_divisores.cpp"
)

#code-entry(
  title: "Criba del primo más pequeño",
  tag: "start",
  source-file: "teoria_de_numeros/criba_primo_mas_pequenio.cpp"
)

#code-entry(
  title: "Criba del primo más grande",
  tag: "start",
  source-file: "teoria_de_numeros/criba_primo_mas_grande.cpp"
)


== Miller-Rabin (Test de Primalidad Determinístico)
#code-entry(
  time: $O(log n)$,
  space: $O(1)$,
  description: [
    Test de primalidad *determinístico* (no probabilístico) para $n <= 3 dot 10^18$, basado en el test de Miller-Rabin con un conjunto fijo de bases que garantiza corrección exacta en ese rango — a diferencia del Miller-Rabin probabilístico clásico, aquí no hay margen de error. Con las bases usadas, el test funciona garantizado para $n <= 2^64$, y el propio autor señala que funciona para $n <= 3 dot 10^24$ si se agregan las bases hasta 41.

    Funciones principales:
    - `mul(a, b, m)`: multiplicación modular de `a * b mod m` segura para `m` cercano a $2^63$, evitando *overflow* mediante la técnica de aproximar el cociente con punto flotante de alta precisión (`long double`) y corregir el resultado, en vez de usar `__int128` (más lento en algunas plataformas).
    - `pow(x, y, m)`: exponenciación modular rápida ($x^y mod m$) mediante *fast power*, construida sobre `mul` para evitar overflow durante las multiplicaciones intermedias.
    - `prime(n)`: descarta rápidamente los casos triviales ($n < 2$: falso; $n <= 3$: primo; `n` par: compuesto), luego descompone $n - 1 = d dot 2^r$ (con `d` impar) usando `__builtin_ctzll`. Para cada base `a` del conjunto fijo `{2, 325, 9375, 28178, 450775, 9780504, 1795265022}`, calcula $a^d mod n$ y verifica la condición de Miller-Rabin: si el resultado no es 1 ni $n-1$, eleva al cuadrado repetidamente hasta $r-1$ veces buscando alcanzar $n-1$; si nunca se alcanza, `n` es compuesto y se retorna falso. Si todas las bases pasan el test, `n` es primo.

    Es la implementación estándar de referencia para verificar primalidad de enteros grandes en competencia (por ejemplo, dentro de factorización tipo Pollard's rho), siendo mucho más rápida que trial division ($O(sqrt(n))$) para valores grandes de $n$.
  ],
  source-file: "teoria_de_numeros/miller_rabin.cpp",
)

== Euclid's Algorithm
The algorithm is based on the formula
$
  gcd(a, b) = cases(
    a & quad b = 0,
    gcd(b, a mod b) & quad b != 0
  )
$

=== Extended Euclid's Algorithm:
Euclid's algorithm can also be extended so that it gives integers $x$ and $y$ for which
$ a x + b y = gcd(a, b) $

#code-entry(
  title: "Iterative version",
  time: $O(log min(a, b))$,
  source-file: "teoria_de_numeros/extended_euclid_algorithm.cpp"
)

== Euler’s Theorem
Euler's totient function $phi(n)$ gives the number of integers between $1, dots, n$ that are coprime to $n$.

Any value of $phi(n)$ can be calculated from the prime factorization of $n$ using the formula
$ phi(n) = product_(i = 1)^k p_i^(alpha_i - 1) (p_i - 1) $

#theorem(title: "Euler’s theorem", width: 100%)[
  For all positive coprime integers $x$ and $m$
  $ x^(phi(m)) mod m = 1 $
]


== Solving Equations

We can efficiently solve a Diophantine equation by using the extended Euclid's algorithm which gives integers $x$ and $y$ that satisfy the equation
$ a x + b y = gcd(a, b) $

A Diophantine equation can be solved exactly when $c$ is divisible by $gcd(a, b)$.

If a pair $(x, y)$ is a solution, then also all pairs
$ (x + (k b)/(gcd(a, b)), y - (k a)/(gcd(a, b))) $
are solutions, where $k$ is any integer.
