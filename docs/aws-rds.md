---
title: AWS / RDS (Relational Database Service)
---
# [AWS](aws.md) / RDS (Relational Database Service)

  - [Amazon Relational Database Service \(RDS\) – AWS](https://aws.amazon.com/rds/) #ril

      - Set up, operate, and scale a relational database in the cloud with just a few clicks.

      - Amazon Relational Database Service (Amazon RDS) makes it easy to set up, operate, and scale a relational database in the cloud. It provides cost-efficient and resizable capacity while automating time-consuming administration tasks such as hardware provisioning, database setup, patching and BACKUPS.

        It frees you to focus on your applications so you can give them the fast performance, high availability, security and compatibility they need.

      - Amazon RDS is available on several database INSTANCE TYPES - optimized for memory, performance or I/O - and provides you with six familiar DATABASE ENGINES to choose from, including Amazon Aurora, PostgreSQL, MySQL, MariaDB, Oracle Database, and SQL Server.

        You can use the AWS Database Migration Service to easily migrate or replicate your existing databases to Amazon RDS.

        除了 MySQL，竟然還有 MariaDB；畢竟 MariaDB 跟 MySQL DB 不完全相容。

## Parameter Group

  - [Working with DB Parameter Groups \- Amazon Relational Database Service](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithParamGroups.html) #ril

      - You manage your DB engine configuration by associating your DB instances with parameter groups. Amazon RDS defines parameter groups with default settings that apply to NEWLY CREATED DB instances . You can define your own parameter groups with customized settings. Then you can modify your DB instances to use your own parameter groups.

        A DB parameter group acts as a container for engine configuration values that are applied to one or more DB instances.

        最後幾句看來，不只會影響新建的 DB instance；另外注意，對象是 DB instance 而非邏輯上個別的 database。

      - If you create a DB instance without specifying a DB parameter group, the DB instance uses a DEFAULT DB parameter group.

        Each default DB parameter group contains database engine defaults and Amazon RDS system defaults based on the engine, compute class, and allocated storage of the instance.

        注意 default parameter group 與 defaults (或 default settings) 的差別；parameter group 本質上就是提供 defaults (有些設定跟 DB engine 有關，有些則是 RDS 本身)，但一開始就會有個不能改的 default parameter group。

        You can't modify the parameter settings of a default parameter group. Instead, you create your own parameter group where you choose your own parameter settings. Not all DB engine parameters can be changed in a parameter group that you create.

      - If you want to use your own parameter group, you create a new parameter group and modify the parameters that you want to. You then modify your DB instance to use the new parameter group. If you update parameters within a DB parameter group, the changes apply to ALL DB instances that are associated with that parameter group.

      - You can copy an existing DB parameter group with the AWS CLI `copy-db-parameter-group` command. Copying a parameter group can be convenient when you want to include most of an existing DB parameter group's custom parameters and values in a new DB parameter group.

      - Here are some important points about working with parameters in a DB parameter group:

          - Set any parameters that relate to the character set or collation of your database in your parameter group before creating the DB instance and before you create a database in your DB instance. This ensures that the default database and new databases in your DB instance use the character set and collation values that you specify.

            If you change character set or collation parameters for your DB instance, the parameter changes are NOT applied to existing databases.

            You can change character set or collation values for an existing database using the `ALTER DATABASE` command, for example:

                ALTER DATABASE database_name CHARACTER SET character_se

## 參考資料 {: #reference }

  - [Relational Database Service (RDS) – AWS](https://aws.amazon.com/rds/)
