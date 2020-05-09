{smcl}

{* -----------------------------title------------------------------------ *}{...}
{p 0 17 2}
{bf:[W-5] wmtmat} {hline 2} output matrix to Stata interface, Word as well as LaTeX. The source code can be gained in {browse "https://github.com/Meiting-Wang/wmtmat":github}.


{* -----------------------------Syntax------------------------------------ *}{...}
{title:Syntax}

{p 8 8 2}
{bf:wmtmat} {it:a_matrix_name} [using {it:filename}] [, {it:options}]

{p 4 4 2}
where the subcommands can be :

{p2colset 5 22 26 2}{...}
{p2col :{it:subcommand}}Description{p_end}
{p2line}
{p2col :{opt a_matrix_name}}A matrix name required{p_end}
{p2col :{opt {help using}}}Output the result to Word with .rtf file or LaTeX with .tex file{p_end}
{p2line}
{p2colreset}{...}


{* -----------------------------Contents------------------------------------ *}{...}
{title:Contents}

{p 4 4 2}
{help wmtmat##Description:Description}{break}
{help wmtmat##Options:Options}{break}
{help wmtmat##Examples:Examples}{break}
{help wmtmat##Author:Author}{break}
{help wmtmat##Also_see:Also see}{break}


{* -----------------------------Description------------------------------------ *}{...}
{marker Description}{title:Description}

{p 4 4 2}
{bf:wmtmat}, based on esttab, can output matrix to Stata interface, Word as well as LaTeX. User can use this command easily due to its simple syntax. It is worth noting that this command can only be used in version 15.1 or later.

{p 4 4 2}
Users can also append the output from {bf:wmtmat} to a existed word or LaTeX document,
which is more likely to be generated by {help wmtsum}, {help wmttest}, {help wmtcorr} and {help wmtreg}.


{* -----------------------------Options------------------------------------ *}{...}
{marker Options}{title:Options}

{p2colset 5 28 32 2}{...}
{p2col :{it:option}}Description{p_end}
{p2line}
{p2col :For all}{p_end}
{p2col :{space 2}{bf:fmt(}{it:{help format:fmt}}{bf:)}}Format all the values of the matrix{p_end}
{p2col :{space 2}{bf:rowsfmt(}{it:{help format:fmtlist}}{bf:)}}Set the format of each row of the matrix separately{p_end}
{p2col :{space 2}{bf:colsfmt(}{it:{help format:fmtlist}}{bf:)}}Set the format of each column of the matrix separately{p_end}
{p2col :{space 2}{opth ti:tle(strings:string)}}Set the title for the table, {bf:Matrix matrix_name[rown,coln]} like {bf:Matrix B[6,5]} as the default{p_end}
{p2col :{space 2}{opt replace}}Replace a file if it already exists{p_end}
{p2col :{space 2}{opt append}}Append the result to a already existed file{p_end}

{p2col :For LaTeX only}{p_end}
{p2col :{space 2}{opth a:lignment(strings:string)}}Format the table columns in LaTeX, but it will not have influence on the Stata interface. {bf:math} or {bf:dot} can be included, {bf:math} as the default{p_end}
{p2col :{space 2}{bf:page(}{it:{help strings:string}}{bf:)}}Set the extra package for the LaTeX. Don't need to care about the package of booktabs, array and dcolumn, because option {bf:alignment} will deal with it automatically{p_end}
{p2line}
{p2colreset}{...}


{* -----------------------------Examples------------------------------------ *}{...}
{marker Examples}{title:Examples}

{p 4 4 2}Setup{p_end}
{p 8 8 2}. {stata set seed 111111}{break}
. {stata mat B = 3021*matuniform(6,5)}{break}
. {stata mat list B}{p_end}

{p 4 4 2}Present matrix B as a table{p_end}
{p 8 8 2}. {stata wmtmat B}{p_end}

{p 4 4 2}Set the overall numeric format of matrix B to four decimal places{p_end}
{p 8 8 2}. {stata wmtmat B, fmt(4)}{p_end}

{p 4 4 2}Set the format of each row of the matrix B separately{p_end}
{p 8 8 2}. {stata wmtmat B, rowsfmt(1 2 3 4 5 6)}{p_end}

{p 4 4 2}Set the format of each column of the matrix B separately{p_end}
{p 8 8 2}. {stata wmtmat B, colsfmt(0 1 2 3 4)}{p_end}

{p 4 4 2}Add a custom title to the table{p_end}
{p 8 8 2}. {stata wmtmat B, ti(this is a title)}{p_end}

{p 4 4 2}Output the result to a .rtf file{p_end}
{p 8 8 2}. {stata wmtmat B using Myfile.rtf, replace}{p_end}

{p 4 4 2}Output the result to a .tex file{p_end}
{p 8 8 2}. {stata wmtmat B using Myfile.tex, replace}{p_end}

{p 4 4 2}Format table column in LaTeX to decimal point alignment{p_end}
{p 8 8 2}. {stata wmtmat B using Myfile.tex, replace a(dot)}{p_end}


{* -----------------------------Author------------------------------------ *}{...}
{marker Author}{title:Author}

{p 4 4 2}
Meiting Wang{break}
School of Economics, South-Central University for Nationalities{break}
Wuhan, China{break}
wangmeiting92@gmail.com


{* -----------------------------Also see------------------------------------ *}{...}
{marker Also_see}{title:Also see}

{space 4}{help esttab}(already installed)  {col 40}{stata ssc install estout:install esttab}(to install)
{space 4}{help wmtsum}(already installed)  {col 40}{stata github install Meiting-Wang/wmtsum:install wmtsum}(to install)
{space 4}{help wmttest}(already installed) {col 40}{stata github install Meiting-Wang/wmttest:install wmttest}(to install)
{space 4}{help wmtcorr}(already installed)  {col 40}{stata github install Meiting-Wang/wmtcorr:install wmtcorr}(to install)
{space 4}{help wmtreg}(already installed)  {col 40}{stata github install Meiting-Wang/wmtreg:install wmtreg}(to install)
