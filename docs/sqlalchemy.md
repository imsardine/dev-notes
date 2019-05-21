# SQLAlchemy (Core)

  - [SQLAlchemy \- The Database Toolkit for Python](https://www.sqlalchemy.org/) Python SQL toolkit + Object Relational Mapper (ORM)。SQL database (tables + rows) 重點在 performance，而 object collections 重點在 abstraction，SQLAlchemy 試著照顧到兩邊。

## SQLAlchemy Core (Expression Language) & ORM

  - [SQLAlchemy \- The Database Toolkit for Python](https://www.sqlalchemy.org/) 最為人所知的 ORM，是 SQLAlchemy 的 optional component? 實作了 data mapper pattern，也就是 class 與 database 間的對應是開放的 (open ended)、低耦合 (decoupled) 的。
  - [SQLAlchemy Documentation — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/) Core 的核心是 SQL Expression Language，是一種 schema-centric usage，不同於 ORM 的 domain-centric mode of usage。
  - [SQL Expression Language Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/core/tutorial.html) Expression Language 讓你可以用 Python constructs 來表示 RDB 的 structures & expressions -- 儘可能貼近 DB，但又做了少量的 abstraction 隔開不同 DB backend 的差異 -- backend-neutral SQL expressions。而 ORM 只是 Expression Lanauge 的一種用法。實務上可以只用 Expression Language，但用了 ORM 也可以搭配 Expression Language 使用。
  - [Overview — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/intro.html) 原來 SQL Expression Language、Engine、Connection Pooling 等都是 SQLAlchemy Core 的一員，底下是 DBAPI，上面才是 ORM，只是 ORM 跟 SQL Expression Language 站在台前 (front-facing) 而已。這裡提到 "When using the ORM, the SQL Expression language remains part of the public facing API as it is used within object-relational configurations and queries." 看來兩者都得要學??

## 新手上路 ?? {: #getting-started }

  - 先看過 [SQL Expression Language Tutorial](http://docs.sqlalchemy.org/en/latest/core/tutorial.html) 到 Insert Expressions 之前的那一段，再從 [Declare a Mapping - Object Relational Tutorial](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#declare-a-mapping) 開始。
  - `sqlalchemy.create_engine()` 搭配 `echo=True` 可以觀察背後產生的 SQL statements (例如某個用法會不會產生多餘的 SQL query?)，搭配 in-memory SQLite database 更方便，例如 `create_engine('sqlite:///:memory:', echo=True)`。

參考資料：

  - Object Relational Tutorial — SQLAlchemy 1.2 Documentation http://docs.sqlalchemy.org/en/latest/orm/tutorial.html #ril
  - [SQLAlchemy Documentation — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/) #ril

## Engine, Dialect ??

  - [Connecting - SQL Expression Language Tutorial — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/core/tutorial.html#connecting)
      - 建立連線用 `sqlalchemy.create_engine()`，例如 `engine = create_engine('sqlite:///:memory:', echo=True)`
      - 這裡採用 in-memory SQLite database (`'sqlite:///:memory:'`)，搭配 `echo=True` 可以將背後產生的 SQL statements 印出來。
      - `create_engine()` 會傳回 `Engine`，做為跟 database 溝通的 core interface；內有 connection pool 與 dialect，而 dialect 決定了採用哪個 DBAPI 實作 (`sqlite` 這個 dialect 預設採用 Python 內建的 `sqlite3`)
      - `create_engine()` 只是傳回 `Engine`，但還沒真的建立連線，要等 `Engine.execute()` 或 `Engine.connect()` 被呼叫時才會建立。
  - [Connecting - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#connecting) When using the ORM, we typically don’t use the `Engine` directly once created; instead, it’s used behind the scenes by the ORM. 因為 engine 是 interface to the database，所以同 database URLs 都跟 Expression Language 及 ORM 有關，只不過用 ORM 時不太會直接操作 engine 而已 (而是透過 session)。
  - [Engine Configuration — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/core/engines.html) #ril
      - Engine 背後有 connection pool 跟 dialect，而 dialect 決定了用哪個 DBAPI 的實作，所以才會有 "The MySQL dialect uses mysql-python as the default DBAPI"、"SQLite connects to file-based databases, using the Python built-in module sqlite3 by default" 等說法。
  - [Dialects — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/dialects/) Dialect 是 SQLAlchemy 用來跟不同 DBAPI impl. 溝通的系統；要使用某個 dialect，要先安裝對應的 DBAPI driver #ril

## Database URL ??

  - Database URL 的寫法會因 dialect 而有不同，通常是 `dialect+driver://username:password@host:port/database`。

常用的 URL 有：

  - MySQL 用 `mysql[+mysqldb]://{username}:{password}@{host}/{database}`，例如 `mysql://scott:tiger@localhost/foo`。
  - SQLite 因為是 file-based，所以 host 的部份會省略 (形成 `///`)，用 `sqlite:///{filepath}`，例如 `sqlite:///foo.db` (相對路徑) 或 `sqlite:////absolute/path/to/foo.db` (絕對路徑)，若是要採用 in-memory database，`filepath` 可以用 `:memory:`，例如 `sqlite:///:memory:` 或 `sqlite://` (empty URL)

參考資料：

  - [Database Urls - Engine Configuration — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/core/engines.html#database-urls) #ril
      - URL 通常是 `dialect+driver://username:password@host:port/database`，其中 dialect 是 SQLAlchemy 支援的 dialect，而 driver 則是 DBAPI 的名稱 (module/package name?)，省略的話就會用 default DBAPI。事實上 `dialect+driver://` 後面的寫法會因 dialect 而有不同。
  - Object Relational Tutorial — SQLAlchemy 1.2 Documentation http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#connecting 與 Engine Configuration — SQLAlchemy 1.2 Documentation http://docs.sqlalchemy.org/en/latest/core/engines.html#database-urls 分別出現 `sqlite:///:memory:` 與 `sqlite://` 的寫法，都可以連到 in-memory database。

## Metadata, Schema ??

  - [SQL Expression Language Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/core/tutorial.html) #ril
      - SQL Expression Language 提供 "representing RELATIONAL database structures and expressions using PYTHON CONSTRUCTS" 的系統，儘可能貼近 underlying database 的用法，也為不同 database backend 間的差異提供抽象，也就是讓你可以寫 backend-neutral SQL expressions。
      - ORM (Object Relational Mapper) 是 Expression Language 的一種高階應用 (high level and abstracted pattern of usage) -- from the perspective of a user-defined domain model which is TRANSPARENTLY persisted and refreshed from its underlying storage model；而 Expression Language 則專注在提供 primitive constructs of the relational database directly，不限定特定用法 (without opinion) -- from the perspective of LITERAL schema and SQL expression representations which are explicitly composed into messages consumed individually by the database.
      - 一個 application 完全只用 Expression Language 當然可以，只是要自己處理 database message 與 database result sets 而已。相反的，一個 application 可以主要用 ORM，偶爾需要直接跟 database 互動才混用 Expression Language。
      - `create_engine('sqlite:///:memory:', echo=True)` 會傳回 Engine (interface to the database)，內部會透過不同的 dialect 跟 DBAPI 溝通，就這個例子而就是 SQLite dialect -> `sqlite3` module (Python 內建)。
      - 其中 `sqlite:///:memory:` 是 Database URL，`echo=True` 會印出過程中產生的 SQL statements。
      - 呼叫 `create_engine()` 時並不會建立連線，而是傳回 `sqlalchemy.engine.Engine`，所以不會有 SQL 產生。第一次呼叫 `Engine.execute()` 或 `Engine.connect()` 時才會建立 DBAPI connection。
      - 資料庫的結構用 `sqlalchemy.schema.Table` 與 `sqlalchemy.schema.Column` 描述，所有 table 及 column 的集合稱做 schema metadata，用 `sqlalchemy.schema.MetaData` 表示。這三者有從屬關係 `Engine` -> `MetaData` -> `Table` -> `Column`，以建立兩個 tables - `users` 與 `addresses` 為例 (一個使用者會有多個 email address)：

            >>> from sqlalchemy import Table, Column, Integer, String, MetaData, ForeignKey
            >>> metadata = MetaData()
            >>> users = Table('users', metadata,
            ...     Column('id', Integer, primary_key=True),
            ...     Column('name', String),
            ...     Column('fullname', String),
            ... )

            >>> addresses = Table('addresses', metadata,
            ...   Column('id', Integer, primary_key=True),
            ...   Column('user_id', None, ForeignKey('users.id')), # 型態是 None?
            ...   Column('email_address', String, nullable=False)
            ...  )

      - 接著就可以呼叫 `metadata.create_all()` 建立 metadata 下的 tables -- `metadata.create_all(engine)`。

            CREATE TABLE users (
                id INTEGER NOT NULL,
                name VARCHAR,
                fullname VARCHAR,
                PRIMARY KEY (id)
            )
            ()
            COMMIT
            CREATE TABLE addresses (
                id INTEGER NOT NULL,
                user_id INTEGER,
                email_address VARCHAR NOT NULL,
                PRIMARY KEY (id),
                FOREIGN KEY(user_id) REFERENCES users (id)
            )
            ()
            COMMIT

      - 眼尖的人會發現，`VARCHAR` 為何沒有長度? 那是因為 SQLite 跟 PostgreSQL 都支持這種 datatype，但其他資料庫就不行，所以若改用 MySQL 時就會出錯，要改用類似 `String(50)` 的方式宣告才行，不過長度這項資訊也只在 create tables 時才會參考。

  - [Define and Create Tables - SQL Expression Language Tutorial — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/core/tutorial.html#define-and-create-tables) #ril
  - [Defining Foreign Keys - Defining Constraints and Indexes — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/core/constraints.html#defining-foreign-keys) 即便 SQLAlchemy Core 沒有 relationship 的概念，但 foreign key 的定義仍屬於 Core 而非 ORM 特有 #ril
  - [Schema Definition Language — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/core/schema.html) #ril

  - [MySQL :: MySQL 5\.7 Reference Manual :: 11\.1\.1 Numeric Type Overview](https://dev.mysql.com/doc/refman/5.7/en/numeric-type-overview.html) `INT` 的值域是 -2147483648 ~ 2147483647。
  - [class sqlalchemy.types.BigInteger - Column and Data Types — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/core/type_basics.html#sqlalchemy.types.BigInteger) Typically generates a BIGINT in DDL, and otherwise acts like a normal Integer on the Python side. 也就是說 Python 這端是以 `int` 來與 DB 的 `BIGINT` 對應；相較於 `sqlalchemy.types.BIGINT` 屬 SQL Standard and Multiple Vendor Types，不一定能作用在所有的 backend。

## Textual SQL ??

  - [Using Textual SQL - SQL Expression Language Tutorial — SQLAlchemy 1\.3 Documentation](https://docs.sqlalchemy.org/en/13/core/tutorial.html#using-textual-sql) #ril

      - Our last example really became a handful to type. Going from what one understands to be a textual SQL expression into a Python construct which groups components together in a programmatic style can be HARD.

            >>> s = select([(users.c.fullname +
            ...               ", " + addresses.c.email_address).
            ...                label('title')]).\
            ...        where(users.c.id == addresses.c.user_id).\
            ...        where(users.c.name.between('m', 'z')).\
            ...        where(
            ...               or_(
            ...                  addresses.c.email_address.like('%@aol.com'),
            ...                  addresses.c.email_address.like('%@msn.com')
            ...               )
            ...        )
            >>> conn.execute(s).fetchall()

        確實沒有比較好懂，尤其對寫過 SQL 的人來說。

      - That’s why SQLAlchemy lets you just use strings, for those cases when the SQL is already known and there isn’t a strong need for the statement to support DYNAMIC FEATURES. The `text()` construct is used to compose a TEXTUAL STATEMENT that is passed to the database MOSTLY UNCHANGED. Below, we create a `text()` object and execute it:

            >>> from sqlalchemy.sql import text
            >>> s = text(
            ...     "SELECT users.fullname || ', ' || addresses.email_address AS title "
            ...         "FROM users, addresses "
            ...         "WHERE users.id = addresses.user_id "
            ...         "AND users.name BETWEEN :x AND :y "
            ...         "AND (addresses.email_address LIKE :e1 "
            ...             "OR addresses.email_address LIKE :e2)")
            SQL>>> conn.execute(s, x='m', y='z', e1='%@aol.com', e2='%@msn.com').fetchall()
            [(u'Wendy Williams, wendy@aol.com',)]

        用 `:var` 來替換變數 (bound parameter)。

        上面 "passed to the database mostly unchanged" 的說法，是否意謂著 textual SQL 會綁定特定資料庫 ??

      - Above, we can see that BOUND PARAMETERS are specified in text() using the NAMED COLON FORMAT; this format is consistent REGARDLESS OF DATABASE BACKEND. To send values in for the parameters, we passed them into the `execute()` method as additional arguments.

    用 Textual SQL 就可以與資料庫隔開一層，不一定要包裝 mapping 或 domain model。

  - [Using raw SQL with Flask\-SQLAlchemy – neekey](http://neekey.net/2017/05/19/using-raw-sql-with-flask-sqlalchemy/) (2017-05-19) #ril
  - [Raw SQL in SQLAlchemy](http://zetcode.com/db/sqlalchemy/rawsql/) #ril
  - [python \- How to execute raw SQL in SQLAlchemy\-flask app \- Stack Overflow](https://stackoverflow.com/questions/17972020/) jpmc26: 也可搭配 session 使用!? #ril
  - [How to Execute Raw SQL in SQLAlchemy](https://chartio.com/resources/tutorials/how-to-execute-raw-sql-in-sqlalchemy/) #ril
  - [sqlalchemy\.sql\.text Python Example](https://www.programcreek.com/python/example/51986/sqlalchemy.sql.text) #ril

## Connection Pooling ??

  - [Connection Pooling — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/core/pooling.html) #ril
  - [Dealing with Disconnects - Connection Pooling — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/core/pooling.html#dealing-with-disconnects) #ril
      - Connection pool 有能力刷新 (refresh) 個別或全部的 connection、將之前的 connection 標示為 invalid，這樣可以比較溫格地渡過 DB 重啟，或是連線已經失效的狀況。
      - 策略上分為 Pessimistic (悲觀) 與 Optimistic (樂觀) 兩種
      - 所謂悲觀是指 "不看好連線穩定"，所以要從 pool 拿出 (checkout) connection 前，會先送出一個 test statement 以確定 connection 是有用的 (viable)，這個動作稱做 pre ping。雖然 pre ping 會對 checkout process 增加一些 overhead，但這是最簡單且可以完全排除拿到 stale pooled connection 的方法，應用端也不用擔心如何從 stale connection 回復的問題。
  - [Configuration — Flask\-SQLAlchemy Documentation \(2\.3\)](http://flask-sqlalchemy.pocoo.org/2.3/config/) #ril

## Transaction ??

  - Glossary — SQLAlchemy 1.2 Documentation http://docs.sqlalchemy.org/en/latest/glossary.html#term-unit-of-work 提到 "transparently keeps track of changes to objects and periodically flushes all those pending changes out to the database" 且 SQLAlchemy session 有實作這個 pattern，在使用上會有什麼影響?
  - [Transactions and Connection Management — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/session_transaction.html) #ril

  - [isolation - Glossary — SQLAlchemy 1\.3 Documentation](https://docs.sqlalchemy.org/en/latest/glossary.html#term-isolation)

      - The isolation property of the ACID model ensures that the CONCURRENT EXECUTION of transactions results in a system state that would be obtained if transactions were EXECUTED SERIALLY, i.e. one after the other. Each transaction must execute in total isolation i.e. if T1 and T2 execute concurrently then each should remain independent of the other. (via Wikipedia)

  - [Setting Transaction Isolation Levels - Transactions and Connection Management — SQLAlchemy 1\.3 Documentation](https://docs.sqlalchemy.org/en/latest/orm/session_transaction.html#setting-transaction-isolation-levels) #ril

      - Isolation refers to the behavior of the transaction at the database level in relation to other transactions occurring concurrently. There are four well-known modes of isolation, and typically the Python DBAPI allows these to be set on a PER-CONNECTION BASIS, either through explicit APIs or via database-specific calls.

      - SQLAlchemy’s dialects support SETTABLE ISOLATION MODES on a PER-ENGINE or PER-CONNECTION basis, using flags at both the `create_engine()` level as well as at the `Connection.execution_options()` level.

        預設是什麼??

      - When using the ORM `Session`, it acts as a FACADE for engines and connections, but does NOT EXPOSE transaction isolation directly. So in order to affect transaction isolation level, we need to act upon the `Engine` or `Connection` as appropriate. 下面會說明做法

  - [`isolation_level` - `sqlalchemy.create_engine()` - Engine Configuration — SQLAlchemy 1\.3 Documentation](https://docs.sqlalchemy.org/en/latest/core/engines.html#sqlalchemy.create_engine.params.isolation_level)

      - this string parameter is interpreted by various dialects in order to affect the transaction isolation level of the database connection. The parameter essentially accepts some SUBSET of these string arguments: `"SERIALIZABLE"`, `"REPEATABLE_READ"`, `"READ_COMMITTED"`, `"READ_UNCOMMITTED"` and `"AUTOCOMMIT"`. BEHAVIOR HERE VARIES PER BACKEND, and individual dialects should be consulted directly.

      - Note that the isolation level can also be set on a PER-CONNECTION BASIS as well, using the `Connection.execution_options.isolation_level` feature.

        感覺依 connection 設定 isolation level 比較合理，因為不是每項操作 (或 use case) 都會涉及資料的異動。

  - [Transaction Isolation Level - MySQL — SQLAlchemy 1\.3 Documentation](https://docs.sqlalchemy.org/en/latest/dialects/mysql.html#mysql-isolation-level) #ril

  - [Handling concurrent INSERT with SQLAlchemy](http://rachbelaid.com/handling-race-condition-insert-with-sqlalchemy/) (2015-08-17) #ril
  - [postgresql \- SqlAlchemy: Table locking with \`get or create\` pattern \- Stack Overflow](https://stackoverflow.com/questions/6091168/) #ril
  - [Lock table, do things to table, unlock table: Best way? \- Google Groups](https://groups.google.com/forum/#!topic/sqlalchemy/neg7nXagaMQ) #ril

## 取得背後產生的 SQL 語法??

取得 `CREATE TABLE` 語法，可以透過 `CreateTable.compile()`，例如：

```
from sqlalchemy.schema import CreateTable
from sqlalchemy.dialects import sqlite, mysql
from sqlalchemy import Table

engine = create_engine(...)
table = Table(...)
# sql = CreateTable(table).compile(engine) # 透過 Engine 也可以
sql = CreateTable(table).compile(dialect=mysql.dialect())
```

建立 engine 時傳入 `echo=True`，例如 `engine = sqlalchemy.create_engine('sqlite://:memory:', echo=True)`。

參考資料：

  - [Printing actual SQLAlchemy queries \| Nicolas Cadou's Blog](http://nicolascadou.com/blog/2014/01/printing-actual-sqlalchemy-queries/) (2014-01-17) #ril
  - [Printing the generated query including parameters \- Johbo's Notes \- Working on the Web](https://www.johbo.com/2016/printing-the-generated-query-including-parameters.html) (2016-10-23) #ril
  - [Karol Kuczmarski's Blog – Turn SQLAlchemy queries into literal SQL](http://xion.io/post/code/sqlalchemy-query-to-sql.html) (2015-11-12) #ril
  - [python \- SQLAlchemy: print the actual query \- Stack Overflow](https://stackoverflow.com/questions/5631078/) #ril
  - [python \- SQLAlchemy printing raw SQL from create\(\) \- Stack Overflow](https://stackoverflow.com/questions/2128717/) 針對 `CREATE TABLE`；Antoine Leclair: 本來提出 `print(CreateTable(table))` 或 `print(CreateTable(Model.__table__))` 的做法 (`sqlalchemy.schema.CreateTable`)，但 klenwell 提到 `CreateTable.compile(engine)` 印出特定 DB 的 SQL，後來 jackotonye: 更提到連 engine 都不用，改用 `CreateTable.compile(dialect=...)` 即可
  - [Connecting - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#connecting) 提到 `create_engine()` 搭配 `echo=True` 可以將產生的 SQL statements 印出來，而且是透過 Python 標準的 `logging` module。
  - [How can I get the CREATE TABLE/ DROP TABLE output as a string? - MetaData / Schema — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/faq/metadata_schema.html#how-can-i-get-the-create-table-drop-table-output-as-a-string) 一樣是 `print(CreateTable(mytable))` 或 `print(CreateTable(mytable).compile(engine))`，不過 `create_engine(url, strategy='mock', executor=dump)` 可以攔截到所有的 SQL statements 更有效? 不知道一般的 query、update 是否攔截得到?? #ril
  - [strategy='plain' - Engine Configuration — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/core/engines.html#sqlalchemy.create_engine.params.strategy) 提到 `mock` strategy 與 `executor` 的用法 #ril
  - [python \- Debugging \(displaying\) SQL command sent to the db by SQLAlchemy \- Stack Overflow](https://stackoverflow.com/questions/2950385/) #ril
  - pytest 的 `caplog` fixture 似乎還滿實用的??

## Logging??

  - [Configuring Logging - Engine Configuration — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/core/engines.html#configuring-logging) #ril

## 如何在 log 中印出 object?

  - Object Relational Tutorial — SQLAlchemy 1.2 Documentation http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#declare-a-mapping 提到 `__repr__()` 的實作並非必要，但輸出關鍵的值，當 instance 被印出來時，對於除錯似乎很有幫助，否則預設只有 object ID?

## 安裝設定 {: #installation }

  - 用 `pip install SQLAlchemy` 安裝。
  - 用 `python -c 'import sqlalchemy; print(sqlalchemy.__version__)'` 檢查。

參考資料：

  - [Installation Guide - Overview — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/intro.html#installation) 支援 Python 2.7+ 與 3.x，但目前只支援 CPython，還不支援 Jython 與 IronPython。用 pip 安裝 `SQLAlchemy` 套件即可。如何安裝 DBAPI??

## 參考資料 {: #reference }

  - [SQLAlchemy \- The Database Toolkit for Python](https://www.sqlalchemy.org/)
  - [zzzeek/sqlalchemy - GitHub](https://github.com/zzzeek/sqlalchemy)
  - [SQLAlchemy - PyPI](https://pypi.org/project/SQLAlchemy/)

社群：

  - ['sqlalchemy' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/sqlalchemy)

更多：

  - [Core](sqlalchemy-core.md)
  - [ORM](sqlalchemy-orm.md)
  - [Domain Model](sqlalchemy-domain-model.md)

相關：

  - SQLAlchemy 底層也是透過 [DB-API](dbapi.md) 跟 DB 溝通。

手冊：

```
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base

from sqlalchemy import Column
from sqlalchemy import String
from sqlalchemy import Integer
```

  - [Python SQLAlchemy Cheatsheet — pysheeet](https://www.pythonsheets.com/notes/python-sqlalchemy.html)

  - [`sqlalchemy.create_engine()`](http://docs.sqlalchemy.org/en/latest/core/engines.html#sqlalchemy.create_engine)
  - [`sqlalchemy.ext.declarative.declarative_base()`](http://docs.sqlalchemy.org/en/latest/orm/extensions/declarative/api.html#sqlalchemy.ext.declarative.declarative_base)
  - [`sqlalchemy.MetaData`](http://docs.sqlalchemy.org/en/latest/core/metadata.html#sqlalchemy.schema.MetaData)
  - [`sqlalchemy.orm.Mapper`](http://docs.sqlalchemy.org/en/latest/orm/mapping_api.html#sqlalchemy.orm.mapper.Mapper)
  - [`sqlalchemy.orm.Session`](http://docs.sqlalchemy.org/en/latest/orm/session_api.html#sqlalchemy.orm.session.Session)
  - [`sqlalchemy.orm.sessionmaker()`](http://docs.sqlalchemy.org/en/latest/orm/session_api.html#sqlalchemy.orm.session.sessionmaker)
  - [`sqlalchemy.orm.Query`](http://docs.sqlalchemy.org/en/latest/orm/query.html#sqlalchemy.orm.query.Query)
  - [`sqlalchemy.Table`](http://docs.sqlalchemy.org/en/latest/core/metadata.html#sqlalchemy.schema.Table)
  - [`sqlalchemy.Column`](http://docs.sqlalchemy.org/en/latest/core/metadata.html#sqlalchemy.schema.Column)
  - [`sqlalchemy.String`](http://docs.sqlalchemy.org/en/latest/core/type_basics.html#sqlalchemy.types.String)
  - [`sqlalchemy.Integer`](http://docs.sqlalchemy.org/en/latest/core/type_basics.html#sqlalchemy.types.Integer)

