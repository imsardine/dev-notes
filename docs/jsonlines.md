# JSON Lines

  - [JSON Lines](http://jsonlines.org/)
      - 是一種 text format，也稱做 newline-delimited JSON。
      - 方便表示結構化的資料，也方便一次處理一行 (record)，跟現有 unix-style text processing 工具尤其搭；很適合 log file，也適合在 process 間傳遞 message?
  - [Line-delimited JSON - JSON streaming \- Wikipedia](https://en.wikipedia.org/wiki/JSON_streaming#Line-delimited_JSON)
      - JSON streaming 是一種 communication protocol，用來在 client/server 間約定如何劃定 (delimit) JSON object 的界限。
      - 系統間交換資料常用 JSON 格式，若要在單一個連線傳遞 a stream of objects，就需要有識別 JSON encoded object 從哪裡開始 & 到哪裡結束的方法，技術上這叫做 framing；而 line-delimited JSON 就是其中一種做法。
      - Line-delimited JSON (LDJSON), newline-delimited JSON (NDJSON), and JSON lines (JSONL) are three terms for EQUIVALENT formats of JSON streaming. 原來有這麼多種說法。
      - Streaming makes use of the fact that the JSON format DOES NOT ALLOW NEWLINE AND RETURN CHARACTERS WITHIN PRIMITIVE VALUES (in strings those must be escaped as `\n` and `\r`, respectively) and that most JSON formatters default to not including any whitespace, including newlines and returns. These features allow the newline and/or return characters to be used as a delimiter. 由於 primitive value 裡不能有 newline 跟 return，正好可以拿來當 delimiter。
  - [JSON Lines Examples](http://jsonlines.org/examples/)
      - CSV seems so easy that many programmers have written code to generate it themselves, and almost EVERY IMPLEMENTATION IS DIFFERENT. ... 看來 CSV 的問題真的很多，可以應用 CSV 的場合，都可以考慮用 JSON lines 來替代 -- JSON Lines handles tabular data cleanly and without ambiguity. Cells may use the standard JSON types.
      - If you have large nested structures then reading the JSON Lines text directly isn't recommended. Use the "jq" tool to make viewing large structures easier: `grep pair winning_hands.jsonl | jq .` 原來 JSON lines 跟 `jq` 這麼搭!!
  - [ndjson](http://ndjson.org/) 說明幾乎跟 JSON Lines 一樣，最下方寫著 Site forked from jsonlines.org。 #ril
  - [JSON Lines Examples](http://jsonlines.org/on_the_web/) 不少應用採 JSON lines #ril

## Format ??

  - [JSON Lines](http://jsonlines.org/) JSON Lines 格式有 3 個要求：
      - 採 UTF-8 encoding，也接受 ASCII escape sequence，雖然這不容易直接閱讀；這點在搭配 Unix 工具時尤其方便，例如 `grep 閃退 usage.jsonl`，若做了 ASCII eacaping，不但無法直接 grep 中文，輸出的結果也難以閱讀。
      - Encodings other than UTF-8 are very unlikely to be valid when decoded as UTF-8 ... 也就是說，解析 JSON lines 時就假設 UTF-8 即可，若編碼不對很容就會錯誤，不太需要擔心 [Mojibake](https://en.wikipedia.org/wiki/Mojibake) 的狀況。
      - 每一行都必須是合法的 JSON value，常見的是 object 或 array。
      - 換行字元 (line separator) 採 `\n` (Unix-like)；這表示 `\r\n` (Windows) 也是可以接受的，因為 trailing white space (去除 `\n` 剩下的 `\r`) 會被忽略；檔案最後一行的換行字元可有可無。
      - 習慣以 `.jsonl` 為副檔名，推薦用像 `gzip`、`bzip2` 這類的 stream compressor 來壓縮 (`.jsonl.gz` 或 `.jsonl.bz2`)
  - [JSON Lines Examples](http://jsonlines.org/examples/) #ril

## Python

讀寫 JSON lines 其實不需要額外的套件，寫出時不要輸出多餘的空白，讀入時以行為單位解析即可。

```
# -*- coding: utf-8 -*-
import json
from textwrap import dedent

def test_jsonline_write(workspace):
    workspace.src('data.jsonl', """
    {"entry1": ["value1", "value2"]}
    """)

    new_entry = {"entry2": u"第一行\n第二行"}

    with open('data.jsonl', 'ab') as f:
        line = json.dumps(new_entry, separators=(',', ':'), ensure_ascii=False)
        f.write(b'\n' + line.encode('utf-8')) # leading newline char

    assert open('data.jsonl', 'rb').read().decode('utf-8') == dedent(u"""\
    {"entry1": ["value1", "value2"]}
    {"entry2":"第一行\\n第二行"}""")

def test_jsonline_read(workspace):
    workspace.src('data.jsonl', u"""
    {"entry1": ["value1", "value2"]}
    {"entry2":"第一行\\n第二行"}
    """)

    entries = []
    with open('data.jsonl', 'rb') as f:
        for line in f:
            entry = json.loads(line) # UTF-8 encoding, by default
            entries.append(entry)
    assert entries == [
        {"entry1": ["value1", "value2"]},
        {"entry2": u"第一行\n第二行"},
    ]
```

由於 `json` module 本來就不會輸出 newline 或 return 字元，所以關鍵在拿掉不必要的空白字元、不要對 Unicode 字元做 ASCII escaping。這分別對應 `json.dumps()` 的 `separators=(',', ':')` (預設是 `(', ', ': ')`) 與 `ensure_ascii=False` (預設會做 ASCII escaping)。

參考資料：

  - [json — JSON encoder and decoder — Python 3\.7\.1 documentation](https://docs.python.org/3/library/json.html)
      - Compact encoding:

            >>> import json
            >>> json.dumps([1, 2, 3, {'4': 5, '6': 7}], separators=(',', ':'))
            '[1,2,3,{"4":5,"6":7}]'

      - If `ensure_ascii` is `true` (the default), the output is guaranteed to have all incoming non-ASCII characters escaped. If `ensure_ascii` is false, these characters will be output as-is. 因為 [JSON Lines](http://jsonlines.org/) 建議不要做 escape，調為 `False` 會比較好。
      - If `indent` is a non-negative integer or string, then JSON array elements and object members will be pretty-printed with that indent level. An indent level of 0, negative, or `""` will only insert newlines. `None` (the default) selects the most compact representation. 原來預設就不會換行，符合 JSON lines 的要求。
      - If specified, `separators` should be an `(item_separator, key_separator)` tuple. The default is `(', ', ': ')` if `indent` is `None` and `(',', ': ')` otherwise. To get the most compact JSON representation, you should specify `(',', ':')` to eliminate whitespace. 原來 `separators` 的預設值會跟著 `indent` 連動，若 `indent=None` 維持預設值不變，可以透過 `separators=(',',':')` 把多餘的空白再去掉。
  - [wbolster/jsonlines: python library to simplify working with jsonlines and ndjson data](https://github.com/wbolster/jsonlines) 處理 JSON Lines 與 NDJSON 的資料 #ril

## 參考資料 {: #reference }

  - [JSON Lines](http://jsonlines.org/)

社群：

  - ['jsonlines' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/jsonlines)
