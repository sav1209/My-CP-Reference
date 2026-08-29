#import "../lib.typ": *

= Teoría de gráficas

== Graph Traversal

=== Floodfill

Flood fill is an algorithm that identifies and labels the connected component that a particular cell belongs to in a multidimensional array.

#warning-box[
    Recursive implementations of flood fill sometimes lead to
    - Memory limit exceeded if you run the recursive implementation on a really big grid (i.e., running the above code on a $4000 times 4000$ grid may exceed 256 MB)
        - Non-recursive implementations generally use less memory than recursive ones.
]

#code-entry(
    title: "Example (recursive implementation)",
    source-file: "graficas/floodfill_recursive.cpp",
)

#code-entry(
    title: "Example (iterative implementation)",
    source-file: "graficas/floodfill_iterative.cpp",
)

== Disjoin Set Union

#code-entry(
    title: "Disjoint Set Union",
    time: [
        - `find`: $O(log n)$
        - Con path compression y union by size/rank: $O(alpha(n))$, donde $alpha$ es la inversa de la función de Ackermann (amortizada).
        - Con union by size/rank, peros sin path compression: $O(log n)$ por consulta.
    ],
    source-file: "graficas/dsu.cpp"
)

#code-entry(
  title: [DSU (Union-Find) - Variantes],
  time: [$O(alpha(n)) "~" O(log n)$],
  space: $O(n)$,
  description: [
    Colección de implementaciones de Disjoint Set Union (DSU), estructura que une conjuntos disjuntos y determina a qué conjunto pertenece un elemento mediante su id. Incluye las siguientes variantes:
    - *DSU básico*: unión por tamaño (`unite`) con compresión de caminos (`find`), logrando complejidad amortizada prácticamente constante $O(alpha(n))$. Base para componentes conexas, Kruskal (MST) y detección de ciclos.
    - *DSU bipartido*: además de unir vértices y encontrar componentes (`find`, `unite`), mantiene coloración (`color`) para saber si la componente de un vértice sigue siendo bipartita (`bip`) tras cada unión. Útil para verificar bipartición dinámica de un grafo procesando aristas en línea.
    - *DSU persistente*: cada unión se marca con un timestamp `t` estrictamente creciente. Permite consultar conectividad (`find`) en cualquier instante pasado sin deshacer operaciones; útil para consultas offline sobre el historial de uniones.
    - *DSU con rollback*: omite compresión de caminos para mantener reversibilidad. `checkpoint()` guarda el estado en $O(1)$ y `rollback()` revierte los cambios desde el último checkpoint en $O(m)$, donde $m$ es el número de modificaciones registradas mediante `save`. Usado en técnicas offline como *divide and conquer* sobre el tiempo (*offline dynamic connectivity*).
  ],
  source-file: "graficas/dsu2.cpp",
)


== Small-to-Large Merging (Sack / DSU on Tree)
#code-entry(
  time: $O(n log n)$,
  space: $O(n)$,
  description: [
    Técnica de *DSU on Tree* (también conocida como *Sack*) que responde de forma *offline* consultas sobre todas las sub-árboles de un árbol enraizado, evitando el costo de $O(n^2)$ que resultaría de recalcular desde cero la información de cada sub-árbol. En este ejemplo se mantiene `cnt[c]`, la cantidad de veces que aparece el color `c` dentro de la sub-árbol del vértice actual, pero la técnica generaliza a cualquier estadística agregable de forma incremental.

    Funciones principales:
    - `build(k, d)`: precomputa el tamaño (`sz`) de cada sub-árbol mediante un DFS, y reordena los hijos de `k` para que el hijo de mayor tamaño (*heavy child*) quede siempre en la posición `g[k][0]`. Este reordenamiento es lo que permite luego "saltarlo" eficientemente en `compute`.
    - `compute(k, x, dont)`: agrega (`x = 1`) o remueve (`x = -1`) la contribución de todo el sub-árbol de `k` sobre `cnt`, recorriéndolo completo. El parámetro `dont` (activado por defecto) hace que se salte el primer hijo (`g[k][0]`, el *heavy child*), ya que su información se maneja por separado para lograr la complejidad amortizada $O(n log n)$.
    - `solve(k, keep)`: resuelve recursivamente todos los hijos livianos (*light children*) primero sin conservar su información (`compute` seguido de limpieza), y por último resuelve el *heavy child* conservando su información (gracias al orden de recorrido `!i`, que asegura que el hijo pesado —índice 0— se procese al final con `keep = 1`). Luego agrega la contribución del propio `k` y de sus hijos livianos mediante `compute(k, 1)`. En este punto, `cnt[i]` refleja exactamente cuántas veces aparece el color `i` en la sub-árbol de `k`, momento ideal para responder cualquier consulta asociada a `k`. Finalmente, si `keep = 0` (es decir, `k` es un hijo liviano de su padre), se revierte la contribución con `compute(k, -1, 0)` para no contaminar el conteo de sub-árboles hermanas.

    La clave de la complejidad $O(n log n)$ es que cada vértice es visitado como parte de un "hijo liviano que se descarta" a lo sumo $O(log n)$ veces a lo largo de todo el algoritmo (cada vez que esto ocurre, el tamaño de su componente al menos se duplica).
  ],
  source-file: "graficas/sack.cpp",
)


== Topological Sort

A topological sort of a directed acyclic graph is a linear ordering of its vertices such that for every directed edge $u -> v$ from vertex $u$ to vertex $v$, $u$ comes before $v$ in the ordering.

#code-entry(
    title: "DFS Version",
    source-file: "graficas/topological_sort_dfs.cpp",
)

#code-entry(
    title: "BFS Version (Kahn's Algorithm)",
    source-file: "graficas/topological_sort_bfs.cpp",
)


== Detección de ciclos

#code-entry(
    title: "Implementación para gráficas dirigidas",
    tag: "start",
    source-file: "graficas/deteccion_ciclos_dirigidas.cpp"
)

#code-entry(
    title: "Implementación para gráficas no dirigidas",
    tag: "start",
    source-file: "graficas/deteccion_ciclos_no_dirigidas.cpp"
)

== Detección de Ciclo (Tortoise and Hare)
#code-entry(
  time: $O(mu + lambda)$,
  space: $O(1)$,
  description: [
    Algoritmo de Floyd (*Tortoise and Hare*) para detectar el ciclo de una función iterada $f$ aplicada sobre un valor inicial `f0`, usando únicamente $O(1)$ de memoria. Retorna un par `{st, len}`: `st` es la cantidad de pasos necesarios desde `f0` hasta el inicio del ciclo (la "cola"), y `len` es la longitud del propio ciclo. La complejidad temporal es lineal respecto a cuánto hay que avanzar para empezar a ciclar (usualmente denotado $mu + lambda$, donde $mu$ es la longitud de la cola y $lambda$ la del ciclo).

    Funcionamiento (`find_cycle()`), en tres fases:
    - *Detección de colisión*: se avanza `tort` (tortuga) un paso a la vez y `hare` (liebre) dos pasos a la vez, contando `t`, hasta que ambos coincidan; esto garantiza que existe un ciclo y que se encuentran dentro de él.
    - *Localización del inicio del ciclo*: se reinicia `tort` a `f0` y se avanza tanto `tort` como `hare` un paso a la vez simultáneamente; el punto donde vuelven a coincidir es exactamente el inicio del ciclo, y la cantidad de pasos dados (`st`) es la longitud de la cola.
    - *Cálculo de la longitud del ciclo*: desde el punto de encuentro (`tort`, ya en el inicio del ciclo), se avanza `hare` repetidamente hasta volver a `tort`, contando los pasos (`len`), lo cual da la longitud exacta del ciclo.

    Es útil en problemas sobre *functional graphs* o secuencias generadas iterativamente (por ejemplo, secuencias pseudoaleatorias, iteración de funciones numéricas) donde se necesita conocer la estructura de "cola + ciclo" sin poder almacenar todo el historial visitado, a diferencia de un enfoque con `set`/`map` que usaría $O(mu + lambda)$ de memoria.
  ],
  source-file: "graficas/tortoise_hare.cpp",
)


== Lowest Common Ancestor (LCA)

#code-entry(
    title: "Lowest Common Ancestor - Binary Lifting",
    source-file: "graficas/lca.cpp"
)

== Centro y Diámetro de un Árbol
#code-entry(
  time: $O(n)$,
  space: $O(n)$,
  description: [
    Encuentra el diámetro de un árbol y su(s) centro(s) en $O(n)$. Un árbol siempre tiene uno o dos centros, y estos se ubican exactamente en el punto medio del camino que forma el diámetro. Es útil como paso previo para técnicas de *centroid decomposition*, *rerooting*, o para acotar la altura de un árbol al elegir la raíz óptima (minimizando la excentricidad máxima).

    Funciones principales:
    - `dfs(v)`: recorre el árbol desde `v` calculando profundidades (`d`) y padres (`par`), actualizando en variables externas (`f`, `df`) el vértice más lejano encontrado hasta el momento y su distancia.
    - `center()`: aplica la técnica clásica de "doble BFS/DFS" para hallar el diámetro: primero corre `dfs` desde un vértice arbitrario (el 0) para encontrar el vértice `f` más lejano (un extremo del diámetro); luego corre `dfs` nuevamente desde `f` (ahora usado como `root`) para encontrar el otro extremo del diámetro y su longitud `df`. Finalmente, reconstruye el camino del diámetro siguiendo los punteros `par` desde el segundo extremo hasta la raíz, y selecciona como centro(s) el o los vértices ubicados en la posición $"df"/2$ (y $("df"+1)/2$ si el diámetro es impar, dando dos centros). Retorna el par `{diámetro, vector de centros}`.

    Nota: el código asume que el árbol contiene al vértice `0` y reinicia `par[root] = -1` antes de la segunda pasada; si se reutiliza `center()` sobre múltiples árboles o componentes, hay que asegurarse de resetear `d`/`par` apropiadamente entre llamadas.
  ],
  source-file: "graficas/centro_arvore.cpp",
)

== Functional Graph (Binary Lifting sobre Ciclos)
#code-entry(
  time: $"build": O(n) quad f_k: O(log(min(n,k))) quad "path": O(log(min(n,k)))$,
  space: $O(n)$,
  description: [
    Estructura para *functional graphs* (grafos donde cada vértice `i` tiene exactamente una arista saliente hacia `f[i]`), que permite responder en $O(log(min(n,k)))$ a dónde se llega tras seguir $k$ aristas desde un vértice, y cuál es el costo acumulado (bajo una operación asociativa `op`, suma por defecto) de recorrer esas $k$ aristas. Todo vértice eventualmente cae en un ciclo; la estructura detecta estos ciclos y combina *binary lifting* (para la parte de "cola" antes del ciclo) con una *segment tree circular* (para moverse dentro del ciclo).

    Arreglos principales:
    - `rt[i]`: ID de la raíz (índice del ciclo) asociado al vértice `i`.
    - `d[i]`: profundidad de `i` respecto al ciclo (0 si `i` está en el ciclo).
    - `pos[i]`: posición de `i` dentro del arreglo que concatena todos los ciclos (usado para indexar la segment tree circular `seg`).
    - `p[i]`, `pp[i]`, `jmp[i]`: estructura de *binary lifting* irregular: `p[i]` es el padre inmediato, `pp[i]` es un salto más largo elegido dinámicamente para balancear la profundidad, y `jmp[i]` acumula `op` sobre ese salto.

    Funciones principales:
    - `op(a, b)`: operación asociativa a acumular a lo largo de las aristas recorridas; por defecto es suma, pero puede reemplazarse fácilmente en el código.
    - `dfs(i, t)`: recorre el grafo detectando ciclos (mediante los tiempos de visita `vis`) y construyendo, para cada vértice fuera de un ciclo, los punteros de *binary lifting* (`p`, `pp`, `jmp`) de forma que la profundidad se reduzca aproximadamente a la mitad en cada salto largo, garantizando $O(log n)$ saltos en el peor caso.
    - `build(f_, val_)`: inicializa la estructura a partir del vector de funciones `f_` (arista de cada vértice) y opcionalmente un vector de costos `val_` (si se omite, se usa `f_` como costo). Recolecta todos los ciclos encontrados y construye sobre ellos una segment tree circular (`seg`) para responder consultas de suma dentro del ciclo en $O(log n)$.
    - `f_k(i, k)`: retorna el vértice al que se llega partiendo de `i` y siguiendo exactamente `k` aristas. Primero sube usando los saltos de *binary lifting* mientras `i` no esté en el ciclo, y si aún quedan pasos, calcula la posición final dentro del ciclo mediante aritmética modular sobre `pos`.
    - `path(i, k)`: análogo a `f_k`, pero retorna el resultado acumulado de `op` a lo largo del camino de `k` aristas, en lugar del vértice destino. Dentro del ciclo, usa la segment tree circular para sumar vueltas completas y el tramo parcial restante.
  ],
  source-file: "graficas/functional_graph.cpp",
)

== Floyd-Warshall
#code-entry(
  time: $O(n^3)$,
  space: $O(n^2)$,
  description: [
    Algoritmo que encuentra el camino mínimo entre *todo par de vértices* de un grafo (dirigido o no, con pesos positivos o negativos), y adicionalmente detecta la existencia de ciclos negativos. Antes de ejecutarlo, la matriz de distancias `d` debe inicializarse con $d[i][i] = 0$ para todo $i$, y para $i != j$, $d[i][j] = w$ si existe una arista $(i, j)$ de peso $w$, o $"INF"$ en caso contrario.

    Funciones principales:
    - `floyd_warshall()`: aplica programación dinámica sobre vértices intermedios `k`, relajando iterativamente $d[i][j] = min(d[i][j], d[i][k] + d[k][j])$ para todo par $(i, j)$. Al finalizar, revisa la diagonal de `d`: si algún $d[i][i] < 0$, significa que existe un ciclo de peso negativo alcanzable desde `i`, y la función retorna `1` (verdadero); en caso contrario retorna `0`.

    Es la opción estándar para *all-pairs shortest path* cuando $n$ es pequeño (usualmente $n <= 400$ a $500$ en competencia), evitando así tener que correr Bellman-Ford o Dijkstra desde cada vértice individualmente. Su capacidad de detectar ciclos negativos globales lo hace además útil como verificación rápida de consistencia en sistemas de restricciones de diferencias (*difference constraints*).
  ],
  source-file: "graficas/floyd_warshall.cpp",
)

== Johnson (All-Pairs Shortest Path)
#code-entry(
  time: $O(n m log m)$,
  space: $O(n^2 + m)$,
  description: [
    Algoritmo que resuelve *all-pairs shortest path* con el mismo objetivo que Floyd-Warshall (ver *Floyd-Warshall*), es decir, encuentra el camino mínimo entre todo par de vértices y detecta la existencia de un ciclo negativo, pero con mejor complejidad cuando el grafo es *ralo* (m << n^2): $O(n m log m)$ en vez de $O(n^3)$. Funciona mediante *reponderación* de aristas (usando potenciales de Bellman-Ford) para eliminar pesos negativos, permitiendo luego correr Dijkstra desde cada vértice.

    Funciones principales:
    - `johnson(n)`: primero calcula potenciales `h[i]` para cada vértice mediante $n$ iteraciones de relajación estilo Bellman-Ford (equivalente a agregar un vértice ficticio conectado a todos con peso 0); si tras $n$ iteraciones aún es posible relajar alguna arista, existe un ciclo negativo y la función retorna `1`. Luego, para cada vértice `i`, corre Dijkstra sobre el grafo reponderado (donde cada arista $(v, u)$ de peso $w$ pasa a tener peso $w + h[v] - h[u] >= 0$), almacenando las distancias en `d[i][*]`. Finalmente, revierte la reponderación sumando $h[j] - h[i]$ a cada distancia calculada, obteniendo así las distancias reales en el grafo original.

    Es la opción preferida sobre Floyd-Warshall cuando $n$ es grande pero el grafo tiene relativamente pocas aristas ($m$ cercano a $n$), ya que evita el costo cúbico fijo de Floyd-Warshall a cambio de ejecutar Dijkstra $n$ veces sobre un grafo reponderado sin pesos negativos.
  ],
  source-file: "graficas/johnson.cpp",
)