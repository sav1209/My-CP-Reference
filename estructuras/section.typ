#import "../lib.typ": *

= Estructuras de Datos

== Ordered Set

#code-entry(
  time: $O(log n)$,
  space: $O(n)$,
  description: [
    Estructura de datos basada en un árbol rojo-negro (*Policy-Based Data Structures*) que extiende las funcionalidades de un `std::set` convencional de C++. Además de soportar las operaciones estándar de un conjunto, permite consultar estadísticas de orden en tiempo logarítmico.

    Funcionalidades adicionales incluidas:
    - `find_by_order(k)`: Retorna un iterador al $k$-ésimo elemento más pequeño (indexado en cero, donde `k = 0` es el elemento mínimo).
    - `order_of_key(k)`: Retorna la cantidad de elementos estrictamente menores que `k`.

    *Soporte para Multiset:*
    Para simular un multiset, se debe usar `ord_set<pair<int, int>>` utilizando el segundo parámetro como un identificador único para diferenciar elementos con valores iguales. La consulta `s.order_of_key({k, -INF})` devolverá la cantidad total de elementos estrictamente menores que `k`.
  ],
  source-file: "estructuras/ordered_set.cpp",
)

== Segment tree
#code-entry(
  source-file: "estructuras/segment-tree.cpp",
  time: [
    - $O(n)$ for building
    - $O(log n)$ for queries and updates
  ]
)

#code-entry(
  title: [Segment Tree con Lazy Propagation (Suma en Rango)],
  time: $"build": O(n) quad "query": O(log n) quad "update": O(log n)$,
  space: $O(n)$,
  description: [
    Segment Tree recursiva con *lazy propagation* para rangos. `query(a, b)` calcula la suma del rango $[a, b]$, y `update(a, b, x)` suma $x$ a cada elemento del rango $[a, b]$. Puede indexarse cada nodo mediante la función $f(l, r) = (l+r) | (l != r)$, lo que permite usar únicamente $2n$ de memoria en lugar de $4n$.

    Funciones principales:
    - `build(n2, v2)`: construye el árbol en $O(n)$ a partir de un arreglo `v2` de tamaño `n2`, inicializando cada hoja con su valor correspondiente y propagando las sumas hacia los nodos internos.
    - `prop(p, l, r)`: aplica la propagación perezosa (*lazy*) pendiente en el nodo `p`, actualizando su valor acumulado y empujando el `lazy` hacia sus hijos antes de cualquier consulta o actualización.
    - `query(a, b)`: retorna la suma de los elementos en el rango $[a, b]$, propagando lazy en el camino recorrido.
    - `update(a, b, x)`: incrementa en `x` todos los elementos del rango $[a, b]$, actualizando `lazy` en los nodos totalmente cubiertos.

    Extensiones adicionales (para una Segment Tree de *máximo*, no de suma):
    - `get_left(a, b, val)`: encuentra en $O(log n)$ la primera posición dentro de $[a, b]$ cuyo valor sea $>=$ `val`, o $-1$ si no existe. Útil para búsquedas de umbral por la izquierda.
    - `get_right(a, b, val)`: análogo a `get_left`, pero retorna la última posición dentro de $[a, b]$ cuyo valor sea $>=$ `val`, o $-1$ si no existe.

    Extensión adicional (para una Segment Tree de *suma* sobre un arreglo `v` no negativo):
    - `lower_bound(i, val)`: dado un valor acumulado `val`, encuentra en $O(log n)$ el mayor índice $j$ tal que $v[i] + v[i+1] + ... + v[j-1] < "val"$. Útil para problemas tipo "cuántos elementos consecutivos caben antes de superar un umbral", análogo a un *binary search* sobre prefijos de suma pero en $O(log n)$ en vez de $O(log^2 n)$.
  ],
  source-file: "estructuras/segtree_lazy.cpp",
)

== Fenwick tree

#code-entry(
  title: [Binary Indexed Tree (BIT / Fenwick Tree)],
  time: $O(log n)$,
  space: $O(n)$,
  description: [
    Estructura de datos Binary Indexed Tree (BIT) de suma indexada en cero ($0$-based). Permite realizar actualizaciones puntuales y consultas de suma por rangos de manera eficiente.

    Funciones e interfaces incluidas:
    - `Bit(v)`: Construcción lineal en $O(n)$ a partir de un `vector<int>`.
    - `update(i, x)`: Suma `x` a la posición `i`.
    - `pref(i)`: Retorna la suma acumulada en el intervalo $[0, i]$.
    - `query(l, r)`: Retorna la suma en el intervalo $[l, r]$.
    - `upper_bound(x)`: Retorna el menor índice `p` tal que `pref(p) > x` ejecutando una búsqueda binaria sobre el árbol en $O(log n)$.
  ],
  source-file: "estructuras/bit.cpp",
)

#code-entry(
  title: [Binary Indexed Tree con Actualización por Rangos (Range BIT)],
  time: $O(log n)$,
  space: $O(n)$,
  description: [
    Variación de la estructura de datos Binary Indexed Tree (BIT) que permite aplicar actualizaciones por rangos y consultas de suma por rangos de manera eficiente mediante el uso de dos arreglos auxiliares ($0$-based).

    Funciones e interfaces incluidas:
    - `build(n2, v)`: Construcción en tiempo lineal $O(n)$ a partir de un arreglo estático de enteros.
    - `update(l, r, x)`: Suma el valor `x` a todos los elementos en el intervalo $[l, r]$.
    - `query(l, r)`: Retorna la suma total de los elementos en el intervalo $[l, r]$.
  ],
  source-file: "estructuras/range_bit.cpp",
)

== Min Queue (Deque)
#code-entry(
  time: $O(1) "amortizado"$,
  space: $O(n)$,
  description: [
    Cola (*queue*) que soporta obtener el mínimo actual en $O(1)$, implementada mediante un `deque` de pares `{valor, contador}`. Todas las operaciones son $O(1)$ amortizado.

    Funciones principales:
    - `push(x)`: inserta `x` al frente de la cola. Antes de insertarlo, elimina del frente del `deque` todos los elementos mayores a `x` (ya que nunca podrán ser el mínimo mientras `x` siga en la cola), acumulando su cantidad en un contador `ct` para no perder el conteo real de elementos al hacer `pop`.
    - `pop()`: elimina el elemento más antiguo de la cola. Si el par en la parte trasera del `deque` representa más de un elemento (`second > 1`), simplemente decrementa su contador; si representa solo uno, lo elimina por completo.
    - `min()`: retorna el mínimo actual de la cola en $O(1)$, correspondiente al valor almacenado en la parte trasera del `deque`.

    Es la base para técnicas de *sliding window minimum* y para estructuras tipo *stack* que soportan mínimo, combinadas para simular una cola.
  ],
  source-file: "estructuras/minqueue.cpp",
)

== Min Queue mediante Dos Min Stacks
#code-entry(
  time: $O(1) "amortizado"$,
  space: $O(n)$,
  description: [
    Implementación de una cola con mínimo en $O(1)$ amortizado, construida a partir de dos *stacks* con mínimo (`minstack`). Todas las operaciones son $O(1)$ amortizado.

    *Min Stack* (`minstack`):
    - `push(x)`: inserta `x` en la pila, guardando junto a él el mínimo acumulado hasta ese punto (`min(top().second, x)`).
    - `top()`: retorna el elemento en el tope de la pila.
    - `pop()`: elimina y retorna el elemento en el tope.
    - `min()`: retorna el mínimo de toda la pila en $O(1)$, almacenado junto al elemento del tope.

    *Min Queue* (`minqueue`), construida con dos `minstack` (`s1` para inserciones, `s2` para remociones):
    - `push(x)`: inserta `x` en `s1`.
    - `move()`: si `s2` está vacía, transfiere todos los elementos de `s1` a `s2` (invirtiendo su orden), preparando así el frente de la cola. Es la operación que amortiza el costo, ya que cada elemento se mueve a lo sumo una vez de `s1` a `s2`.
    - `front()`: llama a `move()` y retorna el elemento al frente de la cola (`s2.top()`).
    - `pop()`: llama a `move()` y elimina el elemento al frente de la cola.
    - `min()`: retorna el mínimo global comparando el mínimo de `s1` y el mínimo de `s2` (considerando el caso en que alguna esté vacía).

    Es una alternativa a la implementación con `deque` (ver *Min Queue (Deque)*), útil cuando se prefiere evitar el manejo de contadores de repetición y trabajar directamente con dos pilas.
  ],
  source-file: "estructuras/minqueue_stack.cpp",
)

== Priority Queue sobre Estructura de Datos (con Rollback)
#code-entry(
  time: $"update": O(log(n) + T(n)) quad "query": O(T(n)) quad "pop": O(log(n) dot T(n)) "amortizado"$,
  space: $O(n + q)$,
  description: [
    Estructura *wrapper* que mantiene un conjunto de actualizaciones (`update`) aplicadas sobre otra estructura de datos base `DS`, la cual debe soportar `rollback` y no ser amortizada. Cada actualización se asocia a una prioridad `p`, y en cualquier momento es posible remover la actualización de mayor prioridad mediante `pop()`. Es fundamental que las actualizaciones sean *conmutativas*, es decir, el estado final de la estructura debe ser el mismo sin importar el orden en que se apliquen. Se asume que todas las prioridades son distintas.

    Funciones principales:
    - `update(u, p)`: aplica la actualización `u` sobre `D` con prioridad `p`, y la registra tanto en `upd` (historial de tuplas `{u, p, idx_in_pos}`) como en `st` (conjunto ordenado de prioridades) para su posterior localización en `pop`.
    - `query(a)`: delega la consulta a la estructura base `D.find(a)`, devolviendo el resultado en la complejidad propia de `D` ($T(n)$).
    - `pop()`: elimina la actualización con mayor prioridad. Para lograrlo sin romper la conmutatividad, deshace (`rollback`) un bloque de actualizaciones recientes, descarta la de mayor prioridad, y reaplica en orden las restantes (separadas en `small` y `big` según su prioridad relativa). El costo amortizado surge de que el tamaño del bloque a deshacer crece geométricamente, similar a la técnica de *doubling* usada en estructuras persistentes con rollback amortizado.

    $n$ es el tamaño de la estructura base `DS` y $q$ el número de actualizaciones almacenadas en el historial (`upd`); $T(n)$ denota la complejidad de `update` sobre `DS`.
  ],
  source-file: "estructuras/priority_queue_ds.cpp",
)

== Chtholly Tree (Range Color / Assignment)
#code-entry(
  time: $"update": O(log q) "amortizado" quad "query": O(log q)$,
  space: $O(q)$,
  description: [
    Estructura conocida como *Chtholly Tree* (o *Old Driver Tree*), basada en un `set` de intervalos `{l, r, color}` que representa asignaciones de color a rangos. Es eficiente cuando las operaciones de asignación tienden a "fusionar" muchos elementos en un mismo color, ya que el costo amortizado depende de $q$ (número de operaciones), no de $n$ (tamaño del arreglo).

    Funciones principales:
    - `update(l, r, val)`: colorea el rango $[l, r]$ con el color `val`. Primero divide (*split*) los intervalos existentes que se solapan parcialmente con $[l, r]$ en sus extremos, luego elimina todos los intervalos completamente contenidos en $[l, r]$ (recolectándolos en el vector de retorno `ret`), e inserta el nuevo intervalo $[l, r]$ con color `val`. Retorna la lista de tuplas `{l, r, color}` que fueron sobrescritas por esta operación, lo cual es útil para procesar de forma incremental el efecto del cambio de color sobre otras estructuras (por ejemplo, sumar o restar contribuciones antes de recolorear).
    - `query(i)`: retorna el color de la posición `i`, buscando el intervalo del `set` que la contiene; retorna $-1$ si la posición no ha sido coloreada.

    Es especialmente útil en problemas donde las asignaciones de rango "asesinan" (sobrescriben) intervalos anteriores, permitiendo procesar cada elemento del arreglo original a lo sumo un número amortizado de veces a lo largo de todas las operaciones.
  ],
  source-file: "estructuras/range_color.cpp",
)

== RMQ Sparse Table $<O(n), O(1)>$

#code-entry(
  time: $"build": O(n) quad "query": O(1)$,
  space: $O(n)$,
  description: [
    Estructura de *Range Minimum Query* con complejidad $O(n)$ de construcción y $O(1)$ por consulta, basada en la técnica de *Sparse Table + Cartesian Tree / bitmask trick* (método de Fischer-Heun). En caso de haber varios índices con el mismo valor mínimo, `query` retorna el de menor índice.

    Funciones principales:
    - `op(x, y)`: compara dos índices `x`, `y` y retorna el de menor valor en `v` (o menor índice en caso de empate), sirviendo como operador de comparación base para todo el resto de la estructura.
    - `msb(x)`: calcula el bit más significativo de `x` usando `__builtin_clz`, utilizado para operar sobre las máscaras de bits.
    - `small(r, sz)`: resuelve en $O(1)$ el mínimo dentro de un bloque de tamaño `sz` (por defecto `b = 30`) terminando en la posición `r`, usando la máscara precomputada `mask[r]`.
    - Constructor `rmq(v_)`: divide el arreglo en bloques de tamaño `b`, precomputa para cada posición una máscara (`mask`) que codifica, mediante una pila monótona implícita (bits), el rango de elementos hacia la izquierda que siguen siendo "candidatos" a mínimo local. Luego construye una *sparse table* (`t`) sobre los mínimos de cada bloque, permitiendo responder consultas entre bloques completos en $O(1)$.
    - `index_query(l, r)`: si el rango cabe dentro de un solo bloque ($r - l + 1 <= b$), resuelve directamente con `small`. En caso contrario, combina el mínimo de los bloques parciales en los extremos (resueltos con `small`) con el mínimo de los bloques completos intermedios (resuelto en $O(1)$ vía la *sparse table* `t`).
    - `query(l, r)`: retorna el valor mínimo en $v[l..r]$, llamando internamente a `index_query` y accediendo a `v` en la posición resultante.

    Es una alternativa más eficiente en tiempo de consulta que la *sparse table* clásica ($O(n log n)$ de construcción, $O(1)$ de consulta), a costa de mayor complejidad de implementación.
  ],
  source-file: "estructuras/rmq_on_o1.cpp",
)


== Sparse Table (RMQ)
#code-entry(
  time: $"build": O(n log n) quad "query": O(1)$,
  space: $O(n log n)$,
  description: [
    Estructura clásica de *Sparse Table* para resolver *Range Minimum Query* (RMQ), aprovechando que el operador mínimo es idempotente, lo cual permite responder consultas de rango en $O(1)$ tras un preprocesamiento de $O(n log n)$. `MAX2` debe definirse como $log("MAX")$, es decir, la cantidad de niveles necesarios para cubrir arreglos de tamaño `MAX`.

    Funciones principales:
    - `build(n2, v)`: construye la tabla `m` en $O(n log n)$. La fila base `m[0]` se inicializa directamente con los valores del arreglo `v`; cada fila siguiente `m[j]` se calcula combinando pares de mínimos de la fila anterior `m[j-1]`, de modo que `m[j][i]` almacena el mínimo del rango $[i, i + 2^j - 1]$.
    - `query(a, b)`: responde en $O(1)$ el mínimo del rango $[a, b]$. Calcula $j = "floor"(log_2(b - a + 1))$ mediante `__builtin_clz`, y combina dos bloques de tamaño $2^j$ que se solapan pero cubren completamente el rango (`m[j][a]` y `m[j][b - 2^j + 1]`), aprovechando la idempotencia del mínimo para ignorar el solapamiento.

    A diferencia de la variante $<O(n), O(1)>$ (ver *RMQ Sparse Table*), esta versión es más simple de implementar pero tiene mayor costo de construcción y memoria ($O(n log n)$ en vez de $O(n)$).
  ],
  source-file: "estructuras/sparse_table.cpp",
)


== Sparse Table Disjunta
#code-entry(
  time: $"build": O(n log n) quad "query": O(1)$,
  space: $O(n log n)$,
  description: [
    Variante de *Sparse Table* que resuelve *Range Query* en $O(1)$ para *cualquier* operación asociativa `op` (no necesariamente idempotente como el mínimo), a diferencia de la Sparse Table clásica que solo funciona correctamente con operaciones idempotentes. `MAX2` debe definirse como $log("MAX")$. Internamente, el arreglo se extiende a la potencia de 2 más cercana hacia arriba para simplificar la construcción por bloques disjuntos.

    Funciones principales:
    - `op(a, b)`: operación asociativa a resolver sobre rangos; en este ejemplo es el mínimo, pero puede reemplazarse por cualquier otra operación asociativa (suma, xor, gcd, etc.), siempre que no dependa de idempotencia.
    - `build(n2, v2)`: construye la tabla en $O(n log n)$. Extiende `n` a la siguiente potencia de 2. Para cada nivel `j` (de tamaño de bloque `len = 2^j`), y cada punto de corte `c` (frontera entre bloques disjuntos consecutivos), calcula prefijos hacia la derecha y sufijos hacia la izquierda de `op` a partir de `c`, cubriendo así cualquier rango $[l, r]$ que atraviese la frontera `c` sin necesidad de combinar rangos solapados.
    - `query(l, r)`: responde en $O(1)$ el resultado de `op` sobre el rango $[l, r]$. Si $l = r$, retorna directamente `v[l]`. En otro caso, calcula $j$ como el bit más significativo de $l "xor" r$ (que identifica el nivel cuya frontera de bloque separa a `l` y `r`), y combina `m[j][l]` (sufijo desde `l` hasta la frontera) con `m[j][r]` (prefijo desde la frontera hasta `r`) mediante `op`.

    A diferencia de la Sparse Table clásica (ver *Sparse Table (RMQ)*), que solo es válida para operaciones idempotentes, esta versión "disjunta" es la opción correcta cuando se necesita responder consultas de rango en $O(1)$ para operaciones como suma, xor o gcd.
  ],
  source-file: "estructuras/sparse_table_disjunta.cpp",
)


== Mo's Algorithm (com Ordenação de Hilbert)
#code-entry(
  time: $O(n sqrt(q))$,
  space: $O(n + q)$,
  description: [
    Responde offline un conjunto de $q$ consultas de rango $[l, r]$ sobre un arreglo `v`, reordenando las consultas de forma que el costo total de mover los punteros `l` y `r` entre consultas consecutivas sea $O(n sqrt(q))$ en total. Para alcanzar esta cota, `SQ` (tamaño de bloque) debe elegirse como $n / sqrt(q)$. En este ejemplo, `ans` mantiene la cantidad de valores *distintos* dentro del rango actual, pero `insert`/`erase` pueden adaptarse a cualquier otra estadística incremental.

    Funciones principales:
    - `insert(p)`: agrega la posición `p` al rango actual, incrementando `freq[v[p]]` y sumando a `ans` si ese valor pasó a tener frecuencia exactamente 1 (es decir, si es una nueva aparición distinta).
    - `erase(p)`: remueve la posición `p` del rango actual, de forma simétrica a `insert`, restando de `ans` si el valor deja de tener frecuencia 1.
    - `hilbert(x, y)`: calcula la distancia a lo largo de una curva de Hilbert para el punto `(x, y)`, usada como clave de ordenamiento alternativa a la clásica ordenación por bloques (`SQ`). En la práctica, ordenar las consultas por su distancia de Hilbert suele dar un mejor rendimiento constante que el orden por bloques tradicional, evitando además el caso patológico de éste último.
    - `MO(q)`: función principal. Ordena el vector de consultas `q` (pares `{l, r}`) según la clave elegida (controlada por el macro `HILBERT`): por distancia de Hilbert si `HILBERT` está activo, o por el esquema clásico de bloques con *serpenteo* (alternando dirección según la paridad del bloque, para evitar saltos innecesarios de `r`) en caso contrario. Luego procesa las consultas en el orden resultante, moviendo los punteros `l`/`r` con `insert`/`erase` hasta alcanzar cada rango, y guarda `ans` en la posición original de cada consulta (`ret[i]`).

    El macro `HILBERT` permite alternar fácilmente entre ambas estrategias de ordenamiento sin reescribir el resto del algoritmo; en competencia suele preferirse Hilbert quando existe riesgo de que el patrón de consultas ataque el peor caso del ordenamiento por bloques.
  ],
  source-file: "estructuras/mo_algorithm.cpp",
)

