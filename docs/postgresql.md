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

## PostgreSQL 跟 MySQL 的選擇??

  - Heroku 主推 PostgreSQL https://devcenter.heroku.com/articles/heroku-mysql 只提到 tight-              integration
  - Why Uber Engineering Switched from Postgres to MySQL - Uber Engineering Blog https://eng.uber.com/mysql-migration/ (2016-07-26) 但 Uber 又說 PostgreSQL 會遇到 scaling 的問題? #ril
  - What are pros and cons of PostgreSQL and MySQL? - Quora https://www.quora.com/What-are-pros-and-cons-of-PostgreSQL-and-MySQL #ril

## 新手上路 {: #getting-started }

  - [PostgreSQL: Documentation: 11: Part I\. Tutorial](https://www.postgresql.org/docs/11/tutorial.html) #ril

      - Welcome to the PostgreSQL Tutorial. The following few chapters are intended to give a simple introduction to PostgreSQL, relational database concepts, and the SQL language to those who are new to any one of these aspects.

      - After you have worked through this tutorial you might want to move on to reading Part II to gain a more formal knowledge of the SQL language, or Part IV for information about developing applications for PostgreSQL. Those who set up and manage their own server should also read Part III.

## 安裝設定 {: #installation }

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
