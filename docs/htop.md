# htop

  - [htop \- an interactive process viewer for Unix](https://hisham.hm/htop/) #ril
      - This is htop, an interactive process viewer for Unix systems. It is a text-mode application (for console or X terminals) and requires ncurses.
      - Since version 2.0, htop is now cross-platform!

  - [FOSDEM 2016 \- Going cross\-platform \- how htop was made portable](https://archive.fosdem.org/2016/schedule/event/htop/) 一開始只是 linux-only，後來才走向 portable；雖然 UI 用 ncurses (portable)，但在蒐集 process data 這一塊則是基於 `/proc` filesystem。

  - [htop \- Wikipedia](https://en.wikipedia.org/wiki/Htop)
      - Users often deploy htop in cases where Unix top does not provide enough information about the system's processes. htop is also popularly used interactively as a SYSTEM MONITOR. Compared to top, it provides a more convenient, visual, cursor-controlled interface for SENDING SIGNALS TO PROCESSES. 難怪除了 process-viewer，也是 process-manager。
      - htop is written in the C programming language using the ncurses library. Its name is derived from the original author's first name, as a nod to pinfo, an info-replacement program that does the same. 就像取代 info 的 pinfo 中的 p 來自作者名字的 "P"rzemek Borys，所以取代 top 的 htop，它的 p 也是來自作者名字的 "H"isham Muhammad。
      - Cross-platform, OpenBSD, FreeBSD and Mac OS X, support was added in htop 2.0. Solaris/Illumos/OpenIndiana support added in 2.2.0.

  - [hishamhm/htop: htop is an interactive text\-mode process viewer for Unix systems\. It aims to be a better 'top'\.](https://github.com/hishamhm/htop) #ril

  - [你一定用過 htop，但你有看懂每個欄位嗎？\. 身為一個工程師，不管你寫的是前端、後端、全端還是什麼端，一定多少用過… \| by Larry Lu \| Starbugs Weekly 星巴哥技術專欄 \| May, 2021 \| Medium](https://medium.com/starbugs/do-you-understand-htop-ffb72b3d5629) (2021-05-16) #ril

## 新手上路 ?? {: #getting-started }

  - [How to install htop on macOS Unix desktop running on MacBook \- nixCraft](https://www.cyberciti.biz/faq/install-htop-on-macos-unix-desktop-running-macbook-pro/) #ril

## 安裝設置 {: #setup }

```
$ brew install htop
...
htop requires root privileges to correctly display all running processes,
so you will need to run `sudo htop`.
```

---

參考資料：

  - [Sources & Binaries - htop \- an interactive process viewer for Unix](https://hisham.hm/htop/index.php?page=downloads#sources)
      - Debian: In Debian you can fetch htop by typing: `apt-get install htop`
      - Building htop is straightforward, as it uses [GNU Autotools](https://en.wikipedia.org/wiki/GNU_Build_System): the typical `./configure; make; sudo make install` should do the trick.

  - [How to install htop on macOS Unix desktop running on MacBook \- nixCraft](https://www.cyberciti.biz/faq/install-htop-on-macos-unix-desktop-running-macbook-pro/) (2018-11-27) 用 Homebrew 安裝 `htop` 套件。

## 參考資料

  - [htop](https://hisham.hm/htop/)
  - [hishamhm/htop - GitHub](https://github.com/hishamhm/htop)

相關：

  - [ncurses](ncurses.md) - UI 是基於 ncurses

手冊：

  - [Changelog](http://hisham.hm/htop/index.php?page=downloads)
