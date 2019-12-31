---
title: UML / Class Diagram
---
# [UML](uml.md) / Class Diagram

  - Allen Holub: Training/Consulting/Programming: Agile, Architecture, Swift, Java http://www.holub.com/goodies/uml/#composition 各種案例的圖形 #ril
  - 在何在 class diagram 表示 interface?? => 用 stereotype? 若圖表中沒有 realization/implementation，看不出誰是 interface。
  - [Class diagram - Wikipedia, the free encyclopedia](http://en.wikipedia.org/wiki/Class_diagram) 說明 class 的表示法 (切成三塊)、如何表示 visibility 與 scope。解釋了一些 relationship，最常用的是 dependency、generalization/inheritance、realization/implementation，至於 association、aggregation、composition 則還沒有搞懂?? #ril
  - 某個 dependency 由 constructor 注入時，肯定會在內部保留 reference，這樣要用 dependency 或 association 來表示?
      - 按 https://en.wikipedia.org/wiki/Class_diagram 的說法，dependency 同時出現在 instance-level relationship 與 general relationship 裡，前者用在 dependency 由 constructor 注入時，內部會持有 dependency 的 refenece，也就是一種 association (實線)，通常會標上 `<<use>>`；後者 dependency 由 method parameter 傳入，只是短暫用到，就是單純的 dependency (虛線)。
      - DependencyAndAssociation - Martin Fowler https://martinfowler.com/bliki/DependencyAndAssociation.html 提到 association 隱含有 dependency 的意思 - if there is an association between two classes, there is also a dependency。事實上，UML 線條的畫法完全一樣，只差 dependency 可以加上 `<<use>>` 而已 (雖然大部份時候都不必要)

  - Association、aggregation、composition 的差別??
      - uml - Difference between association, aggregation and composition - Stack Overflow http://stackoverflow.com/questions/885937/ 有用到就算一種 association，如果概念上有 "has" 的味道，就是 aggregration 或 composition，兩者的差異在於 composition 裡 owned object 無法獨立於 owing object 存在，但 aggregation 可以。
      - design - What is the difference between aggregation, composition and dependency? - Stack Overflow http://stackoverflow.com/questions/1644273/ #ril
      - Java Concepts & Interview Questions with Answers: Difference between Association, Aggregation & Composition for Java / UML (2011-08-22) http://www.javabench.in/2011/08/difference-between-association.html #ril
      - Understanding Association, Aggregation, and Composition - CodeProject (2012-03-15) https://www.codeproject.com/Articles/330447/Understanding-Association-Aggregation-and-Composit #ril
      - What is the difference between Association, Aggregation, and Composition? - Introduction to Object Oriented Programming Concepts (OOP) and More - CodeProject https://www.codeproject.com/articles/22769/introduction-to-object-oriented-programming-concep#Composition #ril

  - [UML basics: The class diagram](http://www.ibm.com/developerworks/rational/library/content/RationalEdge/sep04/bell/) (2004-09-15) #ril
  - BallAndSocket - Martin Fowler (2005-02-03) https://martinfowler.com/bliki/BallAndSocket.html UML 2 開始支援用一個小圓 (`o`) 來表示 interface #ril


## 參考資料 {: #reference }

  - [UML Class Diagrams Reference](https://www.uml-diagrams.org/class-reference.html)
