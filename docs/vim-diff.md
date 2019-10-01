---
title: Vim / Diff
---
# [Vim](vim.md) / Diff

## 新手上路 {: #getting-started }

  - [Viewing differences with vimdiff - Vim: usr\_08\.txt](https://vimhelp.org/usr_08.txt.html#08.7)

      - There is a special way to start Vim, which shows the differences between two files. Let's take a file "`main.c`" and insert a few characters in one line.

        Write this file with the `'backup'` option set (預設沒有開啟), so that the backup file "`main.c~`" will contain the previous version of the file.

        Type this command in a shell (not in Vim):

            vimdiff main.c~ main.c

        Vim will start, with two windows side by side. You will only see the line in which you added characters, and a few lines above and below it.

             VV                   VV
            +-----------------------------------------+
            |+ +--123 lines: /* a|+ +--123 lines: /* a|  <- fold
            |  text              |  text              |
            |  text              |  text              |
            |  text              |  text              |
            |  text              |  changed text      |  <- changed line
            |  text              |  text              |
            |  text              |  ------------------|  <- deleted line
            |  text              |  text              |
            |  text              |  text              |
            |  text              |  text              |
            |+ +--432 lines: text|+ +--432 lines: text|  <- fold
            |  ~                 |  ~                 |
            |  ~                 |  ~                 |
            main.c~==============main.c==============
            |                                         |
            +-----------------------------------------+

        (This picture doesn't show the highlighting, use the vimdiff command for a better look.)

      - The lines that were not modified have been COLLAPSED into one line. This is called a CLOSED FOLD. They are indicated in the picture with "<- fold". Thus the single fold line at the top stands for 123 text lines. These lines are equal in both files.

        The line marked with "<- changed line" is highlighted, and the inserted text is displayed with another color. This clearly shows what the difference is between the two files.

        The line that was deleted is displayed with "---" in the `main.c` window. See the "<- deleted line" marker in the picture. These characters are not really there. They just FILL UP `main.c`, so that it displays the same number of lines as the other window.

        上圖有誤，如果是在 `main.c` 增加一行後存檔，`main.c~` 會相對少一行，所以 `---` 應該在左側的 `main.c~` 才對。

    THE FOLD COLUMN

      - Each window has a column on the left with a slightly different background. In the picture above these are indicated with "VV". You notice there is a plus character there, in front of each closed fold. Move the mouse pointer to that plus and click the left button. The fold will open, and you can see the text that it contains.

        The fold column contains a minus sign for an open fold. If you click on this `-`, the fold will close.

      - Obviously, this only works when you have a working mouse. You can also use "`zo`" to open a fold and "`zc`" to close it.

        更多細節可以看 User Manual 的 Folding 一節。

    DIFFING IN VIM

      - Another way to start in DIFF MODE can be done from inside Vim. Edit the "`main.c`" file, then make a split and show the differences:

            :edit main.c
            :vertical diffsplit main.c~

        The "`:vertical`" command is used to make the window split vertically. If you omit this, you will get a horizontal split.

      - If you have a PATCH OR DIFF FILE, you can use the third way to start diff mode. First edit the file to which the patch applies. Then tell Vim the name of the patch file:

            :edit main.c
            :vertical diffpatch main.c.diff

        WARNING: The patch file must contain ONLY ONE PATCH, for the file you are editing. Otherwise you will get a lot of error messages, and some files might be patched unexpectedly.

        The patching will only be done to the COPY of the file in Vim. The file on your harddisk will remain unmodified (until you decide to write the file).

    SCROLL BINDING

      - When the files have more changes, you can scroll in the usual way. Vim will try to keep both the windows start at the same position, so you can easily see the differences side by side.

        When you don't want this for a moment, use this command:

            :set noscrollbind


    JUMPING TO CHANGES

      - When you have disabled folding in some way, it may be difficult to find the changes. Use this command to jump forward to the next change:

            ]c

        To go the other way use:

            [c

        Prepended a count to jump further away.

    REMOVING CHANGES

      - You can move text from one window to the other. This either removes differences or adds new ones. Vim DOESN'T KEEP THE HIGHLIGHTING UPDATED in all situations.  To update it use this command:

            :diffupdate

        不是透過 `dp`/`do` 而是手動修改時，highlighting 會失去同步 ??

      - To remove a difference, you can move the text in a highlighted block from one window to another. Take the "`main.c`" and "`main.c~`" example above. Move the cursor to the left window, on the line that was deleted in the other window. Now type this command:

            dp

        The change will be removed by putting the text of the current window in the other window.  "`dp`" stands for "diff put".

      - You can also do it the other way around. Move the cursor to the right window, to the line where "changed" was inserted. Now type this command:

            do

        The change will now be removed by getting the text from the other window. Since there are no changes left now, Vim puts all text in a closed fold. "`do`" stands for "diff obtain".

        "`dg`" would have been better, but that already has a different meaning ("`dgg`" deletes from the cursor until the first line). 說明為何不命名為 `dg`，因為跟其他指令衝突了。

      - For details about diff mode, see `vimdiff`.

  - [Git and Vimdiff – usevim – Medium](https://medium.com/usevim/git-and-vimdiff-a762d72ced86) (2012-04-21) #ril
      - `vimdiff` 的用法是 `vimdiff file1 file2 [file3 [file4]]`，剛好可以搭配 `git difftool --tool=vimdiff --no-prompt` 使用。
  - [Vim documentation: diff](http://vimdoc.sourceforge.net/htmldoc/diff.html) 提到 `do` 是指 diff obtain，而 `dp` 是指 diff put，這樣比較好記 #ril
  - [Quick and Dirty : Vimdiff Tutorial \| Core Dump](http://amjith.blogspot.com/2008/08/quick-and-dirty-vimdiff-tutorial.html) (2008-08) 說明了幾個當用的指令跟組合鍵；`ctrl-w + ctrl-w` 在這裡尤其好用 #ril
  - [readonly \- How to prevent git vimdiff from opening files as read\-only? \- Stack Overflow](https://stackoverflow.com/questions/18544238/) 是 Vim 預設的行為 #ril

## 參考資料 {: #reference }

文件：

  - [Vim documentation: diff](http://vimdoc.sourceforge.net/htmldoc/diff.html)
