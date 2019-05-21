---
title: MySQL / Performance
---
# [MySQL](mysql.md) / Performance

## Slow Query Log ??

  - 透過記錄 slow query 可以幫忙點出效能有待改善的 SQL query；所謂 slow query 是指 query time 大於 `long_query_time` (預設 10 秒) 且涉及的資料筆數大於 `min_examined_row_limit` (預設 0) 者，不論過程中有沒有受惠於 index。

        > SHOW GLOBAL VARIABLES WHERE Variable_name LIKE '%slow%' OR Variable_name IN ('long_query_time', 'min_examined_row_limit', 'log_queries_not_using_indexes');
        +-------------------------------+--------------------------------------------------------------------------------------------------------------+
        | Variable_name                 | Value                                                                                                        |
        +-------------------------------+--------------------------------------------------------------------------------------------------------------+
        | log_queries_not_using_indexes | OFF                                                                                                          |
        | log_slow_filter               | admin,filesort,filesort_on_disk,full_join,full_scan,query_cache,query_cache_miss,tmp_table,tmp_table_on_disk |
        | log_slow_rate_limit           | 1                                                                                                            |
        | log_slow_verbosity            | query_plan                                                                                                   |
        | long_query_time               | 10.000000                                                                                                    |
        | min_examined_row_limit        | 0                                                                                                            |
        | slow_launch_time              | 2                                                                                                            |
        | slow_query_log                | OFF                                                                                                          |
        | slow_query_log_file           | /var/log/mysql/mariadb-slow.log                                                                              |
        +-------------------------------+--------------------------------------------------------------------------------------------------------------+
        9 rows in set (0.00 sec)

  - 預設不會啟用，執行期可以透過 `SET GLOBAL slow_query_log = ON;` 啟用 (需要有 `SUPER` 權限)。
  - 記錄 slow query 是第一步，找到源頭 -- 哪一段程式送出這個 query -- 才是最花時間的，由於 slow query log 會揭露 `User@Host: ...`，如果每個應用程式都有用不同的身份連線，可以加快釐清問題的速度。

參考資料：

  - [MySQL :: MySQL 8\.0 Reference Manual :: 5\.4\.5 The Slow Query Log](https://dev.mysql.com/doc/refman/8.0/en/slow-query-log.html) #ril

      - The slow query log consists of SQL statements that take more than `long_query_time` seconds to execute and require at least `min_examined_row_limit` rows to be examined. The slow query log can be used to find queries that take a long time to execute and are therefore CANDIDATES FOR OPTIMIZATION. However, examining a long slow query log can be a TIME-CONSUMING TASK. To make this easier, you can use the `mysqldumpslow` command to process a slow query log file and summarize its contents. See Section 4.6.9, “mysqldumpslow — Summarize Slow Query Log Files”.

      - The time to acquire the INITIAL LOCKS is not counted as execution time. mysqld writes a statement to the slow query log after it has been executed and after all locks have been released, so LOG ORDER might differ from EXECUTION ORDER.

        但為什麼下面 Slow Query Log Contents 提到 Lock_time: duration -- The time to acquire locks in seconds. ??

    Slow Query Log Parameters

      - The minimum and default values of `long_query_time` are 0 and 10, respectively. The value can be specified to a resolution of microseconds.

      - By default, administrative statements are not logged, nor are queries that DO NOT USE INDEXES for lookups. This behavior can be changed using `log_slow_admin_statements` and `log_queries_not_using_indexes`, as described later.

        "NOR are queries that do not use indexes" 這說法可能會造成誤會，因為就算沒用 index，只要 query time 超過 `long_query_time` 就會被記錄。所謂 `log_queries_not_using_indexes` 是指要不要 "額外" 記錄沒有用 index 的 query，不管時間是否超過 `long_query_time`。

      - By default, the slow query log is disabled. To specify the initial slow query log state explicitly, use `--slow_query_log[={0|1}]`. With no argument or an argument of `1`, `--slow_query_log` enables the log. With an argument of `0`, this option disables the log. To specify a log file name, use `--slow_query_log_file=file_name`. To specify the log destination, use the `log_output` system variable (as described in Section 5.4.1, “Selecting General Query Log and Slow Query Log Output Destinations”).

        要在 runtime 啟用 slow query log，可以用 `SET GLOBAL slow_query_log = ON;`

  - [profiling \- Mysql: What is the difference between "slow\_query\_log" vs "log\_slow\_queries" \- Stack Overflow](https://stackoverflow.com/questions/10755151)

      - Sean: `log_slow_queries` was deprecated in MySQL 5.1.29 by `slow-query-log`. The MySQL 5.1 Reference Manual has more details.

      - Rahul: [MySQL :: MySQL 5\.5 Reference Manual :: 5\.1\.6 Server Command Options](https://dev.mysql.com/doc/refman/5.5/en/server-options.html#option_mysqld_log-slow-queries):

        > The `--log-slow-queries` option is deprecated and is removed (along with the `log_slow_queries` system variable) in MySQL 5.6. Instead, use the `--slow_query_log` option to enable the slow query log and the `--slow_query_log_file=file_name` option to set the slow query log file name.

  - [mysql \- Enabling "log\_queries\_not\_using\_indexes" disables "long\_query\_time"? \- Database Administrators Stack Exchange](https://dba.stackexchange.com/questions/29582)

      - coolcfan: is there a way to log all the queries which take longer time than long_query_time, REGARDLESS of whether they are using indexes?

      - drogart: That is expected behavior. Refer to the docs online, but in summary:

          - `long_query_time` is the threshold for query execution time beyond which it is logged. Any queries taking longer than the threshold are logged, REGARDLESS OF WHETHER THEY USE AN INDEX OR NOT.
          - `log_queries_not_using_indexes` tells MySQL to ADDITIONALLY log all queries that do not use an index to limit the number of rows scanned. Logging on this condition happens REGARDLESS OF EXECUTION TIME.

        Hope that helps explain what you are seeing. It seems like you probably just want `long_query_time` and not `log_queries_not_using_indexes` if your goal is to only capture queries that take longer than a particular threshold.

  - [MySQL :: MySQL 8\.0 Reference Manual :: 4\.6\.9 mysqldumpslow — Summarize Slow Query Log Files](https://dev.mysql.com/doc/refman/8.0/en/mysqldumpslow.html) #ril

