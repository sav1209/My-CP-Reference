#import "../lib.typ": *
= Strings
== Trie
#code-entry(
  title: "Estructura",
  tag: "structure",
  source-file: "strings/trie.cpp"
)
#code-entry(
  title: "Agregar una cadena",
  tag: "add_string",
  source-file: "strings/trie.cpp"
)

== Trie UFMG
#code-entry(
  time: $"insert": O(|s| dot sigma) quad "erase, find, count_pref": O(|s|)$,
  space: $O(|s| dot sigma)$,
  description: [
    Estructura de árbol de prefijos (*Trie*) genérica, parametrizable para cualquier alfabeto: `trie T()` construye una trie para el alfabeto de letras minúsculas por defecto, mientras que `trie T(sigma, norm)` permite especificar el tamaño del alfabeto y el carácter mínimo (`norm`), útil para alfabetos como dígitos, mayúsculas, o binarios.

    Funciones principales:
    - `insert(s)`: inserta la cadena `s` en la trie en $O(|s| dot sigma)$, creando nuevos nodos según sea necesario y llevando en `pref[x]` la cantidad de cadenas insertadas que pasan por el nodo `x` (incluyendo la raíz, que cuenta el total de inserciones). Marca `end[x]` en el nodo final para indicar que ahí termina una cadena completa (permitiendo múltiples inserciones de la misma cadena).
    - `erase(s)`: elimina una ocurrencia de `s` de la trie en $O(|s|)$, decrementando `pref` a lo largo del camino y eliminando la arista (`nxt = 0`) cuando un nodo deja de tener cadenas pasando por él, liberando efectivamente esa rama.
    - `find(s)`: retorna el índice del nodo correspondiente al final de `s` en la trie, o $-1$ si `s` no existe como camino completo desde la raíz. Complejidad $O(|s|)$.
    - `count_pref(s)`: retorna la cantidad de cadenas almacenadas en la trie que tienen a `s` como prefijo, aprovechando el contador `pref` ya mantenido en cada nodo. Complejidad $O(|s|)$.

    Es la base para estructuras más avanzadas como *Aho-Corasick*, *XOR Trie* (para consultas de máximo XOR), o problemas de conteo de prefijos/sufijos comunes entre conjuntos de cadenas.
  ],
  source-file: "strings/trie_ufmg.cpp",
)

== String hashing
#code-entry(
  title: "hash-doble",
  tag: "hash",
  source-file: "strings/Hash_Doble.cpp"
)
== KMP — Knuth-Morris-Pratt
#code-entry(
  title: "KMP — Knuth-Morris-Pratt",
  time: $O(n + m)$,
  space: $O(m)$,
  description: "Cuenta ocurrencias de pat en txt. buildPhi construye el arreglo de fallos: phi[j] = prefijo propio más largo de pat[0..j] que es sufijo. Al fallar retrocede a phi[i-1] en lugar de reiniciar.",
  lang: "cpp",
  tag: "kmp",
  source-file: "strings/kmp.cpp",
)
#code-entry(
  title: "Bordes de un string",
  time: $O(n)$,
  space: $O(n)$,
  description: "Dado phi de un string, devuelve todas las longitudes de bordes no triviales (prefijo = sufijo, distinto del string completo), de mayor a menor. Se obtiene siguiendo la cadena phi[n-1], phi[phi[n-1]-1], ... hasta llegar a 0.",
  lang: "cpp",
  tag: "kmp-borders",
  source-file: "strings/Borders_KMP.cpp",
)
#code-entry(
  title: "Conteo de ocurrencias de cada prefijo",
  time: $O(n)$,
  space: $O(n)$,
  description: "Dado phi de un string, cnt[L] = cuántas veces aparece el prefijo de longitud L como substring dentro de todo el string (incluyendo su propia ocurrencia como prefijo). Se calcula acumulando conteos por valor de phi y propagándolos hacia abajo en la cadena de bordes.",
  lang: "cpp",
  tag: "kmp-prefix-count",
  source-file: "strings/Occurrences_KMP.cpp",
)
