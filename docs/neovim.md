# Neovim

  - [Modern Day Vim – Hacker Noon](https://hackernoon.com/modern-day-vim-ab4d3aa0cf6b) (2018-09-09)
      - In 2014, a couple of Vim community members, unhappy with how their efforts to refactor and modernize the codebase was not getting any support, decided to start the Neovim project. ... Neovim had a huge success in the community and as a result, the original Vim project, maintained by Vims creator Bram Moolenar, had to implement some of these new functionalities in order to keep up with this new “competitor”. 這麼多 Vim distribution 裡，只有 Neovim 能撼動 Vim! 就結果來看，這對 Vim 的發展是好事。
      - This brings us to this day. Today we can choose between two different modern Vim distributions, Vim 8+ and Neovim. 完全把其他 distribution 排除在外，不過 spf13-vim 跟 SpaceVim 在 GitHub 的星星數都遠不及 Neovim 倒是真的；顯然 Vim 8 是大改版。
      - In classic Vim distributions (7-) all plugin code runs synchronously. This means that if any plugin code is executing, Vim is essentially frozen. ... Nowadays, thanks to asynchrounous execution in Vim, plugins like [deoplete](https://github.com/Shougo/deoplete.nvim) and [ale](https://github.com/w0rp/ale) help programmers everywhere in the world be even more productive with Vim. 這兩個 plugin 都同時支援 Vim8 與 Neovim。
      - Since the launch of Neovim, finally, we have terminal emulation inside Vim. This allows us to use the terminal inside a Vim buffer and proceed with our work in a different one. Also, workflows like having email, code, chat and other applications running inside the same Vim instance is now possible. 早期要搭配其他 screen manager 才能做到的，直接在 Vim 裡就可以辦到。

  - [Home \- Neovim](https://neovim.io/) #ril
  - [neovim/neovim: Vim\-fork focused on extensibility and usability](https://github.com/neovim/neovim) #ril

## 安裝設定 {: #installation }

  - [Installing Neovim · neovim/neovim Wiki](https://github.com/neovim/neovim/wiki/Installing-Neovim) #ril

## 參考資料 {: #reference }

  - [Neovim](https://neovim.io/)
  - [neovim/neovim - GitHub](https://github.com/neovim/neovim)

相關：

  - [Vim](vim.md)
