# Unit Testing 單元測試

## Questions

  - Infinitest https://infinitest.github.io/ 會在 code 變動時自動執行測試，聽起來不錯??
  - 什麼是 FIRST principle??
  - Coverage 100% 的意義是什麼?
  - 做單元測試時，我們總是對其他 dependency 做了假設 "我這樣呼叫你，就會完成一些事"，這些東西應該寫在 Javadoc 上才對??
  - 除以 0 的複雜度有辦被算出來嗎??

## 定位

### Unit 指的是什麼?

  - Unit 可大可小，重點反倒是 unit 之外的 collaborator isolation。
  - Building Effective Unit Tests | Android Developers https://developer.android.com/training/testing/unit-testing/index.html 提到 unit of code 可以是 method、class 或 component。
  - UnitTest - Martin Fowler https://martinfowler.com/bliki/UnitTest.html "what people consider to be a unit" 提到大家對 unit 的認知不同，OOD 認為是 class、而 functional programming 認為是 function，作者認為 "closely related classes" 或 "a subset of methods in a class" 都可以視為是 unit。

  - Flexible and expressive unit tests with the builder pattern https://www.kenneth-truyers.net/2013/07/15/flexible-and-expressive-unit-tests-with-the-builder-pattern/ 提到 "Unit tests become more valuable if they are expressive and flexible. A good unit test should not only test your code, but also document it."
  - Building Real Software: Automated Tests as Documentation (2013-06-13) http://swreflections.blogspot.tw/2013/06/automated-tests-as-documentation.html 這標題下得真好!! #ril

### 關鍵是 Seams

  - 覺得 DI 只是劃出 seam 的手段，像 Python 這種不太需要 DI 的語言，可替換的 names 就是 seam。
  - Google Testing Blog: Static Methods are Death to Testability https://testing.googleblog.com/2008/12/static-methods-are-death-to-testability.html 也提到 seams #ril
  - Seams | Testing Effectively With Legacy Code | InformIT http://www.informit.com/articles/article.aspx?p=359417&seqNum=2 "A seam is a place where you can alter behavior in your program without editing in that place." 這話說得真好!! #ril

## 基礎

### Arrange-Act-Assert (3A) 原則?

  - Arrange 是不是不該藏進 setup 裡? 感覺 setup 應該只處理 fixture，而 arrange 還是應該明確寫在 test method 裡?
  - Arrange Act Assert http://wiki.c2.com/?ArrangeActAssert 一種安排/格式化 test method 的 pattern，用空白行把 arrage (precondition)、act (on CUT, AUT, SUT)、assert (expected results) 分開來 #ril
  - Arrange Act Assert | JustMock Documentation http://docs.telerik.com/help/justmock/basic-usage-arrange-act-assert.html #ril

### 測試的單位 input 越少越好??

  - 以某個複雜的 data structure 做為 input 時，若沒有用到全部的資料，在測試時如何只提供部份的資料 -- 像 builder 的存在一樣，如何讓會影響結果的 input 被突顯出來? 話說回來，複雜的 data structure 只不過是另一種 object? (例如 hashmap，不同的 key 帶不同的資料)，所以 builder pattern 應該也適用。

## Good Tests

  - 從 caller 角度來想，目前是怎麼用它的，對外做了什麼承諾 (如果有 Javadoc 就好)
  - How to write good tests · mockito/mockito Wiki https://github.com/mockito/mockito/wiki/How-to-write-good-tests #ril
  - AimiaMobile/unit-testing-guidelines: Unit testing best practices https://github.com/AimiaMobile/unit-testing-guidelines #ril

### FIRST Principle ??

  - [Test\-Driven Development on Android with the Android Testing Support Library \(Google I/O '17\) \- YouTube](https://www.youtube.com/watch?v=pK7W5npkhho) (2017-05-18) 07:10 列舉 unit test 應該要掌握的要點 - thorough、repeatable、focused、verify behavior (避免對實作做太多假設，測試 behavior，才不會 implementation 改變就影響 test；這與 [Mockito](https://github.com/mockito/mockito/wiki/How-to-write-good-tests) "focusing on interactions between objects" 的想法一致)、fast (尤其測試數量會很大，否則會不想寫測試、做 refactoring)、concise (將測試做為 documentation)；比 FIRST 多了 focused (快速定位出問題點) 與 verify behavior。
  - Test-Driven Development on Android with the Android Testing Support Library (Google I/O '17) - YouTube (2017-05-19) https://www.youtube.com/watch?v=pK7W5npkhho Mobile Nijia 的場子，ATSL (包括 `AndroidJUnitRunner`、rules、Espresso) 就是這個小 team 在負責，圍遶著 Test Pyramid 與 "Testing is about tradeoffs"，從定位 large E2E test 的 UI test (Espresso) 講到 small unit test (Robolectric)，再回頭講怎麼搭配 hermetic environment 把 large E2E test 拆成數個 medium integration test，宣告下一版 ATSL 會有 Android Test Orchestrator 與 Multiprocess Espresso，分別解決 large E2E test 的 flakiness 與 UI 可能執行在不同 process 的問題。其間最讓人意外的是 Robolectric 似乎在 Google 內部逐漸受到重視，雖然官方常未宣稱支持這個專案，但從 Android CTS 測試進度已達 70% 這件事看來，正式成為 ATSL 的一員也是可以期待的?
  - [F\.I\.R\.S\.T Principles of Unit Testing · ghsukumar/SFDC\_Best\_Practices Wiki](https://github.com/ghsukumar/SFDC_Best_Practices/wiki/F.I.R.S.T-Principles-of-Unit-Testing) (2016-06-28) Fast, Isolated/Independent, Repeatable, Self-Validating, Thorough & Timely，其中 Isolated/Independent 與 Repeatable 互為因果，最重要的就是不要跟環境、會變動的資料、執行順序相依；Fast 背後主要的考量是量很大，所以加總起來的時間會很可觀。
      - Fast 若不夠快，開發人員就會不想多執行它；由於 unit test 的量很大，若每個 test 不控制在幾個 millisecond，加總起來的時間會很可觀。
      - Isolated/Independent - 提及 3 As - Arrange, Act, Assert，其中 arrange 與 "不要跟環境相依" 也有點關係 (不要在這裡做 assert)，另外只做 a single logical assert (== multiple physical asserts)，避免 order-of-run dependency。
      - Repeatable - 因為不跟環境、會變動的資料 (例如 date/time) 相依，所以結果是決定論的 deterministic (de-ter-mi-nis-tic) ；感覺 repeatable 是 isolated/independent 的產物。
      - Self-validating - 不需要人為介入去判斷 pass 或 fail。
      - Thorough and Timely - 比起 100% coverage，是不是覆蓋所有的 use case scenario 更為重要。另外儘可能做到 TDD，這樣就不用事後做 refactoring。
  - [FIRST Principles for Writing Good Unit Tests \- HowToDoInJava](https://howtodoinjava.com/best-practices/first-principles-for-good-tests/) (2016-08-22) Fast 提到慢的原因極可能是跟 database/file/network 產生相依，這些 "external environment not under your direct control" 會防礙你達成 repeatable；另外 isolated 除了要避開不受控制的外部環境、變動資料，也要 "focused only on a small amount of behavior"。
      - FIRST 是個 acronym - First, Isolated, Repeatable, Self-validating, Timely
      - First - 會造成慢的原因，多半是跟外部環境相依，例如 database、file、network calls 等。
      - Isolated - 不只是 test case 可以單獨執行 (不受其他 test case 的影響)，也跟測試失敗時，能否立即反應出是哪裡出錯有關 (不用花時間找問題在哪裡)；這跟 "tests focused only on a small amount of behavior" 有關 => If one of your test methods can break for more than one reason, consider splitting it into separate tests，跟 Single Responsibility Principle (SRP) 的概念有點像。
      - Repeatable - 跟 "external environment not under your direct control" 隔離開來，若不得以要存取 database，可以考慮 in-memory database。
      - Self-validating - 測試過程中不需要人為介入。
      - Timely - 雖然可以在任何時候寫 unit test，但儘早做的好處多多。
  - Agile in a Flash: F.I.R.S.T (2009-02) http://agileinaflash.blogspot.tw/2009/02/first.html #ril

## Coverage

  - 從 coverage 來看哪些沒測試不一定準，因為程式有走過並不代表有做驗證，因為最好是根據 contract 來寫 test case。
  - Codecov https://codecov.io/ 有很多 opensource project 在用??
      - https://github.com/mockito/mockito/pull/286 Mockito

### Coverage 100% 的意義是什麼?

  - F.I.R.S.T Principles of Unit Testing · ghsukumar/SFDC_Best_Practices Wiki https://github.com/ghsukumar/SFDC_Best_Practices/wiki/F.I.R.S.T-Principles-of-Unit-Testing Thorough and Timely 提到 "Should cover every use case scenario and NOT just aim for 100% coverage." 但所有 use case scenario 都 cover 到的情況下，不也就 100% coverage 了?

## Testable

  - 所謂 testable 是指重新安排 (rearrange) code，使能分開測試 (in isolation)，但絕不是在 application 裡安插 test-specific code；但 `@VisibleForTesting` 在灰色地帶??
  - TDD: Testable is most important (2016-02-04) http://pietschsoft.com/post/2016/02/04/TDD-Testable-is-most-important #ril
  - Clean Coder Blog (2014-12-17) http://blog.cleancoder.com/uncle-bob/2014/12/17/TheCyclesOfTDD.html #ril
  - Guide: Writing Testable Code (2008-11-24) http://misko.hevery.com/code-reviewers-guide/ ([PDF](http://misko.hevery.com/attachments/Guide-Writing%20Testable%20Code.pdf)) #ril
  - Flaw: Digging into Collaborators http://misko.hevery.com/code-reviewers-guide/flaw-digging-into-collaborators/ #ril
  - Flaw: Class Does Too Much http://misko.hevery.com/code-reviewers-guide/flaw-class-does-too-much/ #ril

## Readability 可讀性

  - collections - How to convert an Array to a Set in Java - Stack Overflow http://stackoverflow.com/questions/3064423/ David Carboni: I'll take readability over efficiency (nearly) every time 就測試而言，確實是這樣!!
  - Flexible and expressive unit tests with the builder pattern https://www.kenneth-truyers.net/2013/07/15/flexible-and-expressive-unit-tests-with-the-builder-pattern/ 提到 unit test 同時也是文件，要能兼顧 expressive 跟 flexible 會更有價值，但這並不容易；builder pattern 可以幫上一些忙...
  - 要說可讀性，應該就是 BDD 了吧?? 倒也不是要導入什麼 framework，而是像 [這樣](https://github.com/googlesamples/android-architecture/blob/todo-mvp-clean/todoapp/app/src/test/java/com/example/android/architecture/blueprints/todoapp/tasks/TasksPresenterTest.java) 從註解裡下手也不錯 ...
  - Write Tests to be Read | Effective Java Testing (2008-12-09) https://effectivejavatesting.wordpress.com/2008/12/09/write-tests-to-be-read/ #ril

### Non-static nested class (inner class) 如何在測試時不管 enclosing class??

  - 以 `EnclosingClass` 底下的 `public class NonStaticNestedClass` 為例。
  - 利用 Mockito 生出一個假的 enclosing object，例如 `Mockito.mock(EnclosingClass.class).new NonStaticNestedClass(...)` 就可以了。

## Legacy Code & Refactoring

  - https://www.amazon.ca/Working-Effectively-Legacy-Michael-Feathers/dp/0131177052 我們用了 legacy code 這個 term 很久，卻沒有給它一個明確的定義。簡單地說 "Legacy code is code that we've gotten from someone else."，而 "code that you have to change but don't really understand" 就是程式設計師遇到 legacy code 的感覺。作者給 legacy code 下了一個絕妙的定義 "To me, legacy code is simply code without tests."，為什麼是 test? 因為 "Code without tests is bad code. It doesn't matter how well written it is; it doesn't matter how pretty or object-oriented or well-encapsulated it is. With tests, we can change the behavior of our code quickly and verifiably. Without them, we really don't know if our code is getting better or worse."
  - 為 legacy code 寫 unit test 似乎有些技巧
      - 回推為什麼要加這段 code，針對 why 去驗證
      - 從 caller 角度來想，目前是怎麼用它的，對外做了什麼承諾 (如果有 Javadoc 就好)
      - 從更高層次做起有點難? 或許先把要測的 behavior (test name) 全部列出來，再一一補齊，似乎是個不錯的折衷?
  - Legacy code - Wikipedia https://en.wikipedia.org/wiki/Legacy_code #ril
  - Guide to Freelancing: Starting Over vs Refactoring (2016-09-30) https://www.crondose.com/2016/09/starting-over-vs-refactoring/ #ril
  - Do You Write Legacy Code? | Hacker Boss http://hackerboss.com/legacy-code/ #ril
  - Adding unit tests to legacy code - Stack Overflow (2009-10-09) http://stackoverflow.com/questions/1541568/ - 很難，但值得做；從更高的層次做起 (safety net)，再做 refactoring 讓它變成 testable。
  - Refactoring Without Good Tests - Code Climate Blog (2013-12-05) http://blog.codeclimate.com/blog/2013/12/05/refactoring-without-good-tests/ 提到 "outside in" 的概念 (先聚焦在 interface，而非 impl.)，另外 fear of refactoring 會產生越來越多的技術債；建議先寫好 key user scenarios 的 automated acceptance test，再開始用測試驅動所有新的 code #ril

  - Living Dangerously: Refactoring without a Safety Net (2010-10-01) https://simpleprogrammer.com/2010/10/01/living-dangerously-refactoring-without-a-safety-net/ #ril
  - Unit Testing Legacy Code http://wiki.c2.com/?UnitTestingLegacyCode #ril
  - Reversed Tests Pyramid – dealing with legacy code (2012) http://xpdays.com.ua/archive/xp-days-ukraine-2012/materials/legacy-code/ #ril
  - How do you introduce unit testing into a large, legacy (C/C++) codebase? (2009-04-14) Stack Overflow http://stackoverflow.com/questions/748503/ #ril
  - https://en.wikipedia.org/wiki/Characterization_test 看起來像是 integration code 為了確保沒被 unit test 覆蓋到的部份，做為 extend/refactor code 的安全網 #ril
  - 如何面對與避免Legacy Code | iThome (2009-09-18) http://www.ithome.com.tw/node/57107 Legacy 和 Non-Legacy Code 區分的關鍵在測試 #ril
  - testing - Why write tests for code that I will refactor? - Software Engineering Stack Exchange https://softwareengineering.stackexchange.com/questions/233222/why-write-tests-for-code-that-i-will-refactor #ril
  - Practical refactoring using unit tests - Stack Overflow http://stackoverflow.com/questions/522334/ #ril

## Concurrency / Multithreading

## Fluent Assertion

  - AssertJ > Fest > Hamcrest (2014-10-20) https://www.javacodegeeks.com/2014/10/assertj-fest-hamcrest.html #ril

## One Assertion Per Test?

  - 所以什麼是 single concept? 實務上可以搭配 test method 的 naming - `action_Given_Then()` (例如 `addTask_DuplicateName_ShowError()`) 來做判斷，只要 verification 都在 then 的範圍下即可，因為 then 不會寫得太長，自然 verification 的範圍就會受到限制。
  - One Assertion Per Test Considered Ambiguous (2013-08-26) https://www.franzoni.eu/one-assertion-per-test-considered-ambiguous/ 解讀成只能用一次 `assert` method 是錯的，應說說是 Single Concept Per Test。

參考資料：

  - 關於傳說中的 One Assert Per Test，或許 Single Concept Per Test 是相對務實的 "I think the single assert rule is a good guideline. ... But I am not afraid to put more than one assert in a test. I think the best thing we can say is that the number of asserts in a test ought to be minimized. … Perhaps a better rule is that we want to test a single concept in each test function." -- Clean Code
  - should I worry about the unexpected? | monkey island https://monkeyisland.pl/2008/07/12/should-i-worry-about-the-unexpected/ 提到 "I really want to have small, separate test methods that are focused around behavior" 及 "small&focused test methods"
  - F.I.R.S.T Principles of Unit Testing · ghsukumar/SFDC_Best_Practices Wiki https://github.com/ghsukumar/SFDC_Best_Practices/wiki/F.I.R.S.T-Principles-of-Unit-Testing 在 Isolated/Independent 提到 "typically there should be only a single logical assert. A logical assert could have multiple physical asserts as long as all the asserts test the state of a single object." 這裡 "a single logical assert = multiple physical asserts" 的說法很不錯。

  - One Assertion Per Test (2004-02-23) http://www.artima.com/weblogs/viewpost.jsp?thread=35578 #ril
  - 忘了在哪裡寫下 "focused" 比 "single assertion" 更重要??
      - 幾個相關的 state 要一起驗證才對，例如 `select(item)` 後，`isSelected(item)` 跟 `getSelectedCount()` 都會跟著起變化。
  - Google Testing Blog: Testing on the Toilet: Writing Descriptive Test Names https://testing.googleblog.com/2014/10/testing-on-toilet-writing-descriptive.html 一開始的範例就用了 3 個 assertion，與其說是 single assertion，倒不如說是 single behavior?? "By giving tests more explicit names, it forces you to split up testing different behaviors into separate tests"
  - Programmatically Speaking – One assertion per test, please (2015-07-25) http://programmaticallyspeaking.com/one-assertion-per-test-please.html #ril
  - [Testing made sweet with a Mockito by Jeroen Mols \- YouTube](https://www.youtube.com/watch?v=DJDBl0vURD4) It is better to have a simple test that works than a complicated test that seems to work. (在 [Javadoc](https://static.javadoc.io/org.mockito/mockito-core/2.2.7/org/mockito/ArgumentMatcher.html) 裡)，呼應 conclusion 裡的 "keep unit tests small and focused"，要跟 production code 視為一樣重要，否則之後會咬你一口

## Overspecified (Over Specification)

  - Overspecified 跟 fragile 常常同時被提起，意思是稍微修改內部實作 (次數、順序)，就會造成 unit test 失敗
      - 覺得次數不做精確的檢查有點奇怪?? 不過順序倒是有許多情況下不用做檢查。
      - Fragile Test at XUnitPatterns.com http://xunitpatterns.com/Fragile%20Test.html 當我們不視為有 change 但卻會導致 test 失敗時，表示我們遇到了 fragile test #ril
  - 覺得用在 listener/callback 只有觸發某種狀況的檢查，`verifyNoMoreInteractions(mocks...)` 還滿重要的??
      - guava/FutureCallbackTest.java at master · google/guava https://github.com/google/guava/blob/master/guava-tests/test/com/google/common/util/concurrent/FutureCallbackTest.java 就是用在 callback 上
  - should I worry about the unexpected? | monkey island (2008-07-12) https://monkeyisland.pl/2008/07/12/should-i-worry-about-the-unexpected/ 找不到 worry about the unexpected 跟 test quality 有關的證明，所以就是要視情況 "write extra defensive tests only when it’s relevant"，這也就是為什麼 Mockito 預設不會檢查 unexpected interaction，要明確呼叫 `verifyZeroInteractions()` 或 `verifyNoMoreInteractions()`；最後作者與 Tom De Wolf 的討論極為重要，雙方都同意理想上 `verifyNoMoreInteractions()` 應該只檢查 tell method，但實作上有困難，言下之意是，對 tell method 做 unexpected interaction 的檢查是沒問題的，有問題的點是對 ask method 做這件事，其間引出了 is there a difference between asking and telling? | monkey island https://monkeyisland.pl/2008/04/26/asking-and-telling/ 這份文件
  - AimiaMobile/unit-testing-guidelines: Unit testing best practices https://github.com/AimiaMobile/unit-testing-guidelines#mocks-vs-stubs #ril
  - is there a difference between asking and telling? | monkey island (2008-04-26) https://monkeyisland.pl/2008/04/26/asking-and-telling/ #ril
  - Better support of strict mocks · Issue #649 · mockito/mockito https://github.com/mockito/mockito/issues/649 #ril

  - AimiaMobile/unit-testing-guidelines: Unit testing best practices https://github.com/AimiaMobile/unit-testing-guidelines 一些如何避開 over specification 的 guideline #ril
  - http://javadoc.io/page/org.mockito/mockito-core/latest/org/mockito/Mockito.html Mockito API 8. Finding redundant invocations 提到 `verifyNoMoreInteractions()` 要小心使用，避免 "overspecified, less maintainable tests" 的問題；習慣 expect-run-verify 做法的人，很容易過度使用 `verifyNoMoreInteractions()`；另外 `verifyZeroInteractions()` 應該也是相同的考量。
  - EasyMock Tests Are Usually Overspecified http://frequal.com/java/EasyMockTestOverspecification.html 因為 EasyMock 會記住 calls 的次數、順序，如果這些都不重要，可能稍微修改實作就會讓測試壞掉。但如何不做這樣的檢查??

  - Testing anti-patterns: Overspecification - jasonrudolph.com http://jasonrudolph.com/blog/2008/07/01/testing-anti-patterns-overspecification/ #ril

## Naming

  - Naming 很重要，如果可以簡單用幾個單字描述清楚 state under test 與 expected behavior，那麼 test code 就不會驗太多，讓 test case 保持專注 (focused)。

參考資料：

  - `unitUnderTest[_Condition[_ExpectedBehavior]]` 的命名似乎跟 When-Given-Then 有對應關係??
  - Google Testing Blog: Testing on the Toilet: Writing Descriptive Test Names (2014-10-16) https://testing.googleblog.com/2014/10/testing-on-toilet-writing-descriptive.html
      - 用什麼 naming pattern 都好，只要包含 scenario 跟 expected outcome 就好，也就是看得出在測試什麼、預期結果。
      - 沒提到的重點是，scenario 跟 expected outcome 儘可能用 business language 寫，隨著時間過去，從 test name 就能看出 spec。
  - Building Local Unit Tests | Android Developers https://developer.android.com/training/testing/unit-testing/local-unit-tests.html - 出現 `emailValidator_CorrectEmailSimple_ReturnsTrue()`、`readStringFromContext_LocalizedString()` 之類的用法，基本上是 `unitUnderTest[_Condition[_ExpectedBehavior]]`
  - Unit test naming best practices - Stack Overflow (2008-09-30) http://stackoverflow.com/questions/155436 推薦 Roy Osherove 的 naming strategy: `[UnitOfWork__StateUnderTest__ExpectedBehavior]`
  - Naming standards for unit tests - Blog - Osherove (2005-04-03) http://osherove.com/blog/2005/4/3/naming-standards-for-unit-tests.html #ril
  - AimiaMobile/unit-testing-guidelines: Unit testing best practices https://github.com/AimiaMobile/unit-testing-guidelines#unit-test-naming-conventions 這裡也採用 `[Method-Name][StateUnderTest][ExpectedBehaviour]`

  - Google Testing Blog: TotT: Naming Unit Tests Responsibly (2007-02-01) https://testing.googleblog.com/2007/02/tott-naming-unit-tests-responsibly.html
  - Writing Clean Tests – Naming Matters (2014-05-11) https://www.petrikainulainen.net/programming/testing/writing-clean-tests-naming-matters/ #ril
  - What are some popular naming conventions for Unit Tests? - Stack Overflow (2008-09-18) http://stackoverflow.com/questions/96297/
  - 可以一次把所有要測的狀況都列出來，預設 `Assert.fail()`，之後一個個補上，這樣就不會遺漏。

  - [`googlesamples/android-architecture`](https://github.com/googlesamples/android-architecture/)
      - https://github.com/googlesamples/android-architecture/blob/todo-mvp-clean/todoapp/app/src/test/java/com/example/android/architecture/blueprints/todoapp/tasks/TasksPresenterTest.java 看到許多 `clickOnTask_ShowsDetailUi()` 的命名，`_` 前是動作，`_` 後是預期結果。
      - 用來準備 pre-condition 的 method 取做 `givenXXX()` 也滿不錯的，例如 `givenTasksPresenter()`

## New

  - How to Think About the “new” Operator with Respect to Unit Testing (2008-07-08) http://misko.hevery.com/2008/07/08/how-to-think-about-the-new-operator/ 非 leaf node 要把 object construction 與 application logic 拆開才有辦法做 unit test (value object 不在此限)。

  - Flaw: Constructor does Real Work http://misko.hevery.com/code-reviewers-guide/flaw-constructor-does-real-work/ #ril
  - Where Have all the “new” Operators Gone? (2008-09-10) http://misko.hevery.com/2008/09/10/where-have-all-the-new-operators-gone/ #ril
  - My main() Method Is Better Than Yours (2008-08-29) http://misko.hevery.com/2008/08/29/my-main-method-is-better-than-yours/ #ril
  - Collaborator vs. the Factory (2009-03-30) http://misko.hevery.com/2009/03/30/collaborator-vs-the-factory/ #ril
  - Lazy loading 好像也有問題，因為會在 class under test 裡面做 new 的動作??

## Singleton

  - http://misko.hevery.com/code-reviewers-guide/flaw-brittle-global-state-singletons/ 提到 singleton 分為 GoF single 與 application singleton，前者透過 static instance field 來強制達成整個 JVM 裡就只能有一個 instance，但後者單指整個 application 裡只有一個 instance，它本身並沒有強制 singletonness。或許 JVM Global State 與 Application Shared State 這說法更容易識別。
  - 是 singleton 就算了，但全是 static method 的 class 又該怎麼看待?? 似乎比 singleton 更難處理... => utility class 也是 anti pattern
  - Golbal state 跟 singleton 的關係?? => 其實我們要的是 application shared state，而非 JVM global state
      - 從 http://misko.hevery.com/code-reviewers-guide/flaw-brittle-global-state-singletons/ 的 warning signs 看來，singleton 只是 global state 的一種，因為 global state 還有 static field/method、static initialization 等；或許 static global state 的說法會更為精確??
      - http://misko.hevery.com/code-reviewers-guide/flaw-brittle-global-state-singletons/ 裡的 "A Singleton is Global State in Sheep’s Clothing" 這個標題很傳神!!
  - Flaw: Brittle Global State & Singletons http://misko.hevery.com/code-reviewers-guide/flaw-brittle-global-state-singletons/ 提到好多東西!! "Spooky Action at a distance"、無法達到 test isolation (也就無法 parallel testing)、static state 是一種 "秘密通道" 要看過每一行 code 才能察覺，而 singleton 間接產生了 global state，是披著羊皮的狼，說明了 "JVM Global State" 與 "Application Shared State" 的差異 #ril

  - Clean Code Talks – Global State and Singletons (2008-09-13) http://misko.hevery.com/2008/11/21/clean-code-talks-global-state-and-singletons/ #ril
  - Why Singletons Are Controversial https://code.google.com/archive/p/google-singleton-detector/wikis/WhySingletonsAreControversial.wiki #ril
  - Root Cause of Singletons (2008-08-25) http://misko.hevery.com/2008/08/25/root-cause-of-singletons/ #ril
  - Where Have All the Singletons Gone? (2008-08-21) http://misko.hevery.com/2008/08/21/where-have-all-the-singletons-gone/ #ril
  - Singletons are Pathological Liars (2008-08-17) http://misko.hevery.com/2008/08/17/singletons-are-pathological-liars/ #ril
  - Flaw: Constructor does Real Work http://misko.hevery.com/code-reviewers-guide/flaw-constructor-does-real-work/ 原來在 constructor 裡做太多也會出事 #ril

## Public fields

  - Public fields 在測試上似乎也會形成阻礙?? 至少 mocking framework 無法 verify 對 field 的存取?? 但似乎很少人在談論這個?

## Private Method

## Static Method

  - 如果 3rd party lib 只有 static method 可用，怎麼辦? => 按照 "Don't mock types you don't own" 的原則，為它提供一層 wrapper；不過這跟是否為 static 沒有直接關係，而是處理 3rd party dependency 的通用方式。在 http://misko.hevery.com/code-reviewers-guide/flaw-brittle-global-state-singletons/ 也提到 "If you’re stuck with a library class’ static methods, wrap it ..."
  - Legacy code 很容易有 static method，如果要全改成 instance method，工程會太大
      - 以 Mockito + PowerMock 來說，一開始會覺得可以處理掉 static method dependency 很好用，但其實只是 "緩兵之計"，因為當你要測試 static method 所在的 class 時，還是會再遇到它自己的 dependency 要 mock 的問題...
  - 感覺 static method 也沒那麼糟，除非內部有些 dependencies 要在 unit test 時做 mock
  - Google Testing Blog: Static Methods are Death to Testability (2008-12-17) https://testing.googleblog.com/2008/12/static-methods-are-death-to-testability.html - 大體上 "leaf methods are ok to be static but other methods should not be" 是對的，只擔心某天 leaf method 不再是 leaf 而已；Static method 中尤以 factory methods 最糟，因為內部建立了 object graph。
  - FAQ · mockito/mockito Wiki https://github.com/mockito/mockito/wiki/FAQ#user-content-can-i-mock-static-methods 提到 "Mockito prefers object orientation and dependency injection over static, procedural code that is hard to understand & change"，如果面對的是 "scary legacy code"，請用 JMockit 或 PowerMock；但 static method 跟 procedural code 有關係??

### Legacy code 很容易有 static method，如果要全改成 instance method，工程會太大??

  - 以 Mockito + PowerMock 來說，一開始會覺得可以處理掉 static method dependency 很好用，但其實只是 "緩兵之計"，因為當你要測試 static method 所在的 class 時，還是會再遇到它自己的 dependency 要 mock 的問題...

## Test Doubles

  - Mocks And Stubs - Understanding Test Doubles With Mockito | JavaWorld http://www.javaworld.com/article/2074508/core-java/mocks-and-stubs---understanding-test-doubles-with-mockito.html (2011-11-25) 說明 test double 不同角色在 Mockito 上的實作 - dummy object、test stub、mock object、test spy
  - Testing with Doubles, or why Mocks are Stupid - Part 1 | End of Line Blog (2015-11-10) http://endoflineblog.com/testing-with-doubles-or-why-mocks-are-stupid-part-1 #ril
  - Testing with Doubles, or why Mocks are Stupid - Part 2 | End of Line Blog (2015-11-30) http://endoflineblog.com/testing-with-doubles-or-why-mocks-are-stupid-part-2 #ril
  - Testing with Doubles, or why Mocks are Stupid - Part 3 | End of Line Blog (2015-12-30) http://endoflineblog.com/testing-with-doubles-or-why-mocks-are-stupid-part-3 #ril
  - Testing with Doubles, or why Mocks are Stupid - Part 4 | End of Line Blog (2016-01-16) http://endoflineblog.com/testing-with-doubles-or-why-mocks-are-stupid-part-4 #ril
  - Test Double at XUnitPatterns.com http://xunitpatterns.com/Test%20Double.html #ril
  - Test Double · testdouble/contributing-tests Wiki https://github.com/testdouble/contributing-tests/wiki/Test-Double #ril

## Stubbing

  - Mocks Aren't Stubs (2007-01-02) https://martinfowler.com/articles/mocksArentStubs.html #ril
  - AimiaMobile/unit-testing-guidelines: Unit testing best practices https://github.com/AimiaMobile/unit-testing-guidelines#mocks-vs-stubs 提到 "Mocks are used for interaction testing" 與 "a stub can never fail a test" 的概念 #ril

## Don't mock type you don't own!

  - Don't mock type you don't own! - How to write good tests · mockito/mockito Wiki https://github.com/mockito/mockito/wiki/How-to-write-good-tests#dont-mock-type-you-dont-own - 對 3rd party lib 做 mocking/stubbing，換版時 unit test 過了，但實際上會爆。這通常意謂著沒有對 3rd party lib 做 loose decoupling，將 3rd party lib 的使用集中到少數 wrapper 裡，再對 wrapper 做 integration test - 搭配真正的 3rd party lib，若涉及 database 或 networking，就是 in-memory database、mock web server 這類 fake object 上場的時候。
  - Don't mock what you don't own · testdouble/contributing-tests Wiki https://github.com/testdouble/contributing-tests/wiki/Don't-mock-what-you-don't-own 使用 test double 的心態是要傾聽 "design feedback" 並根據它調整 design，若硬是對 3rd party dependency 做 mocking，會掉入 application logic 跟 3rd party lib 綁得太緊的問題。
  - TDD: Only mock types you own - Mark Needham at Mark Needham (2009-12-13) http://www.markhneedham.com/blog/2009/12/13/tdd-only-mock-types-you-own/ 對 3rd party lib 做 mocking，就是在檢查 "the WAY that the library achieves that result"，而 integration test 則是在檢查 "the result that we get from using the library"，後者才是最怕出錯的地方，就算 lib 不換版，平台也會隨著時間演進，可能原版本在新平台上會有問題...
  - 對 3rd party lib 提供另一層 wrapper，以 Java SDK 為例，提出 `JavaUtil.java` 是一個例子，可以提供 `JavaUtil.currentTimeMillis()` 之類的 method，這樣關於時間的測試就會比較好進行。 

  - Don't mock types you don't own - dave^2 = -1 (2011-04-28) http://www.davesquared.net/2011/04/dont-mock-types-you-dont-own.html #ril
  - That's Not Yours | 8th Light (2011-10-27) https://8thlight.com/blog/eric-smith/2011/10/27/thats-not-yours.html #ril
  - mocking - Should you only mock types you own? - Stack Overflow (2009-12-15) http://stackoverflow.com/questions/1906344/ #ril
  - testdouble.js/2-howto-purpose.md at master · testdouble/testdouble.js https://github.com/testdouble/testdouble.js/blob/master/docs/2-howto-purpose.md #ril

## Don't mock value objects

  - 很有趣的是，value object 通常沒有 interface，是否也是一個不適合做 mocking 的根據??
  - "Don't mock value objects" 適用 http://www.javaworld.com/article/2074508/core-java/mocks-and-stubs---understanding-test-doubles-with-mockito.html 這裡講到的 dummy object 嗎?? => 個人覺得 dummy object 是個例外，如果沒有任何 interaction 的話
  - Don't mock value objects - How to write good tests · mockito/mockito Wiki https://github.com/mockito/mockito/wiki/How-to-write-good-tests#dont-mock-value-objects 不好建立 test fixtures 不是藉口，可以建立 factory methods 讓 test code 維持 compact & readable。
  - To “new” or not to “new”… (2008-09-30) http://misko.hevery.com/2008/09/30/to-new-or-not-to-new/ 提到 newable 位處 object graph 的末端 (leaf)，只要沒有跟 external service (injectable) 互動，就不需做 mock。Nothing behaves more like a `String` like than a `String` ... 這句話說得真好!! (所謂 injectable 就是想要換成假的，所以 injectable 與否跟 mocking 是很有關係的)

## 不要將 test code 混入 production code

  - Don't mix test code with production code | 8th Light (2014-12-19) https://8thlight.com/blog/dariusz-pasciak/2014/12/19/dont-mix-test-code-with-production-code.html #ril
  - c# - Is it bad to add code just for unit testing? - Stack Overflow (2010-09-02) http://stackoverflow.com/questions/3629562/is-it-bad-to-add-code-just-for-unit-testing Jeff Sternal 提到專用於 unit test 的 code 通常帶有 design flaw #ril
  - c# - Is it a bad practice to modify code strictly for testing purposes - Software Engineering Stack Exchange (2013-05-22) http://softwareengineering.stackexchange.com/questions/199090/is-it-a-bad-practice-to-modify-code-strictly-for-testing-purposes #ril

## Verification / Assertion 驗證

### 如何驗證 data class 只有特定的 field / property 被異動??

  - 如果是要驗證某個 method 有被呼叫，Mockito 可以用 `verify(mock, only()).method()`，但 fields 怎麼檢查?
  - java - How do I assert equality on two classes without an equals method? - Stack Overflow http://stackoverflow.com/questions/12147297/ 若 class 沒有實作 `equals()`，要怎麼驗 equality? 多個 assert 逐 field / property 驗證會有失敗時看不到 "full equality picture" 的問題 #ril
  - ArgumentMatchers (Mockito 2.7.22 API) https://static.javadoc.io/org.mockito/mockito-core/2.7.22/org/mockito/ArgumentMatchers.html#refEq(T,%20java.lang.String...) `Mockito.refEq()`
  - Reflection Assert - Unitils http://www.unitils.org/tutorial-reflectionassert.html 似乎專門在處理這些事... #ril
  - Is there a Java reflection utility to do a deep comparison of two objects? - Stack Overflow http://stackoverflow.com/questions/1449001/ #ril

