# Kafka

  - [Introduction - Apache Kafka](https://kafka.apache.org/intro) #ril

      - Apache Kafka® is a DISTRIBUTED STREAMING platform. A streaming platform has three key capabilities:

          - PUBLISH and SUBSCRIBE to STREAMS OF RECORDS, similar to a MESSAGE QUEUE or enterprise MESSAGING system.
          - Store streams of records in a fault-tolerant durable way.
          - Process streams of records as they occur.

      - Kafka is generally used for two broad classes of applications:

          - Building real-time streaming DATA PIPELINES that reliably get data BETWEEN SYSTEMS or applications
          - Building real-time streaming applications that TRANSFORM OR REACT TO the streams of data

      - To understand how Kafka does these things, let's dive in and explore Kafka's capabilities from the bottom up. First a few concepts:

          - Kafka is run as a CLUSTER on one or more servers that can SPAN MULTIPLE DATACENTERS.
          - The Kafka cluster stores streams of records IN CATEGORIES CALLED TOPICS.
          - Each record consists of a KEY, a VALUE, and a TIMESTAMP.

      - Kafka has four core APIs:

          - The Producer API allows an application to PUBLISH a stream of records to one or more Kafka topics.

            The Consumer API allows an application to SUBSCRIBE to one or more topics and process the stream of records produced to them.

            Producer/Consumer API 其 publish/subscribe 的對象都是 topic。

          - The Streams API allows an application to act as a STREAM PROCESSOR, consuming an INPUT STREAM from one or more topics and producing an OUTPUT STREAM to one or more OUTPUT TOPICS, effectively transforming the input streams to output streams.

            本身同時扮演 consumer 與 producer，也就是 input stream --> consumer (stream processor --> output stream。

          - The Connector API allows building and running REUSABLE PRODUCERS OR CONSUMERS that connect Kafka topics to existing applications or data systems. For example, a connector to a relational database might CAPTURE EVERY CHANGE TO A TABLE.

      - In Kafka the communication between the clients and the servers is done with a simple, high-performance, LANGUAGE AGNOSTIC TCP PROTOCOL. This protocol is versioned and maintains backwards compatibility with older version.

        We provide a Java client for Kafka, but clients are available in many languages.

## 新手上路 {: #getting-started }

  - [Getting Started - Apache Kafka](https://kafka.apache.org/documentation.html#gettingStarted) #ril

## 參考資料 {: #reference }

  - [Apache Kafka](http://kafka.apache.org/)
