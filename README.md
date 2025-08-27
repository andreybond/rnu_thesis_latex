# ISMA BSc Thesis LaTeX Template (XeLaTeX)

This template implements the key layout and styling rules from the provided ISMA guidelines (A4, 12pt, Times New Roman/Calibri, 1.5 line spacing, mirrored margins, outer page numbers, table/figure caption placement, chapter-based numbering, and an alphabetized bibliography).

## Installation

To use this thesis template on Linux systems, you'll need to install XeLaTeX and additional packages:

### Ubuntu/Debian-based distributions
```bash
# Update package list
sudo apt-get update

# Install XeLaTeX engine and basic TeX Live components
sudo apt-get install texlive-xetex

# Install additional required packages
sudo apt-get install texlive-latex-extra texlive-science  # required for 'algorithmic' & 'algpseudocode'
sudo apt-get install python3-pygments  # required for 'minted'
sudo apt-get install texlive-bibtex-extra biber  # for bibliography management
```

### Fedora/RHEL-based distributions
```bash
# Install XeLaTeX and required packages
sudo dnf install texlive-xetex texlive-latexextra texlive-science
sudo dnf install python3-pygments texlive-biblatex biber
```

### Arch Linux
```bash
# Install necessary packages
sudo pacman -S texlive-core texlive-latexextra texlive-science
sudo pacman -S python-pygments texlive-bibtexextra biber
```

### 🪟 Windows Installation
For Windows users, we recommend these steps:

#### Method 1: MiKTeX (Recommended for Windows)
1. Download and install MiKTeX:
    - Visit MiKTeX's official website
    - Download the basic installer (choose 64-bit or 32-bit depending on your system)
    - Run the installer and follow the setup wizard2
    - Select "Install missing packages on the fly" when prompted2

2. Install additional packages:

    - After installation, open MiKTeX Console
    - Go to "Packages" and install the following:
      - `latex-extra` collection
      - `science` collection
      - `biber` tool
      - `minted` package dependencies

3. Install Python/Pygments:

    - Download Python from [python.org](python.org)
    - During installation, check "Add Python to PATH"
    - Install Pygments using: `pip install pygments`

#### Method 2: TeX Live (Full distribution)
1. Download TeX Live:

    - Visit TeX Live [website](https://www.tug.org/texlive/)
    - Download the Windows installer
    - Run the installer and select "Install TeX Live" (this will take longer but includes all packages)


### 🍎 macOS Installation
For macOS users, we recommend these steps:

#### Method 1: BasicTeX (Lightweight option)
```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install BasicTeX
brew install basictex

# Update tlmgr (TeX Live Manager)
sudo tlmgr update --self

# Install required packages
sudo tlmgr install collection-latexextra
sudo tlmgr install collection-science
sudo tlmgr install biber
sudo tlmgr install minted
sudo tlmgr install xetex:cite[3]

# Install Python/Pygments
brew install python
pip3 install pygments
```

#### Method 2: MacTeX (Full distribution)
1. Download MacTeX:

    - Visit MacTeX [website](https://www.tug.org/mactex/) 
    - Download the MacTeX.pkg file (approximately 4.5GB)
    - Run the installer and follow the [instructions](https://guides.nyu.edu/LaTeX/installation)
    - MacTeX includes a complete TeX Live distribution with all necessary packages ([url](https://www.latex-project.org/get/))

## Compilation (to produce PDF file)

To produce your PDF thesis document, run these commands in sequence:

```bash
# First compilation: processes .tex file and creates .aux file
xelatex -shell-escape main

# Process bibliography with Biber
biber main

# Second compilation: incorporates bibliography references
xelatex -shell-escape main

# Third compilation: ensures all cross-references are resolved
xelatex -shell-escape main
```

## 📝 Compilation Notes
1. The `-shell-escape` parameter is required for the minted package to execute Python Pygments for syntax highlighting

2. Multiple compilations are necessary to resolve all cross-references, citations, and table of contents entries

3. If you make changes to your bibliography, you must rerun the entire compilation sequence

4. For large documents, consider using a compilation script or Makefile

## 🔧 Troubleshooting Common Issues
**XeLaTeX not found error**
- Linux: Ensure texlive-xetex package is installed15
- Windows/macOS: Verify your TeX distribution is properly installed and added to PATH

**Minted package errors**
- Ensure Python and Pygments are installed
- Verify -shell-escape is enabled
- Check that Pygments is accessible from your command line

**Font issues**
- XeLaTeX supports system fonts; specify them by name in your document
- For custom fonts, place them in your project directory and reference them appropriately10

## Editor to use

### VS Code + plugin LaTeX Workshop 
VSCode is a lightweight IDE, when equipped with plugins can serve many purposes.
Open the folder with the project and hit **Build**.

Alternative - enter build commands in the terminal window of the VSCode.

### TeXStudio
[TexStudio](https://www.texstudio.org/) is another free option.

## 💡 Alternative: Online LaTeX Editors
If you prefer not to install LaTeX locally, consider these online options:

  - Overleaf: Professional online LaTeX editor with real-time collaboration (upload whole project into Overleaf):
    - Supports XeLaTeX compilation10
    - No installation required
    - Free Overleaf Professional accounts available for NYU students (check if your institution offers similar)

For more detailed information, consult the official documentation of [TeX Live](https://www.tug.org/texlive/) or [MiKTeX](https://miktex.org/).

Remember that LaTeX distributions are regularly updated, so you may want to periodically update your installation to get the latest packages and bug fixes.

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


## Notes on the Guidelines
- Ensure **each chapter/section** starts with your own introductory text (avoid starting/ending with a float).
- Place large tables/figures (> 2/3 page) in **Appendices** and reference them from the body.
- Keep **two headings** from following each other directly; ensure the proper spacing (class sets reasonable defaults).
- Ensure **analysis** accompanies tables/figures in the text.
- For quotes and references, keep consistency of the chosen **citation option** across the whole thesis.

Happy writing!
