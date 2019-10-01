---
title: Python / Data Structure
---
# [Python](python.md) / Data Structure

  - [5\. Data Structures — Python 2\.7\.14 documentation](https://docs.python.org/2/tutorial/datastructures.html) #ril

## 基礎

### Sequence ??

  - [Sequence Types — str, unicode, list, tuple, bytearray, buffer, xrange - 5\. Built\-in Types — Python 2\.7\.15 documentation](https://docs.python.org/2/library/stdtypes.html#sequence-types-str-unicode-list-tuple-bytearray-buffer-xrange) #ril
  - [sequence - Glossary — Python 3\.6\.6rc1 documentation](https://docs.python.org/3/glossary.html#term-sequence) 實作了 `__getitem__()` 與 `__len__()` #ril
  - [object.__getitem__(self, key) - 3\. Data model — Python 3\.6\.6rc1 documentation](https://docs.python.org/3/reference/datamodel.html#object.__getitem__) #ril
  - [object.__len__(self) - 3\. Data model — Python 3\.6\.6rc1 documentation](https://docs.python.org/3/reference/datamodel.html#object.__len__) #ril

### List??

### Mapping??

  - [Mapping Types — dict - 5\. Built\-in Types — Python 2\.7\.14 documentation](https://docs.python.org/2/library/stdtypes.html#typesmapping) #ril
      - 所謂 mapping object 是 hashable -> object 的對照 (只有 key 一定要是 hashable)，目前 standard library 裡只有一個 mapping type -- dictionary (`dict`)。
      - 除了用 `{key: value, ...}` 建立之外，還有 `dict(**kwarg)`、`dict(mapping, **kwarg)`、`dict(iterable, **kwarg)` 3 種 contructor -- 其中 positional argument 跟 keyword arguments 都是 optional，兩者的關係是 "先根據 positional argument 建立基礎的 dict (如果沒有就是 empty)，然後再用 keyword arguments 覆寫 (但 key 必須是合法的 Python identifier)。其中 positional argument 若是 mapping，會把 key-value pairs 抄寫過來，若是 iterable，每個 item 都必須是長度為 2 的 iterable -- 分別是 key 跟 value。
      - 例如 `{'one': 1, 'two': 2, 'three': 3}` 等同於 `dict(one=1, two=2, three=3)`、`dict(zip(['one', 'two', 'three'], [1, 2, 3]))`、`dict([('two', 2), ('one', 1), ('three', 3)])` 或 `dict({'three': 3, 'one': 1, 'two': 2})`。
      - `dict.items()` 提到 "CPython implementation detail: Keys and values are listed in an arbitrary order which is non-random, varies across Python implementations, and depends on the dictionary’s history of insertions and deletions."，這裡 "in an arbitrary order & is non-random" 的說法很特別，在單元測試時要如何準備資料，來驗證邏輯裡有自己做排序，而不是相依於 CPython impl. 內部實作? 透過 code review? 或是用 assert 檢查預設的順序跟排序的結果不同?
  - [5.5. Dictionaries - 5\. Data Structures — Python 2\.7\.14 documentation](https://docs.python.org/2/tutorial/datastructures.html#dictionaries) #ril

### Ordered Mapping ??

  - [Mapping Types — dict - 5\. Built\-in Types — Python 2\.7\.14 documentation](https://docs.python.org/2/library/stdtypes.html#typesmapping) `dict.items()` 提到 "CPython implementation detail: Keys and values are listed in an ARBITRARY ORDER which is NON-RANDOM, varies across Python implementations, and depends on the dictionary’s history of insertions and deletions."，這裡 "in an arbitrary order & is non-random" 的說法很特別，在單元測試時要如何準備資料，來驗證邏輯裡有自己做排序，而不是相依於 CPython impl. 內部實作?
  - [8.3.5. OrderedDict objects - 8\.3\. collections — High\-performance container datatypes — Python 2\.7\.15 documentation](https://docs.python.org/2/library/collections.html#ordereddict-objects) #ril
      - 跟一般的 dictionary 一樣，只是它會記住 item 放進 dictionary 的順序，對它做 iteration 時，item 就會依序被回傳。
  - [OrderedDict objects - collections — Container datatypes — Python 3\.7\.1rc1 documentation](https://docs.python.org/3/library/collections.html#ordereddict-objects) #ril

### Set??

  - [Set Types — set, frozenset - 5\. Built\-in Types — Python 2\.7\.14 documentation](https://docs.python.org/2/library/stdtypes.html#set-types-set-frozenset) #ril

### map() ??

  - [Getting a map\(\) to return a list in Python 3\.x \- Stack Overflow](https://stackoverflow.com/questions/1303347/) `map(chr, [66, 53, 0, 94])` 在 Pyhton 2.6 會傳回 list，但在 Python 3 會傳回 map object?
      - Triptych: 在 Python 3 許多對 iterable 的處理也回傳 iterator，這樣的可以節省記憶體、加快處理。如果要做 iteration，直接用 for loop (例如 `for ch in map(chr,[65,66,67,68])`) 就可以，不用先轉為 list。
  - Python 2 `map(chr, map(ord, 'Hello'))` 會得到 `['H', 'e', 'l', 'l', 'o']`，但 `map(chr, map(ord, 'Hello'))` 會得到一個 `<map object at ...>`，是個 iterator。可以用 `list()` 或 `tuple()` 轉換成 `list/tuple`。

### 排序 (Sorting)??

```
def test_sorting__sorted():
    versions = ['10.0.01', '11.3.00', '9.8.12', '9.8.00']
    assert sorted(versions, key=lambda v: map(int, v.split('.'))) == \
        ['9.8.00', '9.8.12', '10.0.01', '11.3.00']

def test_sorting__sort_in_place():
    versions = ['10.0.01', '11.3.00', '9.8.12', '9.8.00']
    versions.sort(key=lambda v: map(int, v.split('.')))

    assert versions == ['9.8.00', '9.8.12', '10.0.01', '11.3.00']
```

參考資料：

  - [sorted(iterable, *, key=None, reverse=False) - 2\. Built\-in Functions — Python 3\.6\.4 documentation](https://docs.python.org/3/library/functions.html#sorted) #ril
  - [sorted(iterable[, cmp[, key[, reverse]]]) - 2\. Built\-in Functions — Python 2\.7\.14 documentation](https://docs.python.org/2/library/functions.html#sorted) `sorted()` 中 `cmp`、`key` 的作用類似 (都是 function)，只是 `cmp` 自己做比較 (接受兩個參數)，而 `key` 決定取出什麼東西來比較 (只接受一個參數) #ril
  - [5.1. More on Lists - 5\. Data Structures — Python 2\.7\.14 documentation](https://docs.python.org/2/tutorial/datastructures.html#more-on-lists) `list.sort(cmp=None, key=None, reverse=False)` 跟 `sorted()` 的用法一樣，只是 `list.sort()` 會直接更新 list，不像 `sorted()` 會另建一個 list。
  - [Sorting HOW TO — Python 2\.7\.14 documentation](https://docs.python.org/2.7/howto/sorting.html) #ril
  - [Sorting HOW TO — Python 3\.6\.4 documentation](https://docs.python.org/3/howto/sorting.html) #ril
  - [Glossary — Python 3\.6\.4 documentation](https://docs.python.org/3/glossary.html#term-key-function)
      - key/collation function 用來傳回一個供 sorting/ordering 的 value，許多 function 都接受 key function 用以控制 elements 根據什麼來排序，例如 `min()`、`max()`、`sorted()` 等。
      - 有許多方式建立 key function，包括 lambda expression；用法也很多種，例如 `str.lower()` 可以用來做 case-insensitive sorting。

### map()、filter()、any()、all()、zip() 的妙用??

  - `[expression for item in iterable]` == `map(lambda item: expression, iterable)`

### 如何實現 immutable list??

  - [Does Python have an immutable list? \- Stack Overflow](https://stackoverflow.com/questions/11142397/) cammil: 用 tuple。
  - [`tuple([iterable])` - 2\. Built\-in Functions — Python 2\.7\.14 documentation](https://docs.python.org/2/library/functions.html#tuple) `tuple()` built-in 可以將 iterable 轉為 tuple。

## 參考資料 {: #reference }

  - [Sequence Types - `list`, `tuple`, `range` (Python 3)](https://docs.python.org/3/library/stdtypes.html#sequence-types-list-tuple-range)
  - [Set Types - `set`, `frozenset` (Python 3)](https://docs.python.org/3/library/stdtypes.html#set-types-set-frozenset)
  - [Mapping Types - `dict` (Python 3)](https://docs.python.org/3/library/stdtypes.html#mapping-types-dict)
