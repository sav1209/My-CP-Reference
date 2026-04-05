#import "lib.typ": *
#import "@preview/zebra:0.1.0": qrcode

// ==========================================
//  CONFIGURACIÓN DE LA FUENTE PARA EL TEXTO
// ==========================================
#set text(
    size: 10pt,
    font: "Fira Sans",
)

// ===================================================
//  CONFIGURACIÓN DE LA FUENTE UTILIZADA EN EL CÓDIGO
// ===================================================
#set raw(
    lang: "cpp",    // Lenguaje por defecto para todo tipo de código (se pueden configurar otros lenguajes explicítamente).
    tab-size: 4,
)
// Fuente para código (bloques y línea).
#show raw: set text(font: "FiraCode Nerd Font", weight: "medium")
// Configura la fuente para que el código en línea (no bloques) aparezca en semibold (más grueso que en bloques).
#show raw.where(block: false): set text(weight: "semibold")

// ==========================================================
//  CONFIGURACIÓN DE LA FUENTE PARA LAS FÓRMULAS MATEMÁTICAS
// ==========================================================
#show math.equation: set text(font: "Fira Math")
#set math.cases(gap: 0.5em)


// ==============================================
//  CONFIGURACIÓN DE LOS METADATOS DEL DOCUMENTO
// ==============================================
#set document(
    title: "Reference",
    author: "sav1209",
)



// ==================================
//  APLICA LA PLANTILLA AL DOCUMENTO
// ==================================
#show: reference.with(
    // URL base de GitHub para que la plantilla pueda generar enlaces dentro del PDF a tu repositorio (Opcional).
    github-base: "https://github.com/sav1209/My-CP-Reference/blob/main/",
    
    // Si quieres que el PDF tenga colores tenga un estilo monocromatico descomenta la siguiente línea.
    // use-color: false,                
)

// =======================
//  TÍTULO PERSONALIZADA
// =======================
#align(center)[
    #stack(
        text(
            size: 50pt,
            weight: "black",
            fill: gradient.linear(
                rgb("#00084f"),
                rgb("#001e78"),
                rgb("#0034a6"),
                rgb("#0049d8"),
                rgb("#005eff")
            ),
            "REFERENCE",
        ),
        v(15pt),
        text(
            size: 15pt,
            fill: subtext0,
            weight: "semibold",
            smallcaps("Gatitas Tapabaños Nacatlán")
        ),
        v(5pt),
        text(
            size: 10pt,
            fill: subtext0
        )[
            Última actualización: #datetime.today().display()
        ],
        v(0.75cm),
        link(
            "https://github.com/sav1209/My-CP-Reference",
            qrcode("https://github.com/sav1209/My-CP-Reference")
        ),
        v(0.75cm),
        image("assets/images/shrek.png", width: 70%)
    )
]

// =====================
//  TABLA DE CONTENIDOS
// =====================
#show outline.entry.where(level: 1): strong
#outline()

// =====================
//  SECCIONES TEMATICAS
// =====================
#include "setup/section.typ"
#include "data_structures/section.typ"
#include "sorting_searching/section.typ"
#include "bit_manipulation/section.typ"
#include "graphs/section.typ"
#include "number_theory/section.typ"
#include "combinatorics/section.typ"
#include "utilities/section.typ"