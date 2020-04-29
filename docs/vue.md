# Vue.js

  - [Vue\.js](https://vuejs.org/)

    The PROGRESSIVE JavaScript Framework

      - Approachable

        Already know HTML, CSS and JavaScript? Read the guide and start building things in no time!

      - Versatile

        An incrementally adoptable ecosystem that scales between a library and a full-featured framework.

      - Performant

        20KB min+gzip Runtime. Blazing Fast Virtual DOM. Minimal Optimization Efforts

  - [What is Vue.js? - Introduction — Vue\.js](https://vuejs.org/v2/guide/#What-is-Vue-js)

      - Vue (pronounced /vjuː/, like view) is a progressive framework for building user interfaces. Unlike other monolithic frameworks, Vue is designed from the ground up to be INCREMENTALLY ADOPTABLE.

      - The core library is focused on the VIEW LAYER ONLY, and is easy to pick up and integrate with other libraries or existing projects. On the other hand, Vue is also perfectly capable of powering sophisticated SINGLE-PAGE APPLICATIONS when used in combination with [modern tooling](https://vuejs.org/v2/guide/single-file-components.html) and [supporting libraries](https://github.com/vuejs/awesome-vue#components--libraries). #ril

  - [WHY VUE.JS - Vue\.js](https://vuejs.org/)

      - Over the last 10 years, our web pages have become more dynamic and powerful. thanks to JavaScript. We've moved a lot of code that was normally on the server side into our browsers, leaving us with thousands of lines of JavaScript code connecting to various HTML and CSS files WITH NO FORMAL ORGANIZATION. This is why more and more developers are using JavaScript frameworks like Angular, React, or Vue.

      - Vue is an approachable, versatile, and performant JavaScript framework that helps you create a more maintainable, and TESTABLE code base.

        Vue is a PROGRESSIVE JavaScript framework, which means if you have an existing server-side applications, you can plug Vue into JUST ONE PART of your application that needs a richer, more interactive experience. Or, if you want to build more BUSINESS LOGIC INTO YOUR FRONTEND from the get go, Vue has the core libraries and the ecosystem you'll need to scale.

        什麼時候會想把 business logic 放 frontend? 這裡提到 Core + [Vuex](https://vuex.vuejs.org/) + [Vue-Router](https://router.vuejs.org/) #ril

  - [Comparison with Other Frameworks — Vue\.js](https://vuejs.org/v2/guide/comparison.html) #ril

## 新手上路 {: #getting-started }

  - [WHY VUE.JS - Vue\.js](https://vuejs.org/) #ril

      - Like other frontend frameworks, Vue allows you to take a web page and split it up into reusable components, each having its own HTML, CSS and JavaScript needed to render that piece of the page.

      - Next, we'll take a look at Vue in action by building a product inventory page, but stay tuned to the end of the video for a message from Vue's creator, Evan You.

      - We won't be teaching you how to use Vue, but we'll introduce a couple key concepts that make Vue so useful. As with many JavaScript applications, we start from the need to display data on to our web page.

            <div id="app">
              <h2>X are in stock.</h2>
            </div>
            <script>
              var product = 'Boots'
            </script>

      - With Vue, it starts out really simple. We include the Vue library, create a Vue instance, and PLUG INTO OUR ROOT ELEMENT with the ID of app. E L stands for element, we'll also move our data inside an object, and change X into an EXPRESSION with the double curly braces. As you can see, it works.

            <div id="app">
              <h2>{{ product }} are in stock.</h2>
            </div>
            <script src="https://unpkg.com/vue"></script>
            <script>
              const app = new Vue({
                el: '#app',
                data: {
                  product: 'Boots'
                }
              })
            </script>

      - Pretty cool, but the magic of Vue starts when data changes. If we jump into the console, we ...

  - [The Vue Instance \- Intro to Vue\.js \| Vue Mastery](https://www.vuemastery.com/courses/intro-to-vue-js/vue-instance/) #ril

  - [Getting Started - Introduction — Vue\.js](https://vuejs.org/v2/guide/#Getting-Started) #ril

  - [A Vue\.js introduction for people who know just enough jQuery to get by](https://www.freecodecamp.org/news/eab5aa193d77/) #ril

      - I’ve had a LOVE-HATE relationship with JavaScript for years.

        I got to know the language by way of the design and development community’s favorite WHIPPING BOY (代罪羔羊), jQuery. You see, at the time I began learning JavaScript, as a “DESIGNER WHO CODES,” working with jQuery was a magical experience. I could make modals `fadeIn` and `fadeOut`. With a third-party library, I could add parallax scrolling to my portfolio with just a single function call. Nearly everything I could have possibly dreamed of was encapsulated in a single, ~100kb file…

        And then Angular came out. I had NO CHOICE but to redo my entire portfolio with the framework. And then React came out. I had no choice but to redo my entire portfolio with the library. And then Vue.js came out. I had no choice but to redo my entire portfolio with the library… You see where this is going.

      - All jokes aside, I have greatly enjoyed honing my JavaScript chops through building things here and there with these different frameworks and libraries. I have read countless articles and tutorials in the process, but none has stuck with me more than Shu Uesugi’s piece, “React.js Introduction For People Who Know Just Enough jQuery To Get By.”

        Shu takes readers — who are presumed to have some level of proficiency with JavaScript fundamentals and jQuery — on a journey through the world of React as they build a clone of Twitter’s “compose tweet” component.

        This conceptual frame was quite helpful to me as someone who learns best by doing. Indeed, any time a new JavaScript library comes out, I find myself going back to the example from this article to test the waters. And so, I would like to borrow this frame as I step you all through my recent experience of learning Vue.

        Before you begin the steps below, I highly encourage you to read Shu’s article. He does a fantastic job of walking you through the jQuery code you might write in order to implement some of these features. Thus, and so as to mitigate the risk of redundancy, I will focus on showing you the ins-and-outs of Vue.

## 安裝設置 {: #setup }

  - [Installation — Vue\.js](https://vuejs.org/v2/guide/installation.html) #ril

## 參考資料 {: #reference }

  - [Vue.js](https://vuejs.org/)
  - [vuejs/vue - GitHub](https://github.com/vuejs/vue)

更多：

  - [Component](vue-component.md)
  - [Testing](vue-testing.md)

相關：

  - [JavaScript Framework](html-javascript.md#framework)
