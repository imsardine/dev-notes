---
title: SQLAlchemy / Domain Model
---
# [SQLAlchemy](sqlalchemy.md) / Domain Model

  - [Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html) One approaches the structure and content of data from the perspective of a USER-DEFINED DOMAIN MODEL which is transparently persisted and refreshed from its underlying storage model"，而且連結還指向 Wikipedia 的 [Domain model](https://en.wikipedia.org/wiki/Domain_model)，似乎把跟 database 對應的 user-defined class 當做 domain model 了?
  - [Domain Model - Glossary — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/glossary.html#term-domain-model) 這裡的說法 entities、attributes、relationships、constraints 跟 Wikipedia 已經對不起來了，反倒沒有提到 data + behavior 的重點?
  - [Declare a Mapping - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#declare-a-mapping) 最後提到 mapped classes 被加工 (instrumented) 後跟一般 Python class 無異，也可以宣告其他 attribute、method；這一點對 domain model 很友善。
  - [Constructors and Object Initialization — SQLAlchemy 1\.3 Documentation](https://docs.sqlalchemy.org/en/latest/orm/constructors.html) ORM 載資料時並不透過 constructor，所以 `__init__()` 可以自由安排 #ril

## 新手上路 ?? {: #getting-started }

參考資料：

  - Flask Blueprints - Joel Perras - Google Books https://books.google.com.tw/books?id=SfSoCwAAQBAJ&pg=PA38&lpg=PA38&dq=domain+modeling#v=onepage&q=domain%20modeling&f=false 提到 hybrid attributes 在 domain model 方面的應用 - Hybrid attributes are so named because they can provide distinctly different behaviors when invoked at the class level or instance level. The SQLAlchemy documentation is a great place to learn about the various roles that they can fulfill in your domain modeling
  - Types of Mappings — SQLAlchemy 1.2 Documentation http://docs.sqlalchemy.org/en/latest/orm/mapping_styles.html#classical-mapping Classical mapping 會不會更適合實作 domain model?
  - [the __init__() method - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#create-an-instance-of-the-mapped-class) Instrumentation 會自動產生一個可以接受不同 column names 的 `__init__()`，不過我們還是可以自訂 constructor。

## Hybrid Attribute ??

  - [Using Descriptors and Hybrids - Changing Attribute Behavior — SQLAlchemy 1\.3 Documentation](https://docs.sqlalchemy.org/en/latest/orm/mapped_attributes.html#using-descriptors-and-hybrids)
      - A more comprehensive way to produce modified behavior for an attribute is to use descriptors. These are commonly used in Python using the `property()` function. The standard SQLAlchemy technique for descriptors is to create a plain descriptor, and to have it read/write from a MAPPED ATTRIBUTE with a different name. Below we illustrate this using Python 2.6-style properties:

            class EmailAddress(Base):
                __tablename__ = 'email_address'

                id = Column(Integer, primary_key=True)

                # name the attribute with an underscore,
                # different from the column name
                _email = Column("email", String)

                # then create an ".email" attribute
                # to get/set "._email"
                @property
                def email(self):
                    return self._email

                @email.setter
                def email(self, email):
                    self._email = email

      - The approach above will work, but there’s more we can add. While our `EmailAddress` object will shuttle the value through the email descriptor and into the `_email` mapped attribute, the class level `EmailAddress.email` attribute does not have the usual EXPRESSION SEMANTICS usable with `Query`. (不能用在 query 裡的意思) To provide these, we instead use the HYBRID EXTENSION as follows:

            from sqlalchemy.ext.hybrid import hybrid_property

            class EmailAddress(Base):
                __tablename__ = 'email_address'

                id = Column(Integer, primary_key=True)

                _email = Column("email", String)

                @hybrid_property <-- 從 @property 換成 @hybrid_property
                def email(self):
                    return self._email

                @email.setter
                def email(self, email):
                    self._email = email

        The `.email` attribute, in addition to providing getter/setter behavior when we have an instance of `EmailAddress`, also provides a SQL expression when used at the CLASS LEVEL, that is, from the `EmailAddress` class directly:

            from sqlalchemy.orm import Session
            session = Session()

            SQLaddress = session.query(EmailAddress).\
                             filter(EmailAddress.email == 'address@example.com').\
                             one()

            # SQL:
            # SELECT address.email AS address_email, address.id AS address_id
            # FROM address
            # WHERE address.email = ? <-- 跟 email (getter) 裡的邏輯無關
            # ('address@example.com',)

            address.email = 'otheraddress@example.com'
            SQLsession.commit()

      - The `hybrid_property` also allows us to change the behavior of the attribute, including defining separate behaviors when the attribute is accessed at the INSTANCE LEVEL versus at the CLASS/EXPRESSION LEVEL, using the `hybrid_property.expression()` modifier. Such as, if we wanted to add a host name automatically, we might define TWO SETS of string manipulation logic:

        所謂 class/expression level，是因為用 expression language 寫 query 時，都是用 `mapped_class.attribute`，要如何讓 SQLAlchemy 知道 attribute getter 有一些邏輯，在轉換過的 SQL 也套用相同的邏輯，這就是 `hybrid_property.expression()` 在做的事。

        這也間接說明了，多包裝一層 property 或 hybrid property，並不會增加 query 的負擔，加上 [Simple Validators - Changing Attribute Behavior](https://docs.sqlalchemy.org/en/latest/orm/mapped_attributes.html#simple-validators) 提到的 "Validators, like all ATTRIBUTE EXTENSIONS, are only called by normal USERLAND CODE; they are not issued when the ORM is POPULATING the object:"，就算是從 DB 載入資料也不會有多餘的運算。

            class EmailAddress(Base):
                __tablename__ = 'email_address'

                id = Column(Integer, primary_key=True)

                _email = Column("email", String)

                @hybrid_property
                def email(self):
                    """Return the value of _email up until the last twelve
                    characters."""

                    return self._email[:-12]

                @email.setter
                def email(self, email):
                    """Set the value of _email, tacking on the twelve character
                    value @example.com."""

                    self._email = email + "@example.com"

                @email.expression
                def email(cls):
                    """Produce a SQL expression that represents the value
                    of the _email column, minus the last twelve characters."""

                    return func.substr(cls._email, 0, func.length(cls._email) - 12)

        Above, accessing the `email` property of an instance of `EmailAddress` will return the value of the `_email` attribute, removing or adding the hostname `@example.com` from the value. When we query against the `email` attribute, a SQL FUNCTION is rendered which produces the same effect:

            address = session.query(EmailAddress).filter(EmailAddress.email == 'address').one()

            # SQL:
            # SELECT address.email AS address_email, address.id AS address_id
            # FROM address
            # WHERE substr(address.email, ?, length(address.email) - ?) = ?
            # (0, 12, 'address')

  - [Hybrid Attributes — SQLAlchemy 1\.3 Documentation](https://docs.sqlalchemy.org/en/latest/orm/extensions/hybrid.html) #ril
  - [Introductions to Hybrid Properties in SQLAlchemy \- PyNash](http://pynash.org/2013/03/01/Hybrid-Properties-in-SQLAlchemy/) (2013-03-01) #ril
  - [Using a Hybrid - SQL Expressions as Mapped Attributes — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/orm/mapped_sql_expr.html#using-a-hybrid) #ril

## Model 可以做 validation，可否直接產生 WTForm?

  - WTForms-Alchemy — WTForms-Alchemy 0.16.5 documentation https://wtforms-alchemy.readthedocs.io/en/latest/ #ril

