#import "../lib.typ": *

// Operador de inverso multiplicativo modular
#let inv = math.op("inv")

= Definiciones y resultados útiles

== Teoría de números
=== Primos

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

=== Números de Catalán

$ C_0 = C_1 = 1 $

$ C_n = sum_(k = 0)^(n - 1) C_k C_(n - 1 - k), n >= 2 $

$ C_n = 1/(n + 1) binom(2 n, n) $

==== Aplicaciones
El número de Catalán $C_n$ es la solución para:

- El número de secuencias de paréntesis correctas compuestas por $n$ paréntesis de apertura y $n$ de cierre.

- El número de árboles binarios completos enraizados con $n + 1$ hojas (los vértices no están numerados). Un árbol binario enraizado es completo si cada vértice tiene dos hijos o ninguno.

- El número de formas de parentizar completamente $n + 1$ factores.

- El número de triangulaciones de un polígono convexo con $n + 2$ lados (es decir, el número de particiones del polígono en triángulos disjuntos usando diagonales).

- El número de formas de conectar los $2n$ puntos de una circunferencia para formar $n$ cuerdas disjuntas.

- El número de árboles binarios completos no isomorfos con $n$ nodos internos (es decir, nodos que tienen al menos un hijo).

- El número de caminos monótonos en una retícula desde el punto $(0, 0)$ hasta el punto $(n, n)$ en una cuadrícula de tamaño $n times n$, que no pasan por encima de la diagonal principal.

- El número de permutaciones de longitud $n$ que pueden ordenarse con una pila. Se puede demostrar que la reordenación es ordenable con una pila si y solo si no existe un índice $i < j < k$ tal que $a_k < a_i < a_j$.

- El número de particiones no cruzadas de un conjunto de $n$ elementos.

- El número de formas de cubrir la escalera $1, dots.c, n$ usando $n$ rectángulos. La escalera consta de $n$ columnas, donde la $i$-ésima columna tiene altura $i$.


=== Coeficientes binomiales
- Pascal's Triangle: #h(1fr)$ binom(n, k) = binom(n - 1, k - 1) + binom(n - 1, k) $
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

=== Estrellas y barras

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


== Primeros términos de algunas sucesiones básicas

#show table.cell.where(y: 0): math.bold
#show table.cell.where(x: 0): math.bold

#figure(
  table(
    columns: 7,
    align: center,
    $n$, $p_n$, $F_n$, $C_n$, $2^n$, $n!$, $!n$,
    $0$, $—$, $0$, $1$, $1$, $1$, $1$,
    $1$, $2$, $1$, $1$, $2$, $1$, $0$,
    $2$, $3$, $1$, $2$, $4$, $2$, $1$,
    $3$, $5$, $2$, $5$, $8$, $6$, $2$,
    $4$, $7$, $3$, $14$, $16$, $24$, $9$,
    $5$, $11$, $5$, $42$, $32$, $120$, $44$,
    $6$, $13$, $8$, $132$, $64$, $720$, $265$,
    $7$, $17$, $13$, $429$, $128$, $5040$, $1854$,
    $8$, $19$, $21$, $1430$, $256$, $40320$, $14833$,
    $9$, $23$, $34$, $4862$, $512$, $362880$, $133496$,
    $10$, $29$, $55$, $16796$, $1024$, $3628800$, $1334961$,
    $11$, $31$, $89$, $58786$, $2048$, $39916800$, $14684570$,
    $12$, $37$, $144$, $208012$, $4096$, $479001600$, $176432560$,
    $13$, $41$, $233$, $742900$, $8192$, $6227020800$, $2290792932$,
    $14$, $43$, $377$, $2674440$, $16384$, $87178291200$, $32071101049$,
    $15$, $47$, $610$, $9694845$, $32768$, $1307674368000$, $481066515734$,
  ),
)