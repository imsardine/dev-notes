# JavaScript (JS)

  - [JavaScript \- Wikipedia](https://en.wikipedia.org/wiki/JavaScript) #ril

  - [JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript)

      - JavaScript (JS) is a lightweight, interpreted, or just-in-time compiled programming language with FIRST-CLASS FUNCTIONS. While it is most well-known as the scripting language for Web pages, many NON-BROWSER ENVIRONMENTS also use it, such as Node.js, Apache CouchDB and Adobe Acrobat.

        [First\-class Function \- MDN Web Docs Glossary: Definitions of Web\-related terms \| MDN](https://developer.mozilla.org/en-US/docs/Glossary/First-class_Function):

        > A programming language is said to have first-class functions when functions in that language are treated like any other variable. For example, in such a language, a function CAN BE PASSED AS AN ARGUMENT to other functions, can be returned by another function and can be assigned as a value to a variable.

      - JavaScript is a PROTOTYPE-BASED, multi-paradigm, dynamic language, supporting object-oriented, imperative, and declarative (e.g. functional programming) styles. Read more about JavaScript.

        [Prototype\-based programming \- MDN Web Docs Glossary: Definitions of Web\-related terms \| MDN](https://developer.mozilla.org/en-US/docs/Glossary/Prototype-based_programming):

        > Prototype-based programming is a style of object-oriented programming in which CLASSES ARE NOT EXPLICITLY DEFINED, but rather derived by adding properties and methods to an instance of another class or, less frequently, adding them to an EMPTY OBJECT.
        >
        > In simple words: this type of style allows the creation of an object without first defining its class.

      - This section is dedicated to the JavaScript language itself, and not the parts that are specific to Web pages or other HOST ENVIRONMENTS. For information about APIs specific to Web pages, please see Web APIs and DOM.

        [What JavaScript implementations are available? - About JavaScript \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/About_JavaScript#What_JavaScript_implementations_are_available):

        > Each of Mozilla's JavaScript ENGINES expose a public API which application developers can use to integrate JavaScript into their software. By far, the most common host environment for JavaScript is web browsers. Web browsers typically use the public API to create HOST OBJECTS responsible for reflecting the DOM into JavaScript.

        JavaScript 設計上就是要被整進某個 (host) environment/application，只要 application 往 JavaScript engine 揭露一些 host object (有點像 handle)，就可以自訂 script 來操控 application -- 這時 application 就可以聲稱有 scripting 的功能。

        不同的 host environment 會揭露不同的 host objects，例如 web browser 會提供 `window`、`document` 等，這些都不是 JavaScript 語言的東西。所以學習 JavaScript 可以分成兩塊 -- JavaScript 語言本身 + Host Environment 提供的 API。

        初學 JavaScript 時在 web browser 裡或 Node.js 裡都可以，但要分清楚哪些是 JavaScript 的，哪些又是 host environment 提供的。

      - The standard for JavaScript is ECMAScript. As of 2012, all modern browsers fully support ECMAScript 5.1. Older browsers support at least ECMAScript 3. On June 17, 2015, ECMA International published the sixth major version of ECMAScript, which is officially called ECMAScript 2015, and was initially referred to as ECMAScript 6 or ES6. Since then, ECMAScript standards are on YEARLY RELEASE CYCLES. This documentation refers to the latest draft version, which is currently ECMAScript 2020.

        [Conformance - ECMAScript \- Wikipedia](https://en.wikipedia.org/wiki/ECMAScript#Conformance) 提到主流 JavaScript engine 對 ES7 的支援都達到 100%，但 ES6 的支援只有 96% ~ 99%，現在應該用哪個 ??

  - [About JavaScript \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/About_JavaScript)

      - JavaScript can function as both a procedural and an object oriented language. Objects are created programmatically in JavaScript, by ATTACHING methods and properties to otherwise EMPTY OBJECTS at run time, as opposed to the SYNTACTIC CLASS DEFINITIONS common in compiled languages like C++ and Java. Once an object has been constructed it can be used as a blueprint (or prototype) for creating similar objects.

        動態配置一個 object 做為 blueprint/prototype，之後可以當做 class 產生更多 objects ...

      - JavaScript's dynamic capabilities include runtime object construction, variable parameter lists, function variables, dynamic script creation (via `eval`), object introspection (via `for ... in`), and SOURCE CODE RECOVERY ?? (JavaScript programs can decompile function bodies back into their source text).

    What JavaScript implementations are available?

      - The Mozilla project provides two JavaScript implementations. The first ever JavaScript was created by Brendan Eich at Netscape, and has since been updated to conform to ECMA-262 Edition 5 and later versions. This engine, code named SpiderMonkey, is implemented in C/C++.

        The Rhino engine, created primarily by Norris Boyd (also at Netscape) is a JavaScript implementation written in Java. Like SpiderMonkey, Rhino is ECMA-262 Edition 5 compliant.

        Several major runtime optimizations such as TraceMonkey (Firefox 3.5), JägerMonkey (Firefox 4) and IonMonkey were added to the SpiderMonkey JavaScript engine over time. Work is always ongoing to improve JavaScript execution performance.

        [SpiderMonkey \- Mozilla \| MDN](https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey):

        > SpiderMonkey is Mozilla's JavaScript engine written in C and C++. It is used in various Mozilla products, including Firefox, and is available under the MPL2.

        [Rhino \- Mozilla \| MDN](https://developer.mozilla.org/en-US/docs/Mozilla/Projects/Rhino):

        > Rhino is an open-source implementation of JavaScript written entirely in Java. It is typically embedded into Java applications to provide scripting to end users. It is embedded in J2SE 6 as the default Java scripting engine.

        Rhino 怎會用 Java 寫，這限制了它的應用；Firefox 採用的是 SpiderMonkey，看似它的發展比 Rhino 好很多?

      - Besides the above implementations, there are other popular JavaScript engines such as:

          - Google's V8, which is used in the Google Chrome browser and recent versions of Opera browser. This is also the engine used by Node.js.
          - The JavaScriptCore (SquirrelFish/Nitro) used in some WebKit browsers such as Apple Safari.
          - Carakan in old versions of Opera.
          - The Chakra engine used in Internet Explorer (although the language it implements is formally called "JScript" in order to avoid trademark issues).

      - Each of Mozilla's JavaScript engines expose a public API which application developers can use to integrate JavaScript into their software. By far, the most common host environment for JavaScript is web browsers. Web browsers typically use the public API to create host objects responsible for reflecting the DOM into JavaScript.

        Another common application for JavaScript is as a (Web) server side scripting language. A JavaScript web server would expose host objects representing a HTTP request and response objects, which could then be manipulated by a JavaScript program to dynamically generate web pages. Node.js is a popular example of this.

        JavaScript 本沒有 I/O 能力，必須靠 host environment 提供的 host object 才能達成。

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

## EMCAScript

  - [ECMAScript 6 and up in 2019](https://areknawo.com/ecmascript-6-and-up-in-2019/) (2019-01-02) #ril
  - [Why You Should Use ES6 \- ITNEXT](https://itnext.io/why-you-should-use-es6-56bd12f7ae09) (2018-05-06) #ril

  - [What’s the difference between JavaScript and ECMAScript?](https://medium.freecodecamp.org/whats-the-difference-between-javascript-and-ecmascript-cba48c73a2b5) (2017-10-28) #ril
  - [ecma262 \- What is the difference between JavaScript and ECMAScript? \- Stack Overflow](https://stackoverflow.com/questions/912479/) #ril

## Hello, World! (Browser) ??

  - [How To Write a Hello World Program in JavaScript \| DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-write-your-first-javascript-program) #ril

## Hello, World! (Node.js) ??

## Standard Library??

  - [Standard built\-in objects \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects) #ril

## Strict Mode??

  - [Strict mode \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Strict_mode) #ril

## 新手上路 {: #getting-started }

參考資料：

  - [JavaScript \| MDN](https://developer.mozilla.org/bm/docs/Web/JavaScript)#ril
  - Learn JavaScript | Course | Codeacademy https://www.codecademy.com/learn/learn-javascript 進度比較慢 #ril
  - Learn javascript in Y Minutes https://learnxinyminutes.com/docs/javascript/ #ril
  - About jQuery | jQuery Learning Center http://learn.jquery.com/about-jquery/ jQuery 的 Learning Center 建議先看過 JavaScript basics - Learn web development | MDN https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/JavaScript_basics #ril

## 可以在哪裡練習 JavaScript?

  - Browser 的 Developer Console，包括 Firefox 的 Web Console 或 Scratchpad、Chrome Developer Tools 的 Console 或 Sources > Snippets
  - 線上 JavaScript 編輯器，例如 [JSFiddle](https://jsfiddle.net/)、[JS.do](https://js.do/)、[JS Bin](https://jsbin.com/) 等。
  - Node.js 的 interactive shell 也可以 (`node --interactive`)。
  - [PlayCode \- Code Sandbox\. Online Code Editor](https://playcode.io/) - 左側專側在 JavaScript 的撰寫，右側的輸出分 HTML 與 console。

參考資料：

  - [Getting started with JavaScript - Introduction \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Introduction#Getting_started_with_JavaScript) 提到 Firefox 的 Web Console 與 Scratchpad，後者適合多行編輯；Menu > Web Developer > Web Console / Scratchpad。
  - [Writing Javascript in Google Chrome DevTools \- YouTube](https://www.youtube.com/watch?v=e-Ck0HlCELM) Chrome 的 Developer Tools 下有 Console，另外 Sources > Snippets 也提供多行編輯的環境
  - [5 Best Way To Write And Run JavaScript Online \| DiscoverSDK Blog](http://www.discoversdk.com/blog/5-best-way-to-write-and-run-javascript-online) (2016-11-02) 提到 [JSFiddle](https://jsfiddle.net/)、[JS.do](https://js.do/)、[JS Bin](https://jsbin.com/) 等。
  - Node.js 的 interactive shell 也可以；`node` 搭配 `-i, --interactive`。

## require() 不是 JavaScript 的一部份

  - [database \- What is this Javascript "require"? \- Stack Overflow](https://stackoverflow.com/questions/9901082/) #ril
      - Joseph: `require()` 並非 JavaScript 的一部份，而是 Node.js 提供用來載入其他 module 的方式；module 的概念類似於在網頁用 `<script>` 把 JS code 引入，但不會加入 global scope。
      - Timothy Meade: `require()` 規範在 CommonJS 裡，就 Node 而言會在 module search path 裡找。
  - [Browserify](http://browserify.org/) 讓你在 browser 裡使用 `require('modules')` #ril

## 結尾 `;` 的使用時機?

  - JavaScript basics - Learn web development | MDN https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/JavaScript_basics 結尾的分號表示 statement 結束，把多個 statement 寫在同一行時才需要，但許多人認為在結尾加上分號才是好的做法。
  - Your Guide to Semicolons in JavaScript | Codecademy (2013-06-12) https://www.codecademy.com/blog/78 #ril

## 參考資料 {: #reference }

學習資源：

  - [JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript)

更多：

  - [Programming](javascript-programming.md)
  - [Text Processing](javascript-text.md)
  - [Regex](javascript-regex.md)

相關：

  - [HTML Scripting (JavaScript)](html-scripting.md)
  - [Node.js](nodejs.md)

手冊：

  - [JavaScript Reference | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference)
  - [Web Docs Glossary | MDN](https://developer.mozilla.org/en-US/docs/Glossary)
  - [EMCAScript Specifications | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Language_Resources)
