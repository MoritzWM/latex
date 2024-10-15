% Class declaration
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{preamble}[2022/03/16 Moritz's preamble class]
\author{Moritz Wachsmuth-Melm}

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

\newcommand{\thedocumentclass}{%
    %scrbook%
    %scrreprt%
    scrartcl%
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\thedocumentclass}}
\ProcessOptions\relax
\LoadClass[
a4paper,
cleardoublepage=empty,
toc=bibliography,
toc=index,
% oneside,
% notitlepage,
]{\thedocumentclass}

%================== Basic packages ==================%
% Packages that just should be there in any preamble %
%====================================================%
\RequirePackage[T1]{fontenc}
% \RequirePackage[utf8]{inputenc}
\RequirePackage[full]{textcomp} % required for older texlive distributions when using kpfonts
\RequirePackage[ngerman,english]{babel}
% \RequirePackage[outputdir=output]{minted} % Code syntax highlighting, has to be loaded before csquotes
\RequirePackage[final,nopatch=footnote]{microtype} % Better font spacing and stuff. Final option provides that it is not disabled in draft mode
\RequirePackage[autostyle]{csquotes} % Better quoting, but mainly here because it is recommended for babel and biblatex
\RequirePackage{graphicx}
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
\RequirePackage[
pdfpagelabels=true, % Sets PDF page labels, so that PDF readers can detect different numbering styles (e.g. roman in \frontmatter)
plainpages=false, % Fixes errors caused by page numbering resets (as by \frontmatter, \mainmatter and \backmatter)
hidelinks, % Hidel links (no colorlinks, no link boxes)
bookmarks=true, % Make bookmarks
final, % Make links, no matter if draft mode or not
]{hyperref} 



%========================%
% Styling packages %
%========================%
% \RequirePackage{emptypage} % Ensures removed headers and footers on empty pages (like the one after the title)
\DeclarePrintbibliographyDefaults{title=References}
\RequirePackage{xspace} % In commands, \xspace makes a space after the command only if there is a word. In case of punctuation, it is omitted.
\RequirePackage{setspace}
\RequirePackage{pdflscape} % Landscape pdf pages with \begin{landscape} ... \end{landscape}
\RequirePackage{underscore} % underscore behaves properly in text mode
\RequirePackage[draft=false]{scrlayer-scrpage} % Nice headers and footers
% \RequirePackage{ebgaramond-maths}
% \RequirePackage{lmodern}
\RequirePackage{kpfonts}
\acsgeometry{}
\usepackage{cleveref} % Automatic nice references with \cref, \Cref and \crefrange


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
\DeclareSIUnit{\rpm}{rpm} % Rounds per minute (centrifugation)
\DeclareSIUnit{\hpi}{hpi} % Hours past infection (virology)
\DeclareSIUnit{\PFU}{\textsc{PFU}} % Plaque forming units (virology)
\DeclareSIUnit{\Da}{Da} % Plaque forming units (virology)
\DeclareSIUnit{\kDa}{kDa} % Plaque forming units (virology)
\DeclareSIUnit[number-unit-product = {}]{\percent}{\%} % Remove space before percent sign


%===========%
% Chemistry %
%===========%
\RequirePackage{chemformula} % Stuff like \ch{MgCl2}


%=============%
% Table stuff %
%=============%
\RequirePackage{booktabs} % \toprule, \midrule, \bottomrule, nicer tables (must have!)
\RequirePackage{multirow} % \multicolumn{num_of_columns}{X}{Content} and \multirow{num_of_rows}{X}{Content}


%=========================%
% Floats, figures, images %
%=========================%
\RequirePackage[
    inkscapearea=page,
    inkscapeformat=png,
    inkscapedpi=600,
    % inkscapelatex=false
]{svg}
\RequirePackage{tikz} % Figures you can draw on (text, lines, braces, stuff)
\usetikzlibrary{positioning}
\usetikzlibrary{calc}
\tikzset{
    tight/.style={inner sep=0, outer sep=0},
	tile/.style={tight,draw=none,fill=none,align=center}}


%=============%
% Tikz things %
%=============%
\newcommand{\helplines}{\draw[help lines] (0, 0) grid[xstep=0.1, ystep=0.1] (1, 1)}

% Drawing on figures
\newenvironment{tikzonnode}[1]{%
    \begin{scope}[shift={(#1.south west)},x={(#1.south east)},y={(#1.north west)}]%
        }{%
    \end{scope}%
}
\newenvironment{tikzongraphics}[2][width=\textwidth]{
    \begin{tikzpicture}
        \node[align=center, anchor=south west,inner sep=0] (image) at (0,0) {\includegraphics[#1]{#2}};
        \begin{tikzonnode}{image}
        }{
        \end{tikzonnode}
    \end{tikzpicture}
}

\newcommand{\tikzoverlay}[1]{
    \tikz[overlay,remember picture] {
        #1
    }
}


%===============%
% Miscellaneous %
%===============%
% Print text width and height in draft mode
\makeatletter
\def\convertto#1#2{\strip@pt\dimexpr #2*65536/\number\dimexpr 1#1}
\makeatother
\RequirePackage{ifdraft}
\ifdraft{
    \AtEndDocument{\noindent
        text width: \the\textwidth : \convertto{mm}{\textwidth} mm\\
        text height: \the\textheight : \convertto{mm}{\textheight} mm
    }
}


% ============================================================================%
% ================= Fix booktabs - xltabular incompatibility =================%
% https://tex.stackexchange.com/questions/522920/xltabular-breaking-booktabs %
% ============================================================================%
% is this still necessary?
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
