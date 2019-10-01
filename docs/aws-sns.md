---
title: AWS / SNS (Simple Notification Service)
---
# [AWS](aws.md) / SNS (Simple Notification Service)

  - [Amazon Simple Notification Service \(SNS\) \| AWS](https://aws.amazon.com/sns/)

      - Fully managed pub/sub messaging for microservices, distributed systems, and serverless applications

      - Amazon Simple Notification Service (SNS) is a highly available, durable, secure, fully managed pub/sub messaging service that enables you to decouple microservices, distributed systems, and serverless applications.

        Amazon SNS provides topics for high-throughput, PUSH-BASED ??, many-to-many messaging. Using Amazon SNS topics, your publisher systems can FAN OUT messages to a large number of SUBSCRIBER ENDPOINTS for parallel processing, including Amazon SQS queues, AWS Lambda functions, and HTTP/S webhooks.

        Additionally, SNS can be used to fan out notifications to END USERS using mobile push, SMS, and email.

        感覺像是 AWS 提供不少現成的 application 做為 subscriber，從 topic 收到通知時，就執行特定的功能 -- 往 SQS 塞資料、觸發 Lambda function、打 webhook、送 mobile push、SMS、email 等。

        所謂 subscriber/subscribing endpoint 是指 SNS 收到 message 後要往哪裡送，下面 Getting Started 用的 endpoint type 是 Email，這時 endpoint 就是 email。

    Benefits

      - Reliably deliver messages with durability

        Amazon SNS uses CROSS AVAILABILITY ZONE message storage to provide high message durability. Running within Amazon’s proven network infrastructure and datacenters, Amazon SNS topics are available whenever your applications need them. All messages published to Amazon SNS are stored redundantly across multiple geographically separated servers and data centers.

        Amazon SNS reliably delivers messages to all VALID AWS endpoints, such as Amazon SQS queues and AWS Lambda functions.

      - Automatically scale your workload

        Amazon SNS leverages the proven AWS cloud to dynamically scale with your application. Amazon SNS is a fully managed service, taking care of the heavy lifting related to capacity planning, provisioning, monitoring, and patching. The service is designed to handle high-throughput, BURSTY TRAFFIC patterns. Moreover, there is no upfront cost, and no need to acquire, install, configure, or upgrade messaging software.

      - Simplify your architecture with Message Filtering

        Amazon SNS helps you simplify your pub/sub messaging architecture by offloading the message filtering logic from your subscriber systems, and message routing logic from your publisher systems.

        With Amazon SNS message filtering, subscribing endpoints receive only the messages of interest, instead of all messages published to the topic. Amazon CloudWatch gives visibility into your filtering activity, and AWS CloudFormation enables you to deploy SUBSCRIPTION FILTER POLICIES in an automated and secure manner.

      - Keep messages private and secure

        Amazon SNS topic owners can keep sensitive data secure by setting topic policies that restrict who can publish and subscribe to a topic.

        Amazon SNS also ensures that data is encrypted in transit by applying Amazon ATS certificates to support its HTTPS API, and can also encrypt data at rest by using AWS KMS keys. #ril

        Additionally, using AWS PrivateLink, you can privately publish messages to Amazon SNS topics from your Amazon VPC subnets without traversing the public Internet.

        Amazon SNS can also support use cases in regulated markets, and is in-scope with compliance programs, including HIPAA, PCI, ISO, FIPS, SOC and FedRAMP.

    How it works

      - Amazon SNS enables message filtering and fanout to a large number of subscribers, including serverless functions, queues, and distributed systems. Additionally, Amazon SNS fans out notifications to end users via mobile push messages, SMS, and email.

        ![](https://d1.awsstatic.com/product-marketing/SNS/product-page-diagram_SNS_how-it-works_1.53a464980bf0d5a868b141e9a8b2acf12abc503f.png)

  - [What is Amazon Simple Notification Service? \- Amazon Simple Notification Service](https://docs.aws.amazon.com/sns/latest/dg/welcome.html)

      - Amazon Simple Notification Service (Amazon SNS) is a web service that COORDINATES and manages the delivery or sending of messages to subscribing endpoints or clients.

        In Amazon SNS, there are two types of clients—publishers and subscribers—also referred to as producers and consumers. Publishers communicate asynchronously with subscribers by producing and sending a message to a topic, which is a LOGICAL ACCESS POINT and COMMUNICATION CHANNEL.

        Subscribers (that is, web servers, email addresses, Amazon SQS queues, AWS Lambda functions) consume or receive the message or notification over one of the SUPPORTED PROTOCOLS (that is, Amazon SQS, HTTP/S, email, SMS, Lambda) when they are subscribed to the topic.

        ![](https://docs.aws.amazon.com/sns/latest/dg/images/sns-how-works.png)

        為什麼文件極少提到自己的 application 往 topic 註冊為 subscriber ?? 其中 HTTP/S 最沒意義? 若要做到 decoupling，就不應假設 subscriber 活著?

      - When using Amazon SNS, you (as the owner) create a topic and control access to it by defining policies that determine which publishers and subscribers can communicate with the topic.

        A publisher sends messages to topics that they have created or to topics they have permission to publish to. Instead of including a specific destination address in each message, a publisher sends a message to the topic. Amazon SNS MATCHES the topic to a list of subscribers who have subscribed to that topic, and delivers the message to each of those subscribers.

        Each topic has a unique name that identifies the Amazon SNS endpoint for publishers to post messages and subscribers to register for notifications. Subscribers receive all messages published to the topics to which they subscribe, and all subscribers to a topic receive the same messages.

  - [Building Scalable Applications and Microservices: Adding Messaging to Your Toolbox \| AWS Compute Blog](https://aws.amazon.com/blogs/compute/building-scalable-applications-and-microservices-adding-messaging-to-your-toolbox/) (2017-05-31) #ril

## 新手上路 {: #getting-started }

  - [Amazon Simple Notification Service \(SNS\) Getting Started – AWS](https://aws.amazon.com/sns/getting-started/) #ril

    Step 1: Create a Topic

      - Sign in to the Amazon SNS console.

      - In the Create topic section, enter a Topic name, for example `MyTopic`.

        左側選單打開選 Topics，按 Create topic 後，在 Name 填上 `MyTopic` 即可。

      - Choose Create topic.

        The topic is created and the `MyTopic` page is displayed.

        The topic's Name, ARN, (optional) Display name, and Topic owner's AWS account ID are displayed in the Details section.

        其中 AWS account ID 應該就是畫面上的 Topic owner?

      - Copy the topic ARN to the clipboard, for example:

            arn:aws:sns:us-east-2:123456789012:MyTopic

    Step 2: Create a Subscription for an Endpoint to the Topic

      - On the navigation panel, choose Subscriptions.

      - On the Subscriptions page, choose Create subscription.

      - On the Create subscription page, do the following:

          - Enter the Topic ARN of the topic you created earlier, for example:

                arn:aws:sns:us-east-2:123456789012:MyTopic

            Note: To see a list of the topics in the current AWS account, choose the Topic ARN field.

            點下去就會出現下接提示，但不同 IAM user 的 topic 不互通嗎 ??

      - For Protocol, choose an endpoint type, for example Email.

        選項有 HTTP、HTTPS、Email、Email-JSON、Amazon SQS、AWS Lambda、Platform application endpoint 跟 SMS，如果是自己的 application 要接，要選什麼? 還是都要先進 queue ??

      - For Endpoint, enter an email address that can receive notifications, for example:

            name@example.com

        Note: After your subscription is created, you must confirm it. Only HTTP/S endpoints, email addresses, and AWS resources in other AWS accounts require confirmation. (Amazon SQS queues and Lambda functions in the same AWS account—as well as mobile endpoints —don't require confirmation.) ??

        一開始 subscription 的狀態是 Pending confirmation，會在上面提供的 email address 收到一封抬頭為 AWS Notification - Subscription Confirmation 的信件，內容為：

            You have chosen to subscribe to the topic:
            arn:aws:sns:us-east-2:123456789012:MyTopic

            To confirm this subscription, click or visit the link below (If this was in error no action is necessary):
            Confirm subscription

        按下 Confirm subscription 的連結，會看到：

            Subscription confirmed!
            You have subscribed name@example.com to the topic:
            MyTopic.

            Your subscription's id is:
            arn:aws:sns:us-east-2:123456789012:MyTopic:af18d595-2d2e-4911-a115-5561caec52a5

            If it was not your intention to subscribe, click here to unsubscribe.

        之後 subscription 的狀態就會變成 Confirmed；整個過程好像訂閱 maillist。

  - [How to Filter Messages Published to Amazon SNS Topics \- AWS](https://aws.amazon.com/getting-started/tutorials/filter-messages-published-to-topics/) #ril

## Large Payload

  - SNS 跟 SQS 的 message payload [原先都有 64 KB 的限制](https://aws.amazon.com/about-aws/whats-new/2013/06/18/amazon-sqs-announces-256KB-large-payloads/)，但 2013-06-18 為了支援更多的 use case，所以將此限制放寬到 256 KB。

    但這並不意謂著就該將檔案直接塞進 message 裡，建議把檔案放 S3，而 SNS message 只有留有檔案的 reference 及其他 metadata 即可。

---

參考資料：

  - [Amazon SNS Large Payload and Raw Message Delivery \- Amazon Simple Notification Service](https://docs.aws.amazon.com/sns/latest/dg/sns-large-payload-raw-message-delivery.html)

      - Amazon SNS (and Amazon SQS) allows you to send large payload messages (from 64 to 256 kilobytes in size). To send large payloads, you must use an AWS SDK that supports Signature Version 4.

        注意 SNS 跟 SQS 都有相同的限制 [Limits Related to Messages - Amazon SQS Limits \- Amazon Simple Queue Service](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-limits.html#limits-messages):

        > The minimum message size is 1 byte (1 character). The maximum is 262,144 bytes (256 KB).
        >
        > To send messages larger than 256 KB, you can use the Amazon SQS Extended Client Library for Java. This library allows you to send an Amazon SQS message that contains a REFERENCE TO A MESSAGE PAYLOAD IN AMAZON S3. The maximum payload size is 2 GB.

        將檔案放 S3 並在 SNS message 裡留下 referece，是交換大檔案常見的方法。

  - [Amazon SQS and SNS Announce 256KB Large Payloads](https://aws.amazon.com/about-aws/whats-new/2013/06/18/amazon-sqs-announces-256KB-large-payloads/) (2013-06-18)

      - Today, we are increasing the maximum allowed payload size for the Amazon Simple Queue Service (SQS) and the Amazon Simple Notification Service (SNS) from 64 KB to 256 KB. We are also adding a new option to deliver SNS messages in raw format, in addition to the existing JSON format. This is useful if you are using SNS in conjunction with SQS transmit IDENTICAL COPIES OF A MESSAGE to multiple queues. Here is more information about these new features:

      - 256KB Payloads (SQS and SNS) enable developers to send and receive more data with each API call. Previously, payloads were capped at 64KB. Now, large payloads are billed as one request per 64KB 'chunk' of payload. For example, a single API call for a 256KB payload will be BILLED AS FOUR REQUESTS. Our customers tell us larger payloads will enable NEW USE CASES that were previously difficult to accomplish.

      - SNS Raw Message Delivery enables developers to PACK EVEN MORE INFORMATION content into their messaging payloads. When delivering notifications to SQS and HTTP endpoints, SNS today adds JSON encoding with metadata about the current message and topic. Now, developers can set the optional `RawMessageDelivery` property to disable this added JSON encoding. Raw message delivery is OFF BY DEFAULT, to ensure existing applications continue to behave as expected.

  - [compression \- aws sns publising compressed payload \- Stack Overflow](https://stackoverflow.com/questions/54224029/) gccodec:

    If you think that the file can increase on the time I suggest another approach.

    Put the file on S3 bucket and attach the S3 Event Notification to SNSTopic so all consumer will be notified when a new file is ready to be processed. In other word the message of the SNS will be the LOCATION OF THE FILE and not the file it self. Think about it.

    從 Raw Message Delivery 的角度來看，每個 S3 object 都是一個 message；這對 publisher 是比較單純，不用同時面對 SNS 與 S3 #ril

  - [AWS SQS \- ideas on how to deal with 256 K limit : aws](https://www.reddit.com/r/aws/comments/8na3jg/aws_sqs_ideas_on_how_to_deal_with_256_k_limit/) (2018-05-31)

      - tselatyjr: 800K of data is what most would consider "blob" sized. If you've got blob data, then you should be OFFLOADING blob sized data to a "large" data store and REFERENCING it in the SQS message.

        Consider storing the content in a database (DynamoDB, RDS, S3 bucket, doesn't matter).

        If your payload can't be separated and a message created with a reference for processing, you need to reconsider how you've architected your application.

        這裡 offloading 的說法還滿能說服人的。

      - Dw0: Dynamo has record size limit, currently at 400kb, RDS is for STRUCTURED DATA. Thus S3 for blobs. The only thing, keys have to be random hashes

        tselatyjr: Damn. I forgot DynamoDB only had 400K. Well that's out of the question. RDS isn't really suitable but it DOES solve the problem. As I mentioned, S3 is ideal.

        大家都同意，對於 blob 這類非結構化的資料，放 S3 會比 RDBM 合適。

      - jraede: This for sure. If you generate a UUID and store the content in S3 and just run the UUID and maybe some metadata in the SQS payload, you’ll be fine scaling to thousands of ops per second. Let the managed services do the work.

## Raw Message Delivery

  - [Amazon SNS Large Payload and Raw Message Delivery \- Amazon Simple Notification Service](https://docs.aws.amazon.com/sns/latest/dg/sns-large-payload-raw-message-delivery.html)

      - In addition to sending large payloads, with Amazon SNS you can now enable RAW MESSAGE DELIVERY for messages delivered to either Amazon SQS endpoints or HTTP/S endpoints. This eliminates the need for the endpoints to process JSON formatting, which is created for the Amazon SNS metadata when raw message delivery is not selected.

        For example when enabling raw message delivery for an Amazon SQS endpoint, the Amazon SNS metadata is not included and the published message is delivered to the subscribed Amazon SQS endpoint AS IS. When enabling raw message delivery for HTTP/S endpoints, the messages will contain an additional HTTP header `x-amz-sns-rawdelivery` with a value of `true` to indicate that the message is being published raw instead of with JSON formatting. This enables those endpoints to understand what is being delivered and enables easier transition for subscriptions from JSON to raw delivery.

        若雙方已約定好自己的格式 (也可能是 JSON)，那麼 SNS 再加一層 JSON 似乎是多餘的?

      - To enable raw message delivery using one of the AWS SDKs, you must use the `SetSubscriptionAttribute` action and configure the `RawMessageDelivery` attribute with a value of `true`. The default value is `false`.

        針對單一個 message ??

    Enabling Raw Message Delivery Using the AWS Management Console

     1. Sign in to the Amazon SNS console.
     2. On the navigation panel, choose Topics.
     3. On the Topics page, choose a topic subscribed an Amazon SQS or HTTP/S endpoint.
     4. On the MyTopic page, in the Subscription section, choose a subscription and choose Edit.
     5. On the Edit EXAMPLE1-23bc-4567-d890-ef12g3hij456 page, in the Details section, choose Enable raw message delivery.
     6. Choose Save changes.

  - [Amazon SQS and SNS Announce 256KB Large Payloads](https://aws.amazon.com/about-aws/whats-new/2013/06/18/amazon-sqs-announces-256KB-large-payloads/) (2013-06-18)

    SNS Raw Message Delivery enables developers to PACK EVEN MORE INFORMATION content into their messaging payloads. When delivering notifications to SQS and HTTP endpoints, SNS today adds JSON encoding with metadata about the current message and topic. Now, developers can set the optional `RawMessageDelivery` property to disable this added JSON encoding. Raw message delivery is OFF BY DEFAULT, to ensure existing applications continue to behave as expected.

    為什麼說原來的 JSON format 沒有辦法帶太多資訊 ??

## 安裝設定 {: #setup }

  - [Step 2: Create an IAM User and Get Your AWS Credentials - Setting Up Access for Amazon SNS \- Amazon Simple Notification Service](https://docs.aws.amazon.com/sns/latest/dg/sns-setting-up.html#create-iam-user)

      - To avoid using your IAM administrator user for Amazon SNS operations, it is a best practice to create an IAM user for EACH PERSON who needs administrative access to Amazon SNS.

      - To work with Amazon SNS, you need the `AmazonSNSFullAccess` policy and AWS credentials that are associated with your IAM user. These credentials are comprised of an access key ID and a secret access key.

## 參考資料 {: #reference }

  - [Simple Notification Service (SNS) | AWS](https://aws.amazon.com/sns/)

文件:

  - [Developer Guide - Amazon Simple Notification Service](https://docs.aws.amazon.com/sns/latest/dg/)

相關：

  - 實作了 [Pub/Sub Pattern](pubsub-pattern.md)。
