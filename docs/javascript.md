# JavaScript (JS)

  - [JavaScript \- Wikipedia](https://en.wikipedia.org/wiki/JavaScript) #ril

## 必須依付在某個 Host Environment 下

  - JavaScript Engine 提供的 API 除了將 JavaScript 整合到 host software 裡，也可以向 JavaScript 揭露 host object 使能跟 host environment (或 platform) 互動或擴充 Core JavaScript。Browser 只是最常見的 host environment，也可以是 web server 等。
  - JavaScript 本沒有 I/O 能力，必須靠 host environment 提供的 host object 才能達成。

參考資料：

  - [What is JavaScript? - Introduction \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Introduction#What_is_JavaScript)
      - 是一種 cross-platform、object-oriented 的 scripting language，在 host environment 裡，可以操控 evironment 提供的 object。
      - Core JavaScript 包含 language 與 standard library，可以由環境增補 object 以進行擴充。例如 client-side JavaScript 會拿到可以操作 browser 或 DOM 的 object，而 server-side JavaScript 則會拿到其他 object 以操作檔案、資料庫等。
  - [JavaScript \- Wikipedia](https://en.wikipedia.org/wiki/JavaScript)
      - There is no built-in I/O functionality in JavaScript; the run-time environment provides that. 自身沒有 I/O 的能力，完全依賴它所在的環境 (the host environment in which it is embedded)
      - 最初只實作在 browser 裡，但後來可以內嵌在其他 host software 裡 (包括 server side)。
      - Host environment 通常會提供 host object 給 JavaScript 調用，例如 browser (最常見的 host environment) 會提供代表 DOM 的 host object，而 web server (也是常見的 host environment) 會提供代表 HTTP request & response 的 host object，就能動態產生 web page。
  - [Browser environment, specs](https://javascript.info/browser-environment) A host environment provides PLATFORM-SPECIFIC OBJECTS and functions additionally to the LANGUAGE CORE. Web browsers give means to control web pages. Node.JS provides server-side features, and so on.
  - [What JavaScript implementations are available? - About JavaScript \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/About_JavaScript#What_JavaScript_implementations_are_available) Mozilla 的 JavaScript Engine 提供有 API 將 JavaScript 整合到其他 software 裡，例如 web brower 會透過 API 提供代表 DOM 的 host object，而 web server 會提供代表 HTTP request & response 的 host object。
  - [What is the difference between javascript engine and javascript runtime? \- Quora](https://www.quora.com/What-is-the-difference-between-javascript-engine-and-javascript-runtime) #ril

## 跟 Browser/DOM 的關係??

  - [DOM and JavaScript - Introduction to the DOM \- Web APIs \| MDN](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction#DOM_and_JavaScript) DOM 只是 "object-oriented representation of the web page"，獨立於任何程式語言，但程式程言沒有這個 model or notion of web pages 也無從存取 HTML/XML document；早期 DOM 確實跟 JavaScript 綁得很緊 (tightly intertwined)，但後來的發展漸漸拆開。

## 跟 EMCAScript 的關係??

  - [What’s the difference between JavaScript and ECMAScript?](https://medium.freecodecamp.org/whats-the-difference-between-javascript-and-ecmascript-cba48c73a2b5) (2017-10-28) #ril
  - [ecma262 \- What is the difference between JavaScript and ECMAScript? \- Stack Overflow](https://stackoverflow.com/questions/912479/) #ril

## Hello, World! (Browser) ??

  - [How To Write a Hello World Program in JavaScript \| DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-write-your-first-javascript-program) #ril

## Hello, World! (Node.js) ??

## Standard Library??

  - [Standard built\-in objects \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects) #ril

## Strict Mode??

  - [Strict mode \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Strict_mode) #ril

## 可以在哪裡練習 JavaScript?

  - Browser 的 Developer Console，包括 Firefox 的 Web Console 或 Scratchpad、Chrome Developer Tools 的 Console 或 Sources > Snippets
  - 線上 JavaScript 編輯器，例如 [JSFiddle](https://jsfiddle.net/)、[JS.do](https://js.do/)、[JS Bin](https://jsbin.com/) 等。
  - Node.js 的 interactive shell 也可以 (`node --interactive`)。

參考資料：

  - [Getting started with JavaScript - Introduction \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Introduction#Getting_started_with_JavaScript) 提到 Firefox 的 Web Console 與 Scratchpad，後者適合多行編輯；Menu > Web Developer > Web Console / Scratchpad。
  - [Writing Javascript in Google Chrome DevTools \- YouTube](https://www.youtube.com/watch?v=e-Ck0HlCELM) Chrome 的 Developer Tools 下有 Console，另外 Sources > Snippets 也提供多行編輯的環境
  - [5 Best Way To Write And Run JavaScript Online \| DiscoverSDK Blog](http://www.discoversdk.com/blog/5-best-way-to-write-and-run-javascript-online) (2016-11-02) 提到 [JSFiddle](https://jsfiddle.net/)、[JS.do](https://js.do/)、[JS Bin](https://jsbin.com/) 等。
  - Node.js 的 interactive shell 也可以；`node` 搭配 `-i, --interactive`。

## 如何入門 JavaScript??

參考資料：

  - [JavaScript \| MDN](https://developer.mozilla.org/bm/docs/Web/JavaScript)#ril
  - Learn JavaScript | Course | Codeacademy https://www.codecademy.com/learn/learn-javascript 進度比較慢 #ril
  - Learn javascript in Y Minutes https://learnxinyminutes.com/docs/javascript/ #ril
  - About jQuery | jQuery Learning Center http://learn.jquery.com/about-jquery/ jQuery 的 Learning Center 建議先看過 JavaScript basics - Learn web development | MDN https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/JavaScript_basics #ril

## require() 不是 JavaScript 的一部份??

  - [database \- What is this Javascript "require"? \- Stack Overflow](https://stackoverflow.com/questions/9901082/) #ril
      - Joseph: `require()` 並非 JavaScript 的一部份，而是 Node.js 提供用來載入其他 module 的方式；module 的概念類似於在網頁用 `<script>` 把 JS code 引入，但不會加入 global scope。
      - Timothy Meade: `require()` 規範在 CommonJS 裡，就 Node 而言會在 module search path 裡找。
  - [Browserify](http://browserify.org/) 讓你在 browser 裡使用 `require('modules')` #ril

## 結尾 `;` 的使用時機?

  - JavaScript basics - Learn web development | MDN https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/JavaScript_basics 結尾的分號表示 statement 結束，把多個 statement 寫在同一行時才需要，但許多人認為在結尾加上分號才是好的做法。
  - Your Guide to Semicolons in JavaScript | Codecademy (2013-06-12) https://www.codecademy.com/blog/78 #ril

## 參考資料

學習資源：

  - [JavaScript | MDN](https://developer.mozilla.org/bm/docs/Web/JavaScript)

更多：

  - [Text Processing](javascript-text.md)
  - [Collection](javascript-collection.md)

相關：

  - [HTML Scripting (JavaScript)](html-scripting.md)
  - [Node.js](nodejs.md)

