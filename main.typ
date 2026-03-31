#import "lib.typ": *

// Text font
#set text(
    size: 10pt,
    font: "Fira Sans",
)

// Code font
#set raw(
    lang: "cpp",    // Lenguaje por defecto
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

#show: reference.with(
    github-base: "https://github.com/sav1209/My-CP-Reference/blob/main/",
)

// Cover page
#page(
    columns: 1,
    footer: none,
)[
    #set align(center + horizon)

    #text(
        2.5em,
        weight: "bold",
    )[
        UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO
    ]\
    #text(
        2em, 
        weight: "medium",
        smallcaps[Facultad de Estudios Superiores Acatlán]
    )

    #v(1em)
    #grid(
        columns: 2,
        inset: (x: 0.5cm),
        image("escudos/escudo-unam.svg", width: 3cm),
        image("escudos/escudo-fesa-negro.jpg", width: 3cm)
    )

    #v(1em)
    #text(5em, fill: rgb(palette.red.hex))[#smallcaps[*Reference*]]\
    #v(0.5em)\
    #text(2em)[*Gatitas Tapabaños Nacatlán*]\
    #v(0.5em)\
    #text(1.5em)[by `sav1209`]

    Última actualización: #datetime.today().display()
]

#pagebreak()

// Title block

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