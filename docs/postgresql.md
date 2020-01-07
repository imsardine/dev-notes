# PostgreSQL

  - 唸做 post-gres-q-l 或簡化成 post-gres。

參考資料：

  - [PostgreSQL: About](https://www.postgresql.org/about/) #ril

    What is PostgreSQL?

      - PostgreSQL is a powerful, open source OBJECT-RELATIONAL database system that uses and extends the SQL language combined with many features that safely store and scale the most complicated data workloads. The origins of PostgreSQL date back to 1986 as part of the POSTGRES project at the University of California at Berkeley and has more than 30 years of active development on the core platform.

        看似 PostgreSQL 也是一種 RDMBS，可以用 SQL 操作? 那 object 要強調的是什麼 ??

      - PostgreSQL has earned a strong reputation for its proven architecture, reliability, data integrity, robust feature set, extensibility, and the dedication of the open source community behind the software to consistently deliver performant and innovative solutions. PostgreSQL runs on all major operating systems, has been ACID-compliant since 2001, and has powerful add-ons such as the popular PostGIS geospatial database extender. It is no surprise that PostgreSQL has become the open source relational database of choice for many people and organisations.

      - [Getting started](https://www.postgresql.org/docs/current/tutorial.html) with using PostgreSQL has never been easier - pick a project you want to build, and let PostgreSQL safely and robustly store your data.

  - [PostgreSQL: Survey Results: How do you pronounce 'PostgreSQL'?](https://www.postgresql.org/community/survey/33-how-do-you-pronounce-postgresql/) 2004-12-22 調查，post-gres-q-l 最多人這樣唸，也有不少人簡單唸做 post-gres。
  - [PostgreSQL: PostgreSQL Press FAQ](https://www.postgresql.org/about/press/faq/) 唸做 post-GRES-que-ell，或 post-GRES。
  - [How do you pronounce PostgreSQL?](https://www.quora.com/How-do-you-pronounce-PostgreSQL) 跟官方 FAQ 的唸法一樣。

## PostgreSQL 跟 MySQL 的選擇 {: #vs-mysql }

  - [MySQL vs PostgreSQL \-\- Choose the Right Database for Your Project \| Okta Developer](https://developer.okta.com/blog/2019/07/19/mysql-vs-postgres) (2019-07-19)

      - The choice of a database management system is usually an AFTERTHOUGHT when starting a new project, especially on the Web. Most frameworks come with some object-relational mapping tool (ORM) which more or less HIDES THE DIFFERENCES between the different platforms and makes them all EQUALLY SLOW. ??

        Using the DEFAULT OPTION (MySQL in most cases) is rarely wrong, but it’s worth considering. Don’t fall into the trap of FAMILIARITY AND COMFORT – a good developer must always make INFORMED DECISIONS among the different options, their benefits and drawbacks.

    Database Performance

      - Historically, MySQL has had a reputation as an extremely fast database for READ-HEAVY workloads, sometimes AT THE COST OF CONCURRENCY when mixed with write operations.

      - PostgreSQL, also known as Postgres, advertises itself as “the most advanced open-source relational database in the world”. It was built to be feature-rich, extendable and standards-compliant. In the past, Postgres performance was more BALANCED - reads were generally slower than MySQL, but it was capable of writing large amounts of data more efficiently, and it handled CONCURRENCY BETTER.

      - The performance differences between MySQL and Postgres have been LARGELY ERASED in recent versions. MySQL is still very fast at reading data, but only if using the old MyISAM engine. If using InnoDB (which allows transactions, key constraints, and other important features), differences are NEGLIGIBLE (if they even exist).

        These features are absolutely critical to enterprise or consumer-scale applications, so using the old engine is not an option. On the other hand, MySQL has also been optimized to reduce the gap when it comes to HEAVY DATA WRITES.

      - When choosing between MySQL and PostgreSQL, performance should not be a factor for most RUN-OF-THE-MILL applications – it will be good enough in either case, even if you consider expected future growth.

        Both platforms are perfectly capable of replication, and many cloud providers offer managed scalable versions of either database. Therefore, it’s worth it to consider the other advantages of Postgres over MySQL before you start your next project with the DEFAULT DATABASE SETTING.

    Postgres Advantages over MySQL

      - Postgres is an OBJECT-RELATIONAL database, while MySQL is a PURELY RELATIONAL database. This means that Postgres includes features like TABLE INHERITANCE and function overloading, which can be important to certain applications. Postgres also adheres MORE CLOSELY TO SQL STANDARDS.

      - Postgres handles concurrency better than MySQL for multiple reasons:

          - Postgres implements Multiversion Concurrency Control (MVCC) without read locks
          - Postgres supports parallel query plans that can use multiple CPUs/cores
          - Postgres can create indexes in a non-blocking way (through the `CREATE INDEX CONCURRENTLY` syntax), and it can create PARTIAL indexes (for example, if you have a model with SOFT DELETES, you can create an index that ignores records marked as deleted)
          - Postgres is known for protecting data integrity at the transaction level. This makes it less vulnerable to data corruption.

    Default Installation and Extensibility of Postgres and MySQL

      - The default installation of Postgres generally works better than the default of MySQL (but you can tweak MySQL to compensate). MySQL has some outright weird default settings (for example, for character encoding and collation).

      - Postgres is highly extensible. It supports a number of advanced data types not available in MySQL (geometric/GIS, network address types, JSONB which can be indexed, native UUID, timezone-aware timestamps). If this is not enough, you can also add your own datatypes, operators, and index types.

      - Postgres is truly open-source and COMMUNITY-DRIVEN, while MySQL has had some LICENSING ISSUES.

        It was started as a company product (with a free and a paid version) and Oracle’s acquisition of MySQL AB in 2010 has led to some concerns among developers about its future open source status. However, there are several open source forks of the original MySQL (MariaDB, Percona, etc.), so this is not considered a huge risk at the moment.

    When to Use MySQL

      - Despite all of these advantages, there are still some small drawbacks to using Postgres that you should consider.

          - Postgres is still LESS POPULAR than MySQL (despite catching up in recent years), so there’s a smaller number of 3rd party tools, or developers/database ADMINISTRATORS available.

            這是很現實的考量；沒有 DBA 會管 PostgreSQL，確實是個問題。

          - Postgres forks a new process for each new client connection which allocates a non-trivial amount of memory (about 10 MB).

          - Postgres is built with extensibility, standards compliance, scalability, and data integrity in mind - sometimes at the expense of speed. Therefore, for simple, read-heavy workflows, Postgres might be a worse choice than MySQL.

      - These are only some of the factors a developer might want to consider when choosing a database. Additionally, your platform provider might have a PREFERENCE, for instance Heroku prefers Postgres and offers operational benefits to running it. Your framework may also prefer one over the other by offering better drivers. And as ever, your coworkers may have OPINIONS!

  - Heroku 主推 PostgreSQL https://devcenter.heroku.com/articles/heroku-mysql 只提到 tight-              integration
  - Why Uber Engineering Switched from Postgres to MySQL - Uber Engineering Blog https://eng.uber.com/mysql-migration/ (2016-07-26) 但 Uber 又說 PostgreSQL 會遇到 scaling 的問題? #ril
  - What are pros and cons of PostgreSQL and MySQL? - Quora https://www.quora.com/What-are-pros-and-cons-of-PostgreSQL-and-MySQL #ril

## 新手上路 {: #getting-started }

  - [PostgreSQL: Documentation: 11: Part I\. Tutorial](https://www.postgresql.org/docs/11/tutorial.html) #ril

      - Welcome to the PostgreSQL Tutorial. The following few chapters are intended to give a simple introduction to PostgreSQL, relational database concepts, and the SQL language to those who are new to any one of these aspects.

      - After you have worked through this tutorial you might want to move on to reading Part II to gain a more formal knowledge of the SQL language, or Part IV for information about developing applications for PostgreSQL. Those who set up and manage their own server should also read Part III.

## OID

  - [What Are Oids \| EnterpriseDB](https://www.enterprisedb.com/blog/what-are-oids) (2012-06-13)

      - Object Identifiers (oids) were added to Postgres as a way to UNIQUELY IDENTIFY DATABASE OBJECTS, e.g. ROWS, tables, functions, etc. It is part of Postgres's object-relational HERITAGE (遺產).

      - Because oids where assigned to EVERY DATA ROW by default, and were only four-bytes in size, they were increasingly seen as unnecessary. In Postgres 7.2 (2002), they were made optional, and in Postgres 8.1 (2005), AFTER MUCH WARNING, oids were no longer assigned to USER TABLES by default.

        They are still used by SYSTEM TABLES, and can still be added to user tables using the `with oids` clause during create table. Server parameter `default_with_oids` controls the default mode for table creation (defaults to "false").

        [E.24.2. Migration to Version 8.1 - PostgreSQL: Documentation: 8\.1: Release 8\.1](https://www.postgresql.org/docs/8.1/release-8-1.html#AEN74605)

        > `default_with_oids` is now `false` by default (Neil)
        >
        > With this option set to `false`, USER-CREATED TABLES no longer have an OID column unless `WITH OIDS` is specified in `CREATE TABLE`. Though OIDs have existed in all releases of PostgreSQL, their use is LIMITED because they are only four bytes long and the counter is SHARED ACROSS ALL INSTALLED DATABASES. The preferred way of uniquely identifying rows is via SEQUENCES and the `SERIAL` type, which have been supported since PostgreSQL 6.4.

        如果真的是 shared across all installed databases，表示換到另一台機器時，它的值會改變??

      - Oids as still used extensively for system table rows, and are used to JOIN SYSTEM TABLES, e.g.:

            SELECT oid, relname FROM pg_class ORDER BY 1 LIMIT 1;

             oid |              relname
            -----+-----------------------------------
             112 | pg_foreign_data_wrapper_oid_index
            (1 row)

        Only system tables that need oids have them, e.g. `pg_class` has an `oid` column, but `pg_attribute` does not.

  - [PostgreSQL: Documentation: 12: 8\.19\. Object Identifier Types](https://www.postgresql.org/docs/current/datatype-oid.html) #ril
  - [PostgreSQL \- OID System Column \- Table with OIDs \(Identity, Autoincrement\) \- SQLines Open Source Tools](http://www.sqlines.com/postgresql/oid) #ril
  - [database \- SQL, Postgres OIDs, What are they and why are they useful? \- Stack Overflow](https://stackoverflow.com/questions/5625585/) #ril

## 安裝設置 {: #setup }

  - [PostgreSQL: Documentation: 11: 1\.1\. Installation](https://www.postgresql.org/docs/11/tutorial-install.html)

      - If you are not sure whether PostgreSQL is already available or whether you can use it for your experimentation then you can install it yourself. Doing so is not hard and it can be a good exercise. PostgreSQL can be installed by any UNPRIVILEGED USER; NO SUPERUSER (ROOT) ACCESS IS REQUIRED.

      - If you are installing PostgreSQL yourself, then refer to Chapter 16 for instructions on installation, and return to this guide when the installation is complete. Be sure to follow closely the section about setting up the appropriate environment variables.

      - If your site administrator has not set things up in the default way, you might have some more work to do. For example, if the database server machine is a remote machine, you will need to set the `PGHOST` environment variable to the name of the database server machine.

  - [PostgreSQL: Documentation: 11: Chapter 16\. Installation from Source Code](https://www.postgresql.org/docs/11/installation.html) 完全沒提到 Docker #ril

### Docker

  - [postgres \- Docker Hub](https://hub.docker.com/_/postgres) #ril

## 參考資料 {: #reference }

  - [PostgreSQL](https://www.postgresql.org/)
  - [Planet PostgreSQL](https://planet.postgresql.org/)

社群：

  - ['postgresql' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/postgresql)
  - [PostgreSQL (@PostgreSQL) / Twitter](https://twitter.com/postgresql)

文件：

  - [PostgreSQL: Manuals](https://www.postgresql.org/docs/manuals/)
