---
title: AWS / SDK
---
# [AWS](aws.md) / SDK

  - [SDK - SDKs and Programming Toolkits for AWS](https://aws.amazon.com/tools/#sdk) #ril

## Python ??

  - [AWS SDK for Python](aws-python.md)
  - [aio\-libs/aiobotocore: asyncio support for botocore library using aiohttp](https://github.com/aio-libs/aiobotocore) #ril

## 疑難排解 {: #troubleshooting }

### SignatureDoesNotMatch ... Signature expired: ... is now earlier than ...

曾經在 Docker container 的 root logger 攔截到錯誤 (時間 2019-06-29T11:37:43.546Z)，但 Slack 記錄的時間卻是 2019-06-29T13:43:34Z，也就是 container 內部的時間比外面真的實世界慢了 2 個小時。

```
...
File "/usr/local/lib/python3.6/site-packages/botocore/client.py", line 661, in _make_api_call
  raise error_class(parsed_response, operation_name)
botocore.exceptions.ClientError: An error occurred (SignatureDoesNotMatch) when calling the ReceiveMessage operation: Signature expired: 20190629T113743Z is now earlier than 20190629T132834Z (20190629T134334Z - 15 min.)
```

這符合錯誤訊息的說法：

```
                            +---- Container 內部視角
                            v
Signature expired: 20190629T113743Z is now earlier than 20190629T132834Z (20190629T134334Z - 15 min.)
                                                                                   ^
                                                                                   +--- AWS 視角
```

這個問題的根源是 AWS SDK 所在的系統，其時間與 AWS server 有太大的偏差 (clock skew)，所以根本的解決就是讓時間同步。

很妙的是，AWS JavaScript SDK 另外提供 `correctClockSkew: true` 的參數，遇到時間偏差時會自動修正重試，但這樣真的好嗎？這種解法 Boto (AWS Python SDK) 倒是堅決不採用，認為系統的問題就要系統解。

---

參考資料：

  - [InvalidSignatureException: Signature expired · Issue \#527 · aws/aws\-sdk\-js](https://github.com/aws/aws-sdk-js/issues/527)

      - evansolomon: I have a bunch of apps that run on AWS + Docker and at some point will randomly start throwing these errors. I think the error usually comes up WHEN i HAVEN'T WORKED ON THE APP FOR A COUPLE DAYS, so the "expiration" is pretty extreme. For example, the one I just got is "expired" by 2 days.

            Signature expired: 20150307T194740Z is now earlier than 20150309T203545Z

      - lsegal: (contributor) @evansolomon I'm not sure why clock skew would be ruled out, it seems to coincide precisely with your usage pattern described above:

        > I think the error usually comes up when I haven't worked on the app for a couple days,

        If Docker images only resync NTP when they are re-activated through commands and they have not been activated in multiple days, that would explain the skew pretty accurately. The SDK definitely relies on "current system time" when making requests, so it needs to be synced prior to sending requests. You might see the exact same behavior on a development machine right after waking the machine up from sleep (prior to clock sync), for example.

        I would recommend taking stock of the `date` command in your Docker image next time you run into this issue. Knowing the current system time would be very helpful to diagnosing the issue.

      - kyriesent: Turns out mine was a clock syncing issue on my VM. Running a sync between the VM and the host cleared it up. 指 Docker 執行在 VM 上的狀況?

      - AdityaManohar: @evansolomon I've just pushed a patch that OFFSETS THE SDK CLOCK when a clock skew error is detected. Simply set the correctClockSkew option when constructing a service client. Here's an example:

            var dynamodb = new AWS.DynamoDB({correctClockSkew: true});

        更是忽略兩邊的時間差，這樣好嗎?

      - Iraulier: same issue 'Signature expired' on aws command line resolved by 'calling ntpd' (The Network Time Protocol (NTP) is used to synchronize the time of a computer).

      - Clee681: I encountered this issue locally, and restarting my docker daemon fixed it. (最多人按讚!?)

        tonyjiang: @Clee681 thank you for sharing your experience and solution! Restarting docker daemon fixed my problem as well - could take much longer to solve it without seeing your comment.

      - mankins: The upload was actually taking more than 5 minutes and consequently giving the `SignatureDoesNotMatch` error.

        為什麼跟單次操作的時間長短有關?

      - zeeshanjamal16: Run the command to sync clock `ntpdate pool.ntp.org`

  - [Support for clock skew correction? · Issue \#1252 · boto/boto3](https://github.com/boto/boto3/issues/1252)

      - shawnbro: I know the javascript sdk offers `correctClockSkew` param in the config and allows the specification of an offset. Is this offered in this lib? If not are there any workarounds?

      - JordonPhillips: We don't support this functionality, NO. The only workaround unfortunately is to FIX THE TIME ON THE SYSTEM. Marking this as a feature request.

        就是系統的時間跑掉，堅決不採用 AWS JavaScript SDK `correctClockSkew` 自動修正時間偏移 (clock skew) 的問題。

## 參考資料 {: #reference }

更多：

  - [AWS SDK for Java](aws-sdk-java.md)
  - [AWS SDK for PHP](aws-sdk-php.md)

