# JaCoCo / Kotlin

  - [JaCoCo \- Change History](https://www.jacoco.org/jacoco/trunk/doc/changes.html) Release 0.8.2 (2018/08/21) 才開始提及 Kotlin，不過都跟 filtered out during generation of report；看似 JaCoCo 早就支援 Kotlin，因為 Kotlin 會產生 bytecode #ril

## 新手上路 {: #getting-started }

  - [Kotlin \+ JaCoCo: Tuning Compiler to Skip Generated Code\.](https://medium.com/@andrey.fomenkov/kotlin-jacoco-tuning-compiler-to-skip-generated-code-935fcaeaa391) (2018-03-26)
      - JaCoCo is a free and powerful library for generating comprehensive test coverage reports. Unfortunately for Kotlin developers the collected test information may appear UNREADABLE and DIRTY. 看來 JaCoCo + Kotlin 是可行的，只是有雜訊。
      - Kotlin compiler generates a lot of bytecode even for a concise syntactic constructions; From JaCoCo’s point of view there is no difference between developer and compiler generated code — it analyzes everything in bytecode when composing coverage reports. 後者 "compiler generated code" 指的正是 Kotlin compiler。
      - 以一個簡單的 Kotlin data class 而言，Kotlin compiler 會產生一堆 bytecode，在 JaCoCo 看來就是這些 bytecode 都沒被測試，但我們只寫一行宣告，理當這些自動產生的 bytecode 不應出現在 coverage report 裡；況且 Kotlin 背後的 JetBrains 應該測過。
      - 接著說明當時可能的解法，不過從 0.8.2 開始陸續加上濾除 generated code 的功能，從 [JaCoCo changelog](https://www.jacoco.org/jacoco/trunk/doc/changes.html) 可以看到細節。
  - [How to configure JaCoCo for Kotlin & Java project](http://vgaidarji.me/blog/2017/12/20/how-to-configure-jacoco-for-kotlin-and-java-project/) (2017-12-20) #ril
  - [Test coverage in Kotlin with Jacoco \- KevCodez](https://kevcodez.de/index.php/2018/08/test-coverage-in-kotlin-with-jacoco/) (2018-08-19) #ril