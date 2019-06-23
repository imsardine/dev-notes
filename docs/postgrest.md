# PostgREST

  - [PostgREST Documentation — PostgREST 5\.0\.0 documentation](http://postgrest.org/) #ril

      - PostgREST is a standalone web server that turns your PostgreSQL database directly into a RESTful API. The structural constraints and PERMISSIONS in the database determine the API endpoints and operations.

        聽起來會用 DB 裡的 user 做 authentication ??

    Motivation

      - Using PostgREST is an alternative to manual CRUD programming. Custom API servers suffer problems.

        Writing business logic often duplicates, ignores or hobbles database structure. Object-relational mapping is a LEAKY ABSTRACTION leading to SLOW IMPERATIVE CODE. ?? The PostgREST philosophy establishes a single declarative source of truth: the data itself.

    Declarative Programming

      - It’s easier to ask PostgreSQL to join data for you and let its query planner figure out the details than to loop through rows yourself. It’s easier to assign permissions to db objects than to add guards in controllers. (This is especially true for cascading permissions in data dependencies.) It’s easier to set constraints than to LITTER CODE WITH SANITY CHECKS.

    Leak-proof Abstraction

      - There is NO ORM INVOLVED. Creating new views happens in SQL with known performance implications. A database administrator can now create an API from scratch with no custom programming. 跟 leak 什麼關係 ??

    Embracing the Relational Model

      - In 1970 E. F. Codd criticized the then-dominant hierarchical model of databases in his article A Relational Model of Data for Large Shared Data Banks. Reading the article reveals a striking similarity between hierarchical databases and nested http routes.

        With PostgREST we attempt to use flexible filtering and embedding rather than nested routes. ??

    One Thing Well

      - PostgREST has a focused scope. It works well with other tools like Nginx. This forces you to cleanly separate the data-centric CRUD operations from other concerns. Use a collection of sharp tools rather than building a big ball of mud. ??

## 參考資料 {: #reference }

  - [PostgREST](http://postgrest.org/)
  - [PostgREST/postgrest - GitHub](https://github.com/PostgREST/postgrest)
