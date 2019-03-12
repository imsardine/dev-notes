# lxml

  - [lxml \- Processing XML and HTML with Python](https://lxml.de/) #ril
      - lxml XML toolkit 是 C libraies `libxml2` 與 `libxslt` 的 Python binding -- 方便用 Python 處理 XML 與 HTML；它的 API 相容但優於 ElementTree API。

## 跟 ElementTree 的關係 {: #elementtree }

  - [lxml \- Processing XML and HTML with Python](https://lxml.de/) `lxml.etree` 除了 ElementTree API，也提供 `lxml.etree` 專有的API，以揭露底層 `libxml2` 與 `libxslt` 專屬的功能，例如 XPath、XML Schema、XSLT 等。
  - [The lxml\.etree Tutorial](https://lxml.de/tutorial.html) 這份 Tutorial 主要是在講 ElementTree API，相較於另一份文件 [lxml.etree specific API](https://lxml.de/api.html) 則是從 "相較於 ElementTree API"，`lxml.etree` 多了什麼" 的角度在寫。
  - [ElementTree compatibility of lxml\.etree](https://lxml.de/compatibility.html) 注重 `lxml.etree` 與 `ElementTree` 的相容性，但還是有不相容的部份。
  - [Benchmarks and Speed](https://lxml.de/performance.html) `lxml.etree` 在許多地方速度比 cElementTree 還快。
  - [lxml FAQ \- Frequently Asked Questions](https://lxml.de/FAQ.html) Who uses lxml? 提到 "Also note that the compatibility to the ElementTree library does not require projects to set a hard dependency on lxml - as long as they do not take advantage of lxml's enhanced feature set." 意思是可以因 lxml 提昇效能，但又不綁定 lxml，不過前題是不能用到 lxml 特有的 API。

## HTML Parsing ??

  - [Parsing HTML - Parsing XML and HTML with lxml](https://lxml.de/parsing.html#parsing-html) #ril
      - HTML parsing is similarly simple. The parsers have a recover keyword argument that the HTMLParser sets by default. It lets libxml2 try its best to return a valid HTML tree with all content it can manage to parse. It will not raise an exception on parser errors. You should use libxml2 version 2.6.21 or newer to take advantage of this feature.

## 參考資料 {: #reference }

  - [lxml - Processing XML and HTML with Python](http://lxml.de/)

社群：

  - [lxml' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/lxml)

