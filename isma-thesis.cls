\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{isma-thesis}[2025/08/27 ISMA Bachelor Thesis Class]

% \LoadClass[12pt,a4paper,oneside]{book}
\LoadClass[12pt,a4paper,oneside,openany]{book}

% ===== Packages =====
\RequirePackage{geometry}
\geometry{
  a4paper,
  left=35mm,right=20mm,top=25mm,bottom=25mm,
  headsep=12mm,footskip=15mm
}

\RequirePackage{fontspec}
\setmainfont{Times New Roman}
\RequirePackage{setspace}
\setstretch{1.5}

\RequirePackage{titlesec}
% Heading 1: 16pt bold; Heading 2: 14pt bold, left-aligned
\titleformat{\chapter}[hang]{\bfseries\fontsize{16pt}{16pt}\selectfont}{\thechapter.}{0.8em}{}
\titlespacing*{\chapter}{0pt}{*3}{*1.2}

\titleformat{\section}[hang]{\bfseries\fontsize{14pt}{14pt}\selectfont}{\thesection.}{0.6em}{}
\titlespacing*{\section}{0pt}{*2}{*0.8}

\titleformat{\subsection}[hang]{\bfseries\normalsize}{\thesubsection.}{0.6em}{}
\titlespacing*{\subsection}{0pt}{*1.6}{*0.6}

% Match starred chapter heads (LoF/LoT/LoA/LoL, Abstract, etc.)
\titleformat{name=\chapter,numberless}[hang]
  {\bfseries\fontsize{16pt}{16pt}\selectfont}{}{0pt}{}
\titlespacing*{name=\chapter,numberless}{0pt}{*3}{*1.2}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\cfoot{\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\RequirePackage{tocloft}
\setlength{\cftbeforechapskip}{6pt}

% ---- Unify meta-list/ToC title styling with chapter (16 pt bold) ----
\renewcommand{\cfttoctitlefont}{\bfseries\fontsize{16pt}{16pt}\selectfont}
\renewcommand{\cftloftitlefont}{\bfseries\fontsize{16pt}{16pt}\selectfont}
\renewcommand{\cftlottitlefont}{\bfseries\fontsize{16pt}{16pt}\selectfont}

% Optional: match the after-title spacing to your chapter spacing
\renewcommand{\cftaftertoctitle}{\par\vspace{1.2\baselineskip}}
\renewcommand{\cftafterloftitle}{\par\vspace{1.2\baselineskip}}
\renewcommand{\cftafterlottitle}{\par\vspace{1.2\baselineskip}}

\RequirePackage{graphicx}
\graphicspath{{chapters/chapter1/assets/}{frontmatter/assets/}}


\RequirePackage{listings}

\RequirePackage{caption}
\RequirePackage{ragged2e} % for \RaggedLeft (better ragged-left = flush-right)

% ===== Totals & counts =====
\RequirePackage{totpages}  % provides \ref{TotPages}
\RequirePackage{totcount}  % totals of counters across doc runs
\RequirePackage{etoolbox}

% Global defaults
\captionsetup{
  font=normalsize,
  labelfont=bf,
  labelsep=period,
  skip=6pt
}

% % Per-type rules (apply after all packages are loaded)
% \AtBeginDocument{%
%   % Figures: caption below, centered
%   \captionsetup[figure]{position=bottom, justification=centering, singlelinecheck=false}

%   % Tables: caption above, RIGHT-justified
%   \captionsetup[table]{position=top, justification=RaggedLeft, singlelinecheck=false}

%   % Algorithms: caption above (default alignment is fine)
%   \captionsetup[algorithm]{position=top}

%   % Listings (minted[newfloat]): caption above, RIGHT-justified
%   \captionsetup[listing]{position=top, justification=RaggedLeft, singlelinecheck=false}
% }

% Source line for figures (use before \caption inside a figure)
\newcommand{\figsource}[1]{%
  \captionsetup{type=figure}%
  \caption*{\emph{Source: #1}}%
}




% Annex counter: counts \chapter after \appendix
\newcounter{annex}
\newif\ifinappendix
\inappendixfalse

\pretocmd{\appendix}{\inappendixtrue\setcounter{annex}{0}}{}{}
% increment annex at each chapter once in appendix
\pretocmd{\chapter}{\ifinappendix\stepcounter{annex}\fi}{}{}

% Count printed bibliography entries with biblatex
\newcounter{refcount}

% Safe getters with fallback to 0 on the first run
\newcommand{\TotalOrZero}[1]{%
  \ifcsname c@#1\endcsname%
    \total{#1}%
  \else%
    0%
  \fi%
}

% Hook for biblatex if it's loaded
\AtBeginDocument{%
  \@ifpackageloaded{biblatex}{%
    % This runs for every entry that actually gets printed
    \AtEveryBibitem{\stepcounter{refcount}}%
  }{}%
}

% English scope line
\newcommand{\thesisscopeEN}{%
  The Bachelor Paper is written in \textbf{\ref{TotPages}} pages and contains
  \textbf{\TotalOrZero{table}} tables,
  \textbf{\TotalOrZero{figure}} figures,
  \textbf{\TotalOrZero{algorithm}} algorithms,
  \textbf{\TotalOrZero{lstlisting}} listings,
  \textbf{\TotalOrZero{annex}} annexes, and a list of references with
  \textbf{\TotalOrZero{refcount}} sources.
}

% Latvian scope line
\newcommand{\thesisscopeLV}{%
  Bakalaura darbs izstrādāts \textbf{\ref{TotPages}} lapaspusēs un ietver
  \textbf{\TotalOrZero{table}} tabulas,
  \textbf{\TotalOrZero{figure}} attēlus,
  \textbf{\TotalOrZero{algorithm}} algoritmus,
  \textbf{\TotalOrZero{lstlisting}} programmu kodu izdrukas (listings),
  \textbf{\TotalOrZero{annex}} pielikumus, kā arī literatūras sarakstu ar
  \textbf{\TotalOrZero{refcount}} avotiem.
}

% Register standard float counters for totals and set up captions
\AtBeginDocument{%
  \regtotcounter{figure}%
  \regtotcounter{table}%
  \regtotcounter{algorithm}%
  \regtotcounter{lstlisting}%
  \regtotcounter{annex}%
  \regtotcounter{refcount}%

  % Figures: caption below, centered
  \captionsetup[figure]{position=bottom, justification=centering, singlelinecheck=false}

  % Tables: caption above, ragged-right (no forced centering)
  \captionsetup[table]{position=top, justification=raggedright, singlelinecheck=false}

  % Algorithms: caption above, ragged-right, name "Algorithm"
  \captionsetup[algorithm]{position=top, justification=raggedright,
                           singlelinecheck=false, name=Algorithm}

  % Listings (listings.sty): caption above, ragged-right, name "Listing"
  \captionsetup[lstlisting]{position=top, justification=raggedright,
                            singlelinecheck=false, name=Listing}
}

% Number algorithms/listings within chapters (Algorithm 2.1, Listing 3.2)
% (safe even if a type is missing)
\RequirePackage{chngcntr}
\makeatletter
\@ifundefined{c@algorithm}{}{ \counterwithin{algorithm}{chapter} }
% \@ifundefined{c@listing}{}{  \counterwithin{listing}{chapter}  }
\@ifundefined{c@lstlisting}{}{ \counterwithin{lstlisting}{chapter} }
\makeatother



\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{indentfirst}
\setlength{\parindent}{1.25cm} % 1 TAB ≈ 1.25 cm

% ===== Meta fields (bilingual) =====
% Names usually identical in both languages, but keep separate hooks if needed
\newcommand{\studentnameLV}{} \newcommand{\studentnameEN}{}
\newcommand{\supervisornameLV}{} \newcommand{\supervisornameEN}{}

\newcommand{\thesistitleLV}{}     \newcommand{\thesistitleEN}{}
\newcommand{\studyprogrammeLV}{}  \newcommand{\studyprogrammeEN}{}
\newcommand{\departmentLV}{}      \newcommand{\departmentEN}{}

\newcommand{\thesisyear}{\number\year}
\newcommand{\thesiscityLV}{RĪGA}  \newcommand{\thesiscityEN}{Riga}

% Set LV metadata
\newcommand{\setthesisinfoLV}[6]{%
  \renewcommand{\thesistitleLV}{#1}%
  \renewcommand{\studentnameLV}{#2}%
  \renewcommand{\supervisornameLV}{#3}%
  \renewcommand{\studyprogrammeLV}{#4}%
  \renewcommand{\departmentLV}{#5}%
  \renewcommand{\thesisyear}{#6}%
}

% Set EN metadata
\newcommand{\setthesisinfoEN}[6]{%
  \renewcommand{\thesistitleEN}{#1}%
  \renewcommand{\studentnameEN}{#2}%
  \renewcommand{\supervisornameEN}{#3}%
  \renewcommand{\studyprogrammeEN}{#4}%
  \renewcommand{\departmentEN}{#5}%
  \renewcommand{\thesisyear}{#6}%
}


% ===== Title page =====

% ===== Logo & Title-Block helpers =====
% Path & size can be changed here instead of inside the macro
\newcommand{\ismalogopath}{a_frontmatter/assets/isma_logo.png}
\newcommand{\ismalogowidth}{42mm} % tweak as needed for wide logo

% 16pt bold helper
\newcommand{\sixteenptbf}{\bfseries\fontsize{16pt}{16pt}\selectfont}
% 12pt normal helper
\newcommand{\twelvept}{\fontsize{12pt}{12pt}\selectfont}


\newcommand{\makethesistitle}{
  \thispagestyle{empty}

  % --- Top-left wide logo ---
  \noindent
  \includegraphics[width=\ismalogowidth]{\ismalogopath}

  \vspace{6mm}

  \noindent
  \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
    {\bfseries\fontsize{12pt}{12pt}\selectfont Studiju programma} &
    {\bfseries\fontsize{12pt}{12pt}\selectfont 42484 Informācijas sistēmas (bak)} \\
        % 42345 Uzņēmējdarbības vadība (bak.)\\
        % 42345 Uzņēmējdarbības vadība tūrismā\\
        % 47345 Uzņēmējdarbības vadība (maģ.)\\
        % 42484 Informācijas sistēmas (bak)\\
        % 47483 Datorsistēmas (maģ)
  \end{tabular*}


  \vspace{8mm}

  \begin{center}
    {\bfseries\fontsize{16pt}{16pt}\selectfont Dabaszinātņu un datortehnoloģiju katedra}
      % Vadības, Tiesību, Ekonomikas, Dabaszinātņu un datortehnoloģiju, Starptautiskā biznesa komunikāciju, Kultūras un mākslas\\
  \end{center}

  \vspace{10mm}

  \begin{center}
    {\Large INFORMĀCIJAS SISTĒMU MENEDŽMENTA AUGSTSKOLA}\\[2mm]
    {\large (ISMA)}\\[8mm]

    {\bfseries\fontsize{16pt}{16pt}\selectfont \thesistitle}\\[10mm]
    {\bfseries\large BAKALAURA DARBS}\\[18mm]

    \begin{tabular}{@{}p{6cm}p{8cm}@{}}
      Students:& \studentname\\[2mm]
      Darba vadītājs:& \supervisorname\\
    \end{tabular}

    \vfill
    {\thesiscity\ \thesisyear}
  \end{center}

  \clearpage
}

% ===== Front-matter formatting =====
\providecommand{\frontmatterpage}{}

% ===== Utilities =====
% Unnumbered chapter that appears in ToC
\newcommand{\unchapter}[1]{%
  \chapter*{#1}\addcontentsline{toc}{chapter}{#1}%
}

% Lists of Figures/Tables optional toggle (rename to avoid TeX primitive \showlists)
\newif\ifshowlotlof
\showlotloffalse
\newcommand{\enablelists}{\showlotloftrue}

% Bibliography (simple manual list)
\newcommand{\printliterature}{%
  \chapter*{Literature}\addcontentsline{toc}{chapter}{Literature}
  \input{chapters/references.tex}
}

\endinput
