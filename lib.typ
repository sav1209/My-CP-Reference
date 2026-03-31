// Soothing pastel theme for Typst
#import "@preview/catppuccin:1.0.0": catppuccin, flavors

#let flavor = flavors.latte
#let palette = flavor.colors

// Out-of-the-box, customizable and multilingual theorem environment package.
#import "@preview/theorion:0.3.3": *
#import cosmos.rainbow: *

// Codly is a beautiful code presentation template with many features like smart indentation, line numbering, highlighting, etc.
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *

// Global config consumed by `code-entry` when no explicit github-base is passed.
#let code-entry-github-base-state = state("code-entry-github-base", none)

// Reusable Font Awesome icon helper and GitHub-link icon.
#let fa-icon(icon, ..args) = text(
  font: "Font Awesome 7 Free",
  size: 1em,
  weight: "regular",
  icon,
  ..args,
)
#let icon-external-link = fa-icon("\u{f08e}")

// ╔══════════════════════════════════════════════════════════════════╗
// ║  #code-entry — modern card for CP Reference                      ║
// ║                                                                  ║
// ║  Parameters:                                                     ║
// ║    source-file  relative path to file, e.g. "math/sieve.cpp"     ║
// ║    ..args       optional positional inline code content            ║
// ║    title        code title                                       ║
// ║    time         time complexity                                  ║
// ║    space        space complexity                                 ║
// ║    description  optional description                             ║
// ║    lang         language for syntax highlight (default "cpp")    ║
// ║    github-base  optional base URL to link source code            ║
// ║    range        line range for codly, e.g. (6, 20)               ║
// ╚══════════════════════════════════════════════════════════════════╝

#let code-entry(
  source-file: "",
  title: "",
  time: "",
  space: "",
  description: "",
  lang: "cpp",
  github-base: none,
  range: (),
  ..args,
) = {
  // ── Color palette (teal) ──────────────────────────────────────────
  let c-gradient-a = rgb("#1D9E75") // accent start
  let c-gradient-b = rgb("#5DCAA5") // accent middle
  let c-gradient-c = rgb("#E1F5EE") // accent end (fades)
  let c-header-bg = rgb("#E1F5EE") // header background
  let c-border = rgb("#9FE1CB") // outer border and separators
  let c-title = rgb("#04342C") // title text
  let c-meta-label = rgb("#6B7C78") // muted complexity label

  // ── Optional content flags ───────────────────────────────────────
  let has-time = time != ""
  let has-space = space != ""
  let has-both = has-time and has-space
  let has-complexity = has-time or has-space
  let has-description = description != ""
  let inline-code = if args.pos().len() > 0 { args.pos().at(0) } else { none }
  let has-inline-code = inline-code != none
  let has-file = source-file != "" and not has-inline-code

  // ══════════════════════════════════════════════════════════════════════
  // SUB-COMPONENTS
  // ══════════════════════════════════════════════════════════════════════

  // File badge with GitHub hyperlink
  let file-badge = if has-file and github-base == none [
    #context {
      let default-base = code-entry-github-base-state.get()
      if default-base != none {
        link(
          default-base + source-file,
          text(weight: "black")[#source-file#h(0.3em)#icon-external-link],
        )
      } else {
        text(weight: "black")[#source-file]
      }
    }
  ] else if has-file and github-base != none {
    link(
      github-base + source-file,
      text(weight: "black")[#source-file#h(0.3em)#icon-external-link],
    )
  } else if has-file {
    text(weight: "black")[#source-file]
  } else { [] }

  // 1. Accent bar with gradient (3pt tall)
  let accent-bar = grid.cell(
    fill: gradient.linear(c-gradient-a, c-gradient-b, c-gradient-c, dir: ltr),
  )[
    #box(
      width: 100%,
      height: 3pt,
    )
  ]

  // 2. Header: title on the left
  let header = grid.cell(
    fill: c-header-bg,
    inset: (x: 0.85em, y: 0.6em),
    align: left + horizon,
  )[
    #show math.equation: math.bold
    #text(
      weight: "bold",
      fill: c-title,
      size: 1em,
    )[
      #title
    ]
  ]

  // 3. Reusable complexity cell (label + value)
  let meta-cell(label, value) = pad(
    x: 0.85em,
    y: 0.5em,
    stack(
      dir: ttb,
      spacing: 0.4em,
      // Label in uppercase with letter-spacing
      text(
        size: 0.68em,
        fill: c-meta-label,
        tracking: 0.06em,
        weight: "medium",
      )[#upper(label)],
      text(size: 0.92em)[#value],
    ),
  )

  // 4. Complexity section (conditional)
  let complexity-rows = if has-complexity {
    let inner = if has-both {
      grid(
        columns: (1fr, 1fr),
        stroke: none,
        grid.vline(x: 1, stroke: 0.5pt + c-border),
        meta-cell("Time", time),
        meta-cell("Space", space),
      )
    } else {
      meta-cell(
        if has-time { "Time" } else { "Space" },
        if has-time { time } else { space },
      )
    }
    (grid.hline(stroke: 0.5pt + c-border), inner)
  } else { () }

  // 5. Description section (conditional)
  let description-rows = if has-description {
    (
      grid.hline(stroke: 0.5pt + c-border),
      pad(x: 0.85em, y: 0.7em)[#description],
    )
  } else { () }

  // ══════════════════════════════════════════════════════════════════════
  // CARD ASSEMBLY
  // ══════════════════════════════════════════════════════════════════════

  let parts = (accent-bar, header) + complexity-rows + description-rows

  block(
    width: 100%,
    radius: 5pt,
    stroke: 0.5pt + c-border,
    clip: true, // necessary for radius to clip accent-bar
    breakable: false, // card doesn't break across pages
    above: 1em,
    below: 0pt, // code attached to card
    grid(
      columns: 100%,
      ..parts
    ),
  )

  // ══════════════════════════════════════════════════════════════════════
  // CODE BLOCK (codly)
  // ══════════════════════════════════════════════════════════════════════
  if has-inline-code {
    // Inline code takes precedence over source-file and GitHub metadata.
    codly()
    if range != () {
      codly(range: range)
    }
    v(0.5em)
    if type(inline-code) == str {
      raw(inline-code, lang: lang, block: true)
    } else {
      inline-code
    }
  } else if has-file {
    // If file exists, code block is shown just below the card
    codly(header: file-badge)
    if range != () {
      codly(range: range)
    }
    v(0.5em)
    raw(read(source-file), lang: lang, block: true)
  } else {
    // If no file, no code block is shown
    []
  }
}

// Template
#let reference(
  body,
  github-base: none,
) = {
  show: catppuccin.with(flavor)

  // Document-level default for code-entry links.
  code-entry-github-base-state.update(github-base)

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
    header-cell-args: (align: center, inset: (y: 0.75em)),
    header-transform: x => {
      show math.equation: math.bold
      strong(x)
    },
    number-format: it => text(numbering("1", it), weight: "bold"),
    breakable: true,
    lang-format: (_, icon, _) => text(size: 1.5em, icon),
    zebra-fill: palette.base.rgb,
    stroke: 1pt + palette.crust.rgb,
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
