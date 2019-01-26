# TeX

  - [TeX \- Wikipedia](https://en.wikipedia.org/wiki/TeX) #ril
      - TeX (`/tɛx, tɛk/`, see below), stylized within the system as TEX, is a typesetting (排版) system (or "FORMATTING system") designed and mostly written by Donald Knuth and released in 1978.

        下面 Pronunciation and spelling 進一步說明 The name TeX is intended by its developer to be `/tɛx/`, with the final consonant (子音) of loch (`[lɑk]`) or Bach (`[bɑk]`). ... English speakers often pronounce it `/ˈtɛk/`, like the first syllable (音節) of technical. 也就是都以 `k` 結果，沒有 `[tɛks]` 的唸法。

      - TeX was designed with two main goals in mind: to allow anybody to produce HIGH-QUALITY BOOKS using minimal effort, and to provide a SYSTEM that would give exactly the SAME RESULTS ON ALL COMPUTERS, at any point in time. TeX is free software, which made it accessible to a wide range of users.

        不只是 formatting language，也是個工具，而 LaTeX 是它的高階應用，更適合用在寫作。

      - TeX is a popular means of typesetting complex mathematical formulae; it has been noted as one of the most sophisticated digital typographical systems. ... It has largely displaced Unix troff, the other favored formatting system, in many Unix installations, which use BOTH for different purposes.

## LaTeX {: #vs-latex }

  - [What's the difference between TeX and LaTeX? \- Quora](https://www.quora.com/Whats-the-difference-between-TeX-and-LaTeX) Victor Eijkhout:
      - LaTeX is a user-friendly EXTENSION of TeX. ... TeX's "LANGUAGE" is based on MACRO SUBSTITUTION: if you have to type the string `"if I recall correctly"` many times, you do

            \def\iirc{if I recall correctly}

        and you use the macro "`\iirc`" in your text.

      - If all your section headings use a large font and boldface, you would define a macro with one PARAMETER

            \def\section#1{{\bf\Large #1}}

        and you write "`\section{Introduction}`" and such.

      - And that is what LaTeX is: a bunch of, sometimes very sophisticated, abbreviations of sequences of TeX COMMANDS. It is a bit like building a new language on top of assembly, but in another sense that comparison is wrong: when you write Java, you can not put bits of assembler in your program. When you write LaTeX, it is quite possible to put bits of TeX in your "program". 看似 LaTeX 是 TeX 比較高階的寫法，但要混用 TeX 也是可以的。

  - [tex core \- What is the difference between TeX and LaTeX? \- TeX \- LaTeX Stack Exchange](https://tex.stackexchange.com/questions/49/)
      - Joseph Wright♦: TeX is both a program (which does the typesetting, `tex-core`) and format (a set of MACROS that the engine uses, `plain-tex`). Looked at in either way, TeX gives you the basics only. If you read the source for The TeXBook, you'll see that Knuth wrote more macros to be able to typeset the book, and made a format for that.

        LaTeX is a generalised SET OF MACROS to let you do many things. Most people don't want to have to PROGRAM TeX, especially to set up things like sections, title pages, bibliographies and so on. LaTeX provides all of that: these are the 'macros' that it is made up of. 似乎可以想成 TeX 是基本的語法，但 LaTeX 包裝了許多可以直接調用的 function，感覺就像是個 library。

      - Juan A. Navarro: In short TeX is all about FORMATTING, for document/template designers, while LaTeX is all about CONTENT, for document writers.

        TeX is a typesetting system. It provides many COMMANDS which allow you to specify the format of your document with great detail (e.g. font styles, spacing, kerning, ligatures, etc.), and has specialized algorithms to compute the optimal FLOW OF TEXT in your document (e.g. where to cut lines, pages, etc.). TeX is all about giving you powerful algorithms and commands to specify even the tiniest detail to make your documents look PRETTY.

        LaTeX is a set of macros built on top of TeX. The idea behind LaTeX is to SHIFT THE FOCUS FROM THE FORMAT TO THE CONTENT OF YOUR DOCUMENT. In LaTeX commands are all about giving a STRUCTURE to the content of your document (e.g. sections, emphasis, tables, indices, etc.). In LaTeX you just say `\section{...}` instead of: selecting a larger font, a different font style, and inserting appropriate spaces before and after the section heading. As LaTeX is built on top of TeX you also get, of course, a beautiful document as your output; but, more importantly, your source input can also be WELL STRUCTURED, EASIER TO READ (and write!) for humans.

        這比 "new language on top of assembly" 的說法更容易懂；`\xxx{}` 可能由 TeX 或 LaTeX 提供，但 `xxx` 若是關於 formatting，大概屬於 TeX，若是關於 structure (無關 formatting)，則比較偏 LaTex。猜想 `\sqrt{...}` 便是由 LaTeX 提供?

  - [Texpad · Help · TeX vs\. LaTeX](https://www.texpad.com/support/latex/advanced/tex-vs-latex) #ril
  - [Levels of TeX \- TeX Users Group](http://www.tug.org/levels.html) #ril

## 安裝設定 {: #installation }

### macOS ??

```
$ brew install tex
...
Error: No available formula with the name "tex"
Installing TeX from source is weird and gross, requires a lot of patches,
and only builds 32-bit (and thus can't use Homebrew dependencies)

We recommend using a MacTeX distribution: https://www.tug.org/mactex/

You can install it with Homebrew Cask:
  brew cask install mactex
```

## 參考資料 {: #reference }

  - [TeX Users Group (TUG)](http://tug.org/)

社群：

  - [TeX - LaTeX Stack Exchange](https://tex.stackexchange.com/)

學習資源：

  - [The TeX FAQ](https://texfaq.org/)

相關：

  - [MathJax](mathjax.md) -- 支援 TeX/LaTeX 做為 equation markup。
  - [LaTeX](latex.md) -- TeX 的高階應用，使寫作時能專注在內容/結構，而非表現方式。
