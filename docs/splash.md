# Splash

  - [scrapinghub/splash: Lightweight, scriptable browser as a service with an HTTP API](https://github.com/scrapinghub/splash)
      - Lightweight, scriptable browser as a service with an HTTP API 雖然是用 Python 3 + Twisted + QT5 實現的 JavaScript rendering service，但對外提供的是 HTTP API。
      - 要搭配 Scrapy 應用，有 `scrapy-splash` 可以用。
  - [Splash \- A javascript rendering service — Splash 3\.2 documentation](https://splash.readthedocs.io/en/stable/)
      - 背後的 browser engine 是 WebKit。
      - 可以平行處理多個 webpage、取得最後畫出來的 HTML 或 screenshot，也可以將 rendering 的過程記錄成 HAR 格式。
      - 可以關閉 image 或使用 Adblock Plus rule 加速 rendering。
      - 可以執行自訂的 JavaScript，也可以執行用 Lua 寫的 browsing script?? (用 Splash-Jupyter Notebook 寫)

## 跟 Lua 的關係 ??

  - [Splash \- A javascript rendering service — Splash 3\.2 documentation](https://splash.readthedocs.io/en/stable/) 提到 browsing script 用 Lua 寫。
  - [Folder Sharing - Installation — Splash 3\.2 documentation](http://splash.readthedocs.io/en/stable/install.html#folders-sharing) 提到 Lua modules。
  - [Why does Splash use Lua for scripting, not Python or JavaScript? - FAQ — Splash 3\.2 documentation](http://splash.readthedocs.io/en/stable/faq.html#why-does-splash-use-lua-for-scripting-not-python-or-javascript) 答案指向 Issue #117
  - [Lua scripting support · Issue \#117 · scrapinghub/splash](https://github.com/scrapinghub/splash/issues/117) #ril
  - [Why ScrapyJS has Lua as scripting language and not Python? · Issue \#40 · scrapy\-plugins/scrapy\-splash](https://github.com/scrapy-plugins/scrapy-splash/issues/40) #ril
  - [JavaScript <\-> Python <\-> Lua intergation — Splash 3\.2 documentation](http://splash.readthedocs.io/en/stable/internals/js-python-lua.html) #ril

## Hello, World! ??

```
curl -o index.html http://localhost:8050/render.html?url=https://tiddlywiki.com/
```

## Splash HTTP API ??

## Session ??

  - [scrapinghub/splash: Lightweight, scriptable browser as a service with an HTTP API](https://github.com/scrapinghub/splash) 除了 fast, lightweight，也提到了 stateless。
  - [scrapy\-plugins/scrapy\-splash: Scrapy\+Splash for JavaScript integration](https://github.com/scrapy-plugins/scrapy-splash#session-handling) #ril
      - Splash 是 stateless，每一個 request 都是全新的，所以要自己處理 cookies。

## 安裝設置 {: #setup }

### Docker

```
docker run -p 8050:8050 scrapinghub/splash
```

Splash API 就會在服務。例如：

```
$ docker run --rm -p 8050:8050 scrapinghub/splash
2018-05-18 14:30:32+0000 [-] Log opened.
2018-05-18 14:30:32.706004 [-] Splash version: 3.2
2018-05-18 14:30:32.706855 [-] Qt 5.9.1, PyQt 5.9, WebKit 602.1, sip 4.19.3, Twisted 16.1.1, Lua 5.2
2018-05-18 14:30:32.707126 [-] Python 3.5.2 (default, Nov 23 2017, 16:37:01) [GCC 5.4.0 20160609]
2018-05-18 14:30:32.707676 [-] Open files limit: 1048576
2018-05-18 14:30:32.707922 [-] Can't bump open files limit
2018-05-18 14:30:32.824683 [-] Xvfb is started: ['Xvfb', ':1492286436', '-screen', '0', '1024x768x24', '-nolisten', 'tcp']
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
2018-05-18 14:30:32.897870 [-] proxy profiles support is enabled, proxy profiles path: /etc/splash/proxy-profiles
2018-05-18 14:30:32.998413 [-] verbosity=1
2018-05-18 14:30:32.998671 [-] slots=50
2018-05-18 14:30:32.999273 [-] argument_cache_max_entries=500
2018-05-18 14:30:33.000303 [-] Web UI: enabled, Lua: enabled (sandbox: enabled)
2018-05-18 14:30:33.000569 [-] Server listening on 0.0.0.0:8050
2018-05-18 14:30:33.002187 [-] Site starting on 8050
2018-05-18 14:30:33.002569 [-] Starting factory <twisted.web.server.Site object at 0x7f3a377c97f0>
```

參考資料：

  - [Linux + Docker - Installation — Splash 3\.2 documentation](http://splash.readthedocs.io/en/stable/install.html#linux-docker)
      - `docker run -p 8050:8050 -p 5023:5023 scrapinghub/splash`，其中 8050 是 HTTP，5023 是 Telnet。
      - 實驗發現 5023 port 沒有作用，走 Telnet 是做什麼用的??
  - [Customizing Dockerized Splash - Installation — Splash 3\.2 documentation](http://splash.readthedocs.io/en/stable/install.html#customizing-dockerized-splash) #ril

## 參考資料 {: #reference }

  - [scrapinghub/splash - GitHub](https://github.com/scrapinghub/splash)

手冊：

  - [Splash Documentation](https://splash.readthedocs.io/)
