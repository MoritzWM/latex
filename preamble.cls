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
\newcommand{\setspace}{}
\DeclareOption{onehalfspacing}{
	\renewcommand{\setspace}{\RequirePackage[onehalfspacing]{setspace}}
}
\DeclareOption{doublespacing}{
	\renewcommand{\setspace}{\RequirePackage[doublespacing]{setspace}}
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
\input{preamble_common.tex}
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
\setspace{}
\RequirePackage{pdflscape} % Landscape pdf pages with \begin{landscape} ... \end{landscape}
\RequirePackage{underscore} % underscore behaves properly in text mode
\RequirePackage[draft=false]{scrlayer-scrpage} % Nice headers and footers
% \RequirePackage{ebgaramond-maths}
% \RequirePackage{lmodern}
\RequirePackage{kpfonts}
\acsgeometry{}
\usepackage{cleveref} % Automatic nice references with \cref, \Cref and \crefrange


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
