---
title: SQLAlchemy / ORM (Object Relational Mapper)
---
# [SQLAlchemy](sqlalchemy.md) / ORM (Object Relational Mapper)

  - [Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html) #ril
      - SQLAlchemy ORM (Object Relational Mapper) 提出一種將 user-defined Python class 跟 database table 聯結 (associate) 起來的方法，也就是每個 instance 都對應到個別的 table row。有個 unit of work 的機制可以自動同步 object 與 row 的改變 (transparently)，也可以用 class 及宣告的 relationship 來表達 database query。
      - ORM 是基於 SQLAlchemy 的 SQL Expression Language (用 Python constructs 間接執行 SQL statements)，一個 application 完全只用 ORM 是沒有問題的，極少數情況下才需要直接使用 SQL Expression Language。


      - 生成 mapped class instance 只是第一步，要寫進 database 得透過 `Session.add()` 加進 session 才行，下次 flush 時就會被寫進資料庫。

            >>> ed_user = User(name='ed', fullname='Ed Jones', password='edspassword')
            >>> session.add(ed_user)

      - 加進 session 但還沒寫入資料庫前，這個 instance 處於 pending state (未加入 session 前是 transient state)，因為 SQL statement 尚未執行，而且在 database 裡也還沒有對應的 row (還沒有 PK)。`Session` 會在需要時執行 SQL 寫入資料庫，這個動作稱做 flush，例如在 query 前 - 因為 query 發生在 database 端，異動先進 database (但還沒 commit)，查詢的結果才能反應最新的異動。

            >>> our_user = session.query(User).filter_by(name='ed').first()
            >>> our_user
            <User(name='ed', fullname='Ed Jones', password='edspassword')>

      - 上面 query 的動作會先 flush 再執行 query。這裡傳回的 `our_user` 會等同於 `ed_user` (`assert our_user is ed_user`)，那是因為 session 會維護一個 identity map，在同一個 session 裡，在資料庫裡具有特定 primary key 的 row，只會對應到 session 裡的一個 Python object。

## Mapping, Declarative, Metadata, Instrumentation ??

  - [Declare a Mapping - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#declare-a-mapping) #ril
      - When using the ORM, the configurational process starts by describing the database tables we’ll be dealing with, and then by defining our own classes which will be mapped to those tables. In modern SQLAlchemy, these two tasks are usually PERFORMED TOGETHER, using a system known as DECLARATIVE, which allows us to create classes that INCLUDE DIRECTIVES TO DESCRIBE THE ACTUAL DATABASE TABLE they will be mapped to.

        這段話很重要，但要先走過 SQLAlchemy Core 才知道單純的宣告 metadata 是怎麼回事，所以 declarative = mapper(class + metadata)，在 class 裡直接提供生成 metadata 需要的素材 (例如 `__tablename__`、`relationship()` 等)，這中間的魔法來自 declarative base class 的 metaclass 機制。

      - Declarative system 需要先定義 mapping (實質上就是 mapped class)，裡面主要是 table name、column name/datatype 與 database table 的對應關係。這些 class 要繼承一個 declarative base class (用 `sqlalchemy.ext.declarative.declarative_base()` 產生)，內部會維護 class/table 的清單 (catalog)，通常一個 app 只會有一個 base class。
      - Mapped class 至少要宣告 `__tablename__` 跟一個 `Column` 做為 PK，因為 SQLAlchemy 不對 table name、data type、constraints 等不做任何假設；不過自訂 custom base class 或 mixin 是被鼓勵的 #ril
      - 以 `User` 對應 `users` table 為例，有 `id` (PK)、`name`、`fullname` 與 `password` 4 個欄位；另外 `__repr__()` 不一定要實作，但印到 logs 時好像很方便?

            from sqlalchemy.ext.declarative import declarative_base
            from sqlalchemy import Column, Integer, String

            Base = declarative_base()

            class User(Base):
              __tablename__ = 'users'

              id = Column(Integer, primary_key=True)
              name = Column(String)
              fullname = Column(String)
              password = Column(String)

              def __repr__(self):
                return "<User(name='%s', fullname='%s', password='%s')>" % (
                       self.name, self.fullname, self.password)

      - 當 class 建立時，declarative system 透過 metaclass (來自 declarative base class) 將所有的 `Column` 置換成 descriptor (對 attribute access 動手腳)、並自動產生 table metadata - `Table` (可以從 `__table__` attribute 取得)、透過 `Mapper` 建立兩邊的聯結，形成 mapped class，這個過程稱做 instrumentation，可以同步 class 與 database 兩邊的資料；這要先看過 SQL Expression Language 前面才會懂。

            >>> User.__table__
            Table('users', MetaData(bind=None),
                        Column('id', Integer(), table=<users>, primary_key=True, nullable=False),
                        Column('name', String(), table=<users>),
                        Column('fullname', String(), table=<users>),
                        Column('password', String(), table=<users>), schema=None)

      - Mapped class 跟其他 class 沒什麼不同，可以宣告其他的 attribute、method 等。
      - 雖然建議使用 declarative system，但要使用 SQLAlchemy ORM 也可以走 classical mapping - 任何 Python class 都可以跟透過 `mapper()` 產生 `Mapper`，以建立 class 與 `Table` 的聯結。
      - `Table` 只是 `MetaData` 的一員，可以從 declarative base class 的 `metadata` attribute 取得，可以把它想成是整個 schema，底下有許多 `Table`。可以想見，透過 `MetaData.create_all()` (搭配 `Engine` 做為 database connectivity) 就可以建立資料庫 - 把不存在的 table 建立起來。

            >>> Base.metadata.create_all(engine) # 這時才會用到 engine 跟資料庫溝通
            SELECT ...
            PRAGMA table_info("users")
            ()
            CREATE TABLE users (
                id INTEGER NOT NULL, name VARCHAR,
                fullname VARCHAR,
                password VARCHAR,
                PRIMARY KEY (id)
            )
            ()
            COMMIT

      - Minimal Table Descriptions vs. Full Descriptions 提到 "The length field on String, as well as similar precision/scale fields available on Integer, Numeric, etc. are not referenced by SQLAlchemy other than when creating tables."，也就是說透過 SQLAlchemy 來建立資料結構時這些 constraint 才會作用，跟 validation 無關。
      - 要新增一個 instance/row 時，首先要生成一個 mapped class 的 instance：

            >>> ed_user = User(name='ed', fullname='Ed Jones', password='edspassword')
            >>> ed_user.name
            'ed'
            >>> ed_user.password
            'edspassword'
            >>> str(ed_user.id)
            'None'

      - 顯然 instrumentation 還提供了 `__init__()` constructor，可以接受以 column 為名的 keyword arguments，除非有自訂 `__init__()`。

  - [instrumentation - Glossary — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/glossary.html#term-instrumentation)
      - Instrumentation refers to the process of augmenting the FUNCTIONALITY and ATTRIBUTE SET of a particular class. Ideally, the behavior of the class should REMAIN CLOSE TO A REGULAR CLASS, except that additional behaviors and features are made available.
      - The SQLAlchemy MAPPING PROCESS, among other things, adds DATABASE-ENABLED descriptors to a mapped class which each represent a particular database column or relationship to a related class.

## Session ??

  - [SQL Expression Language Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/core/tutorial.html) 這裡完全沒提到 session，是 ORM 才有的概念。
  - [Creating a Session - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#creating-a-session) #ril
      - ORM 跟 database 對話的接口 (handle) 是 `Session`，一個 session 是一個 workspace，對應一個 database connection (來自 engine 的 connection pool)。首先得用 `sqlalchemy.orm.sessionmaker()` 產生一個 `Session` 的 factory (可以設定 auto flush、auto commit 等)，有趣的是這個 factory 也習慣命名為 `Session` (callable)，然後呼叫它以產生一個 `Session` instance ... 這聽起來有點繞口? This custom-made `Session` class will create new `Session` objects which are bound to our database.

            from sqlalchemy.orm import sessionmaker
            Session = sessionmaker(bind=engine)
            # Session.configure(bind=engine) # 事後綁定

            session = Session()

      - 跟 `Engine` 一樣，雖然 `Session()` 生成了 `Session` instance，但還沒有建立連線，開始使用時才會從 engine 的 connection pool 取用一個 connection，直到 commit 或關閉 session 時。
      - Session Lifecycle Patterns 提到 `Session` instance 的產生時機會因應用類型而異，強調 session 是個 workspace - local to a particular database connection。
      - Session Lifecycle Patterns 強調 "the Session is just a workspace for your objects, local to a particular database connection"，workspace 這說法類似於 Git 的 working tree，有助於理解 transient、pending、dirty、new 這些說法 #ril

  - [Using the Session — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/session.html) #ril
  - [Session Basics — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/session_basics.html) #ril
  - [State Management — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/session_state_management.html) object Mapped class 的 instance 在 session 看來有 transient、pending、persistent、deleted 四種狀態 #ril
  - [Session API — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/session_api.html) #ril

## Relationship ??

  - [Building a Relationship - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#building-a-relationship) #ril
      - 系統內一個 user 可以有多個 email address，也就是 `users` 與 `addresses` 兩個 table 間有 one to many association；Mapping 可以這麼做：(建議對照 [Define and Create Tables (Core)](https://docs.sqlalchemy.org/en/latest/core/tutorial.html#define-and-create-tables) 一起看，很多設定是 Core 本來就有的，並非專屬於 ORM)

            >>> from sqlalchemy import ForeignKey
            >>> from sqlalchemy.orm import relationship

            >>> class Address(Base):
            ...     __tablename__ = 'addresses'
            ...     id = Column(Integer, primary_key=True)
            ...     email_address = Column(String, nullable=False)
            ...     user_id = Column(Integer, ForeignKey('users.id')) # Core 也是類似的寫法
            ...
            ...     user = relationship("User", back_populates="addresses") # 這是 ORM 才有的
            ...
            ...     def __repr__(self):
            ...         return "<Address(email_address='%s')>" % self.email_address

            >>> User.addresses = relationship( # 可以 instrumentation 後才給?
            ...     "Address", order_by=Address.id, back_populates="user")

      - `user_id = Column(Integer, ForeignKey('users.id'))` 中 `ForeignKey` 的意義是 "values in this column should be CONSTRAINED to be values present in the named remote column"，就這個例子而言是指 `addresses.user_id` 的值一定要出現在 `uses.id` 裡；事實上這寫法在 Define and Create Tables (Core) 就有，只是在描述 schema/metadata，跟 ORM 沒有直接關係。
      - `user = relationship("User", back_populates="addresses")` 就跟 ORM 有關，表示 `Address` 透過 `Address.user` 與 `User` 產生連結 (linkage)，`relationship()` 內部會依 foreign key relationships (`ForeignKey`/`ForeignKeyConstraint`) 決定連結的類型 -- 按照 `relationship()` API 文件的說法，應該是決定 `foreign_keys`。
      - `relationship("User", back_populates="addresses")` 與 `relationship("Address", order_by=Address.id, back_populates="user")` 互相引用對方的 attribute name，形成所謂的 bidirectional relationship，這樣 `relationship()` 就會知道這其實是同一個 relationship，只是方向不同而已 (the same relationship as expressed in reverse)。

  - [sqlalchemy.orm.relationship() - Relationships API — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/orm/relationship_api.html#sqlalchemy.orm.relationship) #ril
      - `foreign_keys` - In normal cases, the `foreign_keys` parameter is NOT REQUIRED. `relationship()` will automatically determine which columns in the `primaryjoin` conditition are to be considered “foreign key” columns based on those `Column` objects that specify `ForeignKey`, or are otherwise listed as referencing columns in a `ForeignKeyConstraint` construct.
      - `foreign_keys` is only needed when: 提到 "as there are multiple foreign key references present" 及 "The `Table` being mapped does not actually have `ForeignKey` or `ForeignKeyConstraint` constructs present, often because the table was REFLECTED from a database that does not support foreign key reflection (MySQL MyISAM)." 可見 foreign key relationships 指的正是 `ForeignKey`/`ForeignKeyConstraint`；就算 backend 不支援 FK，只要手動補上 `ForeignKey`/`ForeignKeyConstraint` 即可?
      - `primaryjoin` - By default, this value is computed based on the FOREIGN KEY RELATIONSHIPS of the parent and child tables (or association table). 不就是 `Column(..., ForeignKey())`?
  - [bidirectional relationship - Glossary — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/glossary.html#term-bidirectional-relationship) #ril
  - [Basic Relationship Patterns — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/orm/basic_relationships.html#relationships-many-to-many) #ril
  - [Working with Related Objects - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#working-with-related-objects) #ril
  - [Eager Loading - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#eager-loading) #ril
  - [Deleting - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#deleting) #ril
  - [Building a Many To Many Relationship - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#building-a-many-to-many-relationship) #ril
  - [Relationship Configuration — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/relationships.html) #ril
  - [Linking Relationships with Backref — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/orm/backref.html) #ril
  - [Configuring how Relationship Joins — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/orm/join_conditions.html) #ril

## Relationship > One To Many, Many To One, One To One ??

  - [One To Many - Basic Relationship Patterns — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/orm/basic_relationships.html#one-to-many) #ril
  - [Many To One - Basic Relationship Patterns — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/orm/basic_relationships.html#many-to-one) #ril
  - [One To One - Basic Relationship Patterns — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/orm/basic_relationships.html#one-to-one) #ril
  - [Building a Relationship - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#building-a-relationship) 最後 Did you know? 提到 FOREIGN KEY can refer to its own table. This is referred to as a “self-referential” foreign key. 這要如何 mapping?

## Relationship > Many To Many ??

  - [Many To Many - Basic Relationship Patterns — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/orm/basic_relationships.html#many-to-many) #ril
  - [Assocation Object - Basic Relationship Patterns — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/orm/basic_relationships.html#association-object) #ril

## FK 需要同時揭露 ID 與 relationship 兩個 field 嗎?

  - 若同時揭露 ID 與 relationship，要存取 ID 是很方便，但更新 relationship 時 ID 會變嗎? 或者更新 ID 時 relationship 會變嗎?

### 如何不用 Foreign Key 宣告 Relationship ??

  - [Defining a relationship without a foreign key constraint? \- Google Groups](https://groups.google.com/forum/#!msg/sqlalchemy/q7mREhovAGw/Aufi76-GYp4J) 用 `relation()` #ril
  - [How do I do a join without a real foreign key constraint?](https://gist.github.com/nickretallack/7cf6d4f255b248a9f6ec) 用 `relationship('Parent', primaryjoin='foreign(Child.parent_id) == remote(Parent.id)')` 搭配 SQLite in-memory database 來測。用 `create_engine(echo=True)` 可以觀察 `CREATE TABLE` #ril
  - [orm \- sqlalchemy: create relations but without foreign key constraint in db? \- Stack Overflow](https://stackoverflow.com/questions/37806625/) 不要定義 `ForeignKey` constraint，改用 `relationship()` 搭配 `foreign_keys` 與 `primaryjoin` #ril
  - [Defining Constraints and Indexes — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/core/constraints.html#sqlalchemy.schema.ForeignKey) 是個 constraint #ril
  - [Configuring how Relationship Joins — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/join_conditions.html) 說明 `relationship()` 的用法 #ril
  - [python \- SQLAlchemy and joins, we have no foreign keys \- Stack Overflow](https://stackoverflow.com/questions/6352141/) 方法之一是 `relationship` + `primaryjoin` #ril

## NoForeignKeysError ??

  - [python \- How do I correct this sqlalchemy\.exc\.NoForeignKeysError? \- Stack Overflow](https://stackoverflow.com/questions/28015524/) 加 `Column()` 裡加上 `ForeignKey()` 即可 #ril
  - [【已解决】Flask的SQLAlchemy出错：NoForeignKeysError Could not determine join condition between parent child tables on relationship – 在路上](https://www.crifan.com/flask_sqlalchemy_noforeignkeyserror_could_not_determine_join_condition_between_parent_child_tables_on_relationship/) (2016-12-13) #ril
  - [NoForeignKeysError - Core Exceptions — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/core/exceptions.html?highlight=noforeignkeyserror#sqlalchemy.exc.NoForeignKeysError) Raised when no foreign keys can be located between two selectables during a join.

## Validation ??

  - [Simple Validators - Changing Attribute Behavior — SQLAlchemy 1\.3 Documentation](https://docs.sqlalchemy.org/en/latest/orm/mapped_attributes.html#simple-validators) #ril
      - A quick way to add a “validation” routine to an attribute is to use the `validates()` decorator. An attribute validator can raise an exception, halting the process of mutating the attribute’s value, or can change the given value into something different. (像是 filtering)
      - Validators, like all attribute extensions, are only called by normal USERLAND CODE; they are not issued when the ORM is populating the object: 這表示從資料庫載入資料時不會經過這一層，不會有多餘的運算。

            from sqlalchemy.orm import validates

            class EmailAddress(Base):
                __tablename__ = 'address'

                id = Column(Integer, primary_key=True)
                email = Column(String)

                @validates('email')
                def validate_email(self, key, address):
                    assert '@' in address
                    return address

## 多個 Declarative Base 間會互相干擾??

在生成第一個 mapping class 的 instance 時，觸發了下面的初始化：

```
# Initialize the inter-mapper relationships of all mappers that have been constructed thus far.
sqlalchemy.orm.mapper.configure_mappers()
sqlalchemy.orm.relationships._determine_joins()
```

問題或許就在 "inter-mapper relationships of all mappers"，會引發下面的錯誤：

```
NoForeignKeysError: Could not determine join condition between parent/child tables on relationship Address.user - there are no foreign keys linking these tables.  Ensure that referencing columns are associated with a ForeignKey or ForeignKeyConstraint, or specify a 'primaryjoin' expression.

InvalidRequestError: One or more mappers failed to initialize - can't proceed with initialization of other mappers. Triggering mapper: 'Mapper|Address|address'. Original exception was: Could not determine join condition between parent/child tables on relationship Address.user - there are no foreign keys linking these tables.  Ensure that referencing columns are associated with a ForeignKey or ForeignKeyConstraint, or specify a 'primaryjoin' expression.
```

其中 "One or more mappers failed to initialize" 看起來就滿合理的。

參考資料：

  - [python \- Must two SQLAlchemy declarative models share the same declarative\_base\(\)? \- Stack Overflow](https://stackoverflow.com/questions/1589748/) Denis Otkidach: 成功地在一個 session 中使用多個 declarative base，每個 base 有自己的 metadata，綁定不同的 database。 #ril
  - [Flask\+SQLAlchemy with multiple dababases and shared models \- Blog \- BlaXpirit](https://blaxpirit.com/blog/10/flask-sqlalchemy-with-multiple-dababases-and-shared-models.html) 提到 `scoped_session(sessionmaker(engine))` 的用法，不過這裡是共用一個 declarative base #ril

## Querying ??

  - [Querying - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#querying) #ril
  - [Querying with Joins - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#querying-with-joins) #ril

## 參考資料 {: #reference }

文件：

  - [SQLAlchemy ORM — SQLAlchemy Documentation](https://docs.sqlalchemy.org/en/latest/orm/)

