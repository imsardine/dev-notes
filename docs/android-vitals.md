# [Android](android.md) / Vitals

  - [Android vitals  \|  Android Developers](https://developer.android.com/topic/performance/vitals/) #ril
      - Android vitals is an initiative by Google to improve the stability and performance of Android devices. When an OPTED-IN user runs your app, their Android device logs various metrics, including data about app stability, app startup time, battery usage, render time, and permission denials.
      - The dashboard highlights CRASH RATE, ANR rate, excessive wakeups, and stuck wake locks: these are the CORE VITALS developers should give attention to. 雖然會呈現 crash rate，但若蒐集這些數據要使用者選擇加入，看似跟 Firebase Crashlytics 蒐集 crash report 的機制是不重疊的；其中 "core vitals" 的說法，似乎可以把 vital 解釋為 "生命跡象"?
      - Exhibiting bad behavior in vitals will negatively affect the user experience in your app and is likely to result in BAD RATINGS and POOR DISCOVERABILITY on the Play Store. 會影響在 Play Store 的排名，不過這功能也要使用者 opt-in 不是?
  - [Monitor your app's technical performance with Android vitals \- Play Console Help](https://support.google.com/googleplay/android-developer/answer/7385505) #ril

## 參考資料 {: #reference }

  - [Android vitals | Android Developers](https://developer.android.com/topic/performance/vitals/)
