# Android Manifest

  - [App Manifest Overview  \|  Android Developers](https://developer.android.com/guide/topics/manifest/manifest-intro) #ril

## 基礎

### versionCode, versionName ??

  - [<manifest>  \|  Android Developers](https://developer.android.com/guide/topics/manifest/manifest-element) #ril
      - `android:versionCode="integer"` 與 `android:versionName="string"` 明顯不同。
      - `android:versionCode` - An internal version number. This number is used only to determine whether one version is MORE RECENT THAN ANOTHER, with higher numbers indicating more recent versions. This is not the version number shown to users; that number is set by the `versionName` attribute. 跟使用者看到的 `versionName` 無關，`versionCode` 只有大小之分，數字越大代表越新；後面提到可以把 `versionName` 編碼成一個數字，只要確保新版的 `versionCode` 比較大即可。
      - `android:versionName` - The version number shown to users. ... The string has no other purpose than to be displayed to users. The `versionCode` attribute holds the significant version number used internally. 只是使用者看到的一串文字，跟實際的版號 (`versionCode`) 無關。