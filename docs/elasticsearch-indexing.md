---
title: Elasticsearch / Indexing
---
# [Elasticsearch](elasticsearch.md) / Indexing

## 新手上路 ?? {: #getting-started }

  - [Exploring Your Cluster \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-explore.html) #ril
  - [Cluster Health \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-cluster-health.html) #ril
  - [List All Indices \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-list-indices.html) #ril
  - [Create an Index \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-create-index.html) #ril

  - [Index and Query a Document \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-query-document.html)
      - We’ll index a simple customer document into the `customer` index, with an ID of `1` as follows:

            PUT /customer/_doc/1?pretty <-- 依序是 index, mapping type 及 ID，其中 _doc 是慣例?
            {
              "name": "John Doe"
            }

            ---

            {
              "_index" : "customer",
              "_type" : "_doc",
              "_id" : "1",     <-- 自訂 internal ID，注意型態是 string
              "_version" : 1,
              "result" : "created",
              "_shards" : {
                "total" : 2,
                "successful" : 1,
                "failed" : 0
              },
              "_seq_no" : 0,
              "_primary_term" : 1
            }

      - From the above, we can see that a new customer document was successfully created inside the `customer` index. The document also has an INTERNAL ID of `1` which we specified at INDEX TIME. 為什麼 ID 不是由 Elasticsearch 自己產生? => 後續採相同的 ID 再 index 一次就是 update，若真要由 Elasticsearch 產生 ID，則要改用 `POST` method。
      - It is important to note that Elasticsearch does not require you to explicitly create an index first before you can index documents into it. In the previous example, Elasticsearch will automatically create the `customer` index if it didn’t already exist beforehand. 連帶地，mapping type 也是自動建立的。
      - Let’s now retrieve that document that we just indexed:

            GET /customer/_doc/1?pretty

            ---

            {
              "_index" : "customer",
              "_type" : "_doc",
              "_id" : "1",
              "_version" : 1,
              "found" : true,
              "_source" : { "name": "John Doe" }
            }

      - Nothing out of the ordinary here other than a field, `found`, stating that we found a document with the requested ID `1` and another field, `_source`, which returns the full JSON document that we indexed from the previous step. 原來 index 傳進去的 JSON 整個被視為 `_source`

  - [Delete an Index \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-delete-index.html) #ril

  - [Modifying Your Data \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-modify-data.html)
      - Elasticsearch provides data manipulation and search capabilities in NEAR REAL TIME. By default, you can expect a ONE SECOND DELAY (REFRESH interval) from the time you index/update/delete your data until the time that it appears in your search results. This is an important distinction from other platforms like SQL wherein data is IMMEDIATELY available after a transaction is completed. 雖然不能馬上反應，但 1 秒已經很快了，這一段時間花在 source --> inverted index 的轉換；加 `?refresh` 可以要求馬上更新
      - If we then executed the above command again with a different (or same) document, Elasticsearch will REPLACE (i.e. REINDEX) a new document on top of the existing one with the ID of `1`:

            PUT /customer/_doc/1?pretty
            {
              "name": "Jane Doe"
            }

            ---

            {
              "_index": "customer",
              "_type": "_doc",
              "_id": "1",
              "_version": 2, <-- 每次 _version 都會 +1，即便整個 input 都沒變
              "result": "updated",
              "_shards": {
                "total": 2,
                "successful": 1,
                "failed": 0
              },
              "_seq_no": 1,
              "_primary_term": 1
            }

        注意是 replace (whole) document -- 如果之前提供 `{"name": "John Doe", "height": 180}`，用 `{"name": "Jane Doe"}` 取代後 `"height": 180` 就不見了 -- 而不單單只是更新 `name` field 而已，所以文件才會說這是 replace/reindex，那麼下一份文件的標題是 "Update Documents" 也就不奇怪了。

      - When indexing, the ID part is OPTIONAL. If not specified, Elasticsearch will generate a random ID and then use it to index the document. The actual ID Elasticsearch generates (or whatever we specified explicitly in the previous examples) is returned as part of the index API call.

            POST /customer/_doc?pretty
            {
              "name": "Jane Doe"
            }

            ---

            {
              "_index": "customer",
              "_type": "_doc",
              "_id": "4HUxCGgBGR3KY_r1S5Vj",
              "_version": 1,
              "result": "created",
              "_shards": {
                "total": 2,
                "successful": 1,
                "failed": 0
              },
              "_seq_no": 0,
              "_primary_term": 1
            }

        Note that in the above case, we are using the `POST` verb instead of PUT since we didn’t specify an ID. 實務上就必須記錄這份 source 與 generated ID 的對照... 如果可以的話，可以從 source 的某些 field 算出一個 ID，例如 URL 的 SHA256，如果來源本來就有自己的 ID，直接用也無妨，搭配 Index per document type 的策略，也不用擔心 ID 會衝突。

  - [Updating Documents \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-update-documents.html)
      - In addition to being able to index and REPLACE documents, we can also UPDATE documents. Note though that Elasticsearch does NOT ACTUALLY DO IN-PLACE UPDATES under the hood. Whenever we do an update, Elasticsearch deletes the old document and then indexes a new document with the update applied to it in one shot. 注意 replace 與 update 的不同，雖然 Elasticsearch 底層不支援所謂的 update，但透過 update API 可以做到 "更新 source 部份欄位 + 重新 index 整個 source" 的效果。

            POST /customer/_doc/1/_update?pretty
            {
              "doc": { "name": "Jane Doe" } <-- 注意走 POST，在 JSON document 外多了一層 doc
            }

            ---

            {
              "_index": "customer",
              "_type": "_doc",
              "_id": "1",
              "_version": 2,
              "result": "updated", <-- 跟 PUT/replace 一樣
              "_shards": {
                "total": 2,
                "successful": 1,
                "failed": 0
              },
              "_seq_no": 1,
              "_primary_term": 1
            }

      - This example shows how to update our previous document (ID of 1) by changing the `name` field to `Jane Doe` and at the same time add an `age` field to it:

            POST /customer/_doc/1/_update?pretty
            {
              "doc": { "name": "Jane Doe", "age": 20 }
            }

      - Updates can also be performed by using simple SCRIPTs. This example uses a script to increment the `age` by 5:

            POST /customer/_doc/1/_update?pretty
            {
              "script" : "ctx._source.age += 5"
            }

        In the above example, `ctx._source` refers to the current source document that is about to be updated. 語法是 Painless，滿直覺的

      - Elasticsearch provides the ability to update multiple documents given a query condition (like an `SQL UPDATE-WHERE` statement). See `docs-update-by-query` API 通常會搭配 script 使用。

  - [Deleting Documents \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-delete-documents.html)
      - Deleting a document is fairly straightforward. This example shows how to delete our previous customer with the ID of `2`: `DELETE /customer/_doc/2?pretty`
      - See the `_delete_by_query` API to delete all documents matching a specific query.

  - [Batch Processing \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-batch-processing.html)
      - In addition to being able to index, update, and delete individual documents, Elasticsearch also provides the ability to perform ANY of the above operations in batches using the `_bulk` API. This functionality is important in that it provides a very efficient mechanism to do multiple operations as fast as possible with as FEW NETWORK ROUNDTRIPS as possible.
      - The following call indexes two documents (ID 1 - John Doe and ID 2 - Jane Doe) in one bulk operation: 類 JSON Lines 的格式 -- action 與 source 交替出現，可以用來準備測試資料；如何將現有的資料 dump 成這樣的格式??

            POST /customer/_doc/_bulk?pretty
            {"index":{"_id":"1"}} <-- action / ID
            {"name": "John Doe" } <-- source
            {"index":{"_id":"2"}}
            {"name": "Jane Doe" }

            ---

            {
              "took" : 17,
              "errors" : false,
              "items" : [
                {
                  "index" : {
                    "_index" : "customer",
                    "_type" : "_doc",
                    "_id" : "1",
                    "_version" : 7,
                    "result" : "updated",
                    "_shards" : {
                      "total" : 2,
                      "successful" : 1,
                      "failed" : 0
                    },
                    "_seq_no" : 6,
                    "_primary_term" : 1,
                    "status" : 200
                  }
                },
                {
                  "index" : {
                    "_index" : "customer",
                    "_type" : "_doc",
                    "_id" : "2",
                    "_version" : 2,
                    "result" : "created",
                    "_shards" : {
                      "total" : 2,
                      "successful" : 1,
                      "failed" : 0
                    },
                    "_seq_no" : 1,
                    "_primary_term" : 1,
                    "status" : 201
                  }
                }
              ]
            }

        This example updates the first document (ID of 1) and then deletes the second document (ID of 2) in one bulk operation:

            POST /customer/_doc/_bulk?pretty
            {"update":{"_id":"1"}}
            {"doc": { "name": "John Doe becomes Jane Doe" } } <-- 寫法跟 update API 一樣
            {"delete":{"_id":"2"}}

        Note above that for the delete action, there is no corresponding SOURCE DOCUMENT after it since deletes only require the ID of the document to be deleted. 通常是 action 與 source 交替出現，但是若 action 不需要 document，就不會跟著 document。

      - The Bulk API does NOT FAIL DUE TO FAILURES IN ONE OF THE ACTIONS. If a single action fails for whatever reason, it will continue to process the remainder of the actions after it. When the bulk API returns, it will provide a status for EACH ACTION (in the same order it was sent in) so that you can check if a specific action failed or not. 很彈性的設計，一次回報個別 action 的結果。

  - [?refresh \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-refresh.html) #ril

  - [Indexing for Beginners, Part 1 \| Elastic](https://www.elastic.co/blog/found-indexing-for-beginners-part1) (2013-09-13) #ril
  - [Indexing for Beginners, Part 2 \| Elastic](https://www.elastic.co/blog/found-indexing-for-beginners-part2) (2013-10-08) #ril
  - [Indexing for Beginners, Part 3 \| Elastic](https://www.elastic.co/blog/found-indexing-for-beginners-part3) (2013-10-29) #ril

## Modeling ??

  - [Modeling Your Data \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/current/modeling-your-data.html) #ril
  - [Designing for Scale \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/current/scale.html) #ril
  - [Practical Considerations \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/current/parent-child-performance.html) #ril

## Index ??

  - [Get Index \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-get-index.html)
      - The get index API allows to retrieve information about ONE OR MORE indexes. 例如 `GET /twitter`；先知道如何看 index 的設定、如何刪除 index，再練習建立 index。
      - Specifying an index, alias or wildcard expression is required. The get index API can also be applied to more than one index, or on all indices by using `_all` or `*` as index. 實驗確認逗號開多個 index 也是可以的，例如 `GET /twitter,test`。
  - [Delete Index \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-delete-index.html)
      - The delete index API allows to delete an existing index. 例如 `DELETE /twitter`。
      - Specifying an index or a wildcard expression is required. Aliases cannot be used to delete an index. Wildcard expressions are resolved to matching CONCRETE indices only. 這裡 concrete 是相對於 alias 的說法??
      - The delete index API can also be applied to more than one index, by either using a COMMA SEPARATED list, or on all indices (be careful!) by using `_all` or `*` as index.
  - [Indices Exists \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-exists.html)
      - Used to check if the index (indices) exists or not. The HTTP status code indicates if the index exists or not. A `404` means it does not exist, and `200` means it does. 例如 `HEAD twitter`。
      - This request does not distinguish between an index and an alias, i.e. status code 200 is also returned if an alias exists with that name. 這不是很合理嗎? 有可能 alias 背後的 index 已經不在??
  - [Create Index \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) #ril
      - The most basic command is the following: `PUT twitter` This create an index named `twitter` with all default setting. 這裡的 default setting 指的是 index level setting，至於 mapping type 則要到 index 資料時才會動態產生。

            PUT twitter

            #! Deprecation: the default number of shards will change from [5] to [1] in 7.0.0; if you wish to continue using the default of [5] shards, you must manage this on the create index request or with an index template
            {
              "acknowledged" : true,
              "shards_acknowledged" : true,
              "index" : "twitter"
            }

        原有的 default settings 未來將由 index template 提供。用 get index API 檢查剛建立的 index：

            GET twitter

            {
              "twitter" : {
                "aliases" : { },
                "mappings" : { }, <-- 還沒有 mapping type
                "settings" : {
                  "index" : {
                    "creation_date" : "1546072098512",
                    "number_of_shards" : "5",
                    "number_of_replicas" : "1",
                    "uuid" : "It4LvVmnSxmaTp_0ukJ8zA",
                    "version" : {
                      "created" : "6050499"
                    },
                    "provided_name" : "twitter"
                  }
                }
              }
            }

      - There are several limitations to what you can name your index. The complete list of limitations are: 1) Lowercase only 2) Cannot include `\`, `/`, `*`, `?`, `"`, `<`, `>`, `|`, ` ` (space character), `,`, `#` 3) Indices prior to 7.0 could contain a colon (`:`), but that’s been deprecated and won’t be supported in 7.0+ 4) Cannot start with -, _, + 5) Cannot be `.` or `..` 6) Cannot be longer than 255 bytes 簡單來說，可以用英數字 (小寫)、`-`、`_`、`.`，但只能以英數字開頭。
      - 建立 index 的同時，可以提供 index level settings 及 mapping type：

            PUT test
            {
                "settings" : {
                    "number_of_shards" : 3,
                    "number_of_replicas" : 2
                },
                "mappings" : {
                    "_doc" : { <-- mapping type 的名稱，自動建立的話會與 index 同名??
                        "properties" : { <-- 定義 properties/fields
                            "field1" : { "type" : "text" }
                        }
                    }
                }
            }

        用 get index API 檢查剛建立的 index：

            GET test

            {
              "test" : {
                "aliases" : { },
                "mappings" : { <-- 這次有 mapping type 了
                  "_doc" : {
                    "properties" : {
                      "field1" : {
                        "type" : "text"
                      }
                    }
                  }
                },
                "settings" : {
                  "index" : {
                    "creation_date" : "1546072910916",
                    "number_of_shards" : "3", <-- 預設值也成功覆寫
                    "number_of_replicas" : "2",
                    "uuid" : "ooQ4vtBNQBStLEV8bi06RA",
                    "version" : {
                      "created" : "6050499"
                    },
                    "provided_name" : "test"
                  }
                }
              }
            }

  - [Index Aliases \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-aliases.html) #ril
  - [Open / Close Index API \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-open-close.html) #ril

## Mapping ??

  - [Mapping \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping.html) #ril
      - Mapping is the process of defining how a document, and the FIELDs it contains, are stored and INDEXed. For instance, use mappings to define: which string fields should be treated as full text fields. (即採用 `text` field type)、which fields contain numbers, dates, or geolocations.、whether the values of all fields in the document should be indexed into the CATCH-ALL `_all` field.、the format of date values.、custom rules to control the mapping for DYNAMICALLY ADDED FIELDs. 可以停用 dynamic mapping 嗎?? 又 `_all` 的使用時機??
      - Each index has ONE mapping type which determines how the document will be indexed. (7.0 後則完全沒有 mapping 這東西)
      - Meta-fields - Meta-fields are used to customize how a document’s METADATA associated is treated. Examples of meta-fields include the document’s `_index`, `_type`, `_id`, and `_source` fields.
      - Fields or properties - A mapping type contains a list of fields or properties PERTINENT to the document. 注意field 跟 property 是通用的說法。
      - Each field has a data `type` which can be: a simple type like `text`, `keyword`, `date`, `long`, `double`, `boolean` or `ip`. a type which supports the HIERARCHICAL NATURE of JSON such as `object` or `nested`. or a specialised type like `geo_point`, `geo_shape`, or `completion`.

  - [Removal of mapping types \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/removal-of-types.html) #ril
      - Indices created in Elasticsearch 6.0.0 or later may only contain a SINGLE MAPPING TYPE. Indices created in 5.x with multiple mapping types will continue to function as before in Elasticsearch 6.x. Mapping types will be completely removed in Elasticsearch 7.0.0. 以前一個 index 可以有多個 mapping type，但 6.0 開始限定 1 個，到 7.0 就不支援 mapping type 了；少了 mapping type 這一層，往下就直接是 field (type)。
      - Since the first release of Elasticsearch, each document has been stored in a single index and assigned a single mapping type. A mapping type was used to represent the TYPE OF DOCUMENT or entity being indexed, for instance a `twitter` index might have a `user` type and a `tweet` type. Each mapping type could have its own fields, so the `user` type might have a `full_name` field, a `user_name` field, and an `email` field, while the `tweet` type could have a `content` field, a `tweeted_at` field and, like the `user` type, a `user_name` field. 以前每個 document 都會有 mapping type 用來識別 document type，不同的 document type 有不同的 fields ... 這結構 index --> mapping/document type(s) --> fields 很像是 RDBMS 裡 database --> table --> columns 的關係，但這樣的類比並不恰當...
      - In an Elasticsearch index, fields that have the same name in different mapping types are backed by the same Lucene field internally. In other words, using the example above, the `user_name` field in the `user` type is stored in exactly the same field as the `user_name` field in the `tweet` type, and both `user_name` fields must have the same mapping (definition) in both types. This can LEAD TO FRUSTRATION when, for example, you want `deleted` to be a `date` field in one type and a `boolean` field in another type IN THE SAME INDEX. 上面的類比 database --> table --> columns 會讓人誤以為不同 mapping/document type 間同名的 field 間沒有關係，但事實上同一個 index 下同名的 field 必須要有相同的 mapping definition (主要是 field type)，為了避免這樣的誤會，決定把 mapping type 這一層拿掉，原先識別不同 document type 的用途，則有其他替代方案。
      - On top of that, storing different entities that have FEW OR NO FIELDS IN COMMON in the same index leads to SPARSE DATA and interferes with Lucene’s ability to compress documents efficiently. 很像是 RDBMS table 的概念，硬要將不同 document/entity 存進同一個 table 裡，自然有些非通用的 column 產生，會影響儲存的效率；這呼應了下面 Index per document type 的方案，不同 document type 拆成不同的 index。

  - [Index per document type - Removal of mapping types \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/removal-of-types.html#_index_per_document_type)
      - The first alternative is to HAVE AN INDEX PER DOCUMENT TYPE. Instead of storing tweets and users in a single `twitter` index, you could store tweets in the `tweets` index and users in the `user` index. Indices are completely independent of each other and so there will be no conflict of field types between indices. 拆 index 會影響到什麼?? relationship 效率變差?
      - This approach has two benefits: Data is more likely to be DENSE and so benefit from compression techniques used in Lucene. The TERM STATISTICS used for scoring in full text search are more likely to be accurate because all documents in the same index represent a single entity. 不然跨 index 的 scoring 是怎麼計算的??
      - Each index can be sized appropriately for the number of documents it will contain: you can use a smaller number of PRIMARY SHARDs for users and a larger number of primary shards for tweets. 確實總量不多的 document type 若被分散到太多 shard，之後存取的效能會變差??
      - 如果真依 document type 來分 index 的話，將不同 wiki system 的 wiki pages 併到一個 index 也是合理，因為大家都有 title、content、slug 的概念。

  - [Get Mapping \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-get-mapping.html) #ril
  - [Get Field Mapping \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-get-field-mapping.html) #ril
  - [Types Exists \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-types-exists.html) #ril
  - [Put Mapping \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-put-mapping.html) #ril

## Dynamic Mapping ??

  - [Dynamic Mapping \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/dynamic-mapping.html) #ril
      - One of the most important features of Elasticsearch is that it tries to get out of your way and let you start exploring your data as quickly as possible. To index a document, you DON’T HAVE TO first create an index, define a mapping type, and define your fields — you can just index a document and the index, type, and fields will spring to life automatically: 塞資料就會自動定義 mapping、fields，連 index 都會自動產生

            PUT data/_doc/1 <-- 3 個元素依序是 index、mapping type 跟 ID
            { "count": 5 }

        Creates the `data` index, the `_doc` mapping type, and a field called `count` with datatype `long`.

      - The automatic DETECTION and addition of new fields is called dynamic mapping. The dynamic mapping rules can be customised to suit your purposes with: 搞得好複雜，回到 dynamic mapping 存在的原因 -- "tries to get out of your way"，確實有助於初期上手，但最好還是明確定義 mapping。

  - [Little Logstash Lessons: Using Logstash to help create an Elasticsearch mapping template \| Elastic](https://www.elastic.co/blog/logstash_lesson_elasticsearch_mapping) (2017-03-30) 似乎 dynamic mapping 在實務上有其必要? #ril

## Inverted Index ??

  - [Inverted Index \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/current/inverted-index.html) #ril
  - [Elasticsearch from the Bottom Up, Part 1 \| Elastic](https://www.elastic.co/blog/found-elasticsearch-from-the-bottom-up) (2013-09-16) #ril
  - [Making Text Searchable \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/current/making-text-searchable.html) #ril

## Relationship ??

  - [Handling Relationships \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/current/relations.html) #ril
  - [Managing Relations Inside Elasticsearch \| Elastic](https://www.elastic.co/blog/managing-relations-inside-elasticsearch) (2013-02-20) #ril

## Field Type ??

  - [Field datatypes \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-types.html) #ril

## Update ??

  - [Update API \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-update.html) #ril
  - [Update By Query API \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-update-by-query.html) #ril

## Reindex ??

  - [Reindex API \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-reindex.html) 只要有 `_source` 就可以重新 index，但 `_source` 不是都有嗎?? #ril
  - [Removal of mapping types \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/removal-of-types.html#_custom_type_field_2) 搭配 script 做 reindex #ril

## Configuration ??

  - [Index Level Settings - Settings changes \| Elasticsearch Reference \[5\.2\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/5.2/breaking_50_settings_changes.html#_index_level_settings) In previous versions Elasticsearch allowed to specify index level setting as defaults on the NODE LEVEL, inside the `elasticsearch.yaml` file or even via command-line parameters. From Elasticsearch 5.0 on only selected settings like for instance `index.codec` can be set on the node level. All other settings must be set on each individual index. To set DEFAULT VALUES on every index, INDEX TEMPLATEs should be used instead. 預設值改用 index template，

  - [ES 5\.2 fails to start with setting "index\.number\_of\_shards: 2" in elasticsearch\.yml \- Elasticsearch \- Discuss the Elastic Stack](https://discuss.elastic.co/t/es-5-2-fails-to-start-with-setting-index-number-of-shards-2-in-elasticsearch-yml/83654/4) nik9000: 改用 index template。如果 index level 還是寫在 `elasticsearch.yml` 裡的話，會提示：

        Found index level settings on node level configuration.

        Since elasticsearch 5.x index level settings can NOT be set on the nodes
        configuration like the elasticsearch.yaml, in system properties or command line
        arguments.In order to upgrade all indices the settings must be updated via the
        /${index}/_settings API. Unless all settings are dynamic all indices must be closed
        in order to apply the upgrade. Indices created in the future should use index templates
        to set default values.

        Please ensure all required values are updated on all indices by executing:

        curl -XPUT 'http://localhost:9200/_all/_settings?preserve_existing=true' -d '{
          "index.number_of_shards" : "2"
        }'

  - [Index Templates \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-templates.html) #ril
      - Index templates allow you to define templates that will automatically be applied when new indices are created. 也就是過往寫在 node level (`elasticsearch.yml`) 但有關 index 的預設值可以先安排在 template 裡。

## Import / Export ??

  - [How to Export Data from Elasticsearch into a CSV File](https://qbox.io/blog/how-to-export-data-elasticsearch-into-csv-file) (2016-11-16) #ril
  - [Snapshot And Restore \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-snapshots.html) #ril
  - [What's the easiest way to export ElasticSearch data for later re\-import, say, at a later time on another server? \- Quora](https://www.quora.com/Whats-the-easiest-way-to-export-ElasticSearch-data-for-later-re-import-say-at-a-later-time-on-another-server) #ril
  - [taskrabbit/elasticsearch\-dump: Import and export tools for elasticsearch](https://github.com/taskrabbit/elasticsearch-dump) #ril
