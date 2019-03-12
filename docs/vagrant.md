# Vagrant

  - Development Environments Made Easy 自動管理 virtual machine 與 development environment 的工具
  - `Vagrantfile` 描述了準備環境的步驟 (workflow)，其他人只要執行 `vagrant up` 就能自動在 Linux、Mac、Windows 上生成相同的開發環境，避免 "works on my machine" 的問題；把 production environment 映射 (mirror) 到本地端，在本地端可以用熟悉的工具進行開發，這是採用 remote development environment 會被犠牲的。
  - Machine 可以由 VirtualBox、VMware、AWS 等 provider 提供 (主要是 virtual machine，但也支援 Docker)，再搭配 provisioning tool (shell script、Chef、Puppet、Salt、Ansible 等) 完成 machine 的設置。
  - 包裝不同 provider 自己的 command line 工具，對外提供一致的用法 (consistent workflow)，甚至也幫忙處理掉同一 provider 不同版本間的差異或問題。更提供 synced folder、HTTP tunnel 以支援在 host 上開發，但程式執行在 virtual machine 的用法。

參考資料：

  - Vagrant by HashiCorp https://www.vagrantup.com/ 提供相同的開發環境，可以繼續用熟悉的工具在本地端進行開發。
  - Introduction - Vagrant by HashiCorp https://www.vagrantup.com/intro/index.html 說明 machine、provider、provisioners (provisioning tool) 間的關係；另外解釋了為何 Vagrant 也適合 operator 與 designer。
  - Vagrant vs. CLI Tools - Vagrant by HashiCorp https://www.vagrantup.com/intro/vs/cli-tools.html 在 provider 自己的 CLI 上包裝一層，並提供進階的功能。
  - Getting Started - Vagrant by HashiCorp https://www.vagrantup.com/intro/getting-started/index.html "Now imagine ... from the comfort of your own machine" 在講述使用 Vagrant 的情境。
  - Vagrant vs. Terraform - Vagrant by HashiCorp https://www.vagrantup.com/intro/vs/terraform.html Vagrant 跟 development environment 有關，而 Terraform 則跟 infrastructure management 有關 (extremely large infrastructures that span multiple cloud providers)，由於 Vagrant 也可以處理 "a handful of virtual machines" 的狀況，一般開發人員用到 Terraform 的機會不高?

## 跟 Docker 有什麼不同? {: #vs-docker }

  - Vagrant 可以在不同 OS 上提供相同的 "開發環境"，而 Docker 則是在 containerization system 之上，提供一致的 "執行環境"；沒有 containerization system 時，可以透過 Docker VM 提供。
  - 由於 Docker 不支援 Windows 與 BSD (指 container 裡的 OS)，所以如果 app 是這些平台，就無法像 Vagrant 一樣提供 production parity。
  - 就 microservice heavy 的應用而言，Docker 會比較輕量 - 只要一個 Docker VM，就能執行許多 container；若要同時開許多 VM，應該沒幾個就會卡卡了，尤其是在個人電腦上。
  - 透過 Vagrant 來用 Docker 的好處是 consistent workflow (尤其是 synced folder、HTTP tunnel 等)，但有許多狀況 pure-Docker workflow 也沒什麼問題。
  - Container 是 stateless，但 VM 是 stateful?

參考資料：

  - Vagrant vs. Docker - Vagrant by HashiCorp https://www.vagrantup.com/intro/vs/docker.html

## 只能照顧到開發階段?

  - 就算 production 不是用 Vagrant，但只要 development 與 production 在 provisioning 這一段共用相同的 script/configuration，在某種程度上算是有照顧到開發階段。

參考資料：

  - Vagrant by HashiCorp https://www.vagrantup.com/ 大大寫著 "Development Environments Made Easy"，做法上是 "MIRROR production environments"，不過 ENFORCE CONSISTENCY (Production Parity) 也提到 "Vagrant also integrates with your existing configuration management tooling ..., so you can use the same scripts to configure Vagrant as production."
  - mitchellh/vagrant - GitHub https://github.com/mitchellh/vagrant 一樣只強調 development environment - "Vagrant is a tool for building and distributing development environments."

## Hello, World! ??

```
$ vagrant init ubuntu/xenial64 # Ubuntu 16.04 LTS
$ vagrant up
$ vagrant ssh -c 'echo "Hello, World"'
Hello, World
Connection to 127.0.0.1 closed.
```

參考資料：

  - [Getting Started \- Vagrant by HashiCorp](https://www.vagrantup.com/intro/getting-started/index.html) #ril
  - [Project Setup \- Getting Started \- Vagrant by HashiCorp](https://www.vagrantup.com/intro/getting-started/project_setup.html)
      - 第一步要建立 `Vagrantfile`，它的位置正是 project 的 root directory (許多 option 相對於這個位置)，裡面描述著機器型態、有哪些資源、安裝哪些軟體、如何存取它等；應該被加進 version control。
      - `vagrant init` 會產生 `Vagrantfile`，看看裡面的 comment，大概知道有哪些設定可以調整。

## 新手上路 ?? {: #getting-started }

  - 看過 [Introduction to Vagrant](https://www.vagrantup.com/intro/index.html) 與 [Vagrant vs. CLI Tools](https://www.vagrantup.com/intro/vs/cli-tools.html) 瞭解 (consistent) workflow、machine、provider、provisioner (provisioning tool) 間的關係，像是 VirtualBox/VMware/Docker 等 provider 的 frontend，提供一致的用法，往上再發展出 synced folder、HTTP tunnel 等，以支援在 host 上開發，但程式執行在 virtual machine 裡的模式。
  - 安裝 VirtualBox 與 Vagrant，執行 `vagrant init hashicorp/precise64` (產生 `Vagrantfile`) 與 `vagrant up` 產生 VM。

        $ vagrant up # 根據 Vagrantfile 設定準備一台 VM
        Bringing machine 'default' up with 'virtualbox' provider...
        ==> default: Box 'hashicorp/precise64' could not be found. Attempting to find and install...
            default: Box Provider: virtualbox
            default: Box Version: >= 0
        ==> default: Loading metadata for box 'hashicorp/precise64'
            default: URL: https://vagrantcloud.com/hashicorp/precise64
        ==> default: Adding box 'hashicorp/precise64' (v1.1.0) for provider: virtualbox
            default: Downloading: https://vagrantcloud.com/hashicorp/boxes/precise64/versions/1.1.0/providers/virtualbox.box <== 從 Vagrant Cloud 下載 image
        ==> default: Successfully added box 'hashicorp/precise64' (v1.1.0) for 'virtualbox'! => 存在 ~/.vagrant.d/boxes/ 底下
        ==> default: Importing base box 'hashicorp/precise64'...
        ==> default: Matching MAC address for NAT networking...
        ==> default: Checking if box 'hashicorp/precise64' is up to date...
        ==> default: Setting the name of the VM: vagrant_default_1501771628402_57859
        ==> default: Clearing any previously set network interfaces...
        ==> default: Preparing network interfaces based on configuration...
            default: Adapter 1: nat
        ==> default: Forwarding ports...
            default: 22 (guest) => 2222 (host) (adapter 1) <== 利用 port forwarding 讓 host 可以存取 SSH
        ==> default: Booting VM...
        ==> default: Waiting for machine to boot. This may take a few minutes...
            default: SSH address: 127.0.0.1:2222
            default: SSH username: vagrant <== 這 user 早就安排好了
            default: SSH auth method: private key
            default:
            default: Vagrant insecure key detected. Vagrant will automatically replace
            default: this with a newly generated keypair for better security.
            default:
            default: Inserting generated public key within guest... <== 把 public key 放進 ~/.ssh/authorized_keys
            default: Removing insecure key from the guest if it's present...
            default: Key inserted! Disconnecting and reconnecting using new SSH key...
        ==> default: Machine booted and ready!
        ==> default: Checking for guest additions in VM...
            default: The guest additions on this VM do not match the installed version of
            default: VirtualBox! In most cases this is fine, but in rare cases it can
            default: prevent things such as shared folders from working properly. If you see
            default: shared folder errors, please make sure the guest additions within the
            default: virtual machine match the version of VirtualBox you have installed on
            default: your host and reload your VM.
            default:
            default: Guest Additions Version: 4.2.0
            default: VirtualBox Version: 5.1
        ==> default: Mounting shared folders...
            default: /vagrant => /private/tmp/vagrant 從 VM 裡的 /vagrant 可以存取到 host CWD 的東西

  - 體驗一下 `vagrant ssh`、修改 host CWD 的內容，在 VM 裡的 `/vagrant` 也看得到，也就是在 host 進行開發，但程式碼又執行在 VM 裡的體驗... 最後可以用 `vagrant destroy` 刪除機器。
  - 看過自動產生的 `Vagrantfile`，大致瞭解一下裡面可以做些什麼即可 (有豐富的註解)；將 `hashicorp/precise64` 換成 `ubuntu/xenial64` 就會變成 Ubuntu Server 16.04 LTS
  - 跟著 https://www.vagrantup.com/intro/getting-started/index.html 完成一個 Vagrant project。

## Vagrantfile ??

參考資料：

  - [Vagrantfile \- Vagrant by HashiCorp](https://www.vagrantup.com/docs/vagrantfile/) #ril
      - `Vagrantfile` 主要是描述專案需要的 machine type，以及如何 configure & provision 這些機器。會加入 VCS，別人拿到 code 之後執行 `vagrant up` (跨平台) 就可以把環境準備好。
      - 雖然 `Vagrantfile` 的語法是 Ruby，但不需要花時間學習 Ruby，因為大部份的修改都是 variable assignment。
  - 不需要學 Ruby 的說法是存疑的，從 `vagrant init` 輸出的 `Vagrantfile` 看來，至少要了解傳遞參數的方式 (keyword arguments)、`config.vm.provider "virtualbox" do |vb| ... end` (block) 及 `config.vm.provision "shell", inline: <<-SHELL ... SHELL` (here documentation) 的用法。
  - [Multi\-Machine \- Vagrant by HashiCorp](https://www.vagrantup.com/docs/multi-machine/) #ril
      - 一個 `Vagrantfile` 可以宣告多個 guest machine，稱之為 multi-machine environment，通常是為了模擬 multi-server production topology。
      - 用 `config.vm.define` 個別宣告 machine -- 在 configuration 裡有另一層 configuration，以 `Vagrant.configure("2") do |config| ... config.vm.define "web" do |web| ...` 而言，`web` 跟 `config` 其實是一樣的 (型態)，只是 `web.xxx` 只會作用在目前的 machine。

## SSH ??

  - `vagrant up` 後會將 VM 設定成可以用 SSH key 登入，而 private key 就在 `.vagrant/machines/default/virtualbox/private_key`；過程中可以看到 SSH address 與 SSH username
  - 以 `SSH address: 127.0.0.1:2222` 與 `SSH username: ubuntu` 為例，可以用 `ssh ubuntu@localhost -p 2222 -i .vagrant/machines/default/virtualbox/private_key` 登入。
  - 同樣地，用 Ansible 操作的話，inventory 可以這樣寫 `target ansible_host:127.0.0.1 ansible_port=2222 ansible_user=ubuntu ansible_ssh_private_key_file=.vagrant/machines/default/virtualbox/private_key`。

參考資料：

  - `vagrant up` 的過程中：

        ==> default: Forwarding ports...
            default: 22 (guest) => 2222 (host) (adapter 1)
        ...
            default: SSH address: 127.0.0.1:2222
            default: SSH username: ubuntu
            default: SSH auth method: password
            default:
            default: Inserting generated public key within guest...
            default: Removing insecure key from the guest if it's present...
            default: Key inserted! Disconnecting and reconnecting using new SSH key...

  - 雖然 "SSH auth method: password"，但不知道 password 是什麼? 但因為最後 "reconnecting using new SSH key" 的關係，就走 SSH key，原來 generated private key 在 `.vagrant/machines/default/virtualbox/private_key`。
  - Creating a Base Box - Vagrant by HashiCorp https://www.vagrantup.com/docs/boxes/base.html 通常會以 `vagrant` 為 root password。
  - Using Vagrant and Ansible — Ansible Documentation http://docs.ansible.com/ansible/latest/guide_vagrant.html 提到 Vagrant 1.7+ 後把 private key 放 `.vagrant/machines/[machine name]/[provider]/private_key`。
  - `vagrant ssh-config` 可以看到 SSH 連線該有的設定 (user, port, identity file ...)，按照 `ssh-config` 指令的說明 "outputs OpenSSH valid configuration to connect to the machine" 感覺像是 OpenSSH 專案的格式??

## Default User ??

  - [Default User Settings - Creating a Base Box \- Vagrant by HashiCorp](https://www.vagrantup.com/docs/boxes/base.html#default-user-settings)
      - 如果要公開 box 並預期可以直接使用 ("just work" out of the box)，應該要符合某些慣例；反之，若沒有要公開被使用，則建議不要這麼做 (should try not to follow these)，因為這會有 security risk -- known user, password & private key
      - Vagrant 預設會用 `vagrant` user 進行 SSH (走 key-based authentication)，所以要先配置好 [insecure keypair](https://github.com/hashicorp/vagrant/tree/master/keys) -- 啟動時會被換掉 Vagrant insecure key detected. Vagrant will automatically replace this with a newly generated keypair for better security. 另外為了讓使用者方便手動登入，密碼也要設成 `vagrant`。
      - Root Password: "vagrant" 提到雖然 Vagrant 本身不會用 root 也不預期它的密碼是什麼，但密碼也設定成 `vagrant` 會比較方便 -- 對公開的 base box 而言。
      - Vagrant 預期 default SSH user 會有 passwordless sudo；首先系統要有 `sudo`，用 `visudo` 加上 `vagrant ALL=(ALL) NOPASSWD: ALL`；以 `ubuntu/xenial64 v20180831.0.0` 為例，是將設定寫在 `/etc/sudoers.d/vagrant`。
      - 為了加速 SSH (daemon)，建議將 `UseDNS` 設為 `no`，這樣可以遶開 reverse DNS lookup 省下一些時間。

## Box, Vagrant Cloud ??

  - [Boxes \- Getting Started \- Vagrant by HashiCorp](https://www.vagrantup.com/intro/getting-started/boxes.html)
      - 從頭開始建構 VM 耗時且繁雜，Vagrant 利用 base image 快速建構 VM，而 Vagrant 將該 base image 稱做 box；使用 `Vagrantfile` 的第一步，就是指定要用哪個 box 做為 base。
      - Box 透過 `vagrant box add` 下載到 Vagrant，可以讓多個 VM 共用，例如 `vagrant box add hashicorp/precise64` (`vagrant init hashicorp/precise64` 也會下載)；
      - Box 是 "globally stored for the current user" (在 `~/.vagrant.d/boxes/` 下)。Box 的名稱有 namespace 的概念，由 username 跟 box name 組成 (中間用 `/` 隔開)，以 `hashicorp/precise64` 為例，username 是 `hashicorp`，box name 則是 `precise64`。
      - 下一步就是進 `Vagrantfile` 用 `config.vm.box` 指定 box；不過執行時若 box 常未事先 add，也會自動下載。除了 box 外，也可以用 `config.vm.box_version` 指定版本 (`~/.vagrant.d/boxes/` 可能存有一個 box 的多個版本)
      - 雖然取得 box 最簡單的方式是從 Vagrant Cloud，但也可以從 local file、custom URL 取得，例如 `config.vm.box_url = "http://files.vagrantup.com/precise64.box"`。
      - Vagrant Cloud 上除了 free box 可供下載外，也可以 host 自己的 private box。
  - [Box File Format \- Vagrant by HashiCorp](https://www.vagrantup.com/docs/boxes/format.html) Box files are compressed using tar, tar.gz, or zip. #ril

## Snapshot ??

  - [vagrant snapshot \- Command\-Line Interface \- Vagrant by HashiCorp](https://www.vagrantup.com/docs/cli/snapshot.html) #ril
      - 不是所有的 provider 都支援 snapshot。
      - 最簡單的用法是 `vagrant snapshot push/pop`，讓 snapshot 進出 stack；這種 snapshot 沒有名稱 (unnamed)。
      - 另一種用法是 `vagrant snapshot save/restore/delete NAME`，操作 named snapshot，可以用 `vagrant snapshot list` 查看所有 snapshot (包括 named 及 unnamed)。

## Networking ??

  - [Networking \- Getting Started \- Vagrant by HashiCorp](https://www.vagrantup.com/intro/getting-started/networking.html) #ril
  - [Basic Usage \- Networking \- Vagrant by HashiCorp](https://www.vagrantup.com/docs/networking/basic_usage.html) #ril
  - [Networking \- Vagrant by HashiCorp](https://www.vagrantup.com/docs/networking/) #ril

## Provision, Provisioning ??

  - Provisioning (服務開通) 是[電信技術用語](https://zh.wikipedia.org/wiki/%E6%9C%8D%E5%8A%A1%E5%BC%80%E9%80%9A)，原意是 供應/預備，就 Vagrant 而言，是指拿到一個乾淨的 VM/container 後，要做哪些安裝、配置，然後交付給使用者。
  - [Provisioning \- Getting Started \- Vagrant by HashiCorp](https://www.vagrantup.com/intro/getting-started/provisioning.html)
      - 用 SSH 登入安裝 web server 當然可以，但每個人都要做一次；Vagrant 支援 automated provisioning，會在 `vagrant up` 時自動安裝設定，所以 guest machine 可以輕易重建，開起來就可以直接用。
      - 自訂了一個 `bootstrap.sh` 來做 provisioning；應該有更好的做法?

            #!/usr/bin/env bash

            apt-get update
            apt-get install -y apache2
            if ! [ -L /var/www ]; then # 如果 /var/www 不是個 link，就刪掉它並重建指向 /vagrant 的 symbolic link
              rm -rf /var/www
              ln -fs /vagrant /var/www
            fi

      - 利用 `shell` 這個 provisioner 搭配 `bootstrap.sh` 來安裝；另外還有 `ansible` provisioner。

            Vagrant.configure("2") do |config|
              config.vm.box = "hashicorp/precise64"
              config.vm.provision :shell, path: "bootstrap.sh"
            end

      - 執行 `vagrant up` 時就會做 provisioning，如果已經安裝過，用 `vagrant reload --provision` 可以快速重啟 VM (`--provision` 會重新做 provisioning) 因為 `vagrant up` 只會在第一次做 provisioning (`Running provisioner: shell...`)；這裡 "initial import step" 指的是??
      - 複雜的 provisioning script，建議用 custom box 將環境先設定好；但這就要有放 box 的地方??

參考資料：

  - [Provisioning \- Vagrant by HashiCorp](https://www.vagrantup.com/docs/provisioning/) #ril
      - Provisioning system 透過 provisioner 可以在 `vagrant up` 的過程中自動安裝軟體、調整 config 等；可以是最簡單的 shell script，也可以是專用的 configuration management system -- Ansible、Chef、Puppet 等。
  - [Shell Scripts \- Provisioning \- Vagrant by HashiCorp](https://www.vagrantup.com/docs/provisioning/shell.html) #ril

## 如何建立多 VM 的開發環境?

  - `vagrant ssh <HOST>` 可以連往不同的 VM。
  - Multi-Machine - Vagrant by HashiCorp https://www.vagrantup.com/docs/multi-machine/ #ril

## Custom box 的使用時機?

  - Provisioning - Getting Started - Vagrant by HashiCorp https://www.vagrantup.com/intro/getting-started/provisioning.html#provision- For complex provisioning scripts 提到，建議用 custom box 事先將套件安裝好

## 如何選擇 box?

  - Vagrant box ubuntu/trusty64 - Vagrant Cloud https://app.vagrantup.com/ubuntu/boxes/trusty64 - Ubuntu 14.04 LTS
  - Vagrant box ubuntu/xenial64 - Vagrant Cloud https://app.vagrantup.com/ubuntu/boxes/xenial64 - Ubuntu 16.04 LTS

## Vagrant Cloud 的收費方式?

  - Pricing - Vagrant Cloud https://app.vagrantup.com/pricing public box 免費且不限數量，但 private box 則按月計費，一個 box 每月 $5 - $25 也太貴? #ril

## 如何自己打包 box?

  - `vagrant --help | grep package` 可以看到 "packages a running vagrant environment into a box"，為什麼是 running?

## 如何自己管理 box?

  - 如果把業務相關的部份都抽離，等拿到 box 後再用 configuration management 工具做後續的 setup，直接放 vagrant cloud 就好了?

參考資料：

  - Boxes - Getting Started - Vagrant by HashiCorp https://www.vagrantup.com/intro/getting-started/boxes.html 提到 While it is easiest to download boxes from HashiCorp's Vagrant Cloud you can also add boxes from a local file, custom URL, etc. 甚至出現 `config.vm.box_url = "http://files.vagrantup.com/precise64.box"` 的用法?
  - Your own Vagrant Cloud. – jon ursenbach – Medium (2014-08-04) :https://medium.com/@jonursenbach/your-own-vagrant-cloud-f077625c6ac8 #ril
  - ryandoyle/vagrancy: Your private Vagrant cloud https://github.com/ryandoyle/vagrancy 用 Packer 打包 image，用 `VAGRANT_SERVER_URL` 環境變數指定 server 的位置 #ril
  - Helpers/self-hosted-vagrant-boxes-with-versioning.md at master · hollodotme/Helpers https://github.com/hollodotme/Helpers/blob/master/Tutorials/vagrant/self-hosted-vagrant-boxes-with-versioning.md 準備 image，再打包成 box #ril
  - Versioned Vagrant boxes, privately. – CoverMyMeds Tech Blog (2015-05-28) https://www.scriptscribe.org/infrastructure/versioned-vagrant-boxes-privately/ #ril
  - Create private vagrant box repository | - Softwaretester - (2016-02-07) http://softwaretester.info/create-private-vagrant-box-repository/ #ril
  - Vagrant box ubuntu/xenial64 - Vagrant Cloud https://app.vagrantup.com/ubuntu/boxes/xenial64 看到 "Externally hosted" 是怎麼回事?

## 從外部編輯檔案後，檔尾會多了一些 `\u0`?

  - 這是 VirtualBox 的問題 [#9069](https://www.virtualbox.org/ticket/9069)，在這之前只能從 web server 的 configuration 下手，將提供 static file 的 `sendfile` syscall 停用。
  - Apache 加 `EnableSendfile Off`，nginx 加 `sendfile off;`，而 uWSGI 則用 `--disable-sendfile`。

參考資料：

  - 從外部編輯 `.js` 後，browser 會丟出 `Uncaught SyntaxError: Invalid or unexpected token` 的錯誤。
  - VirtualBox Shared Folders - Synced Folders - Vagrant by HashiCorp https://www.vagrantup.com/docs/synced-folders/virtualbox.html VirtualBox 有個 bug 跟 `sendfile` 有關，會導致 "corrupted or non-updating files"，nginx 與 Apache 有不同的設定方式。
  - nginx - Virtualbox + Vagrant corrupted static files issue - Stack Overflow https://stackoverflow.com/questions/29927591/ 提到 uwsgi 有 `--disable-sendfile` option 可以用。
  - vagrant - fix: Uncaught SyntaxError: Invalid or unexpected token http://haobing.wang/vagrant/#fixuncaughtsyntaxerrorinvalidorunexpectedtoken 改用 NFS? (`config.vm.synced_folder ".", "/vagrant", :nfs => true`)，但會遇到 `NFS requires a host-only network to be created` 的要求。
  - shared folder problem · Issue #351 · mitchellh/vagrant https://github.com/mitchellh/vagrant/issues/351#issuecomment-1339640 mitchellh: 跟用來提供 static files 的 `sendfile` syscall 有關，這是 VirtualBox 要修的問題，在這之前先用不同 server 的 configuration 將 `sendfile` 停用。
  - #9069 (shared folder doesn't seem to update) – Oracle VM VirtualBox https://www.virtualbox.org/ticket/9069 這 issue 存在 6 年了 ~

## 安裝設定 {: #installation }

### macOS

  - 從 https://www.vagrantup.com/downloads.html 下載最新版的 binary package，安裝完成後就有 `vagrant` 指令可用。
  - 在 Mac 上，`vagrant_*.dmg` 打開後有 `vagrant.pkg` 與 `uninstall.tool`，安裝完成後有 `/usr/local/bin/vagrant`。
  - 移除時執行 `vagrant_*.dmg` 裡的 `uninstall.tool`，提示要刪除 `/opt/vagrant` 及 `/usr/local/bin/vagrant`。

參考資料：

  - [Install Vagrant \- Getting Started \- Vagrant by HashiCorp](https://www.vagrantup.com/intro/getting-started/install.html) 從官網下載 binary package 安裝；提醒不要用系統 package manager 安裝，因為通常比較舊。

## 安裝 Ubuntu 特定版本 (patch)，卻會拿到最新版 ??

裝 [`ubuntu/xenial64` 20170217.0.0](https://app.vagrantup.com/ubuntu/boxes/xenial64/versions/20170217.0.0) (Ubuntu 16.04.2 LTS 在 2017-02-16 釋出)，但 SSH 進去卻得到 Ubuntu 16.04.5 LTS。

```
$ vagrant --version
Vagrant 2.1.4

$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Box 'ubuntu/xenial64' could not be found. Attempting to find and install...
    default: Box Provider: virtualbox
    default: Box Version: 20170217.0.0
==> default: Loading metadata for box 'ubuntu/xenial64'
    default: URL: https://vagrantcloud.com/ubuntu/xenial64
==> default: Adding box 'ubuntu/xenial64' (v20170217.0.0) for provider: virtualbox
    default: Downloading: https://vagrantcloud.com/ubuntu/boxes/xenial64/versions/20170217.0.0/providers/virtualbox.box
    default: Download redirected to host: cloud-images.ubuntu.com

$ vagrant ssh -c 'lsb_release -d'
Description:    Ubuntu 16.04.5 LTS
Connection to 127.0.0.1 closed.
```

原來：

```
$ curl -IL https://vagrantcloud.com/ubuntu/boxes/xenial64/versions/20170217.0.0/providers/virtualbox.box 2> /dev/null | grep Location
Location: https://app.vagrantup.com/ubuntu/boxes/xenial64/versions/20170217.0.0/providers/virtualbox.box
Location: http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-vagrant.box
```

轉到最後，`20170217.0.0` 這項版本資訊不見了，只會下載 Xenial (16.04 LTS) 的最新版。

參考資料：

  - [Vagrant box ubuntu/xenial64 v20161221\.0\.0 \- Vagrant Cloud](https://app.vagrantup.com/ubuntu/boxes/xenial64/versions/20161221.0.0/) "This version was created over 1 year ago." 這沒什麼問題，但 Externally hosted (cloud-images.ubuntu.com) 是什麼意思?

## 參考資料 {: #reference }

  - [Vagrant](https://www.vagrantup.com/)
  - [mitchellh/vagrant - GitHub](https://github.com/mitchellh/vagrant)
  - [Discover Vagrant Boxes - Vagrant Cloud](https://app.vagrantup.com/boxes/search)

文件：

  - [Vagrant Documentation](https://www.vagrantup.com/docs/)

手冊：

  - [Vagrantfile](https://www.vagrantup.com/docs/vagrantfile/)
  - [Command-Line Interface](https://www.vagrantup.com/docs/cli/)

