#import "../lib.typ": *

= Programación Dinámica

#code-entry(
  title: "Kadane's algorithm",
  time: $O(n)$,
  tag: "begin",
  description: "Given an array of integers, find the maximum sum subarray.",
  source-file: "dp/kadane.cpp",
)

#code-entry(
  title: "Knapsack 0/1",
  time: $O(n W)$,
  description: [
    Given weights and values of $n$ items, put these items in a knapsack of capacity $W$ to get the maximum total value in the knapsack.
  ],
  tag: "begin",
  source-file: "dp/knapsack01.cpp",
)

#code-entry(
  title: "Coin Change",
  tag: "begin",
  source-file: "dp/coin_change.cpp",
)


== LIS (Longest Increasing Subsequence) con Reconstrucción
#code-entry(
  time: $O(n log n)$,
  space: $O(n)$,
  description: [
    Calcula y reconstruye explícitamente una *Longest Increasing Subsequence* (LIS) del arreglo `v`, no solo su longitud, usando la técnica clásica de `d[t]` = menor valor final posible entre todas las subsecuencias crecientes de longitud `t+1`. Para permitir subsecuencias *no decrecientes* (en vez de estrictamente crecientes), basta con reemplazar `lower_bound` por `upper_bound`.

    Funcionamiento:
    - Se mantiene el arreglo `d`, donde `d[t]` almacena el menor valor final entre todas las subsecuencias crecientes de longitud `t` encontradas hasta el momento; `d[0] = -"INF"` actúa como centinela.
    - Para cada elemento `v[i]`, se busca mediante `lower_bound` la posición `t` donde debe colocarse dentro de `d` (es decir, la longitud de la subsecuencia creciente más larga que termina en `v[i]`), se actualiza `d[t] = v[i]`, y se guarda en `l[i] = t` la longitud de la LIS que termina exactamente en el índice `i`. Se lleva además el máximo `m` de todas las longitudes vistas.
    - Para reconstruir la subsecuencia, se recorre `v` de derecha a izquierda buscando, para cada longitud objetivo `m` (comenzando en la longitud total de la LIS), un índice `p` tal que `l[p] == m`; al encontrarlo se agrega `v[p]` al resultado y se decrementa `m`. Al finalizar se invierte el resultado para obtener el orden correcto.

    Es la extensión natural del algoritmo estándar de LIS en $O(n log n)$ (que solo calcula la longitud), agregando reconstrucción explícita de la subsecuencia sin sacrificar la complejidad asintótica.
  ],
  source-file: "dp/lis_recupera.cpp",
)


== LIS (Longest Increasing Subsequence) - Tamaño
#code-entry(
  time: $O(n log n)$,
  space: $O(n)$,
  description: [
    Calcula únicamente la *longitud* de la *Longest Increasing Subsequence* (LIS) de `v`, sin reconstruir la subsecuencia (para eso, ver *LIS con Reconstrucción*). Es la versión más simple y compacta del algoritmo en $O(n log n)$.

    Funcionamiento: se mantiene un arreglo auxiliar `ans`, donde `ans[t]` representa el menor valor final posible entre todas las subsecuencias crecientes de longitud `t+1` encontradas hasta el momento (aunque `ans` en sí *no* es una LIS válida, solo codifica esta información). Para cada elemento `t` de `v`, se busca mediante `lower_bound` la primera posición en `ans` cuyo valor sea $>= t$: si no existe (`it == ans.end()`), significa que `t` extiende la subsecuencia más larga encontrada hasta ahora, por lo que se agrega al final; si existe, se reemplaza ese valor por `t`, ya que `t` permite continuar subsecuencias futuras con un valor final menor (mejor cota). Al finalizar, el tamaño de `ans` es exactamente la longitud de la LIS. Para permitir subsecuencias *no decrecientes* en vez de estrictamente crecientes, basta con reemplazar `lower_bound` por `upper_bound`.
  ],
  source-file: "dp/lis_tamanho.cpp",
)


== Divide and Conquer DP (Particionamento en $k$ subarreglos)
#code-entry(
  time: $O(k n log n)$,
  space: $O(n)$,
  description: [
    Optimización de programación dinámica que particiona un arreglo en exactamente $k$ subarreglos contiguos, minimizando la suma de una función `query(l, r)` (costo de cada subarreglo $[l, r]$) evaluada sobre todas las particiones. Aplica cuando el óptimo satisface la propiedad de *monotonicidad del punto de quiebre* (*opt monotonicity*): si $"opt"[i]$ es el mejor punto de corte para el estado `i`, entonces $"opt"[i]$ es no decreciente en `i`. Se asume que `query(l, r)` se puede evaluar en $O(1)$ (usualmente mediante prefijos precomputados).

    Funciones principales:
    - `solve(k, l, r, lk, rk)`: resuelve recursivamente, para la capa `k` de la DP, todos los estados `m` en el rango $[l, r]$, sabiendo de antemano que sus puntos de corte óptimos están acotados dentro de $["lk", "rk"]$. Calcula el punto de corte óptimo `p` para el estado medio `m` mediante búsqueda lineal en $["max"(m, "lk"), "rk"]$, y usa ese resultado para acotar las llamadas recursivas sobre las mitades izquierda y derecha ($[l, m-1]$ acotado por $["lk", p]$, y $[m+1, r]$ acotado por $[p, "rk"]$), garantizando que el trabajo total por capa sea $O(n log n)$ en vez de $O(n^2)$.
    - `DC(n, k)`: función principal. Inicializa la capa base `dp[n][*] = 0` (costo de no tener más elementos por particionar) y `dp[i][0] = "LINF"` para los demás estados, luego ejecuta `solve` una vez por cada una de las $k$ capas, alternando el arreglo `dp` mediante paridad (`k&1`) para ahorrar memoria (solo se guardan dos capas simultáneamente en vez de $O(k n)$). Retorna el costo mínimo total `dp[0][k&1]`.

    Es la técnica estándar para acelerar DPs de partición cuando la función de costo satisface *quadrangle inequality* o una condición de monotonicidad similar, reduciendo la complejidad de $O(k n^2)$ (DP ingenua) a $O(k n log n)$.
  ],
  source-file: "dp/dc_dp.cpp",
)


== Longest Common Subsequence con Reconstrucción (Hirschberg)
#code-entry(
  time: $O(n m)$,
  space: $O(n + m)$,
  description: [
    Calcula la *Longest Common Subsequence* (LCS) entre dos arreglos `s` y `t`, reconstruyendo explícitamente la subsecuencia mediante el algoritmo de Hirschberg, el cual logra recuperar la solución completa usando solo $O(n+m)$ de memoria en vez de los $O(n m)$ que requeriría guardar toda la tabla de DP clásica para *backtracking*. Se basa en *divide and conquer* sobre una de las dos secuencias, combinado con DP calculada desde ambos extremos.

    Funciones principales:
    - `dp_top(li, ri, lj, rj)`: calcula, usando solo $O("rj" - "lj")$ de memoria (una fila `dp[0]`), el valor de la LCS entre `s[li..ri]` y cada prefijo `t[lj..j]` para `j` en $["lj", "rj"]$, mediante la recurrencia estándar de LCS pero colapsada a una sola fila reutilizada.
    - `dp_bottom(li, ri, lj, rj)`: análogo a `dp_top` pero calculado desde el extremo opuesto, obteniendo el valor de la LCS entre `s[li..ri]` y cada sufijo `t[j..rj]`, almacenado en `dp[1]`.
    - `solve(ans, li, ri, lj, rj)`: función recursiva principal. En los casos base (`li == ri` o `lj == rj`, es decir, uno de los dos segmentos tiene un solo elemento), busca directamente si ese elemento aparece en el otro segmento y lo agrega a la respuesta. En el caso general, divide `s[li..ri]` por la mitad (`mi`), calcula `dp_top` sobre la mitad izquierda y `dp_bottom` sobre la mitad derecha respecto a todo el rango `t[lj..rj]`, y busca el punto de corte `j_` en `t` que maximiza la suma `dp[0][j] + dp[1][j+1]` (es decir, el mejor punto para dividir `t` de forma consistente con la división de `s`). Luego recursa sobre ambas mitades: `s[li..mi]` con `t[lj..j_]`, y `s[mi+1..ri]` con `t[j_+1..rj]`.
    - `lcs(s, t)`: función de entrada; copia los arreglos a los buffers globales `lcs_s`/`lcs_t` y llama a `solve` sobre el rango completo, retornando la subsecuencia común más larga como vector.

    Esta técnica es la extensión natural del algoritmo clásico de LCS en $O(n m)$ tiempo, pero optimizando memoria de $O(n m)$ a $O(n+m)$ sin sacrificar la capacidad de reconstruir explícitamente la subsecuencia — crucial cuando $n$ y $m$ son grandes y no cabe la tabla completa en memoria.
  ],
  source-file: "dp/lcs_hirschberg.cpp",
)


== Knapsack (Mochila) con Reconstrucción y Memoria Optimizada
#code-entry(
  time: $O(n dot "cap")$,
  space: $O(n + "cap")$,
  description: [
    Resuelve el problema de la mochila 0/1 (*0/1 Knapsack*) reconstruyendo explícitamente el conjunto de ítems elegidos, usando solo $O(n + "cap")$ de memoria en lugar de los $O(n dot "cap")$ que requeriría la tabla completa de DP para *backtracking* tradicional. Aplica la misma idea de *divide and conquer* que el algoritmo de Hirschberg para LCS (ver *LCS con Reconstrucción*): dividir el conjunto de ítems en dos mitades, calcular la DP desde ambos extremos con memoria colapsada, y combinar los resultados en el punto óptimo.

    Funciones principales:
    - `get_dp(x, l, r, cap)`: calcula, usando solo una fila `dp[x]` de tamaño $"cap"+1$, el valor máximo obtenible usando únicamente los ítems en el rango $[l, r]$ para cada capacidad posible de 0 a `cap`, mediante la recurrencia estándar de mochila 0/1 (iterando la capacidad en reversa para no reusar un mismo ítem más de una vez).
    - `solve(ans, l, r, cap)`: función recursiva principal. En el caso base ($l == r$, un solo ítem), agrega el ítem a la respuesta si su peso cabe en la capacidad restante. En el caso general, divide el rango de ítems por la mitad (`m`), calcula `get_dp` para la mitad izquierda `[l, m]` y la derecha `[m+1, r]` de forma independiente, y busca la repartición óptima de capacidad `left_cap` entre ambas mitades que maximice `dp[0][j] + dp[1][cap - j]`. Luego recursa sobre ambas mitades, cada una con su porción de capacidad asignada (`left_cap` para la izquierda, `cap - left_cap` para la derecha).
    - `knapsack(n, cap)`: función de entrada; llama a `solve` sobre el rango completo de ítems $[0, n-1]$ y la capacidad total `cap`, retornando la lista de índices de los ítems seleccionados en la solución óptima.

    Es la versión de mochila 0/1 análoga a Hirschberg para LCS: mismo truco de *divide and conquer* con DP bidireccional para lograr reconstrucción de la solución sin pagar el costo de memoria de guardar toda la tabla de *backtracking*.
  ],
  source-file: "dp/knapsack_hirschberg.cpp",
)

#code-entry(
  title: [SOS DP (Sum over Subsets / Supersets)],
  time: $O(n dot 2^n)$,
  space: $O(2^n)$,
  description: [
    Técnica de programación dinámica sobre *bitmasks* que calcula, para cada máscara, la suma de $f$ sobre todos sus subconjuntos (o superconjuntos) en $O(n dot 2^n)$, en lugar de $O(3^n)$ que resultaría de iterar explícitamente todos los pares (máscara, submáscara). Se procesa un bit a la vez, propagando la contribución entre máscaras que difieren únicamente en ese bit.

    Funciones principales:
    - `sos_dp(f)` (suma de subconjuntos): dado un arreglo `f` indexado por máscara (de tamaño $2^N$), retorna un nuevo arreglo donde la posición `mask` contiene la suma de $f["submask"]$ sobre todos los `submask` $subset.eq$ `mask`. Para cada bit `i`, recorre todas las máscaras que tienen el bit `i` encendido y les suma la contribución de la misma máscara con ese bit apagado.
    - `sos_dp(f)` (suma de superconjuntos): variante simétrica que retorna, en la posición `mask`, la suma de $f["supmask"]$ sobre todos los `supmask` $supset.eq$ `mask`. Para cada bit `i`, recorre las máscaras que tienen el bit `i` *apagado* y les suma la contribución de la misma máscara con ese bit encendido.

    En ambos casos, `N = __builtin_ctz(f.size())` obtiene $log_2$ del tamaño del arreglo (que debe ser una potencia de 2 exacta, verificado con `assert`). Es una herramienta fundamental en problemas de conteo o agregación sobre subconjuntos/superconjuntos de un universo pequeño (usualmente $N <= 20$-$22$ en competencia), como en problemas de *bitmask DP*, convoluciones AND/OR (*Zeta/Möbius transform*), o conteo de máscaras compatibles.
  ],
  source-file: "dp/sos_dp.cpp",
)


#code-entry(
  title: [Subset Sum Acotado (Meet-in-the-Middle Implícito)],
  time: $O(n dot max(w))$,
  space: $O(max(w))$,
  description: [
    Dado un arreglo de pesos `w` y un umbral `t`, retorna el mayor valor $x <= t$ tal que existe un subconjunto de `w` cuya suma sea exactamente `x`. Logra una complejidad de $O(n dot max(w))$ tiempo y $O(max(w))$ memoria, mejorando la DP clásica de subset sum en $O(n dot t)$ cuando $t$ es mucho mayor que $max(w)$ (situación común cuando $t approx sum w_i$).

    Funcionamiento:
    - Primero se consumen "gratis" (sin usar DP) todos los elementos iniciales de `w` mientras la suma prefijo `pref` no exceda `t`, avanzando el índice `k`. Si se logra consumir todo el arreglo sin exceder `t`, la respuesta es directamente `pref`.
    - En caso contrario, se define $W = max(w)$ y se trabaja con una DP relativa (`dp`, de tamaño $2W$), donde `dp[x]` almacena el mayor índice `j` tal que, usando los elementos `w[j..i]` (los "más recientes" procesados hasta el elemento `i`), es posible alcanzar una suma relativa `x` respecto al objetivo desplazado. Esta representación relativa es lo que permite acotar el tamaño de la DP a $O(W)$ en vez de $O(t)$.
    - Por cada nuevo elemento `w[i]`, se actualiza `dp` en dos fases: primero una fase de "inclusión hacia adelante" (agregar `w[i]` a estados existentes), y luego una fase de "poda hacia atrás" que descarta del extremo derecho los elementos más antiguos que ya no son necesarios, manteniendo la ventana de $2W$ acotada y consistente.
    - Al finalizar, se busca decrementando desde `ans = t` el mayor valor para el cual `dp[W - (t - ans)] >= 0`, es decir, el mayor valor alcanzable que no supere `t`.

    Es una técnica avanzada y poco común, útil en problemas donde $t$ es grande pero los pesos individuales están acotados por un $W$ mucho menor, evitando así una DP ingenua de $O(n dot t)$ que sería demasiado lenta o consumiría demasiada memoria.
  ],
  source-file: "dp/subset_sum_bounded.cpp",
)