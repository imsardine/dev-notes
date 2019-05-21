# Dependency Injection (DI)

  - To “new” or not to “new”… (2008-09-30) http://misko.hevery.com/2008/09/30/to-new-or-not-to-new/ 區分 injectable 跟 newable，遵守 injectable 不透過 constructor 要求 newable，或是 newable 不透過 constructor 要求 injectable，就可以讓程式好測試
  - When to inject: the distinction between newables and injectables - Invisible to the eye (2009-07-29) http://www.giorgiosironi.com/2009/07/when-to-inject-distinction-between.html 有看過 `Mail` 會自己送信的嗎? 就算透過 factory 成功將 `MailService` 注入，還是會有一些問題，其中 serialization/deserialization 的觀點尤其特別；因為 entity 因為 stateful 所以是 newable，而 service 因為 stateless 所以是 injectable，掌握 "service 可以相依 entity，但反過來不行" 的原則，從 `$mail = new Mail($this._service, $title, $text); $mail->send();` 演變成 `$mail = new Mail($title, $text); $this->_service->send($mail);`
  - Never write the same code twice: Dependency Injection - Invisible to the eye (2009-07-28) http://www.giorgiosironi.com/2009/07/never-write-same-code-twice-dependency.html #ril
  - Domain-Driven Design and Spring http://static.olivergierke.de/lectures/ddd-and-spring/#ddd.spring 提到 entity 跟 value object 都是 newable。
  - Breaking the Law of Demeter is Like Looking for a Needle in the Haystack (2008-07-18) http://misko.hevery.com/2008/07/18/breaking-the-law-of-demeter-is-like-looking-for-a-needle-in-the-haystack/ 注入 A，再從 A 取得 B 是不好的 #ril
  - Inversion of Control Containers and the Dependency Injection pattern https://www.martinfowler.com/articles/injection.html DI 的 Class Diagram #ril
  - Dependency Injection Myth: Reference Passing (2008-10-21) http://misko.hevery.com/2008/10/21/dependency-injection-myth-reference-passing/ 只要求自己會用到的 dependency，若是要求 A 再拿到 B，應該要直接要求 B；但 injectable factory 是個例外嗎?? #ril
  - Application Wiring on Auto-Pilot (2008-09-24) http://misko.hevery.com/2008/09/24/application-wiring-on-auto-pilot/ #ril
  - Dagger ‡ A fast dependency injector for Android and Java. https://google.github.io/dagger/android.html 提到 "a class shouldn’t know anything about how it isinjected" 的原則?? #ril

  - Dependency injection - Wikipedia https://en.wikipedia.org/wiki/Dependency_injection #ril
  - Understanding Dependencies http://tutorials.jenkov.com/ood/understanding-dependencies.html #ril

  - Circular Dependency in constructors and Dependency Injection http://misko.hevery.com/2008/08/01/circular-dependency-in-constructors-and-dependency-injection/ #ril

## DI 與 IoC 的差別??

  - Dependency Injection (DI) vs. Inversion of Control (IOC) - CodeProject https://www.codeproject.com/Articles/592372/Dependency-Injection-DI-vs-Inversion-of-Control-IO 提到 DI 是 IoC 的子集 (subtype) #ril

## Setter injection 有什麼不好??

  - Constructor Injection vs. Setter Injection (2009-02-19) http://misko.hevery.com/2009/02/19/constructor-injection-vs-setter-injection/ 一開始可能會覺得 setter injection 比較好，尤其測試期間可以透過 setter 換成 test doubles。但 constructor injection 可以要求 initialization 的順序 (做為別人的 collaborator，自己要先完成 initialization)、可以避免 circular dependencies、可以將 collaborator field 設為 `final` 幫助理解它在 (object) lifetime 都不會變。反過來說，這就是 setter injection 的問題；setter injection 容易忘記呼叫 setter，什麼時候 wiring 才算完成也不清楚 (最後一個 setter call?)
  - Repeat After Me: Setter Injection is a Symptom of Design Problems - DZone Java (2012-06-15) https://dzone.com/articles/repeat-after-me-setter 如果發現 constructor injection 用起來不順手，通常反應了 design 上的問題；若真的遇到無法使用 constructor injection 的情境 (不是 design problem)，可以把 setter injection 當做是個 workaround。
  - java - Why use constructor over setter injection in CDI? - Stack Overflow http://stackoverflow.com/questions/19381846/ #ril

## 代表目前使用者的 `User` 適合用 injection 注入嗎??

  - 總覺得 current user 與 database 裡的那個 user entity 是不同的?? 在 Android 上似乎不用規劃出一個 request scope，因為只有一個 user。
  - To “new” or not to “new”… http://misko.hevery.com/2008/09/30/to-new-or-not-to-new/ 提到 newable (也就是 value object) 不適合由 injection framework 提供，但 user 算是 value object 嗎?? 或更精確地說是 "current user"
  - Dependency injection with Dagger 2 - Custom scopes – froger_mcs dev blog – Coding with love http://frogermcs.github.io/dependency-injection-with-dagger-2-custom-scopes/ 提到 `@UserScope`，從系統架構來看，可以更方便取得 `User` instance 而不用透過 intent 傳遞，需要用到 user data 的人也可以直接從 constructor 要求 `User`。
  - User object 似乎是個很特別的應用，像是個 configuration??
      - Java dependency injection: Injecting domain objects instead of infrastructure components (2014-11-10) http://www.mscharhag.com/java/dependency-injection-domain-objects 利用 scope 將 `User` domain object 直接注入；這和 Law of Demeter 多少有點關係 #ril
      - The Future of Dependency Injection with Dagger 2 - YouTube (2016-01-04) https://www.youtube.com/watch?v=plK0zyRLIP8 13:00 `TwitterModule` 的例子很有趣，因為需要一個 user name，所以要有一個明確的 constructor，這是把 (external) state 注入 graph 的方式。30:50 也提到定位在 `@User` scope 的 `TwitterComponent`，可以在使用者登出時整個丟棄 (GC)，待下一個使用者登入時建立另一個 `TwitterComponent`。
      - Dependency injection with Dagger 2 - Custom scopes – froger_mcs dev blog – Coding with love (2015-07-01) http://frogermcs.github.io/dependency-injection-with-dagger-2-custom-scopes/ 在 application scope (`@Singleton`) 與 activity scope (`@ActivityScope`) 中間增加一層 user scope (`@UserScope`)，方便直接從 constructor 注入 `User`。

## Assisted Injection

  - To “new” or not to “new”… (2008-09-30) http://misko.hevery.com/2008/09/30/to-new-or-not-to-new/ 提到 injectable 不透過 constructor 要求 newable，因為 DI framework 不知道要怎麼注入 (這跟好不好測無關)；但為什麼不是想辦法提供?? 因為這樣的需求確實存在
  - http://stackoverflow.com/questions/37516736/ (2016-05-30) 討論到 "injectable factory" 及 "assisted injection"
  - AssistedInject · google/guice Wiki https://github.com/google/guice/wiki/AssistedInject #ril
  - Design for Testability and “Domain-Driven Design” http://misko.hevery.com/2009/03/16/design-for-testability-and-domain-driven-design/ 很明顯你不能說 `injector.getInstance(CreditCard.class)`，這是分辨 newable 與 injectable 的好方法，雖然 `injector.getInstance(HibernateSession.class).get(CreditCard.class, 123)` 這麼說也行，但中間透過 factory 又不算是 "fully injectable"。

