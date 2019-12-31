---
title: Java / Data/Time
---
# [Java](java.md) / Date/Time

  - [Date \(Java Platform SE 8 \)](https://docs.oracle.com/javase/8/docs/api/java/util/Date.html) #ril

      - The class `Date` represents a specific INSTANT in time, with MILLISECOND precision.

        注意 `Date` 不只是日期也包含時間，而且精度還到 millis。

      - Prior to JDK 1.1, the class `Date` had two additional functions. It allowed the interpretation of dates as year, month, day, hour, minute, and second values. It also allowed the formatting and parsing of date strings. Unfortunately, the API for these functions was not amenable to internationalization.

        As of JDK 1.1, the `Calendar` class should be used to convert between dates and time fields and the `DateFormat` class should be used to format and parse date strings. The corresponding methods in `Date` are deprecated.

        `Date` 本身還是會繼續存在，只是跟 date/time field 相關的操作都被標示為 deprecated，單純用來表示跟 1970-01-01 00:00:00Z 的時間差 (millis)。

      - Although the `Date` class is intended to reflect coordinated universal time (UTC), it may not do so exactly, depending on the host environment of the Java Virtual Machine. Nearly all modern operating systems assume that 1 day = 24 × 60 × 60 = 86400 seconds in all cases. In UTC, however, about once every year or two there is an extra second, called a "leap second." The leap second is always added as the last second of the day, and always on December 31 or June 30.

        For example, the last minute of the year 1995 was 61 seconds long, thanks to an added leap second. Most computer clocks are not accurate enough to be able to reflect the leap-second distinction. ??

  - [Trail: Date Time \(The Java™ Tutorials\)](https://docs.oracle.com/javase/tutorial/datetime/index.html) #ril
  - [Java SE 8 Date and Time](https://www.oracle.com/technical-resources/articles/java/jf14-date-time.html) #ril
  - [New Date\-Time API in Java 8 \- GeeksforGeeks](https://www.geeksforgeeks.org/new-date-time-api-java8/) #ril
  - [Java Date Time APIs](https://docs.oracle.com/javase/8/docs/technotes/guides/datetime/index.html) #ril

## 參考資料 {: #reference }

手冊：

  - [Package `java.util`](https://docs.oracle.com/javase/8/docs/api/java/util/package-summary.html)

      - [Class `Date`](https://docs.oracle.com/javase/8/docs/api/java/util/Date.html)

  - [Package `java.text`](https://docs.oracle.com/javase/8/docs/api/java/text/package-summary.html)

      - [Class `DateFormat`](https://docs.oracle.com/javase/8/docs/api/java/text/DateFormat.html)
      - [Class `SimpleDateFormat`](https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html)

  - [Package `java.time`](https://docs.oracle.com/javase/8/docs/api/java/time/package-summary.html)
