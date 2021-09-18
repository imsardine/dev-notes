# Ubuntu

  - [The leading operating system for PCs, IoT devices, servers and the cloud \| Ubuntu](https://www.ubuntu.com/) #ril
      - Ubuntu is an open source software operating system that runs from the desktop, to the cloud, to all your internet connected things 平台有 Cloud??, Server, Containers??, Desktop 與 IoT??。

## Version, Code Name ??

用 `lsb_release -cs` 或 `lsb_release -a` 都可以取得，前者單純取 codename，後者則顯示更多版本相關的資訊。

參考資料：

  - [Get Docker CE for Ubuntu \| Docker Documentation](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#set-up-the-repository) `lsb_release -cs` 可以取得 distribution 的名稱；`-c, --codename` 與 `-s, --short`。
  - [Other Version - Repositories/CommandLine \- Community Help Wiki](https://help.ubuntu.com/community/Repositories/CommandLine#Other_Versions) 一樣提到用 `lsb_release -sc` 取得 code name。
  - `man lsb_release` 發現 `-a` 可以顯示更多的資訊。

## 安裝設置 {: #setup }

### 沒有安裝 standard system utilities 會怎樣? 事後要如何安裝?

  - 沒有安裝不會怎樣；事實上裡面的套件大部份都用不到，需要時再安裝即可。
  - `tasksel --new-install --list-tasks | grep standard` 就可以看到 "standard    standard system utilities" (加 `--new-install` 才會有)，用 `tasksel --task-package standard` 會列出 `standard` task 內含的套件 (只會列出未安裝的套件?)
  - 事後可以用 `sudo tasksel install standard` 安裝。

參考資料：

  - What's the consequences if I don't install the "standard system utilities" of Debian? - Unix & Linux Stack Exchange https://unix.stackexchange.com/questions/307600/ Matija Nalis: 選擇不裝，日後需要時再安裝 #ril
  - 安装debian时的"Standard system utilities"都包括哪些软件包? | 大象的blog http://lexdene.github.io/md-blog/debian/what_does_the_standard_system_task_include.md.html 大多數的套件都用不到，作者選擇先不安裝。
  - what's in "standard system utilities" w/ 16.04 server? - Ask Ubuntu https://askubuntu.com/questions/766419/ `sudo tasksel --task-package standard` 可以看安裝的套件? 為什麼只有 `ubuntu-advantage-tools`?
  - apt - Ubuntu server 16.04 - standard system utilities - Ask Ubuntu https://askubuntu.com/questions/820001/ 事後安裝 `ubuntu-standard` 套件即可；但 `ubuntu-standard` 的說明是 "The Ubuntu standard system"。
  - csmojo http://csmojo.com/posts/what-debian-standard-system-utilities-include.html `tasksel --task-packages standard` 似乎沒有安裝 `standard system utilities` 時才有效果?

### 昇級 LTS 到最新的 patch (major.minor 不變) ??

  - [upgrade \- update Ubuntu 16\.04\.1 to 16\.04\.3 \- Ask Ubuntu](https://askubuntu.com/questions/961143/)
      - gorbedani: 如何從 16.04.1 昇級到 16.04.3? 做了 `apt update`、`upgrade` 跟 `dist-upgrade` 都沒有用，`uname -a` 的輸出還是 `Linux lawyer 4.10.0-35-generic #39~16.04.1-Ubuntu ...`。
      - gertvdijk: Kernel build string 並不會指出 "state of the packages your system has installed"，要用 `lsb_release` 看。
  - [Point Release upgrade from 14\.04\.1 to 14\.04\.2? \- Ask Ubuntu](https://askubuntu.com/questions/597341/) #ril
  - [\[ubuntu\] No upgrade from LTS 16\.04\.2 to LTS 16\.04\.3](https://ubuntuforums.org/showthread.php?t=2371186) #ril

### Docker

  - Ubuntu 官方為不同 release 提供有不同 "最小安裝" 的 image，並以 code name 做為tag：

      - 19.04 -- `ubuntu:disco`, `ubuntu:rolling`
      - 18.10 -- `ubuntu:cosmic`
      - 18.04 LTS -- `ubuntu:bionic`, `ubuntu:latest`
      - 16.04 LTS -- `ubuntu:xenial`
      - 14:04 LTS -- `ubuntu:trusty`

    注意 `ubuntu:latest` 並非指向最新的 19.04，是因為 `latest` tag 會指向最新的 LTS，最新版則用 `rolling` tag 來表示。

---

參考資料：

  - [Backup, restore, or migrate data volumes - Use volumes \| Docker Documentation](https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes) 大量用 `ubuntu` image 說明。

  - [ubuntu \- Docker Hub](https://hub.docker.com/_/ubuntu)

    Supported tags and respective Dockerfile links 不同的 release 有不同的 tag

      - 18.04, bionic-20190424, bionic, latest (bionic/Dockerfile)
      - 18.10, cosmic-20190418, cosmic (cosmic/Dockerfile)
      - 19.04, disco-20190423, disco, rolling (disco/Dockerfile)
      - 14.04, trusty-20190425, trusty (trusty/Dockerfile)
      - 16.04, xenial-20190425, xenial (xenial/Dockerfile)

    What's in this image?

      - This image is built from OFFICIAL ROOTFS TARBALLS provided by Canonical (specifically, https://partner-images.canonical.com/core/).

      - The `ubuntu:latest` tag points to the "latest LTS", since that's the version RECOMMENDED FOR GENERAL USE. The `ubuntu:rolling` tag points to the latest release (regardless of LTS status).

        注意 `latest` 跟一般認知不同，這裡指的是 latest LTS，至於真的最新版，則要改用 `rolling` tag。

    Locales

      - Given that it is a MINIMAL INSTALL of Ubuntu, this image only includes the `C`, `C.UTF-8`, and `POSIX` locales by default. For most uses requiring a `UTF-8` locale, `C.UTF-8` is LIKELY SUFFICIENT (`-e LANG=C.UTF-8` or `ENV LANG C.UTF-8`).

        For uses where that is not sufficient, other locales can be installed/generated via the `locales` package. PostgreSQL has a good example of doing so, copied below:

            RUN apt-get update &amp;&amp; apt-get install -y locales &amp;&amp; rm -rf /var/lib/apt/lists/* \
                &amp;&amp; localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
            ENV LANG en_US.utf8

## 參考資料 {: #reference }

  - [Ubuntu](https://www.ubuntu.com/)
  - [Ubuntu Blog](https://blog.ubuntu.com/)

更多：

  - [Desktop](ubuntu-desktop.md)
  - [Server](ubuntu-server.md)
  - [Rescue Mode](ubuntu-rescue.md)
  - [Networking](ubuntu-networking.md)

手冊：

  - [Releases - Ubuntu Wiki](https://wiki.ubuntu.com/Releases) version - code name - release date - EOL date 的對照
  - [Ubuntu Packages Search](https://packages.ubuntu.com/) 查詢不同 Ubuntu 版本 package manager 裡包裝的版本
  - [Ubuntu Manpage](http://manpages.ubuntu.com/)

