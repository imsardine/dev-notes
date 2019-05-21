# top

## Threads Mode

  - 在 Threads Mode 下，每個 thread 的數據會分開顯示，否則只是加總每個 process 下所有 thread 的數據而已。
  - 啟動時加 `-H` 可以直接進入 Threads Mode，也可以用 `H` (interactive command) 動態開關 Threads Mode；第 2 行 `Tasks/Threads: NN total` 可以看到明顯的差別。

參考資料：

  - [Ubuntu Manpage: top \- display Linux processes](http://manpages.ubuntu.com/manpages/xenial/man1/top.1.html)
      - `-H  :Threads-mode operation` 要求顯示個別的 thread，否則會顯示一個 process 下所有 thread 的總和 (summation)。也可以用 `H` 切換 -- 很明顯地，第 2 行會看到 `Tasks/Threads: NN total` 明顯的變化。
      - `PID  --  Process Id` 除了顯示 process ID，也可能是 process group ID、thread group ID 等，跟 thread ID 不同??
      - `%CPU  --  CPU Usage` 提到，在 SMP (對稱式多工處理, Symmetric MultiProcessing) 的環境下，不在 threads mode 時，CPU usage 可能出現大於 100% 的狀況。
  - [Light\-weight process \- Wikipedia](https://en.wikipedia.org/wiki/Light-weight_process) "In those contexts, the term "light-weight process" typically refers to kernel threads and the term "threads" can refer to user threads." 某種程度上，lightweight process (LWP) 可以視為 thread
  - [Troubleshooting high CPU usage in Java applications](http://tech.asimio.net/2016/02/11/Troubleshoot-high-CPU-usage-in-Java-applications.html) (2016-02-11) 用 `top -H` (threads mode) 找出 lightweight process (LWP) 的 ID，不過是對應到 thread dump 裡的 nid

## 參考資料 {: #reference }

手冊：

  - [top(1) - die.net](https://linux.die.net/man/1/top)
  - [Ubuntu Manpage: top](http://manpages.ubuntu.com/manpages/xenial/man1/top.1.html)
