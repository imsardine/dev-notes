---
title: Elasticsearch / Indexing
---
# [Elasticsearch](elasticsearch.md) / Indexing

## Index ??

  - [Create Index \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) #ril
  - [Delete Index \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-delete-index.html) #ril
  - [Get Index \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-get-index.html) #ril
  - [Indices Exists \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-exists.html) #ril
  - [Open / Close Index API \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-open-close.html) #ril

## Mapping ??

  - [Mapping \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping.html) #ril
      - Mapping is the process of defining how a document, and the FIELDs it contains, are stored and INDEXed. For instance, use mappings to define: which string fields should be treated as full text fields. (即採用 `text` field type)、which fields contain numbers, dates, or geolocations.、whether the values of all fields in the document should be indexed into the CATCH-ALL `_all` field.、the format of date values.、custom rules to control the mapping for DYNAMICALLY ADDED FIELDs. 可以停用 dynamic mapping 嗎?? 又 `_all` 的使用時機??

  - [Removal of mapping types \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/removal-of-types.html) #ril
      - Indices created in Elasticsearch 6.0.0 or later may only contain a SINGLE MAPPING TYPE. Indices created in 5.x with multiple mapping types will continue to function as before in Elasticsearch 6.x. Mapping types will be completely removed in Elasticsearch 7.0.0. 以前一個 index 可以有多個 mapping type，但 6.0 開始限定 1 個，到 7.0 就不支援 mapping type 了；少了 mapping type 這一層，往下就直接是 field (type)。
      - Since the first release of Elasticsearch, each document has been stored in a single index and assigned a single mapping type. A mapping type was used to represent the TYPE OF DOCUMENT or entity being indexed, for instance a `twitter` index might have a `user` type and a `tweet` type. Each mapping type could have its own fields, so the `user` type might have a `full_name` field, a `user_name` field, and an `email` field, while the `tweet` type could have a `content` field, a `tweeted_at` field and, like the `user` type, a `user_name` field. 以前每個 document 都會有 mapping type 用來識別 document type，不同的 document type 有不同的 fields ... 這結構 index --> mapping/document type(s) --> fields 很像是 RDBMS 裡 database --> table --> columns 的關係，但這樣的類比並不恰當...
      - In an Elasticsearch index, fields that have the same name in different mapping types are backed by the same Lucene field internally. In other words, using the example above, the `user_name` field in the `user` type is stored in exactly the same field as the `user_name` field in the `tweet` type, and both `user_name` fields must have the same mapping (definition) in both types. This can LEAD TO FRUSTRATION when, for example, you want `deleted` to be a `date` field in one type and a `boolean` field in another type IN THE SAME INDEX. 上面的類比 database --> table --> columns 會讓人誤以為不同 mapping/document type 間同名的 field 間沒有關係，但事實上同一個 index 下同名的 field 必須要有相同的 mapping definition (主要是 field type)，為了避免這樣的誤會，決定把 mapping type 這一層拿掉，原先識別不同 document type 的用途，則有其他替代方案。
      - On top of that, storing different entities that have FEW OR NO FIELDS IN COMMON in the same index leads to SPARSE DATA and interferes with Lucene’s ability to compress documents efficiently. 很像是 RDBMS table 的概念，硬要將不同 document/entity 存進同一個 table 裡，自然有些非通用的 column 產生，會影響儲存的效率；這呼應了下面 Index per document type 的方案，不同 document type 拆成不同的 index。

  - [Index per document type - Removal of mapping types \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/removal-of-types.html#_index_per_document_type)
      - The first alternative is to HAVE AN INDEX PER DOCUMENT TYPE. Instead of storing tweets and users in a single `twitter` index, you could store tweets in the `tweets` index and users in the `user` index. Indices are completely independent of each other and so there will be no conflict of field types between indices. 拆 index 會影響到什麼?? relationship 效率變差?
      - This approach has two benefits: Data is more likely to be DENSE and so benefit from compression techniques used in Lucene. The TERM STATISTICS used for scoring in full text search are more likely to be accurate because all documents in the same index represent a single entity. 不然跨 index 的 scoring 是怎麼計算的??
      - Each index can be sized appropriately for the number of documents it will contain: you can use a smaller number of PRIMARY SHARDs for users and a larger number of primary shards for tweets. 確實總量不多的 document type 若被分散到太多 shard，之後存取的效能會變差??

  - [Dynamic Mapping \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/dynamic-mapping.html)
      - One of the most important features of Elasticsearch is that it tries to get out of your way and let you start exploring your data as quickly as possible. To index a document, you DON’T HAVE TO first create an index, define a mapping type, and define your fields — you can just index a document and the index, type, and fields will spring to life automatically: 塞資料就會自動定義 mapping、fields，連 index 都會自動產生

            PUT data/_doc/1 <-- 3 個元素依序是 index、mapping type 跟 ID
            { "count": 5 }

        Creates the `data` index, the `_doc` mapping type, and a field called `count` with datatype `long`.

      - The automatic detection and addition of new fields is called dynamic mapping. The dynamic mapping rules can be customised to suit your purposes with: 搞得好複雜，回到 dynamic mapping 存在的原因 -- "tries to get out of your way"，確實有助於初期上手，但最好還是明確定義 mapping。

## Modeling ??

  - [Modeling Your Data \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/current/modeling-your-data.html) #ril
  - [Designing for Scale \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/current/scale.html) #ril
  - [Practical Considerations \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/current/parent-child-performance.html) #ril

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

