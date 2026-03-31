# Reference de Programación Competitiva

Una propuesta moderna y elegante para documentar mis notas de Programación Competitiva.

## 🎨 Sobre este Proyecto

Este proyecto utiliza **Typst** para crear un documento de referencia visualmente atractivo. El archivo principal (`lib.typ`) proporciona utilidades y funciones personalizadas que facilitan la presentación de código y conceptos algorítmicos.

### Funcionalidades Principales

- 📝 **Presentación de código elegante**: Tarjetas personalizadas para cada algoritmo
- 🎨 **Tema visual cohesivo**: Color palette Catppuccin con gradientes personalizados
- 🔗 **Enlaces automáticos a GitHub**: Conecta directamente con el código fuente
- 📐 **Análisis de complejidad**: Campos para mostrar complejidad de tiempo y espacio
- 📦 **Documentación estructurada**: Secciones organizadas por tema

### Paquetes Incluidos en `lib.typ`

| Paquete | Versión | Propósito |
|---------|---------|----------|
| `catppuccin` | 1.0.0 | Tema visual pastel (colores suavizados) |
| `theorion` | 0.3.3 | Entornos de teoremas y cajas personalizables |
| `codly` | 1.3.0 | Presentación de código con numeración y resaltado |
| `codly-languages` | 0.1.8 | Soporte para múltiples lenguajes de programación |

## 📘 Guía de Uso de `code-entry`

### ¿Qué es `code-entry`?

`code-entry` es una función personalizada que crea **tarjetas visuales** para presentar fragmentos de código junto con información sobre complejidad algorítmica. Cada tarjeta incluye:

- Un título descriptivo
- Información de complejidad de tiempo y espacio
- Una descripción opcional del algoritmo
- El código fuente con resaltado de sintaxis
- Un enlace a GitHub (opcional)

### Sintaxis Básica

```typst
#code-entry(
  title: "Nombre del algoritmo",
  source-file: "ruta/al/archivo.cpp",
  time: "O(n log n)",
  space: "O(n)",
)
```

### Parámetros

- **`title`** (string): Nombre descriptivo del algoritmo
  - Ejemplo: `"Algoritmo de Kadane"`, `"Búsqueda Binaria"`

- **`source-file`** (string): Ruta relativa al archivo de código
  - Ejemplo: `"data_structures/kadane.cpp"`
  - Si no se proporciona, puede usar código inline
  - Ruta relativa desde la raíz del proyecto

- **`time`** (string o contenido): Complejidad temporal
  - Ejemplos simples: `"O(n)"`, `"O(n log n)"`
  - Ejemplos avanzados (múltiples casos):
    ```typst
    time: [
      - O(n) para construcción
      - O(log n) para consultas
    ]
    ```

- **`space`** (string o contenido): Complejidad espacial
  - Misma sintaxis que `time`

- **`description`** (string o contenido): Descripción detallada del algoritmo
  - Se muestra en una sección separada en la tarjeta

- **`lang`** (string): Lenguaje de programación para resaltado
  - Default: `"cpp"`
  - Ejemplos: `"py"`, `"java"`, `"rust"`

- **`range`** (tupla): Rango de líneas a mostrar del archivo
  - Sintaxis: `range: (línea_inicio, línea_fin)`
  - Ayuda a mostrar solo la función relevante sin código extra
  - **Importante**: Las líneas son 1-indexed (comienzan en 1)
  - Ejemplo: `range: (6, 23)` muestra desde línea 6 a línea 23

- **`github-base`** (string): URL base para los enlaces a GitHub
  - Este parámetro es casi nunca necesario (se define globalmente)
  - Default: Se obtiene del contexto global establecido en `main.typ`
  - Solo usar si necesita sobrescribir el default

- **Código inline** (parámetro posicional): Código como string en lugar de archivo
  - Toma precedencia sobre `source-file`
  - Ejemplo:
    ````typst
    #code-entry(
      title: "Ejemplo simple",
      time: "O(1)",
    )[
        ```py
        print("Hello world!")
        ```
    ]
    ````

### Ejemplos Prácticos

#### Ejemplo 1: Algoritmo simple con archivo

```typst
#code-entry(
  title: "Algoritmo de Kadane",
  time: $O(n)$,
  space: $O(1)$,
  range: (6, 23),
  source-file: "data_structures/kadane.cpp",
  description: "Encuentra la suma máxima de un subarreglo"
)
```

**Resultado**: Una tarjeta que muestra:
- Título: "Algoritmo de Kadane"
- Complejidad: Tiempo O(n), Espacio O(1)
- Descripción
- Líneas 6-23 del archivo `kadane.cpp`
- Enlace a GitHub para ver el código completo

#### Ejemplo 2: Múltiple complejidad (con casos diferentes)

```typst
#code-entry(
  title: "Árbol de Segmentos",
  source-file: "data_structures/segment-tree.cpp",
  range: (6, 41),
  time: [
    - $O(n)$ para construcción
    - $O(log n)$ para consultas
    - $O(log n)$ para actualizaciones
  ]
)
```

**Resultado**: La sección de tiempo muestra múltiples líneas con diferentes complejidades

#### Ejemplo 3: Solo descripción (sin complejidad)

```typst
#code-entry(
  title: "Concepto: Suma de Prefijos",
  source-file: "utils/prefix_sum.cpp",
  description: "Técnica para responder consultas de suma en rangos en O(1) después de O(n) preprocesamiento"
)
```

### Características Visuales

Cada tarjeta `code-entry` incluye:

1. **Barra de acento** (3px): Gradiente de color que hace la tarjeta distintiva
2. **Encabezado**: Fondo suave con el título en negrita
3. **Secciones de metadatos**: Complejidad de tiempo y/o espacio (si se proporcionan)
4. **Sección descriptiva**: Texto adicional sobre el algoritmo (si se proporciona)
5. **Bloque de código**: Con numeración de líneas y resaltado de sintaxis
6. **Enlace a GitHub**: En el encabezado del código, redirige al archivo fuente

### Integración Global

En `main.typ`, se configura la base para los enlaces a GitHub:

```typst
#show: reference.with(
    github-base: "https://github.com/sav1209/My-CP-Reference/blob/main/",
)
```

Esto hace que todas las llamadas a `code-entry` con `source-file` automáticamente generen enlaces al repositorio.

### Estructura del Proyecto

```
lib.typ          # Define funciones y tema global (incluye code-entry)
main.typ         # Punto de entrada, incluye secciones
README.md        # Este archivo
data_structures/ # Archivos .cpp y section.typ
sorting_searching/
graphs/
number_theory/
combinatorics/
```

## 📚 Recursos de Referencia

## 📘 Libros
- *Guide to Competitive Programming* - Antti Laaksonen
- *Competitive Programming 4* -  Steven Halim, Felix Halim, Suhendry Effendy

## 🌐 Sitios web
- [USACO Guide](https://usaco.guide/)
- [Algorithms for Competitive Programming](https://cp-algorithms.com/)

## 🌟 Inpiraciones
- https://github.com/ecnerwala/icpc-book/blob/master/kactl.pdf
- https://github.com/bqi343/cp-notebook/blob/master/Implementations/kactl_color.pdf
- https://github.com/SJMA11723/Data-structures-and-algorithms
- https://github.com/JorgeIba/Reference
- https://github.com/mhunicken/icpc-team-notebook-el-vasito
- https://github.com/josecarlosmemo/summer-icpc-2022
- https://github.com/club-de-algoritmos/algorithms
- https://people.kth.se/~eliasrg/writeups/cheatsheet.pdf
- https://github.com/xavier-povill/pdf-icpc/blob/master/kactl.pdf
- https://ncduy0303.github.io/Competitive-Programming/
- https://github.com/helloproclub/competitive-programming-cheat-sheet?tab=readme-ov-file#11-c-solution-template
- https://dl.icdst.org/pdfs/files3/f27f274cd4c7d0689d21673146af430c.pdf
- https://github.com/jaehyunp/stanfordacm
- https://github.com/kth-competitive-programming/kactl
- https://github.com/ivangalbans/TeamReference/blob/master/reference.pdf
- https://github.com/BedirT/ACM-ICPC-Preparation
