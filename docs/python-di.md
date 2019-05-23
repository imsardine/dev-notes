---
title: Python / Dependency Injection (DI)
---
# [Python](python.md) / [Dependency Injection (DI)](di.md)

Python module 裡的 global 本質上就是 singleton，若是在 import time 就完成 dependency 的初始化，就不用擔心 threading 的問題：

`pkg/__init__.py`:

```
from _config import config_ # trailing underscore as a hint
```

`pkg/_config.py`:

```
class Config:

    def __init__(self, settings, env): # 跟 os.environ 及檔案脫勾，方便測試各種狀況
        self._settings = settings
        self._env = env

    @property
    def email_signature():
        return self._settings['email_signature']

_config = None # lazy

def config_(): # factory
    global _config
    if not _config:
        env = os.environ
        with open(env['SETTINGS_PATH']) as ymlfile:
            settings = yaml.load(ymlfile, Loader=yaml.FullLoader)

        _config = Config(settings, env)

    return _config
```

`pkg/mail.py`:

```
from . import config_
from .smtp import smtp_transport_ # another factory

class Mailer:

    def __init__(self, smtp_transport, config):
        self._smtp_transport
        self._config = config

    def send_mail(title, content, recipients):
        content += '\n' + self._config.email_signature
        ...

_mailer = None #lazy

def mailer_():
    global _mailer
    if not _mailer:
        _mailer = Mailer(smtp_transport_(), config_()) # injection

    return _mailer
```

要測試 `Mailer` 的話，不需要做 patch，只要搭配可控制的 `SmtpTransport` 及 `Config` 重新生個待測的 `Mailer` 即可，例如：

```
def test_mailer():
    smtp_transport = MagicMock(spec=SmtpTransport)
    config = MagicMock(spec=Config)
    mailer = Mailer(smtp_transport, config)

    ...
```

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
