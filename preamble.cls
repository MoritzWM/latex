% Class declaration
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{preamble}[2022/03/16 Moritz's preamble class]

% Warns of deprecated LaTeX constructs
\RequirePackage[l2tabu, orthodox]{nag}

%===============%
% Class options %
%===============%
% ACS StyleGuide margins (default: disabled)
\newcommand{\acsgeometry}{}
\DeclareOption{geometry}{
	\renewcommand{\acsgeometry}{\RequirePackage[left=1.50cm, right=1.50cm, top=3.00cm, bottom=3.00cm]{geometry}}
}
% Colorlinks yes or no (default no)
\newcommand{\colorlinksenabled}{false}
\DeclareOption{colorlinks}{
	\renewcommand{\colorlinksenabled}{true}
}

% Based on scrbook class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ProcessOptions\relax
\LoadClass[
a4paper,
twoside,
cleardoublepage=empty,
titlepage,
toc=bibliography,
toc=index,
]{scrbook}

% Fix too many alphabets error
\newcommand\hmmax{0}
\newcommand\bmmax{0}

% Add document information
\date{\today}
\author{Moritz Wachsmuth-Melm}

%===============================%
% Extra settings for draft mode %
%===============================%
\RequirePackage{ifdraft}
\ifdraft{
	\RequirePackage{silence}
	\WarningFilter{latex}{Marginpar on page} % Todonotes cause this warning
}{}

%====================================================%
%================== Basic packages ==================%
% Packages that just should be there in any preamble %
%====================================================%
\RequirePackage[T1]{fontenc} 
% \RequirePackage[utf8]{inputenc}
\RequirePackage[ngerman,english]{babel}
\RequirePackage[autostyle]{csquotes} % Better quoting, but mainly here because it is recommended for babel and biblatex
\RequirePackage[
backend=biber,
doi=true,
url=false,
eprint=false,
style=numeric-comp, % Haven't decided on a style yet
sorting=none, % Sorts in citation order, which is the only sorting method that makes sense if using numeric style
autocite=inline, % Options: plain,inline,footnote,superscript,
hyperref=true
]{biblatex} % Biblatex, integrate with zotero using: https://github.com/retorquere/zotero-better-bibtex
\RequirePackage[final]{microtype} % Better font spacing and stuff. Final option provides that it is not disabled in draft mode
\RequirePackage[
pdfpagelabels=true, % Sets PDF page labels, so that PDF readers can detect different numbering styles (e.g. roman in \frontmatter)
plainpages=false, % Fixes errors caused by page numbering resets (as by \frontmatter, \mainmatter and \backmatter)
colorlinks=\colorlinksenabled, % Make links (as in TOC or references to figures) font red instead of drawing a red box around them. Colorlinks are also visible in print, boxes are not
bookmarks=true, % Make bookmarks
final, % Make links, no matter if draft mode or not
]{hyperref} 
\RequirePackage{graphicx}


%========================%
% Styling packages %
%========================%
% \RequirePackage{emptypage} % Ensures removed headers and footers on empty pages (like the one after the title)
\DeclarePrintbibliographyDefaults{title=References}
\RequirePackage{xspace} % In commands, \xspace makes a space after the command only if there is a word. In case of punctuation, it is omitted.
\RequirePackage[onehalfspacing]{setspace}
\RequirePackage{pdflscape} % Landscape pdf pages with \begin{landscape} ... \end{landscape}
\RequirePackage{underscore} % underscore behaves properly in text mode
\RequirePackage[draft=false]{scrlayer-scrpage} % Nice headers and footers
% \RequirePackage{ebgaramond-maths}
% \RequirePackage{lmodern}
\RequirePackage{kpfonts}
\acsgeometry{}

%=========%
% SIUnitx %
% =========%
\RequirePackage[
per-mode=reciprocal-positive-first, % Format of units (fraction or reciprocal)
locale=US, % Set locale
range-units=single, % Don't repeat units in number ranges
list-units=single, % Don't repeat units in number lists
detect-all, % Apply same font settings to the number/unit as the surrounding text
forbid-literal-units=true, % Only allow predefined units to enforce consistency
use-xspace=true, % Correct space after unit
]{siunitx} % Nice SI units, but also for number formatting/alignment in tables (with s and S column specifier)
% Declare custom units (mainly chemistry and biology related)
\DeclareSIUnit{\basepair}{bp} % Basepairs
\DeclareSIUnit{\base}{b} % Bases
\DeclareSIUnit{\molar}{\textsc{m}} % Molarity (mol/l)
\DeclareSIUnit{\mmolar}{\milli\molar} % Short form
\DeclareSIUnit{\umolar}{\micro\molar} % Short form
\DeclareSIUnit{\enzymeunit}{U} % Enzyme activity units
\DeclareSIUnit{\electron}{e\textsuperscript{-}} % Electrons
\DeclareSIUnit{\xg}{xg} % Centrifugal force (g)
\DeclareSIUnit{\rpm}{rpm} % Rounds per minute (centrifuges)
\DeclareSIUnit{\hpi}{hpi} % Hours past infection (virology)
\DeclareSIUnit{\PFU}{\textsc{PFU}} % Plaque forming units (virology)
\DeclareSIUnit[number-unit-product = {}]{\percent}{\%} % Remove space before percent sign


%=====================%
% Chemistry and maths %
%=====================%
\RequirePackage{chemformula} % Stuff like \ch{MgCl2}
\RequirePackage{chemmacros} % Extension of chemformula, most notably contains \iupac{}, very useful for long IUPAC names containing heteroatoms, stereochemistry, greek letters and stuff. Also allows line breaking


%=========================%
% Floats, figures, images %
%=========================%
% \RequirePackage[section]{placeins} % Floats can not be printed behind the next section.
\RequirePackage{tikz} % Figures you can draw on (text, lines, braces, stuff)
\tikzset{nosep/.style={inner sep=0, outer sep=0}}
\RequirePackage{subcaption} % Subfigures, subcaptions
\captionsetup{subrefformat=parens}

%=============%
% Table stuff %
%=============%
\RequirePackage{booktabs} % \toprule, \midrule, \bottomrule, nicer tables (must have!)
\RequirePackage{multirow} % \multicolumn{num_of_columns}{X}{Content} and \multirow{num_of_rows}{X}{Content}
\RequirePackage{xltabular} % A combination of longtable and tabularx. Useful for multi-page tables


%===============%
% Miscellaneous %
% ===============%
\RequirePackage[obeyFinal]{todonotes} % Allows TODO notes in the text with \todo{note}, then can make a \listoftodos
\AtBeginDocument{\listoftodos}

%=======================%
% Consistent references %
%=======================%
% I could use a package like cleveref,
% but they always throw errors for some reason
\newcommand{\tabref}[1]{table~\ref{#1}}
\newcommand{\Tabref}[1]{Table~\ref{#1}}
\newcommand{\tabrefs}[1]{tables~\ref{#1}}
\newcommand{\Tabrefs}[1]{Tables~\ref{#1}}
\newcommand{\figref}[1]{fig.~\ref{#1}}
\newcommand{\Figref}[1]{Fig.~\ref{#1}}
\newcommand{\figrefs}[1]{figs.~\ref{#1}}
\newcommand{\Figrefs}[1]{Figs.~\ref{#1}}

% Custom environment: tikzonimage
\newenvironment{tikzonimage}[2][width=\textwidth]{
    \begin{tikzpicture}
        \node[align=center, anchor=south west,inner sep=0] (image) at (0,0) {\includegraphics[#1]{#2}};
        \begin{scope}[x={(image.south east)},y={(image.north west)}]
        }{
        \end{scope}
    \end{tikzpicture}
}

% ============================================================================%
% ================= Fix booktabs - xltabular incompatibility =================%
% https://tex.stackexchange.com/questions/522920/xltabular-breaking-booktabs %
% ============================================================================%
\makeatletter
\def\@BTrule[#1]{%
  \ifx\longtable\undefined
  \let\@BTswitch\@BTnormal
  \else\ifx\hline\LT@hline
  \nobreak
  \let\@BTswitch\@BLTrule
  \else
  \let\@BTswitch\@BTnormal
  \fi\fi
  \global\@thisrulewidth=#1\relax
  \ifnum\@thisruleclass=\tw@\vskip\@aboverulesep\else
  \ifnum\@lastruleclass=\z@\vskip\@aboverulesep\else
  \ifnum\@lastruleclass=\@ne\vskip\doublerulesep\fi\fi\fi
  \@BTswitch}
\makeatother

\endinput
