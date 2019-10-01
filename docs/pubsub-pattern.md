# Publish/Subscribe (Pub/Sub) Pattern

  - [Publish–subscribe pattern \- Wikipedia](https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern) #ril

      - In software architecture, publish–subscribe is a MESSAGING PATTERN where senders of messages, called PUBLISHERS, do not program the messages to be SENT DIRECTLY to specific receivers, called SUBSCRIBERS, but instead CATEGORIZE published messages into classes WITHOUT KNOWLEDGE OF WHICH SUBSCRIBERS, if any, there may be.

        Similarly, subscribers express INTEREST in one or more classes and only receive messages that are of interest, WITHOUT KNOWLEDGE OF WHICH PUBLISHERS, if any, there are.

      - Publish–subscribe is a SIBLING of the MESSAGE QUEUE paradigm, and is typically one part of a larger message-oriented middleware system. Most messaging systems support both the pub/sub and message queue models in their API, e.g. Java Message Service (JMS).

        但 pub/sub 跟 message queue 差在哪裡 ?? 該不會是每個 subscriber 都能收到相同的 message，而 message queue 拿走就沒了?

      - This pattern provides greater NETWORK SCALABILITY and a more dynamic network topology, with a resulting decreased flexibility to modify the publisher and the structure of the published data.

        不要動到 publisher/subscriber 溝通的 data structure 就好，不過就算是直接呼叫對方，data structure 一樣也不能隨便改不是?

    Message filtering

      - In the publish-subscribe model, subscribers typically receive only a SUBSET of the total messages published. The process of selecting messages for reception and processing is called FILTERING. There are two common forms of filtering: topic-based and content-based.

      - In a TOPIC-BASED system, messages are published to "topics" or NAMED LOGICAL CHANNELS. Subscribers in a topic-based system will receive all messages published to the topics to which they subscribe, and all subscribers to a topic will receive the SAME MESSAGES.

        The publisher is responsible for defining the CLASSES of messages to which subscribers can subscribe.

      - In a CONTENT-BASED system, messages are only delivered to a subscriber if the attributes or content of those messages matches CONSTRAINTS DEFINED BY THE SUBSCRIBER. The subscriber is responsible for classifying the messages.

      - Some systems support a hybrid of the two; publishers post messages to a topic while subscribers register content-based subscriptions to one or more topics.

    Topologies

      - In many pub/sub systems, publishers post messages to an intermediary MESSAGE BROKER or EVENT BUS, and subscribers register subscriptions with that broker, letting the broker perform the filtering. The broker normally performs a store and forward function to route messages from publishers to subscribers. In addition, the broker may PRIORITIZE messages in a queue before routing.

      - Subscribers may register for specific messages at build time, initialization time or runtime. In GUI systems, subscribers can be coded to handle user commands (e.g., click of a button), which corresponds to build time registration. 難以想像 build time 如何做 register ??

        Some frameworks and software products use XML configuration files to register subscribers. These configuration files are read at initialization time. The most sophisticated alternative is when subscribers can be added or removed at runtime. This latter approach is used, for example, in database triggers, mailing lists, and RSS.

      - The Data Distribution Service (DDS) middleware does not use a broker in the middle. Instead, each publisher and subscriber in the pub/sub system shares meta-data about each other via IP multicast. The publisher and the subscribers cache this information locally and route messages based on the discovery of each other in the shared cognizance (認知).

    Advantages > Loose coupling

      - Publishers are LOOSELY COUPLED to subscribers, and need not even know of their EXISTENCE.

      - With the topic being the focus, publishers and subscribers are allowed to remain ignorant of system topology. Each can continue to operate as per normal independently of the other.

        In the traditional TIGHTLY COUPLED CLIENT–SERVER PARADIGM, the client cannot post messages to the server while the server process is not running, nor can the server receive messages unless the client is running.

        雖然 "nor can the server receive messages unless the client is running" 聽起來怪怪的，但這裡只是要強調 client & server 要同時都活著才能溝通。

      - Many pub/sub systems decouple not only the LOCATIONS of the publishers and subscribers but also decouple them temporally. A common strategy used by middleware analysts with such pub/sub systems is to take down a publisher to allow the subscriber to work through the backlog (a form of bandwidth throttling). ??

    Advantages > Scalability

      - Pub/sub provides the opportunity for better scalability than traditional client-server, through parallel operation, message caching, tree-based or network-based routing, etc. However, in certain types of tightly coupled, high-volume enterprise environments, as systems scale up to become data centers with thousands of servers sharing the pub/sub infrastructure, current vendor systems often lose this benefit; scalability for pub/sub products under high load in these contexts is a research challenge. ??

      - Outside of the enterprise environment, on the other hand, the pub/sub paradigm has proven its scalability to volumes far beyond those of a single data center, providing Internet-wide distributed messaging through web syndication protocols such as RSS and Atom.

        These syndication protocols accept higher latency and lack of delivery guarantees in exchange for the ability for even a low-end web server to syndicate messages to (potentially) millions of separate subscriber nodes.

  - [What is Pub/Sub Messaging?](https://aws.amazon.com/pub-sub-messaging/)

    What is Pub/Sub Messaging?

      - Publish/subscribe messaging, or pub/sub messaging, is a form of ASYNCHRONOUS SERVICE-TO-SERVICE COMMUNICATION used in serverless and microservices architectures.

        In a pub/sub model, any message published to a topic is IMMEDIATELY received by all of the subscribers to the topic.

        這裡提到 serverless，是要帶出 publisher 送出 message 時，subscriber 不一定要活著的特性?

      - Pub/sub messaging can be used to enable EVENT-DRIVEN architectures, or to DECOUPLE applications in order to increase performance, reliability and scalability.

    Pub/Sub Messaging Basics

      - In modern cloud architecture, applications are decoupled into smaller, independent building blocks that are easier to develop, deploy and maintain. Publish/Subscribe (Pub/Sub) messaging provides INSTANT event notifications for these distributed applications.

      - The Publish Subscribe model allows messages to be BROADCAST TO DIFFERENT PARTS OF A SYSTEM ASYNCHRONOUSLY.

        A sibling to a MESSAGE QUEUE, a message topic provides a lightweight mechanism to broadcast asynchronous event notifications, and endpoints that allow software components to connect to the topic in order to send and receive those messages. To broadcast a message, a component called a publisher simply pushes a message to the topic.

        Unlike message queues, which BATCH MESSAGES UNTIL THEY ARE RETRIEVED, message topics transfer messages with no or very little queuing, and PUSH THEM OUT IMMEDIATELY to all subscribers. All components that subscribe to the topic will receive every message that is broadcast, unless a message filtering policy is set by the subscriber.

        ![Pub/Sub Model](https://d1.awsstatic.com/product-marketing/Messaging/sns_img_topic.e024462ec88e79ed63d690a2eed6e050e33fb36f.png)

        上面 message queue 的連結都在推 SQS，跟這裡 pub/sub messaging 在推 SNS 形成對比。

        感覺在 topic 的機器上有為所有 subscriber 安排 inbox，所以上面才多次提到 publisher 送出的 message 是直接 (immediately) 給 subscriber ?? 就算當時 subscriber 不在線上也沒關係。

      - The subscribers to the message topic often perform different functions, and can each do something different with the message in parallel. The publisher doesn’t need to know who is using the information that it is broadcasting, and the subscribers don’t need to know who the message comes from.

        This style of messaging is a bit different than message queues, where the component that sends the message OFTEN KNOWS ?? the destination it is sending to. For more information on message queuing, see “What is a Message Queue?”

  - [Publisher\-Subscriber pattern \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/architecture/patterns/publisher-subscriber) (2018-12-07)

      - Enable an application to ANNOUNCE EVENTS TO MULTIPLE INTERESTED CONSUMERS ASYNCHRONOUSLY, without coupling the senders to the receivers.

        Also called: Pub/sub messaging

    Context and problem

      - In cloud-based and distributed applications, components of the system often need to provide information to other components AS EVENTS HAPPEN.

      - Asynchronous messaging is an effective way to DECOUPLE SENDERS FROM CONSUMERS, and AVOID BLOCKING THE SENDER TO WAIT FOR A RESPONSE.

        However, using a DEDICATED MESSAGE QUEUE FOR EACH CONSUMER does not effectively scale to many consumers. Also, some of the consumers might be interested in only a SUBSET of the information. How can the sender announce events to all interested consumers without knowing their identities?

        因為 message queue 裡面的 message 被拿走就沒了，沒有多個 receiver 的概念；顯然 pub/sub 至少可以把 "message queue for each consumer" 做得更有效率，但 pub/sub 不僅於此。

    Solution

      - Introduce an asynchronous messaging subsystem that includes the following:

          - An input messaging CHANNEL used by the sender. The sender packages events into messages, using a KNOWN MESSAGE FORMAT, and sends these messages via the input channel. The sender in this pattern is also called the publisher.

            Note: A message is a packet of data. An event is a message that notifies other components about a change or an action that has taken place.

            Sender 跟 receiver 要約定好 message 的格式；有做版本控制的 JSON 應該是不錯的選擇?

          - One output messaging channel PER CONSUMER. The consumers are known as subscribers.

            呼應上面 "a dedicated message queue for each consumer" 的說法，pub/sub 裡還是得為每個 receiver 安排一個 queue/inbox；下面 "copying each message" 解釋了這件事。

          - A mechanism for COPYING each message from the input channel to the output channels for all subscribers interested in that message. This operation is typically handled by an intermediary such as a MESSAGE BROKER or EVENT BUS.

      - The following diagram shows the logical components of this pattern:

        ![Publish-subscribe pattern using a message broker](https://docs.microsoft.com/en-us/azure/architecture/patterns/_images/publish-subscribe.png)

        Pub/sub messaging has the following benefits:

          - It decouples subsystems that still need to communicate. Subsystems can be managed independently, and messages can be properly managed even if one or more receivers are OFFLINE.

          - It increases scalability and improves RESPONSIVENESS OF THE SENDER. The sender can QUICKLY SEND a single message to the input channel, then return to its core processing responsibilities. The messaging infrastructure is responsible for ensuring messages are delivered to interested subscribers.

            確實，若 sender 要確保有送出 receiver 手裡，除了要等結果，還不處理各種例外狀況 (例如重送)；下面最後一點又重申了一次。

          - It improves reliability. Asynchronous messaging helps applications continue to run smoothly under increased loads and handle INTERMITTENT FAILURES more effectively.

          - It allows for DEFERRED OR SCHEDULED PROCESSING. Subscribers can wait to pick up messages until off-peak hours, or messages can be routed or processed according to a specific schedule.

            對 receiver 也是有好處的，不用在 request 進來時馬上處理；雖然 request 進來先放在 queue 也可以。

          - It enables simpler integration between systems using different platforms, programming languages, or communication protocols, as well as between on-premises systems and applications running in the cloud.

          - It facilitates ASYNCHRONOUS WORKFLOWS across an enterprise.

          - It improves testability. Channels can be monitored and messages can be inspected or logged as part of an overall INTEGRATION TEST STRATEGY.

            因為 channel 會形成一個斷點；可以單獨測試進到 channel 裡的 message 是否正確即可，至於 receiver 收到 message 後能否正常處理，那又是另一件事了。

          - It provides SEPARATION OF CONCERNS for your applications. Each application can focus on its core capabilities, while the messaging infrastructure handles everything required to reliably route messages to multiple consumers.

            中間轉送 message 的這個角色要相當穩定，呼應了下面 "rather than building your own" 的說法，就算有像 Redis、RabbitMQ 這類的開源套件，要維持它穩定提供服務也是個問題；從這個角度想，AWS SNS 這類 cloud service 會是更好的選擇?

    Issues and considerations

      - Consider the following points when deciding how to IMPLEMENT this pattern:

          - Existing technologies. It is strongly recommended to use available messaging products and services that support a publish-subscribe model, RATHER THAN BUILDING YOUR OWN. In Azure, consider using Service Bus or Event Grid. Other technologies that can be used for pub/sub messaging include Redis, RabbitMQ, and Apache Kafka.

          - Subscription handling. The messaging infrastructure must provide mechanisms that consumers can use to subscribe to or unsubscribe from available channels.

          - Security. Connecting to any message channel must be restricted by security policy to prevent eavesdropping by unauthorized users or applications.

          - Subsets of messages. Subscribers are usually only interested in subset of the messages distributed by a publisher. Messaging services often allow subscribers to narrow the set of messages received by:

              - Topics. Each topic has a dedicated output channel, and each consumer can subscribe to all relevant topics.
              - Content filtering. Messages are inspected and distributed based on the content of each message. Each subscriber can specify the content it is interested in.

          - Wildcard subscribers. Consider allowing subscribers to subscribe to multiple topics via wildcards.

          - Bi-directional communication. The channels in a publish-subscribe system are treated as UNIDIRECTIONAL.

            If a specific subscriber needs to send acknowledgment or communicate status back to the publisher, consider using the [Request/Reply Pattern](https://www.enterpriseintegrationpatterns.com/patterns/messaging/RequestReply.html). This pattern uses one channel to send a message to the subscriber, and a SEPARATE REPLY CHANNEL for communicating back to the publisher. #ril

            Pub/Sub 本質上是單向的，但搭配另一個專用於回報結果的 channel，就有機會實現雙向溝通。

          - Message ordering. The order in which consumer instances receive messages ISN'T GUARANTEED, and doesn't necessarily reflect the order in which the messages were created.

            Design the system to ensure that message processing is IDEMPOTENT to help eliminate any dependency on the order of message handling.

          - Message priority. Some solutions may require that messages are processed in a specific order. The [Priority Queue Pattern](https://docs.microsoft.com/en-us/azure/architecture/patterns/priority-queue) provides a mechanism for ensuring specific messages are delivered before others. #ril

            這也是 pub/sub 不支援的，否則就違反了上面 message ordering 的說法。

          - Poison messages. A malformed message, or a task that requires access to resources that aren't available, can cause a service instance to fail. The system should prevent such messages being returned to the queue. Instead, capture and store the details of these messages elsewhere so that they can be analyzed if necessary.

            不過這代表中間轉送 message 的角色要知道 message 的格式，這聽起來不太合理 ??

          - Repeated messages. The same message might be sent more than once. For example, the SENDER MIGHT FAIL AFTER POSTING A MESSAGE. Then a new instance of the sender might start up and repeat the message. The messaging infrastructure should implement duplicate message detection and removal (also known as DE-DUPING) based on MESSAGE IDs in order to provide AT-MOST-ONCE DELIVERY of messages.

            也就是 sender 自己要提供 message ID ??

          - Message expiration. A message might have a LIMITED LIFETIME. If it isn't processed within this period, it might no longer be relevant and should be discarded. A sender can specify an expiration time as part of the data in the message.

            A receiver can examine this information before deciding whether to perform the business logic associated with the message.

            既然過期了，receiver 應該就收不到了才是?

          - Message scheduling. A message might be temporarily EMBARGOED and should not be processed until a specific date and time. The message should not be available to a receiver until this time.

            Sender 先送出訊息，但 receiver 在約定的時間之後才拿得到；感覺中間轉送 message 的角色可以做很多控制 ...

    When to use this pattern

      - Use this pattern when:

          - An application needs to broadcast information to a SIGNIFICANT NUMBER OF CONSUMERS.

            下面 "one or more independently-developed ..." 的說法，間接說明了 consumer 的數量不一定要很多。

          - An application needs to communicate with one or more INDEPENDENTLY-DEVELOPED applications or services, which may use different platforms, programming languages, and communication protocols.

          - An application can send information to consumers WITHOUT REQUIRING REAL-TIME RESPONSES from the consumers.

          - The systems being integrated are designed to support an EVENTUAL CONSISTENCY MODEL for their data.

          - An application needs to communicate information to multiple consumers, which may have different AVAILABILITY REQUIREMENTS or UPTIME SCHEDULES than the sender.

            也就是 sender 跟 receiver 可能不會同時間存在。

      - This pattern might not be useful when:

          - An application has only a few consumers who need significantly different information from the producing application.

            因為 pub/sub 的做法是 broadcast，雖然 subscriber 可以做 filtering，但如果要的資訊本質上就很不一樣，就算可以 filtering 也沒用。

            不過話說回來，message 格式是 producing application 對外通知 event 用的，理當可以規劃出大家都適用的資料格式才對? 又或者可以針對不同的需求，往不同的 topic 送不同的 messsage，這樣 subscriber 就可以視需求訂閱不同的 topic。

          - An application requires near real-time interaction with consumers.

  - [Enterprise Integration Patterns \- Publish\-Subscribe Channel](https://www.enterpriseintegrationpatterns.com/patterns/messaging/PublishSubscribeChannel.html) #ril

## Observer Pattern {: #vs-observer-pattern }

  - [Observer vs Pub\-Sub pattern \- By](https://hackernoon.com/observer-vs-pub-sub-pattern-50d3b27f838c) (2017-10-28) #ril
  - [Difference Between Pub\-Sub Pattern and Observable Pattern](https://medium.com/easyread/difference-between-pub-sub-pattern-and-observable-pattern-d5ae3d81e6ce) (2019-02-05) #ril

## 參考資料 {: #reference }

方案：

  - [AWS SNS (Simple Notification Service)](aws-sns.md)
