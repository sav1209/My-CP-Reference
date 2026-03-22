// FUNCIONALIDAD
// TODO: Agregar archivos de los algoritmos de forma completa con aplicación básica.
// TODO: Agregar configuración para solo colocar ciertas líneas de un algortimo.
// TODO: Cada algoritmo debe tener un enlace directo a su ubicación en GitHub para copiar y pegar rápidamente desde la versión digital con QR.
// CONTENIDO
// TODO: Agregar el código para reconstruir ciclos con Topological Sort
// TODO: Agregar sección con formúlas/sucesiones matemáticas útiles
// TODO: Agregar sección de árboles (bases, LCA)
// TODO: Agregar sección de DP con aplicaciones básicas
// TODO: Agregar sección de matemáticas con fórmulas útiles y sección de recurrencias
// TODO: Revisar página 'Bit Manipulation' de cp-algorithms y agregar lo que falte: https://cp-algorithms.com/algebra/bit-manipulation.html
// TODO: Agregar Fenwick tree (BIT)
// TODO: Agregar triángulo de pascal
// TODO: Agregar desarreglos
// TODO: Agregar una sección de utilidades de Python
// TODO: Pasar bitset para acá con una mejor explicación de utilidades

#import "lib.typ": *

// Text font
#set text(
    size: 10pt,
    font: "Fira Sans",
)

// Code font
#set raw(
    lang: "cpp",
    tab-size: 4,
)
#show raw: set text(font: "FiraCode Nerd Font", weight: "medium")
#show raw.where(block: false): set text(weight: "semibold")

// Math font
#show math.equation: set text(font: "Fira Math")
#set math.cases(gap: 0.5em)

// Template
#set document(
    title: "Reference",
    author: "sav1209",
)
#show: template

// Title block
#align(center+horizon)[
    #text(5em, fill: rgb(palette.red.hex))[#smallcaps[*Reference*]]\
    #text(1.5em)[by `sav1209`]
]

// Outline
#show outline.entry.where(level: 1): strong
#outline()

// Sections
#include "setup/section.typ"
#include "data_structures/section.typ"
#include "sorting_searching/section.typ"
#include "bit_manipulation/section.typ"
#include "graphs/section.typ"

#include "number_theory/section.typ"
#include "combinatorics/section.typ"

#include "utilities/section.typ"