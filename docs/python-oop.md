---
title: Python / Object-oriented Programming
---
# [Python](python.md) / Object-oriented Programming

## Class ??

  - [9\. Classes — Python 3\.7\.3 documentation](https://docs.python.org/3/tutorial/classes.html) #ril

## New-style Class ??

  - [new-style class - Glossary — Python 2\.7\.16 documentation](https://docs.python.org/2/glossary.html#term-new-style-class) #ril
  - [New\-style Classes \| Python\.org](https://www.python.org/doc/newstyle/) #ril

## `super()` {: #super }

  - `super()` 的用法在 Python 3 起了一些變化：

      - Python 2: `super(type[, object-or-type])`
      - Python 3: `super([type[, object-or-type]])`

    最大的差別在於第一個參數 `type` 可以不給。

  - 以呼叫 parent class 的 constructor 為例，在 Python 3 可以寫成：

        class C(B):

            def __init__(self):
                super().__init__() # 同 super(C, self)

    但在 Python 2 一定要寫成：

        class C(B):

            def __init__(self):
                super(C, self).__init__()

---

參考資料：

  - [`super(type[, object-or-type])` - 2\. Built\-in Functions — Python 2\.7\.16 documentation](https://docs.python.org/2/library/functions.html#super)

      - Return a PROXY OBJECT that delegates method calls to a parent or SIBLING ?? class of `type`. This is useful for accessing inherited methods that have been overridden in a class.

      - The SEARCH ORDER is same as that used by `getattr()` except that THE `type` ITSELF IS SKIPPED.

        The `__mro__` attribute of the `type` lists the METHOD RESOLUTION SEARCH ORDER used by both `getattr()` and `super()`. The attribute is dynamic and can change whenever the inheritance hierarchy is updated.

      - If the second argument is omitted, the SUPER OBJECT returned is UNBOUND. If the second argument is an object, `isinstance(obj, type)` must be true. If the second argument is a type, `issubclass(type2, type)` must be true (this is useful for classmethods).

        如果 search order 都看 `type.__mro__`，為什麼還要有 `isinstance(obj, type)` 或 `issubclass(type2, type)` 這一層檢查 ??

      - Note `super()` only works for NEW-STYLE CLASSES.

      - There are two typical use cases for `super`. In a class hierarchy with SINGLE INHERITANCE, `super` can be used to refer to parent classes WITHOUT NAMING THEM EXPLICITLY, thus making the code more MAINTAINABLE. This use closely parallels the use of `super` in other programming languages.

        其中 "without naming them explicit" 似乎指 `type` 參數不用給，但語法上第一個參數是不能省的，這說法似乎只適用 Python 3 ??

      - The second use case is to support COOPERATIVE MULTIPLE INHERITANCE in a dynamic execution environment. This use case is UNIQUE TO PYTHON and is not found in statically compiled languages or languages that only support single inheritance.

        This makes it possible to implement “DIAMOND DIAGRAMS” where multiple base classes implement the same method. Good design DICTATES that this method have the SAME CALLING SIGNATURE in every case (because the order of calls is determined at runtime, because that order adapts to changes in the class hierarchy, and because that order can include sibling classes that are unknown prior to runtime). ??

      - For both use cases, a typical superclass call looks like this:

            class C(B):
                def method(self, arg):
                    super(C, self).method(arg) # 這就是麻煩的地方，在 `class C` 裡還要寫 `super(C)`

      - Note that `super()` is implemented as part of the BINDING PROCESS for explicit dotted attribute lookups such as `super().__getitem__(name)`. It does so by implementing its own `__getattribute__()` method for searching classes in a PREDICTABLE ORDER that supports cooperative multiple inheritance. Accordingly, `super()` is undefined for IMPLICIT LOOKUPS using statements or operators such as `super()[name]`. ??

        Also note that `super()` is not limited to use INSIDE METHODS. The two argument form specifies the arguments exactly and makes the appropriate references. ??

        For practical suggestions on how to design cooperative classes using `super()`, see [guide to using `super()`](https://rhettinger.wordpress.com/2011/05/26/super-considered-super/).

  - [`super([type[, object-or-type]])` - Built\-in Functions — Python 3\.7\.3 documentation](https://docs.python.org/3/library/functions.html#super) 大部份的說法都同 Python 2，但很明顯第一個參數在 Python 3 也可以省略了!

      - For both use cases, a typical superclass call looks like this:

            class C(B):
                def method(self, arg):
                    super().method(arg)    # This does the same thing as:
                                           # super(C, self).method(arg)

        省略所有參數的做法，竟然藏在範例裡。

      - Also note that, aside from the ZERO ARGUMENT FORM, `super()` is not limited to use INSIDE METHODS. ??

        The two argument form specifies the arguments exactly and makes the appropriate references.

      - The zero argument form only works inside a class definition, as the COMPILER fills in the necessary details to correctly retrieve the class being defined, as well as accessing the current instance for ordinary methods.

        語法上的甜頭，因為 compiler 幫忙做掉了一些事。

  - [Supercharge Your Classes With Python super\(\) – Real Python](https://realpython.com/python-super/) (2019-02-12) #ril

## Class Method ??

  - Class method 可以用來實現 alternate constructor，提供除 `__init__()` 之外更彈性的建構方式，例如：

        class Date:

            def __init__(self, year, month, day):
                self.year, self.month, self.day = year, month, day

            @classmethod
            def from_str(cls, date_str):
                year, month, day = map(int, date_str.split('-'))
                return cls(year, month, day)

    用起來像這樣：

        >>> date = Date.from_str('2019-05-03')
        >>> date.year, date.month, date.day
        (2019, 5, 3)

---

參考資料：

  - [Python's Instance, Class, and Static Methods Demystified – Real Python](https://realpython.com/instance-class-and-static-methods-demystified/) (2017-03-29) #ril

  - [`@staticmethod` - Built\-in Functions — Python 3\.7\.3 documentation](https://docs.python.org/3/library/functions.html#staticmethod)

      - Also see `classmethod()` for a variant that is useful for creating ALTERNATE CLASS CONSTRUCTORS.

  - [`@classmethod` - Built\-in Functions — Python 3\.7\.3 documentation](https://docs.python.org/3/library/functions.html#classmethod) #ril

  - [Python and multiple constructors \| Erol\.si](https://www.erol.si/2016/01/python-and-multiple-constructors/) (2016-01-17) #ril
  - [Python: Class methods \- alternative constructor](https://code-maven.com/slides/python-programming/class-methods-alternative-constructor) 用 `from_str()` 做說明 #ril
  - [What is a clean, pythonic way to have multiple constructors in Python? \- Stack Overflow](https://stackoverflow.com/questions/682504/) #ril

## Static Method

  - Static method 的使用時機是為 helper method 提供一個 namespace，可以是 utility class 的一個 method，也可以是 class 內部的 helper。
  - 因為 static method 不會拿到 `cls`/`self`，所以無法取用/變更 state；這個特性也成為一個 hint -- 設計為 static method 就是希望它都不要碰到 state。

---

參考資料：

  - [`@staticmethod` - Built\-in Functions — Python 3\.7\.3 documentation](https://docs.python.org/3/library/functions.html#staticmethod)

      - Transform a method into a static method.

      - A static method does not receive an IMPLICIT FIRST ARGUMENT. To declare a static method, use this idiom:

            class C:
                @staticmethod
                def f(arg1, arg2, ...): ...

        The `@staticmethod` form is a function decorator – see Function definitions for details.

      - A static method can be called either on the class (such as `C.f()`) or on an instance (such as `C().f()`).

        不過 Java 的 static method 不能透過 instance 呼叫。

      - Static methods in Python are similar to those found in Java or C++. Also see `classmethod()` for a variant that is useful for creating ALTERNATE CLASS CONSTRUCTORS.

      - Like all decorators, it is also possible to call `staticmethod` as a regular function and do something with its result. This is needed in some cases where you need a reference to a function from a class body and you want to avoid the AUTOMATIC TRANSFORMATION TO INSTANCE METHOD ??. For these cases, use this idiom:

            class C:
                builtin_open = staticmethod(open)

      - For more information on static methods, see The [standard type hierarchy](https://docs.python.org/3/reference/datamodel.html#types). #ril

  - [Python's Instance, Class, and Static Methods Demystified – Real Python](https://realpython.com/instance-class-and-static-methods-demystified/) (2017-03-29)

        class MyClass:
            def method(self):
                return 'instance method called', self

            @classmethod
            def classmethod(cls):
                return 'class method called', cls

            @staticmethod
            def staticmethod():
                return 'static method called'

    Static Methods

      - The third method, `MyClass.staticmethod` was marked with a `@staticmethod` decorator to flag it as a static method. This type of method takes neither a `self` nor a `cls` parameter (but of course it’s free to accept an arbitrary number of other parameters).

      - Therefore a static method can NEITHER MODIFY OBJECT STATE NOR CLASS STATE. Static methods are restricted in what data they can access - and they’re primarily a way to NAMESPACE YOUR METHODS.

        指放在某個 class 底下。由於不能存取 object/class state 的關係，運算需要用到的資料都來自參數。

    Let’s See Them In Action!

      - Time to call the static method now:

            >>> obj = MyClass()
            >>> obj.staticmethod()
            'static method called'

      - Did you see how we called `staticmethod()` on the OBJECT and were able to do so successfully? Some developers are SURPRISED when they learn that it’s possible to call a static method on an object instance. 確實有點意外!!

        Behind the scenes Python simply enforces the access restrictions by NOT PASSING IN the `self` or the `cls` argument when a static method gets called using the dot syntax.

      - This confirms that static methods can neither access the object instance state nor the class state. They work like regular functions BUT BELONG TO THE CLASS’S (AND EVERY INSTANCE’S) NAMESPACE.

      - Now, let’s take a look at what happens when we attempt to call these methods on the class itself - without creating an object instance beforehand:

            >>> MyClass.classmethod()
            ('class method called', <class MyClass at 0x101a2f4c8>)

            >>> MyClass.staticmethod()
            'static method called'

        We were able to call `classmethod()` and `staticmethod()` just fine, but attempting to call the instance method `method()` failed with a `TypeError`.

    When To Use Static Methods

      - It’s a little more difficult to come up with a good example here. But tell you what, I’ll just keep stretching the pizza analogy thinner and thinner… (yum!) Here’s what I came up with:

            import math

            class Pizza:
                def __init__(self, radius, ingredients):
                    self.radius = radius
                    self.ingredients = ingredients

                def __repr__(self):
                    return (f'Pizza({self.radius!r}, '
                            f'{self.ingredients!r})')

                def area(self):
                    return self.circle_area(self.radius)

                @staticmethod
                def circle_area(r):
                    return r ** 2 * math.pi

      - Now what did I change here? First, I modified the constructor and `__repr__` to accept an extra `radius` argument.

        I also added an `area()` instance method that calculates and returns the pizza’s area (this would also be a good candidate for an `@property` — but hey, this is just a toy example).

        Instead of calculating the area directly within `area()`, using the well-known circle area formula, I FACTORED THAT OUT to a separate `circle_area()` static method. 感覺很適合用在內部實作??

            >>> p = Pizza(4, ['mozzarella', 'tomatoes'])
            >>> p
            Pizza(4, ['mozzarella', 'tomatoes'])
            >>> p.area()
            50.26548245743669
            >>> Pizza.circle_area(4)
            50.26548245743669

      - As we’ve learned, static methods can’t access class or instance state because they don’t take a `cls` or `self` argument. That’s a BIG LIMITATION — but it’s also a great SIGNAL to show that a particular method is INDEPENDENT FROM EVERYTHING ELSE AROUND IT. 重點是 "語意"

        In the above example, it’s clear that `circle_area()` can’t modify the class or the class instance in any way. (Sure, you could always work around that with a global variable but that’s not the point here.)

      - Now, why is that useful? Flagging a method as a static method is not just a HINT that a method won’t modify class or instance state — this restriction is also enforced by the Python runtime.

        Techniques like that allow you to communicate clearly about parts of your class architecture so that new development work is naturally guided to happen within these set boundaries. Of course, it would be easy enough to defy these restrictions. But in practice they often help AVOID ACCIDENTAL MODIFICATIONS going against the original design.

      - Put differently, using static methods and class methods are ways to COMMUNICATE DEVELOPER INTENT while enforcing that intent enough to avoid most slip of the mind mistakes and bugs that would break the design.

        Applied SPARINGLY and when it makes sense, writing some of your methods that way can provide maintenance benefits and make it less likely that other developers use your classes incorrectly.

        很適合用在只有 class 內部會用到的 helper method，不用擔心它會動到 state。

      - Static methods also have benefits when it comes to writing test code. Because the `circle_area()` method is completely independent from the rest of the class it’s much easier to test.

        We don’t have to worry about setting up a complete class instance before we can test the method in a unit test. We can just fire away like we would testing a regular function. Again, this makes future maintenance easier.

        不過話說回來，這不應該透過 public instance method 來測嗎?

    Key Takeaways

      - Static methods don’t have access to `cls` or `self`. They work like regular functions but belong to the class’s namespace.
      - Static and class methods communicate and (to a certain degree) enforce developer intent about CLASS DESIGN. This can have maintenance benefits.

  - [Overriding a static method in python \- Stack Overflow](https://stackoverflow.com/questions/893015/) #ril

