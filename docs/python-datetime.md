---
title: Python / Date/Time
---
# [Python](python.md) / Date/Time

  - [datetime — Basic date and time types — Python 3\.7\.3 documentation](https://docs.python.org/3/library/datetime.html) #ril

      - The `datetime` module supplies classes for manipulating dates and times in both simple and complex ways. While date and time arithmetic is supported, the focus of the implementation is on EFFICIENT ATTRIBUTE EXTRACTION FOR OUTPUT FORMATTING AND MANIPULATION. For related functionality, see also the `time` and `calendar` modules.

      - There are two kinds of date and time objects: “NAIVE” and “AWARE”.

        An aware object has sufficient knowledge of applicable algorithmic and political time adjustments, such as time zone and daylight saving time information, to LOCATE ITSELF RELATIVE TO OTHER AWARE OBJECTS. An aware object is used to represent a SPECIFIC MOMENT in time that is NOT OPEN TO INTERPRETATION.

        A naive object does not contain enough information to UNAMBIGUOUSLY locate itself relative to other date/time objects. Whether a naive object represents Coordinated Universal Time (UTC), local time, or time in some other timezone is PURELY UP TO THE PROGRAM, just like it is up to the program whether a particular number represents metres, miles, or mass.

        Naive objects are EASY TO UNDERSTAND AND TO WORK WITH, at the cost of ignoring some aspects of reality.

        從 "easy to work with" 及 "applications requiring aware object" 看來，似乎是比較推 naive 的，由於 open to interpretation 的特性，統一將 naive 視為 UTC 即可。

      - For applications requiring aware objects, `datetime` and `time` objects have an OPTIONAL time zone information attribute, `tzinfo`, that can be set to an instance of a subclass of the abstract `tzinfo` class. These `tzinfo` objects capture information about the OFFSET FROM UTC TIME, the time zone name, and whether Daylight Saving Time is in effect.

        Note that only one concrete `tzinfo` class, the `timezone` class, is supplied by the `datetime` module. The `timezone` class can represent simple timezones with FIXED OFFSET from UTC, such as UTC ITSELF or North American EST and EDT timezones.

        Supporting timezones at deeper levels of detail is UP TO THE APPLICATION. The rules for time adjustment across the world are more POLITICAL than rational, CHANGE FREQUENTLY, and there is NO STANDARD suitable for every application aside from UTC.

  - [8\.1\. datetime — Basic date and time types — Python 2\.7\.14 documentation](https://docs.python.org/2/library/datetime.html) 專注在取用 date/time 的 attribute extraction - 取年、月、日、時等 #ril
      - Objects of these types are immutable，這也代表著所有的 `datetime.*` types 都是 hashable，可以搭配 hashable collection 使用。
  - [15\.3\. time — Time access and conversions — Python 2\.7\.14 documentation](https://docs.python.org/2/library/time.html) 大部份 function 背後都是同名的 C function，可能因 platform 不同而異 #ril
  - [8\.2\. calendar — General calendar\-related functions — Python 2\.7\.14 documentation](https://docs.python.org/2/library/calendar.html) 會輪出類似 Unix-like `cal` 的日曆 #ril

## 解析/格式化 ??

```
>>> d = datetime.strptime('2017-02-02 18:00', '%Y-%m-%d %H:%M')
>>> d.isoformat()
'2017-02-02T18:00:00'
```

參考資料：

  - [strftime() and strptime() Behavior - 8\.1\. datetime — Basic date and time types — Python 2\.7\.14 documentation](https://docs.python.org/2/library/datetime.html#strftime-and-strptime-behavior) `datetime.date`、`datetime.time` 及 `datetime.datetime` 都有 `strftime(format)` 將代表的日期/時間轉成字串，不過反過來的 parsing 只有 `datetime.datetime` 有提供 `strptime(date_string, format)`，不過 `format` 都要自己用 format code 自己併就是了。
  - [datetime.isoformat([sep]) - 8\.1\. datetime — Basic date and time types — Python 2\.7\.14 documentation](https://docs.python.org/2/library/datetime.html#datetime.datetime.isoformat) 輸出成 ISO 8601，但 timezone 只會用 `+/-HH:MM` 來表示，UTC 並不會在後面串上 `Z` (而是 `+00:00`)。反過來要解析的話，若要支援不同寫法的解析，得要寫多種 format code 應付各種狀況。

## Time Zone ??

  - Unicode 有所謂的 Unicode Sandwich -- 進入程式都轉成 Unicode，輸出都用 byte string。在 time zone 的部份，實務上該如何取捨 naive 與 aware？

    程式跟儲存裡都用 naive，輸出時再轉 aware。

---

參考資料：

  - [8\.1\. datetime — Basic date and time types — Python 2\.7\.14 documentation](https://docs.python.org/2/library/datetime.html)
      - date/time object 區分為 naive (天真的) 與 aware 兩種。所謂 aware 是知道 timezone、daylight saving time (DST) 是否作用中 (in effect)，可以明確地跟其他 aware object 比較 (unambiguously)，相對於 naive 就沒有這些資訊 (可以自己決定該如何解讀)。
      - `datetime` 跟 `time` 都有 `tzinfo` 屬性 (不是 `None` 時就是 aware，型態繼承自 `datetime.tzinfo` abstract class)，記錄著與 UTC 的偏移 (offset)、time zone 名稱、DST (Daylight Saving Time) 是否作用中等。
      - 有趣的是 `datetime` module 並未提供任何 `datetime.tzinfo` 的實作；或許跟 "Naive objects are easy to understand and to work with, at the cost of ignoring some aspects of reality" 與 "The rules for time adjustment across the world are more political than rational, and there is no standard suitable for every application." 這兩段話有關，time zone 並非必要。
  - [datetime.astimezone(tz) - 8\.1\. datetime — Basic date and time types — Python 2\.7\.14 documentation](https://docs.python.org/2/library/datetime.html#datetime.datetime.astimezone) 將 aware `datetime` 轉換成另一個 timezone，若想直接代換掉 timezone 則用 `replace(tzinfo=tz)`，其中 `tz` 若傳入 `None`，則會把 aware `datetime` 變成 naive object。
  - [tzinfo Objects - 8\.1\. datetime — Basic date and time types — Python 2\.7\.14 documentation](https://docs.python.org/2/library/datetime.html#tzinfo-objects) #ril
      - `datetime.tzinfo` 的實作一定要提供 `utcoffset(self, dt)`、`dst(self, dt)` 與 `tzname(self, dt)`。
      - `utcoffset()` 會傳回與 UTC 間的偏移 (`timedelta`)，並把 DST 考量進去。
      - 從 `LocalTimezone` 的實作看來，`utcoffset()`、`dst()` 及 `tzname()` 的回傳值都跟 `_isdst(dt)` 有關，也就是某個 date/time 是否 DST 有在作用中，也難怪所有的 method 都要傳 `dt` 進去；`tzname()` 的 "return different names depending on the specific value of dt passed, especially if the tzinfo class is accounting for daylight time" 印證了這個說法。

  - [Timezones and Python \| Julien Danjou](https://julien.danjou.info/blog/2015/python-and-timezones) (2015-06-16) #ril
  - [pytz \- World Timezone Definitions for Python — pytz 2014\.10 documentation](http://pythonhosted.org/pytz/) #ril

## Time Delta ??

  - [Available Types - 8\.1\. datetime — Basic date and time types — Python 2\.7\.15 documentation](https://docs.python.org/2/library/datetime.html#available-types) 提到 `datetime.timedelta` 是 "A DURATION expressing the difference between two `date`, `time`, or `datetime` instances to MICROSECOND resolution."，也提到 The distinction between naive and aware doesn’t apply to `timedelta` objects. 沒有 time zone naive/aware 的概念。
  - [timedelta Objects - 8\.1\. datetime — Basic date and time types — Python 2\.7\.14 documentation](https://docs.python.org/2/library/datetime.html#timedelta-objects)
      - `class datetime.timedelta([days[, seconds[, microseconds[, milliseconds[, minutes[, hours[, weeks]]]]]]])` 所有 argument 預設都是 `0`，可以接受 integer/float，也可以是 positive/negative，彈性很大；但 microsecond 已經最小精度，再給小數好像也沒意思?
      - 雖然 constructor 提供了 `milliseconds`、`minutes`、`hours`、`weeks` 等，但內部只存 `days`、`seconds` 跟 `microseconds` (也就是 `timedelta` instance 的 3 個 attribute)；也就是內部會做 normalization 以確保 "unique representation"，所以 `milliseconds` => x 1000 macroseconds、`minutes` => x 60 seconds、`hours` => x 3600 seconds、`weeks` => x 7 days。
      - 除了 supported operations 提到的 `timedelta` objects 間可以做一些數學運算，例如 `t1 + t2`、`t1 - t2`、`t * i`、`t // i`、`+t`、`-t` 還有 `abs(t)`，另外 `timedelta` 間也可以比較，比的是 duration 的長短。
      - `timedelta` 本身是 hashable，也支援 pickling。在 boolean context 裡，只要不是 `timedelta(0)` 就會被視為 `True`。
      - 中間提到 `timedelta` 可以跟 `date`/`datetime` 做加減運算 (跟 `time` 不行??)，不過細節就在 `date`/`datetime` objects 的章節說明了。
  - [8\.1\. datetime — Basic date and time types — Python 2\.7\.14 documentation](https://docs.python.org/2/library/datetime.html) 出現不少 `timedelta(0)` 的用法，甚至有 `ZERO = timedelta(0)`。

## Date Time - date, datetime, time ??

  - [date Objects - 8\.1\. datetime — Basic date and time types — Python 2\.7\.15 documentation](https://docs.python.org/2/library/datetime.html#date-objects) #ril
  - [datetime Objects - 8\.1\. datetime — Basic date and time types — Python 2\.7\.15 documentation](https://docs.python.org/2/library/datetime.html#datetime-objects) #ril
  - [time Objects - 8\.1\. datetime — Basic date and time types — Python 2\.7\.15 documentation](https://docs.python.org/2/library/datetime.html#time-objects) #ril

## 如何解析 ISO 8601 字串?

如果要解析 ISO 8601 (或它的子集 RFC 3339)，都不建議用 `datetime.strptime()`，處理各種變化型會很苦。建議用 `python-dateutil`：


```
>>> from dateutil import parser
>>> parser.parse('2017-12-29T13:54:01.2732344+00:00')
datetime.datetime(2017, 12, 29, 13, 54, 1, 273234, tzinfo=tzutc())
>>> parser.parse('2017-12-29T13:54:01.2732344')
datetime.datetime(2017, 12, 29, 13, 54, 1, 273234)
```

參考資料：

  - [python \- How to parse an ISO 8601\-formatted date? \- Stack Overflow](https://stackoverflow.com/questions/127803/) `datetime.strptime()` 不好用，有什麼好方法解析 RFC 3339? Mark Amery: 因為 RFC 3339 有很多變化，別用 `strptime()`。許多人同意 Flimm 用 `python-dateutil` 套件的做法 `dateutil.parser.parse(...)`。
  - [How do I translate a ISO 8601 datetime string into a Python datetime object? \- Stack Overflow](https://stackoverflow.com/questions/969285/) Wes Winham: 傾向用 `python-dateutil`，用 `strptime()` 會很歡樂...

## 如何取得當地時間年、月、日、時、分等不同欄位的值??

```
from datetime import datetime

now = datetime.now()
year, month, day, hour, minute, second =
    now.year, now.month, now.day,
    now.hour, now.minute, now.second
```

參考資料：

  - 8.1. datetime — Basic date and time types — Python 2.7.14 documentation https://docs.python.org/2/library/datetime.html `datetime.now()` 可以取得 `datetime.datetime` 的 instance，然後透過 `.year`、`.month`、`.day`、`.hour`、`.minute`、`.second` 就能取得不同欄位的值。提到 `datetime.today()` 等同於 `datetime.fromtimestamp(time.time())`，也就是等同於 `datetime.now()`。不過 `date.today()` 的可讀性似乎比 `datetime.today()`?

## 如何取得當下 UTC (aware) 的 datetime??

參考資料：

  - [datetime.now([tz]) - 8\.1\. datetime — Basic date and time types — Python 2\.7\.14 documentation](https://docs.python.org/2/library/datetime.html#datetime.datetime.now) #ril
      - `datetime.now()` 沒給 `tz` 時會拿到 local datetime，有提供 `tz` 時則會轉成 `tz` 的時間。
  - [datetime.utcnow() - 8\.1\. datetime — Basic date and time types — Python 2\.7\.14 documentation](https://docs.python.org/2/library/datetime.html#datetime.datetime.utcnow) 跟 `now()` 一樣，只不過傳回 UTC 時間，但 `tzinfo` 一樣是 `None` (naive)。

## TypeError: datetime.datetime(...) is not JSON serializable

```
from datetime import datetime, date
import json
import pytz

def test_default_serializer():
    def default(obj):
        if isinstance(obj, (date, datetime)):
            return obj.isoformat()
        else:
            return str(obj)
            # raise TypeError('%r is not JSON serializable' % obj)

    data = [
        date(2018, 1, 2),
        datetime(2018, 1, 2, 13, 50, tzinfo=pytz.utc),
    ]
    s = json.dumps(data, default=default)
    assert s == '["2018-01-02", "2018-01-02T13:50:00+00:00"]'
```

參考資料：

  - [Serializing your datetime objects - Understanding datetime in Python: A primer \| Opensource\.com](https://opensource.com/article/17/5/understanding-datetime-python-primer) 用 `datetime.isoformat()` 轉成 ISO 8601 字串，也可以轉成 timestamp，最後是是自己寫 serializer -- 不知道如何 serialize 時會被呼叫的 function，搭配 `json.dumps(data, default=serializer)` 使用。
  - [datetime\.date\(2008, 5, 27\) is not JSON serializable · Issue \#22 · jeffknupp/sandman](https://github.com/jeffknupp/sandman/issues/22) dolinsky: `flask.json_encoder` 有支援 `datetime.datetime`? 但不支援 `datetime.date`，這裡用 `flask.json.JSONEncoder` 重新改寫過
  - [Better Python Object Serialization · Hynek Schlawack](https://hynek.me/articles/serialization/) (2016-08-22) 實作 `default()` 傳回 `JSONEncoder` 看得懂的東西，或是自己實作 `JSONEncoder`；但擴充性都很差，帶出了 PEP 443 #ril
  - [python \- How to overcome "datetime\.datetime not JSON serializable"? \- Stack Overflow](https://stackoverflow.com/questions/11875770/) jgbarah: 提供 `default` function，而 jmontes: 提出 `default=str` 的做法也滿妙的；或許可做為 `default` function 的 fallback?
  - [Encoders and Decoders - 19\.2\. json — JSON encoder and decoder — Python 3\.6\.4 documentation](https://docs.python.org/3/library/json.html#json.JSONEncoder.default) 出現 2 次 `def default(self, obj)` 的實作，最後都轉回 `json.JSONEncoder.default(self, obj)`。

