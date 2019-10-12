# FreezeGun

  - [spulec/freezegun: Let your Python tests travel through time](https://github.com/spulec/freezegun)

      - FreezeGun is a library that allows your Python tests to travel through time by mocking the `datetime` module.

        Once the decorator or context manager have been invoked, all calls to `datetime.datetime.now()`, `datetime.datetime.utcnow()`, `datetime.date.today()`, `time.time()`, `time.localtime()`, `time.gmtime()`, and `time.strftime()` will return the time that has been frozen.

## 新手上路 {: #getting-started }

  - [spulec/freezegun: Let your Python tests travel through time](https://github.com/spulec/freezegun) #ril

      - Decorator

            from freezegun import freeze_time
            import datetime
            import unittest


            @freeze_time("2012-01-14")
            def test():
                assert datetime.datetime.now() == datetime.datetime(2012, 1, 14)

            # Or a unittest TestCase - freezes for every test, from the start of setUpClass to the end of tearDownClass

            @freeze_time("1955-11-12")
            class MyTests(unittest.TestCase):
                def test_the_class(self):
                    assert datetime.datetime.now() == datetime.datetime(1955, 11, 12)

            # Or any other class - freezes around each callable (may not work in every case)

            @freeze_time("2012-01-14")
            class Tester(object):
                def test_the_class(self):
                    assert datetime.datetime.now() == datetime.datetime(2012, 1, 14)

        日期的表示法還滿直覺的 `"2012-01-14"`，原來背後用 `dateutil` 在解析。

      - Context manager

            from freezegun import freeze_time

            def test():
                assert datetime.datetime.now() != datetime.datetime(2012, 1, 14)
                with freeze_time("2012-01-14"):
                    assert datetime.datetime.now() == datetime.datetime(2012, 1, 14)
                assert datetime.datetime.now() != datetime.datetime(2012, 1, 14)

        用法跟 decorator 滿像的，都是進入時鎖住時間，離開時回復正常值。

      - Nice inputs

        FreezeGun uses `dateutil` behind the scenes so you can have nice-looking datetimes.

            @freeze_time("Jan 14th, 2012")
            def test_nice_datetime():
                assert datetime.datetime.now() == datetime.datetime(2012, 1, 14)

      - Function and generator objects

        FreezeGun is able to handle function and generator objects.

            def test_lambda():
                with freeze_time(lambda: datetime.datetime(2012, 1, 14)):
                    assert datetime.datetime.now() == datetime.datetime(2012, 1, 14)

            def test_generator():
                datetimes = (datetime.datetime(year, 1, 1) for year in range(2010, 2012))

                with freeze_time(datetimes):
                    assert datetime.datetime.now() == datetime.datetime(2010, 1, 1)

                with freeze_time(datetimes):
                    assert datetime.datetime.now() == datetime.datetime(2011, 1, 1)

                # The next call to freeze_time(datetimes) would raise a StopIteration exception.

        看似很酷，但實用性似乎不高? 因為你不一定清楚受測的程式，在過程中拿了幾次時間 ... 另外值得注意的是，callable 跟 generator 回傳的是 `datetime` object 而非之前的字串。

    Default arguments

      - Note that FreezeGun will not modify DEFAULT ARGUMENTS. The following code will print the current date. See [here](http://docs.python-guide.org/en/latest/writing/gotchas/#mutable-default-arguments) for why.

            from freezegun import freeze_time
            import datetime as dt

            def test(default=dt.date.today()):
                print(default)

            with freeze_time('2000-1-1'):
                test()

        事實上也改不了，因為 `default=dt.date.today()` 在 import time 就已評估。

## Ticking ??

  - [spulec/freezegun: Let your Python tests travel through time](https://github.com/spulec/freezegun)

    `tick` argument

      - FreezeGun has an additional `tick` argument which will RESTART TIME AT THE GIVEN VALUE, but then time will keep ticking. This is alternative to the default parameters which will KEEP TIME STOPPED.

            @freeze_time("Jan 14th, 2020", tick=True)
            def test_nice_datetime():
                assert datetime.datetime.now() > datetime.datetime(2020, 1, 14)

        把時間撥回特定時間點，而非凍結。

    `auto_tick_seconds` argument

      - FreezeGun has an additional `auto_tick_seconds` argument which will autoincrement the value EVERY TIME by the given amount from the start value. This is alternative to the default parameters which will keep time stopped. Note that given `auto_tick_seconds` the `tick` parameter will be ignored.

            @freeze_time("Jan 14th, 2020", auto_tick_seconds=15)
            def test_nice_datetime():
                first_time = datetime.datetime.now()
                auto_incremented_time = datetime.datetime.now()
                assert first_time + datetime.timedelta(seconds=15) == auto_incremented_time

        每次取用時間都會跳 `auto_tick_seconds` 指定的秒數，跟 `tick=True` 讓時間自然往下走不同。

    Manual ticks

      - FreezeGun allows for the time to be MANUALLY FORWARDED as well.

            def test_manual_increment():
                initial_datetime = datetime.datetime(year=1, month=7, day=12,
                                                    hour=15, minute=6, second=3)
                with freeze_time(initial_datetime) as frozen_datetime:
                    assert frozen_datetime() == initial_datetime # (1)

                    frozen_datetime.tick() # (2)
                    initial_datetime += datetime.timedelta(seconds=1)
                    assert frozen_datetime() == initial_datetime

                    frozen_datetime.tick(delta=datetime.timedelta(seconds=10)) # (2)
                    initial_datetime += datetime.timedelta(seconds=10)
                    assert frozen_datetime() == initial_datetime

         1. 呼叫 context manager 的 target 會拿到下次的時間。
         2. `tick(delta)` 讓時間轉動，預設前進 1 秒。

    Moving time to specify datetime

      - FreezeGun allows moving time to specific dates.

            def test_move_to():
                initial_datetime = datetime.datetime(year=1, month=7, day=12,
                                                    hour=15, minute=6, second=3)

                other_datetime = datetime.datetime(year=2, month=8, day=13,
                                                    hour=14, minute=5, second=0)
                with freeze_time(initial_datetime) as frozen_datetime:
                    assert frozen_datetime() == initial_datetime

                    frozen_datetime.move_to(other_datetime) # (1)
                    assert frozen_datetime() == other_datetime

                    frozen_datetime.move_to(initial_datetime)
                    assert frozen_datetime() == initial_datetime


            @freeze_time("2012-01-14", as_arg=True) # (2)
            def test(frozen_time):
                assert datetime.datetime.now() == datetime.datetime(2012, 1, 14)
                frozen_time.move_to("2014-02-12")
                assert datetime.datetime.now() == datetime.datetime(2014, 2, 12)

         1. Context manager 的 target 還有 `move_to()` 的功能。
         2. 做為 decorator 時，加上 `as_arg` 可以拿到類 context manager 的 target，可以調用它的 `tick()`、`move_to()` 等。

        Parameter for `move_to` can be any valid `freeze_time` date (STRING, date, datetime).

## 安裝設置 {: #setup }

  - [Installation - spulec/freezegun: Let your Python tests travel through time](https://github.com/spulec/freezegun#installation)

    To install FreezeGun, simply:

        $ pip install freezegun

    On Debian (Testing and Unstable) systems:

        $ sudo apt-get install python-freezegun

## 參考資料 {: #reference }

  - [spulec/freezegun - GitHub](https://github.com/spulec/freezegun)
  - [freezegun - PyPI](https://pypi.org/project/freezegun/)

相關：

  - 背後用 [`dateutil`](python-dateutil.md) 在解讀日期/時間。
