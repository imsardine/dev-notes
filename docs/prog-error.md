---
title: Programming / Error Handling
---
# [Programming](prog.md) / Error Handling

## Error Handling != Exception Handling ??

  - Error handling 的說法會比 exception handling 來得通用，因為 exception 只是處理 error 的一種機制。

參考資料：

  - [Exception handling \- Wikipedia](https://en.wikipedia.org/wiki/Exception_handling) #ril
  - [搞笑談軟工: 例外處理壞味道（上）](http://teddy-chen-tw.blogspot.com/2013/12/blog-post_13.html) (2013-12-13) #ril
  - [On Exception Handling and Clean Code \| Toptal](https://www.toptal.com/abap/clean-code-and-the-art-of-exception-handling) #ril

## Fail Fast ??

  - [Fail Fast -- ThoughtWorks](https://martinfowler.com/ieeeSoftware/failFast.pdf) (2004-09, PDF)
      - 軟體開發最惱人的是 debugging，尤其是那種經過長時間正常操作後才出現的錯誤、從 stack trace 追查不出原因的那種；Fail Fast 雖然無法減少錯誤的數量，但至少會讓 defect 更容易被找到。
      - 為了 robust (的假象) 而 work around problems automatically? 會造成 failing slowly -- requiring tedious debugging，也就是發生錯誤後還會繼續運作，但終將以奇怪的方式 fail。
      - 而 fail fast 反其道而行，"failing immediately and visibly" 看似不直覺且會讓軟體變得 fragile，但其實是會讓它變得 robust。不過 "Bugs are easier to find and fix, so fewer go into production" 這句話是否暗示 fail fast 不適用 production?
      - 以 `maxConnections` 的 configuration 為例，讀不到時要回 null 或 default (10)，還是直接噴錯? 假設設定檔打錯 `maxConfiguration = 100` (最後少了個 "s")，啟動 server 一切正常，但使用者可能覺得奇怪效能怎麼變差了?
      - Fail fast 的關鍵是 assertion，但什麼時候加 assertion? 通常寫下 "假設" 的 comment 都應改寫成 assertion。大部份的語言都內建支援 assertion，不過因為它 generic、limiting expressiveness 的特性，也不一定會丟 exception (可以停用 assertion)，作者習慣包裝一層 assertion class。
      - "When you’re writing a method, avoid writing assertions for problems in the method itself" 與 "Assertions shine in their ability to flush out problems in the SEAMS of the system" 這兩句有點難懂?? 可能是因為單一個 method 是 stateless 的關係? 有問題的話都是源自 input 或 output (包括往別人呼叫)，應該用 test 來檢查。
      - 大部份的情況下 null references 不用特別處理，出錯時 stack trace 會帶到問題的根源，但 "assign a parameter to an instance variable" 可能會讓問題延後發生，所以要特別做檢查 -- 這比較像是 argument checking。
      - 這裡只是舉了些例子，重點還是思考的過程 (the thought process) -- Think about what kinds of defects are possible and how they occur. 然後把 assertion 放在問題的源頭 (close to the original problem)，讓問題容易被找到。
      - Eliminate the debugger 的觀點很特別 -- 找到問題的點，也需要當時變數的內容，想想看假設這個 assertion 失敗了，你還需要哪些資訊 -- Don’t just repeat the assertion’s condition; the stack trace will lead to that. Instead, put the error in context. 還有就是 Assertions are for programmers, so they don’t need to be user friendly, just informative.
      - Robust failure 回應了 fail fast 是否適用 production 的疑慮；不要停用 assertion!! 因為有些發生在 customer site 的問題很難重製，但直接 crash 也不適合，還好 global exception handler 就是個折衷 -- 統一處理 unexpected exceptions (包括 assertion)，並且通知到 developer；當然這要避免 catch-all exception handlers 才行，否則 exception 不會來到 global handler。
  - [Fail\-fast \- Wikipedia](https://en.wikipedia.org/wiki/Fail-fast) #ril
  - [What's Worse Than Crashing?](https://blog.codinghorror.com/whats-worse-than-crashing/) (2007-08-02) #ril
  - [Fail Fast principle \- Enterprise Craftsmanship](http://enterprisecraftsmanship.com/2015/09/15/fail-fast-principle/) (2015-09-15) #ril

## Narrow try/catch Blocks ??

  - [Readability: Narrow try/catch blocks \- Julio Merino](http://julio.meroh.net/2013/07/readability-narrow-trycatch-blocks.html) (2013-07-29) #ril
  - [exception handling \- Should java try blocks be scoped as tightly as possible? \- Stack Overflow](https://stackoverflow.com/questions/2633834/) #ril
