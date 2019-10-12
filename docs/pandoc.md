# Pandoc

  - [Pandoc \- About pandoc](https://pandoc.org/) #ril
      - A UNIVERSAL document converter. If you need to convert files from one markup format into another, pandoc is your swiss-army knife.
      - Pandoc can convert documents in (several DIALECTS of) Markdown, ... 支援在不同的 markup format (dialect) 間轉換；包括 Markdown (CommonMark、GFM)、reStructuredText、AsciiDoc、MediaWiki、Emac Org-Mode、Microsoft Word (docx)、LibreOffice (ODT)、EPUB、PDF 等。

        但並不是所有的格式都支援雙向轉換，例如 input 不支援 AsciiDoc，但 output 就支援；最下方 input 與 output format 的對照圖，很明顯 output 比 input 多很多。

      - There are many ways to customize pandoc to fit your needs, including a TEMPLATE system?? and a powerful system for writing FILTERS??.
      - Pandoc includes a HASKELL LIBRARY and a standalone command-line program. The library includes separate modules for each input and output format, so adding a new input or output format just requires adding a new module. 上面提到 "custom writers can be written in lua."，但專案本身是用 Haskell 寫的??

## 應用實例 {: #powered-by }

  - [Install and Use Pandoc](https://support.typora.io/Install-and-Use-Pandoc/) [Typora](typora.md) 的 import/export 功能就是靠 Pandoc 來達成。
  - [Pandoc Extras · jgm/pandoc Wiki](https://github.com/jgm/pandoc/wiki/Pandoc-Extras) 一堆整合 Pandoc 的應用。

## Hello, World! ??

```
$ echo '[Google](http://www.google.com)' | pandoc --from markdown --to asciidoc
http://www.google.com[Google]
```

## 新手上路 ?? {: #getting-started }

  - [Pandoc \- Getting started with pandoc](https://pandoc.org/getting-started.html) #ril
  - [Examples - Pandoc \- Demos](https://pandoc.org/demos.html#examples) #ril
  - [Pandoc \- FAQs](https://pandoc.org/faqs.html) #ril

## Markdown ??

  - [Pandoc \- About pandoc](https://pandoc.org/) #ril
      - Markdown (including CommonMark and GitHub-flavored Markdown)
      - Pandoc understands a number of useful markdown syntax extensions, including ... If strict markdown compatibility is desired, all of these extensions can be turned off. 看起來 Markdown 的變異很多，Pandoc 背後是用哪個套件在處理??
  - [Pandoc’s Markdown - Pandoc \- Pandoc User’s Guide](https://pandoc.org/MANUAL.html#pandocs-markdown)

## 疑難排解 {: #troubleshooting }

### 轉換後的文件被斷在 80 行左右 ??

  - [Pandoc wraps line in markdown at the wrong point · Issue \#3277 · jgm/pandoc](https://github.com/jgm/pandoc/issues/3277)
      - jgm: (owner) If you don't want pandoc to rewrap lines, use `--wrap=none`.
  - [`--wrap=auto|none|preserve` - Pandoc \- Pandoc User’s Guide](https://pandoc.org/MANUAL.html#option--wrap)
      - Determine how text is wrapped in the output (the source code, not the rendered version). With `auto` (the default), pandoc will attempt to wrap lines to the column width specified by `--columns` (default `72`). With `none`, pandoc will not wrap lines at all. With `preserve`, pandoc will attempt to preserve the wrapping from the source document (that is, where there are nonsemantic newlines in the source, there will be nonsemantic newlines in the output as well). Automatic wrapping does NOT currently work in HTML output.

        看起來 `preserve` 會是比 `none` 更好的選擇，尊重原始文件的想法。

## 安裝設置 {: #setup }

  - [Pandoc \- Installing pandoc](https://pandoc.org/installing.html) #ril

### macOS ??

  - [macOS - Pandoc \- Installing pandoc](http://pandoc.org/installing.html#macos) #ril
      - 在 [GitHub Releases](https://github.com/jgm/pandoc/releases) 可以下載到 installer，不過解除安裝要跑 Perl!? 還好有另外提供 `.zip` 免安裝的版本，解壓縮就可以使用。

## 參考資料 {: #reference }

  - [Pandoc](https://pandoc.org/)
  - [jgm/pandoc - GitHub](https://github.com/jgm/pandoc)

工具：

  - [Try Pandoc!](http://pandoc.org/try/) - 線上轉換，也會幫忙拼出 `pandoc --from xxx --to yyy` 指令

手冊：

  - [`pandoc` CLI - Pandoc User’s Guide](https://pandoc.org/MANUAL.html)
  - [Input & Output Formats - Pandoc](https://pandoc.org/)
  - [API Documentation](http://hackage.haskell.org/package/pandoc)
