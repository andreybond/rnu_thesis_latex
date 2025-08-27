\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{isma-thesis}[2025/08/24 ISMA BSc Thesis Class]

\DeclareOption{calibri}{\def\isma@font{calibri}}
\DeclareOption{citestyle=footnote}{\def\isma@cite{footnote}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ExecuteOptions{}
\ProcessOptions\relax

\LoadClass[12pt,twoside,a4paper]{report}

% -------- Packages --------
\RequirePackage{amsmath}
\RequirePackage{fontspec}
\RequirePackage{unicode-math}
\RequirePackage{polyglossia}
\setdefaultlanguage{english}
\setotherlanguages{latvian,russian}

% Fonts (Times New Roman default; Calibri optional)
\ifx\isma@font\undefined
  % Times New Roman + matching math
  \setmainfont{Times New Roman}
  \setsansfont{Arial}
  \setmonofont{Courier New}
  \setmathfont{TeX Gyre Termes Math}
\else
  \ifx\isma@font\calibri
    \setmainfont{Calibri}
    \setsansfont{Calibri}
    \setmonofont{Cascadia Mono}
    % Math pairing for Calibri (no native): use Latin Modern Math as neutral choice
    \setmathfont{Latin Modern Math}
  \fi
\fi

\RequirePackage{geometry}
\geometry{
  a4paper,
  inner=3cm,
  outer=2cm,
  top=3cm,
  bottom=2cm,
  headsep=12pt,
  headheight=14pt
}

\RequirePackage{setspace}
\onehalfspacing % 1.5 line spacing

\RequirePackage{microtype}
\RequirePackage{csquotes}

% Header/footer per guidelines: outer upper corner page number
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[RO]{\thepage}
\fancyhead[LE]{\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% Caption setup: tables caption above; figures below; chapter-wise numbering
\RequirePackage{caption}
\captionsetup{labelfont=bf}
\captionsetup[table]{position=top,justification=centering}
\captionsetup[figure]{position=bottom,justification=centering}

\numberwithin{equation}{chapter}
\numberwithin{figure}{chapter}
\numberwithin{table}{chapter}

% Spacing before/after headings, bold headings
\RequirePackage{titlesec}
\titleformat{\chapter}{\bfseries\Large}{\thechapter.\ }{0.5em}{}
\titlespacing*{\chapter}{0pt}{0pt}{1.5\baselineskip} % start each chapter on new page anyway
\titleformat{\section}{\bfseries\large}{\thesection}{0.5em}{}
\titlespacing*{\section}{0pt}{1.5\baselineskip}{0.75\baselineskip}
\titleformat{\subsection}{\bfseries\normalsize}{\thesubsection}{0.5em}{}
\titlespacing*{\subsection}{0pt}{1.25\baselineskip}{0.6\baselineskip}

% ToC depth (chapters/sections/subsections)
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}

% Lists: compact enough but readable
\RequirePackage{enumitem}
\setlist{itemsep=0.25\baselineskip,topsep=0.25\baselineskip}

% Bibliography: default author-year; or footnote-style if option selected
\newif\ifismafootnotecite
\ifx\isma@cite\undefined
  \ismafootnotecitefalse
\else
  \ismafootnotecitetrue
\fi

\ifismafootnotecite
  \RequirePackage[backend=biber,style=verbose-note,sorting=nyt]{biblatex}
\else
  \RequirePackage[backend=biber,style=authoryear,sorting=nyt]{biblatex}
\fi

\addbibresource{bibliography/references.bib}

% Single spacing within a bibliography entry, extra space between entries
\RequirePackage{etoolbox}
\AtBeginBibliography{\setstretch{1.0}}
\setlength\bibitemsep{6pt}

% Footnotes formatting (for Option 2 references)
\RequirePackage[hang,flushmargin]{footmisc}

% For dummy text examples
\RequirePackage{lipsum}

% -------- Custom commands for front matter --------
\newcommand{\thesistitle}{}
\newcommand{\thesisauthor}{}
\newcommand{\thesisyear}{\the\year}
\newcommand{\thesiscity}{Riga-LV}
\newcommand{\thesisprogram}{BSc in Information Technologies}
\newcommand{\thesisfaculty}{ISMA – Department of Natural Sciences and Information Technologies}
\newcommand{\thesissupervisor}{}
\newcommand{\thesisdeclaration}{\input{frontmatter/declaration}}
\newcommand{\thesisacknowledgments}{\input{frontmatter/acknowledgments}}

\newcommand{\setthesistitle}[1]{\renewcommand{\thesistitle}{#1}}
\newcommand{\setthesisauthor}[1]{\renewcommand{\thesisauthor}{#1}}
\newcommand{\setthesissupervisor}[1]{\renewcommand{\thesissupervisor}{#1}}
\newcommand{\setthesisyear}[1]{\renewcommand{\thesisyear}{#1}}
\newcommand{\setthesiscity}[1]{\renewcommand{\thesiscity}{#1}}
\newcommand{\setthesisprogram}[1]{\renewcommand{\thesisprogram}{#1}}
\newcommand{\setthesisfaculty}[1]{\renewcommand{\thesisfaculty}{#1}}

% Title page: aligned with guidelines (minimalistic, centered, portrait)
\newcommand{\makethesistitlepage}{%
  \thispagestyle{empty}
  \begin{center}
    \Large \thesisfaculty \par\vspace{3cm}
    \Large \textbf{\thesistitle}\par\vspace{2cm}
    \normalsize \textbf{Author:} \thesisauthor \par\vspace{2cm}
    \normalsize \thesiscity, \thesisyear \par
  \end{center}
  \clearpage
}

% Abstracts: templates (optional), unnumbered pages
\newcommand{\thesisabstracts}{%
  \thispagestyle{empty}
  \begin{center}\textbf{Abstract (English)}\end{center}
  \input{frontmatter/abstract_en}\par
  \clearpage
  \thispagestyle{empty}
  \begin{center}\textbf{Anotācija (Latviešu)}\end{center}
  \input{frontmatter/abstract_lv}\par
  \clearpage
}

% % Table of contents: unnumbered page
% \newcommand{\thesistoc}{%
%   \thispagestyle{empty}
%   \tableofcontents
%   \clearpage
% }

\newcommand{\thesistoc}{%
  \thispagestyle{empty}%
  \addcontentsline{toc}{chapter}{Table of Contents}%
  \tableofcontents
  \clearpage
}

% Start body: turn on page numbering from here
\newcommand{\startmainmatter}{%
  \pagenumbering{arabic}
  \setcounter{page}{1}
}

% Convenience environments
\newenvironment{conclusions}{\chapter*{Conclusions}\addcontentsline{toc}{chapter}{Conclusions}\begingroup\setlength{\parindent}{1.5em}\par}{\par\endgroup}
\newenvironment{proposals}{\chapter*{Proposals}\addcontentsline{toc}{chapter}{Proposals}\begingroup\setlength{\parindent}{1.5em}\par}{\par\endgroup}

% Ensure paragraphs are indented and fully justified
\setlength{\parindent}{1.5em}
\setlength{\parskip}{0pt}
\pretolerance=1000
\tolerance=2000
\emergencystretch=2em
