---
title: MySQL / Data Type
---
# [MySQL](mysql.md) / Data Type

## NULL

  - [MySQL :: MySQL 8\.0 Reference Manual :: 9\.1\.7 NULL Values](https://dev.mysql.com/doc/refman/8.0/en/null-values.html) #ril
  - [MySQL :: MySQL 8\.0 Reference Manual :: 3\.3\.4\.6 Working with NULL Values](https://dev.mysql.com/doc/refman/8.0/en/working-with-null.html) #ril
  - [MySQL :: MySQL 8\.0 Reference Manual :: B\.4\.4\.3 Problems with NULL Values](https://dev.mysql.com/doc/refman/8.0/en/problems-with-null.html) #ril
  - [MySQL :: MySQL 8\.0 Reference Manual :: 8\.2\.1\.15 IS NULL Optimization](https://dev.mysql.com/doc/refman/8.0/en/is-null-optimization.html) #ril

  - [Indexing NULLs - 4\. Indexes \- High Performance MySQL \[Book\]](https://www.oreilly.com/library/view/high-performance-mysql/0596003064/ch04.html#hpmysql-CHP-4-SECT-1.1.7) #ril

## 少用 NULL ? {: #less-null }

  - `NULL` 就是要保守的用 — 當用則用，沒有不該使用的理由。

    合理的使用情境類似 `deleted_at`、`confi

  - 功能面必須提供 "暫存" 時，可能會導致許多欄位都必須 allow `NULL`，該如何緩解？

    如果資料離開 “草稿” 時就應該有值，就不適合 allow `NULL`，應該有其他方式可以解，不管 column type 為何。
    例如新增記錄時，使用者編修的畫面就已經提供合理的預設值，例如今天的日期、空白等，所以使用者按下暫存時，就不需要用 `NULL` 來表現。

---

參考資料：

  - [Table Columns - MySQL :: MySQL 8\.0 Reference Manual :: 8\.4\.1 Optimizing Data Size](https://dev.mysql.com/doc/refman/8.0/en/data-size.html#data-size-table-columns)

    Declare columns to be `NOT NULL` if possible. It makes SQL operations FASTER, by enabling better use of indexes and eliminating OVERHEAD for testing whether each value is `NULL`. You also save some storage space, ONE BIT PER COLUMN.

    If you really need `NULL` values in your tables, use them. Just avoid the DEFAULT setting that allows `NULL` values in EVERY column.

    當用則用。

  - [sql \- NULL in MySQL \(Performance & Storage\) \- Stack Overflow](https://stackoverflow.com/questions/229179/)

      - Bill Karwin (2008-10-23): It depends on which storage engine you use.

          - In MyISAM format, each ROW HEADER contains a bitfield with one bit for each column to encode `NULL` state. A column that is `NULL` still takes up space, so `NULL`'s don't reduce storage. See https://dev.mysql.com/doc/internals/en/myisam-introduction.html
          - In InnoDB, each column has a "field start offset" in the row header, which is one or two bytes per column. The high bit in that field start offset is on if the column is `NULL`. In that case, the column doesn't need to be stored at all. So if you have a lot of `NULL`'s your storage should be significantly reduced. See https://dev.mysql.com/doc/internals/en/innodb-field-contents.html

        EDIT:

          - The `NULL` bits are part of the row headers, you don't choose to add them.
          - The only way I can imagine `NULL`s improving performance is that in InnoDB, a page of data may fit more rows if the rows contain `NULL`s. So your InnoDB buffers may be more effective.

          - But I would be very surprised if this provides a significant performance advantage in practice. Worrying about the effect `NULL`s have on PERFORMANCE is in the realm of MICRO-OPTIMIZATION.

            You should focus your attention elsewhere, in areas that give greater bang for the buck. For example adding well-chosen indexes or increasing database cache allocation.

        話說回來，用 `NULL` 也不是為了 performance。

      - Arian Acosta (2015-08-18): Bill's answer is good, but a little bit outdated. The use of one or two bytes for storing `NULL` applies only to InnoDB REDUNDANT row format. Since MySQL 5.0.3 InnoDB uses COMPACT row format which uses only one bit to store a `NULL` (of course one byte is the minimum), therefore:

          - Space Required for `NULL`s = `CEILING(N/8)` bytes where `N` is the number of `NULL` columns in a row.

                0 NULLS = 0 bytes
                1 - 8 NULLS = 1 byte
                9 - 16 NULLS = 2 bytes
                17 - 24 NULLS = 3 bytes
                etc...

          - According to the official MySQL site about COMPACT vs REDUNDANT:

            The compact row format decreases row storage space by about 20% at the cost of increasing CPU use for some operations. If your workload is a typical one that is limited by cache hit rates and disk speed, compact format is likely to be faster. ??

          - Advantage of using `NULL`S over Empty Strings or Zeros:

              - 1 `NULL` requires 1 byte
              - 1 `Empty` String requires 1 byte (assuming `VARCHAR`)
              - 1 Zero requires 4 bytes (assuming `INT`)

            You start to see the savings here:

              - 8 `NULL`s require 1 byte
              - 8 Empty Strings require 8 bytes
              - 8 Zeros require 32 bytes

            On the other hand, I suggest using `NULL`s over empty strings or zeros, because they're more ORGANIZED, PORTABLE, and require less space. To improve performance and save space, focus on using the proper data types, indexes, and queries instead of WEIRD TRICKS.

            More on: https://dev.mysql.com/doc/refman/5.7/en/innodb-physical-record.html

            話說回來，用 `NULL` 也不是為了省空間。

      - Captain Hypertext (2015-03-8): I would agree with Bill Karwin, although I would add [these MySQL tips](https://code.tutsplus.com/tutorials/top-20-mysql-best-practices--net-7855). Number 11 addresses this specifically:

        > First of all, ask yourself if there is any DIFFERENCE between having an empty string value vs. a `NULL` value (for `INT` fields: 0 vs. `NULL`). If there is NO REASON to HAVE BOTH, you do not need a `NULL` field. (Did you know that Oracle considers `NULL` and empty string as being the same?)
        >
        > `NULL` columns require additional space and they can add complexity to your comparison statements. Just avoid them when you can. However, I understand some people might have very specific reasons to have `NULL` values, which is NOT ALWAYS A BAD THING.

        主要是省空間的考量。

        On the other hand, I still utilize null on tables that DON'T HAVE TONS OF ROWS, mostly because I like the logic of saying `NOT NULL`.

        Update: Revisiting this later, I would add that I personally DON'T like to use `0` instead of `NULL` in the database, and I don't recommend it. This can easily lead to a lot of FALSE POSITIVES in your application if you are not careful.

        畢竟 empty string 是個特殊值，需要另外處理。

  - [Avoid NULL if possible - Choosing Optimal Data Types - High Performance MySQL: Optimization, Backups, Replication, and More \- Baron Schwartz, Peter Zaitsev, Vadim Tkachenko, Jeremy D\. Zawodny, Arjen Lentz, Derek J\. Balling \- Google Books](https://books.google.com.tw/books?id=BL0NNoFPuAQC&pg=PA81&lpg=PA81&dq=mysql+null+performance)

      - You should define fields as `NOT NULL` whenever you can. A lot of tables include nullable columns even when the application DOES NOT NEED to store `NULL` (the absence of a value), MERELY BECAUSE it's the default. You should be careful to specify columns as `NOT NULL` unless you INTEND to sore `NULL` in them.

        要想過真的需要用，而不是沒想過而直接做為 nullable 即可 -- 當用則用；跟 [MySQL Reference Manual](https://dev.mysql.com/doc/refman/8.0/en/data-size.html#data-size-table-columns) 的論點一致。

      - It's harder for MySQL to optimize queries that refer to nullable columns, because they make INDEXES, index statistics, and value comparisons more complicated. A nullable column uses more storage space and require special processing inside MySQL.

        When a nullable column is indexed, it requires an extra byte per entry and can even cause a fixed-size index (such as an index on a single integer column) to be converted a variable-sized one in MyISAM.

      - Even when you do need to store a "no value" fact in a table, you MIGHT NOT need to use `NULL`. Consider using zero, a special value, or an empty string instead.

        注意這裡 "might not" (可能不) 的用法，只是提供 `NOT NULL` 時如何表達 "absence of a value" 可能的做法；雖然這呼應了標題 "Avoid NULL if possible" 的說法 (針對下面的 index?)，但還是要考量 code 會不會因此變得複雜，甚至影響 maintainability。

      - The performance improvment from changing `NULL` columns to `NOT NULL` is usually SMALL, so don't make finding and changing them on an existing schema a priority unless you know they are causing problems. However, if you're planning to index columns, avoid making them nullable IF POSSIBLE.

        看起來 nullable column 做為 index 時比較有影響。

  - [Upgrading to MySQL 5\.7? Beware of the new STRICT mode \- Percona Database Performance Blog](https://www.percona.com/blog/2016/10/18/upgrading-to-mysql-5-7-beware-of-the-new-strict-mode/) (2016-10-18)

      - If we can’t use `NULL`, we will have to create a default value. In strict mode we can’t use “0000-00-00” either:

            mysql> alter table events_t change event_date event_date datetime NOT NULL default '0000-00-00 00:00:00';
            ERROR 1067 (42000): Invalid default value for 'event_date'
            mysql> alter table events_t change event_date event_date datetime NOT NULL default '2000-00-00 00:00:00';
            ERROR 1067 (42000): Invalid default value for 'event_date'

        We have to use a real date:

            mysql> alter table events_t change event_date event_date datetime NOT NULL default '2000-01-01 00:00:00';
            Query OK, 0 rows affected (0.00 sec)
            Records: 0 Duplicates: 0 Warnings: 0

            mysql> insert into events_t (profile_id) values (1);
            Query OK, 1 row affected (0.00 sec)

      - Or, a most likely much BETTER APPROACH is to change the application logic to:

          - allow `NULL`s, or
          - always insert the real dates (i.e. use `NOW()` function), or
          - change the table field to TIMESTAMP and update it automatically if no value has been assigned

        這裡沒有說明 timestamp 如何表現 "no value" ??

  - [Handling NULL Values in PostgreSQL \- Percona Database Performance Blog](https://www.percona.com/blog/2020/03/05/handling-null-values-in-postgresql/) (2020-03-05)

      - There is often some confusion about `NULL` value, as it is TREATED DIFFERENTLY IN DIFFERENT LANGUAGES. So there is an obvious need to clarify what `NULL` is, how it works in different languages, and what the actual value is behind the `NULL`.

      - Before going into details, there is also a need to understand the concept of [THREE-VALUED LOGIC](https://en.wikipedia.org/wiki/Three-valued_logic) and [TWO-VALUED LOGIC](https://en.wikipedia.org/wiki/Principle_of_bivalence) known as bivalent.

        The bivalent is a concept of boolean value where value can be true or false, but contrary to bivalent the three-valued logic can be true, false, or (intermediate value) unknown. Now, back to `NULL`. In some languages `NULL` acts as bivalent, and in others, three-valued logic (especially in databases).

        當我們在講 ORM 時，應該都有 [Null pointer](https://en.wikipedia.org/wiki/Null_pointer) 的概念，處理上應該不會有什麼差異? 更何況，這種差異應該是各程式語言要自己處理的，不應該成為不該用 `NULL` 的理由。

    Usage of `NULL`

      - If `NULL` does not have any value, then what is the ADVANTAGE of NULL? Here are some examples of usage:

      - In case a field does not have any value, and for example, we have database fields with first/middle and last name. Does, in reality, everybody have a first/middle and last name? The answer is no, there shouldn’t be a field that cannot have any value.

        The other usage of `NULL` is to represent an empty string and empty numeric value. Numeric 0 HAS SIGNIFICANCE so it cannot be used to represent the empty numeric filed, the unknown value at a certain time.

        `NULL` 有它的使用時機，雖然這篇是在講 PostgreSQL，但也不見儘量不要用 `NULL` 的主張，只說使用上要小心。

    Conclusion

      - The purpose of this blog is to be clear about the fact that every language has its own meaning of `NULL`. Therefore, be careful when you are using `NULL`, otherwise, you will get erroneous results. Especially in databases (PostgreSQL), `NULL` has some different concepts, so be careful when writing queries involving `NULL`.

## YearMon

  - 只有年月要儲存時，DB 欄位的型態要用 `CHAR(7)` (例如 `2020-01`) 還是 `DATE` (但日的部份用不到)？
  - 從 storage 來看，`CHAR(7)` 佔 6 x 4 = 24 bytes (以 `utf8mb4` 為例)，但 `DATE` 只有 3 bytes。
  - `CHAR(7)` 要做 data range 的查詢雖然不會有問題，但背後其實是 [collation](mysql-collation.md) 在決定大小，也不是那麼妥當，況且字串比對的效能一定不會比 `DATE` 來得快。

  - `2020-01` 是 date 的一種 representation，也可能是 `2020/01` 或 `2020/1`，不應該將兩者混淆；況且這類資料輸入時一定會轉成 date 做 validation，那就更沒理由再轉回 representation 才存進 DB。

  - 用 `DATE` 可以搭配 constraint 限定日期的部份一定要是每月 1 號

        mysql> CREATE TABLE `data` (`id` INT UNSIGNED NOT NULL AUTO_INCREMENT, `yearmon` DATE NOT NULL, PRIMARY KEY (`id`), CONSTRAINT `yearmon_1stday` CHECK (DAYOFMONTH(`yearmon`) = 1)) ;
        mysql> mysql> INSERT INTO data (yearmon) VALUES ('2020-12-01');
        Query OK, 1 row affected (0.02 sec)
        mysql> INSERT INTO data (yearmon) VALUES ('2020-12-02');
        ERROR 3819 (HY000): Check constraint 'yearmon_1stday' is violated.

  - 將年、月分開存成兩個 integer 欄位看似可行，但遇到 date range 的查詢，會比 `CHAR(7)` 更難處理；如何查出介於 2019-06 ~ 2021-06 的資料?

---

參考資料：

  - [How to map the Java YearMonth type with JPA and Hibernate \- Vlad Mihalcea](https://vladmihalcea.com/java-yearmonth-jpa-hibernate/) (2019-02-19)

    Mapping this entity to a database table requires choosing a column type for the `YearMonth` property. For this purpose we have the following options:

      - We could save it in a `String` column type (e.g., `CHAR(6)`), but that will require 6-byte storage.
      - We could save it as a `Date` column type, which requires 4 bytes.
      - We could save it in a 3 or 4-byte Integer column type.

    Because the `String` alternative is the LEAST EFFICIENT, we are going to choose the `Date` and the `Integer` alternatives instead.

  - [sql \- what type of data type use for year and month? \- Stack Overflow](https://stackoverflow.com/questions/7802879)

      - paxdiablo: Normally, I would advise to use the DATE date types no matter what your restrictions, since it allows you to do DATE MANIPULATIONS AND COMPARISONS. You could then use triggers to restrict dates to the first of the month. You'd need triggers to ensure that you couldn't get two rows for a single month/year combo.

        Actually, as `Damian_The_Unbeliever` rightly points out in a comment, you don't need triggers if your intent is to only allow users to attempt insertion of dates where the day of the month is 1. In that case, constraints will probably be enough. It's only the case where you want to allow users to attempt to insert any date but actually force it to become the first day of that month, that triggers would be required.

        原來 constraint 可以做單一欄位的檢查，將年、月分開存好像不錯，不過遇到 range 的查詢時會出狀況。

        However, in this case, I'd be quite happy with a TWO-COLUMN year/month setup, based on your use case.

        By using two integer-type columns, you don't need to worry about triggers, and you don't seem to have a need for massive processing of the table contents, based on your column specifications.

        I wouldn't store them as a single integer-type column if you ever foresee the need to process data for a given year (independent of the month). Having the year separate will allow a distinct index which will probably be faster than getting a range of `YYYYMM` values.

        Seriously, choose the one that you think will be EASIEST TO CODE UP (and meets the functional requirements). Then if, and only if, you discover a performance problem, look into a schema re-org. Databases are NOT SET-AND-FORGET THINGS, you should be constantly monitoring them for problems and, if necessary, changing things.

## 參考資料 {: #reference }

  - [Data Type Storage Requirements](https://dev.mysql.com/doc/refman/8.0/en/storage-requirements.html)
