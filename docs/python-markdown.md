# Python-Markdown

## 新手上路 ?? {: #getting-started }

  - [The Basics - Library Reference — Python\-Markdown 3\.0\.1 documentation](https://python-markdown.github.io/reference/#the-basics) #ril

        import markdown
        html = markdown.markdown(your_text_string) # 一個動作就把 Markdown 轉 HTML 了

## 應用實例 {: #powered-by }

  - [mkdocs/setup\.py at 1\.0\.4 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/blob/1.0.4/setup.py#L62)

## Markdown ??

  - [Differences - Python\-Markdown — Python\-Markdown 3\.0\.1 documentation](https://python-markdown.github.io/#differences) #ril
      - While Python-Markdown strives to fully implement markdown as described in the syntax rules, the rules can be interpreted in different ways and different implementations occasionally vary in their behavior (see the [Babelmark FAQ](http://johnmacfarlane.net/babelmark2/faq.html#what-are-some-examples-of-interesting-divergences-between-implementations) for some examples). Known and INTENTIONAL differences found in Python-Markdown are summarized below: 有些部份 Markdown 原作者沒講清楚，衍生出實作上的差異
      - Middle-Word Emphasis -- Python-Markdown defaults to ignoring MIDDLE-WORD EMPHASIS (and strong emphasis). In other words, `some_long_filename.txt` will not become `some<em>long</em>filename.txt`. This can be switched off if desired. See the Legacy EM Extension for details. 這對中文很重要 (否則要刻意寫成 `用 _底線_ 標示重點`)，啟用 `legacy_em` extension 即可，確認過在 code span 裡的底線不受影響。

## Extension ??

  - [Extensions — Python\-Markdown 3\.0\.1 documentation](https://python-markdown.github.io/extensions/) #ril
  - [Third Party Extensions · Python\-Markdown/markdown Wiki](https://github.com/Python-Markdown/markdown/wiki/Third-Party-Extensions) #ril
  - [Extension API — Python\-Markdown 3\.0\.1 documentation](https://python-markdown.github.io/extensions/api/) #ril
  - [Arithmatex \- PyMdown Extensions Documentation](https://facelessuser.github.io/pymdown-extensions/extensions/arithmatex/) 提供好多 extension，數量很誇張! #ril

## 參考資料 {: #reference }

  - [Python-Markdown](https://python-markdown.github.io/)
  - [Python\-Markdown/markdown - GitHub](https://github.com/Python-Markdown/markdown)
  - [Markdown - PyPI](https://pypi.org/project/Markdown/)

