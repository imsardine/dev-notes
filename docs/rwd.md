# Responsive Web Design (RWD)

  - [Responsive web design \- Wikipedia](https://en.wikipedia.org/wiki/Responsive_web_design) #ril
      - [Content is like water, a saying that illustrates the principles of RWD](https://en.wikipedia.org/wiki/File:Content-is-like-water-1980.jpg) 這張圖好有感！
      - Responsive web design (RWD) is an approach to web design that makes web pages RENDER WELL on a variety of devices and window or SCREEN SIZES.
      - A site designed with RWD adapts the layout to the viewing environment by using FLUID, proportion-based GRIDS, flexible images, and CSS3 MEDIA QUERIES, an extension of the `@media` rule 其中 media query 可以根據裝置的特性 (通常是瀏覽器的寬度) 決定採用不同的 CSS style rules。
      - RWD 在總 internet traffic 超過一半來自 mobile 後更形重要，也因此 Google 在 2015 宣布 Mobilegeddon 演算法 -- 如果使用者從 mobile 上搜尋，mobile friendly 的網站會得到比較高的 rating。
  - [Official Google Webmaster Central Blog: Rolling out the mobile\-friendly update](https://webmasters.googleblog.com/2015/04/rolling-out-mobile-friendly-update.html) (2015-04-21) #ril

## 新手上路 ?? {: #getting-started }

  - [Responsive Web Design Introduction](https://www.w3schools.com/css/css_rwd_intro.asp)
      - Web pages should not LEAVE OUT information to fit smaller devices, but rather ADAPT its content to fit any device 不是拿掉一些東西，而是根據 device 調適。
      - It is called responsive web design when you use CSS and HTML to resize, HIDE, shrink, enlarge, or move the content to make it look good on any screen. 不含 JavaScript??
  - [Responsive Web Design Viewport](https://www.w3schools.com/css/css_rwd_viewport.asp)
      - The viewport is the user's visible area of a web page. 會因 device 而異；不完全等同於 screen size? 因為手機畫面可能會切割
      - 在 tablet、mobile phone 出現之前，網頁只為 computer 設計 -- static design + fixed size，但這樣的設計塞不進 viewport，瀏覽器的 quick fix 是把整個網頁縮小，但這不是最佳解。
      - HTML5 可以透過 `viewport` 這個 metadata 控制 viewport，例如 `<meta name="viewport" content="width=device-width, initial-scale=1.0">`；其中 `width=device-width` 會把 screen/viewport width 當做 page width，而 `initial-scale=1.0` 則是設定一開始的 zoom level。下面的範例，光是加了 `viewport` meta tag 就有很明顯的差異。
      - Users are used to scroll websites vertically on both desktop and mobile devices - but NOT HORIZONTALLY! So, if the user is forced to scroll horizontally, or zoom out, to see the whole web page it results in a poor user experience. 這一點很關鍵!! 有幾點建議 1) Do NOT use large fixed width elements 要隨 viewport width 調整 2) Do NOT let the content rely on a particular viewport width to render well (例如過往常見的 "建議使用 1024 x 768 瀏覽") 3) Use CSS media queries to apply different styling for small and large screens
  - [Responsive Web Design Grid](https://www.w3schools.com/css/css_rwd_grid.asp) #ril
      - 首先要確保所有 HTML element 都套用 `box-sizing: border-box` -- padding 跟 border 都算在 element 的大小裡；從 [box\-sizing \- CSS: Cascading Style Sheets \| MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/box-sizing) 看來，`box-sizing: border-box` 可以確保 child container 不會突出 parent container 外。

            * {
                box-sizing: border-box;
            }

      - 目標是建立 responsive grid-view -- 將畫面分割為 12 個欄位 (column)，所以每個 column 暫用的寬度是 100% / 12 = 8.33% -- to have more control over the web page. 為此建立 12 個 class `.col-{1,12}`：

            .col-1 {width: 8.33%;}
            .col-2 {width: 16.66%;}
            .col-3 {width: 25%;}
            .col-4 {width: 33.33%;}
            .col-5 {width: 41.66%;}
            .col-6 {width: 50%;}
            .col-7 {width: 58.33%;}
            .col-8 {width: 66.66%;}
            .col-9 {width: 75%;}
            .col-10 {width: 83.33%;}
            .col-11 {width: 91.66%;}
            .col-12 {width: 100%;}


        所有 column 會應往左靠 (floating to the left)：

            [class*="col-"] {
                float: left;
                padding: 15px; // 下面這兩個 properties 只是為了方便說明
                border: 1px solid red;
            }

        搭配 `class="col-{1,12}" 就可以定義某個區塊 (例如 menu、content 等) 要佔幾個 columns 的寬度：

            <div class="row">
              <div class="col-3">...</div> <!-- 25% -->
              <div class="col-9">...</div> <!-- 75% -->
            </div>
      - The columns inside a row are all floating to the left, and are therefore taken out of the flow of the page, and other elements will be placed AS IF THE COLUMNS DO NOT EXIST. To prevent this, we will add a style that clears the flow: 試不出來前後有什麼差別??

            .row::after {
                content: "";
                clear: both;
                display: table;
            }

  - [Responsive Web Design Media Queries](https://www.w3schools.com/css/css_rwd_mediaqueries.asp) #ril
      - Media query 是 CSS3 引進的做法 -- It uses the `@media` rule to include a block of CSS properties only if a certain CONDITION is true. 例如：

            @media only screen and (max-width: 600px) { // 視窗寬度 <= 600 時才生效
                body {
                    background-color: lightblue;
                }
            }

      - 上一節 responsive grid view 的安排將在這裡發揮作用，設定一個分割點 (breakpoint) -- 螢幕寬度多少要開始採用另一套 layout：

            @media only screen and (max-width: 768px) { // 跨過 768px 這門檻，所有套用 `col-*` 的區塊，都會放大到 100%
                /* For mobile phones: */
                [class*="col-"] {
                    width: 100%;
                }
            }

  - [The building blocks of responsive design \- App Center \| MDN](https://developer.mozilla.org/en-US/docs/Web/Apps/Progressive/Responsive/responsive_design_building_blocks) #ril
  - [Responsive Navigation Patterns \- App Center \| MDN](https://developer.mozilla.org/en-US/docs/Web/Apps/Progressive/Responsive/Responsive_navigation_patterns) #ril

## Viewport Meta ??

  - [Setting The Viewport - Responsive Web Design Viewport](https://www.w3schools.com/css/css_rwd_viewport.asp) 加了 `viewport` meta tag 就有很明顯的差異!!
  - [Viewport \- MDN Web Docs Glossary: Definitions of Web\-related terms \| MDN](https://developer.mozilla.org/en-US/docs/Glossary/viewport) 文件目前在 browser window 裡可以看到的部份 (除非是 full screen mode，否則 screen 不等同於 window)，要看到 viewport 外的東西就要捲動。
  - [Using the viewport meta tag to control layout on mobile browsers \- Mozilla \| MDN](https://developer.mozilla.org/en-US/docs/Mozilla/Mobile/Viewport_meta_tag) #ril
      - Narrow screen devices (e.g. mobiles) render pages in a virtual window or viewport, which is usually wider than the screen, and then shrink the rendered result down so it can all be seen at once. 關鍵就在比 screen 還大的 virtual windows!!
      - This is done because many pages are not MOBILE OPTIMIZED, and break (or at least look bad) when rendered at a small viewport width. This virtual viewport is a way to make non-mobile-optimized sites in general look better on narrow screen devices. 加 `<meta name="viewport" ...>` 有宣告 mobile-optimized 的意味。
  - [Responsive Meta Tag \| CSS\-Tricks](https://css-tricks.com/snippets/html/responsive-meta-tag/) #ril
  - [<meta\>: The Document\-level Metadata element \- HTML: HyperText Markup Language \| MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meta#attr-name) #ril
  - [Viewport <META\> element - CSS Device Adaptation Module Level 1](https://drafts.csswg.org/css-device-adapt/#viewport-meta) #ril
  - [Responsive Web Design 基礎 : <meta name=”viewport” \> 設定 – Frochu – Medium](https://medium.com/frochu/html-meta-viewport-setting-69fbb06ed3d8) (2018-02-05) #ril

