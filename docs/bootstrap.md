# Bootstrap

  - [Bootstrap · The most popular HTML, CSS, and JS library in the world\.](https://getbootstrap.com/)
      - Build RESPONSIVE, MOBILE-FIRST projects on the web with the world’s most popular front-end COMPONENT LIBRARY.
      - Bootstrap is an open source toolkit for developing with HTML, CSS, and JS. Quickly prototype your ideas or build your entire app with our Sass variables and mixins, responsive grid system, extensive prebuilt components, and powerful plugins BUILT ON JQUERY.

## jQuery ??

  - [v5 without jQuery by Johann\-S · Pull Request \#23586 · twbs/bootstrap](https://github.com/twbs/bootstrap/pull/23586) 要拔除對 jQuery 的相依 #ril

## 應用實例 {: #powered-by }

  - [Bootstrap Expo](https://expo.getbootstrap.com/)
  - [Examples · Bootstrap](https://getbootstrap.com/docs/4.3/examples/)

## 新手上路 ?? {: #getting-started }

  - [Introduction · Bootstrap](https://getbootstrap.com/docs/4.3/getting-started/introduction/)
      - Copy-paste the stylesheet <link> into your <head> before all other stylesheets to load our CSS.
      - Many of our components require the use of JavaScript to function. Specifically, they require jQuery, Popper.js, and our own JavaScript plugins. Place the following `<script>`s near the end of your pages, RIGHT BEFORE THE CLOSING `</body>` TAG, to enable them. jQuery must COME FIRST, then Popper.js, and then our JavaScript plugins.

        Our `bootstrap.bundle.js` and `bootstrap.bundle.min.js` include Popper, but not jQuery.

      - Be sure to have your pages set up with the latest design and development standards. That means using an HTML5 DOCTYPE and including a VIEWPORT META TAG for proper responsive behaviors. Put it all together and your pages should look like this:

            <!doctype html>
            <html lang="en">
              <head>
                <!-- Required meta tags -->
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

                <!-- Bootstrap CSS -->
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

                <title>Hello, world!</title>
              </head>
              <body>
                <h1>Hello, world!</h1>

                <!-- Optional JavaScript -->
                <!-- jQuery first, then Popper.js, then Bootstrap JS -->
                <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
              </body>
            </html>

    Important globals

      - Bootstrap employs a handful of important global styles and settings that you’ll need to be aware of when using it, all of which are almost exclusively geared towards the normalization of cross browser styles. Let’s dive in.

        所謂 global setting 應該是 JavaScript variable，但什麼是 global style??

    HTML doctype

      - Bootstrap requires the use of the HTML5 doctype. Without it, you’ll see some funky incomplete styling, but including it shouldn’t cause any considerable hiccups.

            <!doctype html>
            <html lang="en">
              ...
            </html>

    Responsive meta tag

      - Bootstrap is developed mobile first, a strategy in which we optimize code for mobile devices first and then SCALE UP COMPONENTS AS NECESSARY using CSS media queries. To ensure proper rendering and touch zooming for all devices, add the responsive viewport meta tag to your `<head>`.

            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    Box-sizing

      - For more straightforward sizing in CSS, we switch the global `box-sizing` value from `content-box` to `border-box`. This ensures `padding` DOES NOT AFFECT THE FINAL COMPUTED WIDTH of an element, but it can cause problems with some third party software like Google Maps and Google Custom Search Engine. 指內嵌其他元件時，可能因為 `box-sizing` 不是 `content-box` 的關係導致顯示上有異常。

      - On the rare occasion you need to override it, use something like the following:

            .selector-for-some-widget {
              box-sizing: content-box;
            }

    Reboot

      - For improved cross-browser rendering, we use [Reboot](https://getbootstrap.com/docs/4.3/content/reboot/) to correct inconsistencies across browsers and devices while providing slightly more OPINIONATED RESETS to common HTML elements. 這不就是 global style 嗎??

## Layout ??

  - [Layout Overview · Bootstrap](https://getbootstrap.com/docs/4.3/layout/overview/) #ril

## Theme ??

  - [Official Themes - Bootstrap · The most popular HTML, CSS, and JS library in the world\.](https://getbootstrap.com/)
      - Take Bootstrap 4 to the next level with official PREMIUM Themes—toolkits built on Bootstrap with new components and plugins, docs, and build tools. 都是要收費的
  - [Bootstrap Themes Built & Curated by the Bootstrap Team\.](https://themes.getbootstrap.com/) #ril

## 安裝設置 {: #setup }

  - [Installation - Bootstrap · The most popular HTML, CSS, and JS library in the world\.](https://getbootstrap.com/)
      - Installation -- Include Bootstrap’s source [Sass](sass.md) and JavaScript files via npm, [Composer](https://getcomposer.org/) or [Meteor](https://www.meteor.com/). Package managed installs don’t include documentation, but do include our build system?? and readme.

            npm install bootstrap
            gem install bootstrap -v 4.3.1

      - BootstrapCDN -- When you only need to include Bootstrap’s COMPILED CSS or JS, you can use BootstrapCDN. 為什麼有 source/compile 的概念??

        CSS only


            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        JS, [Popper.js](https://popper.js.org/)??, and jQuery

            <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

  - [Download · Bootstrap](https://getbootstrap.com/docs/4.3/getting-started/download/)

## 參考資料 {: #reference }

  - [Bootstrap](https://getbootstrap.com/)
  - [twbs/bootstrap - GitHub](https://github.com/twbs/bootstrap)
  - [Bootstrap Blog](https://blog.getbootstrap.com/)

社群：

  - [Bootstrap (@getbootstrap) | Twitter](https://twitter.com/getbootstrap)
  - ['bootstrap-4' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/bootstrap-4)

相關：

  - 跟 [Semantic UI](semantic-ui.md) 是一樣的東西。
  - [Sass](sass.md)
