---
title: Vim / Visual Mode
---
# [Vim](vim.md) / Visual Mode

  - [Vim: visual\.txt](https://vimhelp.org/visual.txt.html)
      - Visual mode is a flexible and easy way to SELECT A PIECE OF TEXT FOR AN OPERATOR. It is the only way to select a BLOCK of text. Since Vim 7.4.200 the `|+visual|` feature is always included.

## 新手上路 ?? {: #getting-started }

  - [Using Visual mode - Vim: visual\.txt](https://vimhelp.org/visual.txt.html#visual-use) #ril
      - Using Visual mode consists of three parts: 先決定範圍，接下來的 command 只會作用在選取的範圍

         1. Mark the start of the text with "v", "V" or CTRL-V. The character under the cursor will be used as the START.
         2. Move to the END of the text. The text from the start of the Visual mode up to and INCLUDING the character under the cursor is highlighted.
         3. Type an operator command. The highlighted characters will be operated upon.

## 參考資料 {: #reference }

文件：

  - [Vim: visual.txt](https://vimhelp.org/visual.txt.html)
