# Stata 新命令：wmtmat——矩阵的输出

> 作者：王美庭  
> Email: wangmeiting92@gmail.com

## 摘要

本文主要介绍了个人编写的可将矩阵输出至 Stata 界面、Word 以及 LaTeX 的`wmtmat`命令。

## 目录

- **摘要**
- **一、引言**
- **二、命令的安装**
- **三、语法与选项**
- **四、实例**
- **五、输出效果展示**

## 一、引言

本文介绍的`wmtmat`的命令，可以将矩阵输出至 Stata 界面、Word 的 .rtf 文件和 LaTeX 的.tex 文件。基于`esttab`内核，`wmtmat`不仅具有了`esttab`的优点，同时也简化了书写语法。

本文阐述的`wmtmat`命令，和已经推出的`wmtsum`、`wmttest`、`wmtcorr`和`wmtreg`命令，都可以通过`append`选项成为一个整体，将输出结果集中于一个 Word 或 LaTeX 文件中。关于以上系列命令更多的优点，可参见[「Stata 新命令：wmtsum——描述性统计表格的输出」](https://mp.weixin.qq.com/s/oLgXf0KTgoePOnN1mJUllA)。

## 二、命令的安装

`wmtmat`命令以及本人其他命令的代码都将托管于 GitHub 上，以使得同学们可以随时下载安装这些命令。

首先你需要有`github`命令，如果没有，可参见[「Stata 新命令：wmtsum——描述性统计表格的输出」](https://mp.weixin.qq.com/s/oLgXf0KTgoePOnN1mJUllA)进行安装。

然后你就可以运行以下命令安装最新的`wmtmat`命令及其帮助文件了：

```stata
github install Meiting-Wang/wmtmat
```

当然，你也可以`github search`一下，也能找到`wmtmat`命令安装的入口：

```stata
github search wmtmat
```

或许，你还想一下子找到`wmtsum`、`wmttest`、`wmtcorr`、`wmtreg`以及`wmtmat`所有命令在 GitHub 的安装入口，那么你可以：

```stata
github search wmt
```

## 三、语法与选项

**命令语法**：

```stata
wmtmat a_matrix_name [using filename] [, options]
```

> - `a_matrix_name`: 输入要报告或输出的矩阵名
> - `using`: 可以将结果输出至 Word（ .rtf 文件）和 LaTeX（ .tex 文件）

**选项（options）**：

- 一般选项
  - `fmt(fmt)`: 设置矩阵整体的数值格式
  - `rowsfmt(fmtlist)`: 设置矩阵每一行的数值格式
  - `colsfmt(fmtlist)`: 设置矩阵每一列的数值格式
  - `title(string)`: 设置表格的标题，本身的矩阵名称如`Matrix B[6,5]`为默认值。
  - `replace`：将结果输出至 Word 或 LaTeX 时，替换已有的文件
  - `append`：将结果输出至 Word 或 LaTeX 时，可附加在已经存在的文件中
- LaTeX 专有选项
  - `alignment()`：设置 LaTeX 表格的列对齐格式，可输入`math`或`dot`，`math`设置列格式为居中对齐的数学格式（自动添加宏包`booktabs`和`array`），`dot`表示小数点对齐的数学格式（自动添加宏包`booktabs`、`array`和`dcolumn`）。默认为`math`
  - `page()`：可添加用户额外需要的宏包

> - 以上其中的一些选项可以缩写，详情可以在安装完命令后`help wmtmat`

## 四、实例

```stata
* 矩阵输出实例
set seed 111111
mat B = 3021*matuniform(6,5)
mat list B

wmtmat B //在Stata界面输出矩阵B
wmtmat B, fmt(4) //设置矩阵B整体的数值格式为小数点后4位
wmtmat B, rowsfmt(1 2 3 4 5 6) //设置矩阵B每一行的数值格式
wmtmat B, colsfmt(0 1 2 3 4) //设置矩阵B每一列的数值格式
wmtmat B, ti(this is a title) //自定义表格标题
wmtmat B using Myfile.rtf, replace //将矩阵B输出至Word
wmtmat B using Myfile.tex, replace //将矩阵B输出至LaTeX
wmtmat B using Myfile.tex, replace a(dot) //将矩阵B输出至LaTeX，并设置其列格式为小数点对齐
```

> 以上所有实例都可以在`help wmtmat`中直接运行。
> ![](https://imgkr.cn-bj.ufileos.com/4e7202f0-f5f9-4609-a30c-5ebbc156a006.png)

## 五、输出效果展示

- **Stata**

```stata
wmtmat B
```

```stata
Matrix B[6,5]
------------------------------------------------------------
                  c1        c2        c3        c4        c5
------------------------------------------------------------
r1          1034.334   317.541  1733.528   909.122  1752.795
r2           653.846  1217.267   320.685  1685.587  1300.605
r3          1635.799  1501.578   435.018  1685.381  1026.157
r4          2741.905   362.318  2999.887  2765.741  1786.258
r5           670.374   986.722  2544.720  1876.381   501.089
r6           341.259  1677.316  1238.299  1228.905   806.692
------------------------------------------------------------
```

- **Word**

```stata
wmtmat B using Myfile.rtf, replace
```

![](https://imgkr.cn-bj.ufileos.com/4a736b04-9058-4f15-8ab2-12019728d8f6.png)

- **LaTeX**

```stata
wmtmat B using Myfile.tex, replace
```

![](https://imgkr.cn-bj.ufileos.com/b2084ce4-0719-422e-bb81-5739ad8c7a10.png)

```stata
wmtmat B using Myfile.tex, replace a(dot)
```

![](https://imgkr.cn-bj.ufileos.com/ef432a6f-18f4-439f-9477-9656e0498022.png)

> 在将结果输出至 Word 或 LaTeX 时，Stata 界面上也会呈现对应的结果，以方便查看。
