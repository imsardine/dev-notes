# MIME Type

  - [Media type \- Wikipedia](https://en.wikipedia.org/wiki/Media_type) #ril
  - [MIME types \- HTTP \| MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types) #ril

## Python

雖然 Python 內建 `mimetypes`，但它只是根據副檔名判斷，建議用 [`python-magic`](python-magic.md) 套件，從檔頭判斷 (背後用 `libmagic`)。

```
>>> import magic
>>> magic.from_file('index.html', mime=True)
'text/html'
```

參考資料：

  - [How to find the mime type of a file in python? \- Stack Overflow](https://stackoverflow.com/questions/43580/)
      - Simon Zimmermann: 用 `python-magic`，雖然 toivotuo 也是建議用 `python-magic`? 從檔案內容判斷

            >>> import magic
            >>> mime = magic.Magic(mime=True)
            >>> mime.from_file("testdata/test.pdf")
            'application/pdf'

      - Dave Webb: Python 內建的 `mimetypes` module 則會根據副檔名猜 MIME type；不過 Cerin 認為透過副檔名判斷不太妥當。
      - akdom: Apache 的 [`mod_mime_magic`](http://httpd.apache.org/docs/1.3/mod/mod_mime_magic.html) 也會根據檔案內容判斷 content type。
      - mammadori: 有 3 個 library 是包裝 libmagic，有 2 個在 Pip 上可以找到 -- `filemagic` 跟 `python-magic`。

  - [File Mime types in Django – Andy Byers – Medium](https://medium.com/@ajrbyers/file-mime-types-in-django-ee9531f3035b) (2017-11-23) Python 內建的 `mimetypes` 單從 filename 判斷，可能會失準，建議用 `python-magic`，有 `file_path_mime(file_path)`、`check_in_memory_mime(in_memory_file)` 可用；但什麼是 in-memory file??
  - [mimetypes — Map filenames to MIME types — Python 3\.7\.1 documentation](https://docs.python.org/3/library/mimetypes.html) #ril
  - [filetype · PyPI](https://pypi.org/project/filetype/) #ril

## 參考資料

手冊：

  - [Incomplete list of MIME types - HTTP | MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Complete_list_of_MIME_types)
