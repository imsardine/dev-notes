# Google Analytics (GA)

  - [Google Analytics \- Wikipedia](https://en.wikipedia.org/wiki/Google_Analytics) #ril

## 新手上路 ?? {: #getting-started }

## Migration to Firebase Analytics ??

  - [Google Analytics For Mobile Apps Getting Shut Down \| Simo Ahava's blog](https://www.simoahava.com/analytics/google-analytics-for-mobile-sunset/) (2018-12-03) #ril
      - Google is now starting the process of deprecating the “legacy” Google Analytics for Mobile Apps. This covers all data collection SDKs that do not have the word “Firebase” in them. As such, also the “Google Analytics” tags in Google Tag Manager for mobile apps will be impacted. 但也只影響 MOBILE，原 web 的應用不受影響。
      - Google is most likely doing this because they want to focus on Firebase Analytics as the new paradigm for Google’s mobile app analytics. 跟 mobile app 相關的部份 (SDK、reprting UI/API 等) 都將移往 Firebase Analytics。
      - In 2019, we will begin to decommission properties that receive data exclusively from the Google Analytics Services SDK. Data collection and processing for such properties will stop on October 31, 2019. Reporting access through our UI and API access will remain available for these properties’ historical data until January 31, 2020. 轉換在 2019 就會開始發生，2019-10-31 不再接受新的數據，舊數據在 2020-01-31 前仍可透過 UI/API 存取，之後舊數據就會刪除。
      - As you can see from the email, only FREE Google Analytics properties are impacted. Furthermore, only those properties that collect data EXCLUSIVELY with the mobile analytics tracking schema will be impacted. 可 property 不是只能在 website 跟 mobile app 擇一? 如何判別 property 只用在 mobile app 的數據?
      - It looks like one way to avoid the impact even if using free Google Analytics is to send the occasional web hit to the property collecting the mobile app data. This means sending hits with the JavaScript SDK, or building a Measurement Protocol request that includes web dimensions. 想摻雜一些來自 website 的數據，但後來作者確認，一旦 property 被識別為專門用在 mobile app (收到信件告知要轉換)，後面再送 website 數據也沒用了。
      - First of all, on a personal note, I’m very glad about this announcement. I’ve considered the “mobile version” of Google Analytics to be flawed for a long time, as it relies on the PARADIGM OUTLINED BY WEB DATA COLLECTION TOO MUCH. It’s difficult trying to pigeon hole the fluctuations of mobile app usage into the constricted schema of GA with its screenviews, sessions, and campaign attribution. 原來過去要把 GA 套在 mobile app 上，概念上就已經格格不入 -- screenview、session 等都不適用 mobile app。
      - At the same time, the push to Firebase won’t be gentle. It’s a very different approach to analytics, as it revolves around the duality of Users and Events??. Thus, it harks back to hit stream analytics?? ... Moving from GA to Firebase isn’t as easy as flipping a switch, and you should familiarize with the latter as soon as possible. 概念上跟原來為 website 設計的 GA 會很不一樣

## 新手上路 {: #getting-started }

  - [Google Analytics  \|  Google Developers](https://developers.google.com/analytics/) #ril
  - [Learn about Google Analytics - Google Analytics  \|  Google Developers](https://developers.google.com/analytics/devguides/platform/) #ril

## 參考資料 {: #reference }

  - [Google Analytics](https://www.google.com/analytics/)
  - [Google Analytics |  Google Developers](https://developers.google.com/analytics/)

社群：

  - [Google Analytics (@googleanalytics) | Twitter](https://twitter.com/googleanalytics)

更多：

  - [Measurement Protocol](google-analytics-measurement-protocol.md) - Client 往 GA server 送數據的協定

相關：

  - [Firebase Analytics](firebase-analytics.md) - Mobile app 的應用將被 Firebase Analytics 取代
