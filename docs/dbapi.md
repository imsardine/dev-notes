# DB-API (Python Database API)

  - [PEP 249 -- Python Database API Specification v2.0 | Python.org](https://www.python.org/dev/peps/pep-0249/)
      - This API has been defined to ENCOURAGE SIMILARITY between the Python modules that are used to access databases. By doing this, ... code that is generally MORE PORTABLE ACROSS DATABASES, and a broader reach of database connectivity from Python. 感覺很像 Java 的 JDBC，為 API 制定一個可遵循的標準。
      - For more information on database interfacing with Python and available packages see the [Database Topic Guide](http://www.python.org/topics/database/) <--這份文件好舊，不過可以看出早期各自發展的亂向。
      - 這份文件在講 Python Database API Specification 2.0 及一些 optional extension -- 異中求同，希望 package writer 以這份文件講的 interface 為基礎。
  - [Features \- SQLAlchemy](http://www.sqlalchemy.org/features.html) No ORM Required 提到 "providing a smooth layer of abstraction over a wide variety of DBAPI implementations and behaviors"。
  - [Connecting - SQL Expression Language Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/core/tutorial.html#connecting) "... the Engine establishes a real DBAPI connection to the database, which is then used to emit the SQL."，實際跟 DB 互動還是透過 DB-API。
  - [11\.13\. sqlite3 — DB\-API 2\.0 interface for SQLite databases — Python 2\.7\.15 documentation](https://docs.python.org/2/library/sqlite3.html) Python 內建的 `sqlite3` 本身就符合 DB-API 的要求。
  - [DatabaseProgramming \- Python Wiki](https://wiki.python.org/moin/DatabaseProgramming) #ril
  - [Databases — The Hitchhiker's Guide to Python](https://docs.python-guide.org/scenarios/db/) #ril

## 有 SQLAlchemy，為什麼要用 DB-API ??

  - 有些時候只想直接操作 DB，但就算不用 SQLAlchemy 的 ORM，只用 Core (Expression Language) 也需要先定義 metadata，有點多此一舉。

參考資料：

  - [SQL Expression Language Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/core/tutorial.html#define-and-create-tables) 只用 SQL Expression Language，還是得先定義 database metadata。
  - [How to Execute Raw SQL in SQLAlchemy](https://chartio.com/resources/tutorials/how-to-execute-raw-sql-in-sqlalchemy/) 試過真的不需要先宣告 metadata，這樣似乎沒理由用 DB-API 了!? #ril

## Hello, World!

以 SQLite 及 Python 內建的 `sqlite3` module 為例。

```
$ cat data.sql
CREATE TABLE say_hello (
  greeting varchar(30),
  target varchar(30)
);

INSERT INTO say_hello VALUES ('Hello', 'World');

$ cat data.sql > sqlite3 data.db # create db

$ python
>>> from sqlite3 import connect
>>> connection = connect('data.db')
>>> cursor = connection.cursor()
>>>
>>> cursor.execute('SELECT * FROM say_hello')
>>> cols = cursor.fetchone()
>>> cols
(u'Hello', u'World')
>>> assert cursor.fetchone() is None
>>>
>>> cursor.execute('INSERT INTO say_hello (greeting, target) VALUES (?, ?)', ['Hey', 'SQLite'])
>>> cursor.execute('SELECT * FROM say_hello')
>>> cursor.fetchall()
[(u'Hello', u'World'), (u'Hey', u'SQLite')]
>>> ^D

$ sqlite3 data.db "SELECT * FROM say_hello"
Hello|World
```

## 新手上路 {: #getting-started }

  - [Writing code using DB\-API \- Week 3 \- Accessing Databases using Python \| Coursera](https://www.coursera.org/lecture/sql-data-science/writing-code-using-db-api-GM85O)
      - 01:20 每個 DBMS 都有自己的 library (符合 DB-API)，例如 MySQL 用 MySQL Connector/Python。
      - 02:00 DB-API 主要兩個概念是 connection object 與 cursor object，前者用來建立 connection 及管理 transaction，後者則用來執行 query (也包含 insert 等異動) -- 先 open cursor 再 run query!!
      - 02:15 Cursor 像是文書處理器裡的 cursor，向下捲動時，可以把 result set 裡的資料取進 application。
      - 02:30 Connection object 有 `cursor()` 用來取得 cursor object，有 `commit()`/`rollback()` 可以將確認/取消 pending transaction，而 `close()` 則用來關閉連線。
      - 02:50 Cursor object 有 `callproc()`、`execute()`、`executemany()`、`fetchone()`、`fetchmany()`、`nextset()`、`Arraysize()` 等，用來管理 fetch operation 的 context，特別提到源自同一個 connection 的多個 cursor 之間並非隔離的 (isolated)，也就是說一個 cursor 的異動，在另一個 cursor 直接可見。若 cursor 源自不同的 connection，其間是否為 isolated 則要看 transaction support 支援到什麼程度。
      - 03:13 Cursor 可以用來走 (traverse) DB records，它像是個 file name/handle，以取得 query result，也會追蹤目前在 query result 中的位置。
      - 03:50 Python code 大概會像這樣 `from dbmodule import connect` -> `connection = connect('databasename', 'username', 'pswd')` -> `cursor = connection.cursor()` -> `cursor.execute('SELECT * FROM mytable')` -> `results = cursor.fetchall()` (注意 `execute()` 跟 `fetch*()` 是拆開的，就算是 `SELECT` 也是) -> `cursor.close()` -> `connection.close()`。
  - [How to connect Python programs to MariaDB \| MariaDB](https://mariadb.com/resources/blog/how-connect-python-programs-mariadb) (2014-11-14) #ril

## Connection ??

  - [Module Interface - PEP 249 \-\- Python Database API Specification v2\.0 \| Python\.org](https://www.python.org/dev/peps/pep-0249/#module-interface) module 要提供 `connect(parameters...)` construtor 以建立 connection object，其中 `parameters` 會因 database 而異。
  - [Connection Objects - PEP 249 \-\- Python Database API Specification v2\.0 \| Python\.org](https://www.python.org/dev/peps/pep-0249/#connection-objects) Connection object 有 `close()`、`commit()`、`rollback()` 與 `cursor()`。`close()` 會關閉與 database 的連線，在這之前若沒有先 commit，背後會做 rollback。

## Cursor ??

  - [Writing code using DB\-API \- Week 3 \- Accessing Databases using Python \| Coursera](https://www.coursera.org/lecture/sql-data-science/writing-code-using-db-api-GM85O) ... 很多內容來自 PEP 249 直接唸 XD
      - 02:15 Cursor 像是文書處理器裡的 cursor，向下捲動時，可以把 result set 裡的資料取進 application。
      - 02:30 Connection object 有 `cursor()` 用來取得 cursor object，有 `commit()`/`rollback()` 可以將確認/取消 pending transaction，而 `close()` 則用來關閉連線。
      - 02:50 Cursor object 有 `callproc()`、`execute()`、`executemany()`、`fetchone()`、`fetchmany()`、`nextset()`、`Arraysize()` 等，用來管理 fetch operation 的 context，特別提到源自同一個 connection 的多個 cursor 之間並非隔離的 (isolated)，也就是說一個 cursor 的異動，在另一個 cursor 直接可見。若 cursor 源自不同的 connection，其間是否為 isolated 則要看 transaction support 支援到什麼程度。
      - 03:13 Cursor 可以用來走 (traverse) DB records，它像是個 file name/handle，以取得 query result，也會追蹤目前在 query result 中的位置。
  - [.cursor() - PEP 249 \-\- Python Database API Specification v2\.0 \| Python\.org](https://www.python.org/dev/peps/pep-0249/#cursor) 根據 connection 產生一個 cursor object。
  - [paramstyle - PEP 249 \-\- Python Database API Specification v2\.0 \| Python\.org](https://www.python.org/dev/peps/pep-0249/#paramstyle) `module.paramstyle` 可以查到 API 採用的 "parameter marker formatting"，有 `qmark` (`WHERE name=?`)、`numeric` (`WHERE name=:1`)、`named` (`WHERE name=:name`)、`format` (`WHERE name=%s`，也就是 ANSI C prinft format codes)、`pyformat` (`WHERE name=%(name)s`)；官方建議 `numeric`、`named` 或 `pyformat`，注意 parameter marker 不用加引號。
  - [.execute(operation [, parameters]) - PEP 249 \-\- Python Database API Specification v2\.0 \| Python\.org](https://www.python.org/dev/peps/pep-0249/#execute)
      - PREPARE and execute a database operation (query or command). 注意這裡 "prepare" 的用法；cursor 內部會留存 `operation` 的 reference，下次又用相同的 `operation` (通常會綁定不同的 `parameters`) 時內部就可以優化。
      - 為了把重複使用 `operation` 的效益最大化，最好能在 `execute()` 前先用 `setinpusizes()` 告知每個 parameter 的 type/size 以預先配置記憶空間，不過就算之後傳進去的資料不符合這裡的宣告，頂多也只是影響到效能而已，並不會出錯。
      - `operation` 內部可以用 `paramstyle` 宣告的方式表示 variable (正確的說法應是 parameter)，搭配 `parameters` 動態代換 (bound to variables)；依據 `paramstyle` 的不同，`parameters` 可以是 sequence 或 mapping。
      - 雖然 `parameters` 也可以是 list of tuples 達到一次插入許多 row 的效果，但建議改用 `executemany()`。
      - Return values are not defined. 因為 operation 可以是 query/command，查詢結果不會從 return value 拿到，更何況取結果的方式不只一種 -- `fetchall()`、`fetchone()` ...
  - [fetchone() - PEP 249 \-\- Python Database API Specification v2\.0 \| Python\.org](https://www.python.org/dev/peps/pep-0249/#fetchone) Fetch the next row of a query RESULT SET, returning a single SEQUENCE, or `None` when no more data is available. 但如果前一個 `execute*()` 沒有 result set 就會丟出 `Error`；注意取回的 row 是 sequence，表示只能透過 index 取出不同欄位的值。
  - [fetchmany([size=cursor.arraysize]) - PEP 249 \-\- Python Database API Specification v2\.0 \| Python\.org](https://www.python.org/dev/peps/pep-0249/#fetchmany)
      - Fetch the next SET OF ROWS of a query result, returning a sequence of sequences (e.g. a list of tuples). An empty sequence is returned when no more rows are available.
      - Note there are performance considerations involved with the `size` parameter. For optimal performance, it is usually best to use the `.arraysize` attribute. If the `size` parameter is used, then it is best for it to retain the same value from one `.fetchmany()` call to the next. 看起來沒理由去動它。
  - [fetchall() - PEP 249 \-\- Python Database API Specification v2\.0 \| Python\.org](https://www.python.org/dev/peps/pep-0249/#fetchall) Fetch all (remaining) rows of a query result, returning them as a sequence of sequences (e.g. a list of tuples). Note that the cursor's `arraysize` attribute can affect the performance of this operation. 內部應該是不斷呼叫 `fetchmany()`；一次傳回所有 rows，要考量 python process 的記憶體...
  - [.executemany( operation, seq_of_parameters ) - PEP 249 \-\- Python Database API Specification v2\.0 \| Python\.org](https://www.python.org/dev/peps/pep-0249/#executemany) #ril
      - Prepare a database operation (query or command) and then execute it against all parameter sequences or mappings found in the sequence `seq_of_parameters`.
      - Use of this method for an operation which produces one or more result sets constitutes undefined behavior ... 聽起來 `executemany()` 不適合用在 query。
  - [Cursor attributes - PEP 249 \-\- Python Database API Specification v2\.0 \| Python\.org](https://www.python.org/dev/peps/pep-0249/#cursor-attributes)
      - `description` - a sequence of 7-item sequences (name, type_code[, display_size, internal_size, precision, scale, null_ok])，用來表示 result set 裡每個 (result) column 的資訊。
      - `rowcount` - 跟最後一次 `execute*()` 有關的 row 數量；就 DQL 而言，就是 result set 的筆數，就 DML 而言，就是受影響的筆數。如果這個數字無法決定，就會傳回 `-1` (未來的 API 會改用 `None`)。

## Transaction

  - [Connection Objects - PEP 249 \-\- Python Database API Specification v2\.0 \| Python\.org](https://www.python.org/dev/peps/pep-0249/#connection-objects)
      - `close()` - Note that closing a connection without committing the changes first will cause an IMPLICIT ROLLBACK to be performed.
      - `commit()` - Commit any PENDING TRANSACTION to the database. 但 "Note that if the database supports an auto-commit feature, this must be initially off. An interface method may be provided to turn it back on." 這是什麼意思??
      - `rollback()` - In case a database does provide transactions this method causes the database to roll back to the start of any pending transaction.
  - [Transactions - UsingDbApiWithPostgres \- Python Wiki](https://wiki.python.org/moin/UsingDbApiWithPostgres#transactions) For databases that support transactions, the Python interface SILENTLY STARTS A TRANSACTION when the cursor is created. The `commit()` method commits the updates made using that cursor, and the `rollback()` method discards them. Each method THEN STARTS A NEW TRANSACTION. 一直都會有 transaction，告一段落時用 `commit()`/`rollback()` 決定去留即可。
  - [Using Transactions in Python Programs \- MySQL Cookbook \[Book\]](https://www.safaribooksonline.com/library/view/mysql-cookbook/0596001452/ch15s07.html) 提到 Invoke `begin()` to begin a transaction and either `commit()` or `rollback()` to end it. 但 DB-API 1.0 跟 2.0 都沒有 `begin()` 啊?
  - [sql \- Why connection in Python's DB\-API does not have "begin" operation? \- Stack Overflow](https://stackoverflow.com/questions/2546926/) newtover: 引用了 SQL The Complete Reference 的說法，因為 SQL standard (SQL1) 提了 implicit transaction mode，只支援 `COMMIT`/`ROLLBACK`，也就是說 transaction 會在第一個 SQL statement 開始，直到 `COMMIT`/`ROLLBACK` 結束，但另一個 transaction 隨即又會開始。後來 SQL2 提了 explicit transaction mode，但 D API 並沒有反應這項變化。
  - [Transactions with Python sqlite3 \- Stack Overflow](https://stackoverflow.com/questions/15856976/transactions-with-python-sqlite3/23634805)
      - `executescript()` 裡故意安排個錯誤，但竟然沒有整個 rollback!?
      - CL.: 引用 [Controlling Transactions - sqlite3](https://docs.python.org/2/library/sqlite3.html#sqlite3-controlling-transactions) 的文件，會在 DML 前自動開始 transaction，可怕的是會在 non-DML & non-query statement 前自動 commit!? 所以才有人包裝了另一個 Python SQLite wrapper - [apsw](https://github.com/rogerbinns/apsw)
  - [MySQLdb: a Python interface for MySQL: MySQLdb \-\- DB API interface](http://structure.usc.edu/mysqldb/MySQLdb-3.html)
      - 這裡也提到 "transactions start when a cursor execute a query, but end when COMMIT or ROLLBACK is executed by the Connection object"。
      - `begin()` 也提到 "Normally you do not need to use this: Executing a query implicitly starts a new transaction if one is not in progress."。
      - Note carefully that these are methods of the connection and not methods of the cursor, even though c.execute(...) is what started the transaction. 這確實有點怪...

## Error Handling ??

  - [Exceptions - PEP 249 \-\- Python Database API Specification v2\.0 \| Python\.org](https://www.python.org/dev/peps/pep-0249/#exceptions) 每個 library 都會宣告這些同名的 exception，在特定的情況下會丟出。

## 參考資料 {: #reference }

相關：

  - [SQLAlchemy](sqlalchemy.md) 底層也是透過 DB-API 跟 DB 溝通。

手冊：

  - [PEP 249 -- Python Database API Specification v2.0 | Python.org](https://www.python.org/dev/peps/pep-0249/)
  - [PEP 248 -- Python Database API Specification v1.0 | Python.org](https://www.python.org/dev/peps/pep-0248/)

