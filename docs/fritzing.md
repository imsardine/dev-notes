# Firtzing

  - [Fritzing \- An Introduction \- YouTube](https://www.youtube.com/watch?v=Hxhd4HKrWpg) Fritzing 唸做 `free(t)zing`
  - [Fritzing Download](http://fritzing.org/download/) Version 0.9.3b was released on June 2, 2016. 2018 年底看來，開發有點停滯?
  - [Fritzing Fab now powered by AISLER \| Fritzing Blog](http://blog.fritzing.org/2017/02/21/fritzing-fab-now-powered-by-aisler/) (2017-02-21) 宣佈與 AISLER 合作後，至今 (2018 年底) 仍沒有新版釋出，一堆人在問這專案是不是死了...
  - [Fritzing \- Wikipedia](https://en.wikipedia.org/wiki/Fritzing) #ril
  - [Creating A PCB In Everything: Friends Don’t Let Friends Use Fritzing \| Hackaday](https://hackaday.com/2016/10/11/creating-a-pcb-in-everything-friends-dont-let-friends-use-fritzing/) (2016-10-11) #ril
  - [Arduino \- Blink](https://www.arduino.cc/en/Tutorial/Blink) 電路圖用 Fritzing 畫。

## 新手上路 {: #getting-started }

  - [Fritzing \- An Introduction \- YouTube](https://www.youtube.com/watch?v=Hxhd4HKrWpg) #ril
      - Electronic projects, document your projects -> prepare them for production
      - 有許多 views，在一個 view 的修改也會反應到其他 views
      - Breadboard view (不在 Fritzing part library 裡的可以用 part editor 自訂)
      - Schematic view (formal representation of the circuit)
      - PCB view 可以調整 parts 在印刷電路板 (printed curcuit board) 的位置，透過 auto router 可以自動調整 layout (很神奇!)
      - 可以直接分享到 fritzing.org (`.fzz`)
      - Fritzing 可以安裝在 Windows, Mac 跟 Linux (德國團隊製作)
  - [Fritzing FAQ](http://fritzing.org/faq/) #ril
      - Fritzing 是個設計工具而非 simulator，強調動手做還是很重要。
      - 發佈 breadboard view 時至少要載明這是用 Fritzing 做的。
      - Fritzing 本身用 C++ 跟 Qt 開發 (本來是用 Eclipse GMF，但遭遇一些困難)

## 安裝設定 {: #installation }

  - [Fritzing Download](http://fritzing.org/download/)
      - 支援 Windows、Mac 10.7+ 跟 Linux; Linux 要 libc >= 2.6 的版本 (在 Ubuntu 上測試過)
      - Mac 下載 `Fritzing<VERSION>.dmg`，掛載起來將 Fritzing 拉到 `/Applications` 即可；啟動時遇到 `"Fritzing" can't be opened because it is from an unidentified develooper` 的錯誤，要進 System Preferences > Security & Privacy > General 另外設定。

## 參考資料 {: #reference }

  - [Fritzing](http://fritzing.org/)
  - [fritzing/fritzing-app - GitHub](https://github.com/fritzing/fritzing-app)

相關：

  - [Circuit Diagram 電路圖](circuit-diagram.md#tools)

