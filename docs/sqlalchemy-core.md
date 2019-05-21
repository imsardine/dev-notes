---
title: SQLAlchemy / Core
---
# [SQLAlchemy](sqlalchemy.md) / Core

## Engine, Connection ??

  - [Working with Engines and Connections — SQLAlchemy 1\.3 Documentation](https://docs.sqlalchemy.org/en/13/core/connections.html) #ril

      - This section details direct usage of the `Engine`, `Connection`, and related objects. Its important to note that when using the SQLAlchemy ORM, these objects are NOT generally accessed; instead, the `Session` object is used as the interface to the database.

        However, for applications that are built around direct usage of TEXTUAL SQL STATEMENTS and/or SQL EXPRESSION CONSTRUCTS without involvement by the ORM’s higher level MANAGEMENT SERVICES, the `Engine` and `Connection` are king (and queen?) - read on.

        確實用 SQLAlchemy 並不一定要走 ORM 就可以讓 code base 不會綁定特定的 DBMS 或 DB-API 實作。

    Basic Usage

      - Recall from Engine Configuration that an `Engine` is created via the `create_engine()` call:

            engine = create_engine('mysql://scott:tiger@localhost/test')

      - The typical usage of `create_engine()` is once per particular DATABASE URL, held globally for the lifetime of a single application process.

        A single `Engine` manages MANY individual DBAPI CONNECTIONS on behalf of the process and is intended to be called upon in a CONCURRENT fashion.

        The `Engine` is not synonymous to the DBAPI `connect` function, which represents just one connection resource - the `Engine` is most efficient when created JUST ONCE AT THE MODULE LEVEL of an application, not per-object or per-function call.

        `Engine` 背後有多個 DB-API connection (如果沒有停用 connection pooling 的話)，整個 process 會共用一個 `Engine`。

      - For a multiple-process application that uses the `os.fork` system call, or for example the Python `multiprocessing` module, it’s usually required that a separate `Engine` be used for each child process. This is because the `Engine` maintains a reference to a CONNECTION POOL that ultimately references DBAPI connections - these tend to not be portable across process boundaries.

        An `Engine` that is configured not to use pooling (which is achieved via the usage of `NullPool`) does not have this requirement.

        所謂 the requirement 指的是 "一個 process 共用一個 engine"，背後如果沒有 pooling 的話 (`NullPool`)，就只會對應到一個 connection，這樣 per-object 或 per-function 也沒差。

      - The engine can be used directly to issue SQL to the database. The most generic way is first procure a connection resource, which you get via the `Engine.connect()` method:

            connection = engine.connect()
            result = connection.execute("select username from users")
            for row in result:
                print("username:", row['username'])
            connection.close()

        The connection is an instance of `Connection`, which is a PROXY OBJECT for an actual DBAPI connection. The DBAPI connection is retrieved from the CONNECTION POOL at the point at which `Connection` is created.

        `Engine.connect()` 在生成 `Connection` 時只是從 pool 拿出一個 DBAPI connection (一直與 DB 保持連線) 包裝起來而已，如果當時 DBAPI connection 不夠 (且數量未達上限)，就會動態建立。

        根據 [DB-API connection object](https://www.python.org/dev/peps/pep-0249/#connection-objects) 只有 `close()`、`commit()`、`rollback()` 及 `cursor()` 4 個 method，並沒有 `connect()`，可見 DB-API connection object 在生成的時候就已經與 DB 建立連線；搭配 MySQL 的 `SHOW PROCESSLIST` 觀察也是如此。

      - The returned result is an instance of `ResultProxy`, which references a DBAPI cursor and provides a LARGELY COMPATIBLE INTERFACE with that of the DBAPI cursor. The DBAPI cursor will be closed by the `ResultProxy` when all of its result rows (if any) are exhausted. A `ResultProxy` that returns no rows, such as that of an `UPDATE` statement (without any returned rows), releases cursor resources immediately upon construction.

        DB-API cursor object 有個 [`close()`](https://www.python.org/dev/peps/pep-0249/#cursor-close)，這意謂著如果沒讀完，要明確呼叫 `ResultProxy.close()`。

      - When the `close()` method is called, the referenced DBAPI connection is RELEASED TO THE CONNECTION POOL. From the perspective of the database itself, NOTHING IS ACTUALLY “CLOSED”, assuming pooling is in use. The pooling mechanism issues a `rollback()` call on the DBAPI connection so that any transactional state or locks are removed, and the connection is ready for its next usage.

        呼應上面 DB-API connection object 沒有 `connect()`，DB-API connection 一直都是與 DB 保持連線的，只是回到 connection pool 前會透過 `rollback()` 把 transactional resources -- 進行到一半的 transaction、要求的 lock 等釋出，也確保下一個拿到這個 DB-API connection 的人不會受影響。

      - The above procedure can be performed in a shorthand way by using the `execute()` method of `Engine` itself:

            result = engine.execute("select username from users")
            for row in result:
                print("username:", row['username'])

        Where above, the `execute()` method acquires a new `Connection` on its own, executes the statement with that object, and returns the `ResultProxy`. In this case, the `ResultProxy` contains a special flag known as `close_with_result`, which indicates that when its underlying DBAPI cursor is closed, the `Connection` object itself is also closed, which again returns the DBAPI connection to the connection pool, releasing transactional resources.

        因為拿不到 connection 以呼叫 `close()`，所以設計成 result set 讀完時會自動呼叫 `Connection.close()` 讓 connection 回到 pool；但如果沒讀完會發生什麼事? 下面在解釋最好明確呼叫 `ResultProxy.close()`，雖然最終也會因為 GC 的關係讓 connection 回到 pool，但最好別依賴這樣的行為。

      - If the `ResultProxy` potentially has rows remaining, it can be instructed to close out its resources explicitly:

            result.close()

        If the `ResultProxy` has pending rows remaining and is DEREFERENCED by the application without being closed, Python garbage collection will ultimately close out the cursor as well as trigger a return of the pooled DBAPI connection resource to the pool (SQLAlchemy achieves this by the usage of WEAKREF CALLBACKS - never the `__del__` method) - however it’s never a good idea to rely upon Python garbage collection to manage resources.

      - Our example above illustrated the execution of a textual SQL string. The `execute()` method can of course accommodate more than that, including the variety of SQL expression constructs described in SQL Expression Language Tutorial.

## 參考資料 {: #reference }

文件：

  - [SQLAlchemy Core Documentation](https://docs.sqlalchemy.org/en/latest/core/)

手冊：

  - [`sqlalchemy.create_engine()`](https://docs.sqlalchemy.org/en/latest/core/engines.html#sqlalchemy.create_engine)
  - [`sqlalchemy.engine.Engine`](http://docs.sqlalchemy.org/en/latest/core/connections.html#sqlalchemy.engine.Engine)
  - [`sqlalchemy.engine.Connection`](https://docs.sqlalchemy.org/en/latest/core/connections.html#sqlalchemy.engine.Connection)
  - [`sqlalchemy.engine.ResultProxy`](https://docs.sqlalchemy.org/en/latest/core/connections.html#sqlalchemy.engine.ResultProxy)
