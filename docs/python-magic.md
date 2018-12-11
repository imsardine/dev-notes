# python-magic

  - [ahupp/python\-magic: A python wrapper for libmagic](https://github.com/ahupp/python-magic) #ril
      - A python wrapper for libmagic -- file type identification library
      - libmagic identifies file types by checking their HEADERs according to a predefined list of file types. This functionality is exposed to the command line by the Unix command `file`. 跟 Unix `file` 指令一樣用 `libmagic`。

## 新手上路 ??

  - [Usage - ahupp/python\-magic: A python wrapper for libmagic](https://github.com/ahupp/python-magic#usage)
      - 直接調用 `magic.from_file()`、`magic.from_buffer()` 即可，搭配 `mime=True` 可以傳回 MIME type：

            >>> import magic
            >>> magic.from_file("testdata/test.pdf")
            'PDF document, version 1.2' # 預設的行為跟 file 指令一樣
            >>> magic.from_buffer(open("testdata/test.pdf").read(1024)) # 讀進 header 就能判斷!
            'PDF document, version 1.2'
            >>> magic.from_file("testdata/test.pdf", mime=True) # 跟 file 一樣加 --mime-type 才會輸出 MIME type
            'application/pdf'

       - There is also a `Magic` class that provides more direct control, including overriding the MAGIC DATABASE FILE and turning on character encoding detection. This is not recommended for general use. In particular, it's not safe for sharing across MULTIPLE THREADS and will fail throw if this is attempted. 看似方便，但不建議使用? 不過有些 option 確實只在 `magic.Magic` 提供，`from_file()` 跟 `from_buffer()` 都只有 `mime=False` 可供調整。

            >>> f = magic.Magic(mime=True, uncompress=True) # uncompress 會解壓縮
            >>> f.from_file('testdata/test.gz')
            'text/plain'

  - [python\-magic/magic\.py at 0\.4\.15 · ahupp/python\-magic](https://github.com/ahupp/python-magic/blob/0.4.15/magic.py#L42)
      - `magic.Magic` 的 constructor 除了 `mime=False` 外，還有其他選項可供調整 `def __init__(self, mime=False, magic_file=None, mime_encoding=False, keep_going=False, uncompress=False)`
      - `mime_encoding` 決定要不要額外輸出 encoding，像是 HTTP header `Content-Type` 後面跟的東西：

            >>> m = magic.Magic(mime=True, mime_encoding=True)
            >>> m.from_file('index.html')
            'text/html; charset=utf-8'

## 安裝設定

  - [Installation - ahupp/python\-magic: A python wrapper for libmagic](https://github.com/ahupp/python-magic#installation)
      - 用 Pip 安裝 `python-magic` 套件
      - macOS 要另外用 Homebrew 安裝 `libmagic` 套件；不過 macOS 上也有 `file`，為什麼還要另外裝 `libmagic`?

## 參考資料

  - [ahupp/python-magic - GitHub](https://github.com/ahupp/python-magic)
  - [python-magic - PyPI](https://pypi.org/project/python-magic/)

相關：

  - [MIME Type](mime-type.md)
