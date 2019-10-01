# JSON

## 資料型態?

  - [JSON](https://www.json.org/) "A value can be a string in double quotes, or a number, or true or false or null, or an object or an array." 其中 object 是 name/value pairs，而 array 則是 list of values；注意字串只能用雙引號。
  - [JavaScript: single quotes or double quotes?](http://2ality.com/2012/09/javascript-quotes.html) (2012-09-17) JSON 只允許雙引號。

## Newline ??

  - [JSON](https://www.json.org/) String 裡可以有 backslash escape，下面同時提到 `\r` (carriage return) 與 `\n` (newline)。

## 在本地端將 JSON 格式化??

  - [How can I pretty\-print JSON in a \(Unix\) shell script? \- Stack Overflow](https://stackoverflow.com/questions/352098/) 很多人推 `jq`。

## Schema

  - JSON Schema http://json-schema.org/ #ril
  - FasterXML/jackson: Main Portal page for Jackson project https://github.com/FasterXML/jackson #ril

## Python

  - 18.2. json — JSON encoder and decoder — Python 2.7.13 documentation https://docs.python.org/2/library/json.html #ril

## Key 重複時，如何轉成 list?

  - python - json.loads allows duplicate keys in a dictionary, overwriting the first value - Stack Overflow https://stackoverflow.com/questions/14902299/ Key 重複時，後者的 value 會覆蓋前者，要如何丟出例外? 提到 `json.loads()` 的 `object_pairs_hook` 參數 #ril
  - python - SimpleJson handling of same named entities - Stack Overflow https://stackoverflow.com/questions/7825261/ 自訂 `json.JSONDecorder`，將重複的 key 轉成 list #ril
  - Python json parser allow duplicate keys - Stack Overflow https://stackoverflow.com/questions/29321677/ #ril

## 輸出時如何控制 key 的順序?

  - python - Items in JSON object are out of order using "json.dumps"? - Stack Overflow https://stackoverflow.com/questions/10844064/ `dict` 是 unordered collection，原始資料改用 [`collections.OrderedDict`](https://docs.python.org/2/library/collections.html#collections.OrderedDict) 即可，載入時則可以搭配 `object_pairs_hook=OrderedDict` #ril

## Comment ??

  - How do I write comments inside a JSON document? - Quora https://www.quora.com/How-do-I-write-comments-inside-a-JSON-document #ril
      - Clarence Leung: JSON 不支援 comment，引用了 JSON 作者 [Douglas Crockford](https://plus.google.com/+DouglasCrockfordEsq/posts/RK8qyGVaGSr) 的說法，如果需要加註的話 (尤其是 configuration file)，可以在送往 JSON parser 前先經過 [JSMin](http://www.crockford.com/javascript/jsmin.html) 之類的套件處理。
      - Tatu Saloranta: 雖然 JSON 的規格不支援，但大部份 decoder 都支援 C 或 C++ style 的註解，也就是 `/* ... */` 與 `// ...`。覺得不支援 comment 是一個粗糙的決定 - "textual data formats really ought to have human-readable non-machine-usable annotations"，也之所以 decoder 通常都支援它。
  - Can comments be used in JSON? - Stack Overflow http://stackoverflow.com/questions/244777/ #ril

## 參考資料 {: #reference }

  - [JSON](http://json.org/)
  - [Maven Repository: org.json » json](https://mvnrepository.com/artifact/org.json/json)

工具：

  - [fx](https://github.com/antonmedv/fx) - terminal JSON viewer
  - [jq](jq.md) - command-line JSON processor

手冊：

  - [RFC 7159 - The JavaScript Object Notation (JSON) Data Interchange Format](https://tools.ietf.org/html/rfc7159)
