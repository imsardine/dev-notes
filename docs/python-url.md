---
title: Python / URL
---
# [Python](python.md) / URL

## URL Parsing ??

  - [urllib-urlencode() - 20\.5\. urllib — Open arbitrary resources by URL — Python 2\.7\.14 documentation](https://docs.python.org/2/library/urllib.html#urllib.urlencode)

      - The `urlparse` module provides the functions `parse_qs()` and `parse_qsl()` which are used to parse query strings into Python data structures.

## URL Encoding

  - [urllib-urlopen() - 20\.5\. urllib — Open arbitrary resources by URL — Python 2\.7\.14 documentation](https://docs.python.org/2/library/urllib.html#urllib.urlopen) 當 URL 採用 `http:` scheme 且有提供 `data` argument 時，會走 POST request。此時 `data` argument 必須採 `application/x-www-form-urlencoded` 格式，參考 `urlencode()`。

  - [urllib-urlencode() - 20\.5\. urllib — Open arbitrary resources by URL — Python 2\.7\.14 documentation](https://docs.python.org/2/library/urllib.html#urllib.urlencode)

      - Convert a mapping object or a sequence of two-element tuples to a “PERCENT-ENCODED” string, suitable to pass to `urlopen()` above as the optional `data` argument. This is useful to pass a dictionary of form fields to a POST request.

        The resulting string is a series of `key=value` pairs separated by `'&'` characters, where both key and value are quoted using `quote_plus()` above.

        雖然這裡只提到 POST data (也就是 `application/x-www-form-urlencoded`)，但根據 [`quote_plus()`](https://docs.python.org/2/library/urllib.html#urllib.quote_plus) 的說法，也可以用在 query string 的編碼：

        > Like `quote()`, but also REPLACES SPACES BY PLUS SIGNS, as required for quoting HTML form values when building up a QUERY STRING to go into a URL. Plus signs in the original string are escaped unless they are included in `safe`. It also does not have safe default to `'/'`.

      - When a sequence of two-element tuples is used as the `query` argument, the first element of each tuple is a key and the second is a value. The value element in itself can be a sequence and in that case, if the optional parameter `doseq` is evaluates to `True`, individual `key=value` pairs separated by `'&'` are generated for each element of the value sequence for the key.

        The order of parameters in the encoded string will match the order of parameter tuples in the sequence.

        因此 two-element tuples 也可以用在想保留 parameters 的順序時，value 不一定要是 sequence。

## URL Decode

```
def test_url_decode__dict():
    query_string = 'key=value&dt=2018-03-20T17%3A00%3A00%2B08%3A00'
    params = urlparse.parse_qs(query_string)

    assert params == {
        'key': ['value'],
        'dt': ['2018-03-20T17:00:00+08:00'] # list of values
    }

def test_url_decode__list():
    query_string = 'key=value&dt=2018-03-20T17%3A00%3A00%2B08%3A00'
    params = urlparse.parse_qsl(query_string)

    assert params == [
        ('key', 'value'),
        ('dt', '2018-03-20T17:00:00+08:00')
    ]
```

參考資料：

  - [urllib-urlencode() - 20\.5\. urllib — Open arbitrary resources by URL — Python 2\.7\.14 documentation](https://docs.python.org/2/library/urllib.html#urllib.urlencode) 提到 `urlparse` 的 `parse_qs()` 與 `parse_qls()` 可以用來解析 query string。
  - [20\.16\. urlparse — Parse URLs into components — Python 2\.7\.14 documentation](https://docs.python.org/2/library/urlparse.html) `parse_qs()` 與 `parse_qsl()` 都可以解析 query string，差別在於 `parse_qs()` 的輸出是 `dict` (注意 value 是 list of value)，而 `parse_qsl()` 的輸出是 list of (name, value)；看起來 `dict(parse_qsl())` 是比較方便的，不用再處理 list of value 的問題。
  - [URL Decoding query strings or form parameters in Python \| URLDecoder](https://www.urldecoder.io/python/) 單純要解 percent-encoded string (不是 `key=value` 的形式)，有 `urllib.unquote()` 可以用 #ril

## urllib.urlencode() 不能用在 Unicode?

若傳入 Unicode 確實會遇到類似下面的錯誤：

```
'ascii' codec can't encode characters in position 0-1: ordinal not in range(128)
```

```
def test_urlencode__unicode__raise_error():
    data = {'unicode': u'中文'}

    message = "'ascii' codec can't encode characters in position 0-1:" \
              " ordinal not in range(128)"
    with pytest.raises(UnicodeEncodeError, match=re.escape(message)) as exc_info:
        urllib.urlencode(data)

def test_urlencode__unicode_utf8encode():
    data = {'unicode-encoded': '中文'} # byte string (no u'...' prefix)
    assert urllib.urlencode(data) == 'unicode-encoded=%E4%B8%AD%E6%96%87'
```

參考資料：

  - [python \- urllib\.urlencode doesn't like unicode values: how about this workaround? \- Stack Overflow](https://stackoverflow.com/questions/6480723/)
      - 把 unicode 直接送給 `urllib.urlencode()` 會出現，作者想出的方法是對所有 item 的 value 做 `encode('utf-8')`。
      - John Machin 提到 "decode at input time, work exclusively in unicode, encode at output time"，這話說得真好!! 往外輸出時要用 byte string

