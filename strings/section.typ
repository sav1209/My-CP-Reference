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

#code-entry(
  title: "hash-doble",
  tag: "hash",
  source-file: "strings/Hash_Doble.cpp"
)

#code-entry(
  title: "KMP — Knuth-Morris-Pratt",
  time: $O(n + m)$,
  space: $O(m)$,
  description: "Cuenta ocurrencias de pat en txt. buildPhi construye el arreglo de fallos: phi[j] = prefijo propio más largo de pat[0..j] que es sufijo. Al fallar retrocede a phi[i-1] en lugar de reiniciar.",
  source-file: "strings/kmp.cpp",
  lang: "cpp",
  tag: "kmp",
  source-file: "kmp.cpp"
)

