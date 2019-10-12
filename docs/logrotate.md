# logrotate

  - [logrotate/logrotate: The logrotate utility is designed to simplify the administration of log files on a system which generates a lot of log files\.](https://github.com/logrotate/logrotate)

      - The logrotate utility is designed to simplify the administration of log files on a system which generates a lot of log files. Logrotate allows for the automatic ROTATION COMPRESSION, removal and MAILING of log files. Logrotate can be set to handle a log file hourly, daily, weekly, monthly or when the log file gets to a certain size.

## 新手上路 {: #getting-started }

  - [Logrotate \- ArchWiki](https://wiki.archlinux.org/index.php/Logrotate) #ril

      - By default, logrotate's rotation consists of RENAMING existing log files with a NUMERICAL SUFFIX, then RECREATING the original EMPTY log file.

        For example, `/var/log/syslog.log` is renamed `/var/log/syslog.log.1`. If `/var/log/syslog.log.1` already exists from a previous rotation, it is first renamed `/var/log/syslog.log.2`. (The number of BACKLOGS to keep can be configured.)

        所以數字越小，內容越新。

    Usage

      - logrotate is usually run through Cron jobs. To run logrotate manually:

            logrotate /etc/logrotate.conf

      - To rotate a single log file:

            logrotate /etc/logrotate.d/mylog

        如果條件符合才會 rotate，跟下面的 `-f, --force` 可以用來測試特定 log file 的設定。

      - To simulate running your configuration file (dry run):

            logrotate -d /etc/logrotate.d/mylog

      - To force running rotations EVEN WHEN CONDITIONS ARE NOT MET, run

            logrotate -vf /etc/logrotate.d/mylog

        其中 `-v` 只是 `--verbose`，而 `-f` 才是 `--force` 跟強制 rotate 有關。

      - See logrotate(8) for more details.

  - [How To Manage Logfiles with Logrotate on Ubuntu 16\.04 \| DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-manage-logfiles-with-logrotate-on-ubuntu-16-04) (2017-11-09) #ril

## Configuration

  - [Configuration - Logrotate \- ArchWiki](https://wiki.archlinux.org/index.php/Logrotate#Configuration)

      - The PRIMARY configuration file for logrotate which sets default parameters is `/etc/logrotate.conf`; additional APPLICATION-SPECIFIC configuration files are included from the `/etc/logrotate.d` directory.

        Values set in application-specific configuration files override those same parameters in the primary configuration file. See `logrotate.conf(5)` for configuration examples and a reference of available` directives.

        以 Utuntu 下的 APT 為例：

            $ cat /etc/logrotate.d/apt
            /var/log/apt/term.log { <-- 要 rorate 的檔案，下面描述何時、如何 rotate
              rotate 12
              monthly
              compress
              missingok
              notifempty
            }

            /var/log/apt/history.log {
              rotate 12
              monthly
              compress
              missingok
              notifempty
            }

      - To VERIFY if logrotate works correctly run the following command which will produce debug output:

            logrotate -d # dry run

        在 Ubuntu 上執行沒有實質作用，要給 config file 才行：

            $ sudo logrotate -d
            logrotate 3.8.7 - Copyright (C) 1995-2001 Red Hat, Inc.
            This may be freely redistributed under the terms of the GNU Public License

            Usage: logrotate [-dfv?] [-d|--debug] [-f|--force] [-m|--mail=command] [-s|--state=statefile] [-v|--verbose] [--version] [-?|--help] [--usage]
                    [OPTION...] <configfile>

## 安裝設置 {: #setup }

  - [Installation - Logrotate \- ArchWiki](https://wiki.archlinux.org/index.php/Logrotate#Installation)

      - Logrotate can be installed with the `logrotate` package. It is INSTALLED BY DEFAULT as it is member of the `base` group.

      - By default, logrotate runs DAILY using a systemd timer: `logrotate.timer`.

        但為什麼下面又說 "logrotate is usually run through Cron jobs." ??

## 參考資料 {: #reference }

  - [logrotate/logrotate - GitHub](https://github.com/logrotate/logrotate)

手冊：

  - [`logrotate(8)` — Arch manual pages](https://jlk.fjfi.cvut.cz/arch/manpages/man/logrotate.8)
  - [`logrotate.conf(5)` — Arch manual pages](https://jlk.fjfi.cvut.cz/arch/manpages/man/logrotate.conf.5)
