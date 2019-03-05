---
title: mitmproxy / Addon
---
# [mitmproxy](mitmproxy.md) / Addon

  - [Addons](https://docs.mitmproxy.org/stable/addons-overview/)
      - Addon 機制由一組 API 構成，addon 以 "回應不同 event" 的方式跟 mitmproxy 互動，可以讓 addon 接進 (hook into) 或改變 mitmproxy 的行為。
      - Addon 可以透過 option 機制組態，也可以揭露 command 給使用者直接調用，也可能透過 interactive tool 裡的 key binding 間接調用。
      - 許多 mitmproxy 自己的功能也是來自 built-in addons，呼應 [Mitmproxy Core Features](https://docs.mitmproxy.org/stable/overview-features/) 裡所條列的功能
  - [Python API - mitmproxy \- an interactive HTTPS proxy](https://mitmproxy.org/#mitmdump) #ril
      - Write powerful addons and script `mitmproxy` with `mitmdump`. 為什麼 scripting 跟 `mitmdump` 有關??
      - The scripting API offers full control over `mitmproxy` and makes it possible to automatically modify messages, redirect traffic, VISUALIZE MESSAGES, or implement CUSTOM COMMANDS. 感覺很適合為特定應用程式打造專用的 debugging 工具。

## 新手上路 ?? {: #getting-started }

  - [Addons](https://docs.mitmproxy.org/stable/addons-overview/)
      - The built-in addons make for INSTRUCTIVE (有啟發性的) READING, and you will quickly see that quite complex functionality can often boil down to a very small, completely self-contained modules. 符合 mitmproxy 一貫的作風，要學 addon 怎麼寫，就看 built-in addons 的原始碼，因為調用的 API 是同一組。
      - 這份文件在講如何用 event、option 及 command 打造自己的 addon，若要看 API reference 還是要從 source code (canonical reference)，可以用 `pydoc` 查看，例如 `pydoc mitmproxy.http`；話說回來，從 GitHub 看 source 也可以，只是 `pydoc` 會把 inheritance 也考量進來。
      - 一個 addon 大概長這樣子，用來計算 flow (也就是 HTTP request) 的數量：

            from mitmproxy import ctx

            class Counter:
                def __init__(self):
                    self.num = 0

                def request(self, flow):
                    self.num = self.num + 1
                    ctx.log.info("We've seen %d flows" % self.num)

            addons = [
                Counter()
            ]

          - 用內部的 logging 機制 (`ctx.log`) 記錄下來 -- 訊息可以在 mitmdump 的 console，或是 interactive tool 的 event log 看到；例如 mitmproxy 由有提供 View event log 的功能。
          - 這裡的 `request(self, flow)` 就是一種 event -- method name + arguments，只要實作想要回應的 event 即可；其中 `flow` 型態是 `mitmproxy.http.HTTPFlow` (用 `pydoc mitmproxy.http.HTTPFlow` 查看)，這項資訊可以在 [Supported Events](https://docs.mitmproxy.org/stable/addons-events/#supported-events) 找到。
          - `mitmproxy.ctx` 是個 HOLDALL module，揭露了寫 addon 時常用的 API；設計上當然可以將 ctx 做為 event method 的參數傳進去，但開發團隊覺得以 global 的方式提供比較優 (neat)，所以用 `ctx.log.xxx()` 就可以做 logging。

      - 用 `-s` 把 addon 掛進 mitmproxy tool，例如 `mitmdump -s ./anatomy.py`，列在 `addons` 裡的 addon (instance) 就會被載入；用 `http_proxy=http://localhost:8080 curl -I http://www.google.com` 就可以在 console 看到 `We've seen NN flows` 之類的訊息。
      - 按照 [mitmproxy\(1\) — mitmproxy — Debian stretch — Debian Manpages](https://manpages.debian.org/stretch/mitmproxy/mitmproxy.1.en.html) 的說法，`-s, --script` 後面接的是 script，而且這個 option 可以使用多次。

  - [Events](https://docs.mitmproxy.org/stable/addons-events/)
      - Event 在 addon 裡以 well-known methods 體現，多數 event 都會接受 `mitmproxy.flow.Flow` 的參數；變更這個 flow，就可以動態改變傳輸的內容 (change traffic on the fly)。以 [`AddHeader`](https://github.com/mitmproxy/mitmproxy/blob/master/examples/addons/addheader.py) 為例：

            class AddHeader:
                def __init__(self):
                    self.num = 0

                def response(self, flow):
                    self.num = self.num + 1
                    flow.response.headers["count"] = str(self.num) # 在 response 加上 count header


            addons = [
                AddHeader()
            ]

      - Supported Events 帶出 [`Events`](https://github.com/mitmproxy/mitmproxy/blob/master/examples/addons/events.py) -- 為所有 event 提供了 stub，提供所有 event 名稱是一回事，重點是每個 method 的說明。

  - [Scripting](https://docs.mitmproxy.org/stable/addons-scripting/)
      - A shorthand that allows A MODULE AS A WHOLE to be treated as an addon object. 還是在寫 addon，只是不用另外寫 class；一樣是寫 event handler，但 `addons = [ ... ]` 也就免了，這似乎比較直覺? 例如：

            def request(flow):
                flow.request.headers["myheader"] = "value"

  - [mitmproxy/setup\.py at v1\.0 · mitmproxy/mitmproxy](https://github.com/mitmproxy/mitmproxy/blob/v1.0/setup.py) 原來 mitmproxy 1.0 開始 (2016-12-18) 就只支援 Python 3 -- `classifiers=[..., "Programming Language :: Python :: 3 :: Only", ...]`

## Content View, View Mode ??

  - 自訂的 content view，在 mitmweb 下也可以使用!!
  - 切換 view mode 後，不論該 flow 的轉譯成功或失敗，結果都會被記往，也就是切去其他 view mode 再切回來時，並不會再轉譯一次。 (4.0.4)
  - 實驗發現，如果在 `View.__call__()` 裡有任何語法上的錯誤，在 event log 裡不會看到任何錯誤，只會被提示 `Couldn't parse: falling back to Raw` 而已。 (4.0.4)

參考資料：

  - 當 request/response 無法檢視時，mitmproxy 會有類似 `[decoded gzip] Couldn't parse: falling back to Raw` 的訊息，右側還有個 `[m:auto]`？
      - 在 Flow Details 下按 m (Set flow view mode)，會看到 Mode 選項 1) auto 2) raw 3) ... d) protocol buffer，這正是 [`mitmproxy.contentviews`](https://github.com/mitmproxy/mitmproxy/blob/v4.0.4/mitmproxy/contentviews/__init__.py#L117) 內建的 13 個 view。
      - [mitmproxy/auto\.py at v4\.0\.4 · mitmproxy/mitmproxy](https://github.com/mitmproxy/mitmproxy/blob/v4.0.4/mitmproxy/contentviews/auto.py) auto mode 只會根據 content type 採用 `contentviews.content_types_map` 註冊該 content type 的第一個 view；若解譯資料的過程中遇到問題，並不會再嘗試其他 view。
  - [mitmproxy/\_\_init\_\_\.py at v4\.0\.4 · mitmproxy/mitmproxy](https://github.com/mitmproxy/mitmproxy/blob/v4.0.4/mitmproxy/contentviews/__init__.py#L117) `get_content_view(viewmode: View, data: bytes, **metadata)` 正是 `Couldn't parse: falling back to Raw` 這段訊息丟出來的地方，裡面有行註解 `Third-party viewers can fail in unexpected ways...`，看起來是可以自訂 viewer 的。
  - [Third\-party viewers · Issue \#130 · mitmproxy/mitmproxy](https://github.com/mitmproxy/mitmproxy/issues/130)
      - kballenegger: 試著寫 third-party viewer，希望可以直接看出 base-64 encoded 的 JSON body。也是看到 `# Third-party viewers can fail in unexpected ways...` 這行註解暗示可以自訂 viewer，想知道自訂 viewer 是否適用這情況 (沒有想要改變 request/response，只是方便檢視)、如何寫 custom viewer、解開 base-64 後能否呼叫原來的 JSON viewer?
      - mhils: (member) [mitmproxy/addingviews\.html at bfb3828f37842c8b99c539910f18fa87fb29a637 · jasonanovak/mitmproxy](https://github.com/jasonanovak/mitmproxy/blob/bfb3828f37842c8b99c539910f18fa87fb29a637/doc-src/scripting/addingviews.html) (2013-05-24) #ril
      - kballenegger: 可以不用修改 mitmproxy 嗎?
      - cortesi: (member) 現在還不支援 pluggable view，所以必須要動 mitmproxy 的原始碼；是應該要有 pluggable view 的機制。
      - mhils: (member) 因為 [!833](https://github.com/mitmproxy/mitmproxy/pull/833) 的關係，可以在 inline script 裡加上 content view 了 (2015-11-15)；主角是 `examples/custom_contentviews.py`：

            import libmproxy.contentviews as cv

            class ViewPigLatin(cv.View):
                name = "pig_latin_HTML"
                prompt = ("pig latin HTML", "l")
                content_types = ["text/html"]

                def __call__(self, data, **metadata):
                    # ...
                    return "HTML", cv.format_text(s)

            pig_view = ViewPigLatin()

            def start(context, argv):
                context.add_contentview(pig_view)

            def stop(context):
                context.remove_contentview(pig_view)

  - [mitmproxy/custom\_contentview\.py at v4\.0\.4 · mitmproxy/mitmproxy](https://github.com/mitmproxy/mitmproxy/blob/v4.0.4/examples/simple/custom_contentview.py) `custom_contentview.py` 還在，只不過寫法變了：(這裡 scripting 的寫法並非必要)

        from mitmproxy import contentviews

        class ViewSwapCase(contentviews.View):
            name = "swapcase"
            content_types = ["text/plain"]

            def __call__(self, data, **metadata) -> contentviews.TViewResult:
                return "case-swapped text", contentviews.format_text(data.swapcase())

        view = ViewSwapCase()

        def load(l):
            contentviews.add(view)

        def done():
            contentviews.remove(view)

  - [Class `mitmproxy.contentviews.View`](https://github.com/mitmproxy/mitmproxy/blob/v4.0.4/mitmproxy/contentviews/base.py#L13)
      - Transform RAW DATA into HUMAN-READABLE output.
      - 唯一要實作的方法是 `__call__(self, data: bytes, **metadata) -> TViewResult`，其中 `TViewResult` 就是 `typing.Tuple[str, typing.Iterator[TViewLine]]`
      - `data`: the data to decode/format. 實驗發現 `data` 就如同畫面上 `[decoded gzip]` 提示的，已經是 gzip 解碼後的結果；也因此 [`mitmproxy.contentviews.raw`](https://github.com/mitmproxy/mitmproxy/blob/v4.0.4/mitmproxy/contentviews/raw.py) 也沒有在處理 gzip decoding。
      - Returns: A `(description, content generator)` tuple. The content generator yields lists of (style, text) tuples, where each list represents a SINGLE LINE. 可能要檢視的資料很大所以設計成 generator，這也解釋了為何上面 `custom_contentview.py` 要回傳 `contentviews.format_text(...)`，因為 `format_text()` 可以將 `TTextType` (`typing.Union[str, bytes]`) 轉成 `typing.Iterator[TViewLine]`。

  - [Options](https://docs.mitmproxy.org/stable/concepts-options/) 提供有 2 個 option 跟 content view 有關 -- `console_default_contentview`、`dumper_default_contentview`，預設值都是 `auto`；但改用 custom content view 好像會有問題??

## 參考資料 {: #reference }

  - [mitmproxy/examples - GitHub](https://github.com/mitmproxy/mitmproxy/tree/master/examples)

手冊：

  - [Built-in Addons](https://github.com/mitmproxy/mitmproxy/tree/master/mitmproxy/addons)
  - [Supported Events](https://docs.mitmproxy.org/stable/addons-events/#supported-events) (同 [`/examples/addons/events.py`](https://github.com/mitmproxy/mitmproxy/blob/master/examples/addons/events.py) 的內容)
  - [Module `mitmproxy.ctx`](https://github.com/mitmproxy/mitmproxy/blob/master/mitmproxy/ctx.py)
  - [Module `mitmproxy.http`](https://github.com/mitmproxy/mitmproxy/blob/master/mitmproxy/http.py)
  - [Class `mitmproxy.flow.Flow`](https://github.com/mitmproxy/mitmproxy/blob/master/mitmproxy/flow.py)
  - [Class `mitmproxy.contentviews.View`](https://github.com/mitmproxy/mitmproxy/blob/v4.0.4/mitmproxy/contentviews/base.py#L13)
