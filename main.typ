#import "lib.typ": *
#import "@preview/zebra:0.1.0": qrcode

// ==========================================
//  CONFIGURACIÓN DE LA FUENTE PARA EL TEXTO
// ==========================================
#set text(
    size: 10pt,
    // font: "IBM Plex Serif",
    lang: "es",
    region: "mx",
    // weight: "light",
)

// ===================================================
//  CONFIGURACIÓN DE LA FUENTE UTILIZADA EN EL CÓDIGO
// ===================================================
#set raw(
    lang: "cpp",    // Lenguaje por defecto para todo tipo de código (se pueden configurar otros lenguajes explicítamente).
    tab-size: 4,
)
// Fuente para código (bloques y línea).
#show raw: set text(
    font: "Roboto Mono",
)
// Configura la fuente para que el código en línea (no bloques) aparezca en semibold (más grueso que en bloques).
#show raw.where(block: false): set text(weight: "medium")

// ==========================================================
//  CONFIGURACIÓN DE LA FUENTE PARA LAS FÓRMULAS MATEMÁTICAS
// ==========================================================
// #show math.equation: set text(
//     font: "IBM Plex Math",
// )
#set math.cases(gap: 0.5em)


// ==============================================
//  CONFIGURACIÓN DE LOS METADATOS DEL DOCUMENTO
// ==============================================
#set document(
    title: "Reference",
)



// ==================================
//  APLICA LA PLANTILLA AL DOCUMENTO
// ==================================

#let url-repo = "https://github.com/sav1209/My-CP-Reference/blob/main/"
#show: reference.with(
    // URL base de GitHub para que la plantilla pueda generar enlaces dentro del PDF a tu repositorio (Opcional).
    github-base: url-repo,
    
    // Si quieres que el PDF tenga colores tenga un estilo monocromatico descomenta la siguiente línea.
    use-color: false,                
)

// =======================
//  TÍTULO PERSONALIZADA
// =======================
#grid(
    columns: 1fr,
    rows: 1fr,
)[
    #set align(center)
    #set text(font: "Montserrat")
    #let qr-repo = link(url-repo, qrcode(url-repo))

    #stack(
        text(
            size: 50pt,
            weight: 900,
            tracking: -1.5pt,
            fill: gradient.linear(green, teal, angle: 45deg),
        )[REFERENCE],
        v(15pt),
        text(
            size: 15pt,
            weight: 600,
            tracking: 2.5pt,
            fill: subtext0
        )[#smallcaps[Gatitas Tapabaños Nacatlán]],
        v(15pt),
        box(
            fill: white,
            stroke: 1pt + surface2,
            radius: 12pt,
            inset: 14pt,
            qr-repo
        ),
        v(1fr),
        image("assets/images/shrek.png", width: 8cm),
        v(1fr),
        box(
            fill: mantle,
            radius: 999pt,
            inset: (x: 14pt, y: 6pt)
        )[
            #text(size: 9pt, fill: subtext1, font: "JetBrains Mono")[
            Última actualización: #datetime.today().display()
            ]
        ]
    )
]

// =====================
//  TABLA DE CONTENIDOS
// =====================
#show outline.entry.where(level: 1): strong
#outline(depth: 3)

// =====================
//  SECCIONES TEMATICAS
// =====================
#include "cpp/section.typ"
#include "estructuras/section.typ"
#include "ordenamiento_busqueda/section.typ"
#include "graficas/section.typ"
#include "dp/section.typ"
#include "teoria_de_numeros/section.typ"
#include "combinatoria/section.typ"
#include "strings/section.typ"
#include "manipulacion_de_bits/section.typ"
#include "matematicas/section.typ"
#include "teoria/section.typ"
// #include "otros/section.typ"