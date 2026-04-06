# Reference de Programacion Competitiva

Notas de Programacion Competitiva utilizadas para competencias estilo ICPC generado con Typst.
Incluye una plantilla visual reutilizable y secciones por tema con codigo.

## Vision General

Este repositorio esta centrado en dos archivos principales:

- main.typ: punto de entrada del documento, configuracion global de fuentes y secciones.
- lib.typ: plantilla reutilizable, incluyendo reference y code-entry.

## Caracteristicas Actuales

- Tarjetas de codigo con code-entry.
- Integracion con codly para resaltado y configuración de código.
- Enlaces a GitHub para archivos fuente (configurable global o por tarjeta).
- Soporte de tema con color o modo monocromatico.

## Dependencias de Typst

| Paquete | Version | Uso |
|---|---|---|
| catppuccin | 1.0.0 | Tema visual base |
| theorion | 0.3.3 | Cajas y entornos de apoyo |
| codly | 1.3.0 | Render de bloques de codigo |
| codly-languages | 0.1.8 | Lenguajes para codly |
| zebra | 0.1.0 | Generacion de QR |

## Guia para Usar el Proyecto

Las formas mas faciles de usar este proyecto son las siguientes:

### Opcion 1: typst.app

1. Descarga este repositorio en tu maquina.
2. Crea un proyecto en https://typst.app/.
3. Sube los archivos del repositorio.
4. Abre main.typ y compila.

### Opcion 2: GitHub Codespaces + Tinymist

Puedes abrir un Codespace con un clic usando el boton "Open in GitHub Codespaces" al inicio de este README.

1. Abre el repositorio en GitHub y crea un Codespace.
2. En la terminal del Codespace instala Typst con:
```bash
curl -fsSL https://install.typst.community/install.sh | sh
```

3. Verifica la instalacion:

```bash
typst --version
```

Repositorio del script de instalacion:
https://github.com/typst-community/typst-install

4. Instala Tinymist para facilitar la edicion en VS Code/Codespaces.

Tinymist es una herramienta de apoyo (LSP) para Typst: mejora la experiencia de edicion, pero el motor que compila el proyecto es Typst CLI.



## Guia de code-entry

code-entry crea una tarjeta superior y un bloque de codigo debajo (todos los paramétros son opcionales).

```typ
#code-entry(
  source-file: "",
  title: "",
  time: "",
  space: "",
  description: "",
  lang: "cpp",
  github-base: none,
  range: (),
  ..args,
)
```

### Comportamiento

- Si alguno de los parámetros se omite, no se coloca en la card.
- La accent-bar siempre se mantiene.
- `time` y `space` son independientes.
- Si se pasa codigo inline por `..args`, tiene prioridad sobre source-file.
- Si hay `source-file` y existe `github-base` (local o global), se agrega link en el header del bloque de codigo.
- `range` renderiza únicamente el rango de líneas ingresado (indexado en 1).

### Ejemplo 1: Con titulo y archivo

```typ
#code-entry(
  title: "Kadane's algorithm",
  time: $O(n)$,
  range: (6, 23),
  source-file: "data_structures/kadane.cpp",
)
```

### Ejemplo 2: Sin titulo

```typst
#code-entry(
  source-file: "graphs/topological_sort_bfs.cpp",
  time: $O(n + m)$,
  description: "Version BFS (Kahn)",
)
```

En este caso, la tarjeta conserva la barra de acento superior, pero no muestra fila de titulo.

### Ejemplo 3: Codigo inline en vez de source-file

````typ
#code-entry(
  title: "Snippet inline",
  time: $O(1)$,
)[
```py
print("hello")
```
]
````

## Configuracion Global con reference

main.typ aplica la plantilla asi:

```typst
#show: reference.with(
  github-base: "https://github.com/sav1209/My-CP-Reference/blob/main/",
  // use-color: false,
)
```

- github-base define el prefijo para links automaticos de code-entry.
- use-color permite alternar entre tema a color y monocromatico.

## Recursos

### Libros

- Guide to Competitive Programming - Antti Laaksonen
- Competitive Programming 4 - Steven Halim, Felix Halim, Suhendry Effendy

### Sitios

- https://usaco.guide/
- https://cp-algorithms.com/

### Inspiraciones

- https://github.com/ecnerwala/icpc-book
- https://github.com/bqi343/cp-notebook/blob/master/Implementations/kactl_color.pdf
- https://github.com/alaneos777/reference
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
