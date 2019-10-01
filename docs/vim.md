# Vim (Vi IMproved)

## 發行版 {: #distributions }

  - [Neovim](neovim.md) - 威脅到 Vim 使其在 10 年後推出 Vim 8
  - [SpaceVim](https://spacevim.org/)
  - [spf13-vim](spf13-vim.md) - 最後一個 commit (`1ce5f23`) 在 2016-02-14

---

參考資料：

  - [Modern Day Vim – Hacker Noon](https://hackernoon.com/modern-day-vim-ab4d3aa0cf6b) (2018-09-09) History 提到為什麼 Neovim 會在 2014 冒出來，又為何會促使 Vim 在 10 年後推出 Vim 8 與 Neovim 應戰。
  - [Vim 8\.0 is released \- Laravel News](https://laravel-news.com/vim-8-0-is-released) (2016-09-19) Vim 8 在 10 年後才出現 #ril

## 新手上路 {: #getting-started }

  - [Vim documentation : vim online](https://www.vim.org/docs.php)

      - The most useful software is sometimes rendered useless by poor or altogether missing documentation. Vim refuses to succumb to death by underdocumentation. With a BOOK to extensive help files to a tips collection, all audiences should be pleased.

        按 [the book >> 的連結](https://iccf-holland.org/vim_books.html)，市場上 Vim 相關書籍的數量不算少。

    Help Files

      - Vim's online documentation system, accessible via the `:help` command, is an extensive CROSS-REFERENCED and hyperlinked reference. It's kept up-to-date with the software and can answer almost any question about Vim's functionality.

        An up-to-date version of the help, with hyperlinks, can be found on [vimhelp.org](https://vimhelp.org/). This is maintained by Carlo Teubner.

        下面 Vim FAQ 的連結指向 vimhelp.org，左側選單 the FAQ >> 的連結卻又指向 vimhelp.appspot.com，不過兩者的內容是一樣的；以前的文件確實有提到 appspot，應該是後來拿到 vimhelp.org 這個 domain 了。

    Learning Vim playfully

      - Especially useful for absolute beginners who fear being bored by learning the basic commands: [Vim Adventure](http://vim-adventures.com/) (用遊戲帶指令). Starts with teaching you h, j, k and l movement commands and practice them in an adventure style interactive play.

      - Less playfull, but a bit faster to go through is the Vim tutor. See `:help tutor` inside Vim. (執行 `vimtutor` 直接在文件內操作)

    The FAQ

      - A manual is great for reference, but voluminous reference materials aren't always the easiest way to locate answers to your questions. We've compiled a list of frequently asked questions, along with good answers. You can find the FAQ [here](https://vimhelp.org/vim_faq.txt.html). It comes from this [github project](https://github.com/chrisbra/vim_faq/). #ril

    Tips

      - Finding an answer is even harder IF YOU DON'T KNOW THAT YOU HAVE A QUESTION. The [Vim tips collection](http://vim.wikia.com/wiki/Vim_Tips_Wiki) contains a seemingly endless supply of hints on making your vim use a more pleasant experience. The tips collection is also a great way to find quick hacks to perform common tasks.

  - [Vim: help\.txt](https://vimhelp.org/)

    `:help` 會看到的畫面，直接說明一些基本的操作

      - Move around: Use the cursor keys, or "`h`" to go left, "`j`" to go down, "`k`" to go up, "`l`" to go right.
      - Close this window: Use "`:q<Enter>`".
      - Get out of Vim: Use "`:qa!<Enter>`" (careful, all changes are lost!).

      - Jump to a subject: Position the cursor on a TAG (e.g. bars) and hit `CTRL-]`.

        With the mouse: "`:set mouse=a`" to enable the mouse (in xterm or GUI). Double-click the left mouse button on a tag, e.g. bars.

        Jump back: Type `CTRL-O`. Repeat to go further back.

        為什麼回去不是按 `CTRL-[` 比較直覺？ 按 `CTRL-O` 的說，`O` 應該是 OLDER cursor position，比較容易記。

      - Get specific help: It is possible to go directly to whatever you want help on, by giving an argument to the `:help` command. Prepend something to specify the context: `help-context`

          - `:help x` - Normal mode command
          - `:help v_u` - Visual mode command (`v_`)
          - `:help i_<Esc>` - Insert mode command (`i_`)
          - `:help :quit` - Command-line command (`:`)
          - `:help c_<Del>` - Command-line editing (`c_`)
          - `:help -r` - Vim command argument (`-`)
          - `:help 'textwidth'` - Option
          - `:help /[` - regular expression

        See `help-summary` for more contexts and an explanation.

        例如在文件裡看到 `:r !ls` 不知道這是什麼用法，就可以用 `:help :r` 查詢。

        上面 `help-context` 以粉紅色表現，作用像是 HTML anchor，可以解讀為 `#help-context`，對應的連結則以綠色表現；平常可以用 `help help-text` 跳到那個地方。以這裡的 `help-summary` 為例，在它上面按 `CTRL-[` 效果跟 `:hlep help-summary` 一樣 (輸入 `help-summary` 的過程中，可以用 Tab 幫助完成)

      - Search for help: Type "`:help word`", then hit `CTRL-D` to see matching HELP ENTRIES for "word".

        用 `CTRL-D` 會提示一些項目 (help entry)，按 Enter 會切換到第一個項目。例如 `:help map` 按 CTRL-D 會出現一長串的選項 (`:map`、`map()`, `'noaltkeymap'`, ...) ，此時按 Enter 會切到第一項 `:map` 的文件，效果跟 `:help :map<Enter>` 的結果是一樣的。

        後來實驗發現，在 `:help map` 連續按 Tab，會依序提示不同的 help entry，跟 `CTRL-D` 清單的順序一樣。

        Or use "`:helpgrep word`".

        符合一般對 grep 的期待，`:helpgrep` 找的不是 help entry，而是 help files 的內文；不知道如何切換到下一個搜尋結果 ??

      - Getting started: Do the Vim tutor, a 20 minute interactive training for the basic commands, see `vimtutor`.

        Read the USER MANUAL from start to end: `usr_01.txt`

      - Vim stands for Vi IMproved. Most of Vim was made by Bram Moolenaar, but only through the help of many others.

    Bars example

      - Now that you've jumped here with `CTRL-]` or a double mouse click, you can use `CTRL-T`, `CTRL-O`, `g<RightMouse>`, or `<C-RightMouse>` to go back to where you were.

        `<RightMouse>` 前的 `g` 跟 `C-` 要怎麼輸入 ??

      - Note that tags are within `|` characters, but when highlighting is enabled these characters are hidden. That makes it easier to read a command.

        Anyway, you can use `CTRL-]` on any word, also when it is not within `|`, and Vim will try to find help for it. Especially for options in single quotes, e.g. `'compatible'`.

        像是自動把游標下的字做為 `:help` 的參數。

  - [About the manuals - Vim: usr\_01\.txt](https://vimhelp.org/usr_01.txt.html) #ril
  - [The first steps in Vim - Vim: usr\_02\.txt](https://vimhelp.org/usr_02.txt.html) #ril

## Editing

  - [Moving around - Vim: usr\_03\.txt](https://vimhelp.org/usr_03.txt.html) #ril
  - [Making small changes - Vim: usr\_04\.txt](https://vimhelp.org/usr_04.txt.html) #ril
  - [Making big changes - Vim: usr\_10\.txt](https://vimhelp.org/usr_10.txt.html) #ril

## Buffer

  - [Editing with multiple windows and buffers. - Vim: windows\.txt](https://vimhelp.org/windows.txt.html) #ril

  - [Miriam Tocino \| Vim: Buffers, Tabs, Windows & Modes](http://www.miriamtocino.com/articles/vim-buffers-tabs-windows-and-modes) (2016-08-02) #ril

## Window

  - `split [<FILENAME>]` 或 `vsplit [<FILENAME]` - 可以水平或垂直劃分；指分割線的走向，所以 `vsplit` 是左右分，`split` 是上下分。
  - `Ctrl-w Ctrl-w` - 循環切換
  - `Ctrl-w _` - 最大化目前的視窗
  - `Ctrl-w =` - 平均分配空間
  - `Ctrl-w <ARROW>` - 往特定方向切換視窗
  - `Ctrl-w r` - 轉動/調換視窗的位置
  - 調整視窗大小用 `:resize <SIZE>` 或 `:vertical resize <SIZE>`，其中 `SIZE`

參考資料：

  - [Splitting windows - Vim: usr\_08\.txt](https://vimhelp.org/usr_08.txt.html) #ril

      - Display two different files above each other. Or view two locations in the file at the same time. See the difference between two files by putting them side by side. All this is possible with SPLIT WINDOWS.

    Split a window

      - The easiest way to open a new window is to use the following command:

            :split

      - This command splits the screen into two windows and leaves the cursor in the TOP ONE:

            +----------------------------------+
            |/* file one.c */                  |
            |~                                 |
            |~                                 |
            one.c=============================
            |/* file one.c */                  |
            |~                                 |
            one.c=============================
            |                                  |
            +----------------------------------+

        What you see here is two windows on the same file. The line with "====" is the STATUS LINE. It displays information about the window ABOVE IT. (In practice the status line will be in reverse video.)

        The two windows allow you to view two parts of the same file. For example, you could make the top window show the variable declarations of a program, and the bottom one the code that uses these variables.

      - The `CTRL-W w` command can be used to jump between the windows. If you are in the top window, `CTRL-W w` jumps to the window below it. If you are in the bottom window it will jump to the first window. (`CTRL-W CTRL-W` does the same thing, in case you let go of the CTRL key a bit later.)

        `CTRL-W w` 等同 `CTRL-W CTRL-W` 是特例 ??

    Split a window > CLOSE THE WINDOW

      - To close a window, use the command:

            :close

      - Actually, any command that quits editing a file works, like "`:quit`" and "`ZZ`". But "`:close`" prevents you from accidentally exiting Vim when you close the last window.

    Split a window > CLOSING ALL OTHER WINDOWS

      - If you have opened a whole bunch of windows, but now want to concentrate on ONE OF THEM, this command will be useful:

            :only

        This closes all windows, EXCEPT FOR THE CURRENT ONE. If any of the other windows has changes, you will get an error message and that window won't be closed.

    Split a window on another file

      - The following command opens a second window and starts editing the given file:

        :split two.c

      - If you were editing `one.c`, then the result looks like this:

            +----------------------------------+
            |/* file two.c */                  |
            |~                                 |
            |~                                 |
            two.c=============================
            |/* file one.c */                  |
            |~                                 |
            one.c=============================
            |                                  |
            +----------------------------------+

      - To open a window on a new, empty file, use this:

            :new

      - You can repeat the ":split" and ":new" commands to create as many windows as you like.

        實驗發現 `new` 跟 `:split FILE` 的用法，window 都會開在上面；可見 `:split` (切割自己) 的行為並非特例，因為另一個視窗也是開在上面，只是 cursor 總會移到新 window，會產生 window 開在下面的錯覺。

        下面 Vertical splits 有明確提到 "the new window above the current one"，事實這跟 `'splitbelow'` option (預設 off)，啟用後就會開在下面。

  - [Window size - Vim: usr\_08\.txt](https://vimhelp.org/usr_08.txt.html#08.3)

      - The "`:split`" command can take a number argument. If specified, this will be the HEIGHT OF THE NEW WINDOW. For example, the following opens a new window three lines high and starts editing the file alpha.c:

            :3split alpha.c

        注意這個 argument 是放在前面。

      - For existing windows you can change the size in several ways. When you have a working mouse, it is easy: Move the mouse pointer to the status line that separates two windows, and drag it up or down.

        儘量少用這種方法，習慣 mouseless 比較好；但就調整視窗這件事而言，mouse 好像比較快?

      - To increase the size of a window: `CTRL-W +`

        To decrease it: `CTRL-W -`

        Both of these commands take a count and increase or decrease the window size by that many lines. Thus "4 CTRL-W +" make the window four lines higher.

        一樣數字放前面，但數字是增/減多少行數。

      - To set the window height to a specified number of lines: `{height}CTRL-W _`

        兩位數也沒問題，例如 `25CTRL-W _` 可以將高度調成 25 行。

      - To make a window as high as it can be, use the `CTRL-W _` command without a count.

        其他 window 只會佔 2 行 -- 內容 + status line。

    USING THE MOUSE

      - In Vim you can do many things very quickly from the keyboard. Unfortunately, the window resizing commands require quite a bit of typing. In this case, using the mouse is FASTER.

        Position the mouse pointer on a status line. Now press the left mouse button and drag. The status line will move, thus making the window on one side higher and the other smaller.

    OPTIONS

      - The `'winheight'` option can be set to a minimal DESIRED height of a window and `'winminheight'` to a HARD minimum height.

        什麼時候會用到 desired/hard height ??

      - Likewise, there is `'winwidth'` for the minimal desired width and `'winminwidth'` for the hard minimum width.

      - The `'equalalways'` option, when set, makes Vim equalize the windows sizes when a window is closed or opened.

  - [Vertical splits - Vim: usr\_08\.txt](https://vimhelp.org/usr_08.txt.html#08.4)

      - The "`:split`" command creates the new window ABOVE the current one. To make the window appear at the left side, use:

            :vsplit

        or:

            :vsplit two.c

        The result looks something like this:

            +--------------------------------------+
            |/* file two.c */   |/* file one.c */  |
            |~                  |~                 |
            |~                  |~                 |
            |~                  |~                 |
            two.c===============one.c=============
            |                                      |
            +--------------------------------------+

        Actually, the `|` lines in the middle will be in reverse video. This is called the VERTICAL SEPARATOR. It separates the two windows left and right of it.

      - There is also the "`:vnew`" command, to open a vertically split window on a new, empty file. Another way to do this:

            :vertical new

        The "`:vertical`" command can be inserted before another command that splits a window. This will cause that command to split the window vertically instead of horizontally. (If the command doesn't split a window, it works UNMODIFIED.)

        這跟下面 Various 提到的 `:leftabove`、`rightbelow` ... 等控制新視窗要開在哪個位置的 modifier command 很像。

    MOVING BETWEEN WINDOWS

      - Since you can split windows horizontally and vertically as much as you like, you can create almost any layout of windows. Then you can use these commands to move between them:

          - `CTRL-W h/j/k/l - move to the window on the left/below/above/right

            發現 `CTRL-W` 加方向鍵也可以，不過 `hjkl` 不用大幅移動手指會比較快。

          - `CTRL-W t` - move to the TOP window
          - `CTRL-W b` - move to the BOTTOM window

        You will notice the same letters as used for moving the cursor. And the cursor keys can also be used, if you like.

        事實上，`CTRL-W` 後面還有許多變化，例如 `CTRL-W f` 會開窗編輯 cursor 下的檔案。

  - [Moving windows - Vim: usr\_08\.txt](https://vimhelp.org/usr_08.txt.html#08.5)

      - You have split a few windows, but now they are in the wrong place. Then you need a command to move the window somewhere else. For example, you have three windows like this:

            +----------------------------------+
            |/* file two.c */                  |
            |~                                 |
            |~                                 |
            two.c=============================
            |/* file three.c */                |
            |~                                 |
            |~                                 |
            three.c===========================
            |/* file one.c */                  |
            |~                                 |
            one.c=============================
            |                                  |
            +----------------------------------+

        Clearly the last one should be at the top. Go to that window (using `CTRL-W w`) and the type this command:

            CTRL-W K

        This uses the uppercase letter `K`. What happens is that the window is moved to the VERY TOP. You will notice that `K` is again used for moving upwards.

        注意是大寫的 `K`，因為 `CTRL-W k` 移動的是 cursor 而非 window 本身。

      - When you have vertical splits, `CTRL-W K` will move the current window to the top and make it occupy the FULL WIDTH of the Vim window. If this is your layout:

            +-------------------------------------------+
            |/* two.c */  |/* three.c */  |/* one.c */  |
            |~            |~              |~            |
            |~            |~              |~            |
            |~            |~              |~            |
            |~            |~              |~            |
            |~            |~              |~            |
            two.c=========three.c=========one.c========
            |                                           |
            +-------------------------------------------+

        Then using `CTRL-W K` in the middle window (`three.c`) will result in:

            +-------------------------------------------+
            |/* three.c */                              |
            |~                                          |
            |~                                          |
            three.c====================================
            |/* two.c */           |/* one.c */         |
            |~                     |~                   |
            two.c==================one.c===============
            |                                           |
            +-------------------------------------------+

        這才符合上面 very top 的說法，所以下面的 `CTRL-W H` 也是移到 very left!!

      - The other three similar commands (you can probably guess these now):

          - `CTRL-W H` - move window to the far left
          - `CTRL-W J` - move window to the bottom
          - `CTRL-W L` - move window to the far right

  - [Commands for all windows - Vim: usr\_08\.txt](https://vimhelp.org/usr_08.txt.html#08.6)

      - When you have several windows open and you want to quit Vim, you can close each window separately. A quicker way is using this command:

            :qall

        This stands for "quit all". If any of the windows contain changes, Vim will not exit. The cursor will automatically be positioned in a window with changes. You can then either use "`:write`" to save the changes, or "`:quit!`" to throw them away.

      - If you know there are windows with changes, and you want to save all these changes, use this command:

            :wall

        This stands for "write all". But actually, it ONLY WRITES FILES WITH CHANGES. Vim knows it doesn't make sense to write files that were not changed.

      - And then there is the combination of "`:qall`" and "`:wall`": the "write and quit all" command:

            :wqall

        This writes all modified files and quits Vim.

      - Finally, there is a command that quits Vim and throws away all changes:

            :qall!

        Be careful, there is no way to undo this command!


    OPENING A WINDOW FOR ALL ARGUMENTS

      - To make Vim open a window for each file, start it with the "`-o`" argument:

            vim -o one.txt two.txt three.txt

        This results in:

            +-------------------------------+
            |file one.txt                   |
            |~                              |
            one.txt========================
            |file two.txt                   |
            |~                              |
            two.txt========================
            |file three.txt                 |
            |~                              |
            three.txt======================
            |                               |
            +-------------------------------+

        The "`-O`" argument is used to get VERTICALLY split windows.

      - When Vim is already running, the "`:all`" command opens a window for each file in the argument list. "`:vertical all`" does it with vertical splits.

        這要從 `vim one.txt two.txt three.txt` (沒有加 `-o` 或 `-O`) 的用法說起，一開始只會看到 `one.txt`，透過 `:next` 才能編輯其他檔案；如果一開始忘了加 `-o`/`-O`，或是中間關閉了一些檔案，都可以用 `:all` 或 `:vertical all` 全部叫回來。

  - [Various - Vim: usr\_08\.txt](https://vimhelp.org/usr_08.txt.html#08.8)

      - The `'laststatus'` option can be used to specify when the last window has a statusline:

          - `0` - never
          - `1` - only when there are split windows (the default)
          - `2` -always

        為什麼針對 last window? 因為中間的 status line 同時要做為分隔線? 最下面的 window 沒有 status line 看起來很怪。

      - Many commands that edit another file have a variant that splits the window.

        For Command-line commands this is done by prepending an "`s`". For example: "`:tag`" jumps to a tag, "`:stag`" splits the window and jumps to a tag.

        For Normal mode commands a `CTRL-W` is prepended. `CTRL-^` jumps to the alternate file, `CTRL-W CTRL-^` splits the window and edits the alternate file.

        按 `CTRL-^` 的文件，alternate file 指的是 "previously edited file"；實驗發現，按 `CTRL-6` 同 `CTRL-^`，是特例 ??

      - The 'splitbelow' option can be set to make a new window appear below the current window. The 'splitright' option can be set to make a vertically split window appear right of the current window.

        When splitting a window you can prepend a modifier command to tell where the window is to appear:

          - `:leftabove {cmd}` - left or above the current window
          - `:aboveleft {cmd}` - idem
          - `:rightbelow {cmd}` - right or below the current window
          - `:belowright {cmd}` - idem
          - `:topleft {cmd}` - at the top or left of the Vim window

          - `:botright {cmd}` - at the bottom or right of the Vim window

            突然用了 bottom 的縮寫 bot。

## Tab Page

  - `CTRL-W T` 可以將目前的 window 轉成 tab page。
  - 如何調換 tab 的位置? => http://stackoverflow.com/questions/11295248/ 用 `:tabmove [INDEX]`，其中 `INDEX` 是指要安插的位置，0 表示最前面，不給 `INDEX` 表示最後面。

---

參考資料：

  - [Tab pages - Vim: usr\_08\.txt](https://vimhelp.org/usr_08.txt.html#08.9)

      - You will have noticed that windows never overlap. That means you quickly RUN OUT OF SCREEN SPACE. The solution for this is called TAB PAGES.

      - Assume you are editing "`thisfile`". To create a new tab page use this command:

            :tabedit thatfile

        This will edit the file "`thatfile`" in a window that occupies the whole Vim window. And you will notice a BAR AT THE TOP with the two file names:

            +----------------------------------+
            | thisfile | /thatfile/ __________X|    (thatfile is bold)
            |/* thatfile */                    |
            |that                              |
            |that                              |
            |~                                 |
            |~                                 |
            |~                                 |
            |                                  |
            +----------------------------------+

        You now have two tab pages. The first one has a window for "`thisfile`" and the second one a window for "`thatfile`". It's like TWO PAGES THAT ARE ON TOP OF EACH OTHER, with a tab sticking out of each page showing the file name.

      - Now use the mouse to click on "`thisfile`" in the top line. The result is

            +----------------------------------+
            | /thisfile/ | thatfile __________X|    (thisfile is bold)
            |/* thisfile */                    |
            |this                              |
            |this                              |
            |~                                 |
            |~                                 |
            |~                                 |
            |                                  |
            +----------------------------------+

        Thus you can switch between tab pages by clicking on the label in the top line. If you don't have a mouse or don't want to use it, you can use the "`gt`" command. Mnemonic: Goto Tab.

      - Now let's create another tab page with the command:

        :tab split

        This makes a new tab page with one window that is editing the same buffer as the window we were in:

            +-------------------------------------+
            | thisfile | /thisfile/ | thatfile __X|   (thisfile is bold)
            |/* thisfile */                       |
            |this                                 |
            |this                                 |
            |~                                    |
            |~                                    |
            |~                                    |
            |                                     |
            +-------------------------------------+

        You can put "`:tab`" before any Ex command that opens a window. The window will be opened in a new tab page. Another example:

            :tab help gt

        Will show the help text for "`gt`" in a new tab page.

        要如何分辨 Ex command ??

      - A few more things you can do with tab pages:

          - click with the mouse in the space after the last label. The next tab page will be selected, like with "`gt`".

          - click with the mouse on the "X" in the top right corner. The current tab page will be closed. Unless there are unsaved changes in the current tab page.

          - double click with the mouse in the top line. A new tab page will be created.

          - the "`tabonly`" command. Closes all tab pages except the current one. Unless there are unsaved changes in other tab pages.

      - For more information about tab pages see `tab-page`.

  - [vim \- How do I move an existing window to a new tab? \- Stack Overflow](https://stackoverflow.com/questions/1758301/)

      - Is there a way to take an existing window (split) and put it into a new tab?

        DrAl: As well as the previously suggested `:tabedit` approach, a quicker way of doing it is (in normal mode) to hit `Ctrl-W Shift-T`. `Ctrl-W` is the general prefix for a wide variety of window manipulation commands.

  - [Vim: tabpage\.txt](https://vimhelp.org/tabpage.txt.html) #ril

## Bookmark, Mark

  - [Using marks - Vim: usr\_03\.txt](https://vimhelp.org/usr_03.txt.html#03.10) #ril

## Key Mapping ??

  - [Basic Mapping / Learn Vimscript the Hard Way](http://learnvimscriptthehardway.stevelosh.com/chapters/03.html) #ril
  - [Modal Mapping / Learn Vimscript the Hard Way](http://learnvimscriptthehardway.stevelosh.com/chapters/04.html) #ril
  - [Strict Mapping / Learn Vimscript the Hard Way](http://learnvimscriptthehardway.stevelosh.com/chapters/05.html) #ril

## Configuration ??

  - [Vim Bootstrap](http://vim-bootstrap.com/) 產生 `.vimrc` #ril
  - [amix/vimrc: The ultimate Vim configuration: vimrc](https://github.com/amix/vimrc) #ril
  - [square/maximum\-awesome: Config files for vim and tmux\.](https://github.com/square/maximum-awesome) #ril

## Line Wrapping

若撰寫 Markdown 時有依循 [four-space rule](https://github.github.com/gfm/#motivation)，搭配下面的組態，會讓你的 Markdown 維持可讀性，編輯被折行的內容也很方便：

```
set linebreak
set breakindent
set breakindentopt=shift:2
nmap <up> gk
nmap <down> gj
```

用起來像這個樣子：

```
⎵⎵⎵⎵
  - Line 1 ...      <-- 內文內縮 4 格 (不含項目符號)
    Line 1 (cont.)  <-- 折行進一步內縮與內文對齊；用方向鍵上下移動
⎵⎵⎵⎵⎵⎵⎵⎵
        Indented code block  <-- 程式碼區塊再內縮 4 格
        ...
⎵⎵⎵⎵
    With multiple paragraphs <-- 清單的內文與項目的內文對齊
```

不過有點兩難的是，加了 `linebreak` 會讓連續的中文字找不到斷點，但不加 `linebreak` 又會讓一個英文單字被斷在中間 ??

---

參考資料：

  - [linebreak - Vim: options\.txt](http://vimhelp.appspot.com/options.txt.html#%27linebreak%27)

      - `linebreak` `lbr` - boolean (default off), local to window.

      - If on, Vim will wrap long lines at a character in `breakat` rather than at the last character that fits on the screen.

        Unlike `wrapmargin` and `textwidth`, this does not insert `<EOL>`s in the file, it only affects the WAY THE FILE IS DISPLAYED, not its contents.

        If `breakindent` is set, line is VISUALLY INDENTED. Then, the value of `showbreak` is used to put in front of wrapped lines. This option is not used when the `wrap` option is off.

        在視窗邊界處折行，搭配 `breakindent` 可以讓拆行跟行首對齊。雖然 `showbreak` 可以在拆行前安插一些字元，但 `breakindentopt` 可以進一步讓折行內縮，效果會更好。

  - [breakat - Vim: options\.txt](https://vimhelp.org/options.txt.html#%27breakat%27)

      - `breakat` `brk` - string  (default `" ^I!@*-+;:,./?"`), global, not available when compiled without the `+linebreak` feature

      - This option lets you choose which characters might cause a line break if `linebreak` is on. Only works for ASCII and also for 8-bit characters when 'encoding' is an 8-bit encoding.

        難怪中文字不會斷；上面 "only works for ASCII ..." 的說法似乎只針對 8-bit encoding ??

  - [how can i intuitively move cursor in vim?(not by line) \- Stack Overflow](https://stackoverflow.com/questions/9713967/)

      - Greg Hewgill: In Vim, the gj and gk commands move by line on the screen rather than by line in the file. 可以考慮重新對應 `j`、`k`:

            :map j gj
            :map k gk

      - Rook: Normally, `k` and `j` move you up and down. If you want to navigate wrapped lines use `gk` or `gj`, or just as some like it, map it to for example, the cursor keys. 若平常就習慣用方向鍵，這個設定更直覺了!!

            nmap <up> gk
            nmap <down> gj

  - [\[RFC\] vim\-patch:8\.0\.0380,8\.0\.0381,8\.0\.0385,8\.0\.0389,8\.0\.0391,8\.0\.0406 by ckelsel · Pull Request \#7850 · neovim/neovim](https://github.com/neovim/neovim/pull/7850) #ril

## 參考資料 {: #reference }

  - [vim.org](https://www.vim.org/)
  - [vim/vim - GitHub](https://github.com/vim/vim)

社群：

  - [Vi and Vim Stack Exchange](https://vi.stackexchange.com/)

文件：

  - [Vim Help](https://vimhelp.org/) - 同 `:help` 的內容
  - [User Manual](https://vimhelp.org/usr_toc.txt.html)
  - [FAQ](https://vimhelp.org/vim_faq.txt.html)

書籍：

  - [Modern Vim: Craft Your Development Environment with Vim 8 and Neovim - The Pragmatic](https://pragprog.com/book/modvim/modern-vim) (2018-05)
  - [Practical Vim, Second Edition: Edit Text at the Speed of Thought - The Pragmatic](https://pragprog.com/book/dnvim2/practical-vim-second-edition) (2015-10)
  - [Pro Vim - Apress](https://www.apress.com/gp/book/9781484202517) (2014-12)
  - [Hacking Vim 7.2 - Packt](https://www.packtpub.com/application-development/hacking-vim-72) (2010-04)
  - [Learning the vi and Vim Editors, 7th Edition - O'Reilly](http://shop.oreilly.com/product/9780596529833.do) (2009-06)

學習資源：

  - [Vim Tips Wiki](http://vim.wikia.com/wiki/Vim_Tips_Wiki)
  - [VIM Adventures](https://vim-adventures.com/) - 遊戲中學習

更多：

  - [Visual Mode](vim-visual.md)
  - [Diff](vim-diff.md)

手冊：

  - [Vim: quickref.txt](https://vimhelp.org/quickref.txt.html)
  - [Vim: map.txt](http://vimhelp.org/map.txt.html) - Key mapping
  - [Vim: options.txt](http://vimhelp.org/options.txt.html)
