---
title: Python / Enum
---
# [Python](python.md) / Enum

  - [enum — Support for enumerations — Python 3\.7\.2 documentation](https://docs.python.org/3/library/enum.html)

      - An enumeration is a set of SYMBOLIC NAMES (MEMBERS) bound to UNIQUE, CONSTANT VALUES. Within an enumeration, the members can be COMPARED BY IDENTITY, and the enumeration itself can be ITERATED OVER.

        其中 value 不一定要是數字。這裡 compared by identity 呼應下面 members == singletons 的說法。

## 新手上路 ?? {: #getting-started }

  - [Creating an Enum - enum — Support for enumerations — Python 3\.7\.2 documentation](https://docs.python.org/3/library/enum.html#creating-an-enum)

      - Enumerations are created using the `class` syntax, which makes them easy to read and write. An alternative creation method is described in Functional API. To define an enumeration, subclass `Enum` as follows:

            >>> from enum import Enum
            >>> class Color(Enum):
            ...     RED = 1
            ...     GREEN = 2
            ...     BLUE = 3
            ...

      - Note: Enum member values -- Member values can be anything: `int`, `str`, etc.. If the exact value is unimportant you may use `auto` instances and an appropriate value will be chosen for you. Care must be taken if you mix `auto` with other values.

        對照上面 "unique, constant value" 的說法，value 只要是唯一即可，是什麼值不重要，但為何下面 Ensuring unique enumeration values 又說 By default, enumerations allow multiple names as ALIASES for the same value? 看似 alias 是例外?

            >>> class Season(Enum):
            ...     FALL = 1
            ...     AUTUMN = 1
            ...
            >>> Season.FALL == Season.AUTUMN
            True
            >>> id(Season.FALL), id(Season.AUTUMN)
            (4492624168, 4492624168) # alias 有相同的 identity
            >>> Season.FALL.name, Season.AUTUMN.name
            ('FALL', 'FALL')         # 後者是 alias，名字只有一個

      - Note: Nomenclature (術語表) -- The class `Color` is an ENUMERATION (or ENUM). The attributes `Color.RED`, `Color.GREEN`, etc., are enumeration MEMBERs (or enum members) and are functionally constants. The enum members have NAMES and VALUES (the name of `Color.RED` is `RED`, the value of `Color.BLUE` is `3`, etc.)

        也就是說 enum/enumeration = members = name + value；注意 enumeration 的說法跟 `enumerate` built-in 無關。

      - Enumeration members have HUMAN READABLE STRING REPRESENTATIONS: (含 `Color.`)

            >>> print(Color.RED)
            Color.RED

        …while their `repr` has more information:

            >>> print(repr(Color.RED))
            <Color.RED: 1>

      - The type of an enumeration member is the enumeration it belongs to:

            >>>
            >>> type(Color.RED)
            <enum 'Color'>
            >>> isinstance(Color.GREEN, Color)
            True
            >>>

      - Enum members also have a property that contains JUST THEIR ITEM NAME: (不含 `Color.`)

            >>> print(Color.RED.name)
            RED

      - Enumerations support iteration, in DEFINITION ORDER:

            >>> class Shake(Enum):
            ...     VANILLA = 7
            ...     CHOCOLATE = 4
            ...     COOKIES = 9
            ...     MINT = 3
            ...
            >>> for shake in Shake:
            ...     print(shake)
            ...
            Shake.VANILLA
            Shake.CHOCOLATE
            Shake.COOKIES
            Shake.MINT

      - Enumeration members are HASHABLE, so they can be used in dictionaries and sets:

            >>>
            >>> apples = {}
            >>> apples[Color.RED] = 'red delicious'
            >>> apples[Color.GREEN] = 'granny smith'
            >>> apples == {Color.RED: 'red delicious', Color.GREEN: 'granny smith'}
            True

  - [Programmatic access to enumeration members and their attributes - enum — Support for enumerations — Python 3\.7\.2 documentation](https://docs.python.org/3/library/enum.html#programmatic-access-to-enumeration-members-and-their-attributes)

      - Sometimes it’s useful to access members in enumerations PROGRAMMATICALLY (i.e. situations where `Color.RED` won’t do because the exact color is not known at program-writing time). Enum allows such access:

            >>> Color(1)
            <Color.RED: 1>
            >>> Color(3)
            <Color.BLUE: 3>

        傳入不對的值會丟出 `ValueError`，例如 `Color(4)` 會丟出 `ValueError: 4 is not a valid Color`。

      - If you want to access enum members by name, use ITEM ACCESS:

            >>> Color['RED']
            <Color.RED: 1>
            >>> Color['GREEN']
            <Color.GREEN: 2>

        傳入不對的 name 會丟出 `KeyError`，例如 `Color['YELLOW']` 會丟出 `KeyError: 'YELLOW'`。

        注意 by value 跟 by name 的差別在於 `Enum(value)` 或 `Enum[name]`。

      - If you have an enum member and need its name or value:

            >>> member = Color.RED
            >>> member.name
            'RED'
            >>> member.value
            1

  - [PEP 435 \-\- Adding an Enum type to the Python standard library \| Python\.org](https://www.python.org/dev/peps/pep-0435/) The PEP was accepted by Guido on May 10th, 2013 #ril

## enum34 ??

  - [How can I represent an 'Enum' in Python? \- Stack Overflow](https://stackoverflow.com/questions/36932/)
      - Alec Thomas: Enum 在 Python 3.4 加入 (PEP 435)，有個 `enum34` 的 backport 在 PyPI 上。進階的使用者可以試試 [aenum](https://pypi.python.org/pypi/aenum) (但跟 Python 3 不相容)。
  - [stoneleaf / enum34 — Bitbucket](https://bitbucket.org/stoneleaf/enum34) #ril

## Naming ??

  - [8\.13\. enum — Support for enumerations — Python 3\.5\.6 documentation](https://docs.python.org/3.5/library/enum.html) `Color.*` 在 3.5 的範例大部份都用小寫 (例如 `Color.red`)，但到了 3.6 全改用大寫了 (例如 `Color.RED`)。

## Customization ??

```
class Platform(Enum):

    IOS         = ('ios', 'iOS')
    MAC         = ('mac', 'Mac')
    APPLE_TV    = ('appletv', 'Apple TV', ('tvOS',))
    ANDROID     = ('android', 'Android')
    ANDROID_TV  = ('androidtv', 'Android TV')
    UWP         = ('uwp', 'Windows (UWP)', ('UWP',))
    WPF         = ('wpf', 'Windows (WPF)', ('WPF',))

    def __new__(cls, code, *args): # pylint: disable=unused-argument
        obj = object.__new__(cls)
        obj._value_ = code # pylint: disable=protected-access

        return obj

    def __init__(self, code, formal_name, alternative_names=None):
        self.code = code
        self.formal_name = formal_name
        self.alternative_names = alternative_names
```

---

參考資料：

  - [How are Enums different? - enum — Support for enumerations — Python 3\.7\.2 documentation](https://docs.python.org/3/library/enum.html#how-are-enums-different) 瞭解 `Enum` class 的特性，有助於理解如何自訂 `Enum` class。

      - Enums have a custom METACLASS that affects many aspects of both derived `Enum` classes and their INSTANCES (members).

      - The `EnumMeta` metaclass is responsible for providing the `__contains__()`, `__dir__()`, `__iter__()` and other methods that allow one to do things with an `Enum` class that FAIL on a typical class, such as `list(Color)` or `some_enum_var in Color`.

        `EnumMeta` is responsible for ensuring that various other methods on the final `Enum` class are correct (such as `__new__()`, `__getnewargs__()`, `__str__()` and `__repr__()`). ??

      - Enum Members (aka instances) -- The most interesting thing about `Enum` members is that they are SINGLETONS. `EnumMeta` creates them all while it is creating the `Enum` class itself, and then puts a custom `__new__()` IN PLACE to ensure that no new ones are ever instantiated by returning only the existing member instances.

  - [Allowed members and attributes of enumerations - enum — Support for enumerations — Python 3\.7\.2 documentation](https://docs.python.org/3/library/enum.html#allowed-members-and-attributes-of-enumerations) #ril

  - [Using a custom `__new__()` - enum — Support for enumerations — Python 3\.7\.2 documentation](https://docs.python.org/3/library/enum.html#using-a-custom-new)
      - Using an auto-numbering `__new__()` would look like:

            >>> class AutoNumber(NoValue):
            ...     def __new__(cls):
            ...         value = len(cls.__members__) + 1
            ...         obj = object.__new__(cls)
            ...         obj._value_ = value
            ...         return obj
            ...
            >>> class Color(AutoNumber):
            ...     RED = ()
            ...     GREEN = ()
            ...     BLUE = ()
            ...
            >>> Color.GREEN
            <Color.GREEN>
            >>> Color.GREEN.value
            2

      - Note The `__new__()` method, if defined, is used during creation of the Enum members; it is then replaced by Enum’s `__new__()` which is used after class creation for LOOKUP OF EXISTING MEMBERS. 呼應上面 "ensure that no new ones are ever instantiated" 的說法。

  - [Finer Points - enum — Support for enumerations — Python 3\.7\.2 documentation](https://docs.python.org/3/library/enum.html#finer-points)

    Supported `__dunder__` names

      - `__members__` is an `OrderedDict` of `member_name`:`member` items. It is only available on the class.
      - `__new__()`, if specified, must create and return the enum members; it is also a very good idea to set the member’s `_value_` appropriately. Once all the members are created it is NO LONGER USED.

        事實上 `__new__()` 就是要生成 member 並給定 `_value_`，自然會有 `__members__` 的對照表。

    Supported `_dunder_` names

      - `_name_` – name of the member
      - `_value_` – value of the member; can be set / modified in `__new__` 實驗發現，在 `__init__()` 才設定 `_value_` 已經來不及了。
      - `_missing_` – a LOOKUP FUNCTION used when a value is not found; may be overridden
      - `_ignore_` – a list of names, either as a `list()` or a `str()`, that will not be transformed into members, and will be removed from the final class
      - `_order_` – used in Python 2/3 code to ensure MEMBER ORDER is consistent (class attribute, removed during class creation)
      - `_generate_next_value_` – used by the Functional API and by `auto` to get an appropriate value for an enum member; may be overridden

  - [Planet - enum — Support for enumerations — Python 3\.7\.2 documentation](https://docs.python.org/3/library/enum.html#planet) #ril

  - [Enums are extensible - Karol Kuczmarski's Blog – Actually, Python enums are pretty OK](http://xion.io/post/code/python-enums-are-ok.html) #ril

## Functional API ??

  - [Functional API - enum — Support for enumerations — Python 3\.7\.2 documentation](https://docs.python.org/3/library/enum.html#functional-api) #ril

## 參考資料 {: #reference }

  - [enum — Support for enumerations](https://docs.python.org/3/library/enum.html)
  - [stoneleaf / enum34 - Bitbucket](https://bitbucket.org/stoneleaf/enum34)
  - [enum34 - PyPI](https://pypi.org/project/enum34/)

手冊：

  - [PEP 435 -- Adding an Enum type to the Python standard library | Python.org](https://www.python.org/dev/peps/pep-0435/)
