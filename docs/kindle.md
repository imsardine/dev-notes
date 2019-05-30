# Kindle

  - Kindle 出現異常時，長按 Power 7 秒後選 Restart；若選單沒出現，則長按 40 秒強制重開。
  - 用 USB 連接電腦時會進入 USB drive mode，從 OS 退出裝置就可以離開 USB drive mode 但繼續充電。
  - Kindle 可以透過 Menu > Landscape / Portrait Mode 轉向
  - Toolbar > Go To > Content 可以看到 TOC，而 Note 則可以看到 note 跟 highlight

## 如何用 Kindle 看自己的 EPUB?

  - How to read EPUB files on your Kindle - CNET (2011-11-07) https://www.cnet.com/how-to/how-to-read-epub-files-on-your-kindle/ 用 Calibre 將 EPUB 轉成 MOBI #ril

## 自行轉檔送到 Kindle 的電子書，要怎麼備份/回復 highlights 與 bookmarks??

  - 試過修改 `documents/My Clippings.txt` 沒有作用；把 `documents/My Clippings.txt` 與 `documents/My Clippings.sdr/` 都刪掉，highligh 還是在 => 其實 My Clippings 只是一本會自動抄寫 highlight 的筆記而已。
  - 發現備份 `<BOOK>.mobi` 對應的 `<BOOK>.srd/` 是有用的，注意過程中不要開著該電子書即可，包括 highlight 跟 bookmark 都在裡面；只擔心 `<BOOK>.srd/` 底下的檔案會因裝置而異??
  - One Click Clean Useless sdr Folders in Kindle - eReader Palace https://www.ereader-palace.com/one-click-clean-useless-sdr-folders-kindle/ `.sdr/` 的存在是因為 "this mechanism makes re-reading a book a better experience"，試過在 Kindle 上刪除透過 Calibre 安裝的電子書，`.sdr` 會留著，下次重新用 Calibre 再安裝一次電子書時，所有的 notes、highlights、reading progress 都回來了。
  - `<BOOK>.srd/` 下有 `<BOOK><DIGEST>.mbp1` 與 `<BOOK><DIGEST>.mbs`，不知道 `DIGETST` 是怎麼產生的?? 發現就同一個 MOBI 其 `DIGEST` 並不會因檔名不同而異，也不是 MOBI 的 MD5 ...

## 如何連結 Amazon 中國? 怎麼有效在 amazon.cn 與 amazon.com 間游走?

  - 註冊 amazon.cn 帳號 (可用微信加入)，跟 amazon.com 是拆開的，結果也選不到自己的 Kindle 設備? => 之後編輯密碼，在 Kindle Paperwhite 上輸入 "+886手機號碼" + 密碼 就可以登入，看到的 store 就是 Amazon 中國
  - 不過為什麼電子書都顯示 "该商品目前无法进行购买" => 我怎么就用kindle买不明白书呢！！菜鸟求助。。。 https://www.douban.com/group/topic/46075317/ yan-wen-jun: 我的账户 > 管理我的内容和设备 > 设置 > 国家/地区设置，隨便提供一個中國飯店住址、電話即可變更為 "中國"，之後瀏覽書籍時就會出現 "立即购买" 或 "一键下单"。
  - 如何用美國的Kindle Paperwhite 買中国亚马逊的電子書 | By 李怡志 http://blog.richyli.com/?p=1400 重新申請 amazon.cn 的帳號 (帳號跟美國可以一樣，但密碼不同即可)，然後帳號 > 管理地址簿 給一個中國大陸的地址即可。
  - 由於 amazon.cn 與 amazon.com 拆開，之前在 amazon.com 上買的書會看不到，只好用兩個設備分別連往 amazon.cn 與 amazon.com；由於買英文原文書的機會相對較少 (amazon.cn 上的中文書很便宜)，大部份都是找 EPUB 下載，所以 Kindle 設備就連往 amazon.cn，而 Kindle for Android/iOS 就連往 amazon.com (amazon.cn 的 Kindle for Android 要自行下載 APK 有點可怕)。
  - 在 amazon.cn 用信用卡買東西還是會有國際交易費，建議走 付款设置 > 账户充值 儲值 (不會要求 CNC 碼?)，能有效減少國際交易費的產生 (儲值可以用 3 年)；另外 包月电子书 採整年制也可以...

## 怎麼使用 Kindle Unlimited (包月电子书) ?

  - "随心畅读数万本精选中英文电子书 ，一次购买，即可自在阅读整月（12元/月）或者整年（118元/年）。立刻加入服务，开启阅读之旅！" ... 英文書也有??
  - 每年 ¥118 也太划算吧? 那是因為並非所有的書都在 Kindle Unlimited 的計劃裡。
  - "开始7天试用 仅需0.1元" 按下去，不能用之前儲值的錢? 因為它要綁定信用卡，之後自動續費；預設採用 "月度会员资格"

## Dictionary 字典

  - Vocabulary Builder 可以用來學習新單字? => 閱讀期間查過的單字會自動加入 builder，之後可以練習 flashcard 或查看 usage sample (即查閱單字時，該單字所在的句子)；可以到 Settings > Reading Options > Language Learing > Vocabulary Builder 關閉
  - Vocabulary Builder > Flashcards 會顯示 usage sample，再問自己這個字懂不懂，如果懂就按 Mark as Mastered
  - 中英字典要怎麼安裝?? 會自動安裝 New Oxford American Dictionary

### 在英文介面下怎麼改用英漢字典?

  - Settings > Language and Dictionaries，先將介面改成簡中，重新開機就會自動下載漢英字典，之後再點進 Language and Dictionaries 把 English > 英漢字典 選為預設字典即可。 

## 疑難排解 {: #troubleshooting }

  - Collection 一定會同步回 cloud，選擇性下載到 Kindle 的會標上星號?? 從 Clound 選定某個 clollection 時，表示 collection 的書都會下載??
  - 怎麼用 Goodreads?? 就是一個分享正在讀什麼、未來要讀什麼的社群??
  - Language Learning 下除了 Vacabulary Builder 外，還有一個 Word Wise ?? 它怎麼知道我哪些字不熟??
  - 重設裝置後，為何 vocabulary builder 裡這麼多單字，怎麼清空??
  - Kindle FreeTime??
      - 跟 Househld 是什麼關係??
      - 可以從 library 選一些書讓孩子讀，可以設定 reading goal、追蹤進度，小朋友可以贏得徽章 (badge) 跟獎項 (award)。
      - 新增 profile、設定密碼 (這跟一開始的 parental control 有關??)
  - 若要完全關掉螢幕，長按 Power 7 秒，選 Screen Off => 全白、沒有 screensaver；跟 sleep mode 有什麼差別?? 要怎麼真的關機??
  - 幾分鐘沒有動作後?? 會自動進入 sleep mode 並顯示 static screensaver (完全不耗電)，也可以自己按 Power 進/出 sleep mode。
  - 可以用 USB 傳送檔案，裡面的檔案結構?? 書本要放哪裡?? 還可以放什麼東西?? 例如音樂、圖片等...
  - 英文以外的鍵盤?? => Settings > Device Options > Language and Dictionaries > Keyboards；發現有 Chinese (Simplified)，結果輸入時似乎只能用羅馬拼音?? 不過可以選到繁體字倒是真的
  - 可以看期刊 (periodical) ?? 可以看報紙嗎?? 
  - X-Ray 的作用是什麼?? 看所有的圖片還可以理解，但 Terms 是怎麼決定的??
  - 從 Kindle 上直接分享到 FB 或 Twitter 是什麼樣子?? 可以加上自己的想法嗎?

## 參考資料 {: #reference }
