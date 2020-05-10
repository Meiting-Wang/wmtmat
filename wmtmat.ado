* Description: output matrix to Stata interface, Word as well as LaTeX
* Author: Meiting Wang, Master, School of Economics, South-Central University for Nationalities
* Email: wangmeiting92@gmail.com
* Created on May 10, 2020


program define wmtmat
version 15.1

syntax name(id="a matrix name") [using/] [, ///
	replace append FMT(string) ROWSFMT(string) COLSFMT(string) ///
	TItle(string) Alignment(string) PAGE(string)]
/*
optional illustration:
1. name: only a matrix name permitted.
2. fmt(): set the overall format for the reported matrix.
3. rowsfmt(): set the format of each row of the matrix separately.
4. colsfmt(): set the format of each column of the matrix separately.
5. title(): set the title for the reported table, matrix name as the default.
6. alignment(): only used in the LaTeX output, set the column format of the LaTeX
table, but it will not impact the column format in the Stata output table, dot as 
the default.
7. page(): only used in the LaTeX output,set the extra package for the LaTeX code.
please don't need to add the package of booktabs array dcolumn, because the code 
will automatic process these with the option of alignment().
*/


*--------设置默认格式------------
local default_fmt "%11.3f"
local default_la_fmt "%11.3fc"


*---------程序不合规时的报错-----------
if ("`replace'`append'"!="")&("`using'"=="") {
	dis "{error:replace or append can't appear when you don't need to output result to a file.}"
	exit
}

if ("`replace'"!="")&("`append'"!="") {
	dis "{error:replace and append cannot appear at the same time.}"
	exit
}

if ("`fmt'"!="")&("`rowsfmt'"!="") {
	dis "{error:fmt and rowsfmt can't appear at the same time.}"
	exit
}
if ("`fmt'"!="")&("`colsfmt'"!="") {
	dis "{error:fmt and colsfmt can't appear at the same time.}"
	exit
}
if ("`rowsfmt'"!="")&("`colsfmt'"!="") {
	dis "{error:rowsfmt and colsfmt can't appear at the same time.}"
	exit
}

if "`fmt'" != "" {
	local fmt_num: word count `fmt'
	if `fmt_num' != 1 {
		dis "{error:fmt needs to be a single word.}"
		exit
	}
}
if "`rowsfmt'" != "" {
	local rowsfmt_num: word count `rowsfmt'
	if `rowsfmt_num' != rowsof(`namelist') {
		dis "{error:the number of words in rowsfmt() can't match the number of rows in the matrix `namelist'.}"
		exit
	}
}
if "`colsfmt'" != "" {
	local colsfmt_num: word count `colsfmt'
	if `colsfmt_num' != colsof(`namelist') {
		dis "{error:the number of words in colsfmt() can't match the number of cols in the matrix `namelist'.}"
		exit
	}
}

if (~ustrregexm("`using'",".tex"))&("`alignment'`page'"!="") { 
	dis "{error:alignment and page can only be used in the LaTeX output.}"
	exit
}


*---------前期语句处理----------
*普通选项语句的处理
if "`using'" != "" {
	local us_ing "using `using'"
}
if "`title'" == "" {
	local title "Matrix `namelist'[`=rowsof(`namelist')',`=colsof(`namelist')']"
}

*fmt系列语句构建
if "`fmt'" != "" {
	local st_fmt "fmt(`fmt')"
	local st_fmt_la "fmt(`fmt')"
}
else if "`rowsfmt'" != "" {
	local st_fmt `"fmt("`rowsfmt'")"'
	local st_fmt_la `"fmt("`rowsfmt'")"'
}
else if "`colsfmt'" != "" {
	local st_fmt "fmt(`colsfmt')"
	local st_fmt_la "fmt(`colsfmt')"
}
else {
	local st_fmt "fmt(`default_fmt')"
	local st_fmt_la "fmt(`default_la_fmt')"
} //默认值

*构建esttab中alignment()和page()内部的语句(LaTeX输出专属)
if "`alignment'" == "" {
	local alignment "math"
} //设置alignment的默认值

if "`page'" != "" {
	local page ",`page'"
}

if "`alignment'" == "math" {
	local page "array`page'"
	local alignment "*{`=colsof(`namelist')'}{>{$}c<{$}}"
}
else {
	local page "array,dcolumn`page'"
	local alignment "*{`=colsof(`namelist')'}{D{.}{.}{-1}}"
}
//加上array宏包可使得表格线之间的衔接没有空缺


*-----------------主程序---------------
esttab matrix(`namelist', `st_fmt'), compress ///
	nomtitles title(`title')  //Stata 界面显示
if ustrregexm("`us_ing'",".rtf") {
	esttab matrix(`namelist', `st_fmt') `us_ing', compress `replace'`append' ///
		nomtitles title(`title')  //Word 显示
}
if ustrregexm("`us_ing'",".tex") {
	local col_names: colnames `namelist'
	tokenize "`col_names'"
	local i = 1
	local col_new_names ""
	while "``i''" != "" {
		local col_new_names "`col_new_names'\multicolumn{1}{c}{``i''} "
		local `i' "" //置空`i'
		local i = `i' + 1
	}
	mat colnames `namelist' = `col_new_names'
	esttab matrix(`namelist', `st_fmt_la') `us_ing', compress `replace'`append' ///
		nomtitles title(`title')  booktabs width(\hsize) page(`page') ///
		alignment(`alignment') 
	mat colnames `namelist' = `col_names'
} //LaTeX 显示
end
