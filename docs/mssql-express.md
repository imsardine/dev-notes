---
title: Microsoft SQL Server / Express
---
# [Microsoft SQL Server](mssql.md) / Express

  - [SQL Server Express \- Wikipedia](https://en.wikipedia.org/wiki/SQL_Server_Express) #ril

      - Microsoft SQL Server Express is a version of Microsoft's SQL Server relational database management system that is free to download, distribute and use. It comprises a database specifically targeted for EMBEDDED and SMALLER-SCALE APPLICATIONS.

        The product traces its roots to the Microsoft Database Engine (MSDE) product, which was shipped with SQL Server 2000. The "Express" branding has been used since the release of SQL Server 2005.

    Capabilities

      - SQL Server Express provides many of the features of the paid, full versions of Microsoft SQL Server database management system. However it has TECHNICAL RESTRICTIONS that make it unsuitable for some large-scale deployments. Differences in the Express product include:

          - Maximum database size of 10 GB per database in SQL Server 2016, SQL Server 2014, SQL Server 2012, and 2008 R2 Express (4 GB for SQL Server 2008 Express and earlier; compared to 2 GB in the former MSDE). The limit applies PER DATABASE (log files excluded); but in some scenarios users can access more data through the use of multiple interconnected databases.
          - No SQL Server Agent service

        Artificial hardware usage limits:

          - Single physical CPU, but multiple cores allowable

          - 1 GB of RAM (runs on a system with higher RAM amount, but uses only at most 1 GB per instance of SQL Server Database Engine. "Recommended: Express Editions: 1 GB All other editions: At least 4 GB and should be increased as database size increases to ensure optimal performance.").

            Express with Advanced Services has a limit of 4 GB per instance of Reporting Services (not available on other Express variants). Analysis Services is not available for any Express variant.
