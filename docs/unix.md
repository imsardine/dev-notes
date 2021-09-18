# Unix-like

## Login Sessions

### 如何切換登入身份?

```
$ sudo su - [USERNAME]
```

參考資料：

  - [The su Command](http://www.linfo.org/su.html) `su` (substitute user) 可以改變 login session 的 owner (用 `whoami` 確認)，可以切換作任何 user，但最常用於切換為 root (會留下記錄，比較直接登入 root 看不出是誰)，所以 su 也被解讀為 "superuser" 或 "switch user"。`su` 預設會保持當前目錄與環境變數不變，建議在 username 前加上 hyphen (`-`，等同於 `-l, --login`)，當前目錄跟環境變數都會像是該使用者剛登入系統的樣子。
  - [The su Command](http://www.linfo.org/su.html) `su -c COMMAND - [USERNAME]` 會以另一個使用者的身份執行 command，跟 `sudo` 有什麼不同??

## Files

### 如何在複製檔案時，置換內部的變數或 token??

參考資料：

  - [bash \- How to replace $\{\} placeholders in a text file? \- Stack Overflow](https://stackoverflow.com/questions/415677/) user: 用 Sed 取代字串 (不過把變數 `${var}` 整個視為 placeholder 好像有點呆?)；mklement0: 利用 `eval` 展開環境變數。

## `find`

  - 多個條件要怎麼下? => 用 `(expr1 -o expr2)` 或 `! expr` 組合多個條件。

## Process

### `killall` 如何根據 argument 過濾?

結論：

  - 改用 `pkill -f <PATTERN>`，例如 `pkill -f gitbook`，若想知道 pattern 會 match 到哪些 process，可以先用 `pgrep -lf <PATTERN>` 檢查。

參考資料：

  - 像 `node`、`python` 通用的 process，如何過濾特定的 script? 因為 `killall` 只會比對 process name。
  - Linux: Kill process based on arguments - Unix & Linux Stack Exchange https://unix.stackexchange.com/questions/31107/ 用 `pkill` 搭配 `-f` (match against full argument lists)，例如 `pkill -f 'sleep 30'`；事實上 pattern 是以 regex 來解讀。

## Disks

### 如何找出是誰吃掉了磁碟空間??

  - 用 `du -hd 1` 先查出哪個子資料夾是大戶。

## 參考資料 {: #reference }

社群：

  - [Unix & Linux Stack Exchange](https://unix.stackexchange.com/)

更多：

  - [Date/Time](datetime.md)
  - [Networking](networking.md)

