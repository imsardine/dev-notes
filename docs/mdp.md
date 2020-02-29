# mdp

  - [visit1985/mdp: A command\-line based markdown presentation tool\.](https://github.com/visit1985/mdp) A command-line based markdown presentation tool. 直接在 terminal 顯示 Markdown 寫的 slides。

## 新手上路 {: #getting-started }

  - `curl -O https://raw.githubusercontent.com/visit1985/mdp/master/sample.md && mdp sample.md`
  - 修改後，按 `r` 就可以重載看到效果，按 `q` 離開。
  - 方向鍵、Space/Backspace 都可以切換投影片，數字按鍵可以直接跳到某張投影片；連續輸入 1 跟 3 則可以跳到 13 頁。

參考資料：

  - [https://raw\.githubusercontent\.com/visit1985/mdp/master/sample\.md](https://raw.githubusercontent.com/visit1985/mdp/master/sample.md)

## 寫作 {: #writing }

  - First-level header 會被視為投影片的抬頭，固定以藍色表現、加底線 (置中要加 `->`)；也支援 second-level header，但顯示時不加底線。
  - 水平線 (至少 3 個 `-` 或 `*`) 用來分割投影片，而且前面要用空白行隔開。
  - Inline code 一樣用 `code` 表示，會以白底黑字表現。
  - Code block 一樣內縮 4 格或用 "```" (backticks) 來表示 (會忽略 language hint)，表現方式同 inline code 是白底黑字 (太亮的話，可以用 `--invert` 演示，變灰底白字)；空白行要刻意補上空白，否則白底會出現斷層。
  - Quote 一樣用 `>`，也支援 nested quotes；文字過長會產生斷行，左側的反白會產生斷層，建議在 Markdown 裡就先斷行 (70 個英數字內)
  - List 會用 ASCII 字元串成樹狀，還滿酷的；一樣，維持在 70 個英數字內，自己先斷行。
  - `[label](link)` 會以 `[label][N]` 藍色加底線來表現，實際的 URL 則以 `[N] ...` 顯示在畫面左下方；實驗確認，不支援 `[label][ref]` 的 reference-style link。

與一般的 Markdown 不同的地方有：

  - 開頭用 `%title: ...`、`%author: ...` 及 `%date: ...` 帶出一些基本資訊；其中 title 與 author 會固定顯示在畫面的上方及左下方。
  - 連續的空白字元會被保留
  - 傳統的 `_` 是強調，而 `__` 是畫重點；但在 mdp 裡，`_` 是劃底線，`*` 則是重點 (紅色顯示)
  - `<br>` 或 `^` 可以做漸進的效果 -- stop the output on that position
  - 開頭的 `->` 表示置中，結尾的 `<-` 則可有可無；也可以用在 header，例如 `-> # Header`
  - Quote 裡不支援 list

參考資料：

  - [visit1985/mdp: A command\-line based markdown presentation tool\.](https://github.com/visit1985/mdp)
      - 以 horizontal ruler (`---`) 做為 slides 的分隔符號，支援簡單的 Markdown 語法 -- headline、code、quote、unordered list、bold/underlined/code text；`sample.md` 有更多細節
      - 支援前置 `@` 的 header? 前 2 個 header lines 會顯示為 title、author? => 結果 `sample.md` 裡完全沒有 `@`，但開頭有 `%title: ...`、`%author: ...` 等用法。

## 分享給其他人 {: #sharing }

  - 其實 Markdown 本身的可讀性已經很高，直接分享 mdp 的原始 Markdown 也可以。
  - 用 [asciinema](https://asciinema.org/) 錄製再分享。
  - [https://raw\.githubusercontent\.com/visit1985/mdp/master/sample\.md](https://raw.githubusercontent.com/visit1985/mdp/master/sample.md) 最後提到，可以用 `markdown` 轉成 HTML，再用 `wkhtmltopdf` 轉成 PDF；懷疑 mdp 的 Markdown 不是很標準，轉出來會歪掉?

## 安裝設置 {: #setup }

### macOS

  - [visit1985/mdp: A command\-line based markdown presentation tool\.](https://github.com/visit1985/mdp) 在 macOS 上，用 Homebrew 安裝 `mdp` 套件即可。

### `TERM`

  - `export TERM=xterm` 沒有淡出/淡入效果 (反應快)，又可以表現底線；淡入/淡出可以用 `mdp --nofade` 停用。
  - 可以事先建好 iTerm 2 的 profile，把字體放大，terminal 採用 `xterm`，方便展示。

參考資料：

  - [visit1985/mdp: A command\-line based markdown presentation tool\.](https://github.com/visit1985/mdp) 提到 `TERM` 環境變數設為 `xterm-256color` 才能正確顯示 256 種顏色 -- 淡入 & 淡出。
  - 在 tmux 下，發現 `TERM` 被設定為 `screen`，沒有淡入/淡出，感覺是比較流暢的；但後來發現 `TERM=screen` 或 `TERM=linux` 的底線效果都出不來，改用 `TERM=xterm` 或 `TERM=rxvt` 就可以。

## 參考資料 {: #reference }

  - [visit1985/mdp - GitHub](https://github.com/visit1985/mdp)

相關：

  - [Slideshow](slideshow.md#markdown)
