#import "../lib.typ": *


= Otros

== Conectividad Dinámica Offline (Divide and Conquer + DSU con Rollback)
#code-entry(
  time: $O(n log^2 n)$,
  space: $O(n + q)$,
  description: [
    Resuelve conectividad dinámica de forma *offline*: dado un conjunto de aristas que se insertan y eliminan a lo largo del tiempo (cada arista activa durante un intervalo de tiempo conocido de antemano), responde consultas sobre el número de componentes conexas en cada instante. Combina *divide and conquer sobre el tiempo* con un DSU con rollback (sin compresión de caminos, para permitir deshacer uniones).

    *DSU con rollback* (`namespace data`):
    - `build(n2)`: inicializa el DSU con `n2` elementos, cada uno en su propia componente, y `ans = n` (número inicial de componentes).
    - `find(k)`: encuentra la raíz de `k` sin compresión de caminos (necesaria para poder revertir).
    - `add(x)`: une los conjuntos de `x.first` y `x.second` por tamaño. Si ya estaban unidos, apila `-1` como marca de "operación nula"; si no, decrementa `ans` y apila la raíz que fue absorbida, para poder deshacerlo luego.
    - `query()`: retorna el número actual de componentes conexas (`ans`).
    - `rollback()`: deshace la última unión registrada en la pila `S`, restaurando tamaños y punteros, e incrementando `ans` si la unión deshecha no era nula.

    *Divide and conquer sobre el tiempo* (`solve(l, r)`):
    - Cada arista `qu[i]` tiene asociado en `ponta[i]` el otro extremo de su intervalo de vida (o $-1$ si `i` representa una consulta puntual en vez de una arista). Para resolver el rango de tiempo $[l, r]$, `solve` agrega temporalmente (mediante `data::add`) todas las aristas cuyo intervalo de vida cubre completamente uno de los dos sub-rangos $[l, m]$ o $[m+1, r]$ pero no ambos, resuelve recursivamente ese sub-rango con la estructura ya actualizada, y luego revierte (`rollback`) exactamente esas adiciones antes de continuar con el otro sub-rango. Cuando el rango se reduce a un único instante ($l >= r$), la estructura `data` refleja el estado correcto en ese instante y se guarda la respuesta en `ans[l]` mediante `data::query()`.

    Esta técnica evita mantener una estructura de conectividad completamente dinámica (que requeriría *link-cut trees* u otras estructuras más complejas), a cambio de resolver el problema *offline* con un factor $log n$ adicional proveniente de la recursión de *divide and conquer*.
  ],
  source-file: "otros/dc_conectividade.cpp",
)