# Builder Pattern

  - [Builder pattern \- Wikipedia](https://en.wikipedia.org/wiki/Builder_pattern) #ril
  - [Too Many Parameters in Java Methods, Part 3: Builder Pattern \- DZone Java](https://dzone.com/articles/too-many-parameters-java-1) (2013-10-18) #ril

## Testing ??

  - 為了避免使用者相依 builder 裡的預設值，或許在 build 的當下，沒給值的部份以亂數產生，可以有效揭露這類不當的假設?
  - Modification method 的命名跟型態可以跟目標 type 脫勾，只要考慮 building expression 的可讀性即可，例如 `XXXBuilder().ver(...).at(...).build()` 對應到 `version`、`time` 等。
  - Builder 也可以提高 test fixture 的可讀性 (甚至比在 production code 中更為常用) - 更為 expressive、clearer intent，可以清楚表達哪些 data 跟特定測試有關。
  - 專為 test code 寫的 builder 放 test project，一開始放在 test class 裡，有共用的話可以擺在最相關的 test class，其他 test class 直接引用沒關係，露在外面反而難管理；例如為 `MyObject` 寫了 `MyObjectBuilder`，就擺在 `MyObjectTest.MyObjectBuilder`，或許本來就有個 `MyObject.Builder` 但不符合測試的需求，剛好可以區分開來。
  - Too Many Parameters in Java Methods, Part 3: Builder Pattern | JavaWorld http://www.javaworld.com/article/2074938/core-java/too-many-parameters-in-java-methods-part-3-builder-pattern.html 提到必要的參數設計成 builder 的 constructor parameter 的做法，並不適用於 testing，因為再怎麼樣 private field 都有辦法生出預設值 (只要處理沒有指定時會造成 exception 的部份) 這就是 builder 用在 test code 上的特性，而且無論預設值是不是測試要的，只要會影響到就要明確寫出來，如此說來就算 production code 有提供 builder，很有可能因為不符合測試需求而要在 test project 另外寫一個。
  - Test code 用的 builder 其 constructor 都是沒有參數的，若沒有再呼叫其他 modification method，就像是 dummy object，就是型態符合而已；就像 http://www.javaworld.com/article/2074508/core-java/mocks-and-stubs---understanding-test-doubles-with-mockito.html 這裡說的一樣，並不在乎它的內容，因為不在乎內容，所以 test code 不用呼叫任何 modification method；會不會提供一個 `public static XXX newInstance()` 比較方便? => 後來發展出了 `instance()`、`instances()`、`instancesWithId()` 很實用
  - 發現 `XXXBuilder` 額外提供 3 個 static method 很實用 - `instance()`、`instances(int count)` 與 `instancesWithId(String... ids)`，前面 2 個快速產生多個 dummy instance，後者則帶有 ID，回傳值的型態建議用 `XXX[]` (array)，方便與 varargs 搭配使用，而且 `instances[0]` (array) 也比 `instances.get(0)` (list) 來得簡潔。
  - How to write good tests · mockito/mockito Wiki https://github.com/mockito/mockito/wiki/How-to-write-good-tests#dont-mock-value-objects Don't mock value objects 提到 "Because instantiating the object is too painful !?" 不是理由，方法之一就是為 value object 建立 builder。
  - Flexible and expressive unit tests with the builder pattern (2013-07-15) https://www.kenneth-truyers.net/2013/07/15/flexible-and-expressive-unit-tests-with-the-builder-pattern/ Unit test 同時也是 document，但 expressive 會是重點，基本上 production code 要求 encapsulation，與 test code 要求 expose unit 使能夠 test it in isolation 是有點衝突，所以用 builder pattern 使 test code 能以 expressive/flexible 的方式接上 test code (builder 放 test project)；越是 flexible (主要是跟 constructor 脫勾)，test code 修改的機會越少，當 unit test 指出一個錯誤時，錯在  production code 的機會也越高。(C#)
  - Builder Pattern: Good for code, great for tests (2013-06-06) https://www.javacodegeeks.com/2013/06/builder-pattern-good-for-code-great-for-tests.html 作者發現在 test code 裡 builder patter 更為實用，強調了 builder 之於 immutable class 的好處，另外澄清了 default value 只是為了避免 exception (一開始都設為 `null`?)，強調 "Only specify values that are actually relevant to your test"，即便 default value 剛好是 test code 需要的，也要明確寫出來。(Java)
  - 'Enclosed' test runner example · junit-team/junit4 Wiki https://github.com/junit-team/junit4/wiki/%27Enclosed%27-test-runner-example 剛好有 (Java) build pattern 同時用在 production code 及 test code 的例子。
  - Mistaeks I Hav Made: Test Data Builders: an alternative to the Object Mother pattern (2007-08-27) http://www.natpryce.com/articles/000714.html #ril
  - Friendly Tester: An Introduction To The Data Builder Pattern (2015-06) http://www.thefriendlytester.co.uk/2015/06/an-introduction-to-data-builder-pattern.html 竟有 "Test Data Builder Pattern" 這種說法? #ril
  - Consider a Builder for Test Data | Effective Java Testing (2008-12-15) https://effectivejavatesting.wordpress.com/2008/12/15/consider-a-builder-for-test-data/ #ril

  - Shaun Abram » Code Camp: Building Better Tests in Java http://www.shaunabram.com/code-camp-building-better-tests-in-java/ [Builder Pattern: Good for code, great for tests](https://www.javacodegeeks.com/2013/06/builder-pattern-good-for-code-great-for-tests.html) 的作者就是受到這個 talk 的啟發 #ril

## Python

  - [Builder pattern equivalent in Python \- Stack Overflow](https://stackoverflow.com/questions/11977279/) #ril

