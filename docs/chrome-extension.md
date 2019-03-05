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
                "default_popup": "hello.html", # popup 會出現的內容
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
      - Administrators can choose which users they want to be able to publish private apps for their organization by clicking this checkbox in the Admin console under Device management > Chrome management > User settings > Chrome Web Store Permissions.

        勾選 Allow users to publish private apps that are restricted to your domain on Chrome Web Store 即可。之後在 Developer Dashboard 發佈 app，就會多出 Visibility options > Private > Everyone at xxx.com 的選項。

    How to publish private Chrome web apps

      - Publishing a private app is very similar to publishing a public app to the Chrome Web Store. The only difference is there's an additional step of restricting access to the app to your domain: ... Add a new item and upload your app as a zip file. Set the promotional image you want to use, and the category, and language for the app. Select Private and Everyone at <your domain>.
      - Optionally, you can select Only trusted testers... which will restrict the app to trusted testers you've specified in your developer dashboard.
      - If you have restricted the visibility of the app to your domain, only users in your organization signed in to their G Suite accounts will be able to see the app. The app will have a private badge applied to it, which appears as a SMALL PADLOCK in the bottom right corner of the app on the Chrome Web Store. You can publish the app publicly by selecting Public.

  - [Create a Chrome app collection \- Google Chrome Enterprise Help](https://support.google.com/chrome/a/answer/2649489?hl=en&ref_topic=9024358) #ril
      - As an administrator, you can recommend a collection of Chrome apps and extensions for users in your organization. You can include public and private apps in a collection. 原來 collection 只是推薦的管道，這說法跟 Firefox 的 Add-on Collection 有點像；可以混雜 private/public apps。
      - Private apps, available only to your users and people you share a link with, appear alongside public apps in the Chrome Web Store. 左邊側欄 Extensions、Themes 會多一個 For xxx.com。
      - Create a collection -- 在 Google Admin Console > Device management > Chrome management > User settings > Chrome Web Store Homepage

        可以調整 Chrome Web Store 的 landing page，在這裡可以將 private app 加入 collection；而 private app 則從 Developer Dashboard 發佈。

      - Add apps or extensions 出現 domain app 的說法 (就是 private app)，但 business app 又是什麼?? 跟 G Suite 的 Business/Enterprise 版本有關?

  - [Private Extension unreachable by organization members \- Google Groups](https://groups.google.com/a/chromium.org/forum/#!topic/chromium-extensions/dojqlG04iAA/discussion) #ril
      - Jonathan Freeman: ... the extension is labeled as "published" in the developer dashboard ... Unfortunately, nobody in my organization is able to access the extension either from the private collection in the chrome webstore or via a direct link. What am I missing?
      - Antony Sargent:  one edge case I could imagine breaking this is if you and the other users all happen to *not* be logged in to chrome sync with an account for this domain, but do have many other google.com accounts logged in with web cookies.

        用 Guest Window 試過單純登入公司的帳號，還是只看到 public extensions。

## Signing ??

  - [What can I do if I lose my Chrome extension private key? \- Stack Overflow](https://stackoverflow.com/questions/36707917/) #ril

## Updating, Auto-update

  - 增加版號並重新包裝 `.zip` 上傳即可，之後會自動更新；使用者完全無感。
  - Google Chrome 每幾個小時會檢查一次是否有更新，但實際更新的頻率無法掌握。若要馬上更新，可以在 `chrome://extensions` 啟用 Developer Mode，按 Update 可以立即更新所有的 extension。

---

參考資料：

  - [Updating - Web Store Hosting and Updating \- Google Chrome](https://developer.chrome.com/extensions/hosting#updating)
      - The Chrome Browser periodically checks for new versions of installed extensions and updates them WITHOUT USER INTERVENTION. 使用者也不會被提示已更新!!
      - To release an update to an extension, increase the number in the “`version`” field of the manifest. Convert the updated extension directory into a ZIP file and locate the old version in the Developer Dashboard. Select Edit, upload the new package, and hit Publish. The browser will will automatically update the extension for users after the new version is published.

    Developer Dashboard 編輯某個現有的 extension 時，Upload 欄位 (Upload Updated Package) 的說明：

      - Upload a new ZIP file to update the manifest (which specifies information such as the name, short description, version, and permissions) or to update any other files that are part of the package that the user downloads from the store. Don’t forget to increment the version number! 看來上新版就是從這裡下手，而且跳版很重要。

  - [Publish in the Chrome Web Store \- Google Chrome](https://developer.chrome.com/webstore/publish)
      - You can update your app as many times as you want, just remember to increase the version number each time.
      - You can control how fast a new version of your app reaches existing users with Controlled Rollout. By using the “max deploy percentage” control, you can limit the percentage of existing users that are updated to the latest version of the app through the Chrome auto-update mechanism. ... Currently the “controlled rollout” feature is only available for items with at least 10,000 users. 但 auto-update 不需要有 10000 個使用者吧??

  - [Do Google Chrome extensions auto update to the latest version or do you have to manually update them? \- Quora](https://www.quora.com/Do-Google-Chrome-extensions-auto-update-to-the-latest-version-or-do-you-have-to-manually-update-them) 一面倒地說會自動更新
      - Eric Hahn: Chrome extensions autoupdate so long as the extension has an autoupdate URL specified in the manifest. All extensions from the Chrome Web Store (and theextensions gallery) GET THIS FIELD SET AUTOMATICALLY. But if you host elsewhere, you can still specify it, and in that case, autoupdate will still work.
      - Akhtaruzzaman Ashik: Yes, they automatically update to the latest version. But, sometimes it might delay A FEW DAYS. But, You can force Chrome to update them. Just go to the Extensions Tab and enable Developer Mode. After enabling, you'll see an option to update all extensions.

  - [How to check chrome extension version and manually update it \| Night Eye](https://nighteye.app/how-to-check-chrome-extension-version-and-manually-update-it/)
      - First and foremost all chrome extensions autoupdate if you installed them fom the Chrome webstore. In most cases you really don’t need to worry checking the current version and update the extension.
      - In the extensions page you will not be able to check the current version, nor manually update them before you enable the Developer mode. ... Once enabled, you will see next to the name of each extension different numbers. 顯示的版號是本地安裝的版本，至於最新版是多少，則要到 web store 上看。
      - Although extensions are being updated automatically, if the developer pushed an update recently and you have not used Chrome for a while, it might take some time the automatic update to take place. 感覺無法預測自動更新的時間點??
      - Once you enable Developer mode, you will notice second bar with 3 new buttons appear in the top left corner. The button you need is Update. Simply click it and Chrome will check all your extensions if they are up to date and if not, will get their latest versions. 無法更新特定的 extension。

  - [How often do Chrome extensions automatically update? \- Stack Overflow](https://stackoverflow.com/questions/24100507/) #ril
      - Rory: Currently this defaults to 5 hours (based on [the code here](https://cs.chromium.org/chromium/src/extensions/common/constants.cc?q=kDefaultUpdateFrequencySeconds&dr=CSs&l=45)).

        You can override this by launching chrome with the `extensions-update-frequency` command-line parameter, which is the frequency in seconds. And you can go to `chrome://extensions`, tick the Developer mode checkbox at the top right, then press the Update Extensions Now button

        Chrome docs doesn't specify this 5 hour value though, so it could change in future versions without notice: Every few hours, the browser checks whether any installed extensions or apps have an update URL. For each one, it makes a request to that URL looking for an update manifest XML file.

  - [Autoupdating \- Google Chrome](https://developer.chrome.com/apps/autoupdate) #ril
      - Every few hours, the browser checks whether any installed extensions or apps have an update URL. For each one, it makes a request to that URL looking for an update manifest XML file. If the update manifest mentions a version that is more recent than what's installed, the browser downloads and installs the new version.

  - [Extensions Update Notifier \- Chrome Web Store](https://chrome.google.com/webstore/detail/extensions-update-notifie/nlldbplhbaopldicmcoogopmkonpebjm?hl=en) 有人做了個會通知更新的 extension #ril

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

### This extension is not listed in the Chrome Web Store and may have been added without your knowledge.

  - [using non\-store extensions : Chromium](https://www.reddit.com/r/Chromium/comments/7ephdn/using_nonstore_extensions/) atomic1fire: You could try using a GPO in windows to white-list the extensions you want to install. 什麼是 GPO ??
  - [Google Chrome deactivated my extension and won't allow me to activate it again · Issue \#524 · YePpHa/YouTubeCenter](https://github.com/YePpHa/YouTubeCenter/issues/524#issuecomment-46626199) 跟 group policy 有關 #ril
  - [This extension is not listed in the Chrome Web Store\.\.\. \- Google Product Forums](https://productforums.google.com/forum/#!topic/chrome/Vh_JBtIaNdY) 提到 For Enterprises, we’ll continue to support group policy to install extensions, irrespective of where the extensions are hosted. Note that any extension which is not hosted on the Web Store and installed via GPO on a machine which has not joined a domain will be hard-disabled. 實驗確認，跟機器有沒有加入 AD 無關。

    之前跟 Developer Support 信件往來，確認跟有沒有用 [Chrome for Enterprise](https://cloud.google.com/chrome-enterprise/browser/download/) 無關。

  - Developer Dashboard 的說明提到 Extensions, applications and themes require AT LEAST ONE SCREENSHOT or YouTube link. ... We prefer screenshots to be 1280x800 pixels in size, as they will be used in future high dpi displays. Currently, ... 一定要給截圖，而且一定要是 1280 x 800。

    後來知道原因了，若 visibility options 選 Public 或 Unlisted 才會檢查並提示 "At least one screenshot or video is required."，選 private 就不會要求 screenshot。不過實驗下來的結果是，不論是 private 也要上傳 screenshot 才會顯示在 For XXX.com 下 (跟有沒有提供 icon 無關)

## 參考資料 {: #reference }

  - [Chrome Web Store](https://chrome.google.com/webstore/)
  - [Developer Dashboard](https://chrome.google.com/webstore/developer/dashboard) ([New](https://chrome.google.com/webstore/devconsole))
  - [Chrome Extensions - Chrome Developer](https://developer.chrome.com/extensions)
  - [Chromium Blog: extensions](https://blog.chromium.org/search/label/extensions)
  - [Google Chrome Extensions - YouTube](https://www.youtube.com/view_play_list?p=CA101D6A85FE9D4B)

社群：

  - ['google-chrome-extension' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/google-chrome-extension)
  - [Chromium Extensions - Google Groups](https://groups.google.com/a/chromium.org/forum/#!forum/chromium-extensions)
  - [Developer Support - Chrome Web Store](https://support.google.com/chrome_webstore/contact/developer_support/) (可以上傳多個檔案)

書籍：

  - [Creating Google Chrome Extensions - Apress](https://www.apress.com/gp/book/9781484217740) (2016-06)

相關：

  - [Electron](electron.md) - 跟 Chrome app 在做的事一樣。

手冊：

  - [Chrome Extension APIs](https://developer.chrome.com/extensions/api_index)
  - [Manifest File Format](https://developer.chrome.com/extensions/manifest)
