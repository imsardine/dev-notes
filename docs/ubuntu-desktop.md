---
title: Ubuntu / Desktop
---
# [Ubuntu](ubuntu.md) / Desktop

  - [Ubuntu PC operating system \| Ubuntu](https://www.ubuntu.com/desktop) #ril

## 安裝設置 {: #setup }

  - [Download Ubuntu Desktop \| Download \| Ubuntu](https://www.ubuntu.com/download/desktop)

      - Ubuntu 18.04.2 LTS -- Download the latest LTS version of Ubuntu, for desktop PCs and laptops. LTS stands for long-term support — which means FIVE YEARS, until April 2023, of free security and maintenance updates, guaranteed.
      - Ubuntu 18.10 -- The latest version of the Ubuntu operating system for desktop PCs and laptops, Ubuntu 18.10 comes with NINE MONTHS, until July 2019, of security and maintenance updates.

  - 記錄 Ubuntu Desktop 18.10 幾個重要的步驟：

      - Updates and other software 選 "Minimal installation" 與 "Install third-party software for graphics and Wi-Fi hardware and additional media formats"
      - Where are you? 選 Taipei 好像會讓 locale 全變成 `lzh_TW UTF-8`? 將 `/etc/default/locale` 裡的 `LC_XXX` 全刪掉，只留 `LANG=en_US.UTF-8`，重新登入即可。

### VirtualBox ??

  - Ubuntu Desktop 18.10 上 Guest Additions 直接安裝就可以切全螢幕，不像 Debian 9.8.0 要先手動安裝其他套件?

    但安裝過程會看到 This system is currently not set up to build kernel modules. ... Please install the gcc make perl packages from your distribution. 還是按 Debian 9.8.0 的做法做一次好了。

## 參考資料 {: #reference }

  - [Ubuntu Desktop](https://www.ubuntu.com/desktop)
