# tmux

  - tmux 唸做 "tee-mucks"。

## 新手上路 {: #getting-started }

  - 如何讓 status line 顯示目前 prefix 已經被按下去? => https://github.com/tmux-plugins/tmux-prefix-highlight #ril
  - 文件裡怎麼表示 prefix?? => 暫時用 `prefix Ctrl-o` 來表示
  - 連線到一個新環境時，要怎麼知道 prefix? => 先用 `tmux ls` 查看 session，再用 `tmux show -g prefix` 查看 prefix

## Session, Window, Pane ??

  - [Workflow in Tmux \(Example\)](https://coderwall.com/p/_g2vpq/workflow-in-tmux) #ril
      - Sessions are groups of windows, and a window is a layout of panes. 某種程度上 window 跟 pane 是可以互換的 (interchangeable)，而 session 概代上近似於 workspace。

## Questions

  - 有沒有指令可以很快回覆整個配置??
  - plugin 怎麼用??
  - Session 是無法跨使用者的??
  - 一個 client 同時間只能 attach 到一個 session，但可以在不同 session 間切換??
  - 所謂 client 是指 terminal 嗎?? 好像是，`list-clients` 列出來都是 `/dev/ttysXXX`
  - 如何調整 pane 的 size??
  - 安裝 tmux 套件即可 -> 啟用 vi mode，並將 window 編號改為 1 開始 (0 不太直覺)
  - 執行 `tmux` 會建立一個 session，一開始有個 window (內含一個 pane)，可以進一步分割 pane。
  - `Ctrl-b ?` 叫出說明 (也在 copy mode)；tmux 的 man page 很長，怎麼看??
  - 設計一個流程，練習 window、pane 的建立、切換...
  - 在 `~/.tmux.conf` 做一些簡單的設定 (以 `#` 開頭的行為註解，但不能在設定後加註解??)，知道怎麼做調整；改 config 後執行 `source-file ~/.tmux.conf` 可以更新，不用重啟 session。
  - `Ctrl-b s` 用樹狀表現所有 session 及 session 下的 window，用上/下鍵移動，按 Enter 決定。
  - `Ctrl-b [` 進入 copy mode，按 `q` 離開
      - `man tmux` 中 "WINDOWS AND PANES" 一節有所有 copy mode 支援的 keys，區分 vi/emacs mode；如何知道在哪個 mode?
      - 上/下鍵就可以捲動 history
      - Mac 上如何快速換頁? 可以搜尋嗎? 用 vi mode 就可以用 Ctrl-F 或 Ctrl-B 翻頁。 
      - 按 Space 開始用方向鍵選取 (或其他 vi 慣用的其他方式，例如 `w` 一個字、`$`/`^` 行首行尾等)，按 Enter 結束選取完成複製，之後可以用 `Ctrl-b ]` 貼上。
      - `set -g mouse on` 使能在捲動滑鼠滾輪時自動進/出 copy mode，雖然用 trackpad 選取文字的動作會失效，但還是可以用 Space -> Enter -> `Ctrl-b ]` 的方式做 copy-paste。(雖然 mouse mode 還可以用 mouse 做很多事，但既然用了 tmux，就儘可能放掉 mouse/trackpad 吧，連到遠端時 mouse mode 好像不會有作用?? 但在 Ubuntu 上是可以的?)
      - copy mode 在一個 session 複製的內容，可以用 `PREFIX ]` 則到另一個 session。
  - tmux 可以從 attached client 使用 prefix key (預設是 `Ctrl-b` 或 `C-b`)，再接著其他 key binding

  - 如果從本機 tmux 連到另一台的 tmux，會有兩個 status line?? 而且 prefix 若一樣會被 local 處理掉，或許將遠端的 prefix 及 status line 的顏色改掉? 在 status line 顯示 prefix??
      - 按兩次 `Ctrl-b` 就能把 key binding 送到遠端，好特別? ... 原來是 `C-b` 被設定成 `send-prefix` 了。
      - 改設定時有沒有辦法針對特定 client，不影響 attach 到同一 session 的其他 client??
      - 改了 prefix 後，拿來當 prefix 的組合鍵就失去原來的用途，有沒有辦法按第 2 次時回到原來的功能 => 原來的設計就是這樣，`C-b C-b` 會執行 `send-key`，所以一旦改了 prefix，要將原有的 `prefix C-b` 停用，再 rebind 到新的。

  - Option 會改變 tmux 的行為
      - Option 分為 server option、session option 跟 window option。
      - 直覺上會覺得 window option 繼承自 session option，最終繼承自 server option，但其實不會。這三種 option 各自有 global option，若某個 server/session/window 沒有特別設定，就會分別從 global option 取預設值。

  - session 可以 detach 跟 re-attach，是什麼意思??
      - 背後有個 server，沒有 session 時執行 `tmux list-sessions` 會出現 "no server running on /private/tmp/tmux-502/default"
      - 一個 terminal 同時間只能 attach 到一個 session；實驗發現一個 session 也可以被多個 client attach，只是看到的畫面是連動的。
      - 每執行一次 `tmux` 就會建立一個 session，用 `tmux attach` 可以 reattach 之前建立的 session，怎麼選??
      - `tmux list-sessions` 可以列出所有的 session，以及 attach 的狀態。
      - detach 是登出了還在背景，之後登入可重新 reattach??
      - 或許可以為不同 session 設定專用的組態，再用 `source-file <CONFIG_FILE>` 載入??
      - 連到一個新的環境，用 `tmux list-session` 看現有的 session，再用 `tmux attach ` 掛上去??

  - 除了用 command 自訂環境外，安裝 plugin 也是少不了的?? 先把 plugin manager 裝起來
  - 在 copy mode 搜尋時，能否 highlight keyword?? 又 keyword 可否用 regex 表示??
  - tmux 有 theme 的概念?? [seebi/tmux\-colors\-solarized: A color theme for the tmux terminal multiplexer using Ethan Schoonover’s Solarized color scheme](https://github.com/seebi/tmux-colors-solarized)
  - command line 的自動完成似乎不太需要，因為 prefix + `:` 叫出 command prompt 後，就有自動完成。

## 其他

  - 看到 iTerm 2 > Preferences > General 下有個 tmux integration??

## Configuration ??

  - [linux \- Keep the window's name fixed in tmux \- Stack Overflow](https://stackoverflow.com/questions/6041178/) preaction: 設定 `set-option -g allow-rename off` 就不會自動更新；但仍然可以手動改名字。
  - [gpakosz/\.tmux: Oh My Tmux\! My pretty \+ versatile tmux configuration that just works \(imho the best tmux configuration\)](https://github.com/gpakosz/.tmux) 搞得好像 Oh My Zsh #ril

## Windows 視窗

  - 多視窗時，有新的 output 時，status line 能否提示??

  - `prefix c` 新增視窗，`prefix &` 關閉視窗 (不是針對單一個 pane)
  - `prefix f` 可以用關鍵字找 window name 或所有 window/pane 目前顯示的內容，只有一個符合會直接切換，有多個符合則可以選擇；只會切到 window，而非特定的 pane。
  - 每個 window 都有一個編號 (預設以 0 開始)，在 status line 看得到，目前的視窗名稱後會加星號，上一個視窗會有減號。(如何快速回到上一個視窗??)
  - `prefix <NUM>` 直接切換到特定編號的視窗，速度會比 `prefix w` 快，但超過 9 就無法用 `prefix <NUM>` 切換。
  - `prefix w` 用上/下鍵選 (但會被限制在目前 pane 的大小)；每個視窗前有數字 1 ~ 9 (超過 9 用字母表示)，沒有視窗編號超過 9 的問題。
  - 假設有編號 1, 2, 3 三個視窗，關閉中間的視窗，並不會讓視窗 3 變成 2；但關閉視窗 3 再開新視窗，編號還是 3 ... 會自動補空位，但舊的號碼不會變 (有點特別? 但用久了覺得數字不要重排似乎滿直覺的?)
  - `prefix ,` 可以修改 window name，預設以目前的 process 為名

## Panes 窗格

### 如何切割/切換窗格?

  - 分割視窗/窗格用 `prefix %` (垂直分割) 或 `prefix "` (水平分割)；事後可否切換分割方向??
  - `prefix Up/Down/Left/Right` 可以根據方位切換 pane
  - `prefix q` - 每個 pane 上會浮現代號，按下數字就能切換；時間可否拉長一點點??
  - `prefix z` - 將目前的 pane 放大/縮小 (status line 的視窗名稱後會多個 "*Z")，切換 pane 時也會回到原來大小。
  - `prefix !` 將目前的 pane 拉出來新的 window；如何將它併回原來的 window?? 或許當初應該用 `prefix z` 將它放大就好?

## Pane

  - 如何搬動 pane 到另一個 window?? 或者把目前 window 併入另一個 window??
  - 如何在水平切割、垂直切割間切換??
  - 同時開很多個 pane 可以做 monitoring，但如果可以執行 script 就自動安排好所有的配置會更好??
  - Pane 似乎只能編號，不能像 window 一樣加以命名??

  - `prefix o` 可以在兩個 pane 之間來回切換。
      - http://unix.stackexchange.com/questions/136631/ `set -g display-panes-time 4000` (單位是 ms，時間到之前可以按 Esc)
  - 開新 window 或 pane 時，如果保持 cwd? => 利用 `new-window` (或 `split-window`) 搭配 `-c '#{pane_current_path}'` 重新將 `prefix c` (及 `%`、`"`) 重新 bind 過即可。

    ```
# Open a new window/pane in the current working directory.
unbind c; bind c new-window -c "#{pane_current_path}"
unbind '"'; bind '"' split-window -v -c '#{pane_current_path}'
unbind %; bind % split-window -h -c "#{pane_current_path}"
    ```

## Commands

  - Command 可以用在很多地方；shell 裡用 `$tmux COMMAND`、在 config file 裡、或按 `prefix :` 輸入
  - Command 可能有 alias，例如 `$tmux attach` 中的 `attach` 其實是 `attach-session`；在 config 裡常看到的 `set` 其實是 `set-option`。
  - 所謂的 key binding，就是按下組合鍵時執行 command，在 command line 執行 `$tmux COMMAND` 有相同的效果。
  - 參數裡出現 `target-pane` (或 `src-pane`、`dst-pane`)，例如 `-t target-pane`， ??
  - 有些 command 還是要記住，連到一個不熟悉的環境時，可以馬上做調整，例如切換 vi mode、查詢prefix key 等。
  - 從目前的 key binding 來瞭解 command 的用法似乎不錯?? tmux 可以調整的配置很多，從別人的組態得到靈感也不錯。

## Buffer

  - 能否把 buffer 的內容另存成檔案，用 vi 看比較方便??
  - `Ctrl-l` - 清除 window/pane 內容，但 buffer 仍保留；其實就是將 window/pane 的內容推進 buffer。在 Mac 上不小心按到 Cmd-K 清掉整個畫面時，可以用 `Ctrl-b r` 要求重畫。要清掉 buffer 可以執行 `clear-history`

## 剪貼簿 Clipboard

  - 如何讓兩邊的 tmux clipboard 互動?? https://github.com/wincent/clipper #ril
  - 如何複製到系統的剪貼簿?? [tmux\-plugins/tmux\-yank: Tmux plugin for copying to system clipboard\. Works on OSX, Linux and Cygwin\.](https://github.com/tmux-plugins/tmux-yank) #ril
  - copy mode 可以有多個剪貼簿嗎??

## 教程規劃

  - 實際上你可能不需要裝 tmux，做為使用者，你要知道有哪些 session，又 prefix 是什麼?
  - 什麼是 keybinding、prefix key，要如何送出 prefix key 本身
  - Session (attach / detach / re-attach) -> Window -> Pane 的關係
  - Session 的狀態 - attached / unattached
  - 如何使用 tmux command，從 shell、tmux 自己的 command prompt；keybinding 背後就是 tmux commands
  - 先知道如何開新視窗、分割視窗、調整大小，並在其間切換，再來談組態。
  - Man page 要怎麼看，尤其 command、alias、taret-session/client/window

## Shared Sessions

  - [Remote Pair Programming Made Easy with SSH and tmux](https://www.hamvocke.com/blog/remote-pair-programming-with-tmux/) (2015-11-03)

      - A simple combination of SSH and tmux is all we need to setup a really effective and lightweight REMOTE PAIR PROGRAMMING environment. We can use all of our beloved command line tools with FINELY TUNED DOTFILES and pat ourselves on the backs for working on our hacker credibility.

        重點是各自的 tmux 套用各自喜好的設定，不用互相牽就。

    What are we going to do?

      - Let’s imagine we have two developers, Alice and Bob. They want to collaborate on a task and since they both are comfortable using the command line they decide to set up a shared terminal environment to work together.

        Alice and Bob connect to the same machine using SSH. They decide to use a DEDICATED PAIRING SERVER that both of them ssh into. Setting up a server with SSH access on DigitalOcean or AWS is a no-brainer nowadays. They simply add their public keys to the `~/.ssh/authorized_keys` file and then can connect securely without needing a password.

        Alternatively they cold also designate Alice’s or Bob’s machine as the pairing host. In this case the respective other person has to ssh into the other dev’s machine and they’re set.

        連到個人的機器可能有隱私的疑慮，連到專用的機器比較可行。

      - Once they are connected to the same machine, they can use tmux for a shared environment. tmux’s client-server architecture allows multiple clients to connect to the same sessions on a server (we’ve got all that session handling stuff covered in the intro guide). That’s perfect for our plans. We can have one session that holds all the windows and panes and can connect one client for each developer.

        ![synchronized session sharing with tmux](https://www.hamvocke.com/assets/img/uploads/ssh_tmux_simple.png)

    Sharing a tmux session

      - The simplest setup is using the exact SAME SESSION with multiple tmux client instances. The following steps will get us there:

          - Alice and Bob ssh into the same server
          - Alice creates a new tmux sesssion: `tmux new -s shared`
          - Bob connects to that session: `tmux attach -t shared`

        Please note that “shared” will be the name of the session, feel free to give it any name you like.

      - From here Alice and Bob can happily hack away on their terminal and make use of all the fancy features offered by tmux. They can create panes and windows, launch different command line applications and pair happily on their tasks. They can even detach from that session and return at any later point. Both will see the exact same output in their respective terminal window.

        But somehow Alice and Bob feel that this is not quite perfect. There are situations where they want to WORK ON DIFFERENT STUFF WHILE STILL BEING IN THAT SESSION. But as soon as Alice switches to a different window to work on her tasks, Bob’s terminal will also switch along.

        雖然跟傳統看著同一個螢幕的做法不同，但分頭進行改同一個 commit 也不錯，避開了要互相 merge code 或解 conflict 的麻煩。

    Independent window switching

      - Instead of sharing the exact same session between multiple tmux clients, we can also create MULTIPLE SESSION WITHIN THE SAME WINDOW GROUP. The result is similar to what we’ve seen above with one difference: Each developer can switch tmux windows independently.

        All contents of the windows will be synchronized between all clients. But each client can decide individually which window’s content should be shown at the moment. This allows Alice and Bob to work independently on different tasks IF THEY FEEL THE NEED TO DO SO. Whenever they want to go back to NORMAL PAIRING they can switch back to the same tmux window and will see the same content again.

        在裡面執行指令時，身份當然是分享 session 的那位。

      - The steps for this setup are a little different:

          - Again, Alice and Bob ssh into the same server

          - Alice, as before, creates a new tmux session: `tmux new -s alice`. tmux will IMPLICITLY create a new WINDOW GROUP

          - Bob does not join that same session. Instead he starts a new session and connects that session to the same window group as Alice’s session: `tmux new -s bob -t alice`

            根據 [man page](http://man7.org/linux/man-pages/man1/tmux.1.html) 的用法 `new-session [-s session-name] [-t group-name]`

            > If `-t` is given, it specifies a SESSION GROUP. Sessions in the same group SHARE THE SAME SET OF WINDOWS - new windows are linked to all sessions in the group and any windows closed removed from all sessions. ... The `group-name` argument may be: ... 2. the name of an existing session - the new session is added to the same group as that session, creating a new group if necessary;
            >
            > 正確的說法是 session group，而非 window group；在 man page 裡完全找不到 window group 的說法。

        That’s it. Now both can move between tmux windows independently. The content (including panes) within those windows will be synchronized between all clients.

      - If you want to get a feeling for what’s happening behind the scenes you can simply look up what sessions and window groups have been created after Alice has created her session. A simple `tmux ls` will reveal what’s happening:

            bob: 2 windows (created Mon Nov  2 22:51:24 2015) [80x23] (group 0) (attached)
            alice: 2 windows (created Mon Nov  2 22:50:36 2015) [80x23] (group 0) (attached)

        As you can see, there are two sessions with their respective name. Both sessions are IN THE SAME GROUP (group 0) and therefore SHARE THE SAME WINDOWS.

        是因為 Bob 透過 `-t alice` 將自己的 session 跟 Alice 的 session 在同一個 group，所以 `tmux ls` 才看得到其他人的 session 嗎? 不過上面 Sharing a tmux session 的做法就已經能看到對方的 session ?? 感覺在開發機上面工作會被看光光 ??

    Benefits and drawbacks

      - To me this is a really nice and lightweight solution if you want to collaborate remotely. You can use it for pair programming, to TROUBLESHOOT ISSUES on your servers together and much more. However, you need to be aware that this is a solution with a lot of restrictions. You’re completely bound to the command line and its tools, there’s no way around it. You also need to have a SEPARATE CHANNEL TO TALK TO EACH OTHER

        這份文件寫於 2015-11-03，現在要搭配其他工具交談並不是什麼問題。

      - One last honorable mention goes out to [tmate.io](https://tmate.io/). Tmate is a service that creates the setup I’ve just described to you in an ad-hoc fashion. If you want to avoid the (quite small) hassle of setting up your own ssh server, tmate might be interesting for you. #ril

        下面有人提到為什麼不用 [wemux](https://github.com/zolrath/wemux) #ril

  - [TMUX — Sharing terminal between Users \- MicroPyramid \- Medium](https://medium.com/@MicroPyramid/tmux-sharing-terminal-between-users-84f2e311c64f) (2017-04-07)

    Connecting to existing session:

        tmux attach -t <session-number>
        tmux attach -t <session-name>

      - The above will only be possible if you’re logged in as THE SAME USER AS ONE SHARING THE SESSION.

    Using Sockets for different users to connect:

      - To Start a new session

            tmux -S /tmp/socket

      - Change its permission for other users to access

            chmod 777 /tmp/socket

        for other users to attach to the session

            tmux -S /tmp/socket attach

        注意 `-S socketpath` 是 `tmux` 的參數，而非 `new-session`、`attach` 這類 tmux command 的參數。

  - [ssh \+ tmux = Pair Programming for Command Line Junkies](https://ryanlue.com/posts/2018-01-13-pair-programming-over-ssh) (2018-01-13) 在講 wemux，要連到其中一方的電腦，設置似乎有點麻煩，還是到共用 server 單純 #ril

  - [BinarApps \- Pair programming with Docker, SSH and TMUX](https://binarapps.com/blog/pair-programming-with-docker-ssh-and-tmux/) (2017-11-07) 跟 Docker 什麼關係? #ril

## 疑難排解 {: #troubleshooting }

### The window server could not be contacted

```
$ open image.png
The window server could not be contacted.  open must be run with a user logged in at the console, either as that user or as root.
```

  - [Unable to use 'open' command in OSX tmux](http://www.elmund.io/2015/07/10/open-command-in-osx-tmux/) (2015-07-10) #ril

## 參考資料 {: #reference }

  - [tmux/tmux - GitHub](https://github.com/tmux/tmux)

工具：

  - [zolrath/wemux: Multi\-User Tmux Made Easy](https://github.com/zolrath/wemux)

書籍：

  - [tmux 2: Productive Mouse-Free Development - The Pragmatic](https://pragprog.com/book/bhtmux2/tmux-2) (2016-11)

手冊：

  - [`tmux(1)` - Linux manual page](http://man7.org/linux/man-pages/man1/tmux.1.html)
