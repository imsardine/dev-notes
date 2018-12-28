# Kibana

  - 初看覺得 Elasticsearch + Kibana 跟 Prometheus + Grafana 的同質性很高？
      - Prometheus 定位 reliability > 100% accurate data，而且不接受自訂 timestamp，無法事後匯入數據再做分析，數據也只接受數值。
      - Grafana 主要是將 time series (數值) 視覺化，可以用來監測各項指標 (metrics) 的高低變化，但 Kibana 除此之外還可以分析/匯整更不一樣的資料類型，而且不一定要是 time series。
      - 總的來說，Prometheus + Grafana 適合做 system monitoring (舊數據不見也沒關係)，而 Elasticsearch + Kibana 除了 system monitoring，更適合用在 (business) operation 上的數據分析 (長期數據很重要)，如果有匯整出一些 time series，透過 Grafana 顯示也是可以的。

---

參考資料：

  - [Kibana: Explore, Visualize, Discover Data \| Elastic](https://www.elastic.co/products/kibana)
      - Your Window into the Elastic Stack: Kibana lets you VISUALIZE your Elasticsearch data and navigate the Elastic Stack. 不只是 Elasticsearch 的前端，而是整個 Elastic Stack；Kibana 自己在裡面的定位是 reporting。
      - A Picture's Worth a Thousand Log Lines: Kibana gives you the freedom to select the way you give SHAPE to your data. And you DON’T ALWAYS HAVE TO KNOW WHAT YOU'RE LOOKING FOR. With its interactive visualizations, start with one question and see where it leads you. 從圖形上比較容易看出一些東西，順著往下找...
      - Start with the Basics: Kibana core ships with the classics: histograms, line graphs, pie charts, sunbursts, and more. Plus, you can use [Vega grammar](vega-grammar.md) to design your own visualizations.
      - Put Geo Data on Any Map: Leverage the Elastic Maps Service (內建在 Kibana?) to visualize geospatial data, or get creative and visualize custom location data on a schematic of your choosing.
      - Time Series Is Also on the Menu: Perform advanced time series analysis on your Elasticsearch data with our curated time series UIs. Describe queries, transformations, and visualizations with powerful, easy-to-learn expressions. 若 Kibana 自己可以表現 time series，為什麼 Grafana 也提供 Elasticsearch data source? => Grafana 可以通吃不同的資料來源。
      - Analyze Relationships with Graph: Take the RELEVANCE capabilities of a search engine, combine them with GRAPH EXPLORATION (也是 Stack 的一員), and uncover the uncommonly common relationships in your Elasticsearch data.
      - Explore Anomalies with Machine Learning: Detect the anomalies hiding in your Elasticsearch data and explore the properties that significantly influence them with unsupervised machine learning features. 透過 machine learning 偵測異常。
      - Get Creative with Canvas: Go beyond the grid. Infuse your style into the STORY OF YOUR DATA with the logos, colors, and design elements that make your brand unique. Canvas (也是 Stack 的一員) is where you can get creative with your live data — and it supports SQL. 產生美美的簡報素材，數據不一定要以格子呈現。
      - Bring Everyone in on the Goodness. Easily share Kibana visualizations with your team members, ... Embed a dashboard, share a link, or export to PDF or CSV files and send as an attachment. Or organize your dashboards and visualizations into Kibana SPACEs. Invite users into certain spaces (and not others) using ROLE-BASED ACCESS CONTROL. 首先要讓視覺化的數據容易取得，然後不同的觀點會引發不同的思考...
      - Apps & UIs for Ingestion and Beyond: The tools you need to start INGESTING DATA are ready (and eagerly awaiting your arrival) on the Kibana home screen. With Kibana, the command line is no longer the only way to manage security settings, rollup your data, or configure additional Elastic Stack features. 除了餵資料，也做為 Elastic Stack 的管理介面 (以前只有 command line)，下面提到 Manage Pipelines、Rollups Management UI ...
  - Kibana 的唸法，開頭是 `[kə]` 還是 `[kɪ]`? 拿[官方的影片](https://www.elastic.co/videos)來聽最準；比較下來，多數人是唸 `[kə]`，但也是有人唸 `[kɪ]`，應該都可以。
      - [Kibana Spaces: Organize \(and Secure\) Your Dashboards and Saved Objects \| Elastic](https://www.elastic.co/webinars/introduction-to-kibana-spaces?view=1) 唸 `[kɪ]`。
      - [Intro to Canvas: A new way to tell visual stories in Kibana \| Elastic](https://www.elastic.co/webinars/intro-to-canvas-a-new-way-to-tell-visual-stories-in-kibana?view=1) 唸 `[kə]`。
  - [Introduction \| Kibana User Guide \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/kibana/current/introduction.html)
      - Kibana is an open source ANALYTICS and visualization platform designed to work with Elasticsearch. You use Kibana to search, view, and interact with data stored in Elasticsearch indices. 首先資料要先進到 Elasticsearch 裡
      - Kibana makes it easy to UNDERSTAND large volumes of data.
  - [Reporting: Export Kibana Visualizations \| Elastic](https://www.elastic.co/products/stack/reporting) #ril

## 新手上路 {: #getting-started }

  - [Get Started with Elasticsearch, Kibana, and the Elastic Stack \| Elastic](https://www.elastic.co/start) 同時安裝 Elasticsearch 與 Kibana，然後透過 Kibana 來操作 Elasticsearch。
  - [Getting Started \| Kibana User Guide \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/kibana/current/getting-started.html)
      - 分為 Explore Kibana using the Flights dashboard 與 Build your own dashboard 兩塊，但後者沒講什麼。
      - 第一次啟動 Kibana 時，若發現 Elasticsearch 裡沒有資料，就會提示 "We noticed that you don't have any data in your cluster. You can try our sample data and dashboards or jump in with your own data." 按下 Try our sample data 後，Add Data to Kibana 有 Sample eCommerce orders、Sample flight data、Sample web logs 可以加，其中 Sample flight data 就是 Getting Started 會帶的範例。
  - [Explore Kibana using the Flight dashboard \| Kibana User Guide \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/kibana/current/tutorial-sample-data.html) On the home page, click the link next to Sample data. On the Sample flight data card, click Add. You’re taken to the Global Flight dashboard, a collection of charts, graphs, maps, and other visualizations of the the data in the `kibana_sample_data_flights` index. 另外看到 Upload data from log file (Import a CSV, NDJSON, or log file) 資料不用先進 Elasticsearch 也可以分析??
  - [Filtering the data \| Kibana User Guide \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/kibana/current/tutorial-sample-filter.html)
      - Many visualizations in the Global Flight dashboard are interactive. You can apply FILTERs to modify the view of the data ACROSS ALL VISUALIZATIONs. 看來 Kibana 習慣將畫面上的 widget/panel 稱做 visualization，而且背後共用一份 query/filtering 的結果。
      - In the Controls visualization, set an Origin City (`OriginCityName`) and a Destination City (`DestCityName`). 這表示 dashboard 也可以自訂查詢的介面，讓一般使用者直接面對 index。
      - You can also add filters manually. In the filter bar, click Add a Filter and specify the data you want to view. 直接描述 index 裡各 field 的過濾條件，也可以寫 Query DSL。
  - [Querying the data \| Kibana User Guide \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/kibana/current/tutorial-sample-query.html)
      - You can enter an Elasticsearch query to narrow the view of the data. 例如 `OriginCityName:Rome` 或更複雜的 `OriginCityName:Rome AND (Carrier:JetBeats OR "Kibana Airlines")`；若要達成同上述 Controls visualization 的操作，可以寫成 `OriginCityName:London AND (DestCityName:Newark OR Pittsburgh)`。
      - When you are finished exploring the dashboard, remove the query by clearing the contents in the query bar and pressing Enter. 清空 query bar 再按 Enter 不是那麼直覺。
      - In general, filters are faster than queries. 原來 query 與 filter 不同!! 主要差別在於 query 會計算 score；發現同時使用會互相影響，兩者是什麼關係??
  - [Using Discover \| Kibana User Guide \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/kibana/current/tutorial-sample-discover.html) #ril
  - [Getting Started with Kibana \| Elastic](https://www.elastic.co/webinars/getting-started-kibana) 定位在 "a window into the Elastic Stack" - data exploration??、visualization、dashboarding 提供 emial 後才能看到影片 #ril

## Console ??

  - [Console \| Kibana User Guide \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/kibana/current/console-kibana.html) 方便寫 HTTP method、endpoint (不用寫 host) 跟 JSON body，也有 auto-completion (或 suggestion)，可以省下很多工 #ril
  - [Kibana: Explore, Visualize, Discover Data \| Elastic](https://www.elastic.co/products/kibana) DEV TOOLS 提到 With Console, you can bypass using curl from the terminal and tinker with your Elasticsearch data directly.

## Search Profiler ??

  - [Kibana: Explore, Visualize, Discover Data \| Elastic](https://www.elastic.co/products/kibana) DEV TOOLS 提到 The Search Profiler lets you easily see where time is spent during search requests.
  - [A Profile a Day Keeps the Doctor Away: The Elasticsearch Search Profiler \| Elastic](https://www.elastic.co/blog/a-profile-a-day-keeps-the-doctor-away-the-elasticsearch-search-profiler) (2016-12-22) #ril

## Grok Debugger ??

  - [Kibana: Explore, Visualize, Discover Data \| Elastic](https://www.elastic.co/products/kibana) DEV TOOLS 提到 And authoring complex GROK PATTERNs in your Logstash configuration becomes a breeze with the Grok Debugger. 從 log line 取出資料並將其結構化的 pattern。

## Configuration ??

  - [Configuring Kibana \| Kibana User Guide \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/kibana/current/settings.html) #ril

## 疑難排解 {: #troubleshooting }

### No endpoint or operation is available at [_xpack]

若 Kibana 連接的 Elasticsearch 沒有停用 X-Pack，但又沒有載入 X-Pack plugin 的話，會出現下面的錯誤：

```
  log   [03:56:55.977] [warning][license][xpack] License information could not be obtained from Elasticsearch. [illegal_argument_exception] No endpoint or operation is available at [_xpack] :: {"path":"/_xpack","statusCode":400,"response":"{\"error\":{\"root_cause\":[{\"type\":\"illegal_argument_exception\",\"reason\":\"No endpoint or operation is available at [_xpack]\"}],\"type\":\"illegal_argument_exception\",\"reason\":\"No endpoint or operation is available at [_xpack]\"},\"status\":400}"}
Unhandled rejection [illegal_argument_exception] No endpoint or operation is available at [_xpack] :: {"path":"/_xpack","statusCode":400,"response":"{\"error\":{\"root_cause\":[{\"type\":\"illegal_argument_exception\",\"reason\":\"No endpoint or operation is available at [_xpack]\"}],\"type\":\"illegal_argument_exception\",\"reason\":\"No endpoint or operation is available at [_xpack]\"},\"status\":400}"}
    at respond (/usr/share/kibana/node_modules/elasticsearch/src/lib/transport.js:295:15)
    at checkRespForFailure (/usr/share/kibana/node_modules/elasticsearch/src/lib/transport.js:254:7)
    at HttpConnector.<anonymous> (/usr/share/kibana/node_modules/elasticsearch/src/lib/connectors/http.js:157:7)
    at IncomingMessage.bound (/usr/share/kibana/node_modules/elasticsearch/node_modules/lodash/dist/lodash.js:729:21)
    at emitNone (events.js:91:20)
    at IncomingMessage.emit (events.js:185:7)
    at endReadableNT (_stream_readable.js:974:12)
    at _combinedTickCallback (internal/process/next_tick.js:80:11)
    at process._tickCallback (internal/process/next_tick.js:104:9)
```

由於 Elasticsearch image 裡內建 X-Pack plugin：

```
$ docker run --rm -it --entrypoint= \
  docker.elastic.co/elasticsearch/elasticsearch:5.4.3 \
  bash -c 'ls -l /usr/share/elasticsearch/plugins'
total 12
drwxr-xr-x 2 elasticsearch elasticsearch 4096 Jun 27  2017 ingest-geoip
drwxr-xr-x 2 elasticsearch elasticsearch 4096 Jun 27  2017 ingest-user-agent
drwxr-xr-x 4 elasticsearch elasticsearch 4096 Jun 27  2017 x-pack
```

硬是把它拿掉的話會有問題，要停用 X-Pack 應該從 configuration 下手：

  - Elasticsearch 5.x - 在 Elasticsearch 及 Kibana 兩端都要將 `xpack.security.enabled` 設為 `false`
  - Elasticsearch 6.x - 只要在 Elasticsearch 端將 `xpack.security.enabled` 設為 `false` 即可。

參考資料：

  - [Security Settings in Kibana \| Kibana User Guide \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/kibana/current/security-settings-kb.html)
      - You do not need to configure any additional settings to use X-Pack security in Kibana. It is enabled by default. 也因為 X-Pack 預設啟用的關係，就會被提示要登入。
      - `xpack.security.enabled` - Set to `true` (default) to enable X-Pack security. DO NOT set this to `false`. To disable X-Pack security entirely, see Elasticsearch Security Settings. If set to `false` in `kibana.yml`, the login form, user and role management screens, and authorization using Kibana privileges are disabled. 到底能不能設成 `false`? => 應該由 Elasticsearch 那端停用
  - [General Security Settings - Security Settings \| X\-Pack for the Elastic Stack \[5\.4\] \| Elastic](https://www.elastic.co/guide/en/x-pack/5.4/security-settings.html#general-security-settings) `xpack.security.enabled` - Set to `false` to disable X-Pack security on the node. Configure in BOTH `elasticsearch.yml` and `kibana.yml`. 做法跟 6.x 很不一樣。
  - [General security settings - Security settings in Elasticsearch \| Elasticsearch Reference \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-settings.html#general-security-settings) `xpack.security.enabled` - If set to `false`, which is the default value for basic and trial licenses, security features are disabled. It also affects all Kibana instances that connect to this Elasticsearch instance; you do not need to disable security features in those `kibana.yml` files. 也就是 Kibana 會根據連接的 Elasticsearch 決定要不要啟用 X-Pack 相關的功能，不需要從 Kibana 這端停用。

## 安裝設定 {: #installation }

  - [Download Kibana Free • Get Started Now \| Elastic](https://www.elastic.co/downloads/kibana) 將 `config/kibana.yml` 裡的 `elasticsearch.url` 指向 Elasticsearch instance，然後執行 `bin/kibana`，就可以在 http://localhost:5601 看到 Kibana 的 UI。
  - [Set Up Kibana \| Kibana User Guide \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/kibana/current/setup.html)
      - Since Kibana runs on Node.js, we include the necessary Node.js binaries for these platforms.
      - Kibana should be configured to run against an Elasticsearch node of the same version. This is the officially supported configuration. ... nor is running a minor version of Kibana that is newer than the version of Elasticsearch (e.g. Kibana 5.1 and Elasticsearch 5.0). ... Running different patch version releases of Kibana and Elasticsearch (e.g. Kibana 5.0.0 and Elasticsearch 5.0.1) is generally supported, though we encourage users to run the same versions of Kibana and Elasticsearch down to the patch version. 最好兩邊都用同一個版本，但至少 major.minor 要一樣。
      - Running a minor version of Elasticsearch that is higher than Kibana will generally work in order to facilitate an upgrade process where ELASTICSEARCH IS UPGRADED FIRST (e.g. Kibana 5.0 and Elasticsearch 5.1). 昇級時，Elasticsearch 會先昇，然後才是 Kibana。

### Docker

Elasticsearch + Kibana：

`docker-compose.yml`:

```yaml
version: '3'
services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:6.5.4
    ports: ["9200:9200"]
  kibana:
    image: docker.elastic.co/kibana/kibana:6.5.4
    ports: ["5601:5601"]
```

```
$ docker-compose up
$ open http://localhost:5601
```

---

連接現有的 Elasticsearch：

```
$ ELASTICSEARCH_URL=http://192.168.1.1:9200/
$ docker run --rm -it \
  --env ELASTICSEARCH_URL=$ELASTICSEARCH_URL \
  --publish 5601:5601 \
  docker.elastic.co/kibana/kibana:6.5.4
```

---

參考資料：

  - [Running Kibana on Docker \| Kibana User Guide \[6\.5\] \| Elastic](https://www.elastic.co/guide/en/kibana/current/docker.html)
      - Docker images for Kibana are available from the Elastic Docker registry. The base image is [centos:7](https://hub.docker.com/_/centos/). 雖然 Docker Hub 上也有 [image](https://hub.docker.com/_/kibana/)
      - These images are free to use under the Elastic license. They contain open source and FREE COMMERCIAL FEATURES and access to paid commercial features. Alternatively, you can download other Docker images that contain only features available under the Apache 2.0 license. 商用 Elastic license 會有問題??

            docker pull docker.elastic.co/kibana/kibana:6.5.4

      - One way to configure Kibana on Docker is to provide `kibana.yml` via bind-mounting. With `docker-compose`, the bind-mount can be specified like this: 覆寫 container 裡的 `/usr/share/kibana/config/kibana.yml`；所有文件都沒提到如何將 Kibana 產生的資料掛到 volume??

            version: '2'
            services:
              kibana:
                image: docker.elastic.co/kibana/kibana:6.5.4
                volumes:
                  - ./kibana.yml:/usr/share/kibana/config/kibana.yml

      - Under Docker, Kibana can be configured via environment variables. When the container starts, a helper process checks the environment for variables that can be mapped to Kibana command-line arguments. For compatibility with container orchestration systems, these environment variables are written in all capitals, with underscores as word separators. The helper translates these names to valid Kibana setting names. 只有 Docker image 才能透過環境變數組態，內部會轉譯成 command-line options (覆寫 `kibana.yml` 裡的設定)；全部大寫、用底線當分隔字元，例如 `XPACK_MONITORING_ENABLED` --> `xpack.monitoring.enabled`

            version: '2'
            services:
              kibana:
                image: docker.elastic.co/kibana/kibana:6.5.4
                environment:
                  SERVER_NAME: kibana.example.org
                  ELASTICSEARCH_URL: http://elasticsearch.example.org

      - These settings are defined in the default `kibana.yml`. They can be overridden with a custom `kibana.yml` or via environment variables. If replacing `kibana.yml` with a custom version, be sure to copy the above defaults to the custom file if you want to retain them. If not, they will be "masked" by the new file. 也就

            $ docker run --rm -it --entrypoint= docker.elastic.co/kibana/kibana:6.5.4 bash -c 'cat /usr/share/kibana/config/kibana.yml'
            ---
            # Default Kibana configuration from kibana-docker.

            server.name: kibana
            server.host: "0"
            elasticsearch.url: http://elasticsearch:9200 # 適合搭配 --link xxx:elasticsearch 或 user-defined bridge network 來做
            xpack.monitoring.ui.container.elasticsearch.enabled: true

  - [elastic/kibana\-docker: Official Kibana Docker image](https://github.com/elastic/kibana-docker) #ril
  - [kibana \- Docker Hub](https://hub.docker.com/_/kibana) #ril
  - [Kibana - Docker @ Elastic](https://www.docker.elastic.co/#kibana) #ril

## 參考資料

  - [Kibana | Elastic](https://www.elastic.co/products/kibana)
  - [elastic/kibana - GitHub](https://github.com/elastic/kibana)

社群：

  - [Kibana - Discuss the Elastic Stack](https://discuss.elastic.co/c/kibana)

文件：

  - [Kibana User Guide](https://www.elastic.co/guide/en/kibana/current/index.html)

相關：

  - [Vega Grammar](vega-grammar.md) - 用來自訂 visualization

手冊：

  - [Kibana Configuration Settings](https://www.elastic.co/guide/en/kibana/current/settings.html#settings)
