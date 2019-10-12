# Zsh (Z shell)

  - [ZSH \- THE Z SHELL](http://zsh.sourceforge.net/)

      - Zsh is a shell designed for interactive use, although it is also a powerful SCRIPTING LANGUAGE.

        Many of the useful features of bash, ksh, and tcsh were incorporated into zsh; many original features were added.

  - [Z shell \- Wikipedia](https://en.wikipedia.org/wiki/Z_shell) #ril
      - Zsh is an extended Bourne shell with a large number of improvements, including some features of Bash, ksh, and tcsh. 集各家大成
      - Programmable command-line completion that can help the user type both options and arguments for most used commands, with out-of-the-box support for several hundred commands
      - Sharing of command history among all running shells 這問題在 Bash 確實滿惱人的
      - Various compatibility modes, e.g. Zsh can pretend to be a Bourne shell when run as `/bin/sh` 若相容性夠高，讓 `/bin/sh` 指向 Zsh 不是問題
      - Themeable prompts, including the ability to put prompt information on the right side of the screen and have it auto-hide when typing a long command 類 Powerline 在做的事；若擔心被 Zsh 綁住，只是利用 Zsh + Oh My Zsh 來加強 shell 的 UI，好像也是一種使用 Zsh 的理由?
      - Named directories. This allows the user to set up shortcuts such as `~mydir`, which then behave the way `~` and `~user` do. 快速切換 dir 很方便

## 新手上路 ?? {: #getting-started }

  - [ZSH \- THE Z SHELL](http://zsh.sourceforge.net/) 比較了 introductory document、manual 與 user guide 的差別，其中 introductory document 假設已經會一種 Unix shell，因此只強調 Zsh 特別的地方，而 manual 最冗長 (很細，但少有例子)，最後 user guide 則用文字詳細解說各項功能；學習路徑可以是 introductory document --> user guide --> manual。
  - [An Introduction to the Z Shell \- Table of Contents](http://zsh.sourceforge.net/Intro/intro_toc.html) #ril
  - [Bash, Zsh and Fish: The awesomeness of Linux Shells](http://davidokwii.com/bash-zsh-and-fish-the-awesomeness-of-linux-shells/#zsh) #ril

## Theme ??

  - [Powerlevel9k](powerlevel9k.md)

---

參考資料：

  - [Themes · robbyrussell/oh\-my\-zsh Wiki](https://github.com/robbyrussell/oh-my-zsh/wiki/Themes) #ril
  - [What's the best theme for Oh My Zsh? \- Slant](https://www.slant.co/topics/7553/~theme-for-oh-my-zsh) 這些 theme 都不在官方 wiki 裡? #ril
  - [denysdovhan/spaceship\-prompt: A Zsh prompt for Astronauts](https://github.com/denysdovhan/spaceship-prompt) #ril

## Startup File ??

  - [An Introduction to the Z Shell \- Startup Files](http://zsh.sourceforge.net/Intro/intro_3.html) #ril

  - [\.bash\_profile needs to be sourced after oh\-my\-zsh updates · Issue \#3807 · robbyrussell/oh\-my\-zsh](https://github.com/robbyrussell/oh-my-zsh/issues/3807)
      - mcornella (collaborator): That's not how you should solve it. `.bash_profile` is a file read only by bash, which is not compatible with zsh. If we start sourcing `.bash_profile` BAD THINGS will start to happen. Instead, you should copy those `ENV` vars to the `.zshrc` file, preferably at the end of it.
      - teledirgido: Just added "`source ~/.bash_profile`" to my `.zshrc` and everything is working fine now even when I open new tabs.
      - preslavrachev: Perhaps, it is a only short-term solution. Eventually, I think that I will extract the HARMLESS variable and alias statements into a third `.sh` file, which will then be sourced by `.bash_profile` and `.zshrc` respectively. 問題是，哪些 variable/alias 是有害的?
      - dedalozzo: The best way is source `~/.bash_profile` at the end of your `.zshrc` file. Nothing bad will happen. Copying all the content of `.bash_profile` is not smart, because you have to maintain two file in synch in case you want remove zsh in the future. 確實要維護兩支檔案很麻煩，尤其 Zsh 又強調相容於 Bash?

## 安裝設置 {: #setup }

  - [zsh \- How can I make tmux use my default shell? \- Super User](https://superuser.com/questions/253786/)
      - Alex Hammel: tmux 要加 `set-option -g default-shell /bin/zsh` 的設定，可能要用 `killall tmux; tmux` 重啟 tmux。
      - DebugXYZ: `set-option -g default-shell $SHELL` 這寫法不會綁定 Zsh，不過之前要先用 `chsh -s $(`which zsh`) $USER` 修改 default shell。

## 工具 {: #tools }

  - [Oh My Zsh](oh-my-zsh.md)
  - [zsh\-users/zsh\-autosuggestions: Fish\-like autosuggestions for zsh](https://github.com/zsh-users/zsh-autosuggestions) 仿 Fish 自動提示的效果 #ril

## 參考資料 {: #reference }

  - [Zsh](http://www.zsh.org/) - 做為 Zsh 的 index，但好像只有 USA 網站的連結是有作用的?
  - [ZSH - THE Z SHELL](http://zsh.sourceforge.net/) - USA Master Site

文件：

  - [A User's Guide to the Z-Shell](http://zsh.sourceforge.net/Guide/zshguide.html)
  - [An Introduction to the Z Shell](http://zsh.sourceforge.net/Intro/intro_toc.html)
  - [The Z Shell Manual](http://zsh.sourceforge.net/Doc/Release/zsh_toc.html)

相關：

  - [Oh My Zsh](oh-my-zsh.md)

手冊：

  - [Release Notes](http://zsh.sourceforge.net/releases.html) ([history](http://zsh.sourceforge.net/News/))
