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
