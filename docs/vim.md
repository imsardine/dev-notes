# Vim

## 發行版 {: #distributions }

  - [Neovim](neovim.md) - 威脅到 Vim 使其在 10 年後推出 Vim 8
  - [SpaceVim](https://spacevim.org/)
  - [spf13-vim](spf13-vim.md) - 最後一個 commit (`1ce5f23`) 在 2016-02-14

---

參考資料：

  - [Modern Day Vim – Hacker Noon](https://hackernoon.com/modern-day-vim-ab4d3aa0cf6b) (2018-09-09) History 提到為什麼 Neovim 會在 2014 冒出來，又為何會促使 Vim 在 10 年後推出 Vim 8 與 Neovim 應戰。
  - [Vim 8\.0 is released \- Laravel News](https://laravel-news.com/vim-8-0-is-released) (2016-09-19) Vim 8 在 10 年後才出現 #ril

## 新手上路 ?? {: #getting-started }

  - [Vim documentation : vim online](https://www.vim.org/docs.php) #ril
      - Vim's online documentation system, accessible via the `:help` command, is an extensive CROSS-REFERENCED and hyperlinked reference. It's kept up-to-date with the software and can answer almost any question about Vim's functionality. An up-to-date version of the help, with hyperlinks, can be found on [appspot](http://vimhelp.appspot.com/). 後者網頁方便在文件內引用，官方文件也是用 appspot 在網頁上引用自己的 help 文件。
      - Especially useful for absolute beginners who fear being bored by learning the basic commands: [Vim Adventure](http://vim-adventures.com/) (用遊戲帶指令). Starts with teaching you h, j, k and l movement commands and practice them in an adventure style interactive play. Less playfull, but a bit faster to go through is the Vim tutor. See `:help tutor` inside Vim. (執行 `vimtutor` 直接在文件內操作)
  - [Vim: vim\_faq\.txt](https://vimhelp.appspot.com/vim_faq.txt.html) #ril

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

  - [Vim Help Files](http://vimhelp.appspot.com/) - 同 `:help` 的內容
  - [Vim: vim_faq.txt](https://vimhelp.appspot.com/vim_faq.txt.html)

學習資源：

  - [Vim Tips Wiki](http://vim.wikia.com/wiki/Vim_Tips_Wiki)
  - [VIM Adventures](https://vim-adventures.com/) - 遊戲中學習

更多：

  - [Visual Mode](vim-visual.md)
  - [Diff](vim-diff.md)

手冊：

  - [Vim: map.txt](http://vimhelp.appspot.com/map.txt.html) - Key mapping
  - [Vim: options.txt](http://vimhelp.appspot.com/options.txt.html)
