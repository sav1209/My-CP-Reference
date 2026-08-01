#let funciones-algorithm = (
  (
    sintaxis: `fill(all(v), x)`,
    complejidad: $O(n)$,
    descripcion: [Rellena `v` con `x`],
    ejemplo: []
  ), (
    sintaxis: [`binary_search(begin, end, val)`],
    complejidad: $O(log n)$,
    descripcion: [Retorna `true` si `val` esta en el rango ordenado.],
    ejemplo: [
      ```
      if (binary_search(all(v), 5))
      cout << "Existe";
      ```
    ],
  ), (
    sintaxis: `next_permutation(begin, end)`,
    complejidad: $O(n)$,
    descripcion: [Genera la siguiente permutación lexicográfica. Caso especial: retorna `false` y deja el rango en la primera permutación (la ordenada) si ya era la última.],
    ejemplo: [
      ```
      vector<int> v = {3,2,1};
      bool hay = next_permutation(all(v));
      // hay == false, v = {1,2,3}
      ```
    ]
  ), (
    sintaxis: `max_element(begin, end)`,
    complejidad: $O(n)$,
    descripcion: [Retorna iterador al maximo. Para varios maximos, retorna el primero.],
    ejemplo: [
      ```
      auto it = max_element(all(v));
      if (it != v.end())
          cout << *it;
      ```
    ]
  ), (
    sintaxis: `min_element(begin, end)`,
    complejidad: $O(n)$,
    descripcion: [Retorna iterador al minimo. Para varios mínimos, retorna el primero.],
    ejemplo: [
      ```
      int min_val = *min_element(all(v));
      // asumiendo no vacio
      ```
    ]
  ), (
    sintaxis: `minmax_element(begin, end)`,
    complejidad: $O(n)$,
    descripcion: [Retorna `pair<minIt, maxIt>`. Caso especial: con elementos iguales, `min` y `max` pueden apuntar al mismo elemento. Rango vacio -> ambos `end()`.],
    ejemplo: [
      ```
      auto [mn, mx] = minmax_element(all(v));
      ```
    ]
  ), (
    sintaxis: `count(begin, end, val)`,
    complejidad: $O(n)$,
    descripcion: [Cuenta ocurrencias de `val`.],
    ejemplo: [
      ```
      int cnt = count(all(v), 2);
      // puede ser 0
      ```
    ]
  ), (
    sintaxis: `count_if(begin, end, pred)`,
    complejidad: $O(n)$,
    descripcion: [Cuenta elementos que cumplen `pred`.],
    ejemplo: [
      ```
      int pares = count_if(all(v), [](int x) {
          return x % 2 == 0;
      });
      ```
    ]
  ), (
    sintaxis: `find(begin, end, val)`,
    complejidad: $O(n)$,
    descripcion: [Retorna un iterador para la primera ocurrencia del elemento `x` en `v`, o `v.end()` si no existe],
    ejemplo: [
      ```
      auto it = find(all(v), 3);
      if (it != v.end())
          cout << "Encontrado en indice " << it - v.begin();
      ```
    ]
  ), (
    sintaxis: `rotate(begin, new_begin, end)`,
    complejidad: $O(n)$,
    descripcion: [Rota de forma que `new_begin` pasa a ser el primer elemento. Caso especial: Si `new_begin == begin` o `new_begin == end`, no hay rotación efectiva.],
    ejemplo: []
  ), (
    sintaxis: `unique(begin, end)`,
    complejidad: $O(n)$,
    descripcion: ["Compacta" elementos duplicados consecutivos moviendo las primeras ocurrencias al frente. Caso especial: No cambia el tamaño del contenedor. Devuelve iterador al nuevo final lógico; se debe usar `erase` para eliminar los sobrantes.],
    ejemplo: [
      ```
      vector<int> v = {1,1,2,2,2,3};
      v.erase(unique(all(v)), v.end());
      // {1,2,3}
      ```
    ]
  ), (
    sintaxis: `merge(b1, e1, b2, e2, out)`,
    complejidad: $O(n+m)$,
    descripcion: [Fusiona dos rangos ordenados en uno solo. Caso especial: Si los rangos de entrada no están ordenados, el comportamiento es indefinido.],
    ejemplo: [
      ```
      vector<int> a = {1,3,5}, b = {2,4,6};
      vector<int> c(6);
      merge(all(a), all(b), c.begin());
      // {1,2,3,4,5,6}
      ```
    ]
  ), (
    sintaxis: `partition(begin, end, pred)`,
    complejidad: $O(n)$,
    descripcion: [Reordena: primero los que cumplen `pred`, luego el resto. Caso especial: No garantiza el orden relativo dentro de cada grupo. Usar `stable_partition` si se necesita estabilidad.],
    ejemplo: [
      ```
      auto it = partition(all(v), [](int x) {
          return x % 2 == 0;
      });
      // pares al frente, impares al final
      ```
    ]
  )
)