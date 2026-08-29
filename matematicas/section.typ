#import "../lib.typ": *

= Matemáticas

== Operaciones básicas con matrices
#code-entry(
  title: "Operaciones básicas con matrices",
  source-file: "matematicas/matrix_exponentiation.cpp"
)


== Division Trick (Floor Division Blocks)
#code-entry(
  time: $O(sqrt(n))$,
  space: $O(1)$,
  description: [
    Técnica que enumera, en $O(sqrt(n))$ iteraciones, todos los valores distintos de $floor.l n/i floor.r$ para $i$ entre $1$ y $n$, agrupándolos en bloques $[l, r]$ donde $floor.l n/i floor.r$ es constante. En cada iteración del ciclo, `l` marca el inicio del bloque actual y `r = n / (n / l)` calcula el mayor índice `i` tal que $floor.l n/i floor.r = floor.l n/l floor.r$, permitiendo saltar directamente al siguiente bloque en la próxima iteración (`l = r + 1`).

    Es una herramienta fundamental para acelerar sumatorias o productos que involucran divisiones enteras, como $sum_(i=1)^n floor.l n/i floor.r$ (usada en problemas de conteo de divisores) o convoluciones de funciones multiplicativas, reduciendo el costo de $O(n)$ a $O(sqrt(n))$ al aprovechar que $floor.l n/i floor.r$ toma a lo sumo $O(sqrt(n))$ valores distintos. Puede combinarse fácilmente con estructuras de prefijos (por ejemplo, sumas de una función multiplicativa) para responder consultas del tipo $sum_(i=1)^n f(i) dot floor.l n/i floor.r$ en $O(sqrt(n))$.
  ],
  source-file: "matematicas/division_trick.cpp",
)