---
title: Elasticsearch / Analysis
---
# [Elasticsearch](elasticsearch.md) / Analysis

  - [Analysis \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis.html)
      - Analysis is the process of converting TEXT, like the body of any email, into TOKENs or TERMs which are added to the INVERTED INDEX for searching. Analysis is performed by an ANALYZER which can be either a built-in analyzer or a `custom` analyzer defined PER INDEX. 只有 `text` field 才需要 analyzer 將其拆成 tokens/terms 存進 inverted index，不過 [`analyzer`](https://www.elastic.co/guide/en/elasticsearch/reference/current/analyzer.html) 也提到 Analyzers can be specified per-query, per-field or per-index. 細到每個 (text) filed 都可以指定不同的 analyzer。

## 新手上路 ?? {: #getting-started }

  - [Index time analysis - Analysis \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis.html#_index_time_analysis)
      - For instance, at index time the built-in `english` analyzer will first convert the sentence: `"The QUICK brown foxes jumped over the lazy dog!"` into DISTINCT TOKENs. It will then LOWERCASE each token, remove frequent STOPWORDs (虛字 "the") and reduce the terms to their WORD STEMs (foxes → fox, jumped → jump, lazy → lazi). In the end, the following TERMs will be added to the INVERTED INDEX: `[ quick, brown, fox, jump, over, lazi, dog ]` 這是 `english` analyzer 才會有的效果，若文字內混著多種語言要怎麼選 analyzer??

      - Each `text` field in a mapping can specify its own `analyzer`: 怎麼看被拆解的 inverted index 長什麼樣? => 進 index 後可以看 term vectors，進 index 前可以用 `analyze` API 測

            PUT my_index
            {
              "mappings": {
                "_doc": {
                  "properties": {
                    "title": {
                      "type":     "text",
                      "analyzer": "standard"
                    }
                  }
                }
              }
            }

        At index time, if no `analyzer` has been specified, it looks for an analyzer in the index settings called `default`. Failing that, it defaults to using the `standard` analyzer. 如何設定 `default` analyzer?? 不會看 mapping 的 `analyzer` parameter??

  - [Search time analysis - Analysis \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis.html#_search_time_analysis)
      - This same analysis process is applied to the QUERY STRING at search time in FULL TEXT QUERIES like the `match` query to convert the text in the query string into terms of the same form as those that are stored in the inverted index. 做 full text query 時，把 query string 也拆成 tokens/terms，最後在 match 的是兩邊的 tokens/terms。
      - For instance, a user might search for: `"a quick fox"` which would be analysed by the same english analyzer into the following terms: `[ quick, fox ]`. Even though the exact words used in the query string don’t appear in the original text (`quick` vs `QUICK`, `fox` vs `foxes`), because we have applied THE SAME ANALYZER to both the text and the query string, the terms from the query string exactly match the terms from the text in the inverted index, which means that this query would match our example document. 重點是 text (field) 與 query string 用的 analyzer 要一樣。
      - Usually the SAME ANALYZER SHOULD BE USED BOTH AT INDEX TIME AND AT SEARCH TIME, and full text queries like the `match` query will use the mapping to look up the analyzer to use for each field. 什麼情況下需要在 search time 另外給 analyzer??
      - The analyzer to use to search a particular field is determined by looking for: An `analyzer` specified in the query itself. --> The `search_analyzer` mapping parameter. --> The `analyzer` mapping parameter. --> An analyzer in the index settings called `default_search`. --> An analyzer in the index settings called `default`. --> The `standard` analyzer. 跟 index time 一樣，無法決定就用 `standard` analyzer；為何 mapping 會同時有 `analyzer` 與 `search_analyzer` 兩個參數??

## Analyzer ??

  - [Anatomy of an analyzer \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/analyzer-anatomy.html) #ril
      - An analyzer  — whether built-in or custom — is just a PACKAGE which contains three lower-level building blocks: character filters, tokenizers, and token filters. 其中 character/token filter 可以有多個 (也可以沒有)，但 tokenizer 一定要有，且只能有一個。
      - The built-in analyzers pre-package these building blocks into analyzers suitable for different languages and types of text. Elasticsearch also exposes the individual building blocks so that they can be combined to define new custom analyzers. 內建的 analyer 只是把幾個常用 tokenizer + character/token filters 先打包好，不過自己也可以拿相同的材料組裝成符合自己需求的 analyzer。如何知道現有 analyzer 的組成??
      - A character filter receives the original text as a stream of characters and can transform the stream by ADDING, REMOVING, OR CHANGING CHARACTERS. For instance, a character filter could be used to convert Hindu-Arabic numerals (`٠١٢٣٤٥٦٧٨٩`) into their Arabic-Latin equivalents (`0123456789`), or to strip HTML elements like `<b>` from the stream. An analyzer may have zero or more character filters, which are applied in order. 先轉換過再拆 token。
      - A tokenizer receives a stream of characters, breaks it up into individual TOKENs (usually individual words), and outputs a stream of tokens. For instance, a `whitespace` tokenizer breaks text into tokens whenever it sees any whitespace. It would convert the text `"Quick brown fox!"` into the terms `[Quick, brown, fox!]`. The tokenizer is also responsible for recording the order or position of each term and the start and end character offsets of the original word which the term represents. (用 `analyze` API 檢測時可以看到這些數據) An analyzer must have EXACTLY ONE tokenizer. 這是 analyzer 內一定要有的東西
      - A token filter receives the TOKEN STREAM and may add, remove, or change tokens. For example, a `lowercase` token filter converts all tokens to lowercase, a `stop` token filter removes common words (stop words) like the from the token stream, and a `synonym` token filter introduces synonyms into the token stream. Token filters are not allowed to change the position or character offsets of each token. An analyzer may have zero or more token filters, which are applied in order. 但 "add, remove, or change tokens" 不會影響到 position/offset 嗎?? 其中 `synonym` 可以自訂同義字，把公司內的 glossary 納入會很實用!!
      - 簡單來說 Analyzer = (character filter x N) --> (characters) --> tokenizer x 1 --> (tokens) --> (token filter x N)，在 tokenizer 前後都可以做些 add/remove/change 的加工，只是對象是 character/token 的不同。

  - [Testing analyzers \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/_testing_analyzers.html)
      - The `analyze` API is an invaluable tool for viewing the terms produced by an analyzer. A built-in analyzer (or COMBINATION of built-in tokenizer, token filters, and character filters) can be specified inline in the request: 除了現有的 analyzer，也可以用 tokenizer + filters 臨時的組合測試，這對自建 analyzer 很有幫助。

            POST _analyze
            {
              "analyzer": "whitespace",
              "text":     "The quick brown fox."
            }

            POST _analyze
            {
              "tokenizer": "standard",
              "filter":  [ "lowercase", "asciifolding" ],
              "text":      "Is this déja vu?"
            }

        以上面 `whitespace` analyzer 的例子會得到：

            {
              "tokens" : [
                {
                  "token" : "The",
                  "start_offset" : 0,
                  "end_offset" : 3,
                  "type" : "word",
                  "position" : 0
                },
                {
                  "token" : "quick",
                  "start_offset" : 4,
                  "end_offset" : 9,
                  "type" : "word",
                  "position" : 1
                },
                {
                  "token" : "brown",
                  "start_offset" : 10,
                  "end_offset" : 15,
                  "type" : "word",
                  "position" : 2
                },
                {
                  "token" : "fox.",
                  "start_offset" : 16,
                  "end_offset" : 20,
                  "type" : "word",
                  "position" : 3
                }
              ]
            }

        As can be seen from the output of the `analyze` API, analyzers not only convert words into terms, they also record the ORDER or RELATIVE POSITIONS of each term (used for phrase queries or word proximity queries), and the start and end character offsets of each term in the original text (used for HIGHLIGHTING search snippets). 可以想像 reverse index 裡就是存這些東西。

      - Alternatively, a `custom` analyzer can be referred to when running the analyze API on a specific index:

            PUT my_index
            {
              "settings": {
                "analysis": {
                  "analyzer": {
                    "std_folded": { <-- 在 index settings 裡定義一個名叫 std_folded 的 analyzer
                      "type": "custom",
                      "tokenizer": "standard",
                      "filter": [   <-- 不分 character/token filter
                        "lowercase",
                        "asciifolding"
                      ]
                    }
                  }
                }
              },
              "mappings": {
                "_doc": {
                  "properties": {
                    "my_text": {
                      "type": "text",
                      "analyzer": "std_folded" <-- 套用自訂的 analyzer
                    }
                  }
                }
              }
            }

            GET my_index/_analyze <-- 定義在 index 裡，所以 analyze API 要透過 index
            {
              "analyzer": "std_folded", <-- 用法跟 built-in analyzer 並無不同
              "text":     "Is this déjà vu?"
            }

            GET my_index/_analyze
            {
              "field": "my_text",
              "text":  "Is this déjà vu?"
            }

      - 嚴格來說 `custom` analyzer 跟 custom analyzer 不太一樣，前者是透過 settings 來宣告，後者則是透過 plugin 安裝，例如 [ICU Analysis Plugin](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-icu.html)，裡面有 tokenizer、filters 等。

  - [Analyzers \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-analyzers.html) #ril
  - [analyzer \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/analyzer.html) #ril

## Normalizer ??

  - [Normalizers \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-normalizers.html) #ril

## Tokenizer ??

  - [Tokenizers \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-tokenizers.html) #ril

## Character Filter ??

  - [Character Filters \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-charfilters.html) #ril

## Token Filter ??

  - [Token Filters \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-tokenfilters.html) #ril

## Term Vector ??

  - [Term Vectors \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/6.5/docs-termvectors.html) #ril

## Human Language ??

  - [Dealing with Human Language \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/current/languages.html) #ril
  - [Elasticsearch analyzer \- Elasticsearch \- Discuss the Elastic Stack](https://discuss.elastic.co/t/elasticsearch-analyzer/76726) (2017-02-28) 資料混著多種語言如何處理? #ril
  - [Mixed\-Language Fields \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/current/mixed-lang-fields.html) #ril

## 中文分詞器 {: #chinese }

  - [medcl/elasticsearch\-analysis\-ik: The IK Analysis plugin integrates Lucene IK analyzer into elasticsearch, support customized dictionary\.](https://github.com/medcl/elasticsearch-analysis-ik) 支援自訂字典 #ril
  - [sing1ee/elasticsearch\-jieba\-plugin: jieba analysis plugin for elasticsearch 6\.4\.0, 6\.0\.0, 5\.4\.0，5\.3\.0, 5\.2\.2, 5\.2\.1, 5\.2, 5\.1\.2, 5\.1\.1](https://github.com/sing1ee/elasticsearch-jieba-plugin) #ril
  - [Smart Chinese Analysis Plugin \| Elasticsearch Plugins and Integrations \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-smartcn.html) 只支援簡中? #ril
  - [Efficient Chinese Search with Elasticsearch — SitePoint](https://www.sitepoint.com/efficient-chinese-search-elasticsearch/) (2014-12-18) #ril
  - [Language Analyzers \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-lang-analyzer.html#chinese-analyzer) #ril
  - [icu\_tokenizer \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/current/icu-tokenizer.html) #ril
  - [Indexing Chinese in Solr](https://opensourceconnections.com/blog/2011/12/23/indexing-chinese-in-solr/) (2011-12-23) #ril
  - [Language Analysis \| Apache Solr Reference Guide 6\.6](https://lucene.apache.org/solr/guide/6_6/language-analysis.html) #ril
  - [medcl/elasticsearch\-analysis\-stconvert: STConvert is analyzer that convert chinese characters between traditional and simplified\.中文简繁體互相转换\.](https://github.com/medcl/elasticsearch-analysis-stconvert) #ril

## Custom Analyzer ??

  - [Custom Analyzer \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-custom-analyzer.html) 有沒有可能組合多個 analyzer 來用?? #ril
