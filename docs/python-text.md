---
title: Python / Text
---
# [Python](python.md) / Text

  - [4\. Text versus Bytes \- Fluent Python \[Book\]](https://www.oreilly.com/library/view/fluent-python/9781491946237/ch04.html) #ril

## str ??

  - [Text Sequence Type — str - Built\-in Types — Python 3\.7\.2 documentation](https://docs.python.org/3/library/stdtypes.html#text-sequence-type-str) #ril

## String Interpolation/Formatting ??

  - [String Methods - Built\-in Types — Python 3\.7\.2 documentation](https://docs.python.org/3/library/stdtypes.html#string-methods)
      - Strings also support TWO STYLES of string formatting, one providing a large degree of FLEXIBILITY and customization (see `str.format()`, Format String Syntax and Custom String Formatting) and the other based on C `printf` style formatting that handles a NARROWER range of types and is slightly HARDER TO USE CORRECTLY, but is often FASTER for the cases it can handle (printf-style String Formatting). 有 2 種方式 (style) 可以做 string formatting，一個是 printf-style (較快，但功能較受限)，另一個 `str.format()` 彈性比較大，兩者語法不同。
  - [Formatter - Logging HOWTO — Python 3\.7\.1 documentation](https://docs.python.org/3/howto/logging.html#formatters) If the style is `%`, the message format string uses `%(<dictionary key>)s` styled string substitution; the possible keys are documented in `LogRecord` attributes. If the style is `{`, the message format string is assumed to be compatible with `str.format()` (using keyword arguments), while if the style is `$` then the message format string should conform to what is expected by `string.Template.substitute()`. 插值的選擇這麼多種，導致 library 也要支援多種不同的用法。
  - [The 4 Major Ways to Do String Formatting in Python – dbader\.org](https://dbader.org/blog/python-string-formatting) (2018-07-04) #ril

### printf Style ??

  - [printf-style String Formatting - Built\-in Types — Python 3\.7\.2 documentation](https://docs.python.org/3/library/stdtypes.html#printf-style-string-formatting) #ril

### New Style ??

  - [`str.format(*args, **kwargs)` - Built\-in Types — Python 3\.7\.2 documentation](https://docs.python.org/3/library/stdtypes.html#str.format) #ril
      - Perform a string formatting operation. The string ON WHICH THIS METHOD IS CALLED can contain literal text or REPLACEMENT FIELDS delimited by braces `{}`. 也就是 string 本身是 template，裡面用 `{}` 來安插 replacement field。
      - Each replacement field contains either the numeric index of a POSITIONAL ARGUMENT, or the name of a KEYWORD ARGUMENT. Returns a copy of the string where each replacement field is replaced with the string value of the corresponding argument. 對照 `*args, **kwargs`，前者 (positional argument) 透過 numeric index 引用，後者 (keyword argument) 透過 keyword name 引用，例如：

            >>> "The sum of 1 + 2 is {0}".format(1+2) # {0} 對應第一個 positional argument
            'The sum of 1 + 2 is 3'

  - [String Formatting - 6\.1\. string — Common string operations — Python 3\.4\.9 documentation](https://docs.python.org/3.4/library/string.html#string-formatting)
      - The built-in string class provides the ability to do complex variable substitutions and value formatting via the `format()` method described in PEP 3101. The `Formatter` class in the `string` module allows you to create and customize your own string formatting behaviors using the same implementation as the built-in `format()` method. 這裡的 `format()` 泛指 `str.format()` 與 `format()` built-in；實務上似乎要自訂 formatter 時才會用到 `string` module。

  - [Format String Syntax - string — Common string operations — Python 3\.7\.2 documentation](https://docs.python.org/3/library/string.html#formatstrings) #ril
      - The `str.format()` method and the `Formatter` class share the SAME SYNTAX for format strings (although in the case of `Formatter`, subclasses can define their own format string syntax).
      - Format strings contain “replacement fields” surrounded by curly braces `{}`. Anything that is not contained in braces is considered LITERAL TEXT, which is copied unchanged to the output. If you need to include a brace character in the literal text, it can be escaped by doubling: `{{` and `}}`.
      - The grammar for a replacement field is as follows:

            replacement_field ::=  "{" [field_name] ["!" conversion] [":" format_spec] "}"
            field_name        ::=  arg_name ("." attribute_name | "[" element_index "]")*
            arg_name          ::=  [identifier | integer]
            attribute_name    ::=  identifier
            element_index     ::=  integer | index_string
            index_string      ::=  <any source character except "]"> +
            conversion        ::=  "r" | "s" | "a"
            format_spec       ::=  <described in the next section>

        In less formal terms, the replacement field can start with a `field_name` that specifies the object whose value is to be formatted and inserted into the output instead of the replacement field. The `field_name` is optionally followed by a `conversion` field, which is preceded by an exclamation point `'!'`, and a `format_spec`, which is preceded by a colon `':'`. These specify a non-default format for the replacement value. 除了 `field_name` 前面不用有符號，`conversion` 跟 `format_spec` (如果有指定的話) 前面的符號一定要有 `!` 跟 `:`。

      - The `field_name` itself begins with an `arg_name` that is either a number or a keyword. If it’s a number, it refers to a positional argument, and if it’s a keyword, it refers to a named keyword argument. If the numerical `arg_names` in a format string are 0, 1, 2, … IN SEQUENCE, they can all be OMITTED (NOT JUST SOME) and the numbers 0, 1, 2, … will be automatically inserted in that order. Because `arg_name` is not quote-delimited, it is not possible to specify arbitrary dictionary keys (e.g., the strings `'10'` or `':-]'`) within a format string. 其中 `field_name` 可以用 integer/identifier 引用 positional/keyword argument，發現兩種用法可以混用，但 integer 不能一下子省略，一下子又指定：

            >>> '{} {key}'.format(123, key='value')
            '123 value'
            >>> '{} {1} {key}'.format(123, 456, key='value')
            Traceback (most recent call last):
              File "<stdin>", line 1, in <module>
            ValueError: cannot switch from automatic field numbering to manual field specification

      - The `arg_name` can be followed by any number of index or attribute expressions. An expression of the form `'.name'` selects the named attribute using `getattr()`, while an expression of the form `'[index]'` does an index lookup using `__getitem__()`.

  - [PEP 3101 \-\- Advanced String Formatting \| Python\.org](https://www.python.org/dev/peps/pep-3101/) String Methods 同時提到 `str.format()` 跟 `format()` built-in #ril #ril

### Literal Interpolation ??

  - [Formatted string literals - 2\. Lexical analysis — Python 3\.7\.2 documentation](https://docs.python.org/3/reference/lexical_analysis.html#f-strings) #ril
  - [PEP 498 \-\- Literal String Interpolation \| Python\.org](https://www.python.org/dev/peps/pep-0498/) #ril

### Template String ??

  - [Template strings - string — Common string operations — Python 3\.7\.2 documentation](https://docs.python.org/3/library/string.html#template-strings) #ril
  - [PEP 292 \-\- Simpler String Substitutions \| Python\.org](https://www.python.org/dev/peps/pep-0292/) #ril

## Unicode ??

  - [Overcoming frustration: Correctly using unicode in python2 — kitchen 1\.2\.1 documentation](https://pythonhosted.org/kitchen/unicode-frustrations.html) #ril
  - [Unicode HOWTO — Python 2\.7\.14 documentation](https://docs.python.org/2/howto/unicode.html) #ril
  - [Unicode HOWTO — Python 3\.6\.4 documentation](https://docs.python.org/3/howto/unicode.html) #ril
  - [Solving Unicode Problems in Python 2\.7 \- Azavea \- Beyond Dots on a Map](https://www.azavea.com/blog/2014/03/24/solving-unicode-problems-in-python-2-7/) (2014-03-24) #ril
  - [More About Unicode in Python 2 and 3 \| Armin Ronacher's Thoughts and Writings](http://lucumr.pocoo.org/2014/1/5/unicode-in-2-and-3/) (2014-01-05) #ril
  - [Python 2\.7\. Unicode Errors Simply Explained](https://gist.github.com/gornostal/1f123aaf838506038710) #ril

### Unicde Sandwich ??

  - [python \- urllib\.urlencode doesn't like unicode values: how about this workaround? \- Stack Overflow](https://stackoverflow.com/questions/6480723/)
      - John Machin 提到 "decode at input time, work exclusively in unicode, encode at output time"，這話說得真好!! 往外輸出時要用 byte string
  - [Pragmatic Unicode](https://nedbatchelder.com/text/unipain/unipain.html#35) 出現 "Unicode Sandwich" 的說法 -- Bytes on the outside, unicode on the inside Encode/decode at the edges 另一種不錯的說法。
  - [John A\. Bachman – Building a Python 2/3 compatible Unicode Sandwich](http://johnbachman.net/building-a-python-23-compatible-unicode-sandwich.html) (2017-03-10) #ril

### UnicodeEncodeError: 'ascii' codec can't encode character u'\xe9' in position 3: ordinal not in range(128) ??

  - [Python 2\.7\. Unicode Errors Simply Explained](https://gist.github.com/gornostal/1f123aaf838506038710) #ril
      - `str(u'café')` 就會引發 `UnicodeDecodeError`，因為 `str()` 會試著用 default encoding (ASCII) 編碼，結果不認得 0..127 以外的字元。

### UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position 3: ordinal not in range(128) ??

  - 發現 `str` 與 `unicode` 串接時，內部會先將 `str` 轉成 `unicode`，若 `str` 內含 ASCII 不認得的字元，就會遇到 `UnicodeDecodeError`；有文件講到這個嗎??
  - [Python 2\.7\. Unicode Errors Simply Explained](https://gist.github.com/gornostal/1f123aaf838506038710) #ril
      - `unicode(u'café'.encode('utf-8'))` 就會引發 `UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position 3: ordinal not in range(128)`，因為 Python 用 default encoding (ASCII) 試著要把 UTF-8 編碼的 byte string 解碼成 unicode，結果不認得 0..127 以外的字元。
      - 你可能從某些地方拿到 byte string (`str`)，當我們把它交給其他 function 處理，內部可能會調用 `unicode()` 而引發上面的錯誤；避開這類錯誤的方法就是用 `.decode('utf-8')` 先轉成 Unicode。

## 如何用分隔字元拆解字串?

  - 如何拆出 `''`、`' '` 與 `1, 2,3, 4 , 5`? =? 利用 list comprehension 搭配 `filter()` 濾除空字串。也就是 `filter(None, [x.strip() for x in input.split(',')])`。
  - 但如果是正規化後的字串 (沒有多餘的空白)，例如 `''` 與 `1,2,3,4`，就不用 `strip()` 處理，用 `filter(None, input.split(','))` 即可。
  - 如果有多種分隔字元，可以事先將其他分隔字元取代成同一個，再統一拆分? 例如 `filter(None, [x.strip() for x in input.replace(';', ',').split(',')])`

參考資料：

  - 7.1. string — Common string operations — Python 2.7.14 documentation https://docs.python.org/2/library/string.html#string.split 提到 `string.split(s[, sep[, maxsplit]])` 的用法，若 `sep` 省略或傳入 `None`，會依 whitespace 分割，結果可能是個 empty list，但如果自訂分隔字元的話，結果就會內含一個 empty string。
  - When splitting an empty string in Python, why does split() return an empty list while split('
') returns ['']? - Stack Overflow https://stackoverflow.com/questions/16645083/ 為什麼 `''.split()` 傳回 `[]`，但 `''.split('\n')` 卻傳回 `['']`? Lennart Regebro: 沒有參數的 `split()` 用來取出 words，有參數的 `split()` 用來切割字串；一刀劃下去就會有兩邊。
  - python - Why are empty strings returned in split() results? - Stack Overflow https://stackoverflow.com/questions/2197451/ 若要問為什麼要有空字串，John La Rooy 的答案很具說服力，因為跟 `join()` 互補，例如 `"/".join(['', 'segment', 'segment', ''])` 可以組出 `/segment/segment/`，少了前後的 empty string 反而不行。若是要拆解字串的話，Franck Dernoncourt 提出 `filter(None, '/segment/segment/'.split('/'))` 的做法還滿妙的。
  - 2. Built-in Functions — Python 2.7.14 documentation https://docs.python.org/2/library/functions.html#filter `filter(function, iterable)` 會將傳入 `function` 傳回 `false` 的項目去除，若 `function` 是 `None` 的話會用 identity function (大概是傳回自己的 function，像是 `lambda x: x`)，所以空字串自然被去除。

## 參考資料 {: #reference }

手冊：

  - [Format String Syntax](https://docs.python.org/3/library/string.html#format-specification-mini-language)
  - [Standard Encodings - The Python Standard Library](https://docs.python.org/3/library/codecs.html#standard-encodings)

