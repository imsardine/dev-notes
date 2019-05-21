# Fcitx (小企鵝輸入法)

  - [Fcitx \- 維基百科，自由的百科全書](https://zh.wikipedia.org/wiki/Fcitx)

      - Fcitx（/ˈfaɪtɪks/，源自「Free Chinese Input Tool for X」，又作「Flexible Context-aware Input Tool with eXtension」或「Flexible Input Method Framework」，暫無正式英文全稱，中文名稱為「小企鵝輸入法」）

      - 是一個在 X Window 中使用的輸入法框架，在原始碼包內包含了拼音，五筆字型以及區位、二筆的支援。可以輸入 UTF-8 編碼中的文字。可以在 Linux、FreeBSD 中執行。採用 GPL 授權。支援 XIM、GTK (版本2和3) 和 Qt 的輸入法模組。

        --> 其中 "區位" 指的是 table-based；GTK 與 Qt 是分別給 GNOME (基於 GTK) 與 KDE (基於 Qt) 用的。但 XIM 跟 Fcitx 定位不是一樣??

      - 因雲帆論壇有人批評 Fcitx 程式碼寫的很差，原作者於 2007 年 7 月 10 日決定[終止本專案](https://web.archive.org/web/20070712173307/http://www.fcitx.org/main/?q=node/123)。不過 2008 年 9 月開始作者又加入離開後愛好者建立的 Google Code 專案並頻繁更新，他發文談到[無法忘記 fcitx](https://web.archive.org/web/20090218001523/http://fcitx.org/main/?q=node%2F135)。

        除了原作者之外，還有一些愛好者共同維護Fcitx。現在Fcitx程式碼代管在GitLab平台上進行開發。

        --> 原本只是要解決自己的問題，但也意外地感動了許多人。

      - 支援的輸入法引擎

        --> 提到許多輸入法，呼應了上面 "輸入法框架" 的說法，Fcitx 只是個框架，可以讓不同的輸入法在 X Window 環境下使用。

          - fcitx-googlepinyin: 移植自 Android 的 Google 拼音支援
          - fcitx-keyboard: 採用系統鍵盤配置作為輸入法，以及提供拼寫檢查
          - citx-libpinyin: libpinyin 為後端的漢語拼音支援，fcitx 演算法最先進的輸入法
          - fcitx-pinyin: 漢語拼音支援，fcitx 上速度最快的輸入法
          - fcitx-table: 碼錶類輸入法支援，如五筆、鄭碼等

      - 優點：Fcitx 預設的拼音由於採用的演算法簡單 (前向最大符合)，以及採用自訂的二進位格式並且執行時將所有資料載入入記憶體，因此回應迅速。組態以及使用較為簡單，可以自行替換詞庫為開源詞庫以提高輸入法效率，提供有碼表的轉換器，定義快速鍵也較為簡單。

        4.0 版新加入組態程式、皮膚、SunPinyin 整合、以詞定字等新特性

      - 缺點：使用 XIM 時，若 XIM 崩潰，會導致 X 和基於 X 的應用程式的崩潰。使用 XIM 時，在目前版本（3.0）的 GTK 3 程式中無法正常使用（使用 GTK im module 時不受影響）。

        如果在 Emacs 中使用，Emacs 必須在 Fcitx 啟動之後才啟動，否則 Emacs 會無法使用輸入法，甚至卡死。

        --> 這看起來不像是 Fcitx 的問題?

  - [Fcitx \- Fcitx](https://fcitx-im.org/wiki/Special:MyLanguage/Fcitx)

      - Fcitx [ˈfaɪtɪks] is an INPUT METHOD FRAMEWORK with extension support. Currently it supports Linux and Unix systems like freebsd. It has three built-in INPUT METHOD ENGINE, Pinyin, QuWei (區位) and Table-based input methods.

      - Fcitx tries to provide a NATIVE FEELING under all desktop as well as a LIGHT WEIGHT CORE. You can easily customize it to fit your requirements.

        難怪同時提供 GTK 跟 Qt 兩種套件：

            $ pacman -Sg fcitx-im
            fcitx-im fcitx
            fcitx-im fcitx-gtk2
            fcitx-im fcitx-gtk3
            fcitx-im fcitx-qt4
            fcitx-im fcitx-qt5

  - [Fcitx \- ArchWiki](https://wiki.archlinux.org/index.php/Fcitx) #ril

      - Fcitx is a lightweight input method framework aimed at providing ENVIRONMENT INDEPENDENT language support for Linux. It supports a lot of different languages and also provides many useful NON-CJK FEATURES.

  - [FAQ \- Fcitx](https://fcitx-im.org/wiki/Special:MyLanguage/FAQ) #ril
  - [Fcitx \- Wikipedia](https://en.wikipedia.org/wiki/Fcitx) #ril

## Table-based IM ??

  - [Table \- Fcitx](https://fcitx-im.org/wiki/Special:MyLanguage/Table) #ril

## Desktop Integration ??

  - [Integrate with Desktop \- Fcitx](https://fcitx-im.org/wiki/Special:MyLanguage/Integrate_with_Desktop) #ril

## 安裝設定 {: #installation }

  - [Install and Configure \- Fcitx](https://fcitx-im.org/wiki/Special:MyLanguage/Install_and_Configure) #ril
  - [Install input method \- Fcitx](https://fcitx-im.org/wiki/Special:MyLanguage/Install_input_method) #ril

### Arch Linux ??

  - [manjaro下安装输入法 \- 简书](https://www.jianshu.com/p/d7c8f29be182) (2018-05-12)

      - 輸入法主要有ibus和fcitx。我常用fcitx，它自帶的雙拼用起來不錯，更適合大眾的搜狗輸入法也是基於fcitx的。在pamac裡搜索安裝fcitx-im（搜索出來的四個都裝上）、 fcitx-sogoupinyin、fcitx-configtool。也可以在終端裡輸入命令：

            $ sudo pacman -S fcitx-sogoupinyin
            $ sudo pacman -S fcitx-im     # 全部安裝
            $ sudo pacman -S fcitx-configtool     # 圖形化配置工具

      - 然後要將fcitx加入到環境變量中去，不然就不能激活fcitx輸入法

            $ sudo vi ~/.xprofile  # vi可以換成系統現有的文本編輯器

        然後在裡面添加：

            export GTK_IM_MODULE=fcitx
            export QT_IM_MODULE=fcitx
            export XMODIFIERS="@im=fcitx"

        最後註銷系統重新登錄，fcitx就可以使用了。

  - [Installation - Fcitx \- ArchWiki](https://wiki.archlinux.org/index.php/Fcitx#Installation) #ril

      - Install the `fcitx` package.

    Input method engines

      - Fcitx provides built-in input methods for Chinese Pinyin and table-based input (for example Wubi).
      - `fcitx-googlepinyin`, the Google pinyin IME for Android.
      - `fcitx-chewing` is a popular Zhuyin input engine for Traditional Chinese based on libchewing.
      - `fcitx-table-extra` adds Cangjie, Zhengma, Boshiamy support.
      - `fcitx-table-other`, tables for Latex, Emoji and others. 好特別的輸入法!

    Input method module

      - To obtain a better experience in Gtk+ and Qt programs, install the `fcitx-gtk2`, `fcitx-gtk3`, `fcitx-qt4` and `fcitx-qt5` input method modules as your need, or the `fcitx-im` group to install all of them.

        Without those modules, the input method may work on most applications but you may experience input method hang up, preview window screen location error or no preview error. 看起來就是要裝啊!!

      - Applications below do not use Gtk+/Qt input module: 這會有什麼影響??

          - Applications use Tk, motif or xlib
          - Emacs, Opera, OpenOffice, LibreOffice, Skype, Wine, Java, Xterm, urxvt, WPS

## 參考資料 {: #reference }

  - [Fcitx](http://fcitx-im.org/)
  - [fcitx / fcitx - GitLab](https://gitlab.com/fcitx/fcitx)
  - [Fcitx Wiki](https://fcitx-im.org/wiki/)

相關：

  - 用於 [X Window](x-window.md) 的輸入法框架
