# MariaDB

## 安裝設置 {: #setup }

### Ubuntu (Package Manager)

  - [How To Install MariaDB on Ubuntu 20\.04 \| DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-mariadb-on-ubuntu-20-04) (2020-05-12) #ril

      - MariaDB is an open-source relational database management system, commonly used as an alternative for MySQL as the database portion of the popular LAMP (Linux, Apache, MySQL, PHP/Python/Perl) stack. It is intended to be a drop-in replacement for MySQL.

      - The short version of this installation guide consists of these three steps:

            $ sudo apt update
            $ sudo apt install mariadb-server
            $ sudo mysql_secure_installation

          - Update your package index using `apt`
          - Install the `mariadb-server` package using `apt`. The package also pulls in related tools to interact with MariaDB
          - Run the `included mysql_secure_installation` security script to restrict access to the server

    Step 1 — Installing MariaDB

      - As of this writing, Ubuntu 20.04’s default APT repositories include MariaDB version 10.3.

        To install it, update the package index on your server with `apt`:

            $ sudo apt update

        Then install the package:

            $ sudo apt install mariadb-server

      - These commands will install MariaDB, but will not prompt you to set a password or make any other configuration changes. Because the default configuration leaves your installation of MariaDB INSECURE, we will use a script that the `mariadb-server` package provides to restrict access to the server and remove unused accounts.

    Step 2 — Configuring MariaDB

      - For new MariaDB installations, the next step is to run the included security script. This script changes some of the less secure default options for things like remote `root` logins and sample users.

        Run the security script:

            $ sudo mysql_secure_installation

        This will take you through a series of prompts where you can make some changes to your MariaDB installation’s security options. The first prompt will ask you to enter the CURRENT database `root` password. Since you have not set one up yet, press ENTER to indicate “none”.

            NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
                  SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

            In order to log into MariaDB to secure it, we'll need the current
            password for the root user.  If you've just installed MariaDB, and
            you haven't set the root password yet, the password will be blank,
            so you should just press enter here.

            Enter current password for root (enter for none):

      - The next prompt asks you whether you’d like to set up a database `root` password. On Ubuntu, the `root` account for MariaDB is tied closely to AUTOMATED SYSTEM MAINTENANCE, so we should not change the configured AUTHENTICATION METHODS for that account.

        Doing so would make it possible for a package update to break the database system by removing access to the administrative account.?? Type `N` and then press `ENTER`.

            . . .
            OK, successfully used password, moving on...

            Setting the root password ensures that nobody can log into the MariaDB
            root user without the proper authorisation.

            Set root password? [Y/n] N

      - Later, we will cover how to set up an additional ADMINISTRATIVE ACCOUNT for password access if SOCKET AUTHENTICATION is not appropriate for your use case.

        From there, you can press `Y` and then `ENTER` to accept the defaults for all the subsequent questions. This will remove some ANONYMOUS USERS and the TEST DATABASE, disable remote `root` logins, and load these new rules so that MariaDB immediately implements the changes you have made.

      - With that, you’ve finished MariaDB’s initial security configuration. The next step is an optional one, though you should follow it if you prefer to authenticate to your MariaDB server with a password.

    Step 3 — (Optional) Creating an Administrative User that Employs Password Authentication

      - On Ubuntu systems running MariaDB 10.3, the `root` MariaDB user is set to authenticate using the `unix_socket` plugin by default RATHER THAN WITH A PASSWORD. This allows for some GREATER SECURITY and USABILITY in many cases, but it can also complicate things when you need to allow an external program (e.g., phpMyAdmin) administrative rights.

      - Because the server uses the `root` account for tasks like log rotation and starting and stopping the server, it is best not to change the `root` account’s authentication details.

        Changing credentials in the `/etc/mysql/debian.cnf` configuration file may work initially, but package updates could potentially overwrite those changes. Instead of modifying the `root` account, the package maintainers recommend creating a separate administrative account for PASSWORD-BASED ACCESS.

      - To this end, we will create a new account called `admin` with the SAME CAPABILITIES as the `root` account, but configured for password authentication. Open up the MariaDB prompt from your terminal:

            $ sudo mariadb

        Then create a new user with root privileges and password-based access. Be sure to change the username and password to match your preferences:

            MaiaDB [(none)]> GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;

        Grant 的動作就是建立使用者??

        Flush the privileges to ensure that they are saved and available in the current session:

            MaiaDB [(none)]> FLUSH PRIVILEGES;

        Following this, exit the MariaDB shell:

            MaiaDB [(none)]> exit

    Step 4 — Testing MariaDB

      - When installed from the default repositories, MariaDB will start running automatically. To test this, check its status.

            $ sudo systemctl status mariadb

        You’ll receive output that is similar to the following:

            ● mariadb.service - MariaDB 10.3.22 database server
                 Loaded: loaded (/lib/systemd/system/mariadb.service; enabled; vendor preset: enabled)
                 Active: active (running) since Tue 2020-05-12 13:38:18 UTC; 3min 55s ago
                   Docs: man:mysqld(8)
                         https://mariadb.com/kb/en/library/systemd/
               Main PID: 25914 (mysqld)
                 Status: "Taking your SQL requests now..."
                  Tasks: 31 (limit: 2345)
                 Memory: 65.6M
                 CGroup: /system.slice/mariadb.service
                         └─25914 /usr/sbin/mysqld
            . . .

        If MariaDB isn’t running, you can start it with the command `sudo systemctl start mariadb`.

      - For an additional check, you can try connecting to the database using the `mysqladmin` tool, which is a client that lets you run administrative commands. For example, this command says to connect to MariaDB as `root` using the UNIX SOCKET and return the version:

            $ sudo mysqladmin version

        You will receive output similar to this:

            mysqladmin  Ver 9.1 Distrib 10.3.22-MariaDB, for debian-linux-gnu on x86_64
            Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

            Server version      10.3.22-MariaDB-1ubuntu1
            Protocol version    10
            Connection      Localhost via UNIX socket
            UNIX socket     /var/run/mysqld/mysqld.sock
            Uptime:         4 min 49 sec

            Threads: 7  Questions: 467  Slow queries: 0  Opens: 177  Flush tables: 1  Open tables: 31  Queries per second avg: 1.615

      - If you configured a separate administrative user with password authentication, you could perform the same operation by typing:

            $ mysqladmin -u admin -p version

        This means that MariaDB is up and running and that your user is able to authenticate successfully.

## 參考資料 {: #reference }

  - [MariaDB.org](https://mariadb.org/)
