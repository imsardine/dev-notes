# OpenSSH

  - OpenSSH 實現了 Secure Shell (SSH) protocol，可以在網路串連的電腦之間 (networked computers) 進行 remote controlling 與交換檔案 (transferring files)，以取代不安全的 telnet、rcp 等。

## Key Generation, Certificate ??

  - `ssh-keygen -t rsa -b 4096 -C COMMENT -f KEY_NAME` 用 RSA 演算法產生 SSH key pair，例如 `ssh-keygen -t rsa -b 4096 -C "GitLab deploy key (personal)" -f id_rsa_gitlab` 會在當前的目錄產生 `id_rsa_gitlab` 與 `id_rsa_gitlab.pub`。
  - 通常需要把 public key 的內容貼到其他地方，用 `pbcopy < KEY_FILE` (Mac) 可以複製到剪貼簿。 => 用 `ssh-copy-id` 才對。

參考資料：

  - [Generating a new SSH key - Generating a new SSH key and adding it to the ssh\-agent \- User Documentation](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#generating-a-new-ssh-key) #ril
  - [ssh\-keygen\(1\) \- OpenBSD manual pages](https://man.openbsd.org/ssh-keygen) #ril
      - `ssh-keygen` generates, manages and converts AUTHENTICATION KEYS for `ssh`(1). `ssh-keygen` can create keys for use by SSH protocol version 2. 支援不同 key format (指 file format，不同於 key type)，但要管理什麼??
      - 產生的 key type 由 `-t` option 決定，支援 `dsa`/`ecdsa`/`ed25519`/`rsa`，預設是 RSA。
      - 一般的使用者只會為了 public key authentication 執行一次 `ssh-keygen 在 `~/.ssh/id_<KEYTYPE>` 產生 authentication key (private)，例如 `~/.ssh/id_rsa`。而 system admin 可能用來產生 host keys。
      - 伴隨著 private key 產生的是對應的 public key (形成所謂的 key pair)，檔名是在 private key 的檔名後面串上 `.pub`，例如 `~/.ssh/id_rsa.pub`。
      - `ssh-keygen` 產生 key pair 的過程中也會詢問 passphrase，可以留白 (host key 不能有 passphrase)。passphrase 類似於 password，但它可以是任意長度，之後可以用 `-p` 修改，但如果忘了 passphrase 就只能重新產生 key pair。
      - 新的 key format 增加 comment 欄位幫助識別不同的 key (用途不同)，預設是 `user@host`，可以透過 `-C` 自訂，事後也可以用 `-c` 修改；似乎 comment 只會出現在 public key file??
      - `-b bits` - the number of bits in the key to create，就 RSA key 而言，最少要 1024 bits，但預設是 2048 bits。文件說 2048 bits 通常是夠的，但為什麼 GitHub 的文件都示範用 4096 ??
      - `-f filename` - 指定 key file 的檔名跟位置；試出來是相對於 CWD，但沒有指定的話，會是 `~/.ssh/id_xxx`。
  - [Certificates - ssh\-keygen\(1\) \- OpenBSD manual pages](https://man.openbsd.org/ssh-keygen#CERTIFICATES) #ril

參考資料：

  - OpenSSH Server https://help.ubuntu.com/lts/serverguide/openssh-server.html#openssh-keys `ssh-keygen -t rsa` 用 RSA algorithm 產生 private key (`~/.ssh/id_rsa`) 與 public key (`~/.ssh/id_rsa.pub`)。
  - SSH - GitLab Documentation https://docs.gitlab.com/ce/ssh/README.html#generating-a-new-ssh-key-pair 用 `ssh-keygen -t rsa -C "your.email@example.com" -b 4096` 產生 (其中 `-C` 就是個 comment，會附加在 public key 後面)

## 為不同 Host 指定不同的 Identity File ??

```
Host <NICKNAME> [<NICKNAME>] ...
  HostName <REAL_HOSTNAME_OR_IP>
  User <LOGIN_USER>
  IdentityFile ~/.ssh/id_rsa.xxx.pub
```

參考資料：

  - [ssh\(1\) \- OpenBSD manual pages](https://man.openbsd.org/ssh#ENVIRONMENT)

      - 沒有指定 identity file 的 environment variable
      - `-i identity_file` 可以指定 identity file (private key)，預設會用 `~/.ssh/id_dsa`、`~/.ssh/id_ecdsa`、`~/.ssh/id_ed25519` 或 `~/.ssh/id_rsa`，提到 "Identity files may also be specified on a PER-HOST BASIS in the configuration file."，但 It is possible to have multiple `-i` options 是怎麼回事?

  - [ssh\_config\(5\) \- OpenBSD manual pages](https://man.openbsd.org/ssh_config.5)
      - 依序從 command-line options -> user's configuration file (`~/.ssh/config`) -> system-wide configuration file (`/etc/ssh/ssh_config`) 讀取 configuration，以先讀取到的值為主 For each parameter, the first obtained value will be used. 也就是前者會覆寫後者；在同一個 configuration file 裡也是一樣，越上面的設定會優先採用 (如果符合 pattern 的話)。
      - 整個檔案以 `Host` specification 劃分，接下來的設定 -- 每一行都是 keyword-argument pair (但 `#` 開頭或空白行會被忽略) -- 只會套用在符合 pattern 的 host(s) 上 (直到下一個 `Host` 或 `Match` 出現)。`Host` 後面可以接多個用空白隔開的 pattern，單一個 `*` 則用來為所有 host 提供 global defaults (要擺在最後面)
      - 上面的 keyword-argument pair，`keyword` 與 `argument` 間可以用空白或 `=` 隔開，若 `argument` 內含空白，則可以用雙引號括起來；前者在 config 裡常用，後者則是方便在 command line 指定 options，例如 `PasswordAuthentication no` (config) 與 `ssh -o PasswordAuthentication=no`。
      - `IdentityFile` 指定 authentication identity，可以使用 `~` (tilde) 表示 home director，例如 `IdentityFile ~/.ssh/id_rsa`。
      - `User` 用來指定 log in 的身份，當使用者跟本機不同時很方便，不用記哪一台機器要用什麼使用者。
      - `HostName` 可以用來指定 log in 真正的 host name，預設是用 command line 給的名字；不太懂 "This can be used to specify nicknames or abbreviations for hosts." 的意思，所謂 nickname 應該在 `Host` 後面羅列出來吧??

  - [Creating remote server nicknames with \.ssh/config \- SaltyCrane Blog](https://www.saltycrane.com/blog/2008/11/creating-remote-server-nicknames-sshconfig/) (2008-11-20) 從範例看來，nickname 是指 `Host` 後面的 pattern，而真正的 host name 則由 `HostName` 來指定。
  - [OpenSSH Config File Examples \- nixCraft](https://www.cyberciti.biz/faq/create-ssh-config-file-on-linux-unix/) (2018-05-15) 習慣上 `Host ...` 以外的設定都會內縮一層。
  - 實驗發現，用 `Host` 指定某些 hosts 的設定之後，並不需要額外用 `Host *` 指定 identity file 要用 `~/.ssh/id_rsa`，好像自然會 fallback。

## 如何設定 SSH key 認證?

  - `ssh-keygen -t rsa` 用 RSA algorithm 產生 private key (`~/.ssh/id_rsa`) 與 public key (`~/.ssh/id_rsa.pub`)。
  - 用 `ssh-copy-id username@remotehost` 可以將 public key 複製到遠端的 `~/.ssh/authorized_keys` (權限應該要是 `600`)；過程中先用密碼登入?

參考資料：

  - OpenSSH Server https://help.ubuntu.com/lts/serverguide/openssh-server.html#openssh-keys SSH Keys 說明如何建立 key pair、如何把 public key 傳到另一台電腦。

## 如何在 remote control session 期間用 scp 交換檔案?

  - 許多討論都提到 `ControlMaster`?
  - Download a file over an active SSH session - Ask Ubuntu https://askubuntu.com/questions/13382/ #ril
  - SCP to the client via the current SSH session? - Ars Technica OpenForum https://arstechnica.com/civis/viewtopic.php?f=16&t=1126363 #ril
  - SSH easily copy file to local system - Unix & Linux Stack Exchange https://unix.stackexchange.com/questions/2857/ #ril

## 參考資料 {: #reference }

  - [OpenSSH](https://www.openssh.com/)

更多：

  - [SSH Tunneling](openssh-tunneling.md)
  - [OpenSSH Server](openssh-server.md)

手冊：

  - [OpenSSH: Manual Pages](https://www.openssh.com/manual.html)
      - [`ssh`(1) - OpenBSD manual pages](https://man.openbsd.org/ssh)
      - [`ssh-keygen`(1) - OpenBSD manual pages](https://man.openbsd.org/ssh-keygen)

