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