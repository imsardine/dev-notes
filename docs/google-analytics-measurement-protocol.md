---
title: Google Analytics / Measurement Protocol
---
# [Google Analytics](google-analytics.md) / Measurement Protocol

  - [Google Analytics For Mobile Apps Getting Shut Down \| Simo Ahava's blog](https://www.simoahava.com/analytics/google-analytics-for-mobile-sunset/) (2018-12-03) 提到 This means sending hits with the JavaScript SDK, or building a Measurement Protocol request that includes web dimensions. 原來 client 跟 GA server 間是走 Measurement API。
  - [Set up Google Analytics - Analytics Tracking  \|  Google Developers](https://developers.google.com/analytics/devguides/collection/) 第一步要 Choose a platform，粗分為 website and web apps、mobile app 與 Internet connected devices，前面兩項有自己的 SDK (JavaScript、Android、iOS)，但 Internet connected devices 就直接指向 Measurement Protocol，大概是因為定位在 track user interaction in ANY ENVIRONMENT 的關係。
  - [Measurement Protocol Overview  \|  Analytics Measurement Protocol  \|  Google Developers](https://developers.google.com/analytics/devguides/collection/protocol/v1/) #ril
      - The Google Analytics Measurement Protocol allows developers to make HTTP requests to send RAW USER INTERACTION DATA directly to Google Analytics servers. This allows developers to measure how users interact with their business from almost any environment.
      - Measure user activity in new environments. Tie online to offline behavior. ?? Send data from both the client and SERVER. 感覺像 Slack slash command 拿 GA 來做 tracking 並不奇怪?? 屬於 server-side 的應用。

## 新手上路 ?? {: #getting-started }

  - [Working with the Measurement Protocol  \|  Analytics Measurement Protocol  \|  Google Developers](https://developers.google.com/analytics/devguides/collection/protocol/v1/devguide) #ril
      - This document demonstrates how to format HTTP requests to send COMMON HIT TYPES to the Google Analytics Measurement Protocol. 所謂 common 是指不給 `t` parameter 嗎??
      - To send user interaction data, make an HTTP POST request to this endpoint.

            POST /collect HTTP/1.1
            Host: www.google-analytics.com

            payload_data

      - The following parameters are required for each payload: Each payload must contain a valid hit type and each hit type has its own set of required fields.

            v=1              // Version.
            &tid=UA-XXXXX-Y  // Tracking ID / Property ID.
            &cid=555         // Anonymous Client ID. (嚴格來說，沒有 `uid` 時，`cid` 才會是必要的)
            &t=              // Hit Type.

        所有的 hit type 都要有 `v`、`tid`、`cid`/`uid` (二擇一) 跟 `t` (hit type)，而 hit type 會決定還有哪些 parameter 是必要的。以 `/home` page 的 `pageview` 為例，`dp` (document path) 是必要的：

            v=1&tid=UA-XXXXX-Y&cid=555&t=pageview&dp=%2Fhome

  - [Hit type - Measurement Protocol Parameter Reference  \|  Analytics Measurement Protocol  \|  Google Developers](https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#t) Required for all hit types. The type of hit. Must be one of `'pageview'`, `'screenview'`, `'event'`, `'transaction'`, `'item'`, `'social'`, `'exception'`, `'timing'`.
  - [Client ID - Measurement Protocol Parameter Reference  \|  Analytics Measurement Protocol  \|  Google Developers](https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#cid)
      - Optional. This field is required if User ID (`uid`) is not specified in the request. 有條件的 optional，也就是 `cid` 跟 `uid` 至少要有一個。
      - This ANONYMOUSLY identifies a particular user, device, or browser instance. For the web, this is generally stored as a first-party cookie with a two-year expiration. For mobile apps, this is randomly generated for each particular instance of an APPLICATION INSTALL. The value of this field should be a random UUID (version 4) as described in http://www.ietf.org/rfc/rfc4122.txt. 識別個別的用戶，所謂 anonymous 指的是相對辨識度較高的 User ID?
  - [Hit Builder — Google Analytics Demos & Tools](https://ga-dev-tools.appspot.com/hit-builder/) #ril

## Event Tracking ??

  - [Event Tracking - Working with the Measurement Protocol  \|  Analytics Measurement Protocol  \|  Google Developers](https://developers.google.com/analytics/devguides/collection/protocol/v1/devguide#event) 跟 page view 有什麼不同??
  - [Event Tracking - Measurement Protocol Parameter Reference  \|  Analytics Measurement Protocol  \|  Google Developers](https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#events) #ril

## Custom Dimensions / Metrics ??

  - [Custom Dimensions / Metrics - Measurement Protocol Parameter Reference  \|  Analytics Measurement Protocol  \|  Google Developers](https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#customs) 最多可以有 20 個 custom dimension #ril

## 參考資料

手冊：

  - [Measurement Protocol Reference](https://developers.google.com/analytics/devguides/collection/protocol/v1/reference)
  - [Measurement Protocol Parameter Reference](https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters)
