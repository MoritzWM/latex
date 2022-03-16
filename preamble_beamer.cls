% Class declaration
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{preamble-beamer}[2022/03/16 Moritz's preamble class (beamer)]

% Warns of deprecated LaTeX constructs
\RequirePackage[l2tabu, orthodox]{nag}

%===============%
% Class options %
%===============%
% Based on beamer class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax
\LoadClass{beamer}

% Fix too many alphabets error
\newcommand\hmmax{0}
\newcommand\bmmax{0}

% Add document information
\date{\today}
\author{Moritz Wachsmuth-Melm}

%====================================================%
%================== Basic packages ==================%
% Packages that just should be there in any preamble %
%====================================================%
\RequirePackage[T1]{fontenc} 
% \RequirePackage[utf8]{inputenc}
\RequirePackage[ngerman,english]{babel}
% \RequirePackage[outputdir=output]{minted} % Has to be loaded before csquotes
\RequirePackage{csquotes} % Better quoting, but mainly here because it is recommended for babel and biblatex
\RequirePackage[final]{microtype} % Better font spacing and stuff. Final option provides that it is not disabled in draft mode
\RequirePackage{graphicx}



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
abbreviations=true, % Load abbreviations (\mg, \mmol, \ml etc.)
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
\DeclareSIUnit[number-unit-product = {}]{\percent}{\%} % Remove space before percent sign


%===========%
% Chemistry %
%===========%
\RequirePackage{chemformula} % Stuff like \ch{MgCl2}
\RequirePackage{chemmacros} % Extension of chemformula, most notably contains \iupac{}, very useful for long IUPAC names containing heteroatoms, stereochemistry, greek letters and stuff. Also allows line breaking


%=========================%
% Floats, figures, images %
%=========================%
\RequirePackage{tikz} % Figures you can draw on (text, lines, braces, stuff)
\tikzset{nosep/.style={inner sep=0, outer sep=0}}
\usepackage{multimedia}

%=============%
% Table stuff %
%=============%
\RequirePackage{booktabs} % \toprule, \midrule, \bottomrule, nicer tables (must have!)
\RequirePackage{multirow} % \multicolumn{num_of_columns}{X}{Content} and \multirow{num_of_rows}{X}{Content}

%=======================%
% Consistent references %
%=======================%
% I could use a package like cleveref,
% but they always throw errors for some reason
\newcommand{\tabref}[1]{tab.~\ref{#1}}
\newcommand{\Tabref}[1]{Tab.~\ref{#1}}
\newcommand{\tabrefs}[1]{tabs.~\ref{#1}}
\newcommand{\Tabrefs}[1]{Tabs.~\ref{#1}}
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

\endinput
