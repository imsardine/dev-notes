# Manjaro

  - Manjaro 唸做 man-ja-ro ([`[mæn‵dʒɑrəul]`](http://www.pronouncekiwi.com/Manjaro%20Linux))。

參考資料：

  - [Manjaro \- enjoy the simplicity](https://manjaro.org/)
      - Manjaro is an operating system, suitable as a FREE REPLACEMENT TO WINDOWS OR MACOS. It has different editions, they all use the same base but provide a different experience, based on the diversity of desktop environments available.

        We also work together with hardware manufacturers, to design MANJARO DEDICATED HARDWARE, visit the shop for more information on the available range of laptops.

        想取代 Windows/macOS，表示 UI 要很容易上手，呼應下面 "entry-point into the Linux world"、"suitable for beginners" 等說法。不過發展 Manjaro 專用的硬體，這路線倒是很特別。

      - Manjaro is an accessible, friendly, open-source Linux distribution and community. Based on Arch Linux, Manjaro provides all the benefits of cutting-edge software combined with a focus on GETTING STARTED QUICKLY, automated tools to require less manual intervention, and help readily available when needed. Manjaro is suitable for both newcomers and experienced Linux users.

        沒想到 Debian 外，Arch Linux 也發展得不錯。

      - Manjaro is an excellent ENTRY-POINT into the Linux world. Unlike proprietary operating systems, Manjaro gives you full control over your hardware, without restrictions. This makes it ideal for people who want to learn how Linux works and how it is different to other operating systems. From this perspective, Manjaro is suitable for BEGINNERS similar to the way an Arduino is an excellent entry-point to embedded hardware development.
      - Manjaro is not a CONSUMER-ORIENTED operating system. You have full control and you will not be prevented from breaking your own installation - but then again, BREAKING THINGS AND FIXING THEM is half of the fun! On the other hand, if you are happy with the way it works you don't have to change a thing.
      - Manjaro can represent a perfect MIDDLE-GROUND for experienced Linux users, those who want good performance, full control, and cutting-edge software but also a degree of software version stability.

    Free is better

      - Manjaro always will be completely free. We create it, so we can have a Linux based operating system that is EASY TO USE and STABLE, you the user, are the main focus, we do not take control away from you and consider PRIVACY very important, we do not keep, sell or pass your data to 3rd parties.

    Install Anything

      - There are thousands of software applications available in the software center, including fully compatible equivalents of popular Windows software such as MS Office ??, any additional software is also completely free. Searching for applications to install on the internet, is not necessary.

    Great Community

      - We have a polite, friendly and cheerful Forum, everyone is welcoming and supportive. The forum is the right place to share knowledge, talk Linux with the community, we all love it.

    Availability

      - Manjaro is Available for 64 Bit architecture, Kde, Gnome and XFCE EDITIONS are officially supported, other flavors are community maintained, so as 32 Bit and ARM architectures.
      - ARM is available as PER DEVICE BASIS, pre built images can be downloaded for the Raspberry Pi and [Pinebook 64](https://www.pine64.org/?page_id=3707).

    What is Linux

      - Linux is the NAME OF THE KERNEL powering the GNU SYSTEM. GNU/Linux, also called Linux is a free and open source operating system, that can be freely used and distributed.

        GNU/Linux (簡稱 Linux) = Linux (kernel) + [GNU System](https://www.gnu.org/gnu/gnu-history.en.html)

      - Originally developed in 1991 by Finnish Programmer Linus Torvalds, Linux is an exceptionally robust and reliable kernel, which combined with the GNU system is most commonly used for Internet servers, mobile phones, tablets mostly known as Android devices. Additionally, the use of GNU/Linux as an alternative operating system, for personal computers such as desktops or laptops, has also been growing over the years, with several million users having already discovered the benefits of it.

    Benefits of using Linux

      - It is highly efficient, very fast and any hardware device works out of the box, only in rare occasions you will need to install a device driver, The 64 bit version of Manjaro with the Xfce desktop, boots up in only a few seconds, it uses only 200MB of memory to run.
      - Linux systems are also very secure, and are not affected by the huge amount of Windows viruses, trojans, worms, or malware out there. ANTI-VIRUS SOFTWARE IS NOT REQUIRED.
      - It is also possible to easily run many popular Windows applications on GNU/Linux using compatibility software such as Wine or PlayonLinux or using [Proton](https://www.protondb.com/) via Steam. The examples given here are far from comprehensive!

## Boot Into Text mode ??

  - [How to boot Manjaro into text mode \(text\-only console mode\) and troubleshoot at bootup \(2018 tutorial\) \- Technical Issues and Assistance / Tutorials \- Manjaro Linux Forum](https://forum.manjaro.org/t/45638)

      - You might have run into it. Issues at bootup. Sometimes you messed something up, but you know how to fix it. If only you had access to a terminal/console at bootup!
      - Look no further. Here’s how to boot Manjaro into text mode, i.e. text-only console mode. (terminal) Additionally a few useful tips are given to solve or work around potential issues.
      - Start up your computer and when you see the Grub screen, do the following:

         1. In the Grub menu press the ‘e’ key to edit Grub’s boot options.
         2. Using your arrow keys, move the typing cursor to the end of the ‘`linux`’ (kernel) line and append a ‘`3`’ at the end of the line (with a space before it).
         3. Then press CTRL+X or F10 to save the changes for THIS BOOTUP SESSION and to boot the system into a console.

    That’s it. You will now boot into a console where you can log in with your username and password.

    之前遇到黑畫面的問題，第一次開進 text mode，再透過 `startx` 進到桌面，之後重開就可以順利進到桌面環境了。

## 安裝設置 {: #setup }

  - [Manjaro \- Try it now](https://manjaro.org/download/)

      - You can try Manjaro without modifying your current operating system, run Manjaro from a USB stick or a DVD. Later on if you decide to install Manjaro, you can do it directly from the live system.
      - For simplicity we have selected XFCE, KDE and GNOME as our FLAGSHIP EDITIONS. If you want to look for other experiences, our community has created many flavours that focus around other desktops. 所謂 flaship edition 就是官方提供的，其餘都由社群貢獻
      - For example we have editions that use technology that makes them very RESOURCE-EFFICIENT and makes them a good choice for old computers.

        Other editions focus on breaking away from user interface standards that are decades old and giving users a MODERN EXPERIENCE. As not everybody wants to have such an experience and likes a more TRADITIONAL WAY how everything works, we have editions that focus on this traditional workflow.

        Simply use our DOWNLOAD SELECTOR below to find your right edition. You may also want to checkout our archive of past released flagship and community editions. 很特別的設計，可以組合 Flagship editions、Beginner-friendly、Resource-efficient、Traditional workflow 找出適合的版本。

  - [Manjaro Free/Non\-Free Drivers \- Newbie Corner \- Manjaro Linux Forum](https://forum.manjaro.org/t/manjaro-free-non-free-drivers/6347) non-free 通常比較快 #ril

  - 安裝 Manjaro 18.04 幾個重要的步驟：

      - 一開始維持 `tz=UTC`、`lang=en_US` 與 `driver=free` 的設定；`driver=free` 的顯示似乎比 `driver=non-free` 正常? 速度也不差，況且最後會再裝 VirtualBox Guest Additions。
      - 在 Location 的步驟，時區選 Asia/Taipei 後，將最下面的 The numbers and dates locale will be set to 繁體中文 (台灣) 改為 American English (United States)，即 `en_US.UTF-8`。

## VirtualBox ??

  - [Install the Guest Additions - VirtualBox \- ArchWiki](https://wiki.archlinux.org/index.php/VirtualBox#Install_the_Guest_Additions)

      - VirtualBox Guest Additions provides drivers and applications that optimize the guest operating system including improved image resolution and better control of the mouse. Within the installed guest system, install:

          - `virtualbox-guest-utils` for VirtualBox Guest utilities with X support
          - `virtualbox-guest-utils-nox` for VirtualBox Guest utilities without X support

      - Both packages will make you choose a package to provide guest modules:

          - for the default linux kernel choose `virtualbox-guest-modules-arch`
          - for non-default kernels choose `virtualbox-guest-dkms`

      - To compile the virtualbox modules provided by `virtualbox-guest-dkms`, it will also be necessary to install the appropriate headers package(s) for your installed kernel(s) (e.g. `linux-lts-headers` for `linux-lts`). When either VirtualBox or the kernel is updated, the kernel modules will be AUTOMATICALLY RECOMPILED thanks to the DKMS Pacman hook.
      - You can alternatively install the Guest Additions with the ISO from the `virtualbox-guest-iso` package, provided you installed this on the host system. To do this, go to the device menu click Insert Guest Additions CD Image.
      - To recompile the vbox kernel modules, run `rcvboxdrv` as root.

      - The guest additions running on your guest, and the VirtualBox application running on your host must have MATCHING VERSIONS, otherwise the guest additions (like shared clipboard) may stop working.

        If you upgrade your guest (e.g. `pacman -Syu`), make sure your VirtualBox application on this host is also the latest version. "Check for updates" in the VirtualBox GUI is sometimes not sufficient; check the VirtualBox.org website.

        這指的是透過 `virtualbox-guest-utils` 安裝 Guest Additions 的狀況，`pacman -Syu` 才可能造成 guest 內部的 Guest Additions 昇級，跟 host 的 VirtualBox 對不起來。

  - 在 VirtualBox 6.0.4 上安裝 Manjaro 18.0.4 時，一開始無法順利安裝 Guest Additions

    用 `pacman -Syu` 全面昇級，再用 `pacman -S gcc make perl linux-headers` 安裝開發套件；Header 的版本參考 `uname -r`。

    重開機，再做 Devices > Insert Guest Additions CD images ... 開始開裝 Guest Additions。

        Verifying archive integrity... All good.
        Uncompressing VirtualBox 6.0.4 Guest Additions for Linux........
        VirtualBox Guest Additions installer
        Copying additional installer modules ...
        Installing additional modules ...
        VirtualBox Guest Additions: Building the VirtualBox Guest Additions kernel 
        modules.  This may take a while.
        VirtualBox Guest Additions: To build modules for other installed kernels, run
        VirtualBox Guest Additions:   /sbin/rcvboxadd quicksetup <version>
        VirtualBox Guest Additions: Building the modules for kernel 4.19.32-1-MANJARO.
        VirtualBox Guest Additions: Running kernel modules will not be replaced until 
        the system is restarted
        VirtualBox Guest Additions: Starting.
        VirtualBox Guest Additions: Building the modules for kernel 4.19.32-1-MANJARO.
        VirtualBox Guest Additions: modprobe vboxsf failed
        Press Return to close this window...

    雖然上面仍有 `modprobe vboxsf failed` 的錯誤，但重開機後 (歷經 `A stop job is running for vboxadd.service` 與 `A start job is running for vboxadd.service`)，就可以正常開全螢幕了。

    Settings > Power > Power Saving > Blank screen 及 Automatic suspend 分別調成 Never 與 When on battery power，才不會動不動要解鎖。

  - [Install Manjaro Linux on VirtualBox – Linux Hint](https://linuxhint.com/install_manjaro_linux_virtualbox/) (2018-08) #ril
  - [Unable to install Linux header for current kernel with pacman \- Super User](https://superuser.com/questions/951055/) #ril
  - [How to install Virtualbox \| Antergos Wiki](https://antergos.com/wiki/system-admin/virtualization/how-to-install-virtualbox/#1_Install_kernel_headers_linux-headers) (2018-08-25)

## 參考資料 {: #reference }

  - [Manjaro](https://manjaro.org/)
  - [Manjaro - GitLab](https://gitlab.manjaro.org/explore/groups)
  - [Manjaro Wiki](https://wiki.manjaro.org/index.php?title=Main_Page)

社群：

  - [Manjaro Linux Forum](https://forum.manjaro.org/)
  - [Manjaro Linux (@ManjaroLinux) | Twitter](https://twitter.com/ManjaroLinux)
  - [r/ManjaroLinux - Reddit](https://www.reddit.com/r/ManjaroLinux/)

相關：

  - 基於 [Arch Linux](archlinux.md)
