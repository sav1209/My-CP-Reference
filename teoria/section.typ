#import "../lib.typ": *
#import "@preview/physica:0.9.8": *

// Operador de inverso multiplicativo modular
#let inv = math.op("inv")

= Teoría

== Teoría de números
=== Algunas funciones relevantes
- La función contadora de primos $pi(n)$ da el _número de primos hasta $n$_. Esta función es asintótica a $n / ln(n)$
  #align(center, table(
    columns: 10,
    stroke: 0.5pt,
    align: center,

    table.cell(fill: mantle)[$x$],
    [$10$],
    [$10^2$],
    [$10^3$],
    [$10^4$],
    [$10^5$],
    [$10^6$],
    [$10^7$],
    [$10^8$],
    [$10^9$],

    table.cell(fill: mantle)[$pi(x)$],
    [4],
    [25],
    [168],
    [1\,229],
    [9\,592],
    [78\,498],
    [664\,579],
    [5\,761\,455],
    [50\,847\,534]
  ))

- Número de divisores de un entero $n$:
  $ tau(n) = product_(i = 1)^k (alpha_i + 1) $

  - Un *número altamente compuesto* es un entero positivo que tiene más divisores que cualquier entero positivo menor que él.
  - Un *número altamente compuesto superior* es un número natural que, en un sentido riguroso y específico, posee una gran cantidad de divisores.

  Algunos números altamente compuestos superiores son:
  #align(center)[
    #table(
      columns: 9,
      stroke: 0.5pt,
      align: center,

      table.cell(fill: mantle)[$n$],
      [6],
      [60],
      [360],
      [5040],
      [55440],
      [720720],
      [4324320],
      [21621600],

      table.cell(fill: mantle)[$tau(n)$],
      [4],
      [12],
      [24],
      [60],
      [120],
      [240],
      [384],
      [576],
    )
  ]

  #align(center)[
    #table(
      columns: 5,
      stroke: 0.5pt,
      align: center,

      table.cell(fill: mantle)[$n$],
      [367567200],
      [6983776800],
      [13967553600],
      [321253732800],

      table.cell(fill: mantle)[$tau(n)$],
      [1152],
      [2304],
      [2688],
      [5376],
    )
  ]

  El número $18401055938125660800 approx 2 times 10^18$ es altamente compuesto y posee $184320$ divisores.

  Para números hasta $10^88$ se cumple que $tau(n) < 3.6 root(3, n)$.

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

*Fórmula recursiva:*
$ C_0 = C_1 = 1 $
$ C_n = sum_(k = 0)^(n - 1) C_k C_(n - 1 - k), quad n >= 2 $

*Fórmulas analíticas:*
$ C_n = 1/(n + 1) binom(2 n, n) = ((2 n)!)/((n + 1)! n!) = product_(k = 2)^n (n + k)/k , quad n >= 0 $

==== Aplicaciones
// Fuentes:
// https://en.wikipedia.org/wiki/Catalan_number
// https://cp-algorithms.com/combinatorics/catalan-numbers.html

El número de Catalán $C_n$ es la solución para:

- Número de secuencias de paréntesis correctas formadas por $n$ paréntesis de apertura y $n$ paréntesis de cierre.
  $ ((())) quad quad ()(()) quad quad ()()() quad quad (())() quad quad dots $

- Las aplicaciones sucesivas de un operador binario pueden representarse mediante un árbol binario completo. Un árbol binario enraizado es completo si cada vértice tiene exactamente dos hijos o ninguno. De esto se sigue que $C_n$ es el número de árboles binarios completos enraizados con $n + 1$ hojas (los vértices no están numerados).

  #example[
    Para $n+1 = 4$ factores $a, b, c, d$: $ a(b(c d)) quad a((b c)d) quad (a b)(c d) quad ((a b)c)d quad (a(b c))d $
  ]

  #figure(image("img/catalan_trees.png", width: 8cm))

- El número de triangulaciones de un polígono convexo con $n + 2$ lados (es decir, el número de particiones del polígono en triángulos disjuntos usando diagonales).
  #example[
    Caso para $n = 4$
    #figure(image("img/catalan_triangulation.png", width: 8cm))
  ]

- El número de formas de conectar los $2n$ puntos de una circunferencia para formar $n$ cuerdas disjuntas.

- El número de árboles binarios completos no isomorfos con $n$ nodos internos (es decir, nodos que tienen al menos un hijo).

- El número de caminos monótonos en una retícula desde el punto $(0, 0)$ hasta el punto $(n, n)$ en una cuadrícula de tamaño $n times n$, que no pasan por encima de la diagonal principal (i.e. conectando $(0, 0)$ a $(n, n)$).

- El número de permutaciones de longitud $n$ que pueden ordenarse con una pila (stack-sortable permutation). Se puede demostrar que la reordenación es ordenable con una pila si y solo si no existe un índice $i < j < k$ tal que $a_k < a_i < a_j$.

- El número de particiones no cruzadas de un conjunto de $n$ elementos.

- El número de formas de cubrir la escalera $1, dots.c, n$ usando $n$ rectángulos. La escalera consta de $n$ columnas, donde la $i$-ésima columna tiene altura $i$.


=== Identidades binomiales
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
sum_(i = 1)^n |A_i|
- sum_(1 <= i < j <= n) |A_i inter A_j|
+ dots.c
+ (- 1)^(n - 1) |A_1 inter A_2 inter dots.c inter A_n|
$

/ Forma compacta: $ lr(|union.big_(i = 1)^n A_i|) = sum_(emptyset != J subset.eq {1, 2, ..., n}) (-1)^(|J| - 1) abs(inter.big_(j in J) A_j) $

=== Derangement (subfactorial)

Un desarreglo (derangement) es una permutación que no tiene puntos fijos. Sea $d_n$ el número de desarreglos de una secuencia $1 dots n$. Se tiene la recurrencia $d_n = (n - 1)(d_(n-1) + d_(n-2))$. Además, $d_n$ es el entero más cercano a $n!/e$.

$ d_n = n! sum_(i=0)^n (-1)^i / i! $
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

== Geometría

=== Ternas pitagóricas
$ a^2 + b^2 = c^2 $

Every Pythagorean triple $(a, b, c)$ is generated uniquely by
$ a = k(m^2 - n^2), b = k(2m n), c = k(m^2 + n^2) $
where $m$, $n$, and $k$ are positive integers with $m > n$, and with $m$ and $n$ coprime and not both odd.

=== Trigonometría

Sean $a, b, c$ las longitudes de los lados y $alpha, beta, gamma$ sus ángulos opuestos, entonces:
/ Semiperímetro: $ s = (a + b + c)/2 $
/ Área: $ A = sqrt(s(s - a)(s - b)(s - c)) $
/ Circunradio: $ R = (a b c)/(4A) $
/ Inradio: $ r = A/s $
/ Longitud de la mediana (divide el triángulo en dos triángulos de igual área):
  $ m_a = 1/2 sqrt(2b^2 + 2c^2 - a^2) $
/ Longitud de la bisectriz (divide los ángulos en dos):
  $ s_a = sqrt(b c [1 - (a/(b + c))^2]) $
/ Ley de senos: $ (sin alpha)/a = (sin beta)/b = (sin gamma)/c = 1/(2R) $
/ Ley de cosenos: $ a^2 = b^2 + c^2 - 2 b c cos alpha $
/ Ley de tangentes: $ (a + b)/(a - b) = tan((alpha + beta)/2) / tan((alpha - beta)/2) $

==== Suma de ángulos
$ 
  sin(alpha plus.minus beta) &= sin alpha cos beta plus.minus cos alpha sin beta\
  cos(alpha plus.minus beta) &= cos alpha cos beta minus.plus sin alpha sin beta\
  tan(alpha plus.minus beta) &= (tan alpha plus.minus tan beta)/(1 minus.plus tan alpha tan beta)
$

==== Transformación de suma a producto
$
  sin alpha plus.minus sin beta &= 2 sin (alpha plus.minus beta)/2 cos (alpha minus.plus beta)/2 \
  cos alpha + cos beta &= 2 cos (alpha + beta)/2 cos (alpha - beta)/2 \
  cos alpha - cos beta &= - 2 sin (alpha + beta)/2 sin (alpha - beta)/2 \
  tan alpha plus.minus tan beta &= (sin(alpha plus.minus beta))/(cos alpha cos beta)
$

=== Producto punto
$ va(a) dprod va(b) = a b cos(theta) $

- El producto punto es positivo si el ángulo entre ellos es agudo.
- Es negativo si el ángulo es obtuso.
- Es cero si son ortogonales (forman un ángulo recto).

==== Propiedades

1. Norma al cuadrado de $vb(a)$:#h(1fr)
  $ |va(a)|^2 = va(a) dprod va(a) $

2. Longitud de $va(a)$:
  $ |va(a)| = sqrt(va(a) dprod va(a)) $

3. Proyección de $va(b)$ sobre $va(a)$:
  $ "proj"_a b = (va(a) dprod va(b))/(|va(b)|^2) va(a) $

4. Ángulo entre vectores:
  $ arccos((va(a) dprod va(b))/(|va(a)| |va(b)|)) $


== Sumas y series
$ sum_(i = 1)^n i = (n(n + 1))/2 wide sum_(i = 1)^n i^2 = (n(n + 1)(2 n + 1))/6 $
$ sum_(i = 1)^n i^3 = (n^2 (n + 1)^2)/4 = (sum_(i = 1)^n i)^2 wide sum_(i = 1)^n i^4 = (n(n + 1)(2n + 1)(3n^2 + 3n - 1))/30 $
$ sum_(k = a)^b c^k = (c^(b + 1) - c^a)/(c - 1), quad c != 1 $
$ g_k (n) = sum_(i = 1)^n i^k = 1/(k + 1) (n^(k + 1) + sum_(j = 1)^k binom(k + 1, j + 1) (- 1)^(j + 1) g_(k - j) (n)) $
$ sum_(i = 0)^n i c^i = (n c^(n + 2) -(n + 1) c^(n + 1) + c)/((c - 1)^2) , quad c != 1 $
$ sum_(i = 0)^infinity i c^i = c/((1 - c)^2) , quad |c| < 1 $

$
e^x &= 1 + x + x^2/2! + x^3/3! + dots.c, -oo < x < oo\
ln(1 + x) &= x - x^2/2 + x^3/3 - x^4/4 + dots.c, -1 < x <= 1\
sqrt(1 + x) &= 1 + x/2 - x^2/8 + (2x^3)/32 - (5x^4)/128 + dots.c, -1 <= x <= 1\
sin x &= x - x^3/3! + x^5/5! - x^7/7! + dots.c, -oo < x < oo\
cos x &= 1 - x^2/2! + x^4/4! - x^6/6! + dots.c, -oo < x < oo
$