# Favicon

  - Favicon 唸做 `/ˈfæv.ɪˌkɒn/`。

---

參考資料：

  - [Favicon \- Wikipedia](https://en.wikipedia.org/wiki/Favicon)
      - A favicon `/ˈfæv.ɪˌkɒn/` (short for favorite icon), also known as a shortcut icon, website icon, tab icon, URL icon, or bookmark icon, is a file containing ONE OR MORE small icons, associated with a particular website or web page. ... Favicons can also be used to have a textless favorite site, saving space. 一個 `.ico` 裡可以藏好幾張圖?? 常出現在 address bar、tab、bookmark 等。
      - In March 1999, Microsoft released Internet Explorer 5, which supported favicons for the first time. Originally, the favicon was a file called `favicon.ico` placed in the ROOT DIRECTORY of a website. It was used in Internet Explorer's favorites (bookmarks) and next to the URL in the address bar IF THE PAGE WAS BOOKMARKED. 早期 favicon 可以用來追蹤有多少人 bookmark，但後來許多 browser 不論有沒有 bookmark，需要顯示 favicon 就可能發出 request。

## 新手上路 ?? {: #getting-started }

  - [Favicon \- Wikipedia](https://en.wikipedia.org/wiki/Favicon)
      - The favicon was standardized by the World Wide Web Consortium (W3C) in the HTML 4.01 recommendation ... The standard implementation uses a `link` element with a `rel` attribute in the `<head>` section of the document to specify the FILE FORMAT and FILE NAME and location. Unlike in the prior scheme, the file can be in any Web site directory and have any image file format. 終於不再限定 `/favicon.ico`。
      - RFC 5988 established an IANA LINK RELATION REGISTRY, and `rel="icon"` was registered in 2010 based on the HTML5 specification. The popular `<link rel="shortcut icon" type="image/png" href="image/favicon.png">` theoretically identifies two relations, "shortcut" and "icon", but "shortcut" is not registered and is REDUNDANT. In 2011 the HTML living standard specified that for HISTORICAL REASONS "shortcut" is allowed immediately BEFORE "icon"; however, "shortcut" DOES NOT HAVE A MEANING in this context. 標準的寫法是 `<link rel="icon" ...>`，但因為歷史因素，寫成 `<link rel="shortcut icon" ...>` 也可以，但當中的 `shortcut` relation 是沒有作用的。
  - [How to Add Favicon to Website](https://www.hostinger.com/tutorials/how-to-add-favicon-to-website) (2017-05-09) 自動偵測一定要用 `favicon.ico`，否則就要明確用 `<link rel="shortcut icon" ...>` 宣告在 HTML source 裡 #ril
  - [Favicon Code \| The Icon Handbook](http://iconhandbook.co.uk/reference/examples/favicons/) Markup for Multiple icons 提到可以針對裝置/螢幕大小提供不同的 favicon #ril
  - [Here's Everything You Need to Know About Favicons in 2017](https://sympli.io/blog/2017/02/15/heres-everything-you-need-to-know-about-favicons-in-2017/) (2017-02-15) #ril

## Image File Format

  - [File format support - Favicon \- Wikipedia](https://en.wikipedia.org/wiki/Favicon#File_format_support) File format support 整理了不同 browser 對不同圖檔格式做為 favicon 的支援程度，其中以 ICO、PNG、GIF 支援度最高 (大部份都不支援 animated GIF)，JPG 目前只有 IE 不支援。

## 工具 {: #tools }

  - [Favicon Generator for all platforms: iOS, Android, PC/Mac\.\.\.](https://realfavicongenerator.net/) #ril
  - [favicon\.ico Generator](https://www.favicon.cc/) #ril
