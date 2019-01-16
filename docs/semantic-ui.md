# Semantic UI

  - [Semantic UI](https://semantic-ui.com/) #ril
      - Semantic is a development framework that helps create beautiful, RESPONSIVE layouts using human-friendly HTML.

## 新手上路 ?? {: #getting-started }

  - 不同的 element 會有不同的 sample，過程中就會學到各式 class 的用法；看過幾個範例，就能體會什麼是 semantic 了。

參考資料：

  - [Semantic UI](https://semantic-ui.com/)
      - Concise HTML: Semantic UI treats WORDS and CLASSES as exchangeable concepts. Classes use syntax from NATURAL LANGUAGES like noun/modifier relationships, word order, and PLURALITY to link concepts intuitively. 意思是 class 寫起來像是 natural laugnage 一樣 (例如下面的 "three buttons"，注意最後的 `s`)，這就是所謂的 semantic。下面的例子，很神奇的，active button 會自己變色!!

    ```
<div class="ui three buttons">
  <button class="ui active button">One</button>
  <button class="ui button">Two</button>
  <button class="ui button">Three</button>
</div>
    ```

      - Intuitive Javascript: Semantic uses simple phrases called BEHAVIORS that trigger functionality. 原來 Semantic UI 跟 JavaScript 也有關係，因為套上 `ui` class 而有的行為嗎?? 什麼是 behavior??

   ```
<select name="skills" multiple="" class="ui fluid dropdown">
  <option value="">Skills</option>
  <option value="angular">Angular</option>
  <option value="css">CSS</option>
  <option value="ember">Ember</option>
  <option value="html">HTML</option>
  <option value="javascript">Javascript</option>
  <option value="meteor">Meteor</option>
  <option value="node">NodeJS</option>
</select>

$('select.dropdown') // 執行下去，會讓 list 收合起來，只剩兩個選定的項目，還可以移除
  .dropdown('set selected', ['meteor', 'ember'])
;
   ```

      - Simplified Debugging: Performance logging lets you track down bottlenecks without digging through stack traces. 開啟 Chrome 的 Developer Tools > Console，可以看到一些 debug info，以下面的例子，加上 `debug: true`，就可以看到動畫在每個環節花了多少時間。

    ```
$('.sequenced.images .image')
  .transition({
    debug     : true,
    animation : 'jiggle',
    duration  : 500,
    interval  : 200
  })
;
    ```

      - Unbelievable Theming: Semantic comes equipped with an intuitive INHERITANCE system and high level THEMING variables that let you have complete design freedom. 有 theme 可以切換，也可以進一步覆寫；下面更提到 3000+ Theming Variables
      - Unbelievable Breadth: Definitions aren't limited to just buttons on a page. Semantic's COMPONENTS allow several distinct TYPES of definitions: elements, collections, views, modules and behaviors which cover the gamut of interface design. 分為 element、collection、view、module 跟 behavior，要如何區分??
      - Responsively Designed: Semantic is designed completely with EM making responsive sizing a breeze. Design variations built into elements allow you to make the choice how content adjusts for tablet and mobile. 有面對不同 screen size 如何反應的選項可以調整。
      - Partners with Libraries You Love: Semantic has integrations with React, Angular, Meteor, Ember and many other frameworks to help organize your UI layer alongside your application logic. 專注在 UI layer，跟其他 framework 不相衝突。

  - [Getting Started \| Semantic UI](https://semantic-ui.com/introduction/getting-started.html) #ril

## Component ??

  - [ui - Project Terminology - Glossary \| Semantic UI](https://semantic-ui.com/introduction/glossary.html#project-terminology)
      - `ui` is a special class name used to distinguish parts of components from components. 只會在 component 的最外層用 `ui` class (方便識別 component)，例如 list element 用 `ui list`，但裡面的 item 只會用 `item` (而非 `ui item`)。
      - The ui class name helps encapsulate CSS rules by making sure all 'parts of a component' are defined in context to a 'whole' component. 大概就是這樣的感覺，不過像 [card](https://semantic-ui.com/views/card.html) 這類較複雜的 compoent，巢狀的 `ui` 是可能出現的。
  - [Message - Form \| Semantic UI](https://semantic-ui.com/collections/form.html#message) A form CAN contain a message 似乎巢狀的 UI components 也不是隨便支援??
  - [Button \| Semantic UI](https://semantic-ui.com/elements/button.html) 一份 component 文件，通常會分 Types、States、Variations 等幾個區段。

## Message ??

  - [Message \| Semantic UI](https://semantic-ui.com/collections/message.html) #ril
      - A message displays information that explains NEARBY CONTENT；表現上比較像是 message box，因為有個框框，左邊可以有 icon。
      - Type 分為 (basic) message、list message、icon message 與 dismissable block (搭配 JavaScript)；其實 types 間也不完全互斥，而是可以混搭的元素，裡面可以有 list、icon、右上角的叉叉 (可以關閉 message)。
      - Message box 主要用 `ui message` 識別，裡面的標題用 `header` 識別，如果有清單用 `<ul class="list">` 即可，下面的 `<li>` 不用特別宣告 class：

    ```
<div class="ui message">
  <div class="header">
    New Site Features
  </div>
  <ul class="list">
    <li>You can now have cover images on blog pages</li>
    <li>Drafts will now auto-save while writing</li>
  </ul>
</div>
    ```

      - Possive/success 或 negative/error message，加上 `positive`/`success` 或 `negatice`/`error` 即可，例如 `<div class="ui negative message">`。
      - Icon 會出大大地出現在 message box，不過這要在最外層加上 `icon` 識別，裡面也要用 `content` 內容區隔開來 (icon 在左側，內容在右側)，例如：

    ```
<div class="ui icon message">
  <i class="inbox icon"></i>
  <div class="content">
    <div class="header">
      Have you heard about our mailing list?
    </div>
    <p>Get the best news in your e-mail every day.</p>
  </div>
</div>
    ```

## Form ??

  - [Form \| Semantic UI](https://semantic-ui.com/collections/form.html) #ril
      - 整個 form 用 `ui form` 識別，裡面個別 (邏輯上的) 欄位用 `field` 識別；因為欄位 = label + control 的關係，習慣用 `<div class="field">` 包裝一層。

    ```
<form class="ui form">
  <div class="field">
    <label>First Name</label>
    <input type="text" name="first-name" placeholder="First Name">
  </div>
  <div class="field">
    <label>Last Name</label>
    <input type="text" name="last-name" placeholder="Last Name">
  </div>
  <div class="field">
    <div class="ui checkbox"> <-- 邏輯上的集合，但還是擺 field 裡面
      <input type="checkbox" tabindex="0" class="hidden">
      <label>I agree to the Terms and Conditions</label>
    </div>
  </div>
  <button class="ui button" type="submit">Submit</button> <-- 不是 field
</form>
    ```

      - Form 的 state 有 `loading`、`success`、`error` 跟 `warning`；`loading` 會有個 loader 覆蓋在 form 上面 (半透明)，`success`/`error`/`warning` 主要是顯示 success/error/warning message；也就是輸出 HTML 不用控制要不要輸出對應的 block，從 form 的 class 就可以操控要顯示哪個 message box。
      - Form 的 `error` state，可以搭配 field 的 `error` state 一起使用，例如 `<div class="field error">`，會跟著 error message box 一起呈現紅色。

## Layout ??

  - [Layouts \| Semantic UI](https://semantic-ui.com/usage/layout.html) #ril

## Form Validation ??

  - [Form Validation \| Semantic UI](https://semantic-ui.com/behaviors/form.html) #ril

## Theme ??

  - [Theming \| Semantic UI](https://semantic-ui.com/usage/theming.html) #ril
  - [Message \| Semantic UI](https://semantic-ui.com/collections/message.html) 只有 3 種 theme? 跟 button 的 11 種 theme 差很多，會不會有不一致的問題??

## Icon

  - [Icon \| Semantic UI](https://semantic-ui.com/elements/icon.html) #ril
      - 一個 icon set 裡多個 glyph 組成。在 Semantics 裡，icon 會以 `<i>` 來表現?
      - Semantic includes a complete port of Font Awesome，意指 Semantic UI 的 icon 是 Font Awsome 的父集合??

## 安裝設定 {: #installation }

  - [Installing - Getting Started \| Semantic UI](https://semantic-ui.com/introduction/getting-started.html#installing) #ril
  - [Include in Your HTML - Getting Started \| Semantic UI](https://semantic-ui.com/introduction/getting-started.html#include-in-your-html) #ril
      - Semantic UI 自己的 CSS 及 JavaScript，但也會用到 jQuery。

## 參考資料 {: #reference }

  - [Semantic UI](https://semantic-ui.com/)
  - [Semantic-Org/Semantic-UI - GitHub](https://github.com/semantic-org/semantic-ui/)

社群：

  - ['semantic-ui' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/semantic-ui)

手冊：

  - [All UI](https://semantic-ui.com/kitchen-sink.html)

