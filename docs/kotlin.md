# Kotlin

  - Kotlin 唸做 [‵kɑ-ʈə-lɪŋ]，不是唸 [‵ko]。

參考資料：

  - [How to Kotlin \- from the Lead Kotlin Language Designer (Google I/O '18) \- YouTube](https://www.youtube.com/watch?v=6P20npkvcb8) Kotlin 的發明者 Andrey Breslav 現身說法，可以聽到 Kotlin 標準的唸法。
  - [FAQ \- Kotlin Programming Language](https://kotlinlang.org/docs/reference/faq.html)
      - What is Kotlin? Kotlin is an OSS STATICALLY TYPED programming language that TARGETS the JVM, Android, JavaScript and Native. 2010 開始，直到 2016/02 釋出 v1.0。注意 target 這個用字，感覺 Kotlin 可以轉換成不同的形式，以執行在不同的平台/環境下。
      - Is Kotlin free? Yes. Kotlin is free, has been free and will remain free. 授權採 Apache 2.0
      - Is Kotlin an object-oriented language or a functional one? Kotlin has both object-oriented and functional constructs. You can use it in both OO and FP styles, or MIX elements of the two.
      - What advantages does Kotlin give me over the Java programming language? Kotlin is more concise. (省下約 40% 的程式碼)、It’s also more type-safe (避免不必要的 NPE) ... facilitating creation of DSL. 這跟 Groovy 的定位重疊??
      - Is Kotlin compatible with the Java programming language? Yes. Kotlin is 100% interoperable with the Java programming language and major emphasis has been placed on making sure that your existing codebase can interact properly with Kotlin. 可以互 call 對方，甚至 IDE 有提供 Java-to-Kotlin 的轉換。
      - What can I use Kotlin for? Kotlin can be used for any kind of development, be it SERVER-SIDE, client-side web and Android. With Kotlin/Native currently in the works, support for other platforms such as embedded systems, macOS and iOS is coming. 感覺無所不包，且 Kotlin/Native 執行期不需要 VM，那麼 iOS 跟嵌入式系統的支援就不無可能。
      - What does Kotlin compile down to? When targeting the JVM, Kotlin produces Java compatible bytecode. When targeting JavaScript, Kotlin transpiles to ES5.1 ... When targeting native, Kotlin will produce platform-specific code (via LLVM). 完全要看它 target 誰
      - Does Kotlin only target Java 6? Kotlin lets you choose between generating Java 6 and Java 8 compatible bytecode. 當然這是 target JVM 時。
      - Who develops Kotlin? 由 JetBrains 的工程師開發，lead language designer 是 Andrey Breslav。
  - [Comparison to Java \- Kotlin Programming Language](https://kotlinlang.org/docs/reference/comparison-to-java.html) #ril
      - What Java has that Kotlin does not 提到 checked exceptions!? 另外為什麼把 Ternary-operator a ? b : c 拿掉?

## 新手上路 ?? {: #getting-started }

  - [Is Kotlin hard? - FAQ \- Kotlin Programming Language](https://kotlinlang.org/docs/reference/faq.html#is-kotlin-hard) Kotlin 受到 Java、C#、Scala 及 Groovy 等語言的影響，雖然 idiomatic Kotlin 跟進階的用法要花一些時日，但整體而言它不是個複雜的語言。
  - [Tutorials \- Kotlin Programming Language](https://kotlinlang.org/docs/tutorials/index.html) #ril
  - [Kotlin Koans - Kotlin Playground](https://play.kotlinlang.org/koans/overview) 通過失敗的 unit test 來練習 Kotlin syntax，根據調查，這是 Java 開發人員學習 Kotlin 最有效的方式 #ril
  - [Basic Syntax \- Kotlin Programming Language](https://kotlinlang.org/docs/reference/basic-syntax.html) #ril

## Coding Style ??

  - [Idioms \- Kotlin Programming Language](https://kotlinlang.org/docs/reference/idioms.html) #ril
  - [Coding Conventions \- Kotlin Programming Language](https://kotlinlang.org/docs/reference/coding-conventions.html) #ril

## 安裝設定 {: #installation }

  - [What build tools support Kotlin? - FAQ \- Kotlin Programming Language](https://kotlinlang.org/docs/reference/faq.html#what-build-tools-support-kotlin) On the JVM side, the main build tools include Gradle, Maven, Ant, and Kobalt. There are also some build tools available that target client-side JavaScript. 針對不同 target 有不同的 build tool。
  - [Working with the Command Line Compiler \- Kotlin Programming Language](https://kotlinlang.org/docs/tutorials/command-line.html) #ril

## 參考資料

  - [Kotlin Programming Language](https://kotlinlang.org/)
  - [Kotlin Playground](https://play.kotlinlang.org/) / [Try Kotlin](https://try.kotlinlang.org/)
  - [JetBrains/kotlin - GitHub](https://github.com/JetBrains/kotlin)
  - [Kotlin Blog](https://blog.jetbrains.com/kotlin/)
  - [Kotlin.link](https://kotlin.link/)

社群：

  - [Kotlin Discussions](https://discuss.kotlinlang.org/)
  - [Kotlin (@kotlin) | Twitter](https://twitter.com/kotlin)
  - ['kotlin' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/kotlin)

相關：

  - [JaCoCo](jacoco-kotlin.md)
