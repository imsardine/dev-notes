---
:title: MySQL / Data Type
---
# [MySQL](mysql.md) / Data Type

## NULL

  - [MySQL :: MySQL 8\.0 Reference Manual :: 9\.1\.7 NULL Values](https://dev.mysql.com/doc/refman/8.0/en/null-values.html) #ril
  - [MySQL :: MySQL 8\.0 Reference Manual :: 3\.3\.4\.6 Working with NULL Values](https://dev.mysql.com/doc/refman/8.0/en/working-with-null.html) #ril
  - [MySQL :: MySQL 8\.0 Reference Manual :: B\.4\.4\.3 Problems with NULL Values](https://dev.mysql.com/doc/refman/8.0/en/problems-with-null.html) #ril
  - [MySQL :: MySQL 8\.0 Reference Manual :: 8\.2\.1\.15 IS NULL Optimization](https://dev.mysql.com/doc/refman/8.0/en/is-null-optimization.html) #ril

  - [Indexing NULLs - 4\. Indexes \- High Performance MySQL \[Book\]](https://www.oreilly.com/library/view/high-performance-mysql/0596003064/ch04.html#hpmysql-CHP-4-SECT-1.1.7) #ril

## 少用 NULL ? {: #less-null }

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

      - You should define fields as `NOT NULL` whenever you can. A lot of tables include nullable columns even when the application DOES NOT NEED to store `NULL` (the absence of a value), MERELY BECAUSE it's the default. You should be careful to specify columns as `NOT NULL` unless you intend to sore `NULL` in them.

        要想過真的需要用，而不是沒想過而直接做為 nullable 即可 -- 當用則用；跟 [MySQL Reference Manual](https://dev.mysql.com/doc/refman/8.0/en/data-size.html#data-size-table-columns) 的論點一致。

      - It's harder for MySQL to optimize queries that refer to nullable columns, because they make INDEXES, index statistics, and value comparisons more complicated. A nullable column uses more storage space and require special processing inside MySQL. When a nullable column is indexed, it requires an extra byte per entry and can even cause a fixed-size index (such as an index on a single integer column) to be converted a variable-sized one in MyISAM.

      - Even when you do need to store a "no value" fact in a table, you MIGHT NOT need to use `NULL`. Consider using zero, a special value, or an empty string instead.

        注意這裡 "might not" (可能不) 的用法，只是提供 `NOT NULL` 時如何表達 "absence of a value" 可能的做法。

      - The performance improvment from changing `NULL` columns to `NOT NULL` is usually SMALL, so don't make finding and changing them on an existing schema a priority unless you know they are causing problems. However, if you're planning to index columns, avoid making them nullable IF POSSIBLE.

        看起來 nullable column 做為 index 時比較有影響。
