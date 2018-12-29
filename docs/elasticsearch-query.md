---
title: Elasticsearch / Query
---
# [Elasticsearch](elasticsearch.md) / Query

  - [Query and filter context \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/6.5/query-filter-context.html) Query 比 filter 的結果多了 `_score` #ril

## Search API ??

  - [Search APIs \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search.html) #ril
  - [Search \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-search.html) #ril
      - The search API allows you to execute a search query and get back SEARCH HITS that match the query. The query can either be provided using a simple QUERY STRING as a parameter (也就是 URI Search), or using a REQUEST BODY.
      - Or we can search across all available indices using `_all`: `GET /_all/_search?q=tag:wow` 若省略 `_all/` 也是代表 all??
  - [URI Search \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-uri-request.html) #ril
  - [Request Body Search \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-body.html) #ril
      - Both HTTP GET and HTTP POST can be used to execute search with body. Since not all clients support GET with body, POST is allowed as well. 聽起來 POST 就比較合理。
  - [Query \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-query.html) #ril
  - [From / Size \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-from-size.html) #ril
  - [Sort \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-sort.html) #ril
  - [Source filtering \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-source-filtering.html) #ril
  - [Fields \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-stored-fields.html) #ril
  - [Script Fields \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-script-fields.html) #ril
  - [Doc value Fields \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-docvalue-fields.html) #ril
  - [Post filter \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-post-filter.html) #ril
  - [Highlighting \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-highlighting.html) #ril
  - [Rescoring \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-rescore.html) #ril
  - [Search Type \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-search-type.html) #ril
  - [Scroll \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-scroll.html) #ril
  - [Preference \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-preference.html) #ril
  - [Explain \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-explain.html) #ril
  - [Version \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-version.html) #ril
  - [Index Boost \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-index-boost.html) #ril
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

## Scoring/Ranking ??

  - [Ranking Evaluation API \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-rank-eval.html) #ril
  - [Explain \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-explain.html) 解釋 score 是如何計算的 #ril
  - [Theory Behind Relevance Scoring \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/current/scoring-theory.html) #ril
  - [Customize relevance with Elasticsearch – Sravanthi Naraharisetti – Medium](https://medium.com/@nschsravanthi/customize-relevance-with-elasticsearch-7735a9ac550e) (2018-04-16) #ril

## Suggestion ??

  - [Elasticsearch: Building AutoComplete functionality – Hacker Noon](https://hackernoon.com/elasticsearch-building-autocomplete-functionality-494fcf81a7cf) (2017-12-31) #ril
  - [Elasticsearch: Using Completion Suggester to build AutoComplete](https://hackernoon.com/elasticsearch-using-completion-suggester-to-build-autocomplete-e9c120cf6d87) (2018-01-26) #ril
  - [How to Build a “Did You Mean” Feature with Elasticsearch](https://qbox.io/blog/how-to-build-did-you-mean-feature-with-elasticsearch-phrase-suggester) (2018-01-04) #ril
  - [Suggesters \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-suggesters.html) #ril
  - [Term suggester \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-suggesters-term.html) #ril

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
