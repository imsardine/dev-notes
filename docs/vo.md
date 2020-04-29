# Value Object

  - Value object 跟 DTO 有什麼不同? => 前者強調 "same value" 與 immutable，後者只應用在緩解 remote call 成本太高的問題，一次取回 server 端的資料。
  - Value object - Wikipedia https://en.wikipedia.org/wiki/Value_object Value Object 看的是 "same value" 而非 "same identity"，而且要是 immutable，由於 Java 不支援 custom value type，要遵循 VALJO (VALue Java Object) 的規則，頗為麻煩 ...
  - dddsample-core/ValueObject.java at master · citerus/dddsample-core https://github.com/citerus/dddsample-core/blob/master/src/main/java/se/citerus/dddsample/domain/shared/ValueObject.java 基本上 value object 是 serializable，唯一的方法 `boolean sameValueAs(T other)` 反應了 same value 的特性。

  - Domain-Driven Design and Spring http://static.olivergierke.de/lectures/ddd-and-spring/#ddd.building-blocks.entites-vs-value-objects 有討論到 Entities VS. Value objects，要依 context 判別，有時候可能兩者都是 #ril
  - ValueObject - Martin Fowler (2016-11-14) https://martinfowler.com/bliki/ValueObject.html #ril
  - Value Object http://wiki.c2.com/?ValueObject #ril
  - Value Objects Should Be Immutable http://wiki.c2.com/?ValueObjectsShouldBeImmutable #ril
  - Stephen Colebourne's blog: VALJOs - Value Java Objects (2014-03-21) http://blog.joda.org/2014/03/valjos-value-java-objects.html #ril
  - Java Practices -> Immutable objects http://www.javapractices.com/topic/TopicAction.do?Id=29 #ril
  - JEP 169: Value Objects http://openjdk.java.net/jeps/169 #ril
  - auto/value at master · google/auto https://github.com/google/auto/tree/master/value 這裡也提供 value object 是 immutable ??

## 可以有 behavior 嗎 ??

  - [Domain Driven Design and Development In Practice](https://www.infoq.com/articles/ddd-in-practice) Table 2. Domain elements with state and behavior 提到 value object 有 state & behavior，但 DTO 就只有 state。
  - [ValueObject](https://martinfowler.com/bliki/ValueObject.html) (2016-11-14) 作者以 `Range` 的 rich behaviour 為例，看來是可以的

