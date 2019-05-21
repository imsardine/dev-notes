# Puppeteer

  - Puppeteer 是唸做 [puppet-'teer]，意思是 "操縱木偶的人"。

參考資料：

  - [Puppeteer  \|  Tools for Web Developers  \|  Google Developers](https://developers.google.com/web/tools/puppeteer/)
      - Puppeteer 是個 Node library 提供 high-level API 控制 Chrome/Chromium -- 中間透過 DevTools protocol，主要是用來操作 headless Chrome/Chromium。
      - 大部份手動在 browser 裡做的事情都能透過 Puppeteer 來做，例如 screenshot、轉 PDF、UI testing、自動填表單、測試 Chrome extension 等。
  - [The power of Headless Chrome and browser automation \(Google I/O '18\) \- YouTube](https://www.youtube.com/watch?v=lhZOFUY1weo) (2018-05-09) #ril

## 新手上路 {: #getting-started }

  - [Quick start  \|  Tools for Web Developers  \|  Google Developers](https://developers.google.com/web/tools/puppeteer/get-started) #ril

        const puppeteer = require('puppeteer');

        (async () => { // 為什麼把 async/await 拿掉就不能跑??
          const browser = await puppeteer.launch();
          const page = await browser.newPage();
          await page.goto('https://example.com');
          await page.screenshot({path: 'example.png'});

          await browser.close();
        })();

  - [Examples  \|  Tools for Web Developers  \|  Google Developers](https://developers.google.com/web/tools/puppeteer/examples) #ril
  - [Getting started with Puppeteer and Chrome Headless for Web Scraping](https://medium.com/@e_mad_ehsan/getting-started-with-puppeteer-and-chrome-headless-for-web-scrapping-6bf5979dee3e) (2017-08-25) #ril

## Architecture ??

  [Overview - puppeteer/api\.md at master · GoogleChrome/puppeteer](https://github.com/GoogleChrome/puppeteer/blob/master/docs/api.md#overview) #ril
  - [puppeteer vs puppeteer-core - puppeteer/api\.md at master · GoogleChrome/puppeteer](https://github.com/GoogleChrome/puppeteer/blob/master/docs/api.md#puppeteer-vs-puppeteer-core) `puppeteer` -> `puppeteer-core` -> Chromium，而 `puppeteer-core` 則直接面對 DevTools protocol，跟 Chromium 沒有直接關係 #ril

## Wait For ??

  - [Generalize page\.waitFor, make waitForSelector a utility on top of it\. · Issue \#91 · GoogleChrome/puppeteer](https://github.com/GoogleChrome/puppeteer/issues/91) #ril
  - [Wait for a specified time before closing the browser · Issue \#651 · GoogleChrome/puppeteer](https://github.com/GoogleChrome/puppeteer/issues/651) #ril

## Console Log ??

  - [puppeteer.launch([options]) - puppeteer/api\.md at master · GoogleChrome/puppeteer](https://github.com/GoogleChrome/puppeteer/blob/master/docs/api.md#puppeteerlaunchoptions) `dumpio <boolean>` - 是否將 browser 的 stdout/stderr 串接到 `process.stdout` 與 `process.stderr`? 例如 `puppeteer.launch({dumpio: true})`，會因此看到 `console.log()` 的內容 "混雜" 在 output messsage 裡。
  - [See console.log from inside the browser - Advanced web spidering with Puppeteer](https://blog.kowalczyk.info/article/ea07db1b9bff415ab180b0525f3898f6/advanced-web-spidering-with-puppeteer.html) (2018-07-18)

      - node script 裡的 `console.log()` 是輸出到 shell，但 `Page.evaluate()` 裡的 `console.log()` 則是執行在 brower context，只會出現在 browser console，在 shell 看不到。
      - 透過 `page.on` 可以安排個 hook，讓 browser 裡的 `console.log()` 也轉印 (re-log) 到 shell。

            page.on("console", msg => {
              console.log("The whole message:", msg.text());
              console.log("\nEach argument:");
              for (let arg of msg.args()) {
                // arg is a Promise returning value of type JSHandle
                // https://pptr.dev/#?product=Puppeteer&show=api-class-jshandle
                arg.jsonValue().then(v => {
                  console.log(v);
                });
              }
            });

  - [page\.console](https://pptr.dev/#?product=Puppeteer&version=v1.8.0&show=api-event-console)
      - Emitted when JavaScript within the page calls one of console API methods, e.g. `console.log` or `console.dir`. Also emitted if the page THROWS AN ERROR OR A WARNING. 會攔載到 `console.xxx()` 及錯誤 (實驗確認) => 如果訊息這麼多樣，或許可以考慮寫到 JSON，供其他平台讀取...
      - The arguments passed into `console.log` appear as ARGUMENTS on the event handler.
      - [ConsoleMessage](https://pptr.dev/#?product=Puppeteer&version=v1.8.0&show=api-class-consolemessage) #ril
      - [JSHandle](https://pptr.dev/#?product=Puppeteer&version=v1.8.0&show=api-class-jshandle) `ConsoleMessage.args()` 的型態是 `Array<JSHandle>`，從 "handle" 看起來，似乎可以間接操作 browser 裡的物件??
  - [How to get all console messages with puppeteer? including errors, CSP violations, failed resources, etc \- Stack Overflow](https://stackoverflow.com/questions/47539043/) 要註冊多個 event listener 才能拿到所有的輸出 #ril

## 安裝設定 {: #installation }

  - [Installation - Quick start  \|  Tools for Web Developers  \|  Google Developers](https://developers.google.com/web/tools/puppeteer/get-started)
      - 用 npm/yarm 安裝 puppeteer 套件，過程中會下自動下載最新版的 Chromium；可以用 `PUPPETEER_SKIP_CHROMIUM_DOWNLOAD` 環境變數跳過這個步驟，但 [Puppeteer 文件](https://github.com/GoogleChrome/puppeteer/blob/v1.8.0/docs/api.md#environment-variables) 又多次強調 "Puppeteer is only guaranteed to work with the bundled Chromium, use at your own risk"。
      - 從 Puppeteer 1.7 開始，發行了另一個輕量版 `puppeteer-core` 套件，預設不會下載 Chromium，使用時會調用已經安裝的 browser，或是連接到遠端。
      - Puppeteer requires at least Node v6.4.0, but the examples below use async/await which is only supported in Node v7.6.0 or greater.

### error while loading shared libraries: libX11-xcb.so.1 (Debian) ??

```
(node:6) UnhandledPromiseRejectionWarning: Error: Failed to launch chrome!
/workspace/node_modules/puppeteer/.local-chromium/linux-588429/chrome-linux/chrome: error while loading shared libraries: libX11-xcb.so.1: cannot open shared object file: No such file or directory
```

  - [Chrome Headless doesn't launch on Debian · Issue \#290 · GoogleChrome/puppeteer](https://github.com/Googlechrome/puppeteer/issues/290) 補足漏掉的套件即可 #ril

      - aslushnikov: 用 `puppeteer.launch({dumpio: true})` 看 stderr 有什麼
      - fortes: 也遇到 `error while loading shared libraries: libX11-xcb.so.1` 的問題，執行 `chrome --help` 就會。
      - Garbee (contributor): I think in the case of Debian systems you still need https://packages.debian.org/sid/libx11-xcb1 to run headless. That way the system has some of the API calls it needs to to do the rendering calculations. 合理
      - Garbee: The action to resolve this (which I'm working on now) is getting a list of all the required dependencies to run Chromium. ... 列出來的 dependencies 也太多。
      - aslushnikov (contributor): `puppeteer.launch({args: ['--no-sandbox']})` 可以。
      - paulirish (member): 是不是考慮在 Linux 上將 `-no-sandbox` 及 `--disable-setuid-sandbox` 視為預設的 flags? 在 chrome-launcher/lighthouse 已經加了 `--disable-setuid-sandbox`，基於這一點也計劃將 `--no-sandbox` 加進去。
      - Garbee: 建議不要將 sandbox 關閉。
      - Garbee: 如果執行身份是 root，確實 Chromium 需要把 sandbox 停用。
      - jeff3dx: Ubuntu 16.04 還要再裝一些套件...

  - 直接拿 `node:8.12.0` 來安裝 `puppeteer@1.8.0` 套件，在下載 Chronium 的階段會發生下面的錯誤；後來確認跟 docker image 無關，因為 `npm install -g moment` 是沒有問題的。

        # npm install -g puppeteer@1.8.0

        > puppeteer@1.8.0 install /usr/local/lib/node_modules/puppeteer
        > node install.js

        ERROR: Failed to download Chromium r588429! Set "PUPPETEER_SKIP_CHROMIUM_DOWNLOAD" env variable to skip download.
        { Error: EACCES: permission denied, mkdir '/usr/local/lib/node_modules/puppeteer/.local-chromium'
          errno: -13,
          code: 'EACCES',
          syscall: 'mkdir',
          path: '/usr/local/lib/node_modules/puppeteer/.local-chromium' }
        npm ERR! code ELIFECYCLE
        npm ERR! errno 1
        npm ERR! puppeteer@1.8.0 install: `node install.js`
        npm ERR! Exit status 1
        npm ERR!
        npm ERR! Failed at the puppeteer@1.8.0 install script.
        npm ERR! This is probably not a problem with npm. There is likely additional logging output above.

  - [Getting Started with Headless Chrome  \|  Web  \|  Google Developers](https://developers.google.com/web/updates/2017/04/headless-chrome#faq) How do I create a Docker container that runs Headless Chrome? 提到 `--no-sandbox` is NOT needed if you properly setup a user in the container. #ril
  - [Lost UI Shared Context · Issue \#1925 · GoogleChrome/puppeteer](https://github.com/GoogleChrome/puppeteer/issues/1925) 後來發現是 `file://index.html` relative path 的表示法造成 #ril
  - [Pages not loading, screenshots empty\. DumpIO Error: Lost UI shared context · Issue \#1828 · GoogleChrome/puppeteer](https://github.com/GoogleChrome/puppeteer/issues/1828) #ril
  - [Install only dependencies of a given package in Debian or Ubuntu \(apt\) \- Server Fault](https://serverfault.com/questions/577942/) 可以只裝 dependencies #ril

## 參考資料 {: #reference }

  - [Puppeteer](https://pptr.dev/)
  - [GoogleChrome/puppeteer - GitHub](https://github.com/GoogleChrome/puppeteer)
  - [Try Puppeteer](https://try-puppeteer.appspot.com/)

社群：

  - ['puppeteer' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/puppeteer)

手冊：

  - [Puppeteer API](https://github.com/GoogleChrome/puppeteer/blob/master/docs/api.md)
