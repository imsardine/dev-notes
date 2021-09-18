# VirtualBox

  - [Oracle VM VirtualBox](https://www.virtualbox.org/)
      - VirtualBox is a powerful x86 and AMD64/Intel64 virtualization product for ENTERPRISE as well as HOME USE.
      - Not only is VirtualBox an extremely feature rich, high performance product for enterprise customers, it is also the only professional solution that is freely available as Open Source Software under the terms of the GNU General Public License (GPL) version 2. See "About VirtualBox" for an introduction.
      - Presently, VirtualBox runs on Windows, Linux, Macintosh, and Solaris hosts and supports a large number of guest operating systems including but not limited to Windows (NT 4.0, 2000, XP, Server 2003, Vista, Windows 7, Windows 8, Windows 10), DOS/Windows 3.x, Linux (2.4, 2.6, 3.x and 4.x), Solaris and OpenSolaris, OS/2, and OpenBSD.
      - VirtualBox is being actively developed with frequent releases and has an ever growing list of features, supported GUEST OPERATING SYSTEMS and PLATFORMS IT RUNS ON. VirtualBox is a community effort backed by a dedicated company: everyone is encouraged to contribute while Oracle ensures the product always meets professional quality criteria.

  - [VirtualBox – Oracle VM VirtualBox](https://www.virtualbox.org/wiki/VirtualBox)
      - VirtualBox is a GENERAL-PURPOSE FULL VIRTUALIZER for x86 hardware, targeted at server, desktop and EMBEDDED use.

        不過 [3.1. Supported Guest Operating Systems - Chapter 3\. Configuring Virtual Machines](https://www.virtualbox.org/manual/ch03.html#guestossupport) 也沒提到任何 embedded 相關的 OS??

## Guest Additions

  - [How to Install VirtualBox Guest Additions on Ubuntu 18\.04 \| Linuxize](https://linuxize.com/post/how-to-install-virtualbox-guest-additions-in-ubuntu/) (2019-07-20) #ril

      - VirtualBox provides a set of drivers and applications (VirtualBox Guest Additions) which can be installed in the guest operating system. The Guest Additions offer several useful functionalities for guest machines such as shared folders, shared clipboard, mouse pointer integration, better video support, and more.

        對於 Terminal 的應用而言，最重要的是 shared folders；不過增加網卡，讓 host 可以跟 guest 可以透過網路交換檔案也是一個方式。

      - In this tutorial, we will show you how to install VirtualBox Guest Additions on Ubuntu 18.04 guests. The same instructions apply for Ubuntu 16.04 and any Ubuntu-based distribution, including Linux Mint and Elementary OS.

## 疑難排解 {: #troubleshooting }

### Failed to create a proxy device for the usb device. (Error: VERR_PDM_NO_USB_PORTS)

  - [How to solve VirtualBox exception when attaching a USB device: failed to create a proxy device for the usb device\. \(error verr\_pdm\_no\_usb\_ports\) \| Our Code World](https://ourcodeworld.com/articles/read/1296/how-to-solve-virtualbox-exception-when-attaching-a-usb-device-failed-to-create-a-proxy-device-for-the-usb-device-error-verr-pdm-no-usb-ports) (2020-07-30) #ril

    搭配 USB 3.0 (xHCI) Controller 並先將 USB 裝置加入 USB Device Filers，啟動 VM 時就會自動掛載。

## 安裝設置 {: #setup }

  - [Downloads – Oracle VM VirtualBox](https://www.virtualbox.org/wiki/Downloads) #ril

### macOS, Retina ??

  - Guest 在 Mac Retina 上會變成高解析度 (字很小)，將 VirtualBox > Preferences > Display > Scale Factor > Monitor 1 調成 200%，其餘非 Retina 的螢幕採預設的 100%，這樣在不同的實體螢幕上都能正常顯示。

    如果有點亂，發現從 View > Virtual Screen 1 下直接選 Scale to xx% 最快。

  - 如果 geust 用 GNOME 桌面，會需要用到 Super Key，建議將 Preference > Input > Host Key Combination 從原來的 Left ⌘  換成右邊。

參考資料：

  - [virtualbox\.org • View topic \- VirtualBox 6 \- Display Resolution](https://forums.virtualbox.org/viewtopic.php?f=8&t=90904) (2018-12-21) #ril

      - granada29: The display resolution is set to 'Default' in System Preferences. This gives an effective display size of 2560x1440.

        VirtualBox 6 seems to be ignoring this setting and displaying the VM window as tho the display was set to its maximum resolution, i.e. 3200x1800, yielding very small windows and content (for my eyes anyway).

        ... and I have since figured out that I need to set the DISPLAY SCALE-FACTOR to 200% to restore the pre-6.0.0 behaviour. Should have read the manual - sigh.

      - socratis: Or you can go to the VirtualBox Preferences and adjust the "GLOBAL" scale factor under Display, and avoid doing that on a per VM basis. 下面提到，一旦動過 VM 的這一塊設定，就不會管 global 的值，所以才建議不要動個別 VM 的設定。

        granada29: Nice idea in in theory. In practice, it does not work. The global setting seems to be ignored

        socratis: That's because you've already edited/changed the per VM option:

        The way I do it is to close all VirtualBox processes and search my VM folder recursively for all "`ScaleFactor`" instances, for all `.vbox` files, with a text editor that can actually do such a thing (TextWrangler on OSX). I then remove all instances of the "`ScaleFactor`" from the vbox files, thus "resetting" the per-VM settings to its global setting.

  - [macos \- How to enable the super key when running linux in a virtual machine in OSX \- Super User](https://superuser.com/questions/391207/)

      - tony_sid: I'm running Linux inside VMware in OSX. I want to use gnome-do. The shortcut key to call it is super+space. But that doesn't work when running inside VMware on OSX. How can I enable to super key to function normally inside this virtual machine?
      - slhck: How do you currently map your ⌘ key? The Super key should be mapped to the Win key from Linux. So basically ⌘ → Win should suffice.

## 參考資料 {: #reference }

  - [VirtualBox](https://www.virtualbox.org/)

文件：

  - [User Manual](https://www.virtualbox.org/manual/)

更多：

  - [Networking](virtualbox-networking.md)

手冊：

  - [Status: Guest OSes](https://www.virtualbox.org/wiki/Guest_OSes)
