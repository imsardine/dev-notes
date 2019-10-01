# Markdown

  - [Markdown \- Wikipedia](https://en.wikipedia.org/wiki/Markdown) #ril
      - Markdown 是一種容易轉換成 HTML 的純文字格式 (plain text formatting syntax)；and many other formats? 一開始只能轉成 (X)HTML
      - Markdown 同時也是工具名稱 (`Mardown.pl`)。
      - John Gruber 與 Aaron Swartz 於 2004 共同制定，目的是易讀、易寫的純文字格式，可以轉換成 (X)HTML。
      - 最重要的目標是 readability，直接可以閱讀 (readable as-is)，甚至看不出有做 formatting，靈感主要是來自於純文字的 email。
      - Gruber 寫了一個 Perl script `Markdown.pl`，可以將 Mardown 文件轉成 (X)HTML。在那之後被用不同的語言重新實作。
  - [Daring Fireball: Markdown](https://daringfireball.net/projects/markdown/) #ril
      - Markdown = formatting syntax (強調直接可讀 readable as-is) + tool for HTML conversion；語法深受 Email 的影響

## 新手上路 {: #getting-started }

  - [Daring Fireball: Markdown Syntax Documentation](https://daringfireball.net/projects/markdown/syntax) #ril

## Editor ??

  - 多數的 editor 採 source & preview 雙欄顯示的做法，但後來出現了 WYSIWYG 的流派
      - 雖然可以降低非技術人員進入 Markdown 寫作的門檻，但使用這類工具也意謂著不再那麼重視原始文件的可讀性 (或偏好)。
      - 最早採用這種做法的似乎是 [Typora](typora.md)，但後來因為 [open source 的問題](https://github.com/typora/typora-issues/issues/16)，大家都轉向了 [Mark Text](marktext.md)
  - Emacs Markdown Mode http://jblevins.org/projects/markdown-mode/ Emacs 看起來很不錯 #ril

## Standard, Variation ??

  - [Daring Fireball: Markdown Syntax](https://daringfireball.net/projects/markdown/syntax)
  - GitHub Flavored Markdown (GFM)
  - [CommonMark](commonmark.md)

## List ??

  - 雖然說項目符號 `*`/`+`/`-` 可以互換，但工具及多數人似乎都慣用 `-`？尤其 `*` 可以用來強調重點。
  - 原先採 GFM 的 (nested list)，在 Vim 裡可以用 `%s/^ \* /  - /g` 與 `%s/^   \* /      - /g` 取代成符合 four-space rule 的表示法。

參考資料：

  - [LISTS - Daring Fireball: Markdown Basics](https://daringfireball.net/projects/markdown/basics)
      - Unordered/bulleted list 以 `*`/`+`/`-` 做為項目符號 (list marker)，而且可以互換；例如下面的 `*` 可以換成 `+` 或 `-`，但同一層 list 同時用上 `*`/`+`/`-` 會怎樣??

            *   Candy. <-- 注意 `*` 後面跟著 3 個空格 (加起來 4 個字元)，這是為了 item 有內文或 nested item 要內縮 4 格做準備
            *   Gum.
            *   Booze.

      - Ordered/numbered list 則用一般的數字後面加 period (`.`) 做為項目符號，例如：

            1.  Red <-- 注意 `1.` 後面跟著 2 個空格 (加起來一樣 4 個字元)
            2.  Green
            3.  Blue

      - 在 item 間留有空白行，項目符號後的文字會以 `<p>` 來表現，內文跟著內縮 4 格 (或 1 個 tab)，就會形成 multi-paragrah list items，例如：

            *   A list item. <-- 內縮 4 格，項目符號後的第一個字剛好跟內文切齊 (正是 HTML 的表現方式)

                With multiple paragraphs.

            *   Another item in the list.

        產生的 HTML 如下：

            <ul>
            <li><p>A list item.</p>
            <p>With multiple paragraphs.</p></li>
            <li><p>Another item in the list.</p></li>
            </ul>

  - [Lists - Daring Fireball: Markdown Syntax Documentation](https://daringfireball.net/projects/markdown/syntax#list) #ril
      - It’s important to note that the actual numbers you use to mark the list have NO EFFECT on the HTML output Markdown produces. ... The point is, if you want to, you can use ordinal numbers in your ordered Markdown lists, so that the numbers in your source MATCH the numbers in your published HTML. But if you want to be lazy, you don’t have to. 如果考量到原始文件的可讀性，還是乖乖編號吧。
      - List markers typically START AT THE LEFT MARGIN, but may be indented by up to three spaces. List markers must be followed by one or more spaces or a tab. 最多內縮 3 格 (排版上的彈性)，因為 list marker 必須出現在 4 格之內，否則就會視為 code block 了。這才知道項目符號習慣上是 "貼著" 左緣的? 雖然有點不直覺
      - To make lists look nice, you can wrap items with HANGING INDENTS: 一樣是考量原始文件的可讀性，雖然不一定要這麼做；下面兩個 item 的表現是一樣的：

            *   Donec sit amet nisl. Aliquam semper ipsum sit amet velit.
                Suspendisse id sem consectetuer libero luctus adipiscing.
            *   Donec sit amet nisl. Aliquam semper ipsum sit amet velit. <-- 即便如此，作者還是保持項目符號佔用 4 個字元的習慣
            Suspendisse id sem consectetuer libero luctus adipiscing.

      - To put a blockquote within a list item, the blockquote’s `>` delimiters need to be indented. To put a code block within a list item, the code block needs to be indented twice — 8 spaces or two tabs. 這些聽起來都很合理，在編寫 multi-paragraph list items 的內文時，要從內縮 4 格後的位置起算，例如：

            *   A list item with a blockquote:

                > This is a blockquote
                > inside a list item.

                    CODE GOES HERE
                    ANOTHER LINE

  - [Motivation - 5.2List items - GitHub Flavored Markdown Spec](https://github.github.com/gfm/#motivation)
      - 這裡整理了 John Gruber 在 list 方面的陳述 (但就是沒講清楚 sublist) -- These rules specify that a paragraph under a list item must be indented FOUR spaces (presumably, from the left margin, rather than the start of the list marker, but this is not said) ... it is certainly reasonable to infer that all block elements under a list item, including other lists, must be indented four spaces. This principle has been called the FOUR-SPACE RULE.
      - The four-space rule is CLEAR AND PRINCIPLED, and if the reference implementation `Markdown.pl` had followed it, it probably would have become the standard. However, `Markdown.pl` allowed paragraphs and sublists to start with only two spaces indentation, at least on the outer level. Worse, its behavior was inconsistent ...看似很多人都拿 `Markdown.pl` 的實作來補足文件上沒講清楚的地方；但這些不一致，會不會是 `Markdown.pl` 的 bug?
      - Different implementations of Markdown have developed very different rules for determining what comes under a list item. Pandoc and python-Markdown, for example, stuck with Gruber’s syntax description and the four-space rule, while discount, redcarpet, marked, PHP Markdown, and others followed `Markdown.pl`’s behavior more closely. 各有不同的堅持，很不幸地 Markdown 也面臨分裂的問題。
      - The spec given here should correctly handle lists formatted with either the four-space rule or the more FORGIVING `Markdown.pl` behavior, provided they are laid out in a way that is NATURAL FOR A HUMAN TO READ. The strategy here is to let the width and indentation of the list marker determine the indentation necessary for blocks to fall under the list item, rather than having a FIXED AND ARBITRARY number. The writer can think of the body of the list item as a unit which gets indented to the right ENOUGH TO FIT THE LIST MARKER (and any indentation on the list marker). The four-space rule is CLEAR BUT UNNATURAL. The choice of four spaces is arbitrary. It can be LEARNED, but it is not likely to be guessed, and it TRIPS UP (絆倒) beginners regularly. Rather than requiring a fixed indent from the MARGIN, we could require a fixed indent (say, two spaces, or even one space) FROM THE LIST MARKER (which may itself be indented). 在 GitHub 可以寫 Markdown 的地方試過，似乎就是內文要在項目符號後的第一個字之後 (含)：

             * Item 1

               Subparagraph

                   Code block here
                   line 2

               ^ 內縮 4 格從項目符號後的第一個字起算，雖然從 left margin 起算是 6 個字元

               * Sublist item 1
               * Sublist item 2

             * Item 2

      - However, on this proposal indented code would have to be indented six spaces after the list marker. And this would BREAK A LOT OF EXISTING MARKDOWN ... This will match the four-space rule in cases where the list marker plus its initial indentation takes four spaces (a common case), but diverge in other cases. 關鍵就在這裡，因為有些實作堅持 four-space rule，而 GFM 也能正確地表現這樣的文件，結果就是要求自己用符合 four-space rule 的方法寫 Markdown，才能確保在不同 implemenation 下都能正確地被解讀。

## Code Block ??

  - [Code Blocks - Daring Fireball: Markdown Syntax Documentation](https://daringfireball.net/projects/markdown/syntax#precode) #ril

## Table

```
| Header 1 | Header 2 | Header 3 | (1)
| :------- | :------: | ---:     | (2)
| Col 1    | Col 2    | Col 3    | (3)
| Row 2 | Content ||
```

 1. `|` 用來劃分 column；`|` 兩側的空白並非必要，但可以提高可讀性。

 2. `---` (至少 3 個 `-`) 用來隔開 header 與 body。

    在 `---` 單側或兩側加上 `:` 表示靠左、置中、靠右對齊。

 3. 上下行的 `|` 不一定要對齊，但某些時候對齊可以提高可讀性。

---

參考資料：

  - [Inline HTML - Daring Fireball: Markdown Syntax Documentation](https://daringfireball.net/projects/markdown/syntax#html)

    For example, to add an HTML table to a Markdown article:

        This is a regular paragraph.

        <table>
            <tr>
                <td>Foo</td>
            </tr>
        </table>

    原始語法唯一提到 table 的地方。

  - [Organizing information with tables \- GitHub Help](https://help.github.com/en/articles/organizing-information-with-tables)

    Creating a table

      - You can create tables with pipes `|` and hyphens `-`.

        Hyphens are used to create each COLUMN'S HEADER, while pipes SEPARATE each column. You must include a blank line before your table in order for it to correctly render.

            | First Header  | Second Header |
            | ------------- | ------------- |
            | Content Cell  | Content Cell  |
            | Content Cell  | Content Cell  |

        The pipes on either end of the table are optional.

        確認 `|` 兩側的空白並非必要，但可以提高可讀性。

      - Cells can vary in width and do not need to be perfectly aligned within columns. There must be AT LEAST THREE HYPHENS in each column of the header row.

            | Command | Description |
            | --- | --- |
            | git status | List all new or modified files |
            | git diff | Show file differences that haven't been staged |

    Formatting content within your table

      - You can use formatting such as links, inline code blocks, and text styling within your table:

            | Command | Description |
            | --- | --- |
            | `git status` | List all *new or modified* files |
            | `git diff` | Show file differences that **haven't been** staged |

      - You can align text to the left, right, or center of a column by including colons `:` to the left, right, or on both sides of the hyphens within the header row.

            | Left-aligned | Center-aligned | Right-aligned |
            | :---         |     :---:      |          ---: |
            | git status   | git status     | git status    |
            | git diff     | git diff       | git diff      |

      - To include a pipe `|` as content within your cell, use a `\` before the pipe:

            | Name     | Character |
            | ---      | ---       |
            | Backtick | `         |
            | Pipe     | \|        |

  - [github markdown colspan \- Stack Overflow](https://stackoverflow.com/questions/23571724/github-markdown-colspan) #ril

## 如何引用文章段落??

```
> Excerpt ....
> <div style="text-align: right">[Source](http://...)</div>
```

參考資料：

  - How to right-align and justify-align in Markdown? - Stack Overflow https://stackoverflow.com/questions/35077507/ 用 HTML - `<div style="text-align: right"> your-text-here </div>` #ril

## Footnote 註腳 ??

  - [How to add footnotes to GitHub\-flavoured Markdown? \- Stack Overflow](https://stackoverflow.com/questions/25579868/) #ril
      - Chris: GFM 不支援 footnote，但可以自己用 `<sup>1</sup>` 模擬。
      - Guildenstern: 可以按慣例把數字寫在 `[]` 裡，例如 `[1]`，這是很常見的手法。
      - Surya Sankar: 在文件下方寫 footnote `<a name="myfootnote1">1</a>: Footnote content goes here`，再搭配 `<sup>[1](#myfootnote1)</sup>` 連往 footnote。

## 有沒有可以分析文件結構的 Python 套件??

  - 有沒有找出 headline 及 list 的套件?? 可以把內容取出來畫成 mind map 之類的 ...
  - alvinwan/md2py: converts markdown into a Python parse tree https://github.com/alvinwan/md2py 有點陽春?
  - python - Parse and traverse elements from a Markdown file - Stack Overflow https://stackoverflow.com/questions/27349951/ Waylan: Mistune 採用 two step process，第一步先轉成 parse tree，第二步才是轉成 HTML。
  - Help with parse-only use · Issue #98 · lepture/mistune https://github.com/lepture/mistune/issues/98 最後是繼承 `Renderer` 自訂 #ril

## 投影片 ??

  - [visit1985/mdp: A command\-line based markdown presentation tool\.](https://github.com/visit1985/mdp) #ril
  - [jaspervdj/patat: Terminal\-based presentations using Pandoc](https://github.com/jaspervdj/patat) #ril
  - [ksky521/nodeppt: This is probably the best web presentation tool so far\!](https://github.com/ksky521/nodeppt) #ril
  - [tslide/tslide: Terminal SlideDeck, supporting markdown\.](https://github.com/tslide/tslide) 利用 iTerm 2 的特性顯示圖片 #ril
  - [hiroppy/fusuma: ✍️Easily make slides with markdown\.](https://github.com/hiroppy/fusuma)
  - [sinedied/backslide: CLI tool for making HTML presentations with Remark\.js using Markdown](https://github.com/sinedied/backslide) 包裝 remark.js #ril
  - [yihui/xaringan: Presentation Ninja 幻灯忍者 · 写轮眼](https://github.com/yihui/xaringan) 好像也是包裝 remark.js? #ril
  - [egonSchiele/mdpress: \[DEAD\] Make impress\.js presentations from markdown files\.](https://github.com/egonschiele/mdpress)
  - [tybenz/vimdeck: VIM as a presentation tool](https://github.com/tybenz/vimdeck)

## 其他

Outline:

  - Quick Start 只是單純說明用法，沒有要注意的地方 (比如不怎麼樣，就會怎樣，只有 happy path)，沒有什麼寫法比較好...
  - 為什麼 Copy Link extension 會在裡頭加 escape，這部份有定義在 spec 裡嗎??
  - 先介紹最基本的語法，再帶出不同的 flavor/variant；http://johnmacfarlane.net/babelmark2/[Babelmark 2 - Compare markdown implementations] 可以用來比對各種實作的不同。
  - 變種 vs. 標準化 (CommonMark)，尤其是 Gruber 的觀點。
  - 可以安插練習題的話還不錯；用 Markdow 做出一份文件，用到所有的語法
  - 連結 (相對)、插入圖片、圖片連結、表格
  - 為什麼要學? 共筆 (Wiki)、
  - 幾個一定要懂的 flavor - GitHub、StackOverflow、WordPress
  - 相關的工具 HackMD、Atom https://toomuchlatte.com/2016/06/15/my-complete-atom-io-package-list-for-writing-markdown/[My Complete Atom.io Package List for Writing Markdown – TOO MUCH LATTE] 對 Markdown 的支援真不少
   ** https://www.zybuluo.com/mdeditor 大陸人寫的 很強大 竟能畫流程圖、甘特圖等
  - 一張同時有各種 flavor 的 cheat sheet。
  - 用 font awesome 來模擬 
      - NOTE `<i class="fa fa-sticky-note-o fa-3x"></i>` 註記
      - TIP `<i class="fa fa-lightbulb-o fa-3x"></i>` 提示
      - IMPORTANT `<i class="fa fa-exclamation-circle fa-3x"></i>` 重要
      - WARNING `<i class="fa fa-exclamation-triangle fa-3x"></i>`
      - CAUTION `<i class="fa fa-fire fa-3x"></i>`

TBD:

  - 編輯時，建議採用等寬字
  - 標題後面的 `#` 可以省略 (數量通常會一樣)
  - 引用，通常要註明出處，Markdown 怎麼做
  - multi-paragraph list items 在 `1.` 前後加個空白，nested graph 剛好可以對齊。
  - Markdown 對待 block-level HTML tag 跟 Span-level HTML tag 的內容方式大不同，跟 HTML 並存的關係有必要解釋清楚。
  - 內縮 4 格於 code block 的差異；都是等寬字，但後者會有行號，這也滿合理的，因為後者才是 code block (但 GitBook 沒有這個差別，在 Hexo/NeXT 及 WordPress 都有差別)
  - 發覺 reference-style link 比較適合 external link (通常比較長)，而 inline-style link 則比較適合 internal link (通常比較短)
  - 越發覺得 reference-style link 的設計真好，內縮一格的可讀性會更高。適時用 `[text][]`，尤其 `[code][]` .. 注意 reference 的 backticks 不能省
  - Markdown 不像 AsciiDoc 會把 `=>` 轉換成箭頭 => http://unicode-table.com/en/sets/arrows-symbols/ 直接輸入 Unicode 字元

  - 如何建立表格?
  - 有沒有可以分析文件結構的 Python 套件??
  - AsciiDoc 的圖片有 caption，現在沒有要怎麼做?? => 可以考慮插入 `<i class="fa fa-camera"></i>`
  - 沒有像 AsciiDoc 的 callout，有沒有 Markdown 的替代方案?? 用 `// (1)` 圓括號比較直觀，之後貼到 WordPress 也比較不會有問題。
  - GFM 的 code block 似乎跟內縮 4 格的表現會一樣??
  - 在某些平台，會不會只支援 Markdown 的 subset，比如在 SO 的 comment 裡，怎麼可能用 reference-style link??
  - 瞭解 https://daringfireball.net/projects/markdown/syntax 中的 "Markdown is not a replacement for HTML" 這一段，大概就能理解為何 Gruber 不建議擴充 Markdown??
  - 如果 `_` 是強調，而 `__` 是畫重點，在實務上只會 `__` 包著 `_`，不會是倒過來的用法??
  - http://daringfireball.net/projects/markdown/index.text 這裡的 reference link 習慣在前面加兩個空白??
  - 同一行裡面出現多個 `_` 或 `*` 時，很難控制它的表現，有沒有規則??
  - 如果不支援就用 HTML 的理念，後來對 Markdown 的擴充，是不是違背了這樣的想法??
  - 怎麼做 TOC，怎麼為 header 加上 anchor?? => http://daringfireball.net/projects/markdown/syntax.text
  - 同一份文件裡 reference link 的 link name 好像可以定義多次?? => http://daringfireball.net/projects/markdown/syntax.text 另外 http://daringfireball.net/projects/markdown/index.text 出現在 header 後加上 `<a id="..." />` 的用法，試過 `## 標題二 <a id="anchor" /> ##` 這樣也可以
  - http://daringfireball.net/projects/markdown/dingus 採用 Markdown 1.0.2b7 這是怎麼回事??
  - 在團隊裡使用 Markdown 要注意什麼?? => style 吧，前後要不要空白、要不要斷行等 (一行不要超過 80 個字?)，重點就是要維持原文的可讀性；雖然說只要產出的結果一樣就好，但 Markdown 在設計上也強調原始文件的可讀性；採用 inline link 還是 reference link，後者確實能大大提高可讀性。標題前的 `#` 跟文字要空一格
  - https://github.com/tj/mad 用來預覽 markdown manual ??
  - 慣用的副檔名?? => `.md` 或 `.markdown`?
  - 怎麼在 terminal 裡預覽 Markdown?? https://github.com/axiros/terminal_markdown_viewer[axiros/terminal_markdown_viewer: Styled Terminal Markdown Viewer] https://linux.die.net/man/1/markdown http://tosbourn.com/view-markdown-files-terminal/[View Markdown Files in your Terminal] 常見的解法都是 pandoc + lynx/w3m http://unix.stackexchange.com/questions/4140/markdown-viewer => https://coderwall.com/p/iryumw/viewing-markdown-files-in-terminal http://brettterpstra.com/projects/mdless/ 更酷 (Ruby)，搭配 iTerm2 顯示圖形 ... 或許 syntax highlighting 就已經足夠??
  - https://github.com/adam-p/markdown-here/[adam-p/markdown-here: Google Chrome, Firefox, and Thunderbird extension that lets you write email in Markdown and render it before sending.] 的星星數也太多!!

## 參考資料 {: #reference }

  - [Daring Fireball: Markdown](https://daringfireball.net/projects/markdown/)

手冊：

  - [GitHub Flavored Markdown Spec](https://github.github.com/gfm/)
  - [Daring Fireball: Markdown Syntax Documentation](https://daringfireball.net/projects/markdown/syntax)
