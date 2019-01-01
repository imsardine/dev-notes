---
title: Elasticsearch / Query
---
# [Elasticsearch](elasticsearch.md) / Query

## 新手上路 ?? {: #getting-started }

  - [Exploring Your Data \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-explore-data.html)
      - I’ve prepared a sample of fictitious JSON documents of customer bank account information. Each document has the following SCHEMA: (For the curious, this data was generated using www.json-generator.com/)

            {
                "account_number": 0,
                "balance": 16623,
                "firstname": "Bradshaw",
                "lastname": "Mckenzie",
                "age": 29,
                "gender": "F",
                "address": "244 Columbus Place",
                "employer": "Euron",
                "email": "bradshawmckenzie@euron.com",
                "city": "Hobucken",
                "state": "CO"
            }

      - You can download the sample dataset (`accounts.json`) from here. Extract it to our current directory and let’s load it into our cluster as follows: 走 Bulk API 將 accounts (JSON Lines) 上傳 1000 筆測試用數據。

            $ curl -L -o accounts.json https://github.com/elastic/elasticsearch/blob/master/docs/src/test/resources/accounts.json?raw=true
            $ head -4 accounts.json
            {"index":{"_id":"1"}}
            {"account_number":1,"balance":39225,"firstname":"Amber","lastname":"Duke","age":32,"gender":"M","address":"880 Holmes Lane","employer":"Pyrami","email":"amberduke@pyrami.com","city":"Brogan","state":"IL"}
            {"index":{"_id":"6"}}
            {"account_number":6,"balance":5686,"firstname":"Hattie","lastname":"Bond","age":36,"gender":"M","address":"671 Bristol Street","employer":"Netagy","email":"hattiebond@netagy.com","city":"Dante","state":"TN"}

            $ curl -H "Content-Type: application/json" -XPOST "localhost:9200/bank/_doc/_bulk?pretty&refresh" --data-binary "@accounts.json"
            $ curl "localhost:9200/_cat/indices?v"

            health status index     uuid                   pri rep docs.count docs.deleted store.size pri.store.size
            yellow open   bank      vA1OFhDGR9GkXDM1EVbZpg   5   1       1000            0    103.8kb        103.8kb

  - [The Search API \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-search-API.html) #ril
  - [Introducing the Query Language \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-query-lang.html) #ril
  - [Executing Searches \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-search.html) #ril
  - [Executing Filters \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-filters.html) #ril

## Search API ??

  - [Search APIs \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search.html) #ril

  - [Search \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-search.html) #ril
      - The search API allows you to execute a search query and get back SEARCH HITS that match the query. The query can either be provided using a simple QUERY STRING as a parameter (也就是 URI Search), or using a REQUEST BODY. 其中 search hits 指的是 match 的筆數。
      - Or we can search across all available indices using `_all`: `GET /_all/_search?q=tag:wow` 若省略 `_all/` 也是代表 all??

  - [URI Search \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-uri-request.html) #ril

  - [Request Body Search \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-body.html) #ril
      - Both HTTP GET and HTTP POST can be used to execute search with body. Since not all clients support GET with body, POST is allowed as well. 聽起來 POST 就比較合理。

  - [Query \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-query.html) #ril
  - [Sort \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-sort.html) #ril
  - [Source filtering \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-source-filtering.html) #ril
  - [Fields \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-stored-fields.html) #ril
  - [Script Fields \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-script-fields.html) #ril
  - [Doc value Fields \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-docvalue-fields.html) #ril
  - [Post filter \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-post-filter.html) #ril
  - [Rescoring \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-rescore.html) #ril
  - [Search Type \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-search-type.html) #ril
  - [Scroll \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-scroll.html) #ril
  - [Preference \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-preference.html) #ril
  - [Explain \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-explain.html) #ril
  - [Version \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-version.html) #ril
  - [min\_score \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-min-score.html) #ril

## Query DSL

  - [Query DSL \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html)
      - Elasticsearch provides a full Query DSL (Domain Specific Language) based on JSON to define queries. ... consisting of two types of CLAUSES: Leaf, Compound
      - Leaf query clauses look for a PARTICULAR VALUE IN A PARTICULAR FIELD, such as the `match`, `term` or `range` queries. These queries can be used by themselves. 相對於 compound query clause 用來組合其他 clause。
      - Compound query clauses WRAP other leaf or compound queries and are used to COMBINE MULTIPLE QUERIES in a logical fashion (such as the `bool` or `dis_max` query), or to alter their behaviour (such as the `constant_score` query). 這裡 multiple queries 的說法可能會誤導? 而是一個 query 可以由 leaf/compound (query) clause 構成；不過官方的文件到處都是 XXX Query 這種說法，只要知道那指的是 query clause 即可。
      - Query clauses behave differently depending on whether they are used in QUERY CONTEXT or FILTER CONTEXT.

  - [Query and filter context \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-filter-context.html)
      - A query clause used in query context answers the question “How well does this document match this query clause?” Besides deciding whether or not the document matches, the query clause also calculates a `_score` representing HOW WELL the document matches, relative to other documents. Query context is in effect whenever a query clause is passed to a `query` parameter, such as the `query` parameter in the `search` API. 除了 match 條件之外，還是算出 score 以區分 match 程度的不同 => 嚴格來說，不是 "計算" score，而是 "會影響" score -- 因為條件成立/不成立，而加減一點分數。
      - In filter context, a query clause answers the question “Does this document match this query clause?” The answer is a simple YES OR NO — no scores are calculated. Filter context is mostly used for filtering STRUCTURED DATA, e.g. Does this `timestamp` fall into the range 2015 to 2016? Is the `status` field set to "published"? 只有 match 與否，沒有程度的不同 => 嚴格來說，是 "不會影響"  score。
      - Frequently used filters will be CACHED AUTOMATICALLY by Elasticsearch, to speed up performance.
      - Filter context is in effect whenever a query clause is passed to a `filter` parameter, such as the `filter` or `must_not` parameters in the `bool` query, the `filter` parameter in the `constant_score` query, or the `filter` aggregation. 通常文件會特別提示 "executed in filter context"，上面 `bool` 的 `filter`/`must_not` parameters 都有。
      - Use query clauses in query context for conditions which SHOULD AFFECT the score of matching documents (i.e. how well does the document match), and use all other query clauses in filter context. 單純地過濾用 filter context，接著要分出程度不同才用 query context。
      - Below is an example of query clauses being used in query and filter context in the search API. This query will match documents where all of the following conditions are met:

            GET /_search
            {
              "query": { <-- query context
                "bool": {
                  "must": [
                    { "match": { "title":   "Search"        }},
                    { "match": { "content": "Elasticsearch" }}
                  ],
                  "filter": [ <-- filter context
                    { "term":  { "status": "published" }},
                    { "range": { "publish_date": { "gte": "2015-01-01" }}}
                  ]
                }
              }
            }

        The `bool` and two `match clauses` are used in query context, which means that they are USED TO SCORE how well each document matches. The `term` and `range` clauses are used in filter context. They will filter out documents which do not match, but they will NOT AFFECT THE SCORE for matching documents. 從最外層 `query` 開始，往下預設都是 query context，除非遇到 filter context，所以 `bool` 跟 `match` clause 都算在 filter context，但 `term` 跟 `range` clause 算在 filter context，至於 `must` 跟 `filter` 不是 query clause，只是 `bool` clause 的 paramter 而已。

  - [Match All Query \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-match-all-query.html) 感覺只用在測試 query，實際上會用在哪??
      - The most simple query, which matches all documents, giving them all a `_score` of `1.0`.

            GET /_search
            {
                "query": {
                    "match_all": {}
                }
            }

      - The `_score` can be changed with the `boost` parameter: 使用時機?

            GET /_search
            {
                "query": {
                    "match_all": { "boost" : 1.2 }
                }
            }

      - Match None Query - This is the inverse of the `match_all` query, which matches no documents. 使用時機?

            GET /_search
            {
                "query": {
                    "match_none": {}
                }
            }

## Full Text Query ??

  - [Query String Query \| Elasticsearch Reference \[5\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/5.4/query-dsl-query-string-query.html) #ril
  - [Simple Query String Query \| Elasticsearch Reference \[5\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/5.4/query-dsl-simple-query-string-query.html) #ril

## Term Level Query ??

  - [Term level queries \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/term-level-queries.html) #ril
      - While the full text queries will analyze the query string before executing, the term-level queries operate on the exact terms that are stored in the inverted index, and will normalize terms before executing only for keyword fields with normalizer property.
  - [Keyword datatype \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/keyword.html) #ril

## Highlighting ??

  - [Highlighting \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-highlighting.html) #ril

## Scoring/Ranking ??

  - [Ranking Evaluation API \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-rank-eval.html) #ril
  - [Explain \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-explain.html) 解釋 score 是如何計算的 #ril
  - [Theory Behind Relevance Scoring \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/current/scoring-theory.html) #ril
  - [Customize relevance with Elasticsearch – Sravanthi Naraharisetti – Medium](https://medium.com/@nschsravanthi/customize-relevance-with-elasticsearch-7735a9ac550e) (2018-04-16) #ril

## Boosting ??

  - [Elasticsearch Query\-Time Strategies and Techniques for Relevance: Part II \- Compose Articles](https://www.compose.com/articles/elasticsearch-query-time-strategies-and-techniques-for-relevance-part-ii/) (2016-03-31) #ril
  - [Tuning Relevance in Elasticsearch with Custom Boosting – Marco Bonzanini](https://marcobonzanini.com/2015/06/22/tuning-relevance-in-elasticsearch-with-custom-boosting/) (2015-06-22) #ril

  - [Index Boost \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-index-boost.html)
      - Allows to configure different boost level per index when searching across more than one indices. This is very handy when hits coming from ONE INDEX MATTER MORE than hits coming from another index (think social graph where each user has an index).
      - You can also specify it as an array to control the order of boosts.

            GET /_search
            {
                "indices_boost" : [
                    { "alias1" : 1.4 },
                    { "index*" : 1.3 }
                ]
            }

      - This is important when you use aliases or wildcard expression. If multiple matches are found, the first match will be used. For example, if an index is included in both `alias1` and `index*`, boost value of `1.4` is applied. 一個 index 最多被 boost 一次。
      - Boost 的值要怎麼給? 給了 `{ "wiki": 5 }` 結果 score 從 2.96 衝到 14.80，它跟 score 計算式的關係是什麼?? 搭配 index per document type 的策略比較好發揮。

  - [boost \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-boost.html) #ril
  - [Boosting Query \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-boosting-query.html) #ril

## Pagination ??

  - [From / Size \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-from-size.html) #ril

## Suggestion ??

  - [Elasticsearch: Building AutoComplete functionality – Hacker Noon](https://hackernoon.com/elasticsearch-building-autocomplete-functionality-494fcf81a7cf) (2017-12-31) #ril
  - [Elasticsearch: Using Completion Suggester to build AutoComplete](https://hackernoon.com/elasticsearch-using-completion-suggester-to-build-autocomplete-e9c120cf6d87) (2018-01-26) #ril
  - [How to Build a “Did You Mean” Feature with Elasticsearch](https://qbox.io/blog/how-to-build-did-you-mean-feature-with-elasticsearch-phrase-suggester) (2018-01-04) #ril
  - [Suggesters \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-suggesters.html) #ril
  - [Term suggester \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-suggesters-term.html) #ril

## Aggregation ??

  - [Executing Aggregations \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-aggregations.html) #ril
  - [Aggregations \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-aggregations.html) #ril

## 工具 {: #tools }

  - [5 Best Elasticsearch GUI clients as of 2018 \- Slant](https://www.slant.co/topics/11537/~elasticsearch-gui-clients) Postman 排名第一!? #ril
  - [The Sense UI \| Sense Documentation \| Elastic](https://www.elastic.co/guide/en/sense/current/sense-ui.html) Sense UI 是一個 Kibana app? #ril
  - [ElasticHQ \- Elasticsearch Management and Monitoring](http://www.elastichq.org/) 看起來很專業，但偏向系統管理 #ril
  - [mobz/elasticsearch\-head: A web front end for an elastic search cluster](https://github.com/mobz/elasticsearch-head) #ril
  - [appbaseio/dejavu: The Missing Web UI for Elasticsearch: Import, browse and edit data with rich filters and query views, create search UIs visually\.](https://github.com/appbaseio/dejavu) #ril
  - [jettro/elasticsearch\-gui: An angularJS client for elasticsearch as a plugin](https://github.com/jettro/elasticsearch-gui) #ril
  - [appbaseio/mirage: GUI for simplifying Elasticsearch Query DSL](https://github.com/appbaseio/mirage) #ril
  - [ElasticSearch 1\.7\.2 Query DSL Builder](https://www.supermind.org/elasticsearch/query-dsl-builder.html) #ril
  - [danpaz/bodybuilder: An elasticsearch query body builder](https://github.com/danpaz/bodybuilder) #ril
  - [sudo\-suhas/elastic\-builder: A Node\.js implementation of the elasticsearch Query DSL](https://github.com/sudo-suhas/elastic-builder) #ril
  - [KunihikoKido/atom\-elasticsearch\-client: elasticsearch\-client](https://github.com/KunihikoKido/atom-elasticsearch-client) #ril
  - [searchkit/searchkit: React UI components / widgets\. The easiest way to build a great search experience with Elasticsearch\.](https://github.com/searchkit/searchkit) 提供前端 search 的 UI 元件 #ril
