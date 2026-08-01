
#let funciones-strings = (
  (
    sintaxis: [`s.substr(i, len)`],
    complejidad: $O(n)$,
    descripcion: [Retorna el substring que inicia en `i` y tiene longitud `len`. Si `len` se omite va hasta el final.],
    ejemplo: [],
  ), (
    sintaxis: [`s.find(str, pos)`, `s.rfind(str, pos)`],
    complejidad: $O(n m)$,
    descripcion: [Busca la primera (`find`) o última (`rfind`) ocurrencia de `str` en `s` a partir de `pos`. Retorna `string::npos` si no existe.],
    ejemplo: [
      ```
      s = "abcabcabc";
      s.find("bc");  // 1
      s.rfind("bc"); // 7
      ```
    ],
  ), (
    sintaxis: [`s.replace(pos, len, str)`],
    complejidad: $O(n)$,
    descripcion: [Reemplaza `len` caracteres desde `pos` con la cadena `str`.],
    ejemplo: [
      ```
      s = "hola mundo";
      s.replace(5, 5, "C++");    // "hola C++"
      s.replace(0, 4, "adios");  // "adios C++"
      ```
    ],
  ), (
    sintaxis: [`s.erase(pos, len)`, `s.erase(iterator)`],
    complejidad: $O(n)$,
    descripcion: [Elimina `len` caracteres desde `pos`, o el carácter apuntado por un `iterator`. Muy útil para remover caracteres/subcadenas no deseados durante el procesamiento.],
    ejemplo: [
      ```
      s = "hola mundo";
      s.erase(4, 6);   // "hola"
      ```
    ],
  ), (
    sintaxis: [`s.insert(pos, str)`, `s.insert(pos, n, ch)`],
    complejidad: $O(n)$,
    descripcion: [Inserta `str` en la posición `pos`, desplazando el resto. También puede insertar `n` copias de un carácter `ch`.],
    ejemplo: [
      ```
      s = "holamundo";
      s.insert(4, " ");    // "hola mundo"

      t = "abc";
      t.insert(1, 3, '*'); // "a***bc"
      ```
    ],
  ), (
    sintaxis: [`s.find_first_of(chars, pos)`, `s.find_last_of(chars, pos)`],
    complejidad: $O(n m)$,
    descripcion: [Encuentra la posición del primer o último carácter de `s` que pertenezca al conjunto `chars`. Ideal para parsing de múltiples delimitadores en una sola llamada.],
    ejemplo: [
      ```
      s = "hola,mundo;cpp";
      s.find_first_of(";,"); // 4 (',')
      s.find_last_of(";,");  // 9 (';')
      ```
    ],
  ), (
    sintaxis: [`s.compare(str)`, `s.compare(pos, len, str)`],
    complejidad: $O(n)$,
    descripcion: [Compara lexicográficamente. Retorna `0` si son iguales, `< 0` si `s` < `str` y `> 0` si `s` > `str`. Permite comparar subcadenas sin extraerlas, evitando allocaciones innecesarias.],
    ejemplo: [
      ```
      "abc".compare("abc") == 0;  // igual
      "abc".compare("abd") < 0;   // menor

      s = "hola mundo";
      s.compare(5, 5, "mundo") == 0;  // true
      ```
    ],
  ), (
    sintaxis: [`count(all(s), ch)`],
    complejidad: $O(n)$,
    descripcion: [Cuenta las ocurrencias de un carácter `ch` en el `string`.],
    ejemplo: [
      ```
      s = "banana";
      count(all(s), 'a');  // 3
      count(all(s), 'n');  // 2
      count(all(s), 'b');  // 1
      ```
    ],
  ), (
    sintaxis: [`isalpha(c)`, `isdigit(c)`, `isalnum(c)`, `isspace(c)`],
    complejidad: $O(1)$,
    descripcion: [Verifican si un carácter `c` es letra, dígito, alfanumérico o espacio respectivamente.],
    ejemplo: []
  ), (
    sintaxis: [`s.erase(unique(all(s)), s.end())`],
    complejidad: $O(n)$,
    descripcion: [Elimina caracteres duplicados consecutivos. Si se aplica sobre un string ordenado, elimina todos los duplicados.],
    ejemplo: [
      ```
      s = "aabbccddee";
      s.erase(unique(all(s)), s.end());
      // "abcde"

      // Todos los duplicados (con sort previo)
      t = "bcaabbcc";
      sort(all(t));   // "aabbbbcc"
      t.erase(unique(all(t)), t.end()); // "abc"
      ```
    ]
  )
)
