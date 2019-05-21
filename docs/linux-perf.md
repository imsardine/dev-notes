---
title: Linux / Performance
---
# [Linux](linux.md) / Performance

## Load Average ??

Linux 下的 `top` 跟 `uptime` 都會輸出 'load averages'：

```
$ uptime
 08:47:23 up 10:43,  1 user,  load average: 0.02, 0.10, 0.29      <1>
$ top
top - 08:47:21 up 10:43,  1 user,  load average: 0.02, 0.10, 0.29 <2>
Tasks: 185 total,   2 running, 182 sleeping,   0 stopped,   1 zombie
Cpu(s): 11.0%us,  8.6%sy,  0.5%ni, 77.6%id,  2.0%wa,  0.0%hi,  0.3%si,  0.0%st
Mem:   3960052k total,  2820096k used,  1139956k free,    48596k buffers
Swap:  5245184k total,   283952k used,  4961232k free,  1224796k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 3108 jeremy    20   0 1286m 598m 547m S    6 15.5  19:02.89 VirtualBox
 1852 jeremy    20   0  292m 4488 2484 S    4  0.1   3:17.38 clock-applet
...
```

 1. 這三個數字分別表示最近 1/5/15 分鐘內平均的 CPU load，數字越小表示 load 越輕。
 2. 跟 `uptime` 的輸出一樣，但 `top` 會定期更新這個值。

從 load averages 這三個數字之間的消長，可以看出 CPU load 的趨勢：

  - 越右邊的數字越具參考價值，例如：

      - 最近 1 分鐘的 load average 衝高到 2.00，表示這只是暫時的現象，並無大礙。
      - 最近 15 分鐘的 load average 都是 2.00，表示 CPU load 一直都處在高檔，表示遇到 CPU bound 的問題了。

  - 由左至右，如果數字越來越大的話，表示 CPU load 呈現下降的趨勢，反應就是呈現上升的趨勢；由右至左來讀這三個數字可能會比較直覺

可以把'單一' CPU 單位時間內的總運算能力視為 1.00，切割成 'n' 份後（a slice of CPU time），分給不同的 processes/threads（處理的順序由 nice values 來決定）。如果 load average 的值是 3.00 的話，表示 CPU 正在處理 n 個 processes/threads 的運算，但還有 2n 個 processes/threads 在等待處理。Linux 有所謂 run-queue length 的概念，指的正是 CPU '正在處理' 以及 '等待處理' 的 processes/threads 數量。

為什麼上面要強調 “一個 CPU“ 呢？因為如果是四顆 CPU 的話，總運算能力就是 4.00。也就是說，1.00 對只有一顆 CPU 的機器來說是 CPU 100%，但對有四顆 CPU 的機器來說（或是兩個雙核的 CPU；事實上，我們可以忽略這樣的差異，我們真正在乎的是 cores 的數量），只有 CPU 50% 而已。

要先搞清楚 processor cores 的數量，才能對 load averages 做出正確的解讀。

Linux 下，可以從 `/proc/cpuinfo` 查看 CPU 的詳細資料 (編號從 0 開始)。

CPU load 比 CPU percentage 更能清楚地反應出負載到底有多重：

 - CPU percentage 只是某個瞬間 CPU 的利用率（可能在等待 I/O），到了 100% 就上不去了，無法像 CPU load 一樣，把後面還有多少 processes/threads 在排隊的情形反應出來。
 - 更重要的一點，load average 並不會將那些正在等待非 CPU 運算完成的 processes/threads 計入。因此，如果 CPU load 真的超過負載，加 CPU 肯定可以提昇效能。

參考資料：

  - [Load (computing) \- Wikipedia](https://en.wikipedia.org/wiki/Load_%28computing%29) #ril
  - [Understanding Linux CPU Load \- when should you be worried? \| Scout APM Blog](https://scoutapp.com/blog/understanding-load-averages) (2009-07-31) 用一座橋來比喻 CPU 的運算能力，CPU 的數量則用車道的數量來做比喻；車子要能順利通過這座橋，如果有塞車而上不了橋，表示已經超過 CPU 的負載。 #ril
  - [Examining Load Average \| Linux Journal](https://www.linuxjournal.com/article/9001) (2006-12-01) 超專業，已經講到 kernel 去了 #ril
  - [How do I Find Out Linux CPU Utilization? \- nixCraft](https://www.cyberciti.biz/tips/how-do-i-find-out-linux-cpu-utilization.html) (2006-04-06) #ril
