---
title: SQLAlchemy / Domain Model
---
# [SQLAlchemy](sqlalchemy.md) / Domain Model

  - [Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html) One approaches the structure and content of data from the perspective of a USER-DEFINED DOMAIN MODEL which is transparently persisted and refreshed from its underlying storage model"，而且連結還指向 Wikipedia 的 [Domain model](https://en.wikipedia.org/wiki/Domain_model)，似乎把跟 database 對應的 user-defined class 當做 domain model 了?
  - [Domain Model - Glossary — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/glossary.html#term-domain-model) 這裡的說法 entities、attributes、relationships、constraints 跟 Wikipedia 已經對不起來了，反倒沒有提到 data + behavior 的重點?
  - [Declare a Mapping - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#declare-a-mapping) 最後提到 mapped classes 被加工 (instrumented) 後跟一般 Python class 無異，也可以宣告其他 attribute、method；這一點對 domain model 很友善。

## 新手上路 ?? {: #getting-started }

參考資料：

  - Flask Blueprints - Joel Perras - Google Books https://books.google.com.tw/books?id=SfSoCwAAQBAJ&pg=PA38&lpg=PA38&dq=domain+modeling#v=onepage&q=domain%20modeling&f=false 提到 hybrid attributes 在 domain model 方面的應用 - Hybrid attributes are so named because they can provide distinctly different behaviors when invoked at the class level or instance level. The SQLAlchemy documentation is a great place to learn about the various roles that they can fulfill in your domain modeling
  - Changing Attribute Behavior — SQLAlchemy 1.2 Documentation http://docs.sqlalchemy.org/en/latest/orm/mapped_attributes.html#using-descriptors-and-hybrids Using Descriptors and Hybrids 一節提到 `@hybrid_property` 可以用來包裝一層邏輯，對應以底線開頭的欄位，但 query 時仍然可以用沒有底線的版本 #ril

        from sqlalchemy.ext.hybrid import hybrid_property

        class EmailAddress(Base):
            __tablename__ = 'email_address'

            id = Column(Integer, primary_key=True)

            _email = Column("email", String)

            @hybrid_property
            def email(self):
                return self._email

            @email.setter
            def email(self, email):
                self._email = email

  - Types of Mappings — SQLAlchemy 1.2 Documentation http://docs.sqlalchemy.org/en/latest/orm/mapping_styles.html#classical-mapping Classical mapping 會不會更適合實作 domain model?
  - [the __init__() method - Object Relational Tutorial — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html#create-an-instance-of-the-mapped-class) Instrumentation 會自動產生一個可以接受不同 column names 的 `__init__()`，不過我們還是可以自訂 constructor。

## Hybrid Attribute ??

  - [Hybrid Attributes — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/orm/extensions/hybrid.html) #ril
  - [Introductions to Hybrid Properties in SQLAlchemy \- PyNash](http://pynash.org/2013/03/01/Hybrid-Properties-in-SQLAlchemy/) (2013-03-01) #ril
  - [Using a Hybrid - SQL Expressions as Mapped Attributes — SQLAlchemy 1\.2 Documentation](https://docs.sqlalchemy.org/en/latest/orm/mapped_sql_expr.html#using-a-hybrid) #ril

## Model 可以做 validation，可否直接產生 WTForm?

  - WTForms-Alchemy — WTForms-Alchemy 0.16.5 documentation https://wtforms-alchemy.readthedocs.io/en/latest/ #ril

