# reStructuredText (RST, reST)

  - [reStructuredText \- Wikipedia](https://en.wikipedia.org/wiki/ReStructuredText) #ril
  - [reStructuredText - Docutils](http://docutils.sourceforge.net/rst.html) #ril

## 新手上路 {: #getting-started }

  - [A ReStructuredText Primer — Docutils 3\.0 documentation](https://docutils.readthedocs.io/en/sphinx-docs/user/rst/quickstart.html) #ril
  - [Learn restructured text \(RST\) in Y Minutes](https://learnxinyminutes.com/docs/rst/) #ril
  - [reStructuredText — Sphinx 3\.0\.0\+/f7bf66012 documentation](http://www.sphinx-doc.org/en/master/usage/restructuredtext/index.html) #ril

## Directive ??

  - [reStructuredText Directives](http://docutils.sourceforge.net/docs/ref/rst/directives.html) #ril

      - This document describes the directives implemented in the reference reStructuredText parser.

        Directives have the following syntax:

            +-------+-------------------------------+
            | ".. " | directive type "::" directive |
            +-------+ block                         |
                    |                               |
                    +-------------------------------+

        Directives begin with an EXPLICIT MARKUP START (two periods and a space), followed by the DIRECTIVE TYPE and two colons (collectively, the "DIRECTIVE MARKER").

      - The directive block begins IMMEDIATELY after the directive marker, and includes all SUBSEQUENT INDENTED LINES.

        好特別的語法，整個用 `.. ` 內縮，然後是 directive type 後面跟著 directive block，中間用 `::` 隔開；在 directive block 跟 `::` 通常都會有個空白，但並不是必要 ??

      - The directive block is divided into ARGUMENTS, OPTIONS (a field list), and CONTENT (in that order), any of which may appear. See the Directives section in the reStructuredText Markup Specification for syntax details.

        用空白行拆分 ??

      - Descriptions below list "doctree elements" (document tree element names; XML DTD generic identifiers) corresponding to individual directives. For details on the hierarchy of elements, please see The Docutils Document Tree and the Docutils Generic DTD XML document type definition.

        Doctree elements 指的是這個 directive type 可能產生哪些 doctree element ??

  - [Directives - reStructuredText Markup Specification](http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#directives) #ril

## 參考資料 {: #reference }

  - [reStructuredText - Docutils](http://docutils.sourceforge.net/rst.html)
  - [docutils - PyPI](https://pypi.org/project/docutils/)

工具：

  - [Online reStructuredText Editor](http://rst.ninjs.org/)

手冊：

  - [reStructuredText Markup Specification](http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html)
  - [The Docutils Document Tree](http://docutils.sourceforge.net/docs/ref/doctree.html)
  - [Docutils Generic DTD](http://docutils.sourceforge.net/docs/ref/docutils.dtd)

相關：

  - [Sphinx](sphinx.md) 的內容主要以 reStructuredText 撰寫。
