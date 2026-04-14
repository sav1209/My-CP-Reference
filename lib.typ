// Soothing pastel theme for Typst
#import "@preview/catppuccin:1.0.0": catppuccin
#import "colors.typ": *

// Out-of-the-box, customizable and multilingual theorem environment package.
#import "@preview/theorion:0.3.3": *
#import cosmos.rainbow: *

// Codly is a beautiful code presentation template with many features like smart indentation, line numbering, highlighting, etc.
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *

// Global config consumed by `code-entry` when no explicit github-base is passed.
#let code-entry-github-base-state = state("code-entry-github-base", none)
#let code-entry-use-color-state = state("code-entry-use-color", true)

// Reusable Font Awesome icon helper and GitHub-link icon.
#let fa-icon(icon, ..args) = text(
  font: "Font Awesome 7 Free",
  size: 1em,
  weight: "regular",
  icon,
  ..args,
)
#let icon-external-link = fa-icon("\u{f08e}")

// ══════════════════════════════════════════════════════════════════════
// HELPER: resolve-tag-range
//
// Given the lines of a source file and a tag name, returns the codly
// range (1-based, inclusive) that covers the content between the
// opening and closing markers, EXCLUDING the marker lines themselves.
//
// Marker format (in the .cpp file):
//   // code-snippet: <tag>     ← opening marker
//   // code-snippet: end       ← closing marker
//
// Index arithmetic:
//   Typst arrays are 0-based; codly ranges are 1-based.
//   If the opening marker sits at 0-based index `i`:
//     - Its 1-based line number is  i + 1  (the marker itself, hidden)
//     - Content starts at           i + 2  (1-based) ← range start
//   If the closing marker sits at 0-based index `j`:
//     - Its 1-based line number is  j + 1  (the marker itself, hidden)
//     - Content ends at             j      (1-based) ← range end
//   Therefore: codly range = (i + 2, j)
// ══════════════════════════════════════════════════════════════════════
#let resolve-tag-range(lines, tag, source-file) = {
  let open-marker  = "//snippet:" + tag
  let close-marker = "//snippet:end"

  let open-idx  = none
  let close-idx = none

  for (i, line) in lines.enumerate() {
    let normalized = line.split().join()
    if open-idx == none and normalized == open-marker {
      open-idx = i
    } else if open-idx != none and close-idx == none and normalized == close-marker {
      close-idx = i
    }
  }

  if open-idx == none {
    panic("snippet tag '" + tag + "' not found in '" + source-file + "'")
  }
  if close-idx == none {
    panic("'snippet: end' not found after tag '" + tag + "' in '" + source-file + "'")
  }

  // Return 1-based codly range, markers excluded
  (open-idx + 2, close-idx)
}


// ╔══════════════════════════════════════════════════════════════════╗
// ║ #code-entry — modern card for CP Reference                      ║
// ║                                                                  ║
// ║ Parameters:                                                      ║
// ║   source-file  relative path to file, e.g. "graphs/dijkstra.cpp"║
// ║   ..args       optional positional inline code content           ║
// ║   title        code title                                        ║
// ║   time         time complexity                                   ║
// ║   space        space complexity                                  ║
// ║   description  optional description                              ║
// ║   lang         language for syntax highlight (default "cpp")     ║
// ║   github-base  optional base URL to link source code             ║
// ║   range        hardcoded line range for codly, e.g. (6, 20)     ║
// ║   tag          code-snippet tag to extract from source-file      ║
// ║                                                                  ║
// ║ Range resolution priority (first match wins):                    ║
// ║   1. tag  → resolve range from markers in the source file        ║
// ║   2. range → use hardcoded range as-is                           ║
// ║   3. (none) → show the entire file                               ║
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
  tag: none,          // ← NEW: code-snippet tag name
  ..args,
) = {
  // ── Optional content flags ────────────────────────────────────────
  let has-title       = title != ""
  let has-time        = time != ""
  let has-space       = space != ""
  let has-both        = has-time and has-space
  let has-complexity  = has-time or has-space
  let has-description = description != ""
  let inline-code     = if args.pos().len() > 0 { args.pos().at(0) } else { none }
  let has-inline-code = inline-code != none
  let has-file        = source-file != "" and not has-inline-code

  // ── Range resolution ──────────────────────────────────────────────
  // Computed once here so the code-block section stays clean.
  // Inline code paths ignore both `tag` and `range` (inline always wins).
  let effective-range = if tag != none and has-file {
    // Tag takes priority: parse the source file and locate the markers.
    let lines = read(source-file).split("\n")
    resolve-tag-range(lines, tag, source-file)
  } else {
    // Fall back to the hardcoded range (may be empty → full file).
    range
  }

  // ══════════════════════════════════════════════════════════════════
  // SUB-COMPONENTS
  // ══════════════════════════════════════════════════════════════════

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

  context {
    let use-color      = code-entry-use-color-state.get()
    let card-gradient-a = if use-color { c-gradient-a } else { g-c-gradient-a }
    let card-gradient-b = if use-color { c-gradient-b } else { g-c-gradient-b }
    let card-gradient-c = if use-color { c-gradient-c } else { g-c-gradient-c }
    let card-header-bg  = if use-color { c-header-bg  } else { g-c-header-bg  }
    let card-border     = if use-color { c-border     } else { g-c-border     }
    let card-title      = if use-color { c-title      } else { g-c-title      }
    let card-meta-label = if use-color { c-meta-label } else { g-c-meta-label }

    // 1. Accent bar with gradient (3 pt tall)
    let accent-bar = grid.cell(
      fill: gradient.linear(card-gradient-a, card-gradient-b, card-gradient-c, dir: ltr),
    )[
      #box(width: 100%, height: 3pt)
    ]

    // 2. Header: title on the left (optional)
    let header-rows = if has-title {
      (
        grid.cell(
          fill: card-header-bg,
          inset: (x: 0.85em, y: 0.6em),
          align: left + horizon,
        )[
          #show math.equation: math.bold
          #text(weight: "bold", fill: card-title, size: 1em)[#title]
        ],
      )
    } else { () }

    // 3. Reusable complexity cell (label + value)
    let meta-cell(label, value) = pad(
      x: 0.85em,
      y: 0.5em,
      stack(
        dir: ttb,
        spacing: 0.4em,
        text(
          size: 0.68em,
          fill: card-meta-label,
          tracking: 0.06em,
          weight: "medium",
        )[#upper(label)],
        text(size: 0.92em)[
          #set raw(lang: none)
          #codly(enabled: false)
          #value
          #codly(enabled: true)
        ],
      ),
    )

    // 4. Complexity section (conditional)
    let complexity-rows = if has-complexity {
      let inner = if has-both {
        grid(
          columns: (1fr, 1fr),
          stroke: none,
          grid.vline(x: 1, stroke: 0.5pt + card-border),
          meta-cell("Time",  time),
          meta-cell("Space", space),
        )
      } else {
        meta-cell(
          if has-time { "Time" } else { "Space" },
          if has-time { time  } else { space    },
        )
      }
      (grid.hline(stroke: 0.5pt + card-border), inner)
    } else { () }

    // 5. Description section (conditional)
    let description-rows = if has-description {
      (
        grid.hline(stroke: 0.5pt + card-border),
        pad(x: 0.85em, y: 0.7em)[#description],
      )
    } else { () }

    // ══════════════════════════════════════════════════════════════════
    // CARD ASSEMBLY
    // ══════════════════════════════════════════════════════════════════
    let parts = (accent-bar,) + header-rows + complexity-rows + description-rows

    block(
      width: 100%,
      radius: 5pt,
      stroke: 0.5pt + card-border,
      clip: true,       // necessary for radius to clip accent-bar
      breakable: false, // card doesn't break across pages
      above: 1em,
      below: 0pt,       // code block attaches flush to the card
      grid(columns: 100%, ..parts),
    )
  }

  // ══════════════════════════════════════════════════════════════════
  // CODE BLOCK (codly)
  // ══════════════════════════════════════════════════════════════════
  if has-inline-code {
    // Inline code takes precedence over source-file and all range logic.
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
    // Source-file path: apply effective-range if present.
    codly(header: file-badge)
    if effective-range != () {
      codly(range: effective-range)
    }
    v(0.5em)
    raw(read(source-file), lang: lang, block: true)
  } else {
    []
  }
}

// Template
#let reference(
  body,
  github-base: none,
  use-color: true,
) = {
  if use-color {
    show: catppuccin.with(flavor)
  }

  // Document-level default for code-entry links.
  code-entry-github-base-state.update(github-base)
  code-entry-use-color-state.update(use-color)

  set raw(theme: "assets/raw_themes/black-white.tmTheme") if not use-color

  // Paper size
  set page(
    margin: (top: 1.25cm, rest: 0.5cm),
    paper: "us-letter",
    numbering: "1",
    flipped: true,
    columns: 2,
    fill: none,
    header: context [
      #set text(weight: "medium", size: 12pt)
      #h(1fr)
      --- #counter(page).display("1") ---
    ],
    footer: none,
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
    number-format: it => text(
      numbering("1", it),
      weight: "medium",
      fill: if use-color { subtext1 } else { g-c-meta-label },
    ),
    breakable: true,
    lang-format: (_, icon, _) => text(size: 1.5em, icon),
    zebra-fill: if use-color { base } else { g-code-zebra },
    stroke: 1pt + if use-color { crust } else { g-code-stroke },
  )

  // Boxes
  show: show-theorion

  // Headings
  set heading(numbering: "1.")
  show heading: it => {
    show math.equation: math.bold
    it
  }
  show heading.where(level: 1): set text(
    size: 1.5em,
    weight: "black",
    fill: if use-color {
      gradient.linear(blue, sky, angle: 30deg)
    } else {
      g-heading-1-a
    },
  )

  show heading.where(level: 2): set text(
    size: 1.3em,
    weight: "extrabold",
    fill: if use-color {
      gradient.linear(mauve, pink, angle: 30deg)
    } else {
      g-heading-2-a
    },
  )

  show heading.where(level: 3): set text(
    size: 1.15em,
    weight: "extrabold",
    fill: if use-color {
      gradient.linear(teal, green, angle: 30deg)
    } else {
      g-heading-3-a
    },
  )

  // Others
  set highlight(fill: if use-color { yellow } else { g-highlight })
  set terms(separator: [: #h(0.75em, weak: true)])

  body
}
