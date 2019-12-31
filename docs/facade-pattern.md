# Facade Pattern

  - [Facade pattern \- Wikipedia](https://en.wikipedia.org/wiki/Facade_pattern) #ril
  - [Best Practice Software Engineering \- Facade](http://best-practice-software-engineering.ifs.tuwien.ac.at/patterns/facade.html) #ril
  - [Façade Design Pattern – Design Standpoint \- DZone Java](https://dzone.com/articles/fa%C3%A7ade-design-pattern-%E2%80%93-design) (2012-12-06) #ril
  - [Facade Design Pattern Example \| Java Code Geeks \- 2018](https://www.javacodegeeks.com/2015/09/facade-design-pattern.html) (2015-09-30) #ril
  - [façade Pronunciation in English](https://dictionary.cambridge.org/pronunciation/english/facade) 唸做 fer-sa-de
  - [facade \| meaning of facade in Longman Dictionary of Contemporary English \| LDOCE](https://www.ldoceonline.com/dictionary/facade) 唸做 "fəˈsɑːd"，意思是建築物的 "正面"

## 基礎

### Workflow, Use Case, Security, Transaction Demarcation ??

  - [Core J2EE Patterns \- Session Facade](http://www.oracle.com/technetwork/java/sessionfacade-141285.html) #ril
      - Centralizes Security Management: 由於 facade 面對 client，對外提供 coarse-grained access -- 數量較少 (相較於背後 business components 提供的 fine-grained control points)，在這一層管理 security policies 相對容易。
      - Centralizes Transaction Control: 由於 facade 包裝不同 use case 的 workflow (全有全無的單位)，跟 centralized security 一樣是 coarse-grained access 的考量，在這一層做 transaction management/demarcation 更合乎邏輯。
  - [Domain Driven Design and Development In Practice](https://www.infoq.com/articles/ddd-in-practice) #ril
      - Table 1. Security Concerns in Various Application Layers 提到 facade 要負責 "Role based authorization"。

### Remote Facade ??

  - [P of EAA: Data Transfer Object](https://martinfowler.com/eaaCatalog/dataTransferObject.html) 面對 Remote Facade 這類的 remote interface 時，要減少 call 的數量，因為 call 的成本不低，也就是 call 要回傳更多/夠用的資料。

### Facade 的 Output 是 DTO ??

  - 若吐出 JSON 結構是不是個選項? 搭配 GraphQL 甚至可以只拿必要的資料項??
  - [java \- Data Transfer Object DTO Where to build \- Stack Overflow](https://stackoverflow.com/questions/43319743/) #ril
  - [JPA implementation patterns: Service Facades and Data Transfers Objects — Xebia Blog](https://xebia.com/blog/jpa-implementation-patterns-service-facades-and-data-transfers-objects/) (2009-05-11) #ril

