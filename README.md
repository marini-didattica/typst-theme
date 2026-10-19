# typst-theme

Shared colours, typography, page setup, code-block styling and heading style
for the Liceo Russell Typst materials.

The package exports `palette`, `font-mono`, `etichetta` and `theme`. Links are
rendered as inline monospace “verb” chips: code background, thin border, and
accent-coloured text, while remaining clickable.

## Usage

Keep the theme next to the document that imports it (as a sibling directory or
a git submodule):

```typ
#import "../typst-theme/src/lib.typ": theme

#show: doc => theme(doc, footer-text: "Verifica di informatica")
```

Compile with the root that contains the theme so Typst's sandbox can read it:

```sh
typst compile --root . path/to/document.typ
```

## Development

This repository is designed to sit side by side with
[`typst-components`](https://github.com/marini-didattica/typst-components).
The `misc` and `riservato` repositories consume both as git submodules.
