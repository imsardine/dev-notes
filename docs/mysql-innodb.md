---
title: MySQL / InnoDB Storage Engine
---
# [MySQL](mysql.md) / InnoDB Storage Engine

  - [Week 9 \- YouTube](https://www.youtube.com/watch?time_continue=1428&v=NWc9GWSSfkk) InnoDB 唸做 [ˈɪno-di-bi]。

## Transaction ??

```
$ docker volume create mysql-data
$ MYSQL_VERSION=5 # 8
$ docker run --rm --name mysql -d \
    -v mysql-data:/var/lib/mysql \
    --env MYSQL_DATABASE=mydb \
    --env MYSQL_USER=appuser \
    --env MYSQL_PASSWORD=secret \
    --env MYSQL_ROOT_PASSWORD=admin \
    mysql:$MYSQL_VERSION
```

建兩個 connection/session 代表不同的 transaction -- T1, T2

```
$ docker exec -it mysql mysql -u appuser -p mydb # T1
$ docker exec -it mysql mysql -u appuser -p mydb # T2
```

先用任一個 connection 觀察一些預設值，並建立基本資料：

```
mysql> SHOW VARIABLES WHERE variable_name IN ('autocommit', 'tx_isolation');
+---------------+-----------------+
| Variable_name | Value           |
+---------------+-----------------+
| autocommit    | ON              |
| tx_isolation  | REPEATABLE-READ |
+---------------+-----------------+
2 rows in set (0.00 sec)

mysql> CREATE TABLE user (
    -> id INT UNSIGNED NOT NULL,
    -> name VARCHAR(20) NOT NULL,
    -> login_counter INT UNSIGNED NOT NULL DEFAULT 0
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> INSERT INTO user (id, name) VALUES (1, 'jamesbond');
Query OK, 1 row affected (0.00 sec)
```

以下開始進行一些實驗 -- 同一個使用者幾乎同一個時間在兩個地方登入，計數器會不會有失真？

```
T1> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

T2> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

T1> SELECT login_counter FROM user WHERE id = 1 INTO @counter;
Query OK, 1 row affected (0.01 sec)

T2> SELECT login_counter FROM user WHERE id = 1 INTO @counter;
Query OK, 1 row affected (0.00 sec)

T1> UPDATE user SET login_counter = @counter + 1 WHERE id = 1;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

T2> UPDATE user SET login_counter = @counter + 1 WHERE id = 1;
...
ERROR 1205 (HY000): Lock wait timeout exceeded; try restarting transaction

T1> COMMIT;
Query OK, 0 rows affected (0.01 sec)

T2 > ...
Query OK, 0 rows affected (3.78 sec) <-- 等 T1
Rows matched: 1  Changed: 0  Warnings: 0

T1> SELECT * FROM user;
+----+-----------+---------------+
| id | name      | login_counter |
+----+-----------+---------------+
|  1 | jamesbond |             1 |
+----+-----------+---------------+
1 row in set (0.00 sec)

T2> SELECT * FROM user;
+----+-----------+---------------+
| id | name      | login_counter |
+----+-----------+---------------+
|  1 | jamesbond |             1 |
+----+-----------+---------------+
1 row in set (0.00 sec)
```

結果發生 lost updates -- 瞬間登入 2 次，但卻只記錄到一次。

用 IX row-level locking (`SELECT ... FOR UPDATE`) 重做一次：

```
T1> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

T2> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

T1> SELECT login_counter FROM user WHERE id = 1 INTO @counter FOR UPDATE;
Query OK, 1 row affected (0.01 sec)

T2> SELECT login_counter FROM user WHERE id = 1 INTO @counter FOR UPDATE;
...

T1> UPDATE user SET login_counter = @counter + 1 WHERE id = 1;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

T1> COMMIT;
Query OK, 0 rows affected (0.01 sec)

T2> ...
Query OK, 1 row affected (20.23 sec) <-- 等 T1

T1> SELECT * FROM user;
+----+-----------+---------------+
| id | name      | login_counter |
+----+-----------+---------------+
|  1 | jamesbond |             2 |
+----+-----------+---------------+
1 row in set (0.00 sec)

T2> UPDATE user SET login_counter = @counter + 1 WHERE id = 1;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

T2> COMMIT;
Query OK, 0 rows affected (0.00 sec)

T2> SELECT * FROM user;
+----+-----------+---------------+
| id | name      | login_counter |
+----+-----------+---------------+
|  1 | jamesbond |             3 |
+----+-----------+---------------+
1 row in set (0.00 sec)
```

這次沒再發生 lost update 了。過程中若 T2 等太久，會發生下面的錯誤：

```
ERROR 1205 (HY000): Lock wait timeout exceeded; try restarting transaction
```

---

參考資料：

  - [MySQL :: MySQL 8\.0 Reference Manual :: 15\.7\.2 InnoDB Transaction Model](https://dev.mysql.com/doc/refman/8.0/en/innodb-transaction-model.html)

      - In the InnoDB transaction model, the goal is to COMBINE the best properties of a MULTI-VERSIONING DATABASE with traditional TWO-PHASE LOCKING. InnoDB performs LOCKING AT THE ROW LEVEL and runs queries as NONLOCKING CONSISTENT READS by default, in the style of Oracle.

        其中 nonlocking consistent reads 指的就是 repeatable reads，跟 multiversion concurrency control (MVCC) 有關。

        The lock information in InnoDB is stored space-efficiently so that lock escalation is not needed. Typically, several users are permitted to lock every row in InnoDB tables, or any random subset of the rows, without causing InnoDB memory exhaustion.

  - [MVCC - MySQL :: MySQL 8\.0 Reference Manual :: MySQL Glossary](https://dev.mysql.com/doc/refman/8.0/en/glossary.html#glos_mvcc)

      - Acronym for “multiversion concurrency control”. This technique lets InnoDB transactions with CERTAIN isolation levels perform CONSISTENT READ operations; that is, to query rows that are being updated by other transactions, and see the values from before those updates occurred.

        This is a powerful technique to INCREASE CONCURRENCY, by allowing queries to proceed WITHOUT WAITING due to locks held by the other transactions.

      - This technique is not universal in the database world. Some other database products, and some other MySQL storage engines, do not support it.

  - [Consistent Read - MySQL :: MySQL 8\.0 Reference Manual :: MySQL Glossary](https://dev.mysql.com/doc/refman/8.0/en/glossary.html#glos_consistent_read)

      - A read operation that uses SNAPSHOT information to present query results based on a point in time, regardless of changes performed by other transactions running at the same time. If queried data has been changed by another transaction, the original data is RECONSTRUCTED based on the contents of the UNDO LOG. This technique avoids some of the locking issues that can REDUCE CONCURRENCY by forcing transactions to WAIT for other transactions to finish.

      - With REPEATABLE READ isolation level, the snapshot is based on the time when THE FIRST READ OPERATION IS PERFORMED. With READ COMMITTED isolation level, the snapshot is RESET TO THE TIME OF EACH CONSISTENT READ OPERATION.

        不太理解為什麼是 "each" consistent read operation，不過若時候不往後推，確實會看不到 committed changes。

      - Consistent read is the DEFAULT MODE in which InnoDB processes `SELECT` statements in `READ COMMITTED` and `REPEATABLE READ` isolation levels. Because a consistent read does NOT SET ANY LOCKS on the tables it accesses, other sessions are free to modify those tables while a consistent read is being performed on the table.

      - For technical details about the applicable isolation levels, see Section 15.7.2.3, “Consistent Nonlocking Reads”.

        [Consistent Nonlocking Reads](https://dev.mysql.com/doc/refman/8.0/en/innodb-consistent-read.html) 一開始就提到 "A consistent read means that InnoDB uses MULTI-VERSIONING to present to a query a snapshot of the database at a point in time."

  - [mysql \- InnoDB MVCC vs Locking \- Database Administrators Stack Exchange](https://dba.stackexchange.com/questions/134218/)

      - TheOddGuy: when does locking or mvcc occur? Where do I need to specify which one the database should use?

      - Morgan Tocker: MVCC applies to isolation levels read-committed and repeatable read (default).

        You don't need to specify anything for both of these features to WORK TOGETHER. Maybe one way to think about it, is that row level locking is important so that you can update multiple rows at a time, and MVCC is so that the updates don't affect read operations at all.

        其中 update multiple rows AT A TIME 似乎跟 range lock 有關?? 但可以確定的是 MVCC 跟 consistent read 有關，但跟 lock 無關，row-level lock 得透過 `SELECT ... FOR UPDATE` 來達成??

  - [MySQL :: MySQL 8\.0 Reference Manual :: 15\.7\.2\.1 Transaction Isolation Levels](https://dev.mysql.com/doc/refman/8.0/en/innodb-transaction-isolation-levels.html) #ril

      - Transaction isolation is one of the foundations of database processing. Isolation is the I in the acronym ACID; the isolation level is the setting that fine-tunes the BALANCE between performance and reliability, consistency, and reproducibility of results when multiple transactions are making changes and performing queries at the same time.
      - InnoDB offers all four transaction isolation levels described by the SQL:1992 standard: `READ UNCOMMITTED`, `READ COMMITTED`, `REPEATABLE READ`, and `SERIALIZABLE`. The default isolation level for InnoDB is `REPEATABLE READ`.

  - [MySQL :: MySQL 8\.0 Reference Manual :: 15\.7\.2\.2 autocommit, Commit, and Rollback](https://dev.mysql.com/doc/refman/8.0/en/innodb-autocommit-commit-rollback.html) #ril

      - In InnoDB, ALL USER ACTIVITY OCCURS INSIDE A TRANSACTION. If AUTOCOMMIT MODE is enabled, each SQL statement FORMS A SINGLE TRANSACTION ON ITS OWN.

        By default, MySQL starts the session for each new connection with autocommit enabled, so MySQL does a commit after each SQL statement if that statement did not return an error. If a statement returns an error, the commit or rollback behavior depends on the error.

        其中 session 跟 connection 是什麼關係? [try to understand mysql concepts: session v\.s\. connection \- Stack Overflow](https://stackoverflow.com/questions/8797724/try-to-understand-mysql-concepts-session-v-s-connection) newtover: A session is just a result of a SUCCESSFUL CONNECTION. Any MySQL client requires some connection settings to establish a connection and after the connection has been established it acquires a CONNECTION ID (thread id) and some context which is called session.

      - A session that has autocommit enabled can perform a MULTIPLE-STATEMENT TRANSACTION by starting it with an explicit `START TRANSACTION` or `BEGIN` statement and ending it with a `COMMIT` or `ROLLBACK statement`.

        If autocommit mode is disabled within a session with `SET autocommit = 0`, the session ALWAYS HAS A TRANSACTION OPEN. A `COMMIT` or `ROLLBACK` statement ENDS THE CURRENT TRANSACTI`ON AND A NEW ONE STARTS.

        當 autocommit = 1 時，`START TRANSACTION` 就是 "暫停" autocommit mode；當 autocommit = 0 時，不需 `START TRANSACTION` 就總是處於可以做 multiple-statement transaction 的狀態。結論就是所有的 statement 都會發生在 transaction 裡。

      - If a session that has autocommit disabled ends WITHOUT EXPLICITLY COMMITTING the final transaction, MySQL rolls back that transaction.

        Some statements implicitly end a transaction, as if you had done a `COMMIT` before executing the statement. 聽起來有點危險?

        [Statements That Cause an Implicit Commit](https://dev.mysql.com/doc/refman/8.0/en/implicit-commit.html) 提到 `START_TRANSACTION` 也會自動 commit!

        > Transactions CANNOT BE NESTED. This is a consequence of the implicit commit performed for any current transaction when you issue a `START TRANSACTION` statement or one of its synonyms.

      - A `COMMIT` means that the changes made in the current transaction are made permanent and become visible to other sessions. A `ROLLBACK` statement, on the other hand, cancels all modifications made by the current transaction. Both `COMMIT` and `ROLLBACK` release all InnoDB locks that were set during the current transaction.

  - [MySQL :: MySQL 8\.0 Reference Manual :: 15\.3 InnoDB Multi\-Versioning](https://dev.mysql.com/doc/refman/8.0/en/innodb-multi-versioning.html) #ril

      - InnoDB is a MULTI-VERSIONED storage engine: it keeps information about OLD VERSIONS OF CHANGED ROWS, to support transactional features such as concurrency and rollback.

        但也支援 table-/row-level locking，原以為這兩種 concurrency control 的做法不會同時存在。

        This information is stored in the tablespace in a data structure called a ROLLBACK SEGMENT (after an analogous data structure in Oracle). InnoDB uses the information in the rollback segment to perform the undo operations needed in a transaction rollback. It also uses the information to build earlier versions of a row for a consistent read.

  - [MySQL :: MySQL 8\.0 Reference Manual :: 15\.7\.1 InnoDB Locking](https://dev.mysql.com/doc/refman/8.0/en/innodb-locking.html) #ril

    Shared and Exclusive Locks

      - InnoDB implements standard ROW-LEVEL LOCKING where there are two types of locks, SHARED (S) locks and EXCLUSIVE (X) locks.

          - A shared (S) lock permits the transaction that holds the lock to read a row.
          - An exclusive (X) lock permits the transaction that holds the lock to update or delete a row.

      - If transaction T1 holds a shared (S) lock on row r, then requests from some distinct transaction T2 for a lock on row r are handled as follows:

          - A request by T2 for an S lock can be granted immediately. As a result, BOTH T1 and T2 hold an S lock on r. 這就是 "share" 的由來
          - A request by T2 for an X lock cannot be granted immediately.

      - If a transaction T1 holds an exclusive (X) lock on row r, a request from some distinct transaction T2 for a lock of either type on r cannot be granted immediately. Instead, transaction T2 has to WAIT FOR TRANSACTION T1 TO RELEASE ITS LOCK ON ROW r.

    Intention Locks

      - InnoDB supports MULTIPLE GRANULARITY locking which permits COEXISTENCE OF ROW LOCKS AND TABLE LOCKS. 突然冒出 table lock??

        For example, a statement such as `LOCK TABLES ... WRITE` takes an exclusive lock (an X lock) on the specified table. To make locking at multiple granularity levels practical, InnoDB uses INTENTION LOCKS. Intention locks are table-level locks that indicate which type of lock (shared or exclusive) a transaction requires later FOR A ROW in a table. There are two types of intention locks:

        搞不懂 S/IS 跟 X/IX 的差別，`SELECT ... FOR SHARE/UPDATE` 似乎是 IS/IX (針對 row)，而 `LOCK TABLES ... READ/WRITE` 似乎是 S/X (針對 table)，但下面又出現 "first acquire an IS lock or stronger ON THE TABLE" 的說法 ??

          - An intention shared lock (IS) indicates that a transaction intends to set a shared lock on INDIVIDUAL ROWS in a table.
          - An intention exclusive lock (IX) indicates that that a transaction intends to set an exclusive lock on INDIVIDUAL ROWS in a table.

      - For example, `SELECT ... FOR SHARE` sets an IS lock, and `SELECT ... FOR UPDATE` sets an IX lock.

        The intention locking PROTOCOL is as follows:

          - Before a transaction can acquire a shared lock on a row in a table, it must first acquire an IS lock or stronger ON THE TABLE.
          - Before a transaction can acquire an exclusive lock on a row in a table, it must first acquire an IX lock ON THE TABLE.

      - Table-level lock type compatibility is summarized in the following matrix. #ril

      - A lock is granted to a requesting transaction if it is COMPATIBLE WITH EXISTING LOCKS (指其他 transaction 設下的 lock), but not if it conflicts with existing locks. A transaction WAITS UNTIL THE CONFLICTING EXISTING LOCK IS RELEASED. If a lock request conflicts with an existing lock and cannot be granted because it would cause DEADLOCK, an error occurs.

      - Intention locks do not block anything except FULL TABLE REQUESTS (for example, `LOCK TABLES ... WRITE`). The main purpose of intention locks is to show that someone is locking a row, or GOING TO lock a row in the table.

      - Transaction data for an intention lock appears similar to the following in `SHOW ENGINE INNODB STATUS` and InnoDB monitor output: ??

            TABLE LOCK table `test`.`t` trx id 10080 lock mode IX

    Record Locks

      - A record lock is a lock on an INDEX RECORD. For example, `SELECT c1 FROM t WHERE c1 = 10 FOR UPDATE;` prevents any other transaction from inserting, updating, or deleting rows where the value of `t.c1` is `10`.
      - Record locks always lock index records, even if a table is defined with no indexes. For such cases, InnoDB creates a HIDDEN CLUSTERED INDEX and uses this index for record locking.

      - Transaction data for a record lock appears similar to the following in `SHOW ENGINE INNODB STATUS` and InnoDB monitor output:

            RECORD LOCKS space id 58 page no 3 n bits 72 index `PRIMARY` of table `test`.`t`
            trx id 10078 lock_mode X locks rec but not gap
            Record lock, heap no 2 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
             0: len 4; hex 8000000a; asc     ;;
             1: len 6; hex 00000000274f; asc     'O;;
             2: len 7; hex b60000019d0110; asc        ;;

  - [MySQL :: MySQL 8\.0 Reference Manual :: 15\.16\.3 InnoDB Standard Monitor and Lock Monitor Output](https://dev.mysql.com/doc/refman/8.0/en/innodb-standard-monitor.html) #ril

## 參考資料 {: #reference }

文件：

  - [MySQL 8.0 Reference Manual :: 15 The InnoDB Storage Engine](https://dev.mysql.com/doc/refman/8.0/en/innodb-storage-engine.html)
