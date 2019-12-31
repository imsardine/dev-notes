# SSH (Secure SHell)

  - SSH 是個加密通訊協定，最常見的應用是登入遠方的電腦 - 主要是 Unix-like OS，而 2015 年 Microsoft 宣稱未來會原生支援 SSH。
  - SSH 在不安全的網路上提供一個安全通道 (secure channel)，走 SSH client -> SSH server 的 client-server 架構，目前協定有 SSH-1 與 SSH-2 兩個版本。
  - SSH 被設計用來取代 Telnet 或其他不安全的協定，例如 rlogin、rsh、rexec 等。

參考資料：

  - Secure Shell - Wikipedia https://en.wikipedia.org/wiki/Secure_Shell #ril

## SSH 跟 SSL 是什麼關係?

  - Secure Shell - Wikipedia https://en.wikipedia.org/wiki/Secure_Shell 看起來 SSH 跟 SSL 都屬於 application layer，整份文件完全沒提到 SSL，但為何會有 "any network service can be secured with SSH" 的說法?
  - SSL vs SSH - A Not-So-Technical Comparison http://www.jscape.com/blog/ssl-vs-ssh-simplified SFTP 與 FTPS 分別基於 SSH 與 SSL/TLS，雖然 SSH 與 SSL 有相似之處，但確實是不同的東西。

## Windows 支援 SSH 嗎?

  - Secure Shell - Wikipedia https://en.wikipedia.org/wiki/Secure_Shell 提到 2015 後 Microsoft 會在未來原生支援 SSH。
  - Comparison of SSH servers - Wikipedia https://en.wikipedia.org/wiki/Comparison_of_SSH_servers 其實有不少工具支援 Windows 上的 SSH server。
  - Microsoft bringing SSH to Windows and PowerShell | Ars Technica (2015-06-03) https://arstechnica.com/information-technology/2015/06/microsoft-bringing-ssh-to-windows-and-powershell/ 最後提到，就算 Windows 原生支援 SSH，但 Windows 在 remote command-line management 這方面還是不如 Unix。

## SSH 的驗證機制?

  - SSH 有兩種用法：
      - 用自動產生的 public-private key pairs 對連線進行加密，然後用密碼 (password authentication) 登入；除非之前沒有連線過 (會記住 server-side key)，否則要小心連到假的 server，不小心交出密碼
      - 用手動產生的 public-private key paris 進行驗證 (可以用 `ssh-keygen` 產生)，不需要密碼就能登入，當然 private key 本身可能有密碼 (passhrase) 保護。public key 放在所有允許被存取的電腦上，而 private key 則由 ower 保存，SSH 只會驗證登入端是否持有對應的 private key。
  - 在 Unix-like 上，authorized public keys 會放在 `~/.ssh/authorized_keys`，SSH 在該檔案只能被 owner & root 寫入時才會參考它的內容，所以通常會設成 600。

參考資料：

  - Secure Shell - Wikipedia https://en.wikipedia.org/wiki/Secure_Shell

## Fingerprint ??

  - [What is a SSH key fingerprint and how is it generated? \- Super User](https://superuser.com/questions/421997/) fingerprint 是基於 host 的 public key，通常是 `/etc/ssh/ssh_host_rsa_key.pub` #ril

## SSH Agent ??

  - Getting Started — Ansible Documentation http://docs.ansible.com/ansible/latest/intro_getting_started.html#your-first-commands 提到 `ssh-agent bash && ssh-add ~/.ssh/id_rsa` 似乎是為了不用重複輸入 private key 的 passphrase。
  - Inventory — Ansible Documentation http://docs.ansible.com/ansible/latest/intro_inventory.html#list-of-behavioral-inventory-parameters 為何 `ansible_ssh_private_key_file` 會有 "if using multiple keys and you don’t want to use SSH agent" 的說法，這是兩件事?
  - [Fix "Could not open a connection to your authentication](https://coderwall.com/p/rdi_wq/fix-could-not-open-a-connection-to-your-authentication-agent-when-using-ssh-add) 原來 `ssh-agent` 的輸出是 `eval $(ssh-agent)` 這樣用的 -- `eval $(ssh-agent)` #ril

## 如何為不同的 host 指定不同的 private key?

  - 從 `ssh` 的 man page 看到 `-i identity_file` 可以指定 identity (private key)，SSH-1 預設採用 `~/.ssh/identity`，SSH-2 則預設用 `~/.ssh/id_dsa` 或 `~/.ssh/id_rsa`。
  - Man page 還提到 configuration file 裡可以用 per-host basis 指定 private key?

## Host Key ??

  - [ssh\-keygen\(1\) \- OpenBSD manual pages](https://man.openbsd.org/ssh-keygen) 提到 system admin 會用 `ssh-keygen` 來產生 host keys。
  - [SSH Host Key \- What, Why, How \| SSH\.COM](https://www.ssh.com/ssh/host-key) #ril

## 參考資料 {: #reference }

更多：

  - [Tunneling](ssh-tunneling.md)

相關：

  - [OpenSSH](openssh.md)
