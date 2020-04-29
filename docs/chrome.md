# Google Chrome

  - [Google Chrome \- Wikipedia](https://en.wikipedia.org/wiki/Google_Chrome) #ril

## Search Engine, Autodiscovery ??

  - [Why chrome adds search engines automatically? \- Google Product Forums](https://productforums.google.com/forum/#!topic/chrome/SHGWhqU-rTs) #ril
  - [Tab to Search \- The Chromium Projects](https://www.chromium.org/tab-to-search) #ril
  - [Search Engine Autodiscovery · Martin Thoma](https://martin-thoma.com/search-engine-autodiscovery/) (2011-10-22) #ril
  - [Set your default search engine \- Computer \- Google Chrome Help](https://support.google.com/chrome/answer/95426) #ril
  - [Custom Search Engines in Google Chrome \- gHacks Tech News](https://www.ghacks.net/2018/03/30/custom-search-engines-in-google-chrome/) (2018-03-30) #ril
  - [Google Chrome automatically adding websites to my list of search engines? \- Super User](https://superuser.com/questions/276069/) #ril

## This site can’t be reached

Chrome 在訪問某些 port 時，會出現 This site can’t be reached (`ERR_UNSAFE_PORT`) 的錯誤。

因為 Chrome 內部有個黑名單，列出哪些 port 是不能存取的。通常自訂 port 會選 1024+，可能踩到的有 2049、3659、6000、6665-6669。

參考資料：

  - [Chrome 非安全端口限制 \| javasgl](https://javasgl.github.io/chrome-unsafe-port-err/) (2017-08-19) #ril
  - [Which ports are considered unsafe on Chrome \- Super User](https://superuser.com/questions/188058/) #ril
  - [\[chrome\] Contents of /trunk/src/net/base/net\_util\.cc](https://src.chromium.org/viewvc/chrome/trunk/src/net/base/net_util.cc?view=markup) 原始碼列出哪些 port 是不安全的，通常會選 1024+，可能踩到的有 2049、3659、6000、6665-6669。

## Per-tab Zoom

推薦 [Zoom Page WE](https://chrome.google.com/webstore/detail/zoom-page-we/bcdjhkphgmiapajkphennjfgoehpodpk)：

  - 進 Options 就能調整 Zoom Mode -- Per-Site / Per-Tab
  - 延用 Ctrl + +/- 的習慣即可。
  - 重整頁面後，縮放比例會自動回到 default level (100%)

後來發現，透過 Zoom Page WE 把 Zoom Mode 改為 Per-Site 後，就算把該 extension 停用，效果還是在；呼應了 [Chrome: any way to zoom a single page, not all pages in domain?](https://superuser.com/questions/677967) 討論中 Jon Freed 的說法，大概是 `zoomSettingsScope` 設定停在 `per-tab` 的關係。

---

參考資料：

  - [How do I increase the font size on only one of the tabs in Google Chrome, while allowing it to remain normal on the other tabs? \- Quora](https://www.quora.com/How-do-I-increase-the-font-size-on-only-one-of-the-tabs-in-Google-Chrome-while-allowing-it-to-remain-normal-on-the-other-tabs)

    There is a Chrome extension called zoomWheel that has a cute work around. A magnifier appears in the upper right of the page, and you point at it, then mouse-wheel, and it will scale the page. If you go to another page from the same site, you can do the same again, WITHOUT CHANGING THE FIRST PAGE’S ZOOM. The extension is here: [zoomWheel](https://chrome.google.com/webstore/detail/zoomwheel/kdfgigbjonaniokmpfflpflkhahhbaej)

  - [Chrome: any way to zoom a single page, not all pages in domain? \- Super User](https://superuser.com/questions/677967)

    Jason Clark: I often use Chrome's Cmd+ and Cmd- (Ctrl+ and Ctrl- on Windows) to zoom in and out on a web page. However, the new zoom level affects every tab showing a page from the SAME DOMAIN. Sometimes this is handy, but other times it's a big problem. Right now, I want to zoom a page containing a video on one tab, while continuing to read text at a normal size in another tab. Is there any method for controlling zoom independently of other tabs? For now I'm stuck using another two browsers.

      - Matias: I have read once that it is one of Chrome's disadvantages. However, there is an extension that may help you, called zoomWheel. You can find it here.

      - Jason Clark: Just discovered that the issue linked by @Qtax in the comments above was marked "WONTFIX" by the Chromium dev team a couple of years ago - they state that this behavior is BY DESIGN, and they do not intent to provide per-page zoom. The extensions mentioned in other answers appear to be the only resolution for this issue.

      - Tim: I was looking for this too and found an extension that's precisly for this. It's called Per Tab Zoom.

        It lets you customize these 4 shortcuts: Ctrl+Mouse wheel, Ctrl+Shift+Mouse wheel, Ctrl++/-, Ctrl+Shift++/- 其中 "Ctrl + +/-" 不就取代了原有的行為?

        For each one, you can choose what kind of zoom to perform, either per-tab zoom or per-domain zoom.

        還要裝 [Native Component](https://www.autocontrol.app/native-component)，不推! 難怪 Zoom Page WE 的使用者人數比較多。

      - Jon Freed: To set Chrome's zoom per tab rather than per site, change "zoomSettingsScope" to "per-tab".

        Unfortunately as of today (2017-10-05), that setting is only accessible through an extension. (It is not changeable via Chrome's settings and flags page, nor through policies.)

        有調整底層設定的工具嗎??

      - studgeek: The extension Zoom Page WE - Chrome Web Store let you switch between per-tab and per-site zooming. Once you just per-tab, then all the existing mechanisms for changing zoom only apply to the current tab. It also allows you to zoom the full page or just zoom text size.

  - [390775 \- zoom in or out affects all tabs within one domain, not just the individual tab \(page\) being zoomed \- chromium](https://bugs.chromium.org/p/chromium/issues/detail?id=390775) (2014-07-02) #ril

## 安裝設置 {: #setup }

### Manjaro Linux ??

  - [How to install Google Chrome in Manjaro Linux \| FOSS Linux](https://www.fosslinux.com/2103/how-to-install-google-chrome-in-manjaro-linux.htm) (2017-10-26) #ril

## 參考資料 {: #reference }

  - [Chrome Web Browser](https://www.google.com/chrome/)
  - [Chrome | Google Blog](https://blog.google/products/chrome/)

更多：

  - [Extension](chrome-ext.md)
