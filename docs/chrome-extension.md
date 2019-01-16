---
title: Chrome / Extension
---
# [Chrome](chrome.md) / Extension

## 新手上路 ?? {: #getting-started }

  - [Hello Extensions - What are extensions? \- Google Chrome](https://developer.chrome.com/extensions#hello-extensions) #ril
      - [Hello - Sample Extensions \- Google Chrome](https://developer.chrome.com/extensions/samples#search:hello) 可以下載 `hello_extensions.zip`，裡面只有 3 個檔案 -- `hello.html`、`hello_extensions.png` 及 `manifest.json`。
      - 每個 extension 都需要一個 manifest (`menifest.json`)，這個 extension 按 icon 時會彈出 pop-up 顯示 `index.html`：

        `manifest.json`:

            {
              "name": "Hello Extensions",
              "description" : "Base Level Extension",
              "version": "1.0",
              "manifest_version": 2,
              "browser_action": {
                "default_popup": "hello.html", # popup file ??
                "default_icon": "hello_extensions.png"
              }
            }

        `index.html`:

            <html>
              <body>
                <h1>Hello Extensions</h1>
              </body>
            </html>

      - 安裝 extension 要到 `chrome://extensions`，啟用 Developer Mode，按 Load Unpacked 選放置上面那些檔案的目錄；載入後的 ID 是怎麼來的??
      - 在 manifest 裡加入下面這段可啟用 keyboard shortcut：(重新 Load Unpacked 即可，不用移除重裝)

            "commands": {
              "_execute_browser_action": {
                "suggested_key": {
                  "default": "Ctrl+Shift+F",
                  "mac": "MacCtrl+Shift+F"
                },
                "description": "Opens hello.html"
              }
            }

  - [Getting Started Tutorial \- Google Chrome](https://developer.chrome.com/extensions/getstarted) #ril
  - [Overview \- Google Chrome](https://developer.chrome.com/extensions/overview) #ril
  - [Building a simple Google Chrome extension \- Mark Ashley Bell](https://markb.co.uk/building-a-simple-google-chrome-extension.html) (2014-09-30) #ril
  - [Tutorial: Getting Started \- Google Chrome](https://developer.chrome.com/webstore/get_started_simple) #ril
  - [Override Pages \- Google Chrome](https://developer.chrome.com/extensions/override) #ril

## Chrome App, Chrome Extension ??

  - [What Are Chrome Apps? \- Google Chrome](https://developer.chrome.com/apps/about_apps)
      - Chrome will be removing support for Chrome Apps on Windows, Mac, and Linux. Chrome OS will continue to support Chrome Apps. Additionally, Chrome and the Web Store will continue to support extensions on all platforms. 也就是 Chrome (browser) 撤掉了對 Chrome App 的支援，但 Chrome OS 不受影響 (因為 Chromebook 上只能跑 Chrome App)。至於 extension 完全不受影響，那是在 Chrome (browser) 內部的事情，還是透過 Web Store 安裝。
      - Chrome Apps let you use HTML5, CSS, and JavaScript to deliver an experience comparable to a native application. 也就是 packaged app 可以執行在 Chrome tab 之外，像是一個 first-class app，使用者看不出來背後是用 web 做的 (預設是 offline)；這一點很像是 Electron。
  - [What are extensions? \- Google Chrome](https://developer.chrome.com/extensions)
      - Extensions are SMALL software programs that customize the browsing experience. They enable users to tailor Chrome functionality and behavior to individual needs or preferences. They are built on web technologies such as HTML, JavaScript, and CSS. 跟 Chrome App 一樣，只是沒打包成可以獨立執行的 app 而已。
      - An extension must fulfill A SINGLE PURPOSE that is narrowly defined and easy to understand. ... User interfaces should be minimal and have intent. 強調 extension 是要解決特定的問題，UI 的的表現也簡單明瞭。

## Manifest ??

  - [Manifest File Format \- Google Chrome](https://developer.chrome.com/extensions/manifest) #ril

## Browser Action ??

  - [chrome\.browserAction \- Google Chrome](https://developer.chrome.com/extensions/browserAction) #ril

## Search Engine ??

  - [myBit \- Default Search Engine \- Chrome Web Store](https://chrome.google.com/webstore/detail/mybit-default-search-engi/omkmhgmfbpahmkfdobdinpnkoohndnge?hl=en) 看起來 extension 是可以在 search engine 動點手腳的 #ril
  - [Qwant for Chrome \- Chrome Web Store](https://chrome.google.com/webstore/detail/qwant-for-chrome/hnlkiofnhhoahaiimdicppgemmmomijo?hl=en) #ril

## Single Purpose, Quality Guideline ??

  - [Single Purpose - Extensions Quality Guidelines FAQ \- Google Chrome](https://developer.chrome.com/extensions/single_purpose) #ril

## Packaging ??

  - [What are extensions? \- Google Chrome](https://developer.chrome.com/extensions) Extension files are zipped into a single `.crx` package that the user downloads and installs. This means extensions do not depend on content from the web, unlike ordinary web apps.
  - [Packaging \- Google Chrome Extensions \- Google Code](http://www.adambarth.com/experimental/crx/docs/packaging.html) 最後提到 command line 打包 `.crx` 的方法 #ril

## Distribution ??

  - [What are extensions? \- Google Chrome](https://developer.chrome.com/extensions) Extensions are distributed through the Chrome Developer Dashboard and published to the Chrome Web Store.
  - [Chrome Extension Distribution Options \- Google Product Forums](https://productforums.google.com/forum/#!topic/chrome/W9hnJxqpBXQ) #ril
  - [How to install a Chrome extension without using the Chrome Web Store](https://blog.hunter.io/how-to-install-a-chrome-extension-without-using-the-chrome-web-store-31902c780034) (2016-05-23) 從 source code 或 `.CRX`，在 developer mode 下將檔案拖進去即可 #ril
  - [Is it possible to create a private Chrome Store or extension that is not publicly available without a Google for business account? \- Quora](https://www.quora.com/Is-it-possible-to-create-a-private-Chrome-Store-or-extension-that-is-not-publicly-available-without-a-Google-for-business-account) #ril
  - [Alternative Extension Distribution Options \- Google Chrome](https://developer.chrome.com/apps/external_extensions) 也提到 CRX #ril
  - [Is it possible to create a Chrome Extension for private distribution outside Chrome Web Store? \- Stack Overflow](https://stackoverflow.com/questions/12452817/) G Suite 的使用者可以用 Chrome Web Store 代管 private apps #ril
  - [\.crx file install in chrome \- Stack Overflow](https://stackoverflow.com/questions/9931906/) 要拖進 `chrome://extensions` 頁面才有效 #ril
  - [Automate your chrome extension deployment in minutes\! \- DEV Community](https://dev.to/gokatz/automate-your-chrome-extension-deployment-in-minutes-48gb) (2018-09-02) #ril

## Distribution (Enterprise) ??

  - [Create a private Chrome app \- Google Chrome Enterprise Help](https://support.google.com/chrome/a/answer/2714278?hl=en&ref_topic=6274409) `auto-update.xml` 是為了在內部測試?? 為什麼 `manifest.json` 跟 icon 要在 web server 上露出? 因為最後還是得走 Publish your app publicly/privately 讓其他人可以安裝 #ril
  - [Publish a private Chrome app \- Google Chrome Enterprise Help](https://support.google.com/chrome/a/answer/2663860?hl=en) #ril
      - This article is for Chrome administrators and developers looking to publish private Chrome web apps FOR THEIR ORGANIZATION. 根據下面 "Many organizations have private Chrome web apps, such as a Chrome extension that ..." 的說法，這裡的 app 泛指 Chrome extension 與 app。
      - Chrome customers using G Suite or Education can use the Chrome Web Store to host private apps restricted only to their users or people who you SHARE A DIRECT LINK to the app with. ...  Users from the same Chrome DOMAIN will see their organization's private apps in a PRIVATE COLLECTION in the Chrome Web Store.
      - Administrators can choose which users they want to be able to publish private apps for their organization by clicking this checkbox in the Admin console under Device management > Chrome management > User settings > Chrome Web Store Permissions 勾選 Allow users to publish private apps that are restricted to your domain on Chrome Web Store 即可。之後在 Developer Dashboard 發佈 app，就會多出 Visibility options > Private > Everyone at xxx.com 的選項。
      - If you have restricted the visibility of the app to your domain, only users in your organization signed in to their G Suite accounts will be able to see the app.
  - [Create a Chrome app collection \- Google Chrome Enterprise Help](https://support.google.com/chrome/a/answer/2649489?hl=en&ref_topic=9024358) #ril
      - As an administrator, you can recommend a collection of Chrome apps and extensions for users in your organization. You can include public and private apps in a collection. 原來 collection 只是推薦的管道，這說法跟 Firefox 的 Add-on Collection 有點像；可以混雜 private/public apps。
      - Private apps, available only to your users and people you share a link with, appear alongside public apps in the Chrome Web Store. 左邊側欄 Extensions、Themes 會多一個 For xxx.com。
      - Create a collection -- 在 Google Admin Console > Device management > Chrome management > User settings > Chrome Web Store Homepage 可以調整 Chrome Web Store 的 landing page，在這裡可以將 private app 加入 collection；而 private app 則從 Developer Dashboard 發佈。
      - Add apps or extensions 出現 domain app 的說法 (就是 private app)，但 business app 又是什麼?? 跟 G Suite 的 Business/Enterprise 版本有關?

## Updating ??

## Developer Dashboard (Web Store) ??

  - [Developer Dashboard \- Chrome Web Store](https://chrome.google.com/webstore/developer/dashboard) #ril
      - The Chrome Web Store has created a new version of the Developer Dashboard. The new dashboard is experimental, so be aware of these Known Issues. 舊的 dashboard 真的大陽春，難怪新界面有 Dashboard 2.0 的說法。
      - Your Developer Account 提到 You have published 0 item(s) (excluding themes) out of your maximum allotted 20.
      - 用公司 Gmail 帳號時，最下面會看到 A one-time developer registration fee of US$5.00 is required to verify your account and publish items. The fee is not required to publish only to users in xxx.com. 只在公司內發行，不需要註冊費 (一次性)；但為什麼新增 item 時沒有取消付款的選項??
      - To publish a new app, extension or theme, click "Add new item". 特別強調 "Upload a ZIP file of your item directory, not a packaged CRX file." 為什麼?? 上傳後要填一大堆資料，最重要的是 Visibility options: Public/Unlisted/Private -- Only trusted testers from your developer dashboard can see it. You can also include members of a Google Group that you own or manage. 好像也不是發佈給 xxx.com 底下所有的人??
  - [\[Public\] Chrome Web Store Developer Dashboard 2\.0: Known Issues](https://docs.google.com/document/d/e/2PACX-1vQi3OH0AE53rgDO1DSSRqLdH0h7790hPKiIHGlayLfhDGyEZWZLmxBQVNuSE4JFR3uj3fjRGY2lOK2J/pub) #ril

## Web Store Hosting ??

  - [Distributing Products Built for Chrome \- Google Chrome](https://developer.chrome.com/webstore) #ril
  - [Chrome 33 Hosting Changes \- Google Chrome](https://developer.chrome.com/extensions/hosting_changes) #ril
  - [Linux Installation \- Google Chrome](https://developer.chrome.com/extensions/linux_hosting) Extensions hosted outside of the Chrome Web Store can only be installed by Linux users. 難得只有 Linux 可以 #ril

## Web Store Publishing ??

  - [Publish in the Chrome Web Store \- Google Chrome](https://developer.chrome.com/webstore/publish) #ril

## Analytics ??

  - [Tutorial: Google Analytics \- Google Chrome](https://developer.chrome.com/extensions/tut_analytics) #ril

## Testing ??

  - [unit testing \- How to test chrome extensions? \- Stack Overflow](https://stackoverflow.com/questions/2869827/) #ril
  - [How Use Selenium to Test Your Chrome Extension in 6 Steps](https://www.blazemeter.com/blog/6-easy-steps-testing-your-chrome-extension-selenium) (2016-02-16) 用 Selenium 測的成本好像有點高? #ril

## 疑難排解 {: #troubleshooting }

### This extension is not listed in the Chrome Web Store and may have been added without your knowledge. ??

  - [using non\-store extensions : Chromium](https://www.reddit.com/r/Chromium/comments/7ephdn/using_nonstore_extensions/) atomic1fire: You could try using a GPO in windows to white-list the extensions you want to install. 什麼是 GPO ??
  - [Google Chrome deactivated my extension and won't allow me to activate it again · Issue \#524 · YePpHa/YouTubeCenter](https://github.com/YePpHa/YouTubeCenter/issues/524#issuecomment-46626199) 跟 group policy 有關 #ril
  - [This extension is not listed in the Chrome Web Store\.\.\. \- Google Product Forums](https://productforums.google.com/forum/#!topic/chrome/Vh_JBtIaNdY) 提到 For Enterprises, we’ll continue to support group policy to install extensions, irrespective of where the extensions are hosted. Note that any extension which is not hosted on the Web Store and installed via GPO on a machine which has not joined a domain will be hard-disabled. 實驗確認，跟機器有沒有加入 AD 無關。

## 參考資料 {: #reference }

  - [Chrome Web Store](https://chrome.google.com/webstore/)
  - [Developer Dashboard](https://chrome.google.com/webstore/developer/dashboard) ([New](https://chrome.google.com/webstore/devconsole))
  - [Chrome Extensions - Chrome Developer](https://developer.chrome.com/extensions)
  - [Chromium Blog: extensions](https://blog.chromium.org/search/label/extensions)
  - [Google Chrome Extensions - YouTube](https://www.youtube.com/view_play_list?p=CA101D6A85FE9D4B)

社群：

  - ['google-chrome-extension' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/google-chrome-extension)
  - [Chromium Extensions - Google Groups](https://groups.google.com/a/chromium.org/forum/#!forum/chromium-extensions)

書籍：

  - [Creating Google Chrome Extensions - Apress](https://www.apress.com/gp/book/9781484217740) (2016-06)

相關：

  - [Electron](electron.md) - 跟 Chrome app 在做的事一樣。

手冊：

  - [Chrome Extension APIs](https://developer.chrome.com/extensions/api_index)
  - [Manifest File Format](https://developer.chrome.com/extensions/manifest)
