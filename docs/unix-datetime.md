---
title: Unix-like / Date/Time
---
# [Unix-like](unix.md) / Date/Time

Linux 開機時，會先讀取 BIOS 所記錄的時間，然後開始用自己的方式來計時。

Linux 作業系統當中其實有兩個時間，一個是 BIOS 硬體時鐘（hardware clock），一個則是 Linux 自己的系統時間（system time）。當我們使用 `date --set` 來設定時間時，只是更動到 Linux 的系統時間而已，BIOS 的時間並不會受到影響，除非用 `hwclock --systohc` 將系統時間寫入 BIOS。

 # date --set="2013/06/17 08:30"

不過 Linux 作業系統通常會在關機時，自動將系統時間寫回 BIOS，因此 `hwclock --systohc` 的動作也並非必要。

## 時間同步

先用 `ntpdate -q` 確認 system time 跟標準時間的落差：

--------------------------------------------------------------------------------
# ntpdate -q pool.ntp.org <1>
server 114.32.8.133, stratum 3, offset 240.063914, delay 0.06873
server 210.68.16.24, stratum 3, offset 240.054648, delay 0.10890
server 220.133.13.3, stratum 2, offset 240.050690, delay 0.08301
21 Nov 05:57:41 ntpdate[841]: step time server 220.133.13.3 offset 240.050690 sec <2>
--------------------------------------------------------------------------------
<1> `ntpdate -q` 不會改動 system time。
<2> "offset ... sec" 表示 system time 跟標準時間的差距，正值表示 system time 慢了，反之負值則表示 system time 快了。

手動校時可以用 `date` + `hwclock`, 網路校時則可以用 `ntpdate` + `hwclock`。

--------------------------------------------------------------------------------
# yum install ntp
# chkconfig --list ntpd       <1>
ntpd              0:off   1:off   2:off   3:off   4:off   5:off   6:off
# ntpdate pool.ntp.org        <2>
21 Nov 06:09:37 ntpdate[986]: step time server 120.119.28.1 offset 240.054985 sec
# hwclock --systohc           <3>
#
#
# ntpdate pool.ntp.org
21 Nov 05:33:34 ntpdate[32404]: the NTP socket is in use, exiting <4>
# service ntpd stop
Shutting down ntpd:                                        [  OK  ]
# ntpdate pool.ntp.org
21 Nov 05:26:12 ntpdate[32223]: step time server 59.124.196.83 offset 16.032887 sec
# service ntpd start
Starting ntpd:                                             [  OK  ]
--------------------------------------------------------------------------------
<1> 確認 `ntpd` 預設不會啟動，因為我們並不想拿這台機器做 time server。如果需要的話，可以用 `chkconfig ntpd on` 來啟動。
<2> 透過 time server 校對 system time。"offset ... sec" 表示校正當下 system time 跟標準時間的差距。
<3> 將校正過的 system time 寫回 hardware time。
<4> 遇到 "the NTP socket is in use"，表示 `ntp` 服務正在運作，要將它停用後才能手動網路校時。

安排每天半夜 4 點做網路校時：

--------------------------------------------------------------------------------
# crontab -e
0 4 * * * /usr/sbin/ntpdate pool.ntp.org
--------------------------------------------------------------------------------

## Timezone

時間有一個很重要的概念就是時區（time zone）。在 Linux 下，時區的定義跟各國日光節約時的規定都記錄在 `tzdata` 套件裡（Time Zone Data；許多時區檔案被安裝到 `/usr/share/zoneinfo/` 底下），這也就是為什麼 `tzdata` 更新頻率會這麼高的原因。

想知道系統的時區，可以查看 `/etc/localtime` 的內容，不過各 distros 的處理方式有些許不同。以 Red Hat 系統為例，它是以複製的方式來處理這個檔案（Debian 也是），而 SuSE 則是以 hard link 的方式來處理。

UTC+0 也有自己的時區檔 `/usr/share/zoneinfo/Etc/UTC`。

--------------------------------------------------------------------------------
$ cat /etc/localtime 
TZif2UTCTZif2UTC
UTC0
--------------------------------------------------------------------------------

要設定時區的話，可以改變 `/etc/localtime` 的指向。CentOS 則有專用的工具，但必須額外安裝 `system-config-date` 套件。

== 是否要將 BIOS 的時間解讀成 UTC？ ==

安裝 Linux 的過程中，時間設定的部份常會被問到 “System clock uses UTC”。

讓 BIOS 記錄 UTC 時間的好處是，系統會自動調整 DST（Daylight Saving Time；不需要手動依當地規定調整時間，前提當然是 `tzdata` 套件要定期更新）。不過在 multi-boot 的環境下，尤其是其中包含有 Windows 作業系統，則建議將 BIOS 的時間設為 local time，因為 Windows 沒有類似 Linux 下 “是否要將 BIOS 時間解讀成 UTC“ 的選項。

對 VM 而言，每個 VM 底層的 hardware clock 都是獨立的，所以沒有 multi-boot 的問題。

從 BIOS 讀出來的時間，要解讀成 UTC 或時區所在的 local time，設定方式會因系統而異。CentOS 設定在 `/etc/sysconfig/clock` 中的 `UTC`（`true`/`false`），Debian 則設定在 `/etc/default/rcS` 中的 `UTC`（`yes`/`no`）。

## HOTWO

### 調整時區 (Ubuntu) {: #change-timezone-ubuntu }

跟時區有關的設定檔有 `/etc/timezone` 與 `/etc/localtime`：

```
$ ls -l /etc | grep time
lrwxrwxrwx 1 root root         31 May 27 08:20 localtime -> /usr/share/zoneinfo/Asia/Taipei
-rw-r--r-- 1 root root         12 May 27 08:20 timezone

$ cat /etc/timezone
Asia/Taipei

$ hexdump -C /etc/localtime
00000000  54 5a 69 66 32 00 00 00  00 00 00 00 00 00 00 00  |TZif2...........|
00000010  00 00 00 00 00 00 00 05  00 00 00 05 00 00 00 00  |................|
00000020  00 00 00 29 00 00 00 05  00 00 00 10 80 00 00 00  |...)............|
00000030  c3 55 49 80 d2 54 59 80  d3 8b 7b 80 d4 42 ad f0  |.UI..TY...{..B..|
...
000002e0  00 00 7e 90 01 0c 00 00  70 80 00 04 4c 4d 54 00  |..~.....p...LMT.|
000002f0  43 53 54 00 4a 53 54 00  43 44 54 00 00 00 00 00  |CST.JST.CDT.....|
00000300  00 00 00 00 00 00 0a 43  53 54 2d 38 0a           |.......CST-8.|
0000030d
```

修改 timezone 有兩個方法：

  - `dpkg-reconfigure tzdata`

    透過選單調整

  - `timedatectl`

     先利用 `timedatectl list-timezones` 找出 timezone identifier，再用 `timedatectl set-timezone <TIMEZONE>` 調整。


          $ timedatectl list-timezones | grep -i chicago
          America/Chicago

          $ cat /etc/timezone
          America/Chicago
          $ ls -l /etc/localtime
          lrwxrwxrwx 1 root root 37 May 26 19:52 /etc/localtime -> ../usr/share/zoneinfo/America/Chicago

都同時會修改 `/etc/timezone` 跟 `/etc/localtime`，後者可以從 `man 5 localtime` 查到說明，但 `/etc/timezone` 的作用是什麼??

參考資料：

  - [How to change time\-zone settings from the command line \- Ask Ubuntu](https://askubuntu.com/questions/3375/)

      - Jossef Harush: 用 `timedatectl set-timezone TIMEZONE`，用 `timedatectl list-timezones` 可以查支援的 timezone。
      - Jorge Castro: `sudo dpkg-reconfigure tzdata` 有 menu-based UI
      - pm_labs: 提到 `/etc/localtime` 轉向 `/usr/share/zoneinfo/...` 的做法，不過用 `timedatectl` 修改前 `/etc/localtime` 並不是 symbolic link?
      - Gilles: 若只是要改變某個 program 的時區，自訂 `TZ` 環境變數即可。
      - chasapis.christos: 修改 `/etc/timezone` 但要重新開機；實驗發現 `timedatectl set-timezone` 會同時修改 `/etc/localtime` 與 `/etc/timezone`，所以重開機設定不會跑掉。

  - [Changing the Time Zone - UbuntuTime \- Community Help Wiki](https://help.ubuntu.com/community/UbuntuTime#Changing_the_Time_Zone)

    Using the Command Line (terminal)

      - Using the command line, you can use `sudo dpkg-reconfigure tzdata`.

        The timezone info is saved in `/etc/timezone` - which can be edited or used below

    Using the Command Line (unattended)

      - Find out the LONG DESCRIPTION for the timezone you want to configure.

        參考 `man 5 localtime` 的說明，這裡 long description 更正式的說法應該是 timezone identifier。

      - Save this name to `/etc/timezone`

      - run `sudo dpkg-reconfigure --frontend noninteractive tzdata`:

            $ echo "Australia/Adelaide" | sudo tee /etc/timezone
            Australia/Adelaide
            $ sudo dpkg-reconfigure --frontend noninteractive tzdata

            Current default time zone: 'Australia/Adelaide'
            Local time is now:      Sat May  8 21:19:24 CST 2010.
            Universal Time is now:  Sat May  8 11:49:24 UTC 2010.

        This can be scripted if required.

  - [Ubuntu Manpage: localtime \- Local timezone configuration file](http://manpages.ubuntu.com/manpages/focal/man5/localtime.5.html) #ril

      - `localtime` - Local timezone configuration file

        ` /etc/localtime -> ../usr/share/zoneinfo/...`

      - The `/etc/localtime` file configures the SYSTEM-WIDE TIMEZONE OF THE LOCAL SYSTEM that is used by applications FOR PRESENTATION to the user.

        It should be an absolute or relative symbolic link pointing to `/usr/share/zoneinfo/`, followed by a TIMEZONE IDENTIFIER such as "Europe/Berlin" or "Etc/UTC". The resulting link should lead to the corresponding BINARY `tzfile`(5) TIMEZONE DATA for the configured timezone.

      - Because the timezone identifier is EXTRACTED from the symlink target name of `/etc/localtime`, this file may NOT be a normal file or hardlink.

        透過 symlink 的 target name 來決定 timezone identifier! 這設計有點特別。

      - The timezone may be overridden for individual programs by using the `$TZ` environment
       variable. See `environ`(7).

        You may use `timedatectl`(1) to change the settings of this file from the command line during runtime. Use `systemd-firstboot`(1) to initialize the time zone on mounted (but not booted) system images. ??

## 參考資料 {: #reference }

手冊：

  - [timedatectl(1)](https://www.linux.org/docs/man1/timedatectl.html)
