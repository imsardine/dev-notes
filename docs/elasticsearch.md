# Elasticsearch

參考資料：

  - [Elasticsearch: RESTful, Distributed Search & Analytics \| Elastic](https://www.elastic.co/products/elasticsearch)
      - Elasticsearch 做為 Elastic Stack 的核心，定位成 distributed, RESTful search and analytics engine - discover the expected and uncover the unexpected 這說法真好；資料就在那裡，端看你怎麼應用它。
      - QUERY - Be Curious. Ask Your Data Questions of All Kinds. 可以從各種角度搜尋 -- structured, unstructured, geo, metric，最後一句 Start simple with one question and see where it takes you. 講得真好，平常人為的搜尋就像這樣，中間會有越來越多的線索、想法。
      - ANALYZE - Step Back and Understand the Bigger Picture. 搜尋數十億筆 log line 顯然不同於找出 10 份符合條件的文件，aggregation 可以讓你看出數據中隱藏的 trend/pattern。
      - SPEED - Elasticsearch Is Fast. Really, Really Fast. 強調它很快，但這並不容易，要對不同性質的資料、查詢事先優化過內部的 index。"When you get answers instantly, your relationship with your data changes. You can afford to iterate and cover more ground." 這話很有趣，呼應上面 "see where it takes you" 的說法。
      - SCALABILITY - Run It on Your Laptop. Or Hundreds of Servers with Petabytes of Data. 初期在自己電腦上評估 (安裝方便)，跟上百台 server + PB 級的資料，都是沒問題的；而且跟單一台 Elasticsearch 或 300-node cluster 對話的方式並無不同。
      - RESILIENCY - We Cover the Bases While You Swing for the Fences. 從頭設計在分散式的環境下運作，會自動偵測 cluster 裡發生的錯誤 (硬體、網路等)，搭配 cross-cluster replication，甚至可以把第 2 個 cluster 當成 hot backup!
      - Elasticsearch Plus Hadoop - Have massive data sitting in Hadoop? Put the real-time search and analytics features of Elasticsearch to work on your big data by using the Elasticsearch-Hadoop (ES-Hadoop) connector. It's the best of two worlds colliding. 顯然 Elasticsearch 在 storage/search 這一段比 Hadoop 強，讓 Hadoop 專注在資料處理上。
      - 最後 Get Started Quickly, Right Out of the Box 提到 With sensible defaults and no up-front schema definition, Elasticsearch makes it easy to START SIMPLE AND FINE-TUNE AS YOU GROW. 這一點真的做得很好，尤其 Elasticsearch 這麼複雜的產品。
  - [Getting Started \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started.html)
      - 是個 full-text search and analytics engine (應該分兩塊來看)，用於 store/search/analyze big volumes of data (強調 in near real time)，通常做為需要 complex search 應用背後的 engine。
      - 可以把整個 product catalog/inventory 存進 Elasticsearch，在購物網站上提供 search 及 autocomplete suggestions 的功能；這時候跟 database 裡的資料要如何同步??
      - 可以用 Logstash 去 collect/aggregate/parse log 或 transaction data，然後餵進 Elasticsearch，就可以透過 Elasticsearch 的 search/aggregation 去 analyze/mine data 以看出一些 trends/statistics/summarizations/anomalies (異常)；這就是 analytics/business-intelligence 方面的應用，透過 Kibana 還可以自訂 dashboard 把數據視覺化。
      - Use case #3 price alerting platform 提到的 "reverse-search (Percolator)" 指的是什麼??
      - 從 Exploring Your Cluster 開始就要開始操作 RESTful API；由於 Elasticsearch 對外的介面就是 RESTful API，好像也不用把 API 拉出去另外看?
  - [Near Realtime (NRT) - Basic Concepts \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/_basic_concepts.html#_near_realtime_nrt) Elasticsearch is a near real time (NRT) search platform. 意指文件進 index 到變成 searchable 之間只有小小的 latency (大約 1s)。
  - [Elasticsearch \- Wikipedia](https://en.wikipedia.org/wiki/Elasticsearch) #ril
  - [Elasticsearch Solutions That Solve Problems \| Elastic](https://www.elastic.co/solutions) 各種不同的應用 #ril

## 跟 Lucene 的關係 ?? {: #lucene }

  - [Shards & Replicas - Basic Concepts \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/_basic_concepts.html#getting-started-shards-and-replicas) 最後提到 "Each Elasticsearch shard is a Lucene index."，所以 Elasticsearch 的背後也是 Lucene。

## Elastic Stack, X-Pack ??

  - Elastic Stack 包含 Elastic 所有的產品線，以 Elasticsearch 為核心，還有 Kinbana、Beats、Logstash 等。

參考資料：

  - [X\-Pack: Extend Elasticsearch, Kibana & Logstash \| Elastic](https://www.elastic.co/products/stack) #ril
      - From enterprise-grade security and developer-friendly APIs to machine learning, and graph analytics. 為什麼要區分出來? 收費方案才有??
      - Ships with features (formerly packaged as X-Pack) made and maintained by us to be enjoyed by you. 跟 X-Pack 合併了
  - [Elasticsearch: RESTful, Distributed Search & Analytics \| Elastic](https://www.elastic.co/products/elasticsearch) 只說 Elasticsearch 是 Elastic Stack 的核心，但沒說 stack 包含哪些?
  - [Powering Data Search, Log Analysis, Analytics \| Elastic](https://www.elastic.co/products) 所有的產品 - 包括 Elasticsearch、Kibana、Beats、Logstash、X-Pack、Cloud。
  - [Get Started with Elasticsearch, Kibana, and the Elastic Stack \| Elastic](https://www.elastic.co/start) 主要是 security 與 monitoring，由 `bin/elasticsearch-plugin install x-pack` 與 `bin/kibana-plugin install x-pack` 看來，它同時做為 Elasticsearch 與 Kibana 的 plugin。

## Logstash ??

  - [Getting Started with Logstash \| Elastic](https://www.elastic.co/webinars/getting-started-logstash) #ril

## Elastic Cloud ??

  - [Get Started with Elasticsearch, Kibana, and the Elastic Stack \| Elastic](https://www.elastic.co/start) 用 "Want to deploy everything in one click instead?" 帶出 Elastic Cloud；由於除了 Elasticsearch 外還有 Kibana、X-Pack 等，有了 Elastic Cloud 就能一指搞定。

## Beats 跟 Logstash 都跟資料蒐集有關，兩者有什麼差別??

參考資料：

  - [Powering Data Search, Log Analysis, Analytics \| Elastic](https://www.elastic.co/products) 這裡 Beats 跟 Logstash 並列，用途一樣?

## 新手上路 ?? {: #getting-started }

  - [Getting Started with Elasticsearch \| Elastic](https://www.elastic.co/webinars/getting-started-elasticsearch) #ril
      - 官方的 video (要給 email 才能看) 會提及 Elasticsearch 的安裝、CRUD RESTful API 的操作、文字分析 (斷詞 tokenization 及 filtering)、簡單的 search query；最後 Aggregations: the faceting and analytics workhorse of Elasticsearch 指的是什麼??
      - 01:50 介紹 Elastic Stack -- 最外層是 Kibana (Visualize & Manage)，Elasticsearch (Store, Search & Analyze) 居於核心，背後可以有 Beats 與 Logstash，都是用來將資料餵進、或吸納 (ingest) 進 Elasticsearch -- 安排在 server 上的 lightweight data shipper。
      - 在 Elastic Stack 的上方提到一些應用 (solution) -- App Search、Site Search、Enterprise Search、Logging、Metrics、APM (Application Performance Monitoring)、Business Analytics、Security Analytics。
      - 03:23 為什麼 Elasticsearch 這麼受歡迎? Distributed & Scalable、Highly Available、Multi-tenancy??、Developer Friendly、Real-time, Full-text Search、Aggregations
      - 04:35 開始講 deployment options，首先是 [Elastic Cloud](https://cloud.elastic.co)，按 Create deployment 可以選擇佈署到 AWS 或 GCP。
      - 05:43 講手動下載 Elasticsearch 安裝，示範下載 TAR 檔 (而非 Docker)；解開後主要的執行檔是 `bin/elasticsearch` (預設在 9200 port 服務)，而 `config/` 下主要的設定檔有 `elasticsearch.yml` 及 `jvm.options`。
      - 09:05 手動下載 Kibana (分平台有不同的 distribution) -- 要用它的 Dev Tools > Console，解開後主要的執行檔是 `bin/kibana`，而 `config/` 下只有一支組態檔 `kibana.yml`。透過 `bin/kinana` 啟動 Kibana server，在 http://localhost:5601 可以看到管理界面。
      - Kibana > Dev Tools 一開始會提示 The Console UI is split into two panes: an editor pane (left) and a response pane (right). Use the editor to type requests and submit them to Elasticsearch. The results will be displayed in the response pane on the right side. 按 Get to work 就可以開始用；Console understands requests in a compact format, similar to cURL: 例如 `PUT index/type/1 { ... }` 這點還滿方便的。
  - [Curl - Client Libraries - Elasticsearch: RESTful, Distributed Search & Analytics \| Elastic](https://www.elastic.co/products/elasticsearch#Curl) #ril
  - [Getting Started \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started.html) #ril
  - [List All Indices \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/_list_all_indices.html) #ril
  - [Create an Index \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/_create_an_index.html#_create_an_index) #ril
  - [Index and Query a Document \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/_index_and_query_a_document.html) #ril
  - [Delete an Index \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/_delete_an_index.html) #ril

  - [Elasticsearch in 5 minutes \- Elasticsearch Tutorial\.com](http://www.elasticsearchtutorial.com/elasticsearch-in-5-minutes.html) #ril
  - [Elasticsearch in an Hour \- YouTube](https://www.youtube.com/watch?v=UPkqFvjN-yI) 推薦看一下，Relevant Search 的作者，釐清了一些觀念 — analysis, aggregation … #ril

## Node, Cluster ??

  - [Elasticsearch: RESTful, Distributed Search & Analytics \| Elastic](https://www.elastic.co/products/elasticsearch) Scalability 提到 you talk to Elasticsearch running on a single node the same way you would in a 300-node cluster.

  - [Cluster - Basic Concepts \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-concepts.html#_cluster)
      - A cluster is a collection of one or more nodes (servers) that together holds your entire data and provides FEDERATED indexing and search capabilities across all nodes. 重點是 cluster 裡的 nodes 從外面看起來像是個整體，內部 nodes 間則相互合作。
      - A cluster is identified by a unique name which by default is "`elasticsearch`". This name is important because a node CAN ONLY BE PART OF A CLUSTER if the node is set up to join the cluster by its name. 每個 cluster 用不同的名稱識別 (預設是 `elasticsearch`)，如果 node 是透過 cluster name 加入 cluster，這個名字就很重要，因為一個 node 只能屬於一個 cluster (就算 cluster 裡只有 single node 也沒關係)。例如 `logging-dev`、`logging-prod` 把不同環境的 cluster 拆分開來。
      - Make sure that you don’t reuse the same cluster names in different environments, otherwise you might end up with nodes JOINING THE WRONG CLUSTER. For instance you could use `logging-dev`, `logging-stage`, and `logging-prod` for the development, staging, and production clusters. 什麼情況下同名的 cluster 會知道對方的存在??
      - Note that it is valid and perfectly fine to have a cluster with only a SINGLE NODE in it. Furthermore, you may also have multiple independent clusters each with its own unique cluster name.

  - [Node - Basic Concepts \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-concepts.html#_node)
      - A node is a single server that is part of your cluster, stores your data, and participates in the cluster’s indexing and search capabilities.
      - Just like a cluster, a node is identified by a name which by default is a random Universally Unique IDentifier (UUID) that is assigned to the node at startup. You can define any node name you want if you do not want the default. This name is important for administration purposes where you want to identify which servers in your network correspond to which nodes in your Elasticsearch cluster. 什麼情況下會需要知道對應??
      - A node can be configured to join a specific cluster by the cluster name. By default, each node is set up to join a cluster named `elasticsearch` which means that if you start up a number of nodes on your network and—assuming they can DISCOVER EACH OTHER—they will all automatically form and join a single cluster named `elasticsearch`.
      - In a single cluster, you can have as many nodes as you want. Furthermore, if there are no other Elasticsearch nodes currently running ON YOUR NETWORK, starting a single node will by default FORM A NEW SINGLE-NODE CLUSTER named `elasticsearch`. 找不到其他人就自立為王了。

  - [Life Inside a Cluster \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/2.x/distributed-cluster.html) #ril
      - Elasticsearch is built to be always available, and to scale with your needs. Scale can come from buying bigger servers (VERTICAL scale, or SCALING UP) or from buying more servers (HORIZONTAL scale, or SCALING OUT).
      - While Elasticsearch can benefit from more-powerful hardware, vertical scale HAS ITS LIMITS. Real scalability comes from horizontal scale—the ability to add more nodes to the cluster and to SPREAD LOAD AND RELIABILITY between them. 很重要的觀念!! scale up 並沒有真的提昇 scalability。
      - With most databases, scaling horizontally usually requires a major OVERHAUL of your application to take advantage of these extra boxes. In contrast, Elasticsearch is distributed BY NATURE: it knows how to manage multiple nodes to provide scale and high availability. This also means that your application doesn’t need to care about it. 就算只有一個 node，面對的也是 (single-node) cluster

  - [An Empty Cluster \| Elasticsearch: The Definitive Guide \[2\.x\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/2.x/_an_empty_cluster.html) #ril
      - A node is a running instance of Elasticsearch, while a cluster consists of one or more nodes with the same `cluster.name` that are working together to share their DATA AND WORKLOAD. As nodes are added to or removed from the cluster, the cluster reorganizes itself to spread the data EVENLY.
      - One node in the cluster is ELECTED to be the master node, which is in charge of managing CLUSTER-WIDE CHANGES like creating or deleting an index, or adding or removing a node from the cluster. The master node does not need to be involved in DOCUMENT-LEVEL CHANGES OR SEARCHES, which means that having just one master node will NOT BECOME A BOTTLENECK as traffic grows. Any node can become the master. Our example cluster has only one node, so it performs the master role. 只有 cluster-wide changes 才要經過 master node，所以不會成為瓶頸；由於每個 node 都知道 document 放哪，所以搜尋不一定要透過 master。
      - As users, we CAN TALK TO ANY NODE in the cluster, including the master node. EVERY NODE KNOWS WHERE EACH DOCUMENT LIVES and can FORWARD our request directly to the nodes that hold the data we are interested in. Whichever node we talk to manages the process of gathering the response from the node or nodes holding the data and returning the final response to the client. It is all managed TRANSPARENTLY by Elasticsearch.

  - [Shards & Replicas - Basic Concepts \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/_basic_concepts.html#getting-started-shards-and-replicas) #ril
  - [Exploring Your Cluster \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/_exploring_your_cluster.html) #ril
  - [Installation \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/_installation.html) 看到 "now we are ready to start our node and single cluster" 及 "elected itself as a master in a single cluster" 的說法。
  - [Cluster Health \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/_cluster_health.html) #ril

## Index, Document ??

  - [Index - Basic Concepts \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/_basic_concepts.html#_index)
      - An index is a collection of DOCUMENTS that have somewhat SIMILAR CHARACTERISTICS. 例如 customer data、product catalog 可以是不同的 index；聽起來像是 database 裡的 table。
      - Index 用 name 來識別，必須全部小寫，之後 indexing/search/update/delete 裡面的 document 時都會用到它。
      - A type used to be a LOGICAL category/partition of your index to allow you to store different types of documents in the same index ... 在 6.0 已被標示為棄用，感覺好像沒什麼必要?
  - [Document - Basic Concepts \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/_basic_concepts.html#_document)
      - A document is a BASIC UNIT of information that can be indexed. 而這份 document 用 JSON 來表達。
      - Note that although a document physically resides in an index, a document actually must be indexed/assigned to a TYPE inside an index. 看來以前 index 下的 type 是必要的。

## Networking, HTTP, Transport ??

  - [Network Settings \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-network.html) #ril
  - [HTTP \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-http.html) 這個 module 透過 HTTP 揭露 Elasticsearch API #ril
  - [Transport \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-transport.html) #ril
      - Transport module 用於 cluster 內部 nodes 間的溝通；例如一個 node 接到 HTTP GET request 時，可能因為資料在另一個 node，所以透過 transport 把 request 交給另一個 node 處理。

## Scripting ??

  - [Scripting \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-scripting.html) #ril
  - [Painless Scripting Language \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-scripting-painless.html) #ril

## Plugin ??

  - [Plugins \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-plugins.html) Plugin 可以強化 Elasticsearch 的功能。
  - [Elasticsearch Plugins and Integrations \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/plugins/current/index.html) #ril

## Configuration ??

  - [Configuring Elasticsearch \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/settings.html) #ril
  - [Setting JVM options \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/jvm-options.html) #ril

## Development Mode, Production Mode ??

  - [Development vs. production mode - Bootstrap Checks \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/bootstrap-checks.html#_development_vs_production_mode) #ril
  - [Running Elasticsearch from the command line - Install Elasticsearch with Docker \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-cli-run) #ril
      - Production mode 要將 `vm.max_map_count` kernel setting 設為 262144 以上，做法根據平台不同，所以是設定在 Docker host 上
  - [Notes for production use and defaults - Install Elasticsearch with Docker \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#_notes_for_production_use_and_defaults) #ril

## Pipeline ??

  - [Kibana: Explore, Visualize, Discover Data \| Elastic](https://www.elastic.co/products/kibana) Apps & UIs for Ingestion and Beyond 提到 MANAGE PIPELINES
  - [Pipeline Definition \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/pipeline.html) #ril

## Data Rollup ??

  - [Kibana: Explore, Visualize, Discover Data \| Elastic](https://www.elastic.co/products/kibana) Apps & UIs for Ingestion and Beyond 提到 ROLLUPS MANAGEMENT UI
  - [Data Rollups in Elasticsearch: You Know, for Saving Space \| Elastic](https://www.elastic.co/blog/data-rollups-in-elasticsearch-you-know-for-saving-space) (2018-03-29) #ril

## SQL Access ??

  - [SQL - Client Libraries - Elasticsearch: RESTful, Distributed Search & Analytics \| Elastic](https://www.elastic.co/products/elasticsearch#SQL) 用 SQL 也可以查詢 Elasticsearch 裡的資料 #ril
  - [SQL Access \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/xpack-sql.html) X-Pack includes a SQL feature to execute SQL against Elasticsearch indices and return results in tabular format. 還在實驗階段 #ril

## Enterprise/Site/Application Search ??

  - [Enterprise Search with Elasticsearch \| Elastic](https://www.elastic.co/solutions/enterprise-search) #ril
  - [App Search with Elasticsearch \| Elastic](https://www.elastic.co/solutions/app-search) #ril
  - [Site Search with Elasticsearch & Swiftype \| Elastic](https://www.elastic.co/solutions/site-search) #ril

## Business Analytics ??

  - [Business Analytics with Elasticsearch \| Elastic](https://www.elastic.co/solutions/business-analytics) #ril

## Monitoring ??

  - [Monitoring: Monitor and Manage Elasticsearch \| Elastic](https://www.elastic.co/products/stack/monitoring) #ril
  - [Open Source APM with Elasticsearch \| Elastic](https://www.elastic.co/solutions/apm) #ril
  - [Analyze Metrics with Elasticsearch \| Elastic](https://www.elastic.co/solutions/metrics) 跟 Prometheus 重疊? #ril
  - [Security Analytics with Elasticsearch \| Elastic](https://www.elastic.co/solutions/security-analytics) Don’t Throw Data Out, Throw It All In 這觀點很特別，有資料才能分析 #ril
  - [Logging with Elasticsearch & Elastic Stack \| Elastic](https://www.elastic.co/solutions/logging) 跟 Splunk 重疊? #ril

## Machine Learning ??

  - [Unsupervised Machine Learning for Elasticsearch \| Elastic](https://www.elastic.co/products/stack/machine-learning) #ril

## Security ??

  - [Getting Started with Security \| X\-Pack for the Elastic Stack \[6\.2\] \| Elastic](https://www.elastic.co/guide/en/x-pack/current/security-getting-started.html)
  - [Security settings in Elasticsearch \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-settings.html) 預設的密碼是 `changeme` #ril

## 安裝設定 {: #installation }

  - 至少要有 Oracle 或 OpenJDK 的 Java 8 (或 1.8.0_131 以上的版本)。
  - 從 [Download Elasticsearch](https://www.elastic.co/downloads/elasticsearch) 下載 TAR/ZIP，解開後執行 `bin/elasticsearch` 即可；`config/jvm.options` 預設是針對 64-bit server JVM，若採用 32-bit client JVM 要另外調整。
  - 預設在 `localhost:9200` 服務，可以用 `curl http://localhost:9200` 檢查。

---

參考資料：

  - [Installation \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/_installation.html) Java 8、如何安裝、在 log 裡觀察 node & cluster #ril
      - 需要 Java 8 (建議 1.8.0_131)
      - 從 [Download Elasticsearch](https://www.elastic.co/downloads/elasticsearch) 下載 TAR/ZIP，解開後執行 `bin/elasticsearch` 即可。
      - 從 log 可以觀察到，一開始在初始化 node，有類似 `NF6tgOz` 的 node name，然後被選為 cluster 的 master；重點是 "one node within one cluster"，若要自訂 node/cluster name 可以用 command line 參數自訂，例如 `./elasticsearch -Ecluster.name=my_cluster_name -Enode.name=my_node_name`。
  - [Download Elasticsearch Free • Get Started Now \| Elastic](https://www.elastic.co/downloads/elasticsearch) 有 ZIP、TAR、DEB、RPM 及 MSI 可供選擇；似乎 ZIP/TAR 最單純? 解開後執行 `bin/elasticsearch`，`curl http://localhost:9200/` 就能看到 JSON 的回應。
  - [Set up Elasticsearch \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/setup.html) 支持 Oracle's Java 與 OpenJDK，建議 1.8.0_131 以後的版本，可以用 `JAVA_HOME` 環境變數來指定使用的 Java 版本。預設組態為 64-bit server JVM，若採用 32-bit client JVM，要調整 `config/jvm.options` 的設定。
  - [Install Elasticsearch with \.zip or \.tar\.gz \| Elasticsearch Reference \[5\.6\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/5.6/zip-targz.html) 說明目錄結果、如何執行為 daemon #ril
  - [Installing Elasticsearch \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/install-elasticsearch.html) ZIP 跟 tarball 是最簡單的方式，若需要大量佈署，也提供 configuration management tools 的支援 - Puppet、Chef、Ansible。
  - [Get Started with Elasticsearch, Kibana, and the Elastic Stack \| Elastic](https://www.elastic.co/start) 似乎建議同時安裝 Elasticsearch 與 Kibana (做為 Elasticsearch 的 UI)，並加裝 X-Pack (security、monitoring)，同時啟動...

### Docker

```
$ docker volume create esdata
$ docker run \
    -v esdata:/usr/share/elasticsearch/data \
    -p 9200:9200 -p 9300:9300 \
    -e "discovery.type=single-node" \
    docker.elastic.co/elasticsearch/elasticsearch:6.4.2
```

參考資料：

  - [library/elasticsearch \- Docker Hub](https://hub.docker.com/r/library/elasticsearch/)
      - For Elasticsearch versions prior to 6.4.0 a full list of images, tags, and documentation can be found at docker.elastic.co. 之前有一陣說 image 改從 www.docker.elastic.co 提供，之後又改回來了；不過 www.docker.elastic.co/ 整理得更清楚。
  - [Docker @ Elastic](https://www.docker.elastic.co/) 官方主動提供所有產品的 Docker image，並將它視為 first-class distribution format。
  - [Install Elasticsearch with Docker \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)
      - 官方提供[所有產品的 Docker image](https://www.docker.elastic.co/) (採 Elastic license 免費使用)，以 `centos:7` 為 base image，放在自家的 Elastic Docker registry -- `docker.elastic.co`。
      - 提到 "Alternatively, you can download other Docker images that contain only features available under the Apache 2.0 license."，但 https://www.docker.elastic.co/ 並沒有看到其他的連結??
      - Development mode 用 `docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.4.2` 執行，其中 9200 是 Elasticsearch 服務，那 9300 呢?? (似乎跟 cluster 有關?) 又 `discovery.type=single-node` 這個環境變數是在控制什麼??
      - 雖然 `docker-compose.yml` 配置的是 cluster，但可以發現 Elasticsearch 的資料位在 `/usr/share/elasticsearch/data`，而且每個 node 的 volume 都是分開的。
  - [Configuring Elasticsearch with Docker - Install Elasticsearch with Docker \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-configuration-methods)
      - Elasticsearch 會從 `/usr/share/elasticsearch/config/` 下面載入 config files；除了提供自訂的 `elasticsearch.yml` 外，image 支援其他方式設定 Elasticsearch。
      - A. Present the parameters via Docker environment variables: 例如 `docker run -e "cluster.name=mynewclustername"`。
      - B. Bind-mounted configuration: 透過 bind mount 把自訂的 `elasticsearch.yml` 掛進 container 裡特定的位置，例如 `-v full_path_to/custom_elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml`。
      - C. Customized image: 有些情況可以準備自己的 image (`FROM docker.elastic.co/elasticsearch/elasticsearch:6.4.2`)，事先把 `elasticsearch.yml` 及 plugin 安裝進去；但要怎麼裝??
      - D. Override the image’s default CMD: 由於 options 可以透過 command-line 傳入，可以用 `docker run ... bin/elasticsearch` 覆寫 `CMD`，後面再串上其他 command-line options，例如 `-Ecluster.name=mynewclustername`。
  - [Encrypting Communications in an Elasticsearch Docker Container \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/configuring-tls-docker.html) #ril
  - [Docker for Elasticsearch, Kibana, and Logstash \| Elastic](https://www.elastic.co/elasticon/conf/2017/sf/why-contain-yourself-official-elastic-stack-for-docker) 官方工程師在 Elastic{ON} 2017 上說明 Elastic Docker team 在這方面的努力 #ril

### Ansible ??

  - [Installing Elasticsearch \| Elasticsearch Reference \[6\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/install-elasticsearch.html) 官方提供 confiugration management tools 的支援，包括 Puppet、Chef、Ansible。
  - [elastic/ansible\-elasticsearch: Ansible playbook for Elasticsearch](https://github.com/elastic/ansible-elasticsearch) #ril

## 參考資料 {: #reference }

  - [Elasticsearch](https://www.elastic.co/products/elasticsearch)
  - [elastic/elasticsearch - GitHub](https://github.com/elastic/elasticsearch)
  - [Docker @ Elastic](https://www.docker.elastic.co/) ([elastic/elasticsearch-docker - GitHub](https://github.com/elastic/elasticsearch-docker))
  - [Elastic Blog](https://www.elastic.co/blog)

社群：

  - [Elasticsearch Forum - Elastic Stack](https://discuss.elastic.co/c/elasticsearch)
  - ['elasticsearch' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/elasticsearch)

文件：

  - [Elasticsearch Reference](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)

書籍：

  - [Elasticsearch Reference 5.6 | Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)
  - [The Definitive Guide 2.x | Elastic](https://www.elastic.co/guide/en/elasticsearch/guide/current/index.html)
  - [Elasticsearch in Action - Manning](https://www.manning.com/books/elasticsearch-in-action) (2015-11)

更多：

  - [Indexing](elasticsearch-indexing.md)
  - [Analysis](elasticsearch-analysis.md)
  - [Query](elasticsearch-query.md)

手冊：

  - [Glossary of terms](https://www.elastic.co/guide/en/elasticsearch/reference/current/glossary.html)
  - [Release Notes](https://www.elastic.co/guide/en/elasticsearch/reference/current/es-release-notes.html)
