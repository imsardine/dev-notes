---
title: HTML / Form
---
# [HTML](html.md) / Form

## Validation ??

  - [Form data validation \- Learn web development \| MDN](https://developer.mozilla.org/en-US/docs/Learn/HTML/Forms/Form_validation)
      - Form validation 的做法有很多種，主要分為 client-side vlidation 及 server-side validation。
      - Client-side validation 發生在資料未送往 server 前，就 instant response 而言，它比 server-side validation 還 user-friendly。可以進一步細分為 JavaScript valication (可自訂) 及 built-in form validation -- HTML5 專屬的功能，通常不需要 JavaScript，但也不能自訂。
      - Server-side validation 發生在資料送到 server 後，雖然比較不友善 (回應沒有 client-side validation 那麼即時)，但 server-side validation 做為最後一條防線，是不能捨棄的；However, server-side validation is your application's last line of defence against incorrect or even malicious data. All popular server-side frameworks have features for validating and sanitizing (消毒) data (making it safe).
      - In the real world, developers tend to use a combination of client-side and server-side validation. 但 client-side validation 會用 JavaScript 還是 built-in form validation 呢??
      - HTML5 有個功能可以幫驗證資料，也不需要用到 script -- 透過 form element 上的 validation attributes，可以描述不同的 rule，當輸入的資料符合所有的 rule 時視為 valid，否則視為 invalid。當 element 為 valid 時，CSS 會套用 `:valid` pseudo-class 的樣式，按 submit 會送出資料 (如果沒有 JavaScript 擋下的話)，反之常 element 為 invalid 時，CSS 會套用 `:invalid` pseudo-class 的樣式，此時若使用者試圖送出資料，會被 browser 擋下來並提示 error message；在 Chrome 上發現，一次只會提醒一個 invalid 的欄位，有點煩。
      - Validation constraints on input elements — starting simple 開始說明一些 validation attributes 的用法，例如 `required`、`pattern` 等 #ril
      - Customized error messages 提到 built-in form validation 發生錯誤時的表現方式會因 browser 而異 (且語言會跟著 browser local 走)，HTML5 是有提供 constraint validation API 可以改變 message，但表現方式還是不能自訂。
  - [Validating forms using JavaScript - Form data validation \- Learn web development \| MDN](https://developer.mozilla.org/en-US/docs/Learn/HTML/Forms/Form_validation#Validating_forms_using_JavaScript) #ril
      - 第一個範例就直接用了 `<form novalidate>`，`novalidate` attribute 可以停用 browser 的 automatic validation，讓我們的 script 可以完全控制 validation，但它並不會影響 constraint validation API 及 CSS pseudo-class (`:valid`、`:invalid`、`:in-range`、`:out-of-range` 等) 的效用。

## 如何送出同名的多個 elements??

```
<form action="http://mysvr/search" method="get">
  <input type="checkbox" name="categories" value="dev" checked> Development
  <input type="checkbox" name="categories" value="life"> Life
  <input type="submit">
</form>
```

同時勾選 Development 與 Life 按 Submit 後，URL 會呈現 `http://mysvr/search?categories=dev&categories=life`，而非 `?categories=dev,life`。

  - [php \- POSTing Form Fields with same Name Attribute \- Stack Overflow](https://stackoverflow.com/questions/2203430/) 出現 `name[]` 的用法 #ril 
  - [python \- Sending a form array to Flask \- Stack Overflow](https://stackoverflow.com/questions/24808660/) Martijn Pieters: 欄位名稱加 `[]` 的做法是 PHP 的慣例，但這不是標準，雖然 Ruby on Rails 也這麼做。如果要走相同的 convention 可以用 `request.form.getlist('name[]')`，但不加 `[]` 其實 Flask 也可以處理 - `request.form.getlist('name')` #ril
  - [php \- Form input field names containing square brackets like field\[index\] \- Stack Overflow](https://stackoverflow.com/questions/4543500/) (2010-12-28) #ril

## application/x-www-form-urlencoded, multipart/form-data ??

  - [http \- application/x\-www\-form\-urlencoded or multipart/form\-data? \- Stack Overflow](https://stackoverflow.com/questions/4007969/) #ril
  - [application/x-www-form-urlencoded - Forms in HTML documents](https://www.w3.org/TR/html401/interact/forms.html#didx-applicationx-www-form-urlencoded) #ril
      - Control name (control element 的 `name` attribute) 跟 value 都會做 (分開做) escaping -- 空白用 `+` 表示、非英數字都要用 `%HH` 取代、斷行用 `CR LF` (也就是 `%0D%0A`) 表示 => 簡單的說，就是先將 space 換成 `+` 再做 URL-encode。
      - name 跟 value 用 `=` 分開，name/value pairs 間則用 `&` 串起來 (同 HTML 裡出現的順序)。
  - [2.2. URL Character Encoding Issues - RFC 1738 \- Uniform Resource Locators (URL)](https://tools.ietf.org/html/rfc1738#section-2.2) Octet 可以用 `%HH` (character triplet) 編碼；除了英數字 (alphanumerics) 之外，沒有 US-ASCII (20 ~ 7E) 對應、unsafe、reserved 的字元都要做 encode。

## Redirect After Post (RAP) ??

  - 對後端產生異動之後的回應，務必要實現 RAP；除了避免使用者重整頁面造成異動重複發出的問題之外，也讓使用者沒有機會拿到該 URL 去 bookmark 起來，如果被網路機器人拿到更糟, 它會不斷發出不適當的要求，產生一連串不必要的錯誤。

參考資料：

  - [Redirect After Post](http://wiki.c2.com/?RedirectAfterPost) #ril
