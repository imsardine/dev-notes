---
title: Python / Data Type
---
# [Python](python.md) / Data Type

### Equality

  - [object.__eq__(self, other) - 3\. Data model — Python 3\.7\.1 documentation](https://docs.python.org/3/reference/datamodel.html#object.__eq__)
      - `__lt__()`、`__le__()`、`__eq__()`、`__ne__()`、`__gt__` 跟 `__ge__()` 統稱為 "rich comparison methods"，很直覺分別對應 `<`、`<=`、`==`、`!=`、`>` 及 `>=`；例如 `x != y` 背後會呼叫 `x.__ne__(y)`。
      - A rich comparison method may return the singleton `NotImplemented` if it does not implement the operation for a given PAIR OF ARGUMENTS (例如 `__eq__(self, other)` 就是比較 `self` 與 `other`). By convention, `False` and `True` are returned for a SUCCESSFUL COMPARISON. 雖然可以回傳其他值，在 boolean context 時會透過 `bool()` 分出 true/false。例如 `if a > b:` 可以想成 `if bool(a.__gt__(b)):`。
      - By default, `__ne__()` delegates to `__eq__()` and inverts the result unless it is `NotImplemented`. 也就是只要實作 `__eq__()` 即可，不過 Python 2 還是得實作 `__ne__()`。
      - See the paragraph on `__hash__()` for some important notes on creating hashable objects which support custom comparison operations and are usable as dictionary keys. => 自訂 hashable 的 comparison 時，要注意 
      - There are no swapped-argument versions of these methods ... ??

  - [object.__eq__(self, other) - 3\. Data model — Python 2\.7\.15 documentation](https://docs.python.org/2/reference/datamodel.html#object.__eq__) #ril
      - There are no implied relationships among the comparison operators. The truth of `x==y` does not imply that `x!=y` is false. Accordingly, when defining `__eq__()`, one should also define `__ne__()` so that the operators will behave as expected. 

### None

Python 中的 `None` 等同於其他語言的 `null`，不過它是個 object，型態是 `types.NoneType`：

```
import types

def test_none_singleton():
    assert isinstance(None, types.NoneType)
```

按照 [Programming Recommendations - PEP 8 \-\- Style Guide for Python Code \| Python\.org](https://www.python.org/dev/peps/pep-0008/#programming-recommendations) 的說法：

> Comparisons to singletons like `None` should always be done with `is` or `is not`, never the equality operators.

由於 `None` 是 singleton，比對時要用 `is`/`is not` (identity)，如果用 `==`/`!=` (equality) 可能會受到 operator overloading 的影響：

```
class Negator(object):

    def __eq__(self, other):
        return not other # doesn't make sense

    def __ne__(self, other): # requried for py2
        return not self.__eq__(other)

def test_none_identity__use_is():
    none = None
    thing = Negator()

    assert none is None # singleton
    assert thing is not None

def test_none_equality__donot_use_equality():
    none = None
    thing = Negator()

    assert none == None
    assert not (none != None)

    # weird? the result dependes on thing.__eq__()
    assert thing == None
    assert not (thing != None)
```

參考資料：

  - [None - 4\. Built\-in Constants — Python 2\.7\.14 documentation](https://docs.python.org/2/library/constants.html#None) `types.NoneType` 唯一的值就是 `None`，表示 "absence of a value"。
  - [Python's null equivalent: None \| Python Central](https://www.pythoncentral.io/python-null-equivalent-none/) (2013-06-28) 由於 `null` 圈內人才懂 (esoteric)，所以 Python 用 `None` 來表示。`None` 是個 object (一個 class)，`type(None)` 會得到 `<type 'NoneType'>`，在檢查是不是 `None` 時，表面上看來 `is` 跟 `==` 是一樣的，但若 class 有覆寫 comparison operator (`__eq__()`)，那 `==` 的結果就會受到影響，所以還是用 `is`/`is not` 來檢查 `None`。
  - [Python None comparison: should I use "is" or ==? \- Stack Overflow](https://stackoverflow.com/questions/14247373/) user4815162342: 引用了 PEP 8 的說法，用 `is` 比較 faster & more predictable，因為 `==` 會受到兩側運算子的影響。
  - [Programming Recommendations - PEP 8 \-\- Style Guide for Python Code \| Python\.org](https://www.python.org/dev/peps/pep-0008/#programming-recommendations) 直接寫明了 "Comparisons to singletons like None should always be done with is or is not, never the equality operators."，就是用 `is None` 或 `is not None`。
  - [Comparisons - 5\. Built\-in Types — Python 2\.7\.14 documentation](https://docs.python.org/2/library/stdtypes.html#comparisons) `is`/`is not` 用在 object identity，而 `==`/`!=` 用在 equality。
  - [Comparing things to None the wrong way — Python Anti\-Patterns documentation](https://docs.quantifiedcode.com/python-anti-patterns/readability/comparison_to_none.html) PEP 8 只是個 guideline? "It can be ignored if needed"? 但可以增加 readability。
  - [Python: "is None" vs "==None"](http://jaredgrubb.blogspot.tw/2009/04/python-is-none-vs-none.html) 作者覺得常看到 `== None` 也沒什麼問題，事實上也很少人自訂 comparison operators ... 這倒是?

### Hashable, hash(), __hash__(), PYTHONHASHSEED ??

  - [hashable - Glossary — Python 3\.7\.1rc1 documentation](https://docs.python.org/3/glossary.html#term-hashable)
      - 明確定義了 An object is hashable if it has a hash value which NEVER CHANGES DURING ITS LIFETIME (it needs a `__hash__()` method), and can be compared to other objects (it needs an `__eq__()` or `__cmp__()` method). Hashable objects which compare equal must have the same hash value. 也就是 hash value 相同不一定 equal，但 equal 的一定有相同的 hash value。
      - Hashable 表示可以做為 dictionary key 或是 set member，因為這些資料結構內部會用到 hash value。
      - All of Python’s immutable built-in objects are hashable, while no mutable containers (such as lists or dictionaries) are. 明確指出所有的 immutable built-in object 都是 hashable，但 mutable container 都不是。
      - 所有 user-defined class 雖然都是 hashable，但它的 hash value 都是來是 `id()`，所以不同 instance 一定是 unequal。
  - [hash(object) - Built\-in Functions — Python 3\.7\.1rc1 documentation](https://docs.python.org/3/library/functions.html#hash)
      - 取得 object 的 hash value (integer)；實驗發現，非 hashable 會丟出 `TypeError`，例如 `hash({})` 會丟出 `TypeError: unhashable type: 'dict'`。
      - Numeric values that compare equal have the same hash value (even if they are of different types, as is the case for 1 and 1.0). 這還滿有趣的，大概是 numeric type 的 `__hash__()` 有特別考量到數值本身。
      - For objects with custom `__hash__()` methods, note that `hash()` TRUNCATES the return value based on the bit width of the host machine. 為什麼要這麼做? 不過好像也沒差，hash 本來就不是唯一值。
  - [object.__hash__(self) - 3\. Data model — Python 3\.7\.1rc1 documentation](https://docs.python.org/3/reference/datamodel.html#object.__hash__) #ril
      - Called by built-in function `hash()` and for operations on members of hashed collections including `set`, `frozenset`, and `dict`. 看起來 hashed collections 內部並不是透過 `hash()` 取得 hash value，而是直接調用 `__hash__()`?
      - 實作上的要求很簡單，只有 "objects which compare equal have the same hash value"，提到 mix together the hash values of the components of the object that also play a part in comparison of objects by PACKING THEM INTO A TUPLE AND HASHING THE TUPLE，這招還滿直觀的，例如 `return hash((self.name, self.nick, self.color))`；因為透過 tuple 拿 hash value 的關係，也已經是被 truncate 後的版本了。
      - 接下來有一大串實作 `__hash__()` 要注意的地方 XD #ril

### New-style Class ??

  - [new-style class - Glossary — Python 2\.7\.15 documentation](https://docs.python.org/2/glossary.html#term-new-style-class) #ril

### Bound & Unbound ??

  - [super(type[, object-or-type]) - 2\. Built\-in Functions — Python 2\.7\.15 documentation](https://docs.python.org/2/library/functions.html#super) `super(type[, object-or-type])` 提到 If the second argument is omitted, the super object returned is unbound. 搭配 If the second argument is a type, `issubclass(type2, type)` must be true (this is useful for classmethods) 的說法，似乎跟 class 產生關聯就不算 unbound?

### super() ??

  - [super(type[, object-or-type]) - 2\. Built\-in Functions — Python 2\.7\.15 documentation](https://docs.python.org/2/library/functions.html#super) #ril
      - Return a PROXY OBJECT that delegates method calls to a PARENT or SIBLING class of `type`. This is useful for accessing inherited methods that have been OVERRIDDEN in a class. 看起來就是呼叫 super class method 的方法，但怎麼會跟 sibling class 有關?
      - The SEARCH ORDER is same as that used by `getattr()` except that the TYPE ITSELF IS SKIPPED. 這裡指的是找尋 "parent or sibling class" 的過程，跟 `getattr()` 一樣，會拿 `type.__mro__` (tuple of classes) 依序檢查 `isinstance(obj, type)` (若 `object-or-type` 是個 object) 或 `issubclass(type2, type)` (檢查 `type2` 是否為 `type` 的 subclass?) ==> 所以 `super(ChildClass, self)` 的用法很合理 (也很多餘，或許 Python 3 的 `super()` 會自帶這些預設值?)，但 `super(ParentClass, ChildClass)` 沒道理啊!?
  - [super([type[, object-or-type]]) - 2\. Built\-in Functions — Python 3\.7\.0 documentation](https://docs.python.org/3/library/functions.html#super) #ril
      - `super([type[, object-or-type]])` 跟 Python 2 的 `super(type[, object-or-type])` 有些微不同，在 Python 3 第一個參數 `type` 也可以省略了。
  - [Python’s super\(\) considered super\! \| Deep Thoughts by Raymond Hettinger](https://rhettinger.wordpress.com/2011/05/26/super-considered-super/) (2011-05-26) #ril
  - [Working with the Python Super Function](https://www.pythonforbeginners.com/super/working-python-super-function) (2017-02-22) #ril

