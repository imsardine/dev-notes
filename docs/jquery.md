# jQuery

  - [jQuery](https://jquery.com/)
      - jQuery is a fast, small, and feature-rich JavaScript library. It makes things like HTML document traversal and manipulation, event handling, animation, and Ajax much simpler with an EASY-TO-USE API that works across a multitude of browsers. ... jQuery has changed the way that millions of people write JavaScript.

        提供跨 browser 的 API，呼應 "write less, do more" 的標語；嚴格來說，是改變了人們在 browser 裡使用 JavaScript 的方式 -- 不用面對最原始的 API，處理平台間的差異。

      - Lightweight Footprint - Only 30kB minified and gzipped. Can also be included as an [AMD module](https://en.wikipedia.org/wiki/Asynchronous_module_definition)??
      - CSS3 Compliant - Supports CSS3 selectors to find elements as well as in style property?? manipulation
      - Cross-Browser - Chrome, Edge, Firefox, IE, Safari, Android, iOS, and more

  - [History \| jQuery Foundation](https://jquery.org/history/) 只記錄到 2014-08-13? 不過 [Releases · jquery/jquery](https://github.com/jquery/jquery/releases) 是有持續在更新的，v3.3.1 於 2018-01-21 釋出。

## 應用實例 {: #powered-by }

  - [Integrating with Other Libraries – React](https://reactjs.org/docs/integrating-with-other-libraries.html) 討論與 jQuery 及 Backbone 的整合。

## 新手上路 {: #getting-started }

  - [A Brief Look - jQuery](https://jquery.com/)
      - DOM Traversal and Manipulation - Get the `<button>` element with the class `'continue'` and change its HTML to 'Next Step...'

            $( "button.continue" ).html( "Next Step..." ) // 定位的方式像 CSS selector

        其中 `$` 等同於 `jQuery`，這在 How jQuery Works 會解釋。

      - Event Handling - Show the `#banner-message` element that is hidden with `display:none` in its CSS when ANY button in `#button-container` is clicked.

            var hiddenBox = $( "#banner-message" );
            $( "#button-container button" ).on( "click", function( event ) { // 會作用在所有符合 CSS selector 的 element
              hiddenBox.show();
            });

      - Ajax - Call a local script on the server `/api/getWeather` with the query parameter `zipcode=97201` and replace the element `#weather-temp`'s html with the returned text.

            $.ajax({
              url: "/api/getWeather",
              data: {
                zipcode: 97201
              },
              success: function( result ) { // 傳入 function 做為 callback
                $( "#weather-temp" ).html( "<strong>" + result + "</strong> degrees" );
              }
            });

  - [About jQuery \| jQuery Learning Center](https://learn.jquery.com/about-jquery/) One important thing to know is that jQuery is just a JavaScript LIBRARY. All the power of jQuery is accessed via JavaScript, so having a strong grasp of JavaScript is essential for understanding, structuring, and debugging your code. While working with jQuery regularly can, over time, improve your proficiency with JavaScript, it can be hard to get started writing jQuery without a working knowledge of JavaScript's built-in constructs and syntax. 只是個 library，還是要有 JavaScript 的基礎。

  - [How jQuery Works \| jQuery Learning Center](https://learn.jquery.com/about-jquery/how-jquery-works/)

    jQuery: The Basics

      - If you don't have a TEST PAGE setup yet, start by creating the following HTML page:

            <!doctype html>
            <html>
            <head>
                <meta charset="utf-8">
                <title>Demo</title>
            </head>
            <body>
                <a href="http://jquery.com/">jQuery</a>
                <script src="jquery.js"></script>
                <script>
                // Your code goes here.
                </script>
            </body>
            </html>

    Launching Code on Document Ready

      - To ensure that their code runs AFTER THE BROWSER FINISHES LOADING THE DOCUMENT, many JavaScript programmers wrap their code in an `onload` function:

            window.onload = function() {
                alert( "welcome" );
            };

      - Unfortunately, the code doesn't run until ALL IMAGES ARE FINISHED DOWNLOADING, including banner ads. To run code as soon as the document is ready to be manipulated, jQuery has a statement known as the `ready` event:

            $( document ).ready(function() {
                // Your code here.
            });

        注意不是 `document.ready()`，而是包裝一層 `$(document).ready()`。

        Note: The jQuery library exposes its methods and properties via two properties of the `window` object called `jQuery` and `$`. `$` is simply an ALIAS for `jQuery` and it's often employed because it's shorter and faster to write. 不管是 `$` 或 `jQuery`，能直接引用是因為做為 `windows` object 的 property。

      - For example, inside the `ready` event, you can add a click handler to the link:

            $( document ).ready(function() {
                $( "a" ).click(function( event ) {
                    alert( "Thanks for visiting!" );
                });
            });

        Copy the above jQuery code into your HTML file where it says `// Your code goes here`. Then, save your HTML file and reload the test page in your browser. Clicking the link should now first display an alert pop-up, then CONTINUE WITH THE DEFAULT BEHAVIOR of navigating to http://jquery.com.

      - For `click` and most other events, you can PREVENT THE DEFAULT BEHAVIOR by calling `event.preventDefault()` in the event handler:

            $( document ).ready(function() {
                $( "a" ).click(function( event ) {
                    alert( "As you can see, the link no longer took you to jquery.com" );
                    event.preventDefault();
                });
            });

    Adding and Removing an HTML Class

      - You must place the remaining jQuery examples inside the `ready` event so that your code executes when the document is ready to be worked on.
      - Another common task is adding or removing a class. First, add some style information into the `<head>` of the document, like this:

            <style>
            a.test {
                font-weight: bold;
            }
            </style>

      - Next, add the `.addClass()` call to the script: `$( "a" ).addClass( "test" );`
      - All `<a>` elements are now bold. To remove an existing class, use `.removeClass()`: `$( "a" ).removeClass( "test" );`

    Special Effects (動畫效果)

      - jQuery also provides some handy effects to help you make your web sites stand out. For example, if you create a click handler of:

            $( "a" ).click(function( event ) {
                event.preventDefault();
                $( this ).hide( "slow" );
            });

    Callbacks and Functions

      - JavaScript enables you to freely pass functions around to be executed at a later time. A CALLBACK is a function that is passed as an argument to another function and is executed after its PARENT FUNCTION has completed.
      - Callbacks are special because they patiently wait to execute until their parent finishes. Meanwhile, the browser can be executing other functions or doing all sorts of other work. 這就是所謂的 asynchronous
      - To use callbacks, it is important to know how to pass them into their parent function. 差別在於 callback function 有沒有帶參數

    Callback without Arguments

      - If a callback has no arguments, you can pass it in like this:

            $.get( "myhtmlpage.html", myCallBack );

        When `$.get()` finishes getting the page `myhtmlpage.html`, it executes the `myCallBack()` function. The second parameter here is simply the function name (but not as a string, and without parentheses).

    Callback with Arguments

      - Executing callbacks with arguments can be tricky. To defer executing `myCallBack()` with its parameters, you can use an ANONYMOUS FUNCTION AS A WRAPPER. Note the use of `function() {`. The anonymous function does exactly one thing: calls `myCallBack()`, with the values of `param1` and `param2`.

            $.get( "myhtmlpage.html", function() {
                myCallBack( param1, param2 );
            });

        When `$.get()` finishes getting the page `myhtmlpage.html`, it executes the anonymous function, which executes `myCallBack( param1, param2 )`.

  - [Using jQuery Core \| jQuery Learning Center](http://learn.jquery.com/using-jquery-core/) #ril

## Type ??

  - [jQuery - Types \| jQuery API Documentation](http://api.jquery.com/Types/#jQuery) #ril
  - [Selector - Types \| jQuery API Documentation](http://api.jquery.com/Types/#Selector) #ril
  - [htmlString - Types \| jQuery API Documentation](http://api.jquery.com/Types/#htmlString) #ril

## DOM Element & jQuery Object ??

  - [The jQuery Object \| jQuery Learning Center](http://learn.jquery.com/using-jquery-core/jquery-object/) #ril
      - When creating new elements (or selecting existing ones), jQuery returns the elements in a COLLECTION. Many developers new to jQuery assume that this collection is an ARRAY. It has a zero-indexed sequence of DOM ELEMENTS, some familiar array functions, and a `.length` property, after all. Actually, the jQuery object is more complicated than that. 看似 array，但不只是 array。
      - The Document Object Model (DOM for short) is a REPRESENTATION of an HTML document. It may contain any number of DOM elements. At a high level, a DOM element can be thought of as a "piece" of a web page. It may contain text and/or other DOM elements. DOM elements are described by a TYPE, such as `<div>`, `<a>`, or `<p>`, and any number of attributes such as `src`, `href`, `class` and so on.
      - Elements have properties like any JavaScript object. Among these properties are attributes like `.tagName` and methods like `.appendChild()`. These properties are the only way to interact with the web page via JavaScript.
      - It turns out that working directly with DOM elements can be AWKWARD. The jQuery object defines many methods to smooth out the experience for developers. Some benefits of the jQuery Object include:
      - Compatibility – The implementation of element methods varies across browser vendors and versions. The following snippet attempts to set the inner HTML of a `<tr>` element stored in `target`:

            var target = document.getElementById( "target" );
            target.innerHTML = "<td>Hello <b>World</b>!</td>";

        This works in many cases, but it will fail in most versions of Internet Explorer. In that case, the recommended approach is to use pure DOM methods instead. By WRAPPING THE `target` ELEMENT in a jQuery object, these edge cases are taken care of, and the expected result is achieved in all supported browsers:

            // Setting the inner HTML with jQuery.
            var target = document.getElementById( "target" );
            $( target ).html( "<td>Hello <b>World</b>!</td>" );

        用標準 DOM API 拿到 element 後，還是先轉成 jQuery object 再操作會比較安全。

  - [$ vs $() \| jQuery Learning Center](http://learn.jquery.com/using-jquery-core/dollar-object-vs-function/) #ril

## Selection ??

  - [Selecting Elements \| jQuery Learning Center](https://learn.jquery.com/using-jquery-core/selecting-elements/) #ril
      - The most basic concept of jQuery is to "select some elements and do something with them." jQuery supports most CSS3 selectors, as well as some NON-STANDARD selectors. 主要是 CSS selector，但會進行一些擴充。
      - Selecting Elements by ID

            $( "#myId" ); // Note IDs must be unique per page.

      - Selecting Elements by Class Name

            $( ".myClass" );

      - Selecting Elements by Attribute

            $( "input[name='first_name']" ); // 就是 CSS 的 attribute selector

      - Selecting Elements by Compound CSS Selector

            $( "#contents ul.people li" );

      - Selecting Elements with a Comma-separated List of Selectors

            $( "div.myClass, ul.people" );

      - Pseudo-Selectors

            $( "a.external:first" );
            $( "tr:odd" );

            // Select all input-like elements in a form (more on this below).
            $( "#myForm :input" );
            $( "div:visible" );

            // All except the first three divs.
            $( "div:gt(2)" );

            // All currently animated divs.
            $( "div:animated" );

        Note: When using the `:visible` and `:hidden` pseudo-selectors, jQuery tests the ACTUAL VISIBILITY of the element, not its CSS `visibility` or `display` properties. jQuery looks to see if the element's PHYSICAL height and width on the page are both greater than zero. 可能不在 viewport 裡，但一定有被 render 出來。

        However, this test doesn't work with `<tr>` elements. In the case of `<tr>` jQuery does check the CSS `display` property, and considers an element hidden if its `display` property is set to `none`.

        Elements that have not been added to the DOM will always be considered hidden, even if the CSS that would affect them would render them visible.

    Choosing Selectors

      - Choosing GOOD SELECTORS is one way to improve JavaScript's performance. Too much SPECIFICITY can be a bad thing. A selector such as `#myTable thead tr th`.special is overkill if a selector such as `#myTable th.special` will get the job done. 不用循著 DOM 的結構走，反觀寫 CSS selector 時也不會這麼做。

  - [How do I select an item using class or ID? \| jQuery Learning Center](https://learn.jquery.com/using-jquery-core/faq/how-do-i-select-an-item-using-class-or-id/) #ril
  - [How do I select elements when I already have a DOM element? \| jQuery Learning Center](https://learn.jquery.com/using-jquery-core/faq/how-do-i-select-elements-when-i-already-have-a-dom-element/) #ril
  - [How do I select an element by an ID that has characters used in CSS notation? \| jQuery Learning Center](https://learn.jquery.com/using-jquery-core/faq/how-do-i-select-an-element-by-an-id-that-has-characters-used-in-css-notation/) #ril
  - [How do I get the text value of a selected option? \| jQuery Learning Center](https://learn.jquery.com/using-jquery-core/faq/how-do-i-get-the-text-value-of-a-selected-option/) #ril
  - [Selectors \| jQuery API Documentation](http://api.jquery.com/category/selectors/) #ril
  - [Working with Selections \| jQuery Learning Center](https://learn.jquery.com/using-jquery-core/working-with-selections/) #ril

## Event, Trigger ??

  - [Events \| jQuery Learning Center](https://learn.jquery.com/events/) #ril
  - [Event Object \| jQuery API Documentation](https://api.jquery.com/category/events/event-object/) #ril
  - [\.trigger() \| jQuery API Documentation](https://api.jquery.com/trigger/) #ril
  - [Events \| jQuery API Documentation](http://api.jquery.com/category/events/) #ril

## Document Ready ??

  - [$( document )\.ready() \| jQuery Learning Center](https://learn.jquery.com/using-jquery-core/document-ready/) #ril
  - [\.ready() \| jQuery API Documentation](http://api.jquery.com/ready/) #ril

## DOM Traversing ??

  - [Traversing \| jQuery Learning Center](http://learn.jquery.com/using-jquery-core/traversing/) #ril
  - [Traversing \| jQuery API Documentation](https://api.jquery.com/category/traversing/) #ril

## DOM Manipulation ??

  - [Manipulating Elements \| jQuery Learning Center](http://learn.jquery.com/using-jquery-core/manipulating-elements/) #ril

  - [Creating New Elements - Manipulating Elements \| jQuery Learning Center](http://learn.jquery.com/using-jquery-core/manipulating-elements/#creating-new-elements)
      - jQuery offers a trivial and elegant way to create new elements using the same `$()` method used to make selections: 以 `<` 開頭就視為要建立 element??

            // Creating new elements from an HTML string.
            $( "<p>This is a new paragraph</p>" );
            $( "<li class=\"new\">new list item</li>" );

            // Creating a new element with an ATTRIBUTE OBJECT.
            $( "<a/>", {
                html: "This is a <strong>new</strong> link",
                "class": "new",
                href: "foo.html"
            });

        Note that the attributes object in the second argument above, the property name `class` is quoted, although the property names `html` and `href` are not. Property names generally do not need to be quoted unless they are reserved words (as `class` is in this case).

      - When you create a new element, it is not immediately added to the page. There are SEVERAL WAYS to add an element to the page once it's been created.

            // Getting a new element on to the page.
            var myNewElement = $( "<p>New element</p>" );
            myNewElement.appendTo( "#content" );
            myNewElement.insertAfter( "ul:last" ); // This will remove the p from #content!
            $( "ul" ).last().after( myNewElement.clone() ); // Clone the p so now we have two.

        The created element doesn't need to be stored in a variable – you can call the method to add the element to the page directly after the `$()`. However, most of the time you'll want a REFERENCE to the element you added so you won't have to select it later.

      - You can also create an element as you're adding it to the page, but note that in this case you don't get a reference to the newly created element:

            // Creating and adding an element to the page at the same time.
            $( "ul" ).append( "<li>list item</li>" ); // 加去哪了??

      - The syntax for adding new elements to the page is easy, so it's tempting to forget that there's a HUGE PERFORMANCE COST for adding to the DOM repeatedly. If you're adding many elements to the same container, you'll want to concatenate all the HTML into a single string, and then append that string to the container instead of appending the elements one at a time. Use an array to gather all the pieces together, then join them into a single string for appending:

            var myItems = [];
            var myList = $( "#myList" );

            for ( var i = 0; i < 100; i++ ) {
                myItems.push( "<li>item " + i + "</li>" );
            }

            myList.append( myItems.join( "" ) );

        加東西到 DOM 的成本很高，那修改、移除呢??

  - [DOM Insertion, Inside \| jQuery API Documentation](https://api.jquery.com/category/manipulation/dom-insertion-inside/) #ril
  - [DOM Insertion, Outside \| jQuery API Documentation](https://api.jquery.com/category/manipulation/dom-insertion-outside/) #ril
  - [DOM Insertion, Around \| jQuery API Documentation](https://api.jquery.com/category/manipulation/dom-insertion-around/) #ril
  - [Manipulation \| jQuery API Documentation](https://api.jquery.com/category/manipulation/) #ril

## CSS ??

  - [CSS \| jQuery API Documentation](http://api.jquery.com/category/css/) #ril

## Form ??

  - [Selecting Form Elements - Selecting Elements \| jQuery Learning Center](https://learn.jquery.com/using-jquery-core/selecting-elements/#selecting-form-elements) #ril
      - jQuery offers several pseudo-selectors that help find elements in forms. These are especially helpful because it can be difficult to distinguish between form elements based on their state or type using standard CSS selectors. 聽起來是 CSS 本身能力不足，

  - [\.submit() \| jQuery API Documentation](http://api.jquery.com/submit/) #ril
  - [Forms \| jQuery API Documentation](https://api.jquery.com/category/forms/) #ril

## Ajax ??

  - [Ajax \| jQuery Learning Center](https://learn.jquery.com/ajax/) #ril
  - [Ajax \| jQuery API Documentation](https://api.jquery.com/category/ajax/) #ril

## Effect ??

  - [Effects \| jQuery Learning Center](https://learn.jquery.com/effects/) #ril
  - [Effects \| jQuery API Documentation](http://api.jquery.com/category/effects/) #ril

## 安裝設置 {: #setup }

  - [Download jQuery \| jQuery](http://jquery.com/download/) 用 CDN 比較方便，但什麼時候要下載自己另存一份?? #ril

### CDN

可以從 https://code.jquery.com 取得連結。

除了 minified 與否，jQuery 3.x 還有 regular 與 slim 的差別，slim 版本少了 Ajax 與動畫特效的支援。

Regular:

```
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
```

Slim:

```
<script
  src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
  integrity="sha256-3edrmyuQ0w65f8gfBsqowzjJe2iM6n0nKciPUp8y+7E="
  crossorigin="anonymous"></script>
```

參考資料：

  - [Using jQuery with a CDN - Download jQuery \| jQuery](http://jquery.com/download/#using-jquery-with-a-cdn)
      - CDNs can offer a PERFORMANCE BENEFIT by hosting jQuery on servers spread across the globe. This also offers an advantage that if the visitor to your webpage has already downloaded a copy of jQuery from the same CDN, it won't have to be re-downloaded. 所謂 performance benefit 指的是下載速度，或是不用重新下載。

    jQuery's CDN provided by StackPath

      - The jQuery CDN supports [Subresource Integrity](https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity) (SRI) which allows the browser to verify that the files being delivered have not been modified. This [specification](https://www.w3.org/TR/SRI/) is currently being implemented by browsers. Adding the new `integrity` attribute will ensure your application gains this security improvement as browsers support it. 也就是 `<script src="https://.../jquery.js" integrity="..."></script>` 的用法，認得 `integrity` 的 browser 就會檢查檔案是否遭到變更。
      - To use the jQuery CDN, just reference the file in the `script` tag directly from the jQuery CDN domain. You can get the complete `script` tag, including Subresource Integrity attribute, by visiting https://code.jquery.com and clicking on the version of the file that you want to use. Copy and paste that tag into your HTML file.

        例如 jQuery Core 3.3.1 - uncompressed, minified, slim, slim minified 按下 minified 的連結就會彈出：

            <script
              src="https://code.jquery.com/jquery-3.3.1.min.js"
              integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
              crossorigin="anonymous"></script>

        The `integrity` and `crossorigin` attributes are used for Subresource Integrity (SRI) checking. This allows browsers to ensure that resources hosted on third-party servers have not been tampered with. Use of SRI is recommended as a best-practice, whenever libraries are loaded from a third-party source. Read more at [srihash.org](https://www.srihash.org/) 如果是放自家，就不用做這層檢查了。

    Other CDNs

      - The following CDNs also host compressed and uncompressed versions of jQuery releases. Starting with jQuery 1.9 they may also host sourcemap files; check the site's documentation.
      - Note that there may be delays between a jQuery release and its availability there. Please be patient, they receive the files at the same time the blog post is made public. Beta and release candidates are not hosted by these CDNs -- [Google CDN](https://developers.google.com/speed/libraries/devguide#jquery)、[Microsoft CDN](https://www.asp.net/ajax/cdn#jQuery_Releases_on_the_CDN_0)、[CDNJS](https://cdnjs.com/libraries/jquery/)、[jsDelivr CDN](https://www.jsdelivr.com/package/npm/jquery) 會採用非官方的 CDN，是因為速度更快?

      - We will include an explanation in the 3.0 final blog post (and we'll probably want to find a place somewhere on jquery.com). That said, it is a custom build of jQuery that excludes effects, ajax, and deprecated code.

  - [What are the differences between normal and slim package of jquery? \- Stack Overflow](https://stackoverflow.com/questions/35424053/)
      - Bhojendra Rauniyar: 找出 `jquery.slim.js` 少了哪些程式碼，提到 ajax、animation effects 還有 XML parsing。
      - gxclarke: 引用 [What is included in the slim version of jQuery? · Issue \#2995 · jquery/jquery](https://github.com/jquery/jquery/issues/2995) 的說法 -- it is a custom build of jQuery that excludes EFFECTS, AJAX, and deprecated code.

        I suspect that the rationale for excluding these components of the jQuery library is in recognition of the increasingly common scenario of jQuery being used in conjunction with another JS framework like Angular or React. In these cases, the usage of jQuery is primarily for DOM TRAVERSAL and MANIPULATION, so leaving out those components that are either obsolete or are provided by the framework gains about a 20% reduction in file size. 即便有 Angular/React，還是有 jQuery 可以發揮的地方。

      - Jannie Theunissen: 引用 [jQuery 3\.0 Final Released\! \| Official jQuery Blog](https://blog.jquery.com/2016/06/09/jquery-3-0-final-released/) 的說法：

        Sometimes you don’t need ajax, or you prefer to use one of the many standalone libraries that focus on ajax requests. And often it is simpler to use a combination of CSS and class manipulation for all your web animations. Along with the regular version of jQuery that includes the [ajax](https://api.jquery.com/category/ajax/) and [effects](https://api.jquery.com/category/effects/) modules, we’re releasing a “slim” version that excludes these modules. All in all, it excludes ajax, effects, and currently deprecated code. The size of jQuery is very rarely a LOAD PERFORMANCE concern these days, but the slim build is about 6k gzipped bytes smaller than the regular version – 23.6k vs 30k. 呼應上面讓 jQuery 專注在 DOM traversal/manipulation 的說法。

## 參考資料 {: #reference }

  - [jQuery](https://jquery.com/)
  - [jquery/jquery - GitHub](https://github.com/jquery/jquery)
  - [jQuery Blog](https://blog.jquery.com/)

社群：

  - [jQuery Forum](http://forum.jquery.com/)
  - ['jquery' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/jquery)
  - [jquery (@jquery) | Twitter](https://twitter.com/jquery)

學習資源：

  - [jQuery Learning Center](https://learn.jquery.com/)

手冊：

  - [jQuery API Documentation](https://api.jquery.com/)

