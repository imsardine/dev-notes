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

## Framework

  - Front-end JavaScript Framework 的說法會比 "JavaScript Framework" 精確，在 [Angular vs React vs Vue: Which Framework to Choose in 2020](https://www.codeinwp.com/blog/angular-vs-vue-vs-react/) 大量出現這種說法。

---

參考資料：

  - [Angular vs React vs Vue: Which Framework to Choose in 2020](https://www.codeinwp.com/blog/angular-vs-vue-vs-react/) (2020-02-18)

      - Just a couple of years ago, developers were mainly debating on whether they should be using Angular vs React for their projects. But over the course of 2018 and 2019, we saw a growth of interest in a third player called Vue.js. Looking forward into 2020, this post is a comprehensive guide on which is perhaps the right solution for you: Angular vs React vs Vue.

      - If you are a developer starting out on a project and cannot decide on which JavaScript framework to use, this guide should help you make a decision.

        We cover various aspects of Angular, Vue, and React to see how they suit your needs. This post is not just a guide on Angular vs React vs Vue but aims to provide a STRUCTURE to help judge FRONT-END JavaScript frameworks in general. In case a new framework arrives next year, you will know exactly what PARAMETERS to look at!

    Part 1: A brief history of Vue vs React vs Angular

      - Before we get into the technical details, let’s first talk about the history behind these frameworks – just to better appreciate their philosophy and their evolution over time.

    Part 1 > How it all started

      - Angular, developed by Google, was first released in 2010, making it the oldest of the lot. It is a TYPESCRIPT-BASED JavaScript framework.

        A substantial shift occurred in 2016 on the release of Angular 2 (and the dropping of the “JS” from the original name – AngularJS). Angular 2+ is known as just Angular. Although AngularJS (version 1) still gets updates, we will focus the discussion on Angular. The latest stable version is Angular 9, which was released in February 2020.

      - Vue, also known as Vue.js, is the youngest member of the group. It was developed by ex-Google employee Evan You in 2014. Over the last three years, Vue has seen a substantial shift in popularity, even though it doesn’t have the backing of a large company.

        The current stable version is 2.6, released in February 2019 (with some small incremental releases since then). Vue’s contributors are supported by Patreon.

        Vue 3, currently in the alpha phase, is planning to MOVE TO TYPESCRIPT.

      - React, developed by Facebook, was initially released in 2013. Facebook uses React extensively in their products (Facebook, Instagram, and WhatsApp). The current stable version is 16.X, released in November 2018 (with smaller incremental updates since then).

      - Here’s a short summary of Angular vs React vs Vue, in terms of their status and history:

        以 size 來講 Vue (80 KB) < React (100 KB) < Angular (500 KB)。

        代表用戶 Angular 除 Google 外有 Wix，React 除 Facebook 外有 Uber，而 Vue 的代表用戶有 Alibaba 及 GitLab。

    Part 1 > License

      - Before you use an open source framework, make sure you go through its license. Interestingly, all three frameworks use the MIT license, which provides limited restrictions on reuse, even in proprietary software. Make sure you know the implications of the license before using any framework or software.

        Here is [a quick summary of the MIT license](https://tldrlegal.com/license/mit-license) in plain English terms. #ril

        MIT 不是相對寬鬆嗎??

    Part 1 > Popularity

      - As “angular” and “react” are common words, it is difficult to grasp their popularity from Google Trends. Though, a good proxy for their popularity is the number of stars that their GitHub repositories get.

        A sudden shift in the number of stars of Vue occurred in mid-2016 and, recently, Vue has been up there with React among the most popular frameworks.

        ![](https://iotvnaw69daj.i.optimole.com/6LNb4w-R5StNuCI/w:692/h:452/q:90/dpr:2.0/https://mk0codeinwp10tp0961a.kinstacdn.com/wp-content/uploads/2019/01/star-history.png)

        Angular 比 React 早出現，但卻起飛得比 React 晚。

    Part 1 > Job market for Angular vs React vs Vue

      - The best [sources of data](https://medium.com/zerotomastery/tech-trends-showdown-react-vs-angular-vs-vue-61ffaf1d8706) that indicate the trends on the job market are the various job boards. #ril

        As seen from the trends of late 2018, the number of jobs that require a skill set of Angular or React is roughly the same, whereas that of Vue was still only a fraction of this number (about 20%). This list is definitely not exhaustive but gives a good picture of the overall tech industry.

        If you are looking strictly from the point of view of the current job market, your best bet is to learn Angular or React. However, given that Vue has gained popularity over the last three years, it may TAKE SOME TIME for projects to use Vue, or new projects that adopt Vue to reach a maturity level that commands a higher number of developers.

    Part 2: Community and development

      - Now that you are familiar with the history and trends of each of these frameworks, we will look at the community to assess the development of these frameworks. We have already seen that for all of the frameworks, incremental releases have been shipped regularly over the past year, which indicates that development is going on in FULL SWING.

        Let us look at Angular vs React vs Vue with respect to statistics on their GitHub repositories:

      - Vue has a huge number of watchers, stars and forks. This shows its popularity among users and its value when comparing Vue vs React. However, the number of contributors for Vue are lower than Angular and React.

        各項指標都很高，就唯獨 contributor 只有 1/4 ~ 1/3。

        One possible explanation is that Vue is driven entirely by the open source community, whereas Angular and React have a significant share of Google and Facebook employees contributing to the repositories.

      - From the statistics, all three projects show significant development activity, and this is surely going to continue in the future — just these statistics cannot be the basis of not deciding to use either of them.

    Part 3: Migrations

      - As you’re working with your framework of choice, you don’t want to have to worry about a framework update coming along and messing up your code. Though in most cases you won’t encounter many issues from one version to another, it’s important to keep your finger on the pulse because some updates can be more significant and require tweaks to keep things compatible.

      - Angular plans major updates every six months. There is also a period of another six months before any major APIs are deprecated, which gives you the time of TWO RELEASE CYCLES (one year) to make necessary changes if any.

      - When it comes to Angular vs React, Facebook has stated that stability is of utmost importance to them, as huge companies like Twitter and Airbnb use React. Upgrades through versions are generally the easiest in React, with scripts such as [react-codemod](https://github.com/reactjs/react-codemod) helping you to migrate.

      - In the Migration section of the FAQ, Vue mentions that 90% of the API is the same if you are migrating from 1.x to 2. There is a [migration helper tool](https://github.com/vuejs/vue-migration-helper) that works on the console to assess the status of your app.

        跟 React 的 `react-codemod` 一樣，看來這才是主流的做法。

    Part 4: Working with Vue vs Angular vs React

      - There are a handful of important characteristics to look at here, chief of them being overall size and load times, the components available, and learning curve.

    Part 4 > Size and load times

      - The sizes of the libraries are as follows:

          - Angular 4+: Depends on the bundle size produced
          - React: 116 KB
          - Vue: 91 KB

        Although there is a significant difference between the sizes of the frameworks, they are still small as compared to the average webpage size (2+ MB in 2018). Additionally, if you use a popular CDN to load these libraries, it is highly probable that a user has the library already loaded in their local system.

    Part 4 > Components

      - Components are integral parts of all three frameworks, no matter if we’re talking Vue, React, or Angular. A component generally gets an input, and changes behavior based on it. This behavior change generally manifests as a change in the UI of some part of the page. The use of components makes it easy to reuse code. A component may be a cart on an e-commerce site or a login box on a social network.

      - In Angular, components are referred to as directives. Directives are just MARKERS on DOM elements, which Angular can track and attach specific behavior too. Therefore, Angular SEPARATES the UI part of components as attributes of HTML tags, and their behaviors in the form of JavaScript code. This is what sets it apart when looking at Angular vs React.

      - React, interestingly, COMBINES the UI and behavior of components. For instance, here is [the code to create a hello world component in React](https://gist.githubusercontent.com/derickbailey/4a7a6c4a899279d9c80b/raw/1821326777044958507c02dc54b2cab814738d90/react-1.js). In React, the same part of the code is responsible for creating a UI element and dictating its behavior.

      - In Vue, UI and behavior are also a part of components, which makes things more intuitive when looking at Vue vs React. Also, Vue is highly customizable, which allows you to combine the UI and behavior of components from within a script.

        Further, you can also use pre-processors in Vue rather than CSS, which is a great functionality. Vue is great when it comes to integration with other libraries, like Bootstrap.

        呼應 Vue 宣稱的 progressive，但為什麼 Angular 跟 React 不能跟其他 library 混用??

      - To compare how the same app looks with different libraries, here is a great post on [creating the same to do list app on React and Vue](https://medium.com/javascript-in-plain-english/i-created-the-exact-same-app-in-react-and-vue-here-are-the-differences-e9a1ae8077fd) and contrasting the differences of the two frameworks.

    Part 4 > Learning curve

      - Angular has a STEEP learning curve, considering it is a COMPLETE SOLUTION, and mastering Angular requires you to learn associated concepts like TypeScript and MVC.

        Even though it takes time to learn Angular, the investment pays dividends in terms of understanding how the front end works. ??

      - React offers a Getting Started guide that should help one set up React in about an hour. The documentation is thorough and complete, with solutions to common issues already present on Stack Overflow.

        React is NOT A COMPLETE FRAMEWORK ?? and advanced features require the use of third-party libraries. This makes the learning curve of the core framework not so steep but depends on the path you take with additional functionality. However, learning to use React does not necessarily mean that you are using the best practices.

      - Vue provides HIGHER CUSTOMIZABILITY and hence is easier to learn than Angular or React. Further, Vue has an overlap with Angular and React with respect to their functionality like the use of components. Hence, the transition to Vue from either of the two is an easy option.

        However, simplicity and flexibility of Vue is a double-edged sword — it allows poor code, making it difficult to debug and test.

      - Although Angular, React and Vue have a significant learning curve, their uses upon mastery are limitless. For instance, you can integrate Angular and React with WordPress and WooCommerce to create progressive web apps.

        跟 Vue 宣稱的 progressive 不同??

    Angular vs React vs Vue: Who wins?

      - Angular is the most mature of the frameworks, has good backing in terms of contributors and is a complete package.

        However, the learning curve is steep and concepts of development in Angular may PUT OFF new developers.

        Angular is a good choice for companies with large teams and developers who ALREADY USE TYPESCRIPT.

        Extra: Here are some [Angular admin dashboard templates](https://www.codeinwp.com/blog/best-angular-admin-dashboard-templates/) that you might be interested in. #ril

      - React is just old enough to be mature and has a huge number of contributions from the community. It has gained widespread acceptance. The job market for React is really good, and the future for this framework looks bright.

        React looks like a good choice for someone getting started with front-end JavaScript frameworks, startups and developers who like some flexibility. The ability to integrate with other frameworks seamlessly gives it a great advantage for those who would like some flexibility in their code.

      - Vue is newest to the arena, without the backing of a major company.

        However, it has done really well in the last few years to come out as a strong competitor for Angular and React. This is perhaps playing a role with a lot of Chinese giants like Alibaba and Baidu picking Vue as their primary front-end JavaScript framework.

        However, it remains to be seen how it does in the future and one is justified to be cautious with it. Vue should be your choice if you prefer simplicity, but also like flexibility.

        Extra: Here are some [Vue admin templates built with Bootstrap](https://www.codeinwp.com/blog/best-vuejs-admin-templates-built-with-bootstrap/) that you might be interested in. #ril

        為什麼跟 Angular 一樣，都要舉 admin template 當例子??

      - The answer to the debate of Angular vs React vs Vue is that there’s NO ABSOLUTE RIGHT CHOICE, which you’ve probably expected.

        Each of these libraries has their own benefits and drawbacks. Based on the project you’re working on, and your individual requirements, one of them is going to be more suitable than the others. It’s always key to DO YOUR OWN RESEARCH BEFORE DECIDING, especially if you’re going to be working on a business venture and not on a personal project.

        自己都要用過才能比較。

  - [I created the exact same app in React and Vue\. Here are the differences\.](https://medium.com/javascript-in-plain-english/i-created-the-exact-same-app-in-react-and-vue-here-are-the-differences-e9a1ae8077fd) (2018-07-25) #ril

## Source Map ??

  - [Use a source map \| MDN](https://developer.mozilla.org/en-US/docs/Tools/Debugger/How_to/Use_a_source_map) #ril
  - [Introduction to JavaScript Source Maps \- HTML5 Rocks](https://www.html5rocks.com/en/tutorials/developertools/sourcemaps/) (2012-03-21) #ril

## 參考資料 {: #reference }

Framework:

  - [Angular](angular.md)
  - [React](react.md)
  - [Vue](vue.md)

手冊：

  - [<script>: The Script element | MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script)
