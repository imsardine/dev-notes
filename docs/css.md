# CSS (Cascading Style Sheets)

  - CSS 是用來描述 HTML/XML 文件該如何在不同媒體上表現 (presentation) 的 stylesheet language，可能的媒體有 screen、paper 等。
  - 按 level 逐步開發推展，CSS1 已經淘汰 (obsolete)，目前 CSS2.1 是推薦 (recommendation)，而 CSS3 則切分成不同 module，逐步標準化中。

參考資料：

  - CSS | MDN https://developer.mozilla.org/en-US/docs/Web/CSS 說明 CSS 的用途、標準的推展。

### CSS 跟平面印刷、語音等表現有關?

  - CSS | MDN https://developer.mozilla.org/en-US/docs/Web/CSS 提到 paper、speech 等非 screen 的媒體，前者應該是指列印的時候，但 speech 就比較難理解??
  - speak | CSS-Tricks https://css-tricks.com/almanac/properties/s/speak/ 只是在調整使用 screen reader 時的 experience #ril

## 基礎

### Hello, World! ??

### 新手上路 ??

參考資料：

  - CSS basics - Learn web development | MDN https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/CSS_basics #ril
  - Learn to style HTML using CSS - Learn web development | MDN https://developer.mozilla.org/en-US/docs/Learn/CSS #ril

### Data Type ??

  - [CSS basic data types \- CSS: Cascading Style Sheets \| MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Types) #ril
      - 用來定義 CSS property 可以接受的 value (包括 keyword、unit 等)；在語法中，會用 `<data_type>` 來表示，例如 `<angle>`、`<color>`、`<ratio>` 等。
  - [CSS Values and Units Module Level 3](https://www.w3.org/TR/css3-values/) #ril

### Length ??

  - [<length> \- CSS: Cascading Style Sheets \| MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/length) #ril
      - `<length>` 表示 distance value，由 `<number>` (可能是負數) 及一個 unit 構成，跟其他 CSS 尺寸 (dimensions) 一樣，在 number 與 unit literal 間不能有空白；當然，如果 number 是 `0`，那後面的 unit 就可有可無。
      - Unit 大致分為 relative 與 absolute 兩類。

### Specificity ??

  - [Specificity \- CSS: Cascading Style Sheets \| MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/Specificity) #ril
      - Specificity is the means by which browsers decide which CSS property values are the MOST RELEVANT to an element and, therefore, will be applied.
  - [Precedence in CSS \(When Order of CSS Matters\) \| CSS\-Tricks](https://css-tricks.com/precedence-css-order-css-matters/) (2016-08-02) #ril
  - [CSS Specificity: Things You Should Know — Smashing Magazine](https://www.smashingmagazine.com/2007/07/css-specificity-things-you-should-know/) (2007-07-27) #ril
  - [In which order do CSS stylesheets override? \- Stack Overflow](https://stackoverflow.com/questions/9459062/) When multiple rules of the same "specificity level" exist, whichever one appears last wins. #ril

### 如何寫註解?

  - CSS 裡註解的表示法只有一種 `/* ... */`，可以寫成單行，也可以橫跨多行，但不能交疊 (nested)。

參考資料：

  - CSS basics - Learn web development | MDN https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/CSS_basics#Fonts_and_text 提到 CSS comment 寫在 `/* ... */` 裡。
  - Comments - CSS | MDN https://developer.mozilla.org/en-US/docs/Web/CSS/Comments 強調 `/* ... */` 同時用在 single-line 與 multiline comments，沒有其他寫法。

### 設定 width/height 時，padding、border 跟 margin 有沒有算在內?

  - 不算在內。設定 width/height 時是針對 content，所以整個 box 的大小要另外把 padding、border 及 margin 算進來。

參考資料：

  - CSS Box Model https://www.w3schools.com/css/css_boxmodel.asp 由內而外，box model 由 content、padding、border 與 margin 組成，其中 padding 跟 margin 都是透明的；當設定 width/height 時，是指 content area，所以 full size 要另外把 padding、border、margin 加進來。

### Selector ??

  - Selectors - Learn web development | MDN https://developer.mozilla.org/en-US/docs/Learn/CSS/Introduction_to_CSS/Selectors #ril

### 如何設定字型?

  - CSS basics - Learn web development | MDN https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/CSS_basics#Fonts_and_text Font and text 利用 Google Fonts 產生

### Unit ??

  - [<length> \- CSS: Cascading Style Sheets \| MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/length) #ril

## 參考資料 {: #reference }

社群：

  - ['css' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/css)

手冊：

  - [Cascading Style Sheets - W3C](https://www.w3.org/Style/CSS/)
  - [CSS Reference | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference)
  - [Basic Data Types](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Types)

