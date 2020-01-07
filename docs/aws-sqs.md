---
title: AWS / SQS (Simple Queue Service)
---
# [AWS](aws.md) / SQS (Simple Queue Service)

  - [Amazon Simple Queue Service \(SQS\) \| Message Queuing for Messaging Applications \| AWS](https://aws.amazon.com/sqs/)

      - Amazon Simple Queue Service (SQS) is a fully managed message queuing service that enables you to DECOUPLE and SCALE microservices, distributed systems, and serverless applications.

        SQS eliminates the complexity and overhead associated with managing and operating MESSAGE ORIENTED MIDDLEWARE, and empowers developers to focus on differentiating work. Using SQS, you can send, store, and receive messages between software components at any volume, without losing messages or REQUIRING OTHER SERVICES TO BE AVAILABLE.

        訊息送出時，不用擔心接收端是否在線上，這才是完整的 decoupling。

      - SQS offers two types of message queues. Standard queues offer maximum throughput, best-effort ordering, and AT-LEAST-ONCE DELIVERY. SQS FIFO queues are designed to guarantee that messages are processed EXACTLY ONCE, in the exact order that they are sent.

        Standard queue 順序不定且會有可能收到 2 次以上 (at-least-once)，FIFO queue 則是依序處理，而且只會收到一次 (exactly once)；前者的應用情境為何??

    Benefits

      - Eliminate administrative overhead

        AWS manages all ongoing operations and underlying infrastructure needed to provide a highly available and scalable message queuing service. With SQS, there is no upfront cost, no need to acquire, install, and configure messaging software, and no time-consuming build-out and maintenance of supporting infrastructure. SQS queues are dynamically created and scale automatically so you can build and grow applications quickly and efficiently.

      - Reliably deliver messages

        Use Amazon SQS to transmit any volume of data, at any level of throughput, without losing messages or requiring other services to be available. SQS lets you DECOUPLE APPLICATION COMPONENTS so that they RUN AND FAIL INDEPENDENTLY, increasing the OVERALL FAULT TOLERANCE of the system.

        Multiple copies of every message are stored redundantly across multiple availability zones so that they are available whenever needed.

      - Keep sensitive data secure

        You can use Amazon SQS to exchange sensitive data between applications using server-side encryption (SSE) to encrypt each message body. Amazon SQS SSE integration with AWS Key Management Service (KMS) allows you to centrally manage the keys that protect SQS messages along with keys that protect your other AWS resources.

        AWS KMS logs every use of your encryption keys to AWS CloudTrail to help meet your REGULATORY AND COMPLIANCE NEEDS.

      - Scale elastically and cost-effectively

        Amazon SQS leverages the AWS cloud to dynamically scale based on demand. SQS scales elastically with your application so you don’t have to worry about capacity planning and pre-provisioning.

        There is no limit to the number of messages per queue, and standard queues provide nearly unlimited throughput. Costs are based on usage which provides significant cost saving versus the “ALWAYS-ON” MODEL of self-managed messaging middleware.

        自架 messaging middleware，確實就一定會是 always-on!! 成本反而會更高。

## 新手上路 {: #getting-started }

  - [Amazon Simple Queue Service \(SQS\) Getting Started – AWS](https://aws.amazon.com/sqs/getting-started/) #ril
  - [How to send messages between distributed applications \- AWS](https://aws.amazon.com/getting-started/tutorials/send-messages-distributed-applications/) #ril
  - [Decouple and Scale Applications Using Amazon SQS and Amazon SNS \- 2017 AWS Online Tech Talks \- YouTube](https://www.youtube.com/watch?v=UesxWuZMZqI) (2017-07-13) #ril
  - [Introducing Amazon Simple Queue Service \(SQS\) FIFO Queues – Messaging on AWS \- YouTube](https://www.youtube.com/watch?v=XrX7rb6M3jw) (2017-07-14) #ril
  - [Getting Started with Amazon EC2 and Amazon SQS whitepaper](http://sqs-public-images.s3.amazonaws.com/Building_Scalabale_EC2_applications_with_SQS2.pdf) (PDF) #ril

## FIFO Queue

  - FIFO (First In, First Out) [唸做 `faɪfo`](https://youglish.com/pronounce/FIFO/english?)。

---

參考資料：

  - [Amazon SQS FIFO \(First\-In\-First\-Out\) Queues \- Amazon Simple Queue Service](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html) #ril

      - FIFO queues have all the capabilities of the standard queue.

        FIFO (First-In-First-Out) queues are designed to enhance messaging between applications when the ORDER OF OPERATIONS AND EVENTS IS CRITICAL, or where duplicates CAN'T BE TOLERATED, for example:

          - Ensure that user-entered commands are executed in the right order.
          - Display the correct product price by sending price modifications in the right order.
          - Prevent a student from enrolling in a course before registering for an account.

## 參考資料 {: #reference }

  - [Amazon Simple Queue Service (SQS)](https://aws.amazon.com/sqs/)

文件：

  - [SQS Developer Guide](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/)

手冊：

  - [SQS API Reference](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/Welcome.html)
  - [sqs - AWS CLI Command Reference](https://docs.aws.amazon.com/cli/latest/reference/sqs/)
