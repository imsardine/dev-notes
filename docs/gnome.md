# GNOME

  - [GNOME \- Wikipedia](https://en.wikipedia.org/wiki/GNOME) #ril

      - GNOME (/(ɡ)noʊm/) is a free and open-source DESKTOP ENVIRONMENT for Unix-like operating systems. GNOME was originally an acronym for GNU Network Object Model Environment, but the acronym was dropped because it no longer reflected the vision of the GNOME project.

      - GNOME is part of the GNU Project and developed by The GNOME Project which is composed of both volunteers and PAID CONTRIBUTORS, the largest corporate contributor being Red Hat.

        It is an INTERNATIONAL project that aims to develop SOFTWARE FRAMEWORKS for the development of software, to program end-user applications based on these frameworks, and to coordinate efforts for internationalization and localization and accessibility of that software.

      - GNOME 3 is the default desktop environment on many major Linux distributions including Fedora, Debian, Ubuntu, SUSE Linux Enterprise (exclusively), Red Hat Enterprise Linux, CentOS, Oracle Linux, Scientific Linux, SteamOS, Tails, Kali Linux, Antergos and Endless OS; it is also default on Solaris, a major Unix operating system.

        Also, the continued fork of the last GNOME 2 release that goes under the name [MATE](https://en.wikipedia.org/wiki/MATE_(software)) is default on many distributions that targets LOW USAGE OF SYSTEM RESOURCES. 為什麼不是基於 GNOME 3 ??

  - [History - GNOME \- Wikipedia](https://en.wikipedia.org/wiki/GNOME#History) #ril

    GNOME 1

      - GNOME was started on August 15 1997 by Miguel de Icaza and Federico Mena as a free software project to develop a desktop environment and applications for it.

        It was founded in part because K Desktop Environment, which was growing in popularity, relied on the Qt widget toolkit which used a PROPRIETARY SOFTWARE LICENSE until version 2.0 (June 1999). In place of Qt, the GTK toolkit was chosen as the base of GNOME.

        難怪有提供 UI 的套件，可能會提供 `-gtk` 與 `-qt` 兩種版本。

      - GTK uses the GNU Lesser General Public License (LGPL), a free software license that allows software linking to it to use a MUCH WIDER SET OF LICENSES, including proprietary software licenses. GNOME itself is licensed under the LGPL for its libraries, and the GNU General Public License (GPL) for its applications.

  - [Can I write an application in Qt that runs with Gnome? \- Stack Overflow](https://stackoverflow.com/questions/3794372/)

      - I know KDE is coded in Qt and Gnome isn't. Is it still possible to write a program in Qt for Gnome?
      - Stefan Monov: If you write a Qt app, it will run fine under GNOME, provided that the user has the Qt libraries installed (or, and this is often better, you ship them with your app)

        Your Qt app will look almost NATIVE under GNOME if you make it use `QGtkStyle` as its widgetstyle (this is done via `QApplication::setStyle`). This means the app won't look ugly or FOREIGN under GNOME (except for some very small details)

        只要有安裝 Qt library (最好自帶) 就可以執行，只是看起來風格會明顯跟 GNOME 不同，套用 [QGtkStyle](https://en.wikipedia.org/wiki/QGtkStyle) 可以讓它跟 GNOME 融合得更好。

  - [GNOME – An easy and elegant way to use your computer, GNOME 3 is designed to put you in control and get things done\.](https://www.gnome.org/) #ril

## 新手上路 {: #getting-started }

  - [Determine which version of GNOME is running](https://help.gnome.org/users/gnome-help/stable/gnome-version.html.en)

      - You can determine the version of GNOME that is running on your system by going to the Details/About panel in Settings.

## Keyboard ??

  - Show Desktop 的組合鍵預設被停用，將 Settings > Devices > Keyboard > Navigation > Hide all normal windows 設定為 Super+D (Windows 慣用) 或 Ctrl+Super+D (Ubuntu 慣用) 即可。

參考資料：

  - [What is the Super key?](https://help.gnome.org/users/gnome-help/stable/keyboard-key-super.html.en)

      - When you press the Super key, the ACTIVITIES OVERVIEW is displayed. This key can usually be found on the BOTTOM-LEFT of your keyboard, next to the Alt key, and usually has a WINDOWS LOGO on it. It is sometimes called the WINDOWS KEY or system key.
      - If you have an Apple keyboard, you will have a ⌘ (Command) key instead of the Windows key, while Chromebooks have a [MAGNIFYING GLASS](https://support.google.com/chromebook/answer/1047364?hl=en) instead.

  - [How To Show Desktop In GNOME 3 \- It's FOSS](https://itsfoss.com/show-desktop-gnome-3/) (2015-10-24)

      - How do you show desktop in GNOME 3? GNOME is a wonderful desktop environment but it focuses more on switching between the applications. What if you want to close all the running windows and display just the desktop?
      - In Windows, you can do this by pressing Windows+D. In Ubuntu Unity, it is done with Ctrl+Super+D shortcut keys. But for some reason, GNOME has the shortcut key to show desktop DISABLED FOR SOME REASONS.

## Input Method

  - 為了提供一致的體驗，GNOME 3.6 開始預先安裝/整合了 IBus，如果想用其他 input method framework 可以將它停用。

  - 輸人法在 Settings > Region & Language > Input Sources 下增加。以 Manjaro 下安裝倉頡為例：

        $ sudo pacman -Sy
        $ sudo pacman -S ibus-table-chinese

    重新登入後，到 Settings > Region & Language > Input Sources 搜尋 Chinese，選 Other 後就能看到 Chinese (XXX) 不同的輸入法。增加 input source 後在畫面右上方會出現 keyboard indicator，用 Super+Space 切換輸入法，就能看到變化。

參考資料：

  - [Integrated Input Methods](https://help.gnome.org/misc/release-notes/3.6/i18n-ibus.html.en)

      - For the very first time, GNOME comes with support for input methods OUT OF THE BOX. It is no longer necessary to manually choose and install an INPUT METHOD FRAMEWORK that may not fit very well into the overall user experience. Input methods are now a part of the core GNOME user experience, just like KEYBOARD LAYOUTS.

        The input method support in GNOME 3.6 is based on IBus.

        也就是預先安裝/整合了某個 input method framework -- IBus；如果這不是你要的 (還有其他 framework 可供選擇)，可以將這項整合停用。

      - INTEGRATED input methods is a major new feature, and changes functionality that is important to many users. We recognize this and want to hear about how you want the new feature to develop in the future.

        If you do not wish to make use of this functionality, or prefer to use ANOTHER FRAMEWORK to provide you with input methods, this remains possible as the IBus integration can be DISABLED.

      - Both KEYBOARD LAYOUTS and INPUT METHODS appear as Input Sources in the Region & Language settings and in the GNOME shell KEYBOARD INDICATOR. 'Candidate windows' that are used by some input methods are presented by GNOME shell, and have the same appearance regardless of whether you are typing in an application window or in the GNOME shell search entry.

        呼應上面 "fit overall user experience" 的說法，input soruce = keyboard layouts + input methods，或許有些西方國家，換個 keyboard layout 就可以了，有些語言則要有 input method 幫忙，但 input source 似乎模糊了兩者的界線。

      - The integrated input methods feature has resulted in the rearrangement of some existing keyboard preferences. If you customize your keyboard layout, there are changes you need to be aware of.

          - The keyboard combination to CHANGE THE INPUT SOURCE or keyboard layout can now be customized by using the Shortcuts tab of the Keyboard settings.

            不在 Settings > Region & Language 下，而是在 Settings > Devices > Keyboard > Typing 下，有 Switch to next input source (Super+Space)、Switch to previous input source (Shift+Super+Space)。

          - Options for the Compose Key, as well as the Alternative Characters Key (also known as the 3rd level chooser key) can also be found in the Shortcuts tab of the Keyboard settings.

            在 Settings > Devices > Keyboard 下找不到，後來 GNONE 3.32.0 在 GNOME Tweaks 下的 Keyboard & Mouse > Keyboard 找到了 Compose Key。

            使用上像是 compose key + `a` `'` 會得到 `á` (按下 compose key 時會出現特別的提示字元)，而 compose key 可以是 Scroll Lock、PrtScn、Caps Lock、Right Super、Left/Right Ctrl、Right Alt 等，在 Mac 鍵盤上 Right Super/Alt 是不錯的選擇，Left Ctrl 明顯與常用的快捷鍵衝突了。

          - Other keyboard layout customization options can now be found in GNOME Tweak Tool.

            GNOME Tweaks > Keyboard & Mouse > Additional Layout Options 的設定好細。

  - [Input Sources - ThreePointFive/Features/IBus \- GNOME Wiki\!](https://wiki.gnome.org/ThreePointFive/Features/IBus) #ril
  - [Languages and Input Sources - Arch Linux Installation Guide](https://briancaffey.github.io/2017/08/03/arch-linux-installation-guide.html#languages-and-input-sources) #ril
  - [Input methods - Localization \- ArchWiki](https://wiki.archlinux.org/index.php/Localization#Input_methods) #ril

## 參考資料 {: #reference }

  - [GNOME](https://www.gnome.org/)

社群：

  - [GNOME (@gnome) | Twitter](https://twitter.com/gnome)

文件：

  - [GNOME Help](https://help.gnome.org/users/gnome-help/stable/)
  - [GNOME Wiki](https://wiki.gnome.org/)

相關：

  - 常跟 [KDE](kde.md) 比較
