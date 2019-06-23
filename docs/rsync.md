# rsync

  - [rsync \- Wikipedia](https://en.wikipedia.org/wiki/Rsync) #ril
      - rsync 能在不同系統間根據 timestamp 及檔案大小傳輸/同步檔案的工具 (演算法屬 delta encoding，減少網路傳輸量)，在 Unix-like 上很常見；用 zlib 進行壓縮，傳輸期間的安全性則可以靠 SSH/stunnel。
      - 例如 `rsync local-file user@remote-host:remote-file` 可以跟遠端同步 -- 用 `user` 的身份登入 `remote-host`，一旦 SSH 連線成功後，兩端的 rsync 就會一同決定哪些檔案 (或部份) 需要交換。
      - rsync 能以 daemon mode 運作，可以用 `rsync://` (native protocol) 交換檔案。
  - [How To Use Rsync to Sync Local and Remote Directories on a VPS \| DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps) (2013-09-10)
      - rsync = remote sync，主要用來同步 remote 與 local 兩端的檔案，利用演算法來最小化需要交換的資料量 -- 只交換有變動的部份。
      - rsync 是個工具，同時也可以是 network protocol (搭配 rsync 工具使用)。

## 新手上路 {: #getting-started }

```
$ rsync --archive [--delete] [--verbose] [--dry-run] src-dir/ dest-dir
```

## `rsync` CLI {: #cli }

  - [How To Use Rsync to Sync Local and Remote Directories on a VPS \| DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps) (2013-09-10) #ril
      - `rsync -r dir1/ dir2` 可以將 `dir1` 內容 (recursively) 同步到 `dir2`，跟 `cp` 一樣，第 1 個參數是 source，第 2 個參數是 destination。
      - 不過實務上更常用 `-a` (archive mode)，除了有 `-r` 的效果，還會保留 symbolic link、device file、mtime、group、owner 權限等。
      - 注意 `dir/` 後面的 slash，表示 "the content of dir1"，若沒有加 `/` 的話，會變成 `dir2/dir1/[files]` 多一層目錄。
      - 可以先用 `-n`/`--dry-run` 跑一次，搭配 `-v`/`--verbose` 看細節 (事實上，不加 `-v` 預設看不到任何東西 XD)；就能看出 `rsync -a dir1/ dir2` 與 `rsync -a dir1 dir2` 的差異。
      - 要跟 remote 同步，只要將 source 或 destination 改成 `username@remote_host:file` 即可。
      - 如果要同步的檔案未經壓縮，加 `-z`/`--compress` 會在傳輸過程中進行壓縮。
      - `-P` (等同於 `--progress --partial`)，其中 `--progress` 可以看到 progress bar，而 `--partial` 則可以支援續傳 (發現 dest 有傳到一半的檔案時，預設會被刪除)
      - 當 dest 比 src 多了一些檔案時，預設並不會從 dest 刪除 (避免 data loss)，可以加 `--delete` 要求刪除 (最好用 `--dry-run` 先測試過)。
  - [Use - rsync \- Wikipedia](https://en.wikipedia.org/wiki/Rsync#Uses) `rsync` 要描述 source 跟 destination，同時間只能有一邊是 remote -- `[USER@]HOST:FILE`
  - [rsync \- ArchWiki](https://wiki.archlinux.org/index.php/rsync) #ril

## 過程中檔案有異動 ??

  - [linux \- Behavior of rsync with file that's still being written? \- Super User](https://superuser.com/questions/847850/) #ril
  - [backup \- Is using rsync while source is being updated safe? \- Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/90245/) #ril

## 遠端要 sudo 才能讀取/寫入檔案

某個 user 在 remote 端可以 `sudo`，但 `rsync` 期間如何 `sudo`？

  - 在 remote 端的 `/etc/sudoers` 增加一筆 `username ALL=NOPASSWD: /usr/bin/rsync` (執行 `sudo rsync` 時不會問密碼)
  - `rsync username@hostname` 再搭配 `--rsync-path="sudo rsync"` 即可。

例如：

```
$ rsync -avzP --rsync-path="sudo rsync" jeremykao@source-host:/var/log .
```

參考資料：

  - [permissions \- Using rsync with sudo on the destination machine \- Ask Ubuntu](https://askubuntu.com/questions/719439/) Thomas Weller: 編輯 `/etc/sudoers` 加上 `<username> ALL=NOPASSWD:<path to rsync>`，再搭配 `--rsync-path="sudo rsync"` 即可。
  - [rsync and sudo over SSH \| crashingdaily](https://crashingdaily.wordpress.com/2007/06/29/rsync-and-sudo-over-ssh/) (2007-06-29) 也提到 `ALL= NOPASSWD:/usr/bin/rsync` 的做法 (之一) #ril
  - https://www.devops.zone/tricks/rsync-using-sudo-over-ssh/[Rsync using sudo over SSH | DevOps Zone] (2016-07-27) `user1    ALL=NOPASSWD: /usr/bin/rsync *` 會讓 `user1` 登入後，執行 `sudo rsync` 時不會被問密碼；搭配 `-e "ssh" --rsync-path="sudo rsync"` 使用。
  - [ubuntu \- Run rsync with root permission on remote machine \- Super User](https://superuser.com/questions/270911/) #ril

## 如何顯示整體進度?

rsync 3.1.0 後支援 `--info=progress2` 顯示整體傳輸進度，要避免與 `-v`/`--verbose` 一起使用 (螢幕會因輸出檔名而一直捲動)。另外 rsync 3.0 後 recursive 會採用 incremental scan (掃過部份目錄就開始傳輸)，要停用 incremental scan 算出來的整體進度才有參考價值 (`--no-i-r`/`--no-inc-recursive`)，例如：

```
$ rsync -azP --info=progress2 --no-inc-recursive jermeykao@source-host:/var/log .
```

參考資料：

  - [linux \- Showing total progress in rsync: is it possible? \- Server Fault](https://serverfault.com/questions/219013/)
      - Avio: rsync v3.1.0 支援 `--info=progress2` 的用法
      - Alex: 要搭配 `--no-i-r`/`--no-inc-recursive` 使用，在開始 copy 才會掃過整個目錄結構，知道還剩多少要傳。
      - sanmai, Geremia: `--info=progress2` 不能/不要搭配 `-v` 使用，否則畫面會充滿 file name。
  - [-r, --recursive - rsync](https://download.samba.org/pub/rsync/rsync.html) rsync 3.0.0 開始，recursive 會採用 incremental scan 以節省記憶體，也就是掃完前面幾個目錄後就開始傳輸。有些操作需要 rsync 知道 full file list，可以用 `--no-i-r`/`--no-inc-recursive` 停用。
  - [-P - rsync](https://download.samba.org/pub/rsync/rsync.html) 提到 `--info=progress2` 會顯示整體進度 (statistics based on the whole transfer)，明確指出不想看一堆 filename 在捲動，就要避免 `-v` 或 `--info=name0` 的使用。

## 如何避開尖峰時間?

網路上存在 `--time-limit` 與 `--stop-at` 的說法，但這需要套用 patch，多數人建議搭配 `timeout` 使用，例如：

```
timeout rsync ...
```

若要搭配 cron job 在 non-busy hours 同步，過程中不需要輸入密碼才行。

參考資料：

  - [linux \- Favorite rsync tips and tricks \- Server Fault](https://serverfault.com/questions/45083/) `--time-limit` 指定 T 分鐘後停止，或是 `--stop-at=y-m-dTh:m` 在指定時間停止，可以在 non-busy hours 做備份。可惜 RedHat/CentOS 或 Ubuntu dist 都沒有這個 option。
  - [backup \- How to put running time constraints on rsync processes? \- Ask Ubuntu](https://askubuntu.com/questions/548287/) 沒有 `--time-limit`，可以搭配 `timeout`。
  - [Limit rsync running time](https://lists.samba.org/archive/rsync/2009-September/023938.html) (2009-09-17) 用 `timeout`。

## 同步大量檔案 ??

  - [synchronization \- Faster rsync of huge directory which was not changed \- Server Fault](https://serverfault.com/questions/746551/) #ril

## 參考資料 {: #reference }

  - [rsync](https://rsync.samba.org/)

手冊：

  - [rsync(1)](https://download.samba.org/pub/rsync/rsync.html)
  - [rsyncd.conf(5)](https://download.samba.org/pub/rsync/rsyncd.conf.html)
