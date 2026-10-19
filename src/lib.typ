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
          spacing: 7pt,
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
    spacing: 0.7em,
  )
  set raw(tab-size: 4)

  show raw.where(block: true): it => block(
    width: 100%,
    fill: palette.code-bg,
    radius: 4pt,
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
    radius: 2pt,
    extent: 2pt,
  )[
    #text(
      font: (font-mono,),
      size: 0.9em,
      fill: palette.accent-dark,
    )[#it]
  ]

  show heading.where(level: 1): it => block(
    above: 1.4em,
    below: 1em,
    width: 100%,
  )[
    #stack(
      dir: ttb,
      spacing: 0.35em,
      grid(
        columns: (auto, 1fr),
        column-gutter: 9pt,
        align: horizon,
        box(
          fill: palette.accent,
          inset: (x: 7pt, y: 4pt),
          radius: 4pt,
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

  body
}

