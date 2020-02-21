# Strategy Pattern

  - [Strategy pattern \- Wikipedia](https://en.wikipedia.org/wiki/Strategy_pattern) #ril

## 新手上路 {: #getting-started }

  - [Strategy Pattern \| Set 1 \(Introduction\) \- GeeksforGeeks](https://www.geeksforgeeks.org/strategy-pattern-set-1/)

      - As always we will learn this pattern by defining a problem and using strategy pattern to solve it. Suppose we are building a game “Street Fighter”. For simplicity assume that a character may have four moves that is kick, punch, roll and jump. Every character has kick and punch moves, but roll and jump are OPTIONAL.

      - How would you model your classes? Suppose initially you use inheritance and abstract out the common features in a `Fighter` class and let other characters subclass `Fighter` class.

        `Fighter` class will we have DEFAULT IMPLEMENTATION of normal actions. Any character with specialized move can override that action in its subclass. Class diagram would be as follows:

        ![](https://media.geeksforgeeks.org/wp-content/uploads/classinh.jpg)

      - What are the problems with above design?

        What if a character doesn’t perform jump move? It still inherits the jump behavior from superclass. Although you can override jump to DO NOTHING in that case but you may have to do so for many existing classes and take care of that for future classes too. This would also make maintenance difficult. So we can’t use inheritance here.

      - What about an Interface?

        Take a look at the following design:

        ![](https://media.geeksforgeeks.org/wp-content/uploads/classas.jpg)

        It’s much cleaner. We took out some actions (which some characters might not perform) out of `Fighter` class and made interfaces for them. That way only characters that are supposed to jump will implement the `JumpBehavior`.

      - 若改走 interface 呢? 把 `Fighter` class 裡的 optional move 提出來變成 interface，支援 roll 或 jump 的角色就可以實作 `RollBehavior`、`JumpBehavior`。這會衍生 code reuse 的問題，況且多數語言都不支援 multiple inheritance (實作可以留在 `Fighter`?)
      - Inheritance 跟 interface 都走不通，這便是 strategy pattern 要解決的問題；Wikipedia 的定義 -- In computer programming, the strategy pattern (also known as the policy pattern) is a software design pattern that enables an algorithm’s behavior to be SELECTED AT RUNTIME. The strategy pattern: defines a family of algorithms, makes the algorithms interchangeable within that family.” 簡單講，就是可以在 runtime 動態決定採用不同的實作。
      - 關鍵在 rely on COMPOSITION instead of INHERITANCE for reuse，`Context` 並不直接提供實作，而是交付 (delegate) 給 `Strategy` interface 背後不同的實作 -- The context would be the class that would REQUIRE CHANGING BEHAVIORS，結果就是 `Strategy` is implemented as INTERFACE so that we can change behavior without affecting our context.
      - 優點有：
          - A family of algorithms can be defined AS A CLASS HIERARCHY (自成一個體系) and can be used interchangeably to alter application behavior without changing its ARCHITECTURE (也就是上面的 context).
          - By encapsulating the algorithm separately, NEW ALGORITHMS complying with the same interface can be easily introduced.
          - The application can switch strategies at run-time.
          - Strategy enables the clients (也就是 context/architecture) to choose the required algorithm, without using a “switch” statement or a series of “if-else” statements. 顯然，一連串的 switch/if-else 就是套用 strategy pattern 的提示
          - Data structures used for implementing the algorithm are completely encapsulated in `Strategy` classes. Therefore, the implementation of an algorithm can be changed without affecting the `Context` class. 達到 loose coupling!
      - 缺點有：
          - The application must BE AWARE OF ALL THE STRATEGIES to select the right one for the right situation. 自動 discover 或被動 register 有機會??
          - `Context` and the `Strategy` classes normally communicate through the interface specified by the abstract `Strategy` base class. `Strategy` base class must expose interface for all the required behaviours, which some concrete `Strategy` classes might not implement. 拆成多個不同的 strategy 即可? 例如 Set 2 實作篇的 `KickBehavior` 與 `JumpBehavior`?
          - In most cases, the application configures the `Context` with the required `Strategy` object. Therefore, the application needs to create and maintain two objects in place of one. 這應該不算缺點。

  - [Strategy Pattern \| Set 2 \(Implementation\) \- GeeksforGeeks](https://www.geeksforgeeks.org/strategy-pattern-set-2/) #ril
