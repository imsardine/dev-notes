---
title: HTML / JavaScript
---
# [HTML](html.md) / [JavaScript](javascript.md)

## `<script>` ??

  - [A "hello world" example - JavaScript basics \| MDN](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/JavaScript_basics#A_hello_world_example)
      - Next, in your `index.html` file enter the following element on a new line just before the closing `</body>` tag: `<script src="scripts/main.js"></script>`
      - Note: The reason we've put the `<script>` element NEAR THE BOTTOM OF THE HTML FILE is that HTML is loaded by the browser in the order it appears in the file. If the JavaScript is loaded first and it is supposed to affect the HTML below it, it might not work, as the JavaScript would be loaded before the HTML it is supposed to work on. Therefore, putting JavaScript near the bottom of the HTML page is OFTEN THE BEST STRATEGY. 如果載入的 JavaScript 會操作到 HTML，沒有放 `</body>` 結束前，就會出錯。

  - [Launching Code on Document Ready - How jQuery Works \| jQuery Learning Center](https://learn.jquery.com/about-jquery/how-jquery-works/#launching-code-on-document-ready) 一樣要考量 "code runs after the browser finishes loading the document"，不過 jQuery 提供有 `ready` event，確保程式在 document ready 後才會執行，就不會出錯；這種情況下，`<script>` 就不一定要擺 `</body>` 前。

  - [`<script>`: The Script element \| MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script) #ril
  - [Scripts in HTML documents](https://www.w3.org/TR/html4/interact/scripts.html)

  - [Why self\-closing script tags doesn't work?](http://www.namasteui.com/why-self-closing-script-tags-doesnt-work/) (2016-12-22)
      - 一開始就講 "Self-closing script tag are not supported by all browsers as this may contain inline code and HTML is not smart enough to turn that feature on or off." 而 not smart enough 指的是 "based on the presence of an attribute" -- 動態根據是否給 `src` attribute 來決定 end tag 是否可以省略。
      - Basically, the concept of self-closing tags is an XML concept. You can use them in XHTML if the document is served with an XML content-type but not if it is served as text/html. 若視為 XML，寫成 `<script />` 倒是沒問題，但 HTML (`text/html`) 就不行。
  - [That annoying non\-self\-closing `<script>` tag \| Mike Friedman \[blogs\.perl\.org\]](http://blogs.perl.org/users/mike_friedman/2009/12/that-annoying-non-self-closing-script-tag.html) (2009-12-11) 提到 `<link>`，但又說 No browser supports loading Javascript via a `<link>` tag?
  - [javascript \- Why don't self\-closing script tags work? \- Stack Overflow](https://stackoverflow.com/questions/69913/) #ril
      - 為什麼寫成 `<script src="path/to/js" />` 不行，要寫成 `<script src="path/to/js"><script>` 才行?
      - Adam Ness: 早期 self-closing script tag 在 Chrome 可以作用，但近期開始出問題 (2010-10-24)
      - DOM: 不只是 script tag，也不認為 self-closing div 可以作用。
      - squadette: 引用 XHTML 1 spec 的 С.3. Element Minimization and Empty Element Content 提到 "Given an empty instance of an element whose content model is not EMPTY (for example, an empty title or paragraph) do not use the minimized form (e.g. use `<p> </p>` and not `<p />`)."，但下面不少人反駁 "do not" 不等同於 "must not"，不過 4.3. For non-empty elements, end tags are required 似乎給了答案? 除非 DTD 裡宣為 EMPTY，否則 end tag 不能省略。
      - Sheepy: 說得很詳細，但看不懂 XD
      - defau1t: HTML 已經有 `<link>` 可以引用 resource，而且它可以 self-closing，例如 `<link type="text/javascript" rel ="script" href="/path/tp/javascript" />`，但 `<script>` 不能 self-closing。但 Dave Lawrence: 因為有個 predefined `<script>` 可以用來載 script，為什麼要用其他方式?

## Source Map ??

  - [Use a source map \| MDN](https://developer.mozilla.org/en-US/docs/Tools/Debugger/How_to/Use_a_source_map) #ril
  - [Introduction to JavaScript Source Maps \- HTML5 Rocks](https://www.html5rocks.com/en/tutorials/developertools/sourcemaps/) (2012-03-21) #ril

## 參考資料 {: #reference }

手冊：

  - [<script>: The Script element | MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script)
