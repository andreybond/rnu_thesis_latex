# ISMA BSc Thesis LaTeX Template (XeLaTeX)

This template implements the key layout and styling rules from the provided ISMA guidelines (A4, 12pt, Times New Roman/Calibri, 1.5 line spacing, mirrored margins, outer page numbers, table/figure caption placement, chapter-based numbering, and an alphabetized bibliography).

## Highlights
- **A4**, **twoside** with **mirrored margins**: inner=3cm, outer=2cm, top=3cm, bottom=2cm.
- **12pt**, **Times New Roman** by default (switch to **Calibri** using class option `calibri`).
- **1.5 line spacing**; black text.
- **Outer-corner page numbers** using `fancyhdr` (upper-right on odd pages, upper-left on even pages).
- **Headings in Bold**; you control capitalization.
- **Tables**: caption **above**; **Figures**: caption **below**; both numbered per chapter (e.g., 2.1).
- **Formulas** numbered per chapter: (2.3).
- **References** via `biblatex`; choose `authoryear` (inline) or `verbose-note` (footnotes) by class option.
- **Front matter** (title/abstracts/ToC) pages are unnumbered; numbering starts at **Introduction**.
- **Multilingual support** (English/Latvian/Russian) with `polyglossia`.

## Requirements
- **XeLaTeX** (or LuaLaTeX).
- `biber` for bibliography.
- Fonts installed: **Times New Roman** and/or **Calibri** (system fonts).

## Quick Start
```bash
# build (from this folder)
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex
```

If you use VS Code + LaTeX Workshop, open the folder and hit **Build**.

## Switching Fonts & Citation Style
- Use **Calibri** instead of Times: in `main.tex`, change `\documentclass{isma-thesis}` to:
  ```tex
  \documentclass[calibri]{isma-thesis}
  ```
- Use **footnote citations** instead of author-year: add `citestyle=footnote` class option:
  ```tex
  \documentclass[citestyle=footnote]{isma-thesis}
  ```
  By default, the class uses `authoryear` style.

## Structure
- `frontmatter/` — title page, declaration, acknowledgments, abstracts.
- `chapters/` — introduction, chapters, conclusions & proposals.
- `appendices/` — appendices.
- `bibliography/` — `references.bib` (sample entries).

## Notes on the Guidelines
- Ensure **each chapter/section** starts with your own introductory text (avoid starting/ending with a float).
- Place large tables/figures (> 2/3 page) in **Appendices** and reference them from the body.
- Keep **two headings** from following each other directly; ensure the proper spacing (class sets reasonable defaults).
- Ensure **analysis** accompanies tables/figures in the text.
- For quotes and references, keep consistency of the chosen **citation option** across the whole thesis.

Happy writing!
