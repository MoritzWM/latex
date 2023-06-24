% Class declaration
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{preamble_beamer}[2022/03/16 Moritz's preamble class (beamer)]

% Warns of deprecated LaTeX constructs
\RequirePackage[l2tabu, orthodox]{nag}

%===============%
% Class options %
%===============%
\newcommand{\background}{light}
\DeclareOption{dark}{
	\renewcommand{\background}{dark}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax
\LoadClass[aspectratio=169]{beamer}

%==================================%
% Custom environments and commands %
%==================================%
% Movie inclusion with media9
\newcommand{\movie}[2]{%
    \includemedia[%
        addresource=#2,%
        activate=pageopen,%
        passcontext,%
        flashvars={%
            source=#2%
            &loop=true%
        }]{#1}{VPlayer.swf}%
}
\usetheme[numbering=none,background=\background]{metropolis}

\endinput
