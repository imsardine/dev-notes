# Trac

## Wiki ??

  - [TracWiki – The Trac Project](https://trac.edgewall.org/wiki/TracWiki) #ril
  - [WikiFormatting – The Trac Project](https://trac.edgewall.org/wiki/WikiFormatting) #ril
  - 直接輸入 `http://...` 或 `[<LINK> <LABEL>]` (注意 link 與 label 的順序)

參考資料：

  - [TracLinks – The Trac Project](https://trac.edgewall.org/wiki/TracLinks) #ril
      - 在提示支援 Wiki formatting 的地方，Trac link 可以建立不同 entity 間的連結，例如 ticket、report、changeset、wiki page、milestone 等
      - Trac link 通常以 `type:id` 的形式出現，其中 `id` 是可以識別某個項目的編號、名稱、路徑。也常同時出現 `[link label]` 與 `[[link|label]]` 的用法，差別在於後者用 `|` 明確隔開 link 與 label。

## 取出 Wiki Text 的文字內容 (不含 Markup) {: #wiki-text-extraction }

  - 方向上是先轉 HTML 再取出文字，後段的工具很多，但 Trac 有自己的語法，要轉 HTML 並沒有其他獨立的套件可用。
  - 要從 Trac source code 抽取出 `trac.wiki.formatter.format_to_html()` 似乎不太可行，因為牽扯太廣，而且也不相容 Python 3。

  - 可以考慮 [RPC API](https://trac-hacks.org/rpc#rpc.wiki) 的 `string wiki.wikiToHtml(string text)`

    雖然 wiki 有 `wiki.getPageHTML(string pagename, int version=None)` 可以用，但 ticket 就沒有類似的接口，再加上 wiki text 可能內含 `[[TicketQuery]]` 這類處理起來相當耗時、對本文也沒有幫助的 macro，比較通用的方式是先取得 wiki、ticket、comment 的 wiki text，去掉 macros 之後，再交給 `wiki.wikiToHtml(string text)` 轉換成 HTML。

---

參考資料：

  - [trac\-1\.2\.3 in tags – The Trac Project](https://trac.edgewall.org/browser/tags/trac-1.2.3)

    從 `trac.wiki.formatter.format_to_html()` 開始：

      - [trac/wiki/formatter.py#L1618](https://trac.edgewall.org/browser/tags/trac-1.2.3/trac/wiki/formatter.py#L1618)

            def format_to_html(env, context, wikidom, escape_newlines=None):
               if not wikidom:
                   return Markup()
               if escape_newlines is None:
                  escape_newlines = context.get_hint('preserve_newlines', False)
               return HtmlFormatter(env, context, wikidom).generate(escape_newlines)

        如何拿到 `env`、`context` 及 `wikidom`?

      - [trac/wiki/formatter.py#L1566](https://trac.edgewall.org/browser/tags/trac-1.2.3/trac/wiki/formatter.py#L1566)

            if isinstance(wikidom, basestring):
                wikidom = WikiParser(env).parse(wikidom)

        Wiki DOM 可以用 `trac.wiki.parser.WikiParser.parse(wiki)` 產生，但還是得用到 `env`。

      - [trac/wiki/parser.py#L27](https://trac.edgewall.org/browser/tags/trac-1.2.3/trac/wiki/parser.py#L27)

        `WikiParser` 繼承自 `trac.core.Component`，而 `trac/core.py` 沒再 import 其他 module。

    到這裡想放棄了 ...

  - 不考慮 [RPC API](https://trac-hacks.org/rpc#rpc.wiki) `string wiki.wikiToHtml(string text)` 的原因? 或許先用 `string wiki.getPage(string pagename, int version=None)` 取得 wiki text，去掉耗時的 markup 之後 (例如 [macros](https://trac.edgewall.org/wiki/WikiFormatting#Macros))，再交給 `string wiki.wikiToHtml(string text)` 轉換?

    許多 macro 都是在 wiki page 上 "附加" 內容，可以考慮只保留 `[[Image]]`，其餘全部去掉；其實 `[[Image]]` 也跟文字內容無關，完全略過 macro 也沒問題。

## 參考資料 {: #reference }

  - [The Trac Project](https://trac.edgewall.org/)
  - [edgewall/trac - GitHub](https://github.com/edgewall/trac)
  - [Trac Hacks - Plugins Macros etc.](https://trac-hacks.org/)

社群：

  - ['trac' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/trac)

文件：

  - [The Trac User and Administration Guide](https://trac.edgewall.org/wiki/TracGuide)

更多：

  - [Remote API](trac-api.md)

手冊：

  - [Trac Source](https://trac.edgewall.org/browser)
