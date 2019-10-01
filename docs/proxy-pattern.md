# Proxy Pattern

  - [Proxy pattern \- Wikipedia](https://en.wikipedia.org/wiki/Proxy_pattern) #ril

      - In computer programming, the proxy pattern is a software design pattern. A proxy, in its most general form, is a class functioning AS AN INTERFACE TO SOMETHING ELSE. The proxy could interface TO ANYTHING: a network connection, a large object in memory, a file, or some other resource that is expensive or IMPOSSIBLE TO DUPLICATE.

        最後 "impossible to duplicate" 似乎在暗示 single?

      - In short, a proxy is a WRAPPER or AGENT object that is being called by the client to access the REAL SERVING OBJECT behind the scenes. Use of the proxy can SIMPLY BE FORWARDING to the real object, or can provide ADDITIONAL LOGIC.

        In the proxy, extra functionality can be provided, for example CACHING when operations on the real object are resource intensive, or CHECKING PRECONDITIONS before operations on the real object are invoked. For the client, usage of a PROXY OBJECT Is similar to using the real object, because both implement the SAME INTERFACE.

        這裡首次提到 "proxy object"

    Overview

      - The Proxy design pattern is one of the twenty-three well-known GoF design patterns that describe how to solve recurring design problems to design flexible and reusable object-oriented software, that is, objects that are easier to implement, change, test, and reuse.

      - What problems can the Proxy design pattern solve?

          - The access to an object should BE CONTROLLED.
          - ADDITIONAL FUNCTIONALITY should be provided when accessing an object.
          - When accessing sensitive objects, for example, it should be possible to check that clients have the needed ACCESS RIGHTS.

      - What solution does the Proxy design pattern describe?

        Define a separate Proxy object that

          - can be used as substitute for another object (`Subject`) and
          - implements additional functionality to control the access to this subject.

        This enables to work through a Proxy object to perform additional functionality when accessing a subject. For example, to check the access rights of clients accessing a sensitive object.

        To act as substitute for a subject, a proxy must implement the `Subject` interface. Clients CAN'T TELL whether they work with a subject or its proxy.

## Python

利用 `object.__getattr__(self, name)` 在走過 default attribute access 但找不到特定 attribute 時就會被呼叫的特性，搭配 `getattr(target, attr)` 就可以營造出 (lazy) proxy object：

```
from __future__ import print_function

class LazyProxy(object):

    def __init__(self, factory):
        self._factory = factory
        self._target = None

    def __getattr__(self, attr):
        print('__getattr__(self, %r)', attr)
        if not self._target:
            print('retrieve the target object lazily.')
            self._target = self._factory()

        return getattr(self._target, attr)
```

用起來像這樣：

```
>>> d = {'k1': 'v1', 'k2': 'v2'}
>>> p = LazyProxy(lambda: d)
>>> p.get('k1')
__getattr__(self, %r) get
retrieve the target object lazily.
'v1'
```

不過還是有些限制：

```
>>> p['k1']
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'LazyProxy' object has no attribute '__getitem__'
>>> p
<__main__.LazyProxy object at 0x1007ba050>
>>> isinstance(d, dict), isinstance(p, dict)
(True, False)
```

雖然 magic method 不會走 `__getattr__()`，不過這對於 [dependency injection](python-di.md) 的應用已經足夠。

---

參考資料：

  - [Python - Proxy pattern \- Wikipedia](https://en.wikipedia.org/wiki/Proxy_pattern#Python)

        """
        Proxy pattern example.
        """
        from abc import ABCMeta, abstractmethod


        NOT_IMPLEMENTED = "You should implement this."


        class AbstractCar:
            __metaclass__ = ABCMeta

            @abstractmethod
            def drive(self):
                raise NotImplementedError(NOT_IMPLEMENTED)


        class Car(AbstractCar):
            def drive(self):
                print("Car has been driven!")


        class Driver(object):
            def __init__(self, age):
                self.age = age


        class ProxyCar(AbstractCar):
            def __init__(self, driver):
                self.car = Car() # (1)
                self.driver = driver

            def drive(self):
                if self.driver.age <= 16: # (2)
                    print("Sorry, the driver is too young to drive.")
                else:
                    self.car.drive()


        driver = Driver(16)
        car = ProxyCar(driver)
        car.drive()

        driver = Driver(25)
        car = ProxyCar(driver)
        car.drive()

     1. 其中 `Car` 不是從 constructor 傳入比較奇怪。
     2. 不過這裡想示範的是 proxy object 可以安插 additional logic。

  - [Proxy object in Python \- Stack Overflow](https://stackoverflow.com/questions/26091833/)

      - orange: I'm looking for way to pass method calls through from an object (WRAPPER) to a member variable of an object (WRAPPEE). There are potentially many methods that need to be externalised, so a way to do this without changing the interface of the wrapper when adding a method to the wrappee would be helpful.

        It would be great if this call redirection is "FAST" (relative to a direct call, i.e. not adding too much overhead).

      - Rafael Barros: A somewhat elegant solution is by creating an "ATTRIBUTE PROXY" on the wrapper class:

            class Wrapper(object):
                def __init__(self, wrappee):
                    self.wrappee = wrappee

                def foo(self):
                    print 'foo'

                def __getattr__(self, attr):
                    return getattr(self.wrappee, attr)


            class Wrappee(object):
                def bar(self):
                    print 'bar'

            o2 = Wrappee()
            o1 = Wrapper(o2)

            o1.foo()
            o1.bar()

        all the magic happens on the `__getattr__` method of the `Wrapper` class, which will try to access the method or attribute on the `Wrapper` instance, and if it doesn't exist, it will try on the wrapped one.

        if you try to access an attribute that doesn't exist on either classes, you will get this:

            o2.not_valid
            Traceback (most recent call last):
              File "so.py", line 26, in <module>
                o2.not_valid
              File "so.py", line 15, in __getattr__
                raise e
            AttributeError: 'Wrappee' object has no attribute 'not_valid'

      - abarnert: If you really need this to be fast, the fastest option is to MONKEYPATCH yourself AT INITIALIZATION:

            def __init__(self, wrappee):
                for name, value in inspect.getmembers(wrappee, callable):
                    if not hasattr(self, name):
                        setattr(self, name, value)

        This will give your `Wrapper` instances normal data attributes whose values are bound methods of the `Wrappee`. That should be blazingly fast. Is it?

            class WrapperA(object):
                def __init__(self, wrappee):
                    self.wrappee = wrappee
                    for name, value in inspect.getmembers(wrappee, callable):
                        if not hasattr(self, name):
                            setattr(self, name, value)

            class WrapperB(object):
                def __init__(self, wrappee):
                    self.wrappee = wrappee
                def __getattr__(self, name):
                    return getattr(self.wrappee, name)

            In [1]: %run wrapper
            In [2]: o2 = Wrappee()
            In [3]: o1a = WrapperA(o2)
            In [4]: o1b = WrapperB(o2)
            In [5]: %timeit o2.bar()    # 直接呼叫
            10000000 loops, best of 3: 154 ns per loop
            In [6]: %timeit o1a.bar()   # 透過 monkeypatch
            10000000 loops, best of 3: 159 ns per loop
            In [7]: %timeit o1b.bar()   # 透過 __getattr__ 轉
            1000000 loops, best of 3: 879 ns per loop
            In [8]: %timeit o1b.wrapper.bar() # 應該是 o1b.wrappee.bar() ??
            1000000 loops, best of 3: 220 ns per loop

        So, copying bound methods has a 3% cost (not sure why it even has that much…). Anything MORE DYNAMIC THAN THIS would have to pull attributes from `self.wrapper`, which has a MINIMUM 66% OVERHEAD. The usual `__getattr__` solution has 471% overhead (and adding unnecessary extra stuff to it can only make it slower).

        So, that sounds like an open and shut win for the bound-methods hack, right? Not necessarily. That 471% overhead is still only 700 nanoseconds. Is that really going to make a difference in your code? Probably not unless it's being used inside a TIGHT LOOP—in which case you're almost certainly going to want to COPY THE METHOD TO A LOCAL VARIABLE ANYWAY.

        確實，如果不是用在 tight loop 裡，471% overheadd 只有 700 ns，用這麼少的時間來換取彈性是沒問題的；如果真成為效能的瓶頸，除了這裡提到 client code 可以把 `wrapper.some_attribute` 先存成 local variable 之外，也可以在 wrapper 內做一層快取，減少 `getattr(wrappee, name)` 的次數，大概就是慢在這裡。

        And there are a lot of DOWNSIDES of this HACK. It's not the "one obvious way to do it". It WON'T WORK FOR SPECIAL METHODS that aren't looked up on the instance dict. It's STATICALLY pulling the attributes off `o2`, so if you create any new ones later, `o1` won't be proxying to them (try building a dynamic chain of proxies this way…). It wastes a lot of memory if you have a lot of proxies. It's slightly different between Python 2.x and 3.x (and even within the 2.x and 3.x series, if you rely on `inspect`), while `__getattr__` has very carefully been kept the same from 2.3 up to the present (and in alternate Python implementations, too). And so on.

        If you really need the speed, you may want to consider a hybrid: a `__getattr__` method that CACHES PROXIED METHODS. You can even do it in two stages: something that's called once, you CACHE THE UNBOUND METHOD IN A CLASS ATTRIBUTE AND BIND IT ON THE FLY; if it's then called repeatedly, you cache the bound method in an instance attribute.

  - [Customizing attribute access - 3\. Data model — Python 3\.7\.3 documentation](https://docs.python.org/3/reference/datamodel.html#customizing-attribute-access)

    `object.__getattr__(self, name)`

      - Called when the DEFAULT ATTRIBUTE ACCESS fails with an `AttributeError` (either `__getattribute__()` raises an `AttributeError` because name is not an instance attribute or an attribute in the CLASS TREE for `self`; or `__get__()` of a name property raises `AttributeError`). This method should either return the (COMPUTED) ATTRIBUTE VALUE or raise an `AttributeError` exception.

      - Note that if the attribute is found through the normal mechanism, `__getattr__()` is NOT CALLED. (This is an INTENTIONAL ASYMMETRY between `__getattr__()` and `__setattr__()`.)

        This is done both for EFFICIENCY REASONS and because otherwise `__getattr__()` would have no way to access other attributes of the instance. Note that at least for instance variables, you can FAKE TOTAL CONTROL by not inserting any values in the instance attribute dictionary (but instead inserting them in another object). See the `__getattribute__()` method below for a way to actually get TOTAL CONTROL OVER ATTRIBUTE ACCESS.

    `object.__getattribute__(self, name)`

      - Called UNCONDITIONALLY to implement attribute accesses for instances of the class. If the class also defines `__getattr__()`, the latter will NOT BE CALLED unless `__getattribute__()` either calls it explicitly or raises an `AttributeError`.

        跟 `__getattr__` 的差別就在 called unconditionally，做為 proxy object 遶過 default attribute access 及 class tree 會更有效率。

      - This method should return the (computed) attribute value or raise an `AttributeError` exception. In order to avoid infinite recursion in this method, its implementation SHOULD ALWAYS CALL THE BASE CLASS METHOD with the same name to access any attributes it needs, for example, `object.__getattribute__(self, name)`.

        若 `__getattribute__()` 裡又有用到 `self.xxx` 的話，又會呼叫 `__getattribute__()` 自己，結果就會引發 `RecursionError: maximum recursion depth exceeded in comparison`；多數情況下覆寫 `__getattr__()` 就已足夠。

      - Note This method may still be BYPASSED WHEN LOOKING UP SPECIAL METHODS as the result of implicit invocation via language syntax or built-in functions. See Special method lookup.

        會不會只有 C extension 才能全面控制 attribute access ??

  - [Customizing attribute access - 3\. Data model — Python 2\.7\.16 documentation](https://docs.python.org/2/reference/datamodel.html#customizing-attribute-access)

    `object.__getattr__(self, name)`

      - Called when an attribute lookup has not found the attribute in the USUAL PLACES (i.e. it is not an instance attribute nor is it found in the class tree for `self`). `name` is the attribute name. This method should return the (computed) attribute value or raise an `AttributeError` exception.

      - Note that if the attribute is found through the normal mechanism, `__getattr__()` is not called. (This is an intentional asymmetry between `__getattr__()` and `__setattr__()`.) This is done both for efficiency reasons and because otherwise `__getattr__()` would have no way to access other attributes of the instance. Note that at least for instance variables, you can fake total control by not inserting any values in the instance attribute dictionary (but instead inserting them in another object). See the `__getattribute__()` method below for a way to actually get total control IN NEW-STYLE CLASSES.

        Python 2 也有 `__getattribute__()`，但只有 new-style class 才支援。

    More attribute access for new-style classes -- `object.__getattribute__(self, name)`

      - Called unconditionally to implement attribute accesses for instances of the class. If the class also defines `__getattr__()`, the latter will not be called unless `__getattribute__()` either calls it explicitly or raises an `AttributeError`. This method should return the (computed) attribute value or raise an `AttributeError` exception. In order to avoid infinite recursion in this method, its implementation should always call the base class method with the same name to access any attributes it needs, for example, `object.__getattribute__(self, name)`.
      - Note This method may still be bypassed when looking up special methods as the result of implicit invocation via language syntax or built-in functions. See Special method lookup for new-style classes.

  - [Proxying objects in Python \| ionel's codelog](https://blog.ionelmc.ro/2015/01/12/proxying-objects-in-python/) (2015-01-12)

      - A LAZY object proxy is an object that wraps a CALLABLE but defers the call until the object is actually required, and caches the result of said call.

        這個 callable 就是 factory。

      - These kinds of objects are useful in resolving various dependency issues, few examples:

          - Objects that need to held CIRCULAR REFERENCES at each other, but AT DIFFERENT STAGES. To instantiate object `Foo` you need an instance of `Bar`. Instance of `Bar` needs an instance of `Foo` in some of it methods (but NOT AT CONSTRUCTION). CIRCULAR IMPORTS sound familiar?

            這裡的 no at construction 指的是 no at import-time。

          - Performance sensitive code. You don't know ahead of time what you're going to use but you don't want to pay for allocating all the resources at the start as you usually need just few of them.

        There are other examples, I've just made up a couple for context.

      - If you've used Django you may be familiar with [`SimpleLazyObject`](https://github.com/django/django/blob/stable/1.7.x/django/utils/functional.py#L337). For simple use-cases it's fine, and if you're already using Django the choice is obvious. Unfortunately it's MISSING MANY MAGIC METHODS, most glaring omissions: `__iter__`, `__getslice__`, `__call__` etc. It's not too bad, you can just subclass and add them yourself.

        But what if you need to have `__getattr__`? The horrors of the infinite recursive call beckon.

        但如果做為 dependency，需要支援到這麼細嗎? 通常我們只會調用 service 的 methods，倒是很少把它當做 data structure 或 callable 使用 -- `for item in service`? `service[-1]`? `service()`?

      - Meanwhile I've noticed that [wrapt](https://github.com/GrahamDumpleton/wrapt) has a quite complete [object proxy](http://wrapt.readthedocs.org/en/latest/wrappers.html#object-proxy). Unfortunately it's not really amendable to adding a LAZY BEHAVIOR in a subclass due to the C extension (I wouldn't make bets on sub-classing the pure-python proxy implementation either without some UNWANTED OVERHEAD :-).

        Thus I forked the code and changed everything to have the lazy behavior. You can see the results here: https://github.com/ionelmc/python-lazy-object-proxy

  - [werkzeug/local\.py at 0\.15\.4 · pallets/werkzeug](https://github.com/pallets/werkzeug/blob/0.15.4/src/werkzeug/local.py#L255) Flask 常用的 local proxy object，實作了大部份的 magic methods #ril

  - [class `xmlrpclib.ServerProxy` - 20\.23\. xmlrpclib — XML\-RPC client access — Python 2\.7\.16 documentation](https://docs.python.org/2/library/xmlrpclib.html#xmlrpclib.ServerProxy) 提到 "returned proxy instance" 及 "The returned instance is a proxy object" #ril
