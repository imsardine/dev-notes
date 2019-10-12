# MySQL

## mysqld

  - [MySQL :: MySQL 8\.0 Reference Manual :: 4\.3\.1 mysqld — The MySQL Server](https://dev.mysql.com/doc/refman/8.0/en/mysqld.html)
      - `mysqld` (MySQL Server) 是 MySQL 的主程式，它管理著 data directory (含有 database 及 table) 的存取，預設其他 log & status file 也在 data directory 裡。
      - MySQL Server 有許多 system variable 可以影響它的行為，有些甚至可以在 runtime 改變，另外也有許多 status variables 可以用來監看 runtime performance characteristics。
  - [mysql \- How to stop mysqld \- Stack Overflow](https://stackoverflow.com/questions/11091414/) 如何停止 `mysqld`? #ril
      - 自己的狀況；手動啟動 `mysqld` 時，按 Ctrl-C 確實沒用，用另一個 session 執行 `mysqld stop` 一樣卡住。
      - squiter: 用 `mysqladmin -u root shutdown` ... 真的有效!
  - [MySQL :: MySQL 8\.0 Reference Manual :: 5\.1\.6 Server Command Options](https://dev.mysql.com/doc/refman/8.0/en/server-options.html) #ril
      - `mysqld` 會讀取 option file 裡的 `[mysqld]` 與 `[server]`，但也接受 command options。
  - [MySQL :: MySQL 8\.0 Reference Manual :: 5\.1 The MySQL Server](https://dev.mysql.com/doc/refman/8.0/en/mysqld-server.html) 說明許多 configuration、system/status variables #ril

## System Variable ??

  - [MySQL :: MySQL 8\.0 Reference Manual :: 5\.1\.8 Server System Variables](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html) #ril

      - The MySQL server maintains many system variables that configure its operation. Each system variable has a default value. System variables can be set at server startup using options on the command line or in an option file.

      - Most of them can be changed dynamically at runtime using the `SET` statement, which enables you to modify operation of the server without having to stop and restart it. You can also use system variable values in expressions.

        例如 `SET GLOBAL variable = value;` 或 `SET SESSION variable = value`。

        At runtime, setting a global system variable value normally requires the `SYSTEM_VARIABLES_ADMIN` or `SUPER` privilege. Setting a session system variable value normally requires no special privileges and can be done by any user, although there are exceptions. For more information, see Section 5.1.9.1, “System Variable Privileges”

      - Some of the following variable descriptions refer to “enabling” or “disabling” a variable. These variables can be enabled with the `SET` statement by setting them to `ON` or `1`, or disabled by setting them to `OFF` or `0`. Boolean variables can be set at startup to the values `ON`, `TRUE`, `OFF`, and `FALSE` (not case sensitive), as well as `1` and `0`. See Section 4.2.6, “Program Option Modifiers”.

        在 command line option 裡 boolean 的字面表示比較多樣，在 `SET` 裡就只能用 `ON`/`1` 跟 `OFF`/`0`。

  - [MySQL :: MySQL 8\.0 Reference Manual :: 5\.1\.9\.1 System Variable Privileges](https://dev.mysql.com/doc/refman/8.0/en/system-variable-privileges.html) #ril

  - [MySQL :: MySQL 5\.7 Reference Manual :: 5\.1\.5 Server System Variables](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html)
      - MySQL server 用許多 system variables 來記錄組態。每個 system variable 都有個預設值，可以透過 command-line option 或 option file 設定，大部份也可以在 runtime 透過 `SET` 修改 (通常需要 SUPER privilege，但不用重啟 server)，在 expression 裡也可以引用 system variable。
      - 用 `SHOW VARIABLES` 可以看執行期 system variable 的值。
  - [MySQL :: MySQL 5\.7 Reference Manual :: 13\.7\.5\.39 SHOW VARIABLES Syntax](https://dev.mysql.com/doc/refman/5.7/en/show-variables.html)
      - `SHOW VARIABLES` 會列出 system variables 的值，不需要特別的 privilege，只要可以建立連線即可。
      - `SHOW [GLOBAL | SESSION] VARIABLES [LIKE 'pattern' | WHERE expr]`，可以用 `LIKE` 來過濾 variable name，例如 `LIKE '%connection%'。
      - 其中 `GLOBAL`/`SESSION` 稱做 variable scope modifier，預設會用 `SESSION`。所謂 global value 是指新 connection 用來初始化 session value 的預設值，而 session/local value 則是指 current connection。
  - [MySQL :: MySQL 5\.7 Reference Manual :: 5\.1\.6 Using System Variables](https://dev.mysql.com/doc/refman/5.7/en/using-system-variables.html) #ril

## Storage Engine ??

  - [MySQL :: MySQL 8\.0 Reference Manual :: 16 Alternative Storage Engines](https://dev.mysql.com/doc/refman/8.0/en/storage-engines.html)
      - Storage engine 是 MySQL 用來處理 SQL operation 的元件，預設是 InnoDB；架構上設計成 pluggable，可以動態 load/unload storage engine。
      - `SHOW ENGINES` 可以看支援哪些 storage engine，Support 欄位要是 YES/DEFAULT 才能使用。
      - 只有 InnoDB 與 NDB 支援 transaction 與 foreign key；這代表測試期間，拿 Memory storage engine 來做測試是有落差的。
      - InnoDB: Transaction-safe (ACID compliant)，支援 row-level locking 及 Oracle-style consistent nonlocking reads?? (提昇 multi-user concurrency)。把資料存在 clustered indexes，所以基於 primary key 的 query 可以減少 I/O?? 也支援 `FOREIGN KEY` referential-integrity constraints。
      - Memory: 把所有的資料存在 RAM，用於 quick lookups of non-critical data，不過它的用途越來越少。
      - CSV: 資料存放在 CSV 文字檔，主要用於 import/export 資料。
  - [MySQL :: MySQL 8\.0 Reference Manual :: A\.2 MySQL 8\.0 FAQ: Storage Engines](https://dev.mysql.com/doc/refman/8.0/en/faqs-storage-engines.html) #ril

## Connection, Pool ??

  - 最大同時連線數，可以用 `SHOW VARIABLES LIKE 'max_connections'` 查詢，預設是 100 或 150 (依 MySQL 版本不同)。
  - `SHOW PROCESSLIST` 可以查看目前的連線數，從 Command (Sleep) 跟 Time 可以看出連線已經閒置多久，至於閒置多久會被中斷，則要看 `wait_timeout` (non-interactive) 與 `interactive_timeout` 的設定 -- `SHOW VARIABLES LIKE '%_timeout'`，預設是 8hr (28800 sec)。

參考資料：

  - [MySQL :: MySQL Connector/J 5\.1 Developer Guide :: 7 Connection Pooling with Connector/J](https://dev.mysql.com/doc/connector-j/5.1/en/connector-j-usagenotes-j2ee-concepts-connection-pooling.html) #ril
      - Connection pooling 可以管理 a pool of connections 供任何需要 thread 取用，可以提昇 application 的效能，也減少 application 整理資源的使用量。
      - 處理 transaction 時才會用到 connection，其他時候 connection 處於 idle，而 connection pooling 可以讓 idle connection 讓其他有需要的 thread 使用；實務上 application 會跟 pool 拿 connection，用完後再放回 pool (未中斷連線)，所以 application 可能拿到已經存在的 connection，也可能是新建立的 connection。
      - 使用 connection pooling 的好處有 1. 減少建立連線的時間 (networking、driver overhead) 2. 避免 heavy load 時建立太多 connection 而導致不可預期的結果。
      - 每個 connection 在 client & server 兩端都有 overhead，因此 connection pool 需要調校。
      - Connection pool 的大小跟預期的負載、平均 DB 交易時間有關，實務上最佳的 connection pool 可能會小於你認為的，以 Oracle's Java Petstore blueprint 為例，15-20 個 connection 就足以應付 600 個 concurrent user。
      - 要找到適合的大小，可以透過 JMeter、Grinder 這些 load test 工具找出來。一開始可以不設定上限 (unbounded)，透過 load test 找出最高的同時連線數，以該數字為起點慢慢往回調，找到可以兼顧 best performance 及 response time 的 connection pool 大小。
      - 驗證 connection pool 裡 connection 的有效性，可以避免拿到 stale/die connection，檢查的時機可能是 pool 把 connection 交給 application 前、application 歸還 connection 給 pool 時，或是定期檢查 idle connections。
  - [MySQL :: MySQL 5\.7 Reference Manual :: B\.5\.2\.6 Too many connections](https://dev.mysql.com/doc/refman/5.7/en/too-many-connections.html)
      - 當連線數超過 `max_connections` system variable 的設定時，client 會收到 "Too many connections" 的錯誤，預設值是 150 (之前是 100)。
      - 事實上 `mysqld` 可以接受 `max_connections` + 1 個連線，多出來的那個 connection 是保留給具有 `SUPER` privilege 的 user (administrator)，讓他在出現 Too many connections 問題時，還可以連線進去用 `SHOW PROCESSLIST` 查看問題 (需要有 `PROCESS` privilege)。
      - 最大同時連線數跟特定 platform 上的 thread library、RAM 的數量、每個 connection 的 workload 及預期的 response time 有關。
  - [MySQL :: MySQL 5\.7 Reference Manual :: 13\.7\.5\.29 SHOW PROCESSLIST Syntax](https://dev.mysql.com/doc/refman/5.7/en/show-processlist.html)
      - `SHOW [FULL] PROCESSLIST` 顯示有哪些 thread 正在執行 (也就是未中斷的連線)，其中 `FULL` 是指 `Info` 欄位裡的 SQL statement 要完全顯示出來，不只是前 100 個字元。
      - `SHOW PROCESSLIST` 預設只會顯示自己的 thread (同一個 account)，如果有 `PROCESS` privilege 的話，才能看到所有的 thread；這裡 process、thread、connection 似乎是可以互通的?
      - 提到 thread 可以用 `KILL` 刪除，可以用來模擬意外斷線的狀況??
      - Id: Connection identifier 或 processlist ID
      - Command: 該 thread 目前在執行的 command type，Sleep 是指??
      - State: 該 thread 目前在做什麼? 跟 Command 有什麼差別??
      - Time: 目前的 state 已經持續多久 (秒)
  - [SHOW PROCESSLIST in MySQL command: sleep \- Stack Overflow](https://stackoverflow.com/questions/12194241/) Drew: Sleep 跟 connection pool 或 client-side DB admin tool 有關 #ril
  - [mysql \- Difference between wait\_timeout and interactive\_timeout \- Server Fault](https://serverfault.com/questions/375136/) #ril

## ON DELETE CASCADE ??

  - [MySQL ON DELETE CASCADE: Deleting Data From Multiple Tables](http://www.mysqltutorial.org/mysql-on-delete-cascade/) #ril
      - allows you to delete data from child tables automatically when you delete the data from the parent table 刪除 parent table 某個 item 時，會自動刪除 child tables 裡關聯的 items。

## 日期時間??

  - [MySQL :: MySQL 8\.0 Reference Manual :: 11\.3\.1 The DATE, DATETIME, and TIMESTAMP Types](https://dev.mysql.com/doc/refman/8.0/en/datetime.html) #ril
      - MySQL converts TIMESTAMP values from the current time zone to UTC for storage, and back from UTC to the current time zone for retrieval. (This does not occur for other types such as DATETIME.) 原來 `DATETIME` 不受時區影響?
  - [MySQL :: MySQL 8\.0 Reference Manual :: 9\.1\.3 Date and Time Literals](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-literals.html) #ril

## 權限管理??

  - [An introduction to MySQL permissions — DatabaseJournal\.com](https://www.databasejournal.com/features/mysql/article.php/3311731/An-introduction-to-MySQL-permissions.htm) (2004-02-17) #ril
  - [How to Grant All Privileges on a Database in MySQL](https://chartio.com/resources/tutorials/how-to-grant-all-privileges-on-a-database-in-mysql/) #ril
  - [How To Create a New User and Grant Permissions in MySQL \| DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql) (2012-06-12) #ril
  - [MySQL :: MySQL 5\.7 Reference Manual :: 6\.2\.1 Privileges Provided by MySQL](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html) #ril
  - [MySQL :: MySQL 5\.7 Reference Manual :: 13\.7\.1\.4 GRANT Syntax](https://dev.mysql.com/doc/refman/5.7/en/grant.html) #ril

## mysqldump??

  - [MySQL :: MySQL 5\.7 Reference Manual :: 4\.5\.4 mysqldump — A Database Backup Program](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html) 用來做 logical backup，產生一組 SQL statements 用以重建 database definition 與 table data -- 目的可能是 backup 或轉移資料，所以輸出格式也可以是 CSV 或 XML。
  - [Invocation Syntax - MySQL :: MySQL 5\.7 Reference Manual :: 4\.5\.4 mysqldump — A Database Backup Program](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#mysqldump-syntax) 常見的用法是 `mysqldump [OPTIONS] DB_NAME`，例如 `mysqldump [--host HOST] --user USER --password [--no-data] DB_NAME`

## Backup ??

  - [MySQL :: MySQL Enterprise Backup 4\.1 User's Guide :: 4\.3\.3 Making a Differential or Incremental Backup](https://dev.mysql.com/doc/mysql-enterprise-backup/4.1/en/mysqlbackup.incremental.html) #ril
  - [MySQL :: MySQL 8\.0 Reference Manual :: 7\.2 Database Backup Methods](https://dev.mysql.com/doc/refman/8.0/en/backup-methods.html) #ril

## information_schema ??

  - [MySQL :: MySQL 8\.0 Reference Manual :: 24 INFORMATION\_SCHEMA Tables](https://dev.mysql.com/doc/refman/8.0/en/information-schema.html) #ril
  - [MySQL :: MySQL 5\.7 Reference Manual :: 24 INFORMATION\_SCHEMA Tables](https://dev.mysql.com/doc/refman/5.7/en/information-schema.html) #ril

## Auto Increment ??

  - [How To Reset MySQL Autoincrement Column\. Autoincrement Number Reseting](https://viralpatel.net/blogs/reseting-mysql-autoincrement-column/) #ril

### 如何匯出/匯入資料??

  - [MySQL :: MySQL 5\.7 Reference Manual :: 13\.2\.9\.1 SELECT \.\.\. INTO Syntax](https://dev.mysql.com/doc/refman/5.7/en/select-into.html) 示範了 `SELECT ... INTO OUTFILE ... FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' FROM ...` 可以寫出 CSV 檔 #ril
  - [MYSQL into outfile "access denied" \- but my user has "ALL" access\.\. and the folder is CHMOD 777 \- Stack Overflow](https://stackoverflow.com/questions/6091427/) `GRANT ALL` 不含 `GRANT FILE`，有可能是因為檔案要寫在 server 端的關係? #ril
  - [MySQL :: MySQL 5\.7 Reference Manual :: 13\.2\.6 LOAD DATA INFILE Syntax](https://dev.mysql.com/doc/refman/5.7/en/load-data.html) `mysqldump -T` 或 `SELECT ... INTO OUTFILE` 可以寫出 CSV，相對地 `mysqlimport` 或 `LOAD DATA INFILE` 可以匯入 CSV #ril
  - [MySQL :: MySQL 5\.7 Reference Manual :: 4\.5\.5 mysqlimport — A Data Import Program](https://dev.mysql.com/doc/refman/5.7/en/mysqlimport.html) `mysqlimport` 做為 `LOAD DATA INFILE` 的 CLI，所以大部份 option 都直接對應到 `LOAD DATA INFILE` 的語法 #ril

## 如何刪除所有 Table ??

  - [MySQL DROP all tables, ignoring foreign keys \- Stack Overflow](https://stackoverflow.com/questions/3476765/) #ril
      - StuartLC: 為什麼不 `DROP DATABASE`，bcmcfc: 為了保留權限。
      - Dion Truter: `SELECT table_name FROM information_schema.tables WHERE table_schema='xxx'` 可以找到 tables。
  - [MySQL Empty Database / Delete or Drop All Tables \- nixCraft](https://www.cyberciti.biz/faq/how-do-i-empty-mysql-database/) #ril

## Duplicate entry '2147483647' for key 'PRIMARY'

  - [MySQL :: MySQL 5\.7 Reference Manual :: 11\.1\.1 Numeric Type Overview](https://dev.mysql.com/doc/refman/5.7/en/numeric-type-overview.html) `INT` 的值域是 -2147483648 ~ 2147483647。
  - [mysql \- ERROR 1062 \(23000\): Duplicate entry '2147483647' for key 'PRIMARY' \- Stack Overflow](https://stackoverflow.com/questions/20442140/) John Conde: 因為 `INT` (signed) 的最大值是 2147483647，任何超過這個數字的值會被 truncate；或許採用 `VARCHAR` 是更好的選擇?

## 安裝設置 {: #setup }

### Docker

```
$ docker volume create mysql-data
$ MYSQL_VERSION = 5 # 8
$ docker run --rm --name mysql -d \
    -v mysql-data:/var/lib/mysql \
    --env MYSQL_DATABASE=mydb \
    --env MYSQL_USER=appuser \
    --env MYSQL_PASSWORD=secret \
    --env MYSQL_ROOT_PASSWORD=admin \
    mysql:$MYSQL_VERSION
$ until docker logs mysql 2>&1 | grep 'mysqld: ready for connections.'; do continue; done

$ docker exec -it mysql mysql -u appuser -p
```

`Makefile` + Docker Compose 可以這麼用：

```
up:
	docker-compose up --detach
	until docker-compose logs mysql 2>&1 | grep 'mysqld: ready for connections'; do continue; done

down restart:
	docker-compose $(docker_compose_opts) $@
```

用 container 裡的 MySQL client 連到 Docker host 或其他 host 的 MySQL daemon：

```
$ alias mysql="docker run -it --rm mysql mysql -h host.docker.internal --default-character-set=utf8"
$ mysql -u xxx -p
$ mysql -h another-host -u xxx -p
```

其中 `host.docker.internal` 可以動態對應到 Docker host 的 IP，即便 host 沒有任何網路。

---

參考資料：

  - [library/mysql \- Docker Hub](https://hub.docker.com/_/mysql/)

    Start a mysql server instance

      - Starting a MySQL instance is simple:

            $ docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag

        ... where `some-mysql` is the name you want to assign to your container, `my-secret-pw` is the password to be set for the MySQL ROOT USER and `tag` is the tag specifying the MySQL version you want. See the list above for relevant tags.

        其中 `MYSQL_ROOT_PASSWORD` 沒給的話，container 會起不來直接死掉。

            $ docker run --name mysql mysql:5.7
            error: database is uninitialized and password option is not specified
              You need to specify one of MYSQL_ROOT_PASSWORD, MYSQL_ALLOW_EMPTY_PASSWORD and MYSQL_RANDOM_ROOT_PASSWORD

    Connect to MySQL from the MySQL command line client

      - The following command starts another mysql container instance and runs the mysql command line client against your original mysql container, allowing you to execute SQL statements against your database instance:

            $ docker run -it --network some-network --rm mysql mysql -hsome-mysql -uexample-user -p

        ... where `some-mysql` is the name of your original mysql container (connected to the `some-network` Docker network).

      - This image can also be used as a client for non-Docker or remote instances:

            $ docker run -it --rm mysql mysql -hsome.mysql.host -usome-mysql-user -p

    ... via docker stack deploy or docker-compose

      - Example `stack.yml` for mysql:

            # Use root/example as user/password credentials
            version: '3.1'

            services:

              db:
                image: mysql
                command: --default-authentication-plugin=mysql_native_password
                restart: always
                environment:
                  MYSQL_ROOT_PASSWORD: example

              adminer:
                image: adminer
                restart: always
                ports:
                  - 8080:8080

      - Run `docker stack deploy -c stack.yml mysql` (or `docker-compose -f stack.yml up`), WAIT FOR IT TO INITIALIZE COMPLETELY, and visit `http://swarm-ip:8080`, `http://localhost:8080`, or `http://host-ip:8080` (as appropriate).

    Container shell access and viewing MySQL logs

      - The `docker exec` command allows you to run commands inside a Docker container. The following command line will give you a bash shell inside your mysql container:

            $ docker exec -it some-mysql bash

      - The log is available through Docker's container log:

            $ docker logs some-mysql

    No connections until MySQL init completes

      - If there is no database initialized when the container starts, then a default database will be created.

        While this is the expected behavior, this means that it will not accept incoming connections UNTIL SUCH INITIALIZATION COMPLETES. This may cause issues when using automation tools, such as `docker-compose`, which start several containers simultaneously.

        原來時間差是因為要初始化資料庫產生的。

      - If the application you're trying to connect to MySQL does not handle MySQL downtime or waiting for MySQL to start gracefully, then a putting a CONNECT-RETRY LOOP before the service starts might be necessary. For an example of such an implementation in the official images, see WordPress or Bonita.

  - [Environment Variables - mysql \- Docker Hub](https://hub.docker.com/_/mysql/#environment-variables)

      - When you start the `mysql` image, you can adjust the configuration of the MySQL instance by passing one or more environment variables on the `docker run` command line. Do note that none of the variables below will have any effect if you start the container with a DATA DIRECTORY that already contains a database: any PRE-EXISTING DATABASE will always be left UNTOUCHED on container startup.

        也就是這些環境變數是專用於初始化資料庫；不過其他 MySQL 本來就會參考的環境變數，應該也會影響現有的 database 才對。

      - See also https://dev.mysql.com/doc/refman/5.7/en/environment-variables.html for documentation of environment variables which MySQL itself respects (especially variables like `MYSQL_HOST`, which is known to cause issues when used with this image).

    `MYSQL_ROOT_PASSWORD`

      - This variable is MANDATORY and specifies the password that will be set for the MySQL root superuser account. In the above example, it was set to `my-secret-pw`.

        用 `MYSQL_USER`/`MYSQL_PASSWORD` 建立另一個使用者時，可以用 `MYSQL_RANDOM_ROOT_PASSWORD` 給一個隨機的密碼，這時候沒給 `MYSQL_ROOT_PASSWORD` 就不會出錯，這樣用也滿合理的。

    `MYSQL_DATABASE`

      - This variable is optional and allows you to specify the name of a database to be created on image startup. If a user/password was supplied (see below) then that user will be GRANTED SUPERUSER ACCESS (corresponding to `GRANT ALL`) to this database.

        沒給 `MYSQL_DATABASE` 的話就不會自動建 database。

    `MYSQL_USER`, `MYSQL_PASSWORD`

      - These variables are optional, used in conjunction to create a new user and to set that user's password. This user will be granted superuser permissions (see above) for the database specified by the `MYSQL_DATABASE` variable. Both variables are required for a user to be created.

      - Do note that there is no need to use this mechanism to create the root superuser, that user gets created by default with the password specified by the `MYSQL_ROOT_PASSWORD` variable.

        `root` 這個使用者本來就會有，`MYSQL_USER`/`MYSQL_PASSWORD` 只是要求建立另一個使用者。

    `MYSQL_ALLOW_EMPTY_PASSWORD`

      - This is an optional variable. Set to `yes` to allow the container to be started with a blank password FOR THE ROOT USER.

        NOTE: Setting this variable to `yes` is not recommended unless you really know what you are doing, since this will leave your MySQL instance completely unprotected, allowing anyone to gain complete superuser access.

    `MYSQL_RANDOM_ROOT_PASSWORD`

      - This is an optional variable. Set to `yes` to generate a random initial password for the root user (using `pwgen`). The generated root password will be printed to stdout (`GENERATED ROOT PASSWORD: .....`).

    `MYSQL_ONETIME_PASSWORD`

      - Sets root (not the user specified in `MYSQL_USER`!) user as EXPIRED ONCE INIT IS COMPLETE, FORCING A PASSWORD CHANGE ON FIRST LOGIN.

        NOTE: This feature is supported on MySQL 5.6+ only. Using this option on MySQL 5.5 will throw an appropriate error during initialization.

        看似 `MYSQL_RANDOM_ROOT_PASSWORD` 的另一種選擇。

  - [Initializing a fresh instance - library/mysql \- Docker Hub](https://hub.docker.com/_/mysql/)

      - When a container is started FOR THE FIRST TIME, a new database with the specified name will be created and initialized with the provided configuration variables.

        有提供 `MYSQL_USER` 的話，該使用者對該 database 會取得 `GRANT ALL` 的權限 (Host 採 `%` 在開發時很方便)。

      - Furthermore, it will execute files with extensions `.sh`, `.sql` and `.sql.gz` that are found in `/docker-entrypoint-initdb.d`.

        Files will be executed IN ALPHABETICAL ORDER. You can easily POPULATE your `mysql` services by mounting a SQL dump into that directory and provide custom images with contributed data.

        SQL files will be imported by default to the database specified by the `MYSQL_DATABASE` variable.

  - [Where to Store Data - library/mysql \- Docker Hub](https://hub.docker.com/_/mysql/) #ril
  - [Using a custom MySQL configuration file - library/mysql \- Docker Hub](https://hub.docker.com/_/mysql/) #ril
  - [mysql/mysql\-server \- Docker Hub](https://hub.docker.com/r/mysql/mysql-server/) 由 [mysql/mysql-docker](https://github.com/mysql/mysql-docker) 產生，但其實是源自 `docker-library/mysql`，該用哪個??
  - [MySQL :: MySQL 5\.7 Reference Manual :: 2\.5\.7\.1 Basic Steps for MySQL Server Deployment with Docker](https://dev.mysql.com/doc/refman/5.7/en/docker-mysql-getting-started.html) 就 MySQL Community Server 而言，這裡用 `mysql/mysql-server` #ril

## 參考資料 {: #reference }

  - [MySQL](https://www.mysql.com/)

更多：

  - [InnoDB Storage Engine](mysql-innodb.md)
  - [JSON](mysql-json.md)

手冊：

  - [Keywords and Reserved Words - MySQL](https://dev.mysql.com/doc/refman/8.0/en/keywords.html)
  - [Server System Variables](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html) ([Dynamic](https://dev.mysql.com/doc/refman/8.0/en/dynamic-system-variables.html))
