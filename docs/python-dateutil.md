# python-dateutil

  - [dateutil \- powerful extensions to datetime — dateutil 2\.8\.0 documentation](https://dateutil.readthedocs.io/en/stable/)

      - The `dateutil` module provides powerful extensions to the standard `datetime` module, available in Python.

    Features

      - Computing of relative deltas (next month, next year, next monday, last week of month, etc);
      - Computing of relative deltas between two given `date` and/or `datetime` objects;
      - Computing of dates based on very flexible recurrence rules, using a superset of the iCalendar specification. Parsing of RFC strings is supported as well.
      - GENERIC PARSING of dates in almost any string format;
      - Timezone (`tzinfo`) implementations for `tzfile(5)` format files (`/etc/localtime`, `/usr/share/zoneinfo`, etc), `TZ` environment string (in all known formats), iCalendar format files, given ranges (with help from relative deltas), local machine timezone, fixed offset timezone, UTC timezone, and Windows registry-based time zones.
      - Internal UP-TO-DATE world timezone information based on Olson’s database.
      - Computing of Easter Sunday dates for any given year, using Western, Orthodox or Julian algorithms;
      - A comprehensive test suite.

  - [dateutil \- powerful extensions to datetime — dateutil 2\.6\.1 documentation](https://dateutil.readthedocs.io/en/stable/) 抬頭寫著 "powerful extensions to datetime"，又 "Generic parsing of dates in almost any string format" 似乎是它的強項，另外也提供了 `tzinfo` 的實作。
  - [python \- How to parse an ISO 8601\-formatted date? \- Stack Overflow](https://stackoverflow.com/questions/127803/) 由於 `datetime.strptime()` 不好用，許多人推薦用 `python-dateutil` 來解析字串。

## 跟 pytz 的關係?

dateutil 主要是用它的工具 (尤其是 parsing)，需要用到 timezone 時，習慣上還是會用 pytz。但 Python 3.6 之後似乎建議用 `dateutil.tz`?

參考資料：

  - [Differences when working with pytz - Understanding datetime in Python: A primer \| Opensource\.com](https://opensource.com/article/17/5/understanding-datetime-python-primer) (2017-05-12) 為什麼會有 "Since Python 3.6, the recommended library to get the Olson database is dateutil.tz, but it used to be pytz." 這樣的說法? #ril
  - [dateutil \- powerful extensions to datetime — dateutil 2\.6\.1 documentation](https://dateutil.readthedocs.io/en/stable/) 提到 "Timezone (tzinfo) implementations for..." 及 "Internal up-to-date world timezone information based on Olson’s database." 看來就不需要 pytz 了?
  - [The Case for pytz over dateutil — Блог Дейла](http://www.assert.cc/2014/05/25/which-python-time-zone-library.html) (2014-05-25) dateutil 看似是 pytz 的 superset，除了 timezone info 外，還有一些好用的工具 #ril
  - [djangosnippets: Converting PDT to UTC using pytz and dateutil](https://www.djangosnippets.org/snippets/995/) (2008-08-21) 並用 pytz 與 dateutil，用 pytz 的 timezone 搭配 dateutil 的 parsing。
  - [Datetimes and Timezones and DST, oh my\! \(Example\)](https://coderwall.com/p/7t3qdq/datetimes-and-timezones-and-dst-oh-my) (2016-02-25) 一樣並用 pytz 與 dateutil。

## 新手上路 {: #getting-started }

  - [dateutil \- powerful extensions to datetime — dateutil 2\.8\.0 documentation](https://dateutil.readthedocs.io/en/stable/#quick-example)

      - Suppose you want to know HOW MUCH TIME IS LEFT, in years/months/days/etc, before the next easter happening on a year with a Friday 13th in August, and you want to get today’s date out of the “date” unix system command. Here is the code:

            >>> from dateutil.relativedelta import *
            >>> from dateutil.easter import *
            >>> from dateutil.rrule import *
            >>> from dateutil.parser import *
            >>> from datetime import *
            >>> now = parse("Sat Oct 11 17:13:46 UTC 2003")
            >>> today = now.date()
            >>> year = rrule(YEARLY,dtstart=now,bymonth=8,bymonthday=13,byweekday=FR)[0].year
            >>> rdelta = relativedelta(easter(year), today)
            >>> print("Today is: %s" % today)
            Today is: 2003-10-11
            >>> print("Year with next Aug 13th on a Friday is: %s" % year)
            Year with next Aug 13th on a Friday is: 2004
            >>> print("How far is the Easter of that year: %s" % rdelta)
            How far is the Easter of that year: relativedelta(months=+6)
            >>> print("And the Easter of that year is: %s" % (today+rdelta))
            And the Easter of that year is: 2004-04-11

        範例有點難懂 ??

  - [dateutil examples — dateutil 2\.8\.0 documentation](https://dateutil.readthedocs.io/en/stable/examples.html) #ril
  - [Exercises — dateutil 2\.8\.0 documentation](https://dateutil.readthedocs.io/en/stable/exercises/index.html) #ril

## Parsing ??

  - [parser — dateutil 2\.8\.0 documentation](https://dateutil.readthedocs.io/en/stable/parser.html) #ril

      - This module offers a GENERIC date/time string parser which is able to parse MOST KNOWN FORMATS to represent a date and/or time.

      - This module attempts to be FORGIVING with regards to unlikely input formats, returning a `datetime` object even for dates which are ambiguous. If an element of a date/time stamp is omitted, the following rules are applied:

          - If AM or PM is left unspecified, a 24-hour clock is assumed, however, an hour on a 12-hour clock (`0 <= hour <= 12`) must be specified if AM or PM is specified.

          - If a time zone is omitted, a timezone-NAIVE `datetime` is returned.

          - If any other elements are missing, they are taken from the `datetime.datetime` object passed to the parameter `default`.

            但為何 `parser.parse('May 3')` 會得到 `datetime.datetime(2019, 5, 3, 0, 0)`? 原來 [`dateutil.parser.parse` 的實作](https://github.com/dateutil/dateutil/blob/2.8.0/dateutil/parser/_parser.py#L642) 會拿當天的零時零分做為預設值：

                default = datetime.datetime.now().replace(hour=0, minute=0, second=0, microsecond=0)

            If this results in a day number exceeding the valid number of days per month, the value FALLS BACK TO THE END OF THE MONTH.

            但為何 `parser.parse('Feb. 30')` 會丟 `ValueError: day is out of range for month` 的錯誤 ??

      - Additional resources about date/time string formats can be found below:

          - [A summary of the international standard date and time notation](http://www.cl.cam.ac.uk/~mgk25/iso-time.html)
          - [W3C Date and Time Formats](http://www.w3.org/TR/NOTE-datetime)
          - [Time Formats (Planetary Rings Node)](https://pds-rings.seti.org/tools/time_formats.html)
          - [CPAN ParseDate module](http://search.cpan.org/~muir/Time-modules-2013.0912/lib/Time/ParseDate.pm)
          - [Java SimpleDateFormat Class](https://docs.oracle.com/javase/6/docs/api/java/text/SimpleDateFormat.html)

  - [parser — dateutil 2\.6\.1 documentation](http://dateutil.readthedocs.io/en/stable/parser.html) "This module offers a generic date/time string parser which is able to parse most known formats to represent a date and/or time."

## 安裝設定 {: #installation }

用 `pip` 安裝 `python-dateutil` 套件即可：(注意不是 `dateutil`)

```
pip install python-dateutil
```

## 參考資料 {: #reference }

  - [dateutil](https://dateutil.readthedocs.io/en/stable/)
  - [dateutil/dateutil - GitHub](https://github.com/dateutil/dateutil/)
  - [python-dateutil - PyPI](https://pypi.python.org/pypi/python-dateutil)

手冊：

  - [Changelog](https://dateutil.readthedocs.io/en/stable/changelog.html)
  - [dateutil Documentation](https://dateutil.readthedocs.io/en/stable/)
