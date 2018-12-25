# Zsh (Z shell)

  - [ZSH \- THE Z SHELL](http://zsh.sourceforge.net/) Zsh is a shell designed for interactive use, although it is also a powerful scripting language. Many of the useful features of bash, ksh, and tcsh were incorporated into zsh; many original features were added. 集各家大成

  - [Z shell \- Wikipedia](https://en.wikipedia.org/wiki/Z_shell) #ril
      - Zsh is an extended Bourne shell with a large number of improvements, including some features of Bash, ksh, and tcsh. 集各家大成
      - Programmable command-line completion that can help the user type both options and arguments for most used commands, with out-of-the-box support for several hundred commands
      - Sharing of command history among all running shells 這問題在 Bash 確實滿惱人的
      - Various compatibility modes, e.g. Zsh can pretend to be a Bourne shell when run as `/bin/sh` 若相容性夠高，讓 `/bin/sh` 指向 Zsh 不是問題
      - Themeable prompts, including the ability to put prompt information on the right side of the screen and have it auto-hide when typing a long command 類 Powerline 在做的事；若擔心被 Zsh 綁住，只是利用 Zsh + Oh My Zsh 來加強 shell 的 UI，好像也是一種使用 Zsh 的理由?
      - Named directories. This allows the user to set up shortcuts such as `~mydir`, which then behave the way `~` and `~user` do. 快速切換 dir 很方便

## 新手上路 ?? {: #getting-started }

  - [ZSH \- THE Z SHELL](http://zsh.sourceforge.net/) 比較了 introductory document、manual 與 user guide 的差別，其中 introductory document 假設已經會一種 Unix shell，因此只強調 Zsh 特別的地方，而 manual 最冗長 (很細，但少有例子)，最後 user guide 則用文字詳細解說各項功能；學習路徑可以是 introductory document -> user guide -> manual。
  - [An Introduction to the Z Shell \- Table of Contents](http://zsh.sourceforge.net/Intro/intro_toc.html) #ril
  - [Bash, Zsh and Fish: The awesomeness of Linux Shells](http://davidokwii.com/bash-zsh-and-fish-the-awesomeness-of-linux-shells/#zsh) #ril

## Theme ??

  - [Powerlevel9k](powerlevel9k.md)

---

參考資料：

  - [Themes · robbyrussell/oh\-my\-zsh Wiki](https://github.com/robbyrussell/oh-my-zsh/wiki/Themes) #ril
  - [What's the best theme for Oh My Zsh? \- Slant](https://www.slant.co/topics/7553/~theme-for-oh-my-zsh) 這些 theme 都不在官方 wiki 裡? #ril
  - [denysdovhan/spaceship\-prompt: A Zsh prompt for Astronauts](https://github.com/denysdovhan/spaceship-prompt) #ril

## 安裝設定 {: #installation }

```
$ sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
Cloning Oh My Zsh...
Cloning into '/Users/jeremykao/.oh-my-zsh'...
...
Looking for an existing zsh config...
Found ~/.zshrc. Backing up to ~/.zshrc.pre-oh-my-zsh
Using the Oh My Zsh template file and adding it to ~/.zshrc
Time to change your default shell to zsh!
Changing shell for jeremykao.
Password for jeremykao:
         __                                     __
  ____  / /_     ____ ___  __  __   ____  _____/ /_
 / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \
/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / /
\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/
                        /____/                       ....is now installed!


Please look over the ~/.zshrc file to select plugins, themes, and options.

p.s. Follow us at https://twitter.com/ohmyzsh.

p.p.s. Get stickers and t-shirts at https://shop.planetargon.com.

➜  ~ git:(master) ✗
```

---

參考資料：

  - [Oh My Zsh \- a delightful & open source framework for Z\-Shell](https://ohmyz.sh/) 執行 `$ sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"` 即可完成安裝，還會自動換掉預設的 shell。

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

相關：

  - [Oh My Zsh](oh-my-zsh.md)

手冊：

  - [The Z Shell Manual](http://zsh.sourceforge.net/Doc/Release/zsh_toc.html)
  - [Release Notes](http://zsh.sourceforge.net/releases.html) ([history](http://zsh.sourceforge.net/News/))
