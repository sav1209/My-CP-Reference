// Own math operators
// Modular multiplicative inverse operator
#let inv = math.op("inv")

// Soothing pastel theme for Typst
#import "@preview/catppuccin:1.0.0": catppuccin, flavors

#let flavor = flavors.latte
#let palette = flavor.colors
#let time-icon = "stopwatch"
#let space-icon = "server"

// Out-of-the-box, customizable and multilingual theorem environment package.
#import "@preview/theorion:0.3.3": *
#import cosmos.rainbow: *

// Codly is a beautiful code presentation template with many features like smart indentation, line numbering, highlighting, etc.
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

// GitHub Octicons for Typst
#import "@preview/octique:0.1.1": *

#let show-algorithm(algorithm) = {
  let (title, time, space, description, lang, source-file) = (
    algorithm.at("title", default: ""),
    algorithm.at("time", default: ""),
    algorithm.at("space", default: ""),
    algorithm.at("description", default: ""),
    algorithm.at("lang", default: "cpp"),
    algorithm.source-file,
  )

  block(
    width: 100%,
    breakable: false,
    stack(
      if title != "" {
        set align(center+horizon)
        set text(
          size: 1.2em,
          weight: "extrabold"
        )
        show math.equation: math.bold

        box(
          fill: palette.mantle.rgb,
          inset: (x: 0.5em, y: 0.5em),
          width: 100%,
          radius: 5pt,
          title
        )
      },
      if time != "" or space != "" [
        #if title != "" { v(0.75em) }

        #set text(size: 1.1em)
        #show math.equation: set text(weight: "black")

        #grid(
          columns: (auto, 1fr),
          align: center+horizon,
          grid.cell()[
            #text(
              fill: palette.text.rgb,
              weight: "bold",
            )[
              Complexity
            ]
          ],
          [
            #if time != "" [
              #octique-inline(time-icon, baseline: 10%, color: palette.text.rgb)#h(0.2em)#time
            ]
            #if time != "" and space != "" [#h(0.75em)|#h(0.75em)]
            #if space != "" [
              #octique-inline(space-icon, baseline: 10%, color: palette.text.rgb)#h(0.2em)#space
            ]
          ]
        )
      ],
      if description != "" {
        if title != "" or time != "" or space != "" { v(1em) }
        description
      }
    )
  )
  raw(read(source-file), lang: lang, block: true)
}

// Template
#let template(
  body,
) = {
  show: catppuccin.with(flavor)

  // Paper size
  set page(
    margin: (x: 0.5cm, y: 1cm),
    paper: "us-letter",
    numbering: "1",
    flipped: true,
    columns: 2,
    fill: none,
  )

  // Code
  show: codly-init.with()
  codly(
    languages: codly-languages,
    header-cell-args: (align: center),
    header-transform: x => {
      show math.equation: math.bold
      strong(x)
    },
    number-format: it => text(numbering("1", it), weight: "semibold"),
    breakable: true,
    lang-format: none,
    zebra-fill: palette.base.rgb,
    stroke: 1pt+palette.crust.rgb,
  )

  // Boxes
  show: show-theorion

  // Headers
  set heading(numbering: "1.")
  show heading: it => {
    show math.equation: math.bold
    it
  }
  show heading.where(level: 1): set text(size: 1.5em, weight: "black", fill: gradient.linear(
    palette.blue.rgb,
    palette.sky.rgb,
    angle: 30deg,
  ))

  show heading.where(level: 2): set text(size: 1.3em, weight: "extrabold", fill: gradient.linear(
    palette.mauve.rgb,
    palette.pink.rgb,
    angle: 30deg,
  ))

  show heading.where(level: 3): set text(size: 1.15em, weight: "extrabold", fill: gradient.linear(
    palette.teal.rgb,
    palette.green.rgb,
    angle: 30deg,
  ))

  // Others
  set highlight(fill: palette.yellow.rgb)
  set terms(separator: [: #h(0.75em, weak: true)])

  body
}
