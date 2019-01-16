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

## 參考資料 {: #reference }

  - [Chrome Web Browser](https://www.google.com/chrome/)
  - [Chrome | Google Blog](https://blog.google/products/chrome/)

更多：

  - [Extension](chrome-extension.md)
