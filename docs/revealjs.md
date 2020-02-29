# reveal.js

  - [hakimel/reveal\.js: The HTML Presentation Framework](https://github.com/hakimel/reveal.js/)

      - A FRAMEWORK for easily creating beautiful presentations using HTML. [Check out the live demo](https://revealjs.com/).

        這個專案的星星數有 50.5k，有點誇張!!

      - reveal.js comes with a broad range of features including nested slides, Markdown support, PDF export, speaker notes and a JavaScript API. There's also a fully featured visual editor and platform for sharing reveal.js presentations at slides.com.

      - Presentations are written using HTML or Markdown but there's also an online editor for those of you who prefer a graphical interface. Give it a try at https://slides.com.

        Markdown 的用法並不是事先用工具轉成 HTML，而是內嵌在 HTML，在 browser 裡動態解析；所以 Slides.com 應該沒有上傳 Markdown 的選項。

      - This project was started and is maintained by @hakimel with the help of many contributions from the community. The best way to support the project is to become a paying member of Slides.com—the reveal.js presentation platform that Hakim is building.

        原來 slides.com 是作者 Hakim 建的商用平台。

## 新手上路 {: #getting-started }

  - [Markup - Instructions - hakimel/reveal\.js: The HTML Presentation Framework](https://github.com/hakimel/reveal.js/#markup)

      - Here's a BAREBONEs example of a fully working reveal.js presentation:

            <html>
              <head>
                <link rel="stylesheet" href="css/reveal.css">
                <link rel="stylesheet" href="css/theme/white.css">
              </head>
              <body>
                <div class="reveal">
                  <div class="slides">
                    <section>Slide 1</section>
                    <section>Slide 2</section>
                  </div>
                </div>
                <script src="js/reveal.js"></script>
                <script>
                  Reveal.initialize();
                </script>
              </body>
            </html>


        The presentation markup hierarchy needs to be `.reveal > .slides > section` where the `section` represents one slide and can be repeated indefinitely.

        這就是所謂的 framework，順著它的安排加上內容、調整設定即可；幾乎都在 HTML 裡進行 ??

      - If you place multiple `section` elements inside of another `section` they will be shown as VERTICAL slides.

        The first of the vertical slides is the "ROOT" of the others (at the top), and will be included in the HORIZONTAL SEQUENCE. For example:

            <div class="reveal">
              <div class="slides">
                <section>Single Horizontal Slide</section>
                <section>
                  <section>Vertical Slide 1</section>
                  <section>Vertical Slide 2</section>
                </section>
              </div>
            </div>

        也就是 "Single Horizontal Slide" 往右會看到 "Vertical Slide 1"，接著要往下才看得到 "Vertical Slide 2"。

## Markdown

  - [Markdown - Instructions - hakimel/reveal\.js: The HTML Presentation Framework](https://github.com/hakimel/reveal.js/#markdown)

      - It's possible to write your slides using Markdown. To enable Markdown, add the `data-markdown` attribute to your `<section>` elements and wrap the contents in a `<textarea data-template>` like the example below.

        為什麼要包裝在 `<textarea>` 裡??

        You'll also need to add the `plugin/markdown/marked.js` and `plugin/markdown/markdown.js` scripts (in that order) to your HTML file.

      - This is based on [data-markdown](https://gist.github.com/1343518) from Paul Irish modified to use [marked](https://github.com/chjj/marked) to support GitHub Flavored Markdown.

        `index.html` 預設就引用了 `plugin/markdown/marked.js` 跟 `plugin/markdown/markdown.js`。

        SENSITIVE to indentation (avoid mixing tabs and spaces) and line breaks (avoid consecutive breaks).

            <section data-markdown>
              <textarea data-template>
                ## Page title

                A paragraph with some text and a [link](http://hakim.se).
              </textarea>
            </section>

        原來 Markdown 的解析也在 browser 裡；每個 `section` 都要加 `data-markdown` 與 `text-area` 有點麻煩? 不過 reveal.js 就是個 framework，若要直接從 Markdown 轉 HTML (可能會失去一些彈性)，是有像 [reveal-md](https://github.com/webpro/reveal-md) 這類的工具。

  - [External Markdown - hakimel/reveal\.js: The HTML Presentation Framework](https://github.com/hakimel/reveal.js/#external-markdown) #ril
  - [Configuring markd - hakimel/reveal\.js: The HTML Presentation Framework](https://github.com/hakimel/reveal.js/#configuring-marked) #ril
  - [rstudio/revealjs: R Markdown Format for reveal\.js Presentations](https://github.com/rstudio/revealjs) #ril

## Configuration {: #config }

  - [Configuration - hakimel/reveal\.js: The HTML Presentation Framework](https://github.com/hakimel/reveal.js/#configuration) #ril

## Hosting

  - 首推 [HackMD](hackmd.md) 的 Slide Mode，它強調了 reveal.js 對 Markdown 的支持，比走向 WYSIWYG 的 Slides.com 讓人更容易專注在內容的撰寫。
  - reveal.js 本身是 HTML (+ CSS + JavaScript)，當然也可以放在 [GitHub Pages](github-pages.md)

---

參考資料：

  - [Client presentation - hakimel/reveal\.js: The HTML Presentation Framework](https://github.com/hakimel/reveal.js#client-presentation) #ril

  - [Example Presentations · hakimel/reveal\.js Wiki](https://github.com/hakimel/reveal.js/wiki/Example-Presentations)

    Explore more than 800,000 presentations on [Slides](https://slides.com/) – the online editor and HOSTING platform for reveal.js https://slides.com/explore

    不少都放 GitHub Pages (`xxx.github.io`) 上。

    試用了 Slides Editor，並不是用 Markdown 寫，而是 WYSIWYG 的編輯介面!? 可以手動上傳本地端上傳的 slides 嗎??

  - [Make Presentation Slides with HackMD \- HackMD](https://hackmd.io/s/how-to-create-slide-deck)

    HackMD integrates reveal.js so we can easily make a deck of presentation slides within a markdown note.

    某種程度上可以說 HackMD 也是一個 reveal.js 的 hosting 平台。

## Plugin

  - [Plugin - hakimel/reveal\.js: The HTML Presentation Framework](https://github.com/hakimel/reveal.js/#plugins) #ril
  - [Plugins, Tools and Hardware · hakimel/reveal\.js Wiki](https://github.com/hakimel/reveal.js/wiki/Plugins,-Tools-and-Hardware) #ril
  - [Plugin Guidelines · hakimel/reveal\.js Wiki](https://github.com/hakimel/reveal.js/wiki/Plugin-Guidelines) #ril

## 安裝設置 {: #setup }

  - [Installation - hakimel/reveal\.js: The HTML Presentation Framework](https://github.com/hakimel/reveal.js/#installation)

      - The basic setup is for AUTHORING PRESENTATIONS ONLY. The full setup gives you access to all reveal.js features and plugins such as speaker notes as well as the development tasks needed to make changes to the SOURCE.

        感覺 basic setup 是 reveal.js + 預配置好的設定所產生的結果，所以不能用 Markdown 寫了??

        無論如何，都需要 reveal.js 的 repo。

    Basic setup

      - The CORE of reveal.js is very easy to install. You'll simply need to download a copy of this repository and open the `index.html` file directly in your browser.

    Full setup

      - Some reveal.js features, like external Markdown and speaker notes, require that presentations RUN FROM A LOCAL WEB SERVER. The following instructions will set up such a server as well as all of the development tasks needed to make edits to the reveal.js SOURCE CODE.

        為什麼要動到 reveal.js 的原始碼?? 轉成 HTML 後應該就不需要有 local web server 了??

         1. Install Node.js (9.0.0 or later)
         2. Clone the reveal.js repository
         3. Navigate to the reveal.js folder

         4. Install dependencies

                $ npm install

         5. Serve the presentation and MONITOR source files for changes

                $ npm start

         6. Open http://localhost:8000 to view your presentation

            You can change the port by using `npm start -- --port=8001`.

    Folder Structure

      - `css/` - Core styles without which the project does not function
      - `js/` - Like above but for JavaScript
      - `plugin/` - Components that have been developed as extensions to reveal.js
      - `lib/` - All other third party assets (JavaScript, CSS, fonts)

  - [Dependencies - hakimel/reveal\.js: The HTML Presentation Framework](https://github.com/hakimel/reveal.js/#dependencies)

      - Reveal.js doesn't rely on any third party scripts to work but a few OPTIONAL libraries are included by default. These libraries are loaded as dependencies in the order they appear, for example:

            Reveal.initialize({
              dependencies: [
                // Interpret Markdown in <section> elements
                { src: 'plugin/markdown/marked.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
                { src: 'plugin/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },

                // Syntax highlight for <code> elements
                { src: 'plugin/highlight/highlight.js', async: true },

                // Zoom in and out with Alt+click
                { src: 'plugin/zoom-js/zoom.js', async: true },

                // Speaker notes
                { src: 'plugin/notes/notes.js', async: true },

                // MathJax
                { src: 'plugin/math/math.js', async: true }
              ]
            });

      - You can add your own extensions using the same syntax. The following properties are available for each DEPENDENCY OBJECT:

          - `src`: Path to the script to load

          - `async`: [optional] Flags if the script should load after reveal.js has started, defaults to `false`

            引用 plugin 時都要用 `async: true` ??

          - `callback`: [optional] Function to execute when the script has loaded
          - `condition`: [optional] Function which must return true for the script to be loaded

  - [jupyter/nbconvert: Jupyter Notebook Conversion](https://github.com/jupyter/nbconvert) 輸出支援 reveal.js #ril
  - [Pandoc \- About pandoc](https://pandoc.org/) Pandoc 支援的 slide show format 裡有 reveal.js

## 參考資料 {: #reference }

  - [reveal.js](https://revealjs.com/)
  - [hakimel/reveal.js - GitHub](https://github.com/hakimel/reveal.js/)

工具：

  - [reveal-md](revealmd.md) - 將 Markdown 轉成 reveal.js。

相關：

  - [Slideshow](slideshow.md#markdown)
  - [HackMD](hackmd) - Slide Mode 就是用 reveal.js

手冊：

  - [Changelog](https://github.com/hakimel/reveal.js/releases)
