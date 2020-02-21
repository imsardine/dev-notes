# Repository Pattern

  - [P of EAA: Repository](https://martinfowler.com/eaaCatalog/repository.html)

      - Mediates between the domain and data mapping layers using a COLLECTION-LIKE INTERFACE for accessing domain objects.

        For a full description see P of EAA page 322

        ![](https://martinfowler.com/eaaCatalog/repositorySketch.gif)

        重點是用起來像個 (in-memory) collection；雖然這個 sequence diagram 只強調了 query construction，但還是有提到 add/remove。

      - A system with a complex domain model often benefits from a LAYER, such as the one provided by Data Mapper (165), that isolates domain objects from details of the database access code.

        In such systems it can be worthwhile to build another layer of abstraction over the mapping layer where QUERY CONSTRUCTION CODE is concentrated. This becomes more important when there are a large number of domain classes or heavy querying. In these cases particularly, adding this layer helps MINIMIZE DUPLICATE QUERY LOGIC.

        這裡的 data mapper 指的就是 ORM/DAL，在 domain model 與 ORM 之間，可以再隔一層 repository，對外除了 query logic 還有 add & remove，內部會轉化成 ORM 的操作。

      - A Repository mediates between the domain and data mapping layers, acting like an IN-MEMORY DOMAIN OBJECT COLLECTION. Client objects construct QUERY SPECIFICATIONS DECLARATIVELY and submit them to Repository for satisfaction. Objects can be added to and removed from the Repository, as they can from a simple collection of objects, and the mapping code encapsulated by the Repository will carry out the appropriate operations behind the scenes.

        上圖中的 criteria 或這裡的 (declarative) specification 並非必要，但確實可以讓 query method 的數量變少。

      - Conceptually, a Repository encapsulates the set of objects persisted in a data store and the operations performed over them, providing a MORE OBJECT-ORIENTED VIEW of the persistence layer. Repository also supports the objective of achieving a clean separation and ONE-WAY DEPENDENCY between the domain and data mapping layers.

        也就是說，用了 repository pattern，就沒有理由讓 domain 接觸到 ORM。

  - [The Repository Pattern \| Microsoft Docs](https://docs.microsoft.com/en-us/previous-versions/msp-n-p/ff649690(v=pandp.10)) (2010-04-27) #ril

  - [Using the Repository Pattern \| Building RESTful Web Services Workshop 17 \- YouTube](https://www.youtube.com/watch?v=tUuBMifqFAg) #ril

### 有 ORM 為什麼還要有 Repository ??

  - [Repository pattern, done right – jgauffin's coding den](http://blog.gauffin.org/2013/01/repository-pattern-done-right/) (2013-01-11) #ril

      - The repository pattern has been discussed a lot lately. Especially about it’s usefulness since the introduction of OR/M libraries. 有了 ORM，還需要 repository 嗎??
      - Let’s start with the [definition](http://martinfowler.com/eaaCatalog/repository.html):

        > A Repository mediates between the domain and data mapping layers (指的正是 ORM), acting like an IN-MEMORY DOMAIN OBJECT COLLECTION. Client objects construct QUERY SPECIFICATIONS DECLARATIVELY and submit them to Repository for satisfaction. Objects can be added to and removed from the Repository, as they can from a simple collection of objects, and the mapping code encapsulated by the Repository will carry out the appropriate operations behind the scenes

      - The repository pattern is an ABSTRACTION. It’s purpose is to reduce complexity and make the rest of the code PERSISTENT IGNORANT. As a bonus it allows you to write unit tests instead of integration tests. The problem is that many developers fail to understand the patterns purpose and create repositories which LEAK PERSISTENCE SPECIFIC INFORMATION up to the caller (typically by exposing `IQueryable<T>`).

        By doing so they get no benefit over using the OR/M directly.

    Repositories is about being able to switch DAL implementation

      - Using repositories is not about being able to switch persistence technology (i.e. changing database or using a web service etc instead). Repository pattern do allow you to do that, but it’s not the main purpose.
      - A more realistic approach is that you in `UserRepository.GetUsersGroupOnSomeComplexQuery()` uses ADO.NET directly while you in `UserRepository.Create()` uses Entity Framework. By doing so you are probably saving a lot of time instead of struggling with LinqToSql to get your complex query running.

    Unit testing

      - When people talks about Repository pattern and unit tests they are not saying that the pattern allows you to use unit tests for the data access layer. What they mean is that it allows you to unit test the business layer. It’s possible as you can fake the repository (which is a lot easier than faking nhibernate/EF interfaces) and by doing so write clean and readable tests for your business logic.
      - As you’ve separated business from data you can also write integration tests for your data layer to make sure that the layer works with your current database schema.
      - If you use ORM/LINQ in your business logic you can never be sure why the tests fail. It can be because your LINQ query is incorrect, because your business logic is not correct or because the ORM mapping is incorrect.
      - If you have mixed them and fake the ORM interfaces you can’t be sure either. Because Linq to Objects do not work in the same way as Linq to SQL.
      - Repository pattern reduces the complexity in your tests and allow you to specialize your tests for the current layer

  - [Design patterns that I often avoid: Repository pattern \| InfoWorld](https://www.infoworld.com/article/3117713/application-development/design-patterns-that-i-often-avoid-repository-pattern.html) (2016-09-08) #ril

### 跟 DAO 的不同 ??

  - 關鍵在 repository = collection of domain objects，所以 CURD 中的 Create 跟 Delete 會對應到 collection 的操作，而 Update 本來就會透過 domain object 本身，所以剩下的就是 Read，呼應了 repository 用來封裝 query logic 的說法。

參考資料：

  - [4 Common Mistakes with the Repository Pattern \- Programming with Mosh](https://programmingwithmosh.com/entity-framework/common-mistakes-with-the-repository-pattern/) (2017-04-03)
      - One repository per domain: 一個 domain class 對應一個 repository。
      - Repositories that return view models/DTOs: 由於 repository = a collection of domain objects，很明顯 mapping 並不是 repository 的責任 (將 domain object 轉成 view model 或 DTO 而言) -- 那是 client code 的責任。

      - Save/Update method in repositories: 由於 repository 是個 collection，不會有 `save()`/`update()`；後段 "sometimes as part of a transaction you may work with multiple repositories" 的說法不太懂，不過 `save()` 確實給人有 persistence 的錯覺，這裡 `unitOfWork.Complete()` 的寫法還滿通用的 #ril

        Update 就找 domain object，不該在 repository 上。

      - Repositories that return IQueryable: 重申 repository 的目的是 "encapsulate fat queries ... the chances of you repeating a fat query in multiple places increases"，要像是個 collection of domain objects，所以要傳回 `IEnumerable` 而非 `IQueryable`；這應該是 .NET 特有的問題?
  - [Sapiensworks \| Repository vs DAO](https://blog.sapiensworks.com/post/2012/11/01/Repository-vs-DAO.aspx) (2012-11-01) #ril
  - [hibernate \- What is the difference between DAO and Repository patterns? \- Stack Overflow](https://stackoverflow.com/questions/8550124/) #ril
  - [Repository Design Pattern in Swift – Frederik Jacques – Medium](https://medium.com/@frederikjacques/repository-design-pattern-in-swift-952061485aa) (2017-09-30) 把 CRUD 加入 reposotiry? #ril

## 基礎

### Specification ??

### Unit of Work ??

  - [CRUD Operations Using the Generic Repository Pattern and Unit of Work in MVC \- CodeProject](https://www.codeproject.com/Articles/814768/CRUD-Operations-Using-the-Generic-Repository-Patte) (2014-12-24) #ril

### Caching ??

  - [The Repository Pattern \| Microsoft Docs](https://docs.microsoft.com/en-us/previous-versions/msp-n-p/ff649690(v=pandp.10)) (2010-04-27)
      - You want to implement and centralize a CACHING STRATEGY for the data source.
      - Implementation Details > Web Service Repositories 提到 Note that services are often expensive to invoke and BENEFIT FROM CACHING STRATEGIES that are implemented within the repository. ... In this case, the query logic in the repository first checks to see whether the queried items are in the cache. If they are not, the repository accesses the Web service to retrieve the information.
      - Considerations 提到 synchronization 的問題 When caching data in a multithreaded environment, consider synchronizing access to the cache in addition to the cached objects. ... If you are caching data in heavily loaded systems, performance can be an issue. Consider synchronizing access to the data source. This ensures that only a single request for the data is issued to the list or back-end service. 對 heavily loaded systems 而言，repository 的這層 caching 尤其重要，但要注意 synchronization 的問題。

### Unit Testing ??

  - [The Repository Pattern \| Microsoft Docs](https://docs.microsoft.com/en-us/previous-versions/msp-n-p/ff649690(v=pandp.10)) (2010-04-27)
      - You want to maximize the amount of code that can be tested with automation and to ISOLATE THE DATA LAYER TO SUPPORT UNIT TESTING.
      - Implementation Details > Web Service Repositories 提到 A repository centralizes the access logic for a service and provides a SUBSTITUTION POINT FOR UNIT TESTS.
      - Considerations: The Repository pattern helps to isolate both the service and the list access code. Isolation makes it easier to treat them as independent services and to replace them with mock objects in unit tests. Typically, it is difficult to unit test the repositories themselves, so it is often better to write integration tests for them. 是這樣嗎??

## 參考資料
