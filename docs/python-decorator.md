---
title: Python / Decorator
---
# [Python](python.md) / Decorator

  - [Glossary — Python 3\.7\.3 documentation](https://docs.python.org/3/glossary.html#term-decorator)

      - A function RETURNING ANOTHER FUNCTION, usually applied as a FUNCTION TRANSFORMATION using the `@wrapper` syntax. Common examples for decorators are `classmethod()` and `staticmethod()`.

        包含 decorator 自己，共有 3 個 function；而 decorator 的 input 跟 output 都是 function，通常是用 output function (outer) 將 input function (inner) 包裝一層，未來呼叫 outer function 時會間接呼叫 inner function，其間就是 decorator 可以安插一些邏輯的地方。

        [Can Python decorators be used to return non\-function objects? \- Stack Overflow](https://stackoverflow.com/questions/20791056/)

      - The decorator syntax is merely SYNTACTIC SUGAR, the following two function definitions are semantically equivalent:

            def f(...):
                ...
            f = staticmethod(f)

            @staticmethod
            def f(...):
                ...

      - The same concept exists for classes, but is LESS COMMONLY USED THERE. See the documentation for function definitions and class definitions for more about decorators.

## 新手上路 {: #getting-started }

```
>>> def plus_five(func):
...     x = func()
...     return x + 5
...
>>> @plus_five
... def add_nums():
...     return 1 + 2
...
>>> type(add_nums) # <1>
<type 'int'>
>>> type(add_nums), add_nums
(<type 'int'>, 8)
```

 1. `add_nums` 的型態竟是 `int`。那是因為過程中已經發生 `add_nums = plus_five(add_nums)` 這件事，結果 `add_nums` 就是一個運算結果，而非包裝過一層的 function。

解法就是 `plus_five` 回傳一個 function 而非運算結果：

```
>>> def plus_five(func):
...     def inner(*args, **kwargs):
...         x = func(*args, **kwargs) + 5
...         return x
...     return inner
...
>>> @plus_five
... def add_nums(num1, num2):
...     return num1 + num2
>>> type(add_nums), add_nums
(<type 'function'>, <function inner at 0x7ff8b2e0c668>)
>>>
```

用 class 來寫的彈性比較大：

`deco.py`:

```
class decoargs():

    def __init__(self, arg):
        self.arg = arg

    def __call__(self, func):

        def wrapper(*args, **kwargs):
            print '[%s] before' % self.arg
            result = func(*args, **kwargs)
            print '[%s] after' % self.arg
            return result

        return wrapper

@decoargs('hello1')
def calc1(a, b):
    print '----------> calc1'
    return a + b

decoargs = decoargs('hello2')

@decoargs
def calc2(a, b):
    print '----------> calc2'
    return a + b

print calc1(1, 1)
print calc2(2, 2)
```

Python/Jython 都支援這樣的用法：

```
$ python deco.py
[hello1] before
----------> calc1
[hello1] after
2
[hello2] before
----------> calc2
[hello2] after
4

$ jython deco.py
[hello1] before
----------> calc1
[hello1] after
2
[hello2] before
----------> calc2
[hello2] after
4
```

---

參考資料：

  - [Function definitions - 8\. Compound statements — Python 3\.7\.3 documentation](https://docs.python.org/3/reference/compound_stmts.html#function-definitions)

        funcdef                 ::=  [decorators] "def" funcname "(" [parameter_list] ")"
                                     ["->" expression] ":" suite
        decorators              ::=  decorator+
        decorator               ::=  "@" dotted_name ["(" [argument_list [","]] ")"] NEWLINE

      - A function definition may be wrapped by one or more DECORATOR EXPRESSIONS. Decorator expressions are EVALUATED WHEN THE FUNCTION IS DEFINED, in the scope that contains the function definition.

        The RESULT MUST BE A CALLABLE, which is invoked with the FUNCTION OBJECT as THE ONLY ARGUMENT. The RETURNED VALUE is bound to the function name INSTEAD OF THE FUNCTION OBJECT.

        下面 `func = f1(arg)(f2(func))` 的說法，呼應了 "evaluated when the function is defined" 的說法，許多 function 的呼叫會發生在 import time。

        廣義上來說，"a function returning another function" 可以視為 "a callable returning another callable"，只要該 callable 接受單一個 callable 做為參數即可；而 class 也是 callable，也就是 class 也可以用來實作 decorator。

      - Multiple decorators are applied IN NESTED FASHION. For example, the following code

            @f1(arg)
            @f2
            def func(): pass

        is roughly equivalent to

            def func(): pass
            func = f1(arg)(f2(func))

        except that the original function is not TEMPORARILY bound to the name `func`.

        由內往外，最接近 function definition 那層會接到 function object，外層則會接到下一層回傳的結果 (return value)... 注意 decorator 也可以有自己的參數，例如 `f1(arg)(...)`。

  - [Class definitions - 8\. Compound statements — Python 3\.7\.3 documentation](https://docs.python.org/3/reference/compound_stmts.html#class-definitions)

        classdef    ::=  [decorators] "class" classname [inheritance] ":" suite

      - Classes can also be decorated: just like when decorating functions,

            @f1(arg)
            @f2
            class Foo: pass

        is roughly equivalent to

            class Foo: pass
            Foo = f1(arg)(f2(Foo))

      - The evaluation rules for the decorator expressions are the same as for function decorators. The result is then bound to the class name.

  - [The best explanation of Python decorators I’ve ever seen\. \(An archived answer from StackOverflow\.\)](https://gist.github.com/Zearin/2f40b7b9cfc51132851a) #ril
  - [Decorators - Python syntax and semantics \- Wikipedia](https://en.wikipedia.org/wiki/Python_syntax_and_semantics#Decorators) #ril
  - [Primer on Python Decorators – Real Python](https://realpython.com/primer-on-python-decorators/) (2018-08-22) #ril
  - [Decorators I: Introduction to Python Decorators](https://www.artima.com/weblogs/viewpost.jsp?thread=240808) (2008-10-18) #ril
  - [Python Decorators II: Decorator Arguments](https://www.artima.com/weblogs/viewpost.jsp?thread=240845) (2008-10-19) #ril
  - [Python Decorators III: A Decorator\-Based Build System](https://www.artima.com/weblogs/viewpost.jsp?thread=241209) (2008-10-26) #ril
  - [micheles/decorator: decorator](https://github.com/micheles/decorator) 內建許多可以簡化 decorators 開發的工具 #ril
  - [PythonDecorators \- Python Wiki](https://wiki.python.org/moin/PythonDecorators) #ril
  - [PythonDecoratorLibrary \- Python Wiki](https://wiki.python.org/moin/PythonDecoratorLibrary) #ril
  - [Function Decorators - Chapter 4: Defining Functions and Using Built\-ins — Jython Book v1\.0 documentation](https://www.jython.org/jythonbook/en/1.0/DefiningFunctionsandUsingBuilt-Ins.html#function-decorators) #ril
  - [simeonfranklin\.com \- Understanding Python Decorators in 12 Easy Steps\!](http://simeonfranklin.com/blog/2012/jul/1/python-decorators-in-12-steps/) (2012-07-01) #ril
  - [Python Decorators \| Python Conquers The Universe](https://pythonconquerstheuniverse.wordpress.com/2012/04/29/python-decorators/) (2012-04-29) #ril
  - [Python Decorators Don't Have to be \(that\) Scary \- Siafoo](http://www.siafoo.net/article/68) (2010-03-17) #ril
  - [Introduction to Python Decorators \| Python Conquers The Universe](https://pythonconquerstheuniverse.wordpress.com/2009/08/06/introduction-to-python-decorators-part-1/) (2009-08-06) #ril
  - [python \- How to make a chain of function decorators? \- Stack Overflow](https://stackoverflow.com/questions/739654/) #ril
  - [Python 2\.4 Decorators \| Dr Dobb's](http://www.drdobbs.com/web-development/python-24-decorators/184406073) (2005-03-01) #ril

## 不傳回 callable 可以嗎？ {: #not-returning-callable }

  - 根據 [Function definitions - 8\. Compound statements — Python 3\.7\.3 documentation](https://docs.python.org/3/reference/compound_stmts.html#function-definitions) 的說法：

    > Multiple decorators are applied in nested fashion. For example, the following code
    >
    >     @f1(arg)
    >     @f2
    >     def func(): pass
    >
    > is roughly equivalent to
    >
    >     def func(): pass
    >     func = f1(arg)(f2(func))
    >
    > except that the original function is not temporarily bound to the name `func`.

    `f1()` 傳回 non-function 沒什麼問題，但 `f2()` 傳回 non-function 可能就會讓預期收到 function 的外層 (`f1`) 出錯。

    這跟 [Can Python decorators be used to return non\-function objects? \- Stack Overflow](https://stackoverflow.com/a/20791175/1691598) 中 mgilson 的想法/擔憂一致：

    > However, doing so would be TERRIBLY UNCLEAR. People expect function decorators to return functions (or at least callable objects) and class decorators to return classes. If you stray from that pattern, DO SO AT YOUR OWN RISK

---

參考資料：

  - [Can Python decorators be used to return non\-function objects? \- Stack Overflow](https://stackoverflow.com/questions/20791056/) #ril

      - mgilson: To quote PEP 0318:

        The current syntax for function decorators as implemented in Python 2.4a2 is:

            @dec2
            @dec1
            def func(arg1, arg2, ...):
                pass

        This is equivalent to:

            def func(arg1, arg2, ...):
                pass
            func = dec2(dec1(func))

        without the INTERMEDIATE ASSIGNMENT to the variable `func`.

        So, to answer your question, you CAN have a decorator return something which isn't a function and the behavior is COMPLETELY DEFINED. Otherwise, it wouldn't be equivalent to the code above.

        However, doing so would be TERRIBLY UNCLEAR. People expect function decorators to return functions (or at least callable objects) and class decorators to return classes. If you stray from that pattern, DO SO AT YOUR OWN RISK -- If your neighbor decides to knock down your cubicle out of anger and frustration, that's your problem :).

## 參考資料 {: #reference }

手冊：

  - [PEP 318 -- Decorators for Functions and Methods | Python.org](https://www.python.org/dev/peps/pep-0318/)
  - [PEP 3129 -- Class Decorators | Python.org](https://www.python.org/dev/peps/pep-3129/)
