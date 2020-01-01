---
title: PHP / Web Development
---
# [PHP](php.md) / Web Development

## Development Server

  - [PHP: Built\-in web server \- Manual](https://www.php.net/manual/en/features.commandline.webserver.php) #ril

## Configuration {: #config }

  - [PHP: The configuration file \- Manual](https://www.php.net/manual/en/configuration.file.php) #ril

## 安裝設置 {: #setup }

  - [PHP: Installation on Unix systems \- Manual](https://www.php.net/manual/en/install.unix.php) #ril
  - [PHP: Apache 2\.x on Unix systems \- Manual](https://www.php.net/manual/en/install.unix.apache2.php) #ril
  - [PHP: Nginx 1\.4\.x on Unix systems \- Manual](https://www.php.net/manual/en/install.unix.nginx.php) #ril

### Debian

  - [PHP: Debian GNU/Linux installation notes \- Manual](https://www.php.net/manual/en/install.unix.debian.php) #ril

      - This section contains notes and hints specific to installing PHP on » Debian GNU/Linux.

        Warning: Unofficial builds from third-parties are not supported here. Any bugs should be reported to the Debian team unless they can be reproduced using the latest builds from our » download area.

      - While the instructions for building PHP on Unix apply to Debian as well, this manual page contains specific information for other options, such as using either the `apt-get` or `aptitude` commands. This manual page uses these two commands interchangeably.

    Using APT

      - First, note that other related packages may be desired like `libapache2-mod-php5` to integrate with Apache 2, and `php-pear` for PEAR. ??

        Second, before installing a package, it's wise to ensure the package list is up to date. Typically, this is done by running the command `apt-get update`.

      - Example #1 Debian Install Example with Apache 2

            # apt-get install php5-common libapache2-mod-php5 php5-cli

        APT will automatically install the PHP 5 module for Apache 2 and all of its dependencies, and then activate it. Apache should be restarted in order for the changes take place. For example:

      - Example #2 Stopping and starting Apache once PHP is installed

            # /etc/init.d/apache2 stop
            # /etc/init.d/apache2 start

    Better control of configuration

      - In the last section, PHP was installed with only CORE MODULES. It's very likely that additional modules will be desired, such as MySQL, cURL, GD, etc. These may also be installed via the `apt-get` command.

      - Example #3 Methods for listing additional PHP 5 packages

            # apt-cache search php5
            # aptitude search php5
            # aptitude search php5 |grep -i mysql

        The examples will show a lot of packages including several PHP specific ones like `php5-cgi`, `php5-cli` and `php5-dev`. Determine which are needed and install them like any other with either `apt-get` or `aptitude`.

        And because Debian performs dependency checks, it'll prompt for those so for example to install MySQL and cURL:

      - Example #4 Install PHP with MySQL, cURL

            # apt-get install php5-mysql php5-curl

        APT will automatically add the appropriate lines to the different `php.ini` related files like `/etc/php5/apache2/php.ini`, `/etc/php5/conf.d/pdo.ini`, etc. and depending on the extension will add entries similar to `extension=foo.so`. However, restarting the web server (like Apache) is required before these changes take affect.

        看起來不同 PHP 版本的設定會拆開??

    Common Problems

      - If the PHP scripts are not parsing via the web server, then it's likely that PHP was not added to the web server's configuration file, which on Debian may be `/etc/apache2/apache2.conf` or similar. See the Debian manual for further details.

      - If an extension was seemingly installed yet the functions are undefined, be sure that the appropriate ini file is being loaded and/or the web server was restarted after installation.

