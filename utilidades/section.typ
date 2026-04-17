#import "../lib.typ": *

#set page(columns: 1)

= Utilidades

== Funciones útiles para strings en C++

#codly(enabled: false)
#table(
  columns: (auto, auto, 1fr, auto),
  align: (left+horizon, center+horizon, horizon+left, horizon+left),
  stroke: 1pt+crust,
  [*Sintaxis*], [*Complejidad*], [*Descripción*], [*Ejemplos*],
[
```
s.substr(pos, len)
```
],
[$ O(n) $],
[
  Extrae y retorna una subcadena que inicia en la posición `pos` con longitud `len`. Si `len` se omite, va hasta el final. Fundamental para extraer tokens y ventanas deslizantes.
],[
```
string s = "hola_mundo";
string a = s.substr(0, 4);   // "hola"
string b = s.substr(5);      // "mundo"
string c = s.substr(2, 3);   // "la_"
```
],

[
```
s.find(str, pos)
s.rfind(str, pos)
```
],
[$ O(n m) $],
[
  Busca la primera (`find`) o última (`rfind`) ocurrencia de `str` en `s` a partir de `pos`. Retorna `string::npos` si no existe.
], [
```
string s = "abcabcabc";
size_t f = s.find("bc");    // 1
size_t rf = s.rfind("bc");  // 7
if (s.find("xyz") == string::npos)
    cout << "no encontrado";
```
],

[
```
s.replace(pos, len, str)
```
],
[$ O(n) $],
[
  Reemplaza `len` caracteres desde `pos` con la cadena `str`.
], [
```
string s = "hola mundo";
s.replace(5, 5, "C++");    // "hola C++"
s.replace(0, 4, "adios");  // "adios C++"
```
],

[
```
s.erase(pos, len)
s.erase(iterator)
```
],
[$ O(n) $],
[
  Elimina `len` caracteres desde `pos`, o el carácter apuntado por un `iterator`. Muy útil para remover caracteres/subcadenas no deseados durante el procesamiento.
], [
```
string s = "hola mundo";
s.erase(4, 6);   // "hola"

string t = "a1b2c3";
t.erase(remove_if(all(t), ::isdigit), t.end());
// "abc"
```
],

[
```
s.insert(pos, str)
s.insert(pos, n, ch)
```
],
[$ O(n) $],
[
  Inserta `str` en la posición `pos`, desplazando el resto. También puede insertar `n` copias de un carácter `ch`.
], [
```
string s = "holamundo";
s.insert(4, " ");    // "hola mundo"

string t = "abc";
t.insert(1, 3, '*');  // "a***bc"
```
],

[
```
s.find_first_of(chars, pos)
s.find_last_of(chars, pos)
```
],
[$ O(n m) $],
[
  Encuentra la posición del primer o último carácter de `s` que pertenezca al conjunto `chars`. Ideal para parsing de múltiples delimitadores en una sola llamada.
], [
```
string s = "hola,mundo;cpp";
size_t p1 = s.find_first_of(";,"); // 4 (',')
size_t p2 = s.find_last_of(";,");  // 9 (';')
```
],

[
```
s.compare(str)
s.compare(pos, len, str)
```
],
[$ O(n) $],
[
  Compara lexicográficamente. Retorna `0` si son iguales, `< 0` si `s` < `str` y `> 0` si `s` > `str`. Permite comparar subcadenas sin extraerlas, evitando allocaciones innecesarias.
], [
```
"abc".compare("abc") == 0;  // igual
"abc".compare("abd") < 0;   // menor

string s = "hola mundo";
s.compare(5, 5, "mundo") == 0;  // true
```
],

[
```
count(all(s), ch)
```
],
[$ O(n) $],
[
  Cuenta las ocurrencias de un carácter `ch` en el `string`.
], [
```
string s = "banana";
int a = count(all(s), 'a');  // 3
int n = count(all(s), 'n');  // 2
int b = count(all(s), 'b');  // 1
```
],

[
```
s.erase(unique(all(s)), s.end())
```
],
[$ O(n) $],
[
  Elimina caracteres duplicados consecutivos. Si se aplica sobre un string ordenado, elimina todos los duplicados.
], [
```
string s = "aabbccddee";
s.erase(unique(all(s)), s.end());
// "abcde"

// Todos los duplicados (con sort previo)
string t = "bcaabbcc";
sort(all(t));   // "aabbbbcc"
t.erase(unique(all(t)), t.end()); // "abc"
```
],

[
```
next_permutation(all(s))
```
],
[$ O(n) $],
[
  Transforma `s` en su siguiente permutación lexicográfica. Retorna `false` al volver a la primera permutación.
], [
```
string s = "abc";
do {
    cout << s << "\n";
} while (next_permutation(all(s)));
// abc, acb, bac, bca, cab, cba
```
],

[
```
isalpha(c)
isdigit(c)
isalnum(c)
```
],
[$ O(1) $],
[
  Verifican si un carácter `c` es letra, dígito o alfanumérico respectivamente.
], [
```
for (char c : "hallo mundo") {
    if (isalpha(c))  cout << "letra";
    if (isdigit(c))  cout << "digito";
    if (isalnum(c))  cout << "alfanum";
    if (isspace(c))  cout << "espacio";
}
```
],
)

== Funciones útiles de `<algorithm>`

#table(
  columns: (auto, auto, 1fr, auto),
  align: (left+horizon, center+horizon, horizon+left, horizon+left),
  stroke: 1pt+crust,
  [*Sintaxis*], [*Complejidad*], [*Descripción*], [*Ejemplos*],

[
```
lower_bound(begin, end, val)
```
],
[$ O(log n) $],
[
  Retorna iterador al primer elemento `>= val`. Si todos los elementos son `< val`, retorna `end()`.
], [
```
auto it = lower_bound(all(v), 10);
if (it == v.end())
    cout << "No hay elemento >= 10";
```
],

[
```
upper_bound(begin, end, val)
```
],
[$ O(log n) $],
[
  Retorna iterador al primer elemento `> val`. Si todos los elementos son `<= val`, retorna `end()`.
], [
```
auto it = upper_bound(all(v), 9);
int cnt = it - lower_bound(all(v), 9);
// cuenta iguales a 9
```
],

[
```
binary_search(begin, end, val)
```
],
[$ O(log n) $],
[
  Retorna `true` si `val` esta en el rango ordenado.
], [
```
if (binary_search(all(v), 5))
    cout << "Existe";
```
],

[
```
next_permutation(begin, end)
```
],
[$ O(n) $],
[
  Genera la siguiente permutación lexicográfica. Caso especial: retorna `false` y deja el rango en la primera permutación (la ordenada) si ya era la última.
], [
```
vector<int> v = {3,2,1};
bool hay = next_permutation(all(v));
// hay == false, v = {1,2,3}
```
],

[
```
max_element(begin, end)
```
],
[$ O(n) $],
[
  Retorna iterador al maximo. Para varios maximos, retorna el primero.
], [
```
auto it = max_element(all(v));
if (it != v.end())
    cout << *it;
```
],

[
```
min_element(begin, end)
```
],
[$ O(n) $],
[
  Retorna iterador al minimo. Para varios mínimos, retorna el primero.
], [
```
int min_val = *min_element(all(v));
// asumiendo no vacio
```
],

[
```
minmax_element(begin, end)
```
],
[$ O(n) $],
[
  Retorna `pair<minIt, maxIt>`. Caso especial: con elementos iguales, `min` y `max` pueden apuntar al mismo elemento. Rango vacio -> ambos `end()`.
], [
```
auto [mn, mx] = minmax_element(all(v));
```
],

[
```
count(begin, end, val)
```
],
[$ O(n) $],
[
  Cuenta ocurrencias de `val`.
], [
```
int cnt = count(all(v), 2);
// puede ser 0
```
],

[
```
count_if(begin, end, pred)
```
],
[$ O(n) $],
[
  Cuenta elementos que cumplen `pred`.
], [
```
int pares = count_if(all(v), [](int x) {
    return x % 2 == 0;
});
```
],

[
```
find(begin, end, val)
```
],
[$ O(n) $],
[
  Busca la primera ocurrencia de `val`. Caso especial: si no se encuentra, retorna `end()`.
], [
```
auto it = find(all(v), 3);
if (it != v.end())
    cout << "Encontrado en indice " << it - v.begin();
```
],

[
```
rotate(begin, new_begin, end)
```
],
[$ O(n) $],
[
  Rota de forma que `new_begin` pasa a ser el primer elemento. Caso especial: Si `new_begin == begin` o `new_begin == end`, no hay rotación efectiva.
], [
```
vector<int> v = {1,2,3,4,5};
rotate(all(v), v.begin()+2);
// {3,4,5,1,2}
```
],

[
```
unique(begin, end)
```
],
[$ O(n) $],
[
  "Compacta" elementos duplicados consecutivos moviendo las primeras ocurrencias al frente. Caso especial: No cambia el tamaño del contenedor. Devuelve iterador al nuevo final lógico; se debe usar `erase` para eliminar los sobrantes.
], [
```
vector<int> v = {1,1,2,2,2,3};
v.erase(unique(all(v)), v.end());
// {1,2,3}
```
],

[
```
merge(b1, e1, b2, e2, out)
```
],
[$ O(n+m) $],
[
  Fusiona dos rangos ordenados en uno solo. Caso especial: Si los rangos de entrada no están ordenados, el comportamiento es indefinido.
], [
```
vector<int> a = {1,3,5}, b = {2,4,6};
vector<int> c(6);
merge(all(a), all(b), c.begin());
// {1,2,3,4,5,6}
```
],

[
```
partition(begin, end, pred)
```
],
[$ O(n) $],
[
  Reordena: primero los que cumplen `pred`, luego el resto. Caso especial: No garantiza el orden relativo dentro de cada grupo. Usar `stable_partition` si se necesita estabilidad.
], [
```
auto it = partition(all(v), [](int x) {
    return x % 2 == 0;
});
// pares al frente, impares al final
```
],
)
