# PhantomJS

  - [PhantomJS \- Scriptable Headless Browser](http://phantomjs.org/) #ril

      - PhantomJS development is SUSPENDED UNTIL FURTHER NOTICE ([more details](https://github.com/ariya/phantomjs/issues/15344)). #ril

        有機會繼續發展的意思。

      - PhantomJS is a HEADLESS web browser SCRIPTABLE WITH JAVAsCRIPT. It runs on Windows, macOS, Linux, and FreeBSD.

        Using QtWebKit as the back-end, it offers fast and native support for various web standards: DOM handling, CSS selector, JSON, Canvas, and SVG.

      - The following simple script for PhantomJS loads Google homepage, waits a bit, and then captures it to an image.

            var page = require('webpage').create();
            page.open('http://www.google.com', function() {
                setTimeout(function() {
                    page.render('google.png');
                    phantom.exit();
                }, 200);
            });

      - PhantomJS is an optimal solution for:

          - Page automation -- Access webpages and EXTRACT INFORMATION using the standard DOM API, or with usual libraries like jQuery.
          - Screen capture -- Programmatically capture web contents, including SVG and Canvas. Create web site screenshots with thumbnail preview.
          - Headless website testing -- Run FUNCTIONAL TESTS with frameworks such as Jasmine, QUnit, Mocha, WebDriver, etc.
          - Network monitoring -- Monitor page loading and export as standard [HAR files](https://en.wikipedia.org/wiki/.har). Automate PERFORMANCE ANALYSIS using [YSlow](http://yslow.org/) and Jenkins. 跟 Jenkins 什麼關係 ??

## 新手上路 {: #getting-started }

  - [Quick Start with PhantomJS](http://phantomjs.org/quick-start.html) #ril

## 疑難排解 {: #troubleshooting }

### HTTPS 網頁的內容是空的 {: #https }

在 Docker 裡用 PhantomJS 存取 HTTPS 時會拿不到網頁內容 (HTTP 可以)，但同時間 `curl https://...` 又沒問題。當時的 `Dockerfile`：

```
FROM python:3.7.3 AS base
RUN curl -Lo /tmp/phantomjs.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2 \
    && tar xf /tmp/phantomjs.tar.bz2 -C /tmp \
    && mkdir /usr/local/lib/phantomjs \
    && mv /tmp/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/lib/phantomjs/phantomjs \
    && ln -s /usr/local/lib/phantomjs/phantomjs /usr/local/bin \
    && rm -rf /tmp/*
```

錯誤訊息：

```
$ phantomjs --debug=true script-accessing-https.js
2019-05-13T10:18:40 [WARNING] QSslSocket: cannot call unresolved function SSLv23_client_method
2019-05-13T10:18:40 [WARNING] QSslSocket: cannot call unresolved function sk_num
2019-05-13T10:18:40 [DEBUG] Phantom - execute: Configuration
...
2019-05-13T10:18:40 [DEBUG]      4 ignoreSslErrors : "false"
...
2019-05-13T10:18:40 [DEBUG]      17 sslProtocol : "tlsv1"
2019-05-13T10:18:40 [DEBUG]      18 sslCertificatesPath : ""
...
2019-05-13T10:18:40 [DEBUG] Network - Resource request error: 99 ( "Invalid or empty cipher list (error:1410D0B9:SSL routines:SSL_CTX_set_cipher_list:no cipher match)" ) URL: "https://www.google.com/"
```

根據[這裡](https://github.com/wkhtmltopdf/wkhtmltopdf/issues/2938)的說法，加裝 `libssl1.0-dev` 套件就可以。

---

參考資料：

  - [QSslSocket: cannot call unresolved function SSLv23\_client\_method · Issue \#2938 · wkhtmltopdf/wkhtmltopdf](https://github.com/wkhtmltopdf/wkhtmltopdf/issues/2938)

      - mlutfy: For those like me stumbling on this issue, for Debian users, see this comment with a simple fix: #3001 (comment)

        tl;dr: `apt-get install libssl1.0-dev`

        Rather odd, but it works!

        確實裝了 `libssl1.0-dev` 問題就沒了。

  - [javascript \- Phantomjs fail to load the address \- Stack Overflow](https://stackoverflow.com/questions/29755476/) #ril
  - [PhantomJS unable to load the address · Issue \#10178 · ariya/phantomjs](https://github.com/ariya/phantomjs/issues/10178) #ril
  - [PhantomJS fail to open HTTPS site \| MichaelYin Blog](https://blog.michaelyin.info/phantomjs-fail-to-open-https/) (2018-08-31) #ril

## 安裝設定 {: #installation }

  - [Download PhantomJS](http://phantomjs.org/download.html) #ril

### Linux ??

  - [Linux - Download PhantomJS](http://phantomjs.org/download.html#linux-64-bit) #ril

      - 64-bit -- Download [phantomjs-2.1.1-linux-x86_64.tar.bz2](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2) (22.3 MB) and extract the content.
      - 32-bit -- Download [phantomjs-2.1.1-linux-i686.tar.bz2](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-i686.tar.bz2) (23.0 MB) and extract the content.

      - Note: For this STATIC BUILD, the binary is SELF-CONTAINED. There is no requirement to install Qt, WebKit, or any other libraries. It however still relies on Fontconfig (the package `fontconfig` or `libfontconfig`, depending on the distribution). The system must have `GLIBCXX_3.4.9` and `GLIBC_2.7`.

        如何確認 GLIBC 的版本??

### Docker

```
RUN apt-get update && apt-get install -y --no-install-recommends \
        libssl1.0-dev \
    && curl -Lo /tmp/phantomjs.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2 \
    && tar xf /tmp/phantomjs.tar.bz2 -C /tmp \
    && mkdir /usr/local/lib/phantomjs \
    && mv /tmp/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/lib/phantomjs/phantomjs \
    && ln -s /usr/local/lib/phantomjs/phantomjs /usr/local/bin \
    && rm -rf /tmp/*
```

## 參考資料 {: #reference }

  - [PhantomJS](http://phantomjs.org/)

相關：

  - 屬於 [headless browser](browser-headless.md)

手冊：

  - [Web Page Module](http://phantomjs.org/api/webpage/)
