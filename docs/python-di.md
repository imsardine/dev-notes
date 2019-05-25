---
title: Python / Dependency Injection (DI)
---
# [Python](python.md) / [Dependency Injection (DI)](di.md)

  - Python 雖然不太流行 DI framework，但並不代表 Python 不需要它，而是利用語言本身的特性，就可以滿足大部份的需求。

      - Python module 本身就是 singleton。
      - 實現 lazy proxy pattern 對 Python 這樣的動態語言是輕而易舉。

    為什麼要有 lazy proxy object？這樣就能在 import time 就拿到 dependency，但 dependency 又不會在 import time 完成初始化，這種做法不僅 pythonic，甚至可以實現 circular reference。

    `pkg/utils.py`

        __all__ = ['lazy_service']

        class LazyProxy:

            def __init__(self, factory):
                self._factory = factory
                self._target = None

            def __getattr__(self, attr):
                if not self._target:
                    self._target = self._factory()
                return getattr(self._target, attr)

        def lazy_service(factory):
            return LazyProxy(factory)

  - 用起來像這樣：

    `pkg/__init__.py`:

        from _config import config

    `pkg/_config.py`:

        from .utils import lazy_service

        class Config:

            def __init__(self, settings, env): # 跟 os.environ 及檔案脫勾，方便測試各種狀況
                self._settings = settings
                self._env = env

            @property
            def email_signature():
                return self._settings['email_signature']

        def config(): # factory
            env = os.environ
            with open(env['SETTINGS_PATH']) as ymlfile:
                settings = yaml.load(ymlfile, Loader=yaml.FullLoader)

            return Config(settings, env)

        config = lazy_service(config)

    `pkg/mail.py`:

        from . import config
        from .utils import lazy_service
        from .smtp import smtp_transport # another dendency (proxy)

        class Mailer:

            def __init__(self, smtp_transport, config):
                self._smtp_transport
                self._config = config

            def send_mail(title, content, recipients):
                content += '\n' + self._config.email_signature
                ...

        def mailer():
            return Mailer(smtp_transport, config) # injection

        mailer = lazy_service(mailer)

  - 由於 `lazy_service(factory)` 接受單一個 callable 做為參數，雖然回傳值是 `LazyProxy` 而非 callable，但搭配 `@wrapper` decorator syntax 還是可以帶來些好處：

        mailer = lazy_service(lambda: Mailer(smtp_transport, config))

        # or

        def mailer():
            return Mailer(smtp_transport, config) # injection

        mailer = lazy_service(mailer)

        # or

        @lazy_service
        def mailer():
            return Mailer(smtp_transport, config) # injection

    若 factory 無法寫成單一行 lambda，在 Python 不支援多行 anonymous function 的情況下，第 3 種寫法相較第 2 種好讀，之後甚至可以發展 `@lazy_service(scope='thread')` 的應用。

  - 要測試 `Mailer` 的話，不需要做 patch，只要搭配可控制的 `SmtpTransport` 及 `Config` 重新生個待測的 `Mailer` 即可，例如：

        def test_mailer():
            smtp_transport = MagicMock(spec=SmtpTransport)
            config = MagicMock(spec=Config)
            mailer = Mailer(smtp_transport, config)

            ...

  - 上面提到的 circular reference 雖然不常見，但因為 lazy proxy object 會延後初始化的時間，所以遇到 circular reference 還是可以應付。

    `pkg/__init__.py`

        from .foo import foo
        from .bar import bar

    `pkg/foo.py`

        from .utils import lazy_service

        class Foo:

            def __init__(self, bar):
                self._bar = bar

            def op(self):
                print 'I am Foo, and I have a Bar %r' % self._bar

        @lazy_service
        def foo():
            from .bar import bar # 避開 circular import 的問題
            return Foo(bar)

    `pkg/bar.py`

        from .utils import lazy_service

        class Bar:

            def __init__(self, foo):
                self._foo = foo

            def say_hi(self):
                print 'I am Bar, and I have a Foo %r' % self._foo

        @lazy_service
        def bar():
            from .foo import foo
            return Bar(foo)

    `test`

        #!/usr/bin/env python
        from pkg import foo, bar

        foo.say_hi()
        bar.say_hi()

    執行 `test` 的結果：

        $ ./test
        I am Foo, and I have a Bar <pkg.utils.Proxy instance at 0x101e65908>
        I am Bar, and I have a Foo <pkg.utils.Proxy instance at 0x101e657e8>

---

參考資料：

  - [design patterns \- Why is IoC / DI not common in Python? \- Stack Overflow](https://stackoverflow.com/questions/2461702/)

      - tux21b: In Java IoC / DI is a very common practice which is extensively used in web applications, nearly all available frameworks and Java EE. On the other hand, there are also lots of big Python web applications, but beside of Zope (which I've heard should be really horrible to code) IoC doesn't seem to be very common in the Python world. (Please name some examples if you think that I'm wrong).

        There are of course several CLONES of popular Java IoC frameworks available for Python, [springpython](http://springpython.webfactional.com/) for example. But none of them seems to GET USED PRACTICALLY. At least, I've never stumpled upon a Django or sqlalchemy+<insert your favorite wsgi toolkit here> based web application which uses something like that.

        這現象確實很奇特，有些看似很完整的方案，但用的人確很少，除了 Spring Python 外，還有 Google 內部自己做的 Pinject。

        In my opinion IoC has reasonable advantages and would make it easy to replace the `django-default-user-model` for example, but extensive usage of INTERFACE CLASSES and IoC in Python looks a bit odd and NOT »PYTHONIC«. But maybe someone has a better explanation, why IoC isn't widely used in Python.

      - Jörg W Mittag: I don't actually think that DI/IoC are that uncommon in Python. What is uncommon, however, are DI/IoC frameworks/containers.

        Think about it: what does a DI container do? It allows you to WIRE TOGETHER INDEPENDENT COMPONENTS into a complete application ... at runtime. We have names for "wiring together" and "at runtime": scripting, dynamic

        So, to recap: the practice of DI/IoC is just as important in Python as it is in Java, for exactly the same reasons. The implementation of DI/IoC however, is BUILT INTO THE LANGUAGE and often so lightweight that it completely vanishes.

        終究還是沒講說要怎麼做，所以下面引來一堆 downvote XD

      - Max Malysh: IoC and DI are SUPER COMMON in MATURE Python code. You just don't need a framework to implement DI thanks to DUCK TYPING.

            # settings.py
            CACHES = {
                'default': {
                    'BACKEND': 'django_redis.cache.RedisCache',
                    'LOCATION': REDIS_URL + '/1',
                },
                'local': {
                    'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
                    'LOCATION': 'snowflake',
                }
            }

        Django Rest Framework utilizes DI heavily:

            class FooView(APIView):
                # The "injected" dependencies:
                permission_classes = (IsAuthenticated, )
                throttle_classes = (ScopedRateThrottle, )
                parser_classes = (parsers.FormParser, parsers.JSONParser, parsers.MultiPartParser)
                renderer_classes = (renderers.JSONRenderer,)

                def get(self, request, *args, **kwargs):
                    pass

                def post(self, request, *args, **kwargs):
                    pass

        看不懂這跟 injection 是什麼關係 ??

      - jhonatan teixeira: Whats a DI library good for if you can INSTANTIATE A OBJECT YOURSELF INSIDE A PACKAGE AND IMPORT IT TO INJECT IT YOURSELF?

        The chosen answer is right, since java has no PROCEDURAL SECTIONS (code outside of classes), all that goes into boring configuration xml's, hence the need of a class to instantiate and inject dependencies on a LAZY LOAD FASHION so you don't blow away your performance, while on python you just code the injections on the "procedural" (code outside classes) sections of your code

        但 lazy load fashion 並沒什麼不好啊...

      - TM.: Part of it is the way the module system works in Python. You can get a sort of "SINGLETON" FOR FREE, JUST BY IMPORTING IT FROM A MODULE. Define an actual instance of an object in a module, and then any client code can import it and actually get a working, FULLY CONSTRUCTED / POPULATED OBJECT.

        This is in contrast to Java, where you don't import actual instances of objects. This means you are always having to instantiate them yourself, (or use some sort of IoC/DI style approach). You can mitigate the hassle of having to instantiate everything yourself by having STATIC FACTORY METHODS (or actual factory classes), but then you still incur the resource overhead of actually creating new ones each time.

        有點感覺，但在 import time 就產生 fully constructed/populated object，有些情況下並不可行。

        Luxspes: Oversimplifying, answer, in real life, you rarely need just "a singleton", you need to control SCOPE (you might need a THREAD LOCAL SINGLETON, or a SESSION SINGLETON, and so on), this makes me think that the kind of problems solved in Python are not the kind of real world problems actually solved in an ENTERPRISE setting.

        好像很有道理，不過這些 scope 的存在似乎是因為 component 是 stateful 的，做為 stateless 就沒事了 ??

## 工具 {: #tools }

  - [Dependency Injection: Python – Shivam Aggarwal – Medium](https://medium.com/@shivama205/dependency-injection-python-cb2b5f336dce) (2018-07-19) 介紹 [Dependency Injector](https://github.com/ets-labs/python-dependency-injector)，但好像把事情變複雜了。
  - [Home \| Spring Python](http://springpython.webfactional.com/) #ril
  - [google/pinject: A pythonic dependency injection library\.](https://github.com/google/pinject) #ril
  - [msiedlarek/wiring: Architectural foundation for Python applications\.](https://github.com/msiedlarek/wiring) #ril
