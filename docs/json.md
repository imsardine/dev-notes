# JSON

  - [JSON](https://www.json.org/json-en.html)

      - JSON (JavaScript Object Notation) is a LIGHTWEIGHT DATA-INTERCHANGE FORMAT. It is easy for humans to read and write. It is easy for machines to parse and generate.

        It is based on a subset of the JavaScript Programming Language Standard ECMA-262 3rd Edition - December 1999. JSON is a text format that is completely LANGUAGE INDEPENDENT but uses conventions that are familiar to programmers of the C-family of languages, including C, C++, C#, Java, JavaScript, Perl, Python, and many others.

        These properties make JSON an ideal data-interchange LANGUAGE.

## Structure

  - [JSON](https://www.json.org/json-en.html)

      - JSON is built on two structures:

          - A collection of NAME/VALUE PAIRS. In various languages, this is realized as an object, record, struct, dictionary, hash table, keyed list, or associative array.
          - An ORDERED LIST of values. In most languages, this is realized as an array, vector, list, or sequence.

        These are universal data structures. Virtually all modern programming languages support them in one form or another. It makes sense that a data format that is interchangeable with programming languages also be based on these structures.

      - In JSON, they take on these forms:

          - An OBJECT is an UNORDERED set of name/value pairs. An object begins with `{` and ends with `}`. Each name is followed by `:` and the name/value pairs are separated by `,`.

            ![](https://www.json.org/img/object.png)

            其中 name 只能是 string，但 value 則可以是 string, number, object, array 等。

          - An ARRAY is an ordered collection of values. An array begins with `[` and ends with `]`. Values are separated by `,`.

            ![](https://www.json.org/img/array.png)

          - A VALUE can be a string in DOUBLE quotes, or a number, or `true` or `false` or `null`, or an object or an array. These structures can be NESTED.

            ![](https://www.json.org/img/value.png)

          - Whitespace can be inserted between any pair of TOKENS. Excepting a few encoding details ??, that completely describes the language.

            允許 linefeed、carriage retur、horizontal tab 出現是為了增加 JSON 本身的可讀性，但這些字元在 string 裡都要被 escape。

## String

  - [JSON](https://www.json.org/json-en.html)

      - A string is a sequence of zero or more UNICODE characters, wrapped in DOUBLE quotes, using BACKSLASH ESCAPES.

        ![](https://www.json.org/img/string.png)

        圖形本身揭露了更多資訊 -- Any codepoint except " or \ or control characters，表示 Unicode 不需要做 escaping，但 `"`、`\` 及其他控制字元一定要，例如 `\"`、`\\`、`\t`、`\r`、`\n` 等。

        最特別的地方是 `/` (solidus/slash) 也在其中? 什麼情況下要有 `\/` 的用法??

        A character is represented as a SINGLE CHARACTER STRING. A string is very much like a C or Java string.

        也就是 JSON 不像 Java 有 `char` 型態 (單引號)，只能用只有一個字元的 string 來表現 (雙引號)。

  - [javascript \- JSON: why are forward slashes escaped? \- Stack Overflow](https://stackoverflow.com/questions/1580647/)

      - JSON escapes the forward slash, so a hash `{a: "a/b/c"}` is serialized as `{"a":"a\/b\/c"}` instead of `{"a":"a/b/c"}`.

        Walter Tross: PHP's `json_encode()` escapes forward slashes by default, but has the [`JSON_UNESCAPED_SLASHES`](https://www.php.net/manual/en/json.constants.php#constant.json-unescaped-slashes) option starting from PHP 5.4.0

      - Ruben: JSON doesn't require you to do that, it allows you to do that. It also allows you to use "\u0061" for "A", but it's NOT REQUIRED. Allowing `\/` helps when embedding JSON in a `<script>` tag, which doesn't allow `</` inside strings, like Seb points out.

        這只是選擇的問題。

        Some of Microsoft's ASP.NET Ajax/JSON API's use this loophole to add extra information, e.g., a datetime will be sent as `"\/Date(milliseconds)\/"`. (Yuck) 為什麼要這麼做?

        Ruben: That would be a good thing, escaping just `</`. Though JSON is not often embedded in script tags anyway.

      - Simon East: PHP escapes forward slashes BY DEFAULT which is probably why this appears so commonly. I'm not sure why, but possibly because embedding the string `"</script>"` inside a `<script>` tag is considered unsafe.

        This functionality can be disabled by passing in the `JSON_UNESCAPED_SLASHES` flag but most developers will not use this since THE ORIGINAL RESULT IS ALREADY VALID JSON.

        若只供程式讀取，slash 有沒有 escape 其實沒差。

## Number

  - [JSON](https://www.json.org/json-en.html)

      - A number is very much like a C or Java number, except that the octal and hexadecimal formats are not used.

        ![](https://www.json.org/img/number.png)

        可以表現正負數、小數、指數。

## Boolean

  - [JSON](https://www.json.org/json-en.html)

    A VALUE can be a string in DOUBLE quotes, or a number, or `true` or `false` or `null`, or an object or an array. These structures can be NESTED.

    這是 JSON 首頁對 `true`/`false` 唯一的說明。

## Null

  - [JSON](https://www.json.org/json-en.html)

    A VALUE can be a string in DOUBLE quotes, or a number, or `true` or `false` or `null`, or an object or an array. These structures can be NESTED.

    這是 JSON 首頁對 `null` 唯一的說明。

## Date/Time

  - [Tales from the Evil Empire \- Dates and JSON](https://weblogs.asp.net/bleroy/dates-and-json) (2008-01-18) #ril

## Comment

  - How do I write comments inside a JSON document? - Quora https://www.quora.com/How-do-I-write-comments-inside-a-JSON-document #ril
      - Clarence Leung: JSON 不支援 comment，引用了 JSON 作者 [Douglas Crockford](https://plus.google.com/+DouglasCrockfordEsq/posts/RK8qyGVaGSr) 的說法，如果需要加註的話 (尤其是 configuration file)，可以在送往 JSON parser 前先經過 [JSMin](http://www.crockford.com/javascript/jsmin.html) 之類的套件處理。
      - Tatu Saloranta: 雖然 JSON 的規格不支援，但大部份 decoder 都支援 C 或 C++ style 的註解，也就是 `/* ... */` 與 `// ...`。覺得不支援 comment 是一個粗糙的決定 - "textual data formats really ought to have human-readable non-machine-usable annotations"，也之所以 decoder 通常都支援它。
  - Can comments be used in JSON? - Stack Overflow http://stackoverflow.com/questions/244777/ #ril

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

## 參考資料 {: #reference }

  - [JSON](http://json.org/)
  - [Maven Repository: org.json » json](https://mvnrepository.com/artifact/org.json/json)

工具：

  - [fx](https://github.com/antonmedv/fx) - terminal JSON viewer
  - [jq](jq.md) - command-line JSON processor
  - [Myjson](myjson.md) - 自己安排 API 回傳的 JSON

手冊：

  - [RFC 7159 - The JavaScript Object Notation (JSON) Data Interchange Format](https://tools.ietf.org/html/rfc7159)
