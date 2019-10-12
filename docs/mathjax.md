# MathJax

  - [MathJax \| Beautiful math in all browsers\.](https://www.mathjax.org/)

      - A JavaScript DISPLAY ENGINE for mathematics that works in all browsers. No more setup for readers. It just works.

        由前端動態轉換!! 另一個專案 [mathjax-node](https://github.com/mathjax/mathjax-node) 支援 server-side 轉換。

      - High-quality typography - MathJax™ uses CSS with web fonts or SVG, instead of bitmap images or Flash, so equations SCALE WITH SURROUNDING TEXT at all zoom levels.

        看似優先採用字型，退而用 SVG；用字型的好處是會跟著周圍的文字一起縮放。

      - Modular Input & Output - MathJax is highly modular on input and output. Use MathML, TeX and ASCIImath as input and produce HTML+CSS, SVG and MathML as output.

        跟使用者比較相關是用什麼 equation markup 寫，雖然 MathML 的輸出需要 browser 支援，但用 MathML 來寫是沒有問題的；似乎 AsciiMath 表示法的可讀性最高?

      - Accessible & reusable - MathJax is compatible with screenreaders & provides zoom for everyone. You can also copy equations into Office, LaTeX, wikis, and other software.

        複製進 Google Docs 沒有作用?? 注意 TeX 不完全等同於 LaTex。

      - A rich API - Use our extensive APIs to create interactive content, advanced authoring tools, and MATH-ENABLED web and mobile apps.

      - Works everywhere - MathJax generates high-quality output on all browsers & platforms - even on IE 6 (if you have to).

        事實上最通用的 CommonHTML 在 IE8+ 也支援了。

    Core Goals

      - The core of the MathJax project is the development of its state-of-the-art, open source, JavaScript platform for display of mathematics. Our key design goals are

        - high-quality display of mathematics notation in all browsers
        - no special browser setup required
        - support for LaTeX, MathML and other EQUATION MARKUP directly in the HTML source.
        - an extensible, modular design with a rich API for easy integration into web applications.
        - support for accessibility, copy and paste and other rich functionality
        - interoperability with other applications and MATH-AWARE SEARCH. ??

    History

      - MathJax grew out of the popular [jsMath](http://www.math.union.edu/~dpvc/jsMath/) project, an earlier AJAX-BASED math rendering system developed by Davide Cervone in 2004. In the following years, there were many significant developments relevant for web publication of mathematics: consolidation of browser support for CSS 2.1, Web Font technology, adoption of MATH ACCESSIBILITY STANDARDS, and increasing usage of XML workflows for SCIENTIFIC PUBLICATION.
      - In 2009, AMS, Design Science, and SIAM formed the MathJax Consortium to enable Cervone and others to design MathJax FROM THE GROUND UP as a next-generation platform, while still benefiting from the extensive real-world experience gained from jsMath. Since its initial release in 2010, MathJax has become the gold standard for MATHEMATICS ON THE WEB.

  - [View Samples - MathJax \| Beautiful math in all browsers\.](https://www.mathjax.org/#samples)

      - Our homepage is configured to use MathJax's CommonHTML mode with web fonts to display the equations, which produces uniform layout and typesetting across browsers. But MathJax can also be configured to use HTML-CSS (for legacy browsers), SVG, and NATIVE MathML rendering when available in a browser.

        除非考量舊的 browser，否則 CommonHTML (rendering mode) 只會用到字型，跟 SVG 無關；其中 MathML 需要 browser 直接支援，像 Chrome 就沒支援。

      - You can try the various output modes using the MathJax context Menu (which you access by ctrl+clicking / alt-clicking an equation) or the button below.

        原來右鍵有進階選項；切換 Select the rendering mode: CommonHTML/MathML/HTML-CSS/SVG，就 CommonHTML 與 SVG 最大的差異，在於選取時 CommonHTML 是個別的字元 (靠字型)，但後者是一張圖。

  - [Browser support - MathJax \| Beautiful math in all browsers\.](https://www.mathjax.org/#browsers)

      - MathJax generates IDENTICAL, high-quality output on all browsers & platforms. Our newer output formats have minimal restrictions on browser support:

          - The HTML-CSS Output supports even IE 6+ (as well as Firefox 3+, Safari 2+, Chrome 1+).
          - The CommonHTML Output supports IE 8+ etc.
          - The SVG Output supports IE 9+ etc.

## 新手上路 ?? {: #getting-started }

  - [Live Demo - MathJax \| Beautiful math in all browsers\.](https://www.mathjax.org/#demo)

      - Type text in the box below. Include some math as MathML, wrap TeX in `$` or `$$` delimiters, and ASCIImath in ``'`'`` delimiters (pre-populated jsbin). The text you enter is actually HTML, so you can include tags if you want; but this also means you have to be careful how you use less-than signs, ampersands, and other HTML special characters (surrounding them by spaces should be sufficient).

        其中 AsciiMath 因為用 backtick 區隔的關係，搭配 Markdown 使用時要跳脫，相對不方便? 如果可以像 [GitLab Wiki](gitlab-wiki.md#math) 一樣用 ```$`...`$``` 來表現會好很多。

            When $a \ne 0$, there are two solutions to \(ax^2 + bx + c = 0\) and they are
            $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$

        都是 TeX 的用法，其中 `\( ... \)` 的寫法叫 in-line mathematics，表現如下：

        > When $a \ne 0$, there are two solutions to \(ax^2 + bx + c = 0\) and they are
        >
        > $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$

        上面 pre-populated jsbin 的內容如下：

            <!DOCTYPE html>
            <html>
            <head>
              <meta charset="utf-8">
              <meta name="viewport" content="width=device-width">
              <title>MathJax example</title>
              <script type="text/javascript" async
              src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/latest.js?config=TeX-MML-AM_CHTML">
            </script>
            </head>
            <body>
            <p>
              When \(a \ne 0\), there are two solutions to \(ax^2 + bx + c = 0\) and they are
              $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$
            </p>
            </body>
            </html>

        看過比較能理解上面 "The text you enter is actually HTML" 的說法，因為 MathJax 的轉換是發生在 browser 上。

        用 AsciiMath 也可以：

            `x = (-b +- sqrt(b^2-4ac))/(2a)`

        > \`x = (-b +- sqrt(b^2-4ac))/(2a)\`

## Server-side Rendering ??

  - [Getting Started - MathJax \| Beautiful math in all browsers\.](https://www.mathjax.org/#gettingstarted) If you prefer to render server-side, you can check out [mathjax-node](https://github.com/mathjax/mathjax-node).

## 安裝設置 {: #setup }

  - [Getting Started - MathJax \| Beautiful math in all browsers\.](https://www.mathjax.org/#gettingstarted) #ril

      - If you write your own HTML (directly or via a template/theme engine), you can include MathJax by adding this snippet to your page:

            <script src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML' async></script>

        或

            <script src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/latest.js?config=TeX-MML-AM_CHTML' async></script>

        Although this refers to a specific version, the `latest.js` file will load the most current version regardless of the one you specified. 好奇特的 URL!!

      - Note: the configuration file `TeX-MML-AM_CHTML` is a great way test all input options at once. You can find leaner combined configuration packages in our documentation.

        其中 `MML`、`AM`、`CHTML` 分別對應 MathML、AsciiMath 與 CommonHTML。

## 參考資料 {: #reference }

  - [MathJax](https://www.mathjax.org/) ([Live Demo](https://www.mathjax.org/#demo))
  - [News | MathJax](https://www.mathjax.org/news/)
  - [mathjax/MathJax - GitHub](https://github.com/mathjax/mathjax)

文件：

  - [MathJax Documentation - Read the Docs](http://docs.mathjax.org/en/latest/)

社群：

  - ['mathjax' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/mathjax)

相關：

  - 支援 [TeX](tex.md)/LaTeX、[AsciiMath](asciimath.md) 做為 equation markup。
