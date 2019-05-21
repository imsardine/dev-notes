---
title: Python / Exception Handling
---
# [Python](python.md) / Exception Handling

  - [8\. Errors and Exceptions — Python 3\.6\.5 documentation](https://docs.python.org/3/tutorial/errors.html) #ril
  - [8\. Errors and Exceptions — Python 2\.7\.15 documentation](https://docs.python.org/2.7/tutorial/errors.html) #ril
  - [HandlingExceptions \- Python Wiki](https://wiki.python.org/moin/HandlingExceptions) #ril
  - [Write Cleaner Python: Use Exceptions](https://jeffknupp.com/blog/2013/02/06/write-cleaner-python-use-exceptions/) (2013-02-06) #ril
  - [Programming Recommendations - PEP 8 \-\- Style Guide for Python Code \| Python\.org](https://www.python.org/dev/peps/pep-0008/#programming-recommendations) 提到一堆 exception 相關注意事項 #ril

## Built-in Exception ??

  - [Built\-in Exceptions — Python 3\.7\.1 documentation](https://docs.python.org/3/library/exceptions.html) #ril
      - Except where mentioned, they have an “associated value” indicating the detailed cause of the error. This may be a string or a tuple of several items of information (e.g., an error code and a string explaining the code). The associated value is usually passed as arguments to the exception class’s constructor.
      - Programmers are encouraged to derive new exceptions from the `Exception` class or one of its subclasses, and not from `BaseException`.
      - `BaseException` 是所有 built-in exception 的 base class，它的 `__str__()` 會回傳 "the representation of the argument(s) to the instance"。這裡解釋了 `args` -- The tuple of arguments given to the exception constructor. Some built-in exceptions (like `OSError`) expect a certain number of arguments and assign a special meaning to the elements of this tuple, while others are usually called only with A SINGLE STRING GIVING AN ERROR MESSAGE. 最常見的用法就是單一個 error messsage。
  - [Exception hierarchy - Built\-in Exceptions — Python 3\.7\.1 documentation](https://docs.python.org/3/library/exceptions.html#exception-hierarchy) #ril
  - [Exception hierarchy - 6\. Built\-in Exceptions — Python 2\.7\.15 documentation](https://docs.python.org/2/library/exceptions.html#exception-hierarchy) #ril

## 如何選用 Exception {: #choice }

  - [`logging.basicConfig(**kwargs)` - logging — Logging facility for Python — Python 3\.7\.3 documentation](https://docs.python.org/3/library/logging.html#logging.basicConfig) - `stream` - ... Note that this argument is incompatible with `filename` - if both are present, a `ValueError` is raised. 看來只要 input 不對，都可以丟 `ValueError`。

## Exception Chaining ??

  - [Programming Recommendations - PEP 8 \-\- Style Guide for Python Code \| Python\.org](https://www.python.org/dev/peps/pep-0008/#programming-recommendations)

      - Use EXCEPTION CHAINING appropriately. In Python 3, `raise X from Y` should be used to indicate explicit replacement without losing the original traceback.

        Python 2 要怎麼做 ??

      - When deliberately REPLACING an inner exception (using "raise X" in Python 2 or "raise X from None" in Python 3.3+), ensure that relevant details are transferred to the new exception (such as preserving the attribute name when converting `KeyError` to `AttributeError`, or embedding the text of the original exception in the new exception message).

  - [Built\-in Exceptions — Python 3\.7\.1 documentation](https://docs.python.org/3/library/exceptions.html) 一開始就提到 `raise new_exc from original_exc` 的用法，跟 `__cause__` 有關 #ril
  - [Wrapping Exceptions - The definitive guide to Python exceptions](https://julien.danjou.info/python-exceptions-guide/#wrappingexceptions) (2016-08-11) #ril

## Exception Hierarchy ??

  - [User-defined Exceptions - 8\. Errors and Exceptions — Python 3\.7\.1 documentation](https://docs.python.org/3/tutorial/errors.html#user-defined-exceptions) When creating a MODULE that can raise several distinct errors, a common practice is to create a BASE CLASS for exceptions defined by that module, and subclass that to create specific exception classes for different error conditions 也就是 application/library 的 exception hierarhcy 會自成一個體系；下面 exception hierarchy 的例子，root 是 `Error(Exception)`，這名稱還滿直覺的 (已在 module 下，不用再寫明 context)。
  - [Organization - The definitive guide to Python exceptions](https://julien.danjou.info/python-exceptions-guide/#organization) (2016-08-11) Library 可以把 exceptions 集中在一個檔案，但 application 則建議按子系統拆開 #ril

  - [The exceptions module](http://effbot.org/librarybook/exceptions.htm) #ril
  - [Python 2's \`exceptions\` module is missing in Python3, where did its contents go? \- Stack Overflow](https://stackoverflow.com/questions/27030933/) #ril
  - [python \- Is it better to have many specified exceptions or some general that are raised with specified description? \- Software Engineering Stack Exchange](https://softwareengineering.stackexchange.com/questions/343262/) 9000: 提到 library/module 要有 umbrella exception class 的概念 #ril

可供參考的實作：

  - [requests/exceptions\.py at master · requests/requests](https://github.com/requests/requests/blob/master/requests/exceptions.py)
  - [pylint/exceptions\.py at master · PyCQA/pylint](https://github.com/PyCQA/pylint/blob/master/pylint/exceptions.py)
  - [sqlalchemy/exc\.py at master · zzzeek/sqlalchemy](https://github.com/zzzeek/sqlalchemy/blob/master/lib/sqlalchemy/exc.py) #ril
  - [boto3/exceptions\.py at develop · boto/boto3](https://github.com/boto/boto3/blob/develop/boto3/exceptions.py)
  - [Search · filename:exceptions\.py](https://github.com/search?p=3&q=filename%3Aexceptions.py&type=Code) GitHub 上面好多 `exceptions.py` 裡一起宣告不同的 exceptions，形成一個 hierarchy。
  - [mkdocs/exceptions\.py at master · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/blob/master/mkdocs/exceptions.py)
  - [scrapy/exceptions\.py at master · scrapy/scrapy](https://github.com/scrapy/scrapy/blob/master/scrapy/exceptions.py)

## User-defined Exception ??

  - [User-defined Exceptions - 8\. Errors and Exceptions — Python 3\.7\.1 documentation](https://docs.python.org/3/tutorial/errors.html#user-defined-exceptions)

      - Programs may name their own exceptions by creating a new exception class (see Classes for more about Python classes). Exceptions should typically be derived from the `Exception` class, either directly or indirectly.

        Exception classes can be defined which do anything any other class can do, but are usually KEPT SIMPLE, often only offering a number of ATTRIBUTES that allow INFORMATION ABOUT THE ERROR to be extracted by handlers for the exception.

      - When creating a module that can raise several distinct errors, a common practice is to create A BASE CLASS FOR EXCEPTIONS DEFINED BY THAT MODULE, and subclass that to create specific exception classes for different error conditions:

            class Error(Exception):
                """Base class for exceptions in this module."""
                pass

            class InputError(Error):
                """Exception raised for errors in the input.

                Attributes:
                    expression -- input expression in which the error occurred
                    message -- explanation of the error
                """

                def __init__(self, expression, message):
                    self.expression = expression
                    self.message = message

            class TransitionError(Error):
                """Raised when an operation attempts a state transition that's not
                allowed.

                Attributes:
                    previous -- state at beginning of transition
                    next -- attempted new state
                    message -- explanation of why the specific transition is not allowed
                """

                def __init__(self, previous, next, message):
                    self.previous = previous
                    self.next = next
                    self.message = message

        Most exceptions are defined with names that end in `Error`, similar to the naming of the standard exceptions.

        確實，在 [Exception hierarchy](https://docs.python.org/3/library/exceptions.html#exception-hierarchy) 裡除了 `BaseException` 與 `Exception` 外，所有 exception 的命名都以 `Error` 或 `Warning` 結尾。其中 base error 就叫做 `Error`，剛好 Exception Hierarchy 裡沒有用到 `Error`。

        沒有特別的要求? 從範例看來 attribute 確實很多樣，其中 `message` attribute 是通用的? 不用考慮 `Exception` 的 `__init__()`?? 也不用實作 `__str__()` ??

      - Many standard modules define THEIR OWN EXCEPTIONS to report errors that may occur in functions they define. More information on classes is presented in chapter Classes.

        Module 就該定義自己的 exception 了，不一定要到 package。

  - [Handling Exceptions - 8\. Errors and Exceptions — Python 3\.7\.3 documentation](https://docs.python.org/3/tutorial/errors.html#handling-exceptions)

      - The `except` clause may specify a variable after the exception name. The variable is bound to an exception instance with the arguments stored in `instance.args`.

        For convenience, the exception instance defines `__str__()` so the arguments can be printed directly without having to reference `.args`."

            >>> try:
            ...     raise Exception('spam', 'eggs')
            ... except Exception as inst:
            ...     print(type(inst))    # the exception instance
            ...     print(inst.args)     # arguments stored in .args
            ...     print(inst)          # __str__ allows args to be printed directly,
            ...                          # but may be overridden in exception subclasses
            ...     x, y = inst.args     # unpack args
            ...     print('x =', x)
            ...     print('y =', y)
            ...
            <class 'Exception'>
            ('spam', 'eggs')
            ('spam', 'eggs')
            x = spam
            y = eggs

        這說明了 built-in exception 一定會有 `.args`，且 `__str__()` 預設的行為就會把 arguments 全部印出。

  - [User-defined Exceptions - 8\. Errors and Exceptions — Python 2\.7\.15 documentation](https://docs.python.org/2/tutorial/errors.html#user-defined-exceptions) 說法跟 Python 3 的文件有些差異

      - Programs may name their own exceptions by creating a new exception class (see Classes for more about Python classes). Exceptions should typically be derived from the `Exception` class, either directly or indirectly. For example:

            >>> class MyError(Exception):
            ...     def __init__(self, value):
            ...         self.value = value
            ...     def __str__(self):
            ...         return repr(self.value)
            ...
            >>> try:
            ...     raise MyError(2*2)
            ... except MyError as e:
            ...     print 'My exception occurred, value:', e.value
            ...
            My exception occurred, value: 4
            >>> raise MyError('oops!')
            Traceback (most recent call last):
              File "<stdin>", line 1, in <module>
            __main__.MyError: 'oops!'

        In this example, the default `__init__()` of `Exception` has been overridden. The new behavior simply creates the `value` attribute. This replaces the default behavior of creating the `args` attribute.

        另外也實作了 `__str_()`，為什麼都不考慮呼叫 `Exception.__init__()` ??

  - [PEP 8 \-\- Style Guide for Python Code \| Python\.org](https://www.python.org/dev/peps/pep-0008/)

    Exception Names

      - Because exceptions should be classes, the class naming convention applies here. However, you should use the suffix `Error` on your exception names (IF the exception actually is an error).

        這裡埋下了 exception 不一定是 error 的伏筆。

    Programming Recommendations

      - Derive exceptions from `Exception` rather than `BaseException`. Direct inheritance from `BaseException` is reserved for exceptions where catching them is almost always the wrong thing to do.

        `BaseException` 不該被 cache? 猜想是針對它直屬 subclass 的說法 -- 包括 `SystemExit`、`KeyboardInterrupt`、`GeneratorExit` 跟 `Exception`，也難怪 `except Exception` 的用法會被 Pylint 警告 `broad-except`。

      - Design exception hierarchies BASED ON THE DISTINCTIONS THAT CODE CATCHING THE EXCEPTIONS IS LIKELY TO NEED, rather than the locations where the exceptions are raised. Aim to answer the question "WHAT WENT WRONG?" programmatically, rather than only stating that "A problem occurred" (see PEP 3151 for an example of this lesson being learned for the builtin exception hierarchy)

      - Class naming conventions apply here, although you should add the suffix `Error` to your exception classes if the exception is an error. Non-error exceptions that are used for NON-LOCAL FLOW CONTROL or other forms of signaling need no special suffix.

        原來有 non-error exception 這種用法 ??

  - [Getting Useful Information from an Exception - HandlingExceptions \- Python Wiki](https://wiki.python.org/moin/HandlingExceptions#Getting_Useful_Information_from_an_Exception)

      - The `.args` attribute of exceptions is a tuple of all the arguments that were passed in (typically the one and only argument is the error message). This way you can modify the arguments and re-raise, and the extra information will be displayed. You could also put a print statement or logging in the `except` block.

            try:
                a, b, c = d
            except Exception as e:
                e.args += (d,)
                raise

        這裡改動 `args` 再 `reraise` 的做法真怪!?

      - Note that not all exceptions subclass `Exception` (though almost all do), so this might not catch some exceptions;

        also, exceptions aren't required to have an `.args` attribute (though it will if the exception subclasses `Exception` and DOESN'T OVERRIDE `__init__` WITHOUT CALLING ITS SUPERCLASS), so the code as written might fail but in practice it almost never does (and if it does, you should fix the non-conformant exception!)

        說明了自訂 exception 應該要呼叫 `Exception.__init__()`，雖然不一定有 `.args`，但應該要有的。

  - [exception Exception - Built\-in Exceptions — Python 3\.7\.1 documentation](https://docs.python.org/3/library/exceptions.html#Exception)

      - All built-in, NON-SYSTEM-EXITING exceptions are derived from this class. All user-defined exceptions should also be derived from this class.

        從 non-system-exiting 這個定位，可以理解為何自訂的 exception 都必須繼承自它。

  - [requests/exceptions\.py at master · requests/requests](https://github.com/requests/requests/blob/master/requests/exceptions.py)
      - 所有的 exception/warning 分別繼承自 `RequestException(IOError)` 與 `RequestsWarning(Warning)`。
      - `RequestException` 的 constructor 採 `__init__(self, *args, **kwargs)`，中間會用 `kwargs.pop('xxx', None)` 把部份的 keyword arguments 取出，最後會呼叫 `super(RequestException, self).__init__(*args, **kwargs)`
      - `MissingSchema(RequestException, ValueError)` 除了 `RequestException` 外還繼承其他 class 的狀況並不少見。

  - [sqlalchemy/exc\.py at master · zzzeek/sqlalchemy](https://github.com/zzzeek/sqlalchemy/blob/master/lib/sqlalchemy/exc.py)
      - 所有的 exception 都繼承自 `SQLAlchemyError(Exception)`。
      - `SQLAlchemyError` 的 constructor 採 `__init__(self, *arg, **kw)`，中間會用 `kw.pop('xxx', None)` 把部份的 keyword argument 取出，最後會呼叫 `super(SQLAlchemyError, self).__init__(*arg, **kw)`，還自訂 `__str__(self)` (會操作到 `Exception.args`)，會額外附加 error code 及對應的文件 URL。

  - [ValidationError - wtforms/validators\.py at master · wtforms/wtforms](https://github.com/wtforms/wtforms/blob/master/src/wtforms/validators.py#L50) `ValidationError(ValueError)` 的 `__init__(self, message="", *args, **kwargs)` 單純呼叫 `ValueError.__init__(self, message, *args, **kwargs)` 因為第一個 positional argument 是 message??

  - [Subclassing Exceptions and Other Fancy Things - Writing and Using Custom Exceptions in Python \| Codementor](https://www.codementor.io/sheena/how-to-write-python-custom-exceptions-du107ufv9#subclassing-exceptions-and-other-fancy-things) (2015-05-26)
      - 這裡也出現 `Exception.__init__(self,*args,**kwargs)` 的寫法。
      - `Exception.__init__(self,"my exception was raised with arguments {0}".format(dErrArguments))` 感覺對 `Exception.__init__()` 的第一個參數做了假設?
      - The fact that it is `anOhMyGoodnessExc` doesn't matter much─what we care about is the message. 事先定義了不同的 `oh_my_goodness = Exception("well, that rather badly didnt it?")`，視不同的情況再 raise ... 有點特別的用法。

  - [How to Define Custom Exceptions in Python? \(With Examples\)](https://www.programiz.com/python-programming/user-defined-exception)
      - using the `raise` statement with an optional error message. 也對 `Exception` 的第一個參數做了假設。
      - it is a good practice to place all the user-defined exceptions that our program raises in a separate file. Many standard modules do this. They define their exceptions separately as `exceptions.py` or `errors.py` (generally but not always). 像 Requests 套件就是。

  - [Problems with user defined exception classes - PYRO \- Errors and Troubleshooting](https://pythonhosted.org/Pyro/10-errors.html)

      - `__init__(self, mymessage)` 在 Python 2.5 後會有問題，要改成 `__init__(self, *args)` 或 `__init__(self, mymessage=None)`
      - If you don't need any special behavior of your own exception objects, it is probably best to just subclass them from `Exception` and not define any custom methods or properties. That avoids the problem as well. All builtin exceptions should accept a STRING ARGUMENT to be used as the EXCEPTION MESSAGE, so there is no need to subclass the exception and add custom behavior as shown above, if you just want to remember a message string. 問題是所有 built-in exception 都是這樣嗎?

  - [The definitive guide to Python exceptions](https://julien.danjou.info/python-exceptions-guide/) (2016-08-11)

      - 從 CPython 的原始碼觀察到，`Exception` 只是單純地繼承 `BaseException`，沒有加其他東西，而 `BaseException.__init__` 的 signature 為 `BaseException.__init__(*args)`，只是將傳入的 arguments 存到 `args` attribute，而這個 `args` attribute 只被用在 `BaseException.__str__()`，演算法大概像是：


            def __str__(self): # 專注在 message，不用輸出 type
                if len(self.args) == 0:
                    return ""
                if len(self.args) == 1:
                    return str(self.args[0])
                return str(self.args)

      - 所以有了 "the message to display for an exception should be passed as the FIRST AND THE ONLY ARGUMENT to the `BaseException.__init__` method" 這樣的結論 => always call `BaseException.__init__` with only one argument. 下面的範例是看過最棒的，`msg=None` 跟 `super(CarError, self).__init__(msg)` 的設計更是巧妙!! 事先把 message 準備好傳入 `Exception.__init__()`，就不用再自訂 `__str__()`：

            class CarError(Exception):
                """Basic exception for errors raised by cars"""
                def __init__(self, car, msg=None):
                    if msg is None:
                        # Set some default useful error message
                        msg = "An error occured with car %s" % car
                    super(CarError, self).__init__(msg)
                    self.car = car

            class CarCrashError(CarError):
                """When you drive too fast"""
                def __init__(self, car, other_car, speed):
                    super(CarCrashError, self).__init__(
                        car, msg="Car crashed into %s at speed %d" % (other_car, speed))
                    self.speed = speed
                    self.other_car = other_car

      - Inherits from builtin exceptions types when it makes sense. This makes it easier for programs to NOT BE SPECIFIC TO YOUR APPLICATION OR LIBRARY: 例如 `class InvalidColor(CarError, ValueError)` => That allows many programs to catch errors in a more generic way without noticing your own defined type. 這樣的用法也出現在 Requests 裡，例如 `MissingSchema(RequestException, ValueError)`。

  - [Python exception \- how does the args attribute get automatically set? \- Stack Overflow](https://stackoverflow.com/questions/44799976/) #ril
  - [Proper way to declare custom exceptions in modern Python? \- Stack Overflow](https://stackoverflow.com/questions/1319615/) #ril
  - [Custom Python Exceptions with Error Codes and Error Messages \- Stack Overflow](https://stackoverflow.com/questions/6180185/) #ril

## Non-local Flow Control ??

  - [Programming Recommendations - PEP 8 \-\- Style Guide for Python Code \| Python\.org](https://www.python.org/dev/peps/pep-0008/#programming-recommendations) 提到 NON-ERROR EXCEPTIONS that are used for NON-LOCAL FLOW CONTROL or other forms of signaling need no special suffix. 原來還有 non-error exception 這種東西。
  - [Are exceptions for flow control best practice in Python? \- Software Engineering Stack Exchange](https://softwareengineering.stackexchange.com/questions/351110/) #ril
  - [Python\. Good, bad, evil \-3\-: Flow control exceptions \- Blog \- Open Source \- schlitt\.info](http://schlitt.info/opensource/blog/0724_python_good_bad_evil_03_flow_control_exceptions.html) #ril
  - [Dont Use Exceptions For Flow Control](http://wiki.c2.com/?DontUseExceptionsForFlowControl) 有提到 Python 的觀點 #ril
  - [Using Exception Handling for Control Flow \(in Python\) – Scott Lobdell](http://scottlobdell.me/2015/06/using-exception-handling-control-flow-python/) (2015-06-23) #ril
  - [try catch \- Python using exceptions for control flow considered bad? \- Stack Overflow](https://stackoverflow.com/questions/7274310/) #ril

## Catch-all (`Exception`) 的使用時機 ??

```
try:
    # ...
except Exception:
    _logger.exception('Failed to ...')
```

  - 在 outmost level 做為 uncaught exception handler 時會使用。
  - 處理 3rd-party library 時可能會用，尤其無法掌握它會以什麼形式出錯時。
  - `except Exception:` 的寫法，只比 `except:` (bare except) 少處理了 system-exiting exceptions (`SystemExit`、`KeyboardInterrupt` 跟 `GeneratorExit`)，用 bare except 可能會導致 script 無法結束。

參考資料：

  - [Programming Recommendations - PEP 8 \-\- Style Guide for Python Code \| Python\.org](https://www.python.org/dev/peps/pep-0008/#programming-recommendations) 提到 base `except` 的使用時機 #ril
  - [W0703 \- PyLint Messages](http://pylint-messages.wikidot.com/messages:w0703)
      - 抓 `Exception` 時會提示 `Catching too general exception %s`。
      - Catching exceptions should be as precise as possible. The type of exceptions that can be raised should be known in advance. Using a catch-all Exception instance defeats the purpose of knowing the type of error that occured, and prohibits the use of tailored responses. 但前提是你有打算處理，以提供 tailored responses。
  - [python \- About catching ANY exception \- Stack Overflow](https://stackoverflow.com/questions/4990718/)
      - Tim Pietzcker: 你可以，但你不應該。
      - Blaze: 重點是少用 (sparingly)，尤其在處理 3rd-party library 時，你不會希望有漏網之魚 -- have a backup catch all for the ones you miss。
      - Duncan: 只有在 the most outer level of your code 處理 uncaught exception 時才會用。比起 bare except (`except:`)，`except Exception` 的好處是不會抓 `KeyboardInterrupt`、`SystemExit` 等，不會讓人無法中斷 script。
  - [Handling Exceptions - 8\. Errors and Exceptions — Python 3\.7\.0 documentation](https://docs.python.org/3/tutorial/errors.html#handling-exceptions) The last except clause may omit the exception name(s), to serve as a wildcard. Use this with extreme caution, since it is easy to mask a real programming error in this way! 不過若是擔心 programming error，測試應該是可以解決的。
  - [5\. Built\-in Exceptions — Python 3\.7\.0 documentation](https://docs.python.org/3/library/exceptions.html)
      - 所有的 exception 都直接或間接繼承自 `BaseException`，不過 user-defined exception 應該要繼承自 `Exception`，而非 `BaseException`。從 `Exception` class 的說明看來，`BaseException` 是保留給 system-exiting exceptions 使用的。
      - 從 Exception hierarchy 看來，做 `except Exception:` 也不過漏了 `SystemExit`、`KeyboardInterrupt` 跟 `GeneratorExit` 而已，跟 bare except (`except:`) 的差別不大。

## 參考資料 {: #reference }

手冊：

  - [Exception hierarchy - Python Documentation](https://docs.python.org/3/library/exceptions.html#exception-hierarchy)
