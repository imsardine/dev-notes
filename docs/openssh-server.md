---
title: OpenSSH / Server
---
# [OpenSSH](openssh.md) / Server

  - [OpenSSH Server](https://help.ubuntu.com/lts/serverguide/openssh-server.html) #ril
      - OpenSSH 實現了 Secure Shell (SSH) protocol，可以在網路串連的電腦之間 (networked computers) 進行 remote controlling 與交換檔案 (transferring files)，以取代不安全的 telnet、rcp 等。
      - OpenSSH daemon (sshd) 可以接受不同 client 的連線，包括 `ssh` (建立 remote control session)、`scp` (複製檔案)，支援不同的認證 (authentication) 方式 - plain password、public key、Kerberos tickets??
      - Client 與 server 要分別安裝 `openssh-client` 與 `openssh-server` 套件。
      - sshd 的組態檔在 `/etc/ssh/sshd_config`，語法參考 `man sshd_config`，修改過後用 `sudo systemctl restart sshd.service` 重新套用 (用 `sudo service sshd restart` 也可以)，在 remote control session 裡做這件事並不會斷線!?
      - `Banner /etc/issue.net` 用來顯示 pre-login banner，搭配 ASCII art 產生 
      - `ssh-keygen -t rsa` 用 RSA algorithm 產生 private key (`~/.ssh/id_rsa`) 與 public key (`~/.ssh/id_rsa.pub`)。用 `ssh-copy-id username@remotehost` 可以將 public key 複製到遠端的 `~/.ssh/authorized_keys` (權限應該要是 `600`)。

## 如何避免在組態 sshd 的過程中斷線?

  - OpenSSH Server https://help.ubuntu.com/lts/serverguide/openssh-server.html 提到若 SSH 是存取該機器的唯一管道，要小心因組態錯誤，導致 sshd 重啟後連不進去，或是 sshd 無法重啟；修改前先備份是個方式，但有沒有方法可以檢查語法?
  - OpenSSH Tip: Check Syntax Errors before Restarting SSHD Server – nixCraft (2008-01-08) https://www.cyberciti.biz/tips/checking-openssh-sshd-configuration-syntax-errors.html 用 `sshd -t` 檢查 #ril

## Connection closed by remote host ??

  - [MaxStartups - sshd\_config\(5\) \- OpenBSD manual pages](https://man.openbsd.org/sshd_config#MaxStartups) #ril

      - Specifies the maximum number of CONCURRENT UNAUTHENTICATED CONNECTIONS to the SSH daemon. Additional connections will be dropped until authentication succeeds or the `LoginGraceTime` expires for a connection. The default is `10:30:100`.

        同時間進來在做 authentication 的連線 (start) 預設是 10 個，其他 100 個連線 (full) 等 `LoginGraceTime` (預設 120s) 後若還沒有完成 authentication 就會被回絕 (收到 `Connection closed by remote host`)；不過 start 真的來到 10 之後，新連線有 30% (rate / 100) 機會被直接回絕，機率會隨著進入 queue 等待的連線，等比例增加到 100%。

      - Alternatively, RANDOM EARLY DROP can be enabled by specifying the three colon separated values `start:rate:full` (e.g. `"10:30:60"`).

        為什麼從預設的 `10:30:100` 改成 `10:30:60` 才有 random early drop 的效果，應該本來就有了? 從 "alternatively" 的說法看來，`MaxStartups` 也可以用單一個數字控制 concurrent unauthenticated connection?

        sshd(8) will refuse CONNECTION ATTEMPTS with a probability of rate/100 (30%) if there are currently start (10) unauthenticated connections. The probability INCREASES LINEARLY and all connection attempts are REFUSED if the number of unauthenticated connections reaches full (60).

  - [ssh\_exchange\_identification: Connection closed by remote host \(\#1687\) · Issues · GitLab\.com / GitLab\.com Support Tracker · GitLab](https://gitlab.com/gitlab-com/support-forum/issues/1687) - due to a load balancer config change
  - [ssh远程登陆有时候正常，有时候显示：ssh\_exchange\_identification: Connection closed by remote host，这是什么原因？ \- 知乎](https://www.zhihu.com/question/20023544) 許多人提到 SSH 連接數滿了，將 `/etc/ssh/ssh_config` 裡的 `MaxStartups` 設定提高 (或取消這個設定) 即可。

## 安裝設定 {: #installation }

### Ubuntu

  - 安裝 `openssh-server` 套件即可。
  - 組態檔在 `/etc/ssh/sshd_config` (語法參考 `man sshd_config`)，調整過後用 `sudo systemctl restart sshd.service` 重新套用。

參考資料：

  - [Installation - OpenSSH Server](https://help.ubuntu.com/lts/serverguide/openssh-server.html#openssh-installation) 提到 client 與 server 分開安裝。

## 參考資料 {: #reference }

手冊：

  - [`sshd_config`(5) - OpenBSD manual pages](https://man.openbsd.org/sshd_config)
