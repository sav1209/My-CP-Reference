#import "../lib.typ": *

#set math.frac(style: "horizontal")

// Función para mostrar lista de funciones con sintaxis, complejidad, descripción y ejemplo.
#let show-list(funciones) = {
  codly-disable()

  terms(
    ..for f in funciones {
      (terms.item[#f.sintaxis -- #f.complejidad][
        #f.descripcion
        #if f.ejemplo != [] [
          #f.ejemplo
        ]
      ], )
    }
  )
}


= C++

== Configuración

- *Imprimir con $bold(n)$ decimales:* `cout << fixed << setprecision(n);`

=== Compilación
#code-entry(
    lang: "bash",
    source-file: "cpp/compilation.sh"
)

=== Plantilla
#code-entry(
    source-file: "cpp/template.h",
)



== STL (Standard Template Library)

=== Vector
/ `v.insert(it, x)` -- $O(n)$: Inserta `x` en la posición apuntada por el iterador `it`
/ `v.erase(it)` -- $O(n)$: Remueve el elemento apuntado por el iterador `it`
/ `v.erase(it1, it2)` -- $O(n)$: Remueve los valores en el intervalo `[it1, it2)` de iteradores

=== Multiset
En un multiset, `erase` remueve _todas_ las copias de un valor, y `count` devuelve el número de copias de un valor.
/ Remover una solo ocurrencia de un valor x: `s.erase(s.find(x))`

Las funciones `count` y `erase` tienen un factor adicional de $O(k)$ donde $k$ es el número de elementos contados/eliminados. En particular, _no_ es eficiente contar el número de copias de un valor en un multiset usando la función `count`.

=== Map
/ `m.erase(key)` -- $O(log n)$: Remueve la clave `key` del mapa

=== Priority Queue
En la cola de prioridad por defecto el mayor elemento es el primero en salir.

/ `pq.push(x)` -- $O(log n)$: Agrega `x` a la cola de prioridad
/ `pq.pop()` -- $O(log n)$: Remueve el mayor elemento de la cola de prioridad
/ `pq.top()` -- $O(1)$: Devuelve el mayor elemento de la cola de prioridad
/ `priority_queue<int, vector<int>, greater<int>> pq`: Cola de prioridad en la que el elemento más pequeño es el primero en salir

Si solo necesitamos encontrar o eliminar eficientemente el elemento mínimo o máximo, es buena idea usar una cola de prioridad en lugar de un set o multiset.

=== Deque
Es un arreglo dinámico que puede manipular eficientemente ambos extremos de la estructura.
/ `d.push_back(x)` -- $O(1)$: Agrega `x` al final
/ `d.push_front(x)` -- $O(1)$: Agrega `x` al inicio
/ `d.pop_back()` -- $O(1)$: Remueve el elemento del final
/ `d.pop_front()` -- $O(1)$: Remueve el elemento del inicio

=== Bitset
Sirve para representar máscaras de bits cuando un entero no es suficiente. Posee operaciones optimizadas por el procesador.
/ `bitset<N> a`  -- $O(1)$: Crea un bitset de tamaño `N` (`N` debe ser constante)
/ `a[i]` -- $O(1)$: Retorna el valor del bit en la posición `i`
/ `a.count()` -- $O(N/w)$: Retorna el número de bits con 1
/ `a.size()` -- $O(1)$: Retorna el tamaño del bitset
/ `a.set(i)` -- $O(1)$: Pone el bit en la posición `i` a 1
/ `a.set()` -- $O(N/w)$: Pone todos los bits a 1
/ `a.reset(i)` -- $O(1)$: Pone el bit en la posición `i` a 0
/ `a.reset()` -- $O(N/w)$: Pone todos los bits a 0
/ `a.flip(i)` -- $O(1)$: Invierte el bit en la posición `i`
/ `a.flip()` -- $O(N/w)$: Invierte todos los bits
/ `a.to_ullong()` -- $O(N/w)$: Retorna el valor del bitset como un entero sin signo (si el tamaño del bitset es mayor al número de bits de un entero, solo se consideran los bits menos significativos)
/ Imprimir un entero como binario: `cout << bitset<8>(mask) << "\n";`

El bitset también soporta operaciones como: `&`, `|`, `^`, `~`, `<<`, `>>`, entre otras

*Obs:* $w$ es el tamaño de palabra del procesador, en general 32 o 64 bits.



== Funciones para strings

#import "strings.typ": funciones-strings
#show-list(funciones-strings)



== Funciones de `<algorithm>`

#import "algorithm.typ": funciones-algorithm
#show-list(funciones-algorithm)



== Otras funciones útiles
/ `round(x)` -- $O(1)$: Retorna el entero más próximo a `x`



== Constantes

#align(center)[
  #set math.frac(style: "horizontal")
  #table(
    columns: 3,
    [*Constante*],  [*Nombre*],   [*Valor aproximado*],
    $pi$,           `M_PI`,       $3.141592 dots.h$,
    $pi/2$,         `M_PI_2`,     $1.570796 dots.h$,
    $pi/4$,         `M_PI_4`,     $0.785398 dots.h$,
    $1/pi$,         `M_1_PI`,     $0.318309 dots.h$,
    $2/pi$,         `M_2_PI`,     $0.636619 dots.h$,
    $2/sqrt(pi)$,   `M_2_SQRTPI`, $1.128379 dots.h$,
    $sqrt(2)$,      `M_SQRT2`,    $1.414213 dots.h$,
    $1/sqrt(2)$,    `M_SQRT1_2`,  $0.707106 dots.h$,
    $e$,            `M_E`,        $2.718281 dots.h$,
    $log_(2) e$,    `M_LOG2E`,    $1.442695 dots.h$,
    $log_(10) e$,   `M_LOG10E`,   $0.434294 dots.h$,
    $ln 2$,         `M_LN2`,      $0.693147 dots.h$,
    $ln 10$,        `M_LN10`,     $2.302585 dots.h$,
  )
]