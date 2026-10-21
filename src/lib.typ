// typst-theme — shared visual identity for the Liceo Russell Typst materials.

#let palette = (
  ink: rgb("#212630"),
  accent: rgb("#3e63dd"),
  accent-dark: rgb("#2c46b8"),
  tint: rgb("#eef3fd"),
  amber: rgb("#e9a13b"),
  amber-dark: rgb("#a86508"),
  amber-tint: rgb("#fdf3e2"),
  code-bg: rgb("#f4f5f7"),
)

#let font-mono = "DejaVu Sans Mono"

/// Shared vertical rhythm.
///
/// Flowing content uses the `em`-based scale (`xs` … `xxl`); fixed page
/// furniture (cover, footer, answer lines) uses the absolute `page` scale.
/// Components should use these tokens instead of ad-hoc `#v(...)` values.
#let spazio = (
  xs: 0.25em,
  sm: 0.45em,
  md: 0.65em,
  lg: 0.9em,
  xl: 1.5em,
  xxl: 2em,
  page: (
    xs: 4pt,
    sm: 8pt,
    md: 12pt,
    lg: 16pt,
    xl: 20pt,
    xxl: 28pt,
  ),
)

/// Text of the last level-1 heading. Components use it to group automatic
/// summaries by the section they appear in.
#let sezione-corrente = state("sezione-corrente", none)

/// Small uppercase label used above values and sections.
#let etichetta(txt) = text(
  size: 7.6pt,
  weight: 700,
  tracking: 0.14em,
  fill: luma(118),
)[#upper(txt)]

/// Apply the shared page, typography, code and heading styles.
/// Use with `#show: doc => theme(doc, ...)`.
#let theme(
  body,
  footer-text: "Verifica di informatica",
  paper: "a4",
  margin: (top: 2.1cm, bottom: 2.4cm, x: 2.2cm),
) = {
  set page(
    paper: paper,
    margin: margin,
    footer: if footer-text == none {
      none
    } else {
      context [
        #set text(size: 8.5pt, fill: luma(140))
        #stack(
          dir: ttb,
          spacing: spazio.page.sm,
          line(length: 100%, stroke: 0.5pt + luma(225)),
          align(center)[
            #footer-text #h(10pt)·#h(10pt) #counter(page).display()
          ],
        )
      ]
    },
  )

  set text(lang: "it", region: "IT", size: 11pt, fill: palette.ink)
  set par(justify: true)
  set heading(numbering: "1.")
  set list(
    marker: (text(fill: palette.accent)[•],),
    indent: 1em,
    spacing: spazio.md,
  )
  set raw(tab-size: 4)

  show raw.where(block: true): it => block(
    width: 100%,
    fill: palette.code-bg,
    radius: 3pt,
    inset: (x: 10pt, y: 9pt),
    outset: (y: 3pt),
    stroke: none,
  )[#it]

  show raw.where(block: false): it => box(
    fill: palette.code-bg,
    inset: (x: 3pt, y: 1pt),
    outset: (y: 2pt),
    radius: 3pt,
  )[#it]

  show link: it => highlight(
    fill: palette.code-bg,
    stroke: 0.4pt + luma(200),
    radius: 3pt,
    extent: 2pt,
  )[
    #text(
      font: (font-mono,),
      size: 0.9em,
      fill: palette.accent-dark,
    )[#it]
  ]

  show heading.where(level: 1): it => {
    sezione-corrente.update(_ => it.body)

    block(
      above: spazio.xl,
      below: spazio.lg,
      width: 100%,
    )[
      #stack(
        dir: ttb,
        spacing: spazio.page.md,
        grid(
          columns: (auto, 1fr),
          column-gutter: 9pt,
          align: horizon,
          box(
            fill: palette.accent,
            inset: (x: 7pt, y: 4pt),
            radius: 3pt,
            baseline: 32%,
          )[
            #text(fill: white, weight: 800, size: 12pt)[
              #counter(heading).display()
            ]
          ],
          text(size: 17pt, weight: 800, fill: palette.ink)[#it.body],
        ),
        line(length: 100%, stroke: 2.2pt + palette.accent),
      )
    ]
  }

  body
}

