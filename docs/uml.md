# UML

## Logical View??

  - [Sequence diagram \- Wikipedia](https://en.wikipedia.org/wiki/Sequence_diagram) 提到 "Sequence diagrams are typically associated with use case realizations in the Logical View of the system under development."。
  - [UML : The 4\+1 View of a System \| scottaltham\.com](https://scottaltham.com/2009/10/26/uml-unified-modeling-language-intro/) 系統架構可以從 5 個面向來考量，包括 logical view、process view、physical view、developement view 與 use case view。其中 logical view 的解釋是 "The logical objects (parts) of the system."。

## 新手上路 ?? {: #getting-started }

  - 有幾種圖形? 分別用在什麼場合??
      - Use Case、Class、Package、Object、Sequence、Collaboration、State、Activity、Component、Deployment
      - Use Case Diagram 到底有什麼用??
      - 好像只剩 Class、Object、Sequence、State、Activity 有用? 其中 Class 跟 Object diagram 有何不同??

  - 可以將文字轉成圖表最好；目前以 PlantUML 的支援最完整，可惜不像 yUML 或 WebSequenceDiagrams 支援手繪風。
      - 用文字的好處是可以來回修改設計，不用等 test code 的 design feedback，尤其適用設計初期。
  - 多數輕量化的工具不支援所有類型的圖表，只要關鍵的 class diagram、sequence diagram 有支援就夠了。
  - 一張 class diagram 看要溝通什麼，只會將相關的 class 拉進來，也只會揭露必要的結節。呼應 DependencyAndAssociation - Martin Fowler (2013-09-17) https://martinfowler.com/bliki/DependencyAndAssociation.html 所說的 "You need to be very selective and show only those that are important to whatever it is you are communicating"。

## 參考資料 {: #reference }

更多：

  - [Class Diagram](uml-class-diagram.md)
  - [State Diagram](uml-state-diagram.md)

相關：

  - [PlantUML](plantuml.md)
