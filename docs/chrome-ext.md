---
title: Chrome / Extension
---
# [Chrome](chrome.md) / Extension

  - [What are extensions? \- Google Chrome](https://developer.chrome.com/extensions)

      - Extensions are SMALL software programs that customize the browsing experience. They enable users to tailor Chrome functionality and behavior to individual needs or preferences. They are built on web technologies such as HTML, JavaScript, and CSS.

        跟 Chrome App 一樣，只是沒打包成可以獨立執行的 app 而已。

      - An extension must fulfill a SINGLE PURPOSE that is narrowly defined and easy to understand. A single extension can include multiple components and a range of functionality, as long as everything contributes towards a COMMON PURPOSE.

        User interfaces should be minimal and have INTENT. They can range from a simple icon, such as the Google Mail Checker extension shown on the right, to [overriding](https://developer.chrome.com/override) an entire page. #ril

        強調 extension 是要解決特定的問題，UI 的的表現也簡單明瞭。

      - Extension files are zipped into a single `.crx` package that the user downloads and installs. This means extensions DO NOT DEPEND ON CONTENT FROM THE WEB, unlike ordinary web apps.

        範例都是用 `.zip`，什麼時候會用到 `.crx` ??

      - Extensions are distributed through the Chrome Developer Dashboard and published to the Chrome Web Store. For more information, see the [store developer documentation](https://developer.chrome.com/webstore). #ril

  - [What Are Chrome Apps? \- Google Chrome](https://developer.chrome.com/apps/about_apps)

      - Chrome will be removing support for Chrome Apps on Windows, Mac, and Linux. Chrome OS will continue to support Chrome Apps. Additionally, Chrome and the Web Store will continue to support extensions on all platforms.

        也就是 Chrome (browser) 撤掉了對 Chrome App 的支援，但 Chrome OS 不受影響 (因為 Chromebook 上只能跑 Chrome App)。至於 extension 完全不受影響，那是在 Chrome (browser) 內部的事情，還是透過 Web Store 安裝。

      - Chrome Apps let you use HTML5, CSS, and JavaScript to deliver an experience comparable to a native application.

        也就是 packaged app 可以執行在 Chrome tab 之外，像是一個 first-class app，使用者看不出來背後是用 web 做的 (預設是 offline)；這一點很像是 Electron。

  - [Single Purpose - Extensions Quality Guidelines FAQ \- Google Chrome](https://developer.chrome.com/extensions/single_purpose) #ril

## 新手上路 {: #getting-started }

  - [Hello Extensions - What are extensions? \- Google Chrome](https://developer.chrome.com/extensions#hello-extensions)

      - Take a small step into extensions with this quick Hello Extensions example. Start by creating a new directory to store the extension's files, or download them from the [sample page](https://developer.chrome.com/extensions/samples#search:hello).

        Next, add a file called `manifest.json` and include the following code:

            {
              "name": "Hello Extensions",
              "description" : "Base Level Extension",
              "version": "1.0",
              "manifest_version": 2
            }

      - Every extension requires a manifest, though most extensions will not do much with just the manifest. For this quick start, the extension has a POPUP FILE and icon declared under the `browser_action` field:

            {
              "name": "Hello Extensions",
              "description" : "Base Level Extension",
              "version": "1.0",
              "manifest_version": 2,
              "browser_action": {
                "default_popup": "hello.html",
                "default_icon": "hello_extensions.png"
              }
            }

        [chrome\.browserAction \- Google Chrome](https://developer.chrome.com/extensions/browserAction):

        > Use BROWSER ACTIONS to put icons in the main Google Chrome toolbar, to the right of the address bar. In addition to its icon, a browser action can have a tooltip, a BADGE, and a popup.

        所謂 popup file 指的是按下 icon 時會彈出的畫面，通常是選單。

      - Download [`hello_extensions.png` here](https://developer.chrome.com/static/images/index/hello_extensions.png) and then create a file titled `hello.html`:

            <html>
              <body>
                <h1>Hello Extensions</h1>
              </body>
            </html>

      - The extension now displays `hello.html` when the icon is clicked. The next step is to include a command in the `manifest.json` that enables a keyboard shortcut. This step is fun, but not necessary:

            {
              "name": "Hello Extensions",
              "description" : "Base Level Extension",
              "version": "1.0",
              "manifest_version": 2,
              "browser_action": {
                "default_popup": "hello.html",
                "default_icon": "hello_extensions.png"
              },
              "commands": {
                "_execute_browser_action": {
                  "suggested_key": {
                    "default": "Ctrl+Shift+F",
                    "mac": "MacCtrl+Shift+F"
                  },
                  "description": "Opens hello.html"
                }
              }
            }

        [chrome\.commands \- Google Chrome](https://developer.chrome.com/extensions/commands#usage):

        > The `_execute_browser_action` and `_execute_page_action` COMMANDs are reserved for the action of opening your extension's popups.

      - The last step is to install the extension on your local machine.

         1. Navigate to chrome://extensions in your browser. You can also access this page by clicking on the Chrome menu on the top right side of the Omnibox, hovering over More Tools and selecting Extensions.

         2. Check the box next to DEVELOPER MODE.

            啟用 Developer Mode 後，上方會有三個按鈕 -- Load unpacked、Pack extension 及 Update。

         3. Click Load Unpacked Extension and select the DIRECTORY for your "Hello Extensions" extension.

            載入後的 ID 是怎麼來的 ??

        Congratulations! You can now use your POPUP-BASED extension by clicking the `hello_world.png` icon or by pressing `Ctrl+Shift+F` on your keyboard.

  - [Overview \- Google Chrome](https://developer.chrome.com/extensions/overview)

    雖然官方文件把 Overview 安排在 Getting Started Tutorial 之後，但我覺得應該先把 Overview 看過才對，畢竟上面的 Hello Extension 已經有些概念。

      - Extensions are zipped bundles of HTML, CSS, JavaScript, images, and other files used in the web platform, that customize the Google Chrome browsing experience. Extensions are built using web technology and can use the same APIs the browser provides to the open web.

      - Extensions have a wide range of functional possibilities. They can modify web content users see and interact with or extend and change the behavior of the browser itself.

        Consider extensions the gateway to making the Chrome browser the most PERSONALIZED BROWSER.

    Extension Files

      - Extensions vary in types of files and amount of directories, but they are all required to have a manifest. Some basic, but useful, extensions may consist of just the manifest and its toolbar icon.

      - The manifest file, titled `manifest.json`, gives the browser information about the extension, such as the most important files and the CAPABILITIES the extension might use.

            {
              "name": "My Extension",
              "version": "2.1",
              "description": "Gets information from Google.",
              "icons": {
                "128": "icon_16.png",
                "128": "icon_32.png",
                "128": "icon_48.png",
                "128": "icon_128.png"
              },
              "background": {
                "persistent": false,
                "scripts": ["background_script.js"]
              },
              "permissions": ["https://*.google.com/", "activeTab"],
              "browser_action": {
                "default_icon": "icon_16.png",
                "default_popup": "popup.html"
              }
            }

        其中 capabilities 不完全是指 permission，例如 `backgroup` 跟 `browser_action` 都代表著 extension 可以有哪些行為。

      - Extensions must have an icon that sits in the browser toolbar. Toolbar icons allow easy access and keep users aware of which extensions are installed. Most users will interact with an extension that uses a popup by clicking on the icon.

          - This Google Mail Checker extension uses a browser action.

            ![](https://developer.chrome.com/static/images/overview/browser_arrow.png)

          - This Mappy extension uses a page action and content script.

            ![](https://developer.chrome.com/static/images/overview/mappy.png)

        注意 browser action 跟 page action 在 toolbar icon 的表現有何不同? browser action 跟特定 tab 無關，永遠都是 active (彩色)，但 page action 就不一定 (灰色)

    Extension Files > Referring to files

      - An extension's files can be referred to by using a RELATIVE URL, just as files in an ordinary HTML page.

            <img src="images/my_image.png">

      - Additionally, each file can also be accessed using an absolute URL.

            chrome-extension://<extensionID>/<pathToFile>

        In the absolute URL, the `<extensionID>` is a unique identifier that the extension system generates for each extension. The IDs for all loaded extensions can be viewed by going to the URL `chrome://extensions`. The `<pathToFile>` is the location of the file under the extension's top folder; it matches the relative URL.

        While working on an UNPACKED EXTENSION the extension ID can change. Specifically, the ID of an unpacked extension will change if the extension is loaded from a different directory; the ID will change again when the extension is packaged. If an extension's code relies on an absolute URL, it can use the `chrome.runtime.getURL()` method to avoid hardcoding the ID during development.

        原來 unpacked extension 的 ID 跟目錄位置有關。什麼情況下會用到 absolute URL ??

    Background Script

      - The background script is the extension's EVENT HANDLER; it contains listeners for browser events that are important to the extension. It lies dormant until an event is fired then performs the instructed logic.

        An effective background script is only loaded when it is needed and UNLOADED WHEN IT GOES IDLE.

    UI Elements

      - An extension's user interface should be purposeful and minimal. The UI should customize or enhance the browsing experience without distracting from it.

        Most extensions have a browser action or page action, but can contain other forms of UI, such as context menus, use of the omnibox, or creation of a keyboard shortcut.

      - Extension UI PAGES, such as a popup, can contain ordinary HTML pages with JavaScript logic. Extensions can also call `tabs.create` or `window.open()` to display additional HTML files present in the extension.

        這時候就會用到 absolute URL ??

      - An extension using a page action and a popup can use the DECLARATIVE CONTENT API to set RULES in the background script for when the popup is available to users. When the conditions are met, the background script communicates with the popup to MAKE IT’S ICON CLICKABLE to users. ??

        ![A browser window containing a page action displaying a popup.](https://developer.chrome.com/static/images/overview/popuparc.png)

    Content scripts

      - Extensions that read or write to web pages utilize a content script. The content script contains JavaScript that executes IN THE CONTEXTS OF A PAGE that has been loaded into the browser. Content scripts read and modify the DOM of web pages the browser visits.

        ![A browser window with a page action and a content script.](https://developer.chrome.com/static/images/overview/contentscriptarc.png)

      - Content scripts can communicate with their PARENT EXTENSION by exchanging messages and storing values using the `storage` API.

        ![Shows a communication path between the content script and the parent extension.](https://developer.chrome.com/static/images/overview/contentscriptarc.png)

        若 content script 執行在 page 裡，如何能調用得到 `storage` API ??

    Options Page

      - Just as extensions allow users to customize the Chrome browser, the options page enables customization of the extension.
      - Options can be used to enable features and allow users to choose what functionality is relevant to their needs.

  - [Using Chrome APIs - Overview \- Google Chrome](https://developer.chrome.com/extensions/overview#apis)

      - In addition to having access to the same APIs as web pages, extensions can also use extension-specific APIs that create tight integration with the browser.

        Extensions and webpages can both access the standard `window.open()` method to open a URL, but extensions can specify which window that URL should be displayed in by using the Chrome API `tabs.create` method instead.

    Asynchronous vs. synchronous methods

      - Most Chrome API methods are asynchronous: they return immediately without waiting for the operation to finish. If an extension needs to know the outcome of an asynchronous operation it can pass a CALLBACK function into the method. The callback is executed later, potentially much later, after the method returns.

      - If the extension needed to navigate the user’s currently selected tab to a new URL, it would need to get the current tab’s ID and then update that tab’s address to the new URL.

        If the `tabs.query` method were synchronous, it may look something like below.

            //THIS CODE DOESN'T WORK
            var tab = chrome.tabs.query({'active': true}); //WRONG!!!
            chrome.tabs.update(tab.id, {url:newUrl});
            someOtherFunction();

        This approach will fail because `query()` is asynchronous. It returns without waiting for the work to complete, and does not return a value. A method is asynchronous WHEN THE CALLBACK PARAMETER IS AVAILABLE IN ITS SIGNATURE.

            // Signature for an asynchronous method
            chrome.tabs.query(object queryInfo, function callback)

        To correctly query a tab and update its URL the extension must use the callback parameter.

            //THIS CODE WORKS
            chrome.tabs.query({'active': true}, function(tabs) {
              chrome.tabs.update(tabs[0].id, {url: newUrl});
            });
            someOtherFunction();

        In the above code, the lines are executed in the following order: 1, 4, 2. (行號) The callback function specified to `query()` is called and then executes line 2, but only after information about the currently selected tab is available. This happens sometime after `query()` returns.

      - Although `update()` is asynchronous the code doesn’t use a callback parameter, since the extension doesn’t do anything with the RESULTS of the update.

        有 `callback` 參數時代表是 asynchronous，但有 `callback` 參數不一定要用，除非想要等結果。

            // Synchronous methods have no callback option and returns a type of string
            string chrome.runtime.getURL()

        This method synchronously returns the URL as a string and performs no other asynchronous work.

    Communication between pages

      - Different components in an extension often need to communicate with each other. Different HTML pages can find each other by using the `chrome.extension` methods, such as `getViews()` and `getBackgroundPage()`.

        Once a page has a reference to other extension pages the first one can invoke functions on the other pages and manipulate their DOMs. Additionally, all components of the extension can access values stored using the `storage` API and communicate through MESSAGE PASSING.

    Saving data and incognito mode

      - Extensions can save data using the `storage` API, the [HTML5 web storage API](https://html.spec.whatwg.org/multipage/webstorage.html), or by making server requests that result in saving data. When the extension needs to save something, first consider if it's from an incognito window. By default, extensions DON'T RUN in incognito windows.

      - Incognito mode promises that the window will LEAVE NO TRACKS. When dealing with data from incognito windows, extensions should HONOR this promise. If an extension normally saves browsing history, don't save history from incognito windows. However, extensions can store setting preferences from any window, incognito or not.

        To detect whether a window is in incognito mode, check the `incognito` property of the relevant `tabs.Tab` or `windows.Window` object.

            function saveTabData(tab) {
              if (tab.incognito) {
                return;
              } else {
                chrome.storage.local.set({data: tab.url});
              }
            }

  - [Getting Started Tutorial \- Google Chrome](https://developer.chrome.com/extensions/getstarted)

      - Extensions are made of different, but cohesive, COMPONENTS. Components can include BACKGROUND SCRIPTS, CONTENT SCRIPTS, an OPTIONS PAGE, UI elements and various LOGIC FILES.

        Extension components are created with web development technologies: HTML, CSS, and JavaScript. An extension's components will depend on its functionality and may not require every option.

      - This tutorial will build an extension that allows the user to change the background color of any page on developer.chrome.com. It will use many core components to give an introductory demonstration of their relationships.

        To start, create a new directory to hold the extension's files.

        The completed extension can be downloaded [here](https://developer.chrome.com/extensions/examples/tutorials/get_started_complete.zip).

    Create the Manifest

      - Extensions start with their manifest. Create a file called `manifest.json` and include the following code, or download the file here.

            {
              "name": "Getting Started Example",
              "version": "1.0",
              "description": "Build an Extension!",
              "manifest_version": 2
            }

      - The directory holding the manifest file can be added as an extension in developer mode in its current state.

        除了 manifest 什麼都不寫，就是一個 extension 了，連 icon 都不用給。

         1. Open the Extension Management page by navigating to chrome://extensions.

            The Extension Management page can also be opened by clicking on the Chrome menu, hovering over More Tools then selecting Extensions.

         2. Enable Developer Mode by clicking the toggle switch next to Developer mode.

            Click the LOAD UNPACKED button and select the extension directory.

        Ta-da! The extension has been successfully installed. Because no icons were included in the manifest, a GENERIC TOOLBAR ICON will be created for the extension.

    Add Instruction

      - Although the extension has been installed, it has no INSTRUCTION. Introduce a background script by creating a file titled `background.js`, or downloading it here, and placing it inside the extension directory.

      - Background scripts, and many other important components, must be registered in the manifest. Registering a background script in the manifest tells the extension which file to reference, and how that file should BEHAVE.

            {
              "name": "Getting Started Example",
              "version": "1.0",
              "description": "Build an Extension!",
              "background": {
                "scripts": ["background.js"],
                "persistent": false
              },
              "manifest_version": 2
            }

        The extension is now aware that it includes a NON-PERSISTENT background script and will SCAN the registered file for important EVENTS it needs to LISTEN FOR.

        [Register Background Scripts - Manage Events with Background Scripts \- Google Chrome](https://developer.chrome.com/extensions/background_pages#persistentWarning)

        > The only occasion to keep a background script PERSISTENTLY ACTIVE is if the extension uses `chrome.webRequest` API to block or modify network requests. The `webRequest` API is incompatible with non-persistent background pages.

        所以 `persistent` 是在控制 persistently active 與否，因此大部份情況下用 `"persistent": false` 就夠了。

      - This extension will need information from a PERSISTENT VARIABLE as soon as its installed. Start by including a listening event for `runtime.onInstalled` in the background script. Inside the `onInstalled` listener, the extension will set a value using the `storage` API. This will allow multiple extension components to access that value and update it.

            chrome.runtime.onInstalled.addListener(function() {
              chrome.storage.sync.set({color: '#3aa757'}, function() {
                console.log("The color is green.");
              });
            });

        這裡 persistent variable 並非 JavaScript 的概念 (也不是指 `chrome` 這個 global variable)，而是先把某個參數的值在 extension 一安裝起來時透過 `storage` API 保存起來，其他 ext component 就可以讀取共用。

      - Most APIs, including the `storage` API, must be registered under the `permissions` field in the manifest for the extension to use them.

            {
              "name": "Getting Started Example",
              "version": "1.0",
              "description": "Build an Extension!",
              "permissions": ["storage"],
              "background": {
                "scripts": ["background.js"],
                "persistent": false
              },
              "manifest_version": 2
            }

      - Navigate back to the extension management page and click the RELOAD link. A new field, Inspect views, becomes available with a blue link, background page.

        ![Inspect Views](https://developer.chrome.com/static/images/get_started/view_background.png)

        Click the link to view the background script's console log, "The color is green."

        Reload 的按鈕在個別的 extension (只有本地安裝的才有)，不在上面的 3 個按鈕裡；可以加速開發工作，若能自動 reload 就更好了!

        許多 extension 都有 "Inspect views background page (inactive)" 的連結，代表有 background script，但其中 inactive 指的是 ??

    Introduce a User Interface

      - Extensions can have MANY FORMS of a user interface, but this one will use a popup. Create and add a file titled `popup.html` to the directory, or download it here. This extension uses a button to change the background color.

            <!DOCTYPE html>
            <html>
              <head>
                <style>
                  button {
                    height: 30px;
                    width: 30px;
                    outline: none;
                  }
                </style>
              </head>
              <body>
                <button id="changeColor"></button>
              </body>
            </html>

        最後按 button 會改變 page 的背景色；只是 popup 要在目前的 host 是 `developer.chrome.com` 時，toolbar 上的 icon 才會是彩色的 (作用中)，使用者點擊才會顯示 popup。

      - Like the background script, this file needs to be designated as a popup in the manifest under `page_action`.

            {
              "name": "Getting Started Example",
              "version": "1.0",
              "description": "Build an Extension!",
              "permissions": ["storage"],
              "background": {
                "scripts": ["background.js"],
                "persistent": false
              },
              "page_action": {
                "default_popup": "popup.html"
              },
              "manifest_version": 2
            }

        [chrome\.pageAction \- Google Chrome](https://developer.chrome.com/extensions/pageAction):

        > Use the `chrome.pageAction` API to put icons in the main Google Chrome toolbar, to the right of the address bar. Page actions represent actions that can be taken on the CURRENT PAGE, but that AREN'T APPLICABLE TO ALL PAGES. Page actions appear GRAYED OUT WHEN INACTIVE.

        這跟 Hello Extension 用的 `browser_action` 不同，難怪 Hello Extension 沒有灰色 icon 的現象。因為採用 `page_action` 的關係，所以預設是 inactive，執行期要由程式判斷當下的 page 要不要讓 extension 作用 ??

      - Designation for toolbar icons is also included under `page_action` in the `default_icon` field. Download the images folder here, unzip it, and place it in the extension's directory. Update the manifest so the extension knows how to use the images.

            {
              "name": "Getting Started Example",
              "version": "1.0",
              "description": "Build an Extension!",
              "permissions": ["storage"],
              "background": {
                "scripts": ["background.js"],
                "persistent": false
              },
              "page_action": {
                "default_popup": "popup.html",
                "default_icon": {
                  "16": "images/get_started16.png",
                  "32": "images/get_started32.png",
                  "48": "images/get_started48.png",
                  "128": "images/get_started128.png"
                }
              },
              "manifest_version": 2
            }

        其中 `default_icon` 有規定至少要給幾個不同大小嗎 ??

      - Extensions also display images on the extension management page, the PERMISSIONS WARNING, and FAVICON. These images are designated in the manifest under `icons`.

            {
              "name": "Getting Started Example",
              "version": "1.0",
              "description": "Build an Extension!",
              "permissions": ["storage"],
              "background": {
                "scripts": ["background.js"],
                "persistent": false
              },
              "page_action": {
                "default_popup": "popup.html",
                "default_icon": {
                  "16": "images/get_started16.png",
                  "32": "images/get_started32.png",
                  "48": "images/get_started48.png",
                  "128": "images/get_started128.png"
                }
              },
              "icons": {
                "16": "images/get_started16.png",
                "32": "images/get_started32.png",
                "48": "images/get_started48.png",
                "128": "images/get_started128.png"
              },
              "manifest_version": 2
            }

        什麼是 permission page? 為什麼會跟 favicon 有關? 又 `icons` 跟 `page_action.default_icon` 有什麼不同 ??

      - If the extension is reloaded at this stage, it will include a GREY-SCALE icon, but will not contain any functionality differences.

        Because `page_action` is declared in the manifest, it is up to the extension to tell the browser when the user can interact with `popup.html`.

      - Add DECLARED RULES to the background script with the `declarativeContent` API within the `runtime.onInstalled` listener event.

            chrome.runtime.onInstalled.addListener(function() {
              chrome.storage.sync.set({color: '#3aa757'}, function() {
                console.log('The color is green.');
              });
              chrome.declarativeContent.onPageChanged.removeRules(undefined, function() {
                chrome.declarativeContent.onPageChanged.addRules([{
                  conditions: [new chrome.declarativeContent.PageStateMatcher({
                    pageUrl: {hostEquals: 'developer.chrome.com'},
                  })
                  ],
                      actions: [new chrome.declarativeContent.ShowPageAction()]
                }]);
              });
            });

        為什麼是 `removeRules()` 搭配著 `addRules()` 的用法 ??

        The extension will need permission to access the `declarativeContent` API in its manifest.

            {
              "name": "Getting Started Example",
            ...
              "permissions": ["declarativeContent", "storage"],
            ...
            }

        The browser will now show a FULL-COLOR page action icon in the browser toolbar when users navigate to a URL that contains `"developer.chrome.com"`. When the icon is full-color, users can click it to view `popup.html`.

      - The last step for the popup UI is adding color to the button. Create and add a file called `popup.js` with the following code to the extension directory, or downloaded here.

            let changeColor = document.getElementById('changeColor');

            chrome.storage.sync.get('color', function(data) {
              changeColor.style.backgroundColor = data.color;
              changeColor.setAttribute('value', data.color);
            });

        This code grabs the button from `popup.html` and requests the color value from storage. It then applies the color as the background of the button. Include a `script` tag to `popup.js` in `popup.html`.

            <!DOCTYPE html>
            <html>
            ...
              <body>
                <button id="changeColor"></button>
                <script src="popup.js"></script>
              </body>
            </html>

        Reload the extension to view the GREEN button.

        Popup 載入時，先將 button 的背景色換成 storage 裡的顏色；提示使用者按下 button 時，會將 page 的背景換成什麼顏色。

    Layer Logic

      - The extension now knows the popup should be available to users on developer.chrome.com and displays a colored button, but needs logic for further user interaction. Update `popup.js` to include the following code.

            let changeColor = document.getElementById('changeColor');
            ...
            changeColor.onclick = function(element) {
              let color = element.target.value;
              chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
                chrome.tabs.executeScript(
                    tabs[0].id,
                    {code: 'document.body.style.backgroundColor = "' + color + '";'});
              });
            };

        注意這些 code 主要執行在 `popup.html` 裡，再透過 `chrome.tabs.executeScript()` 在 (active) tab 裡執行另一段 code。

      - The updated code adds an `onclick` event the button, which triggers a [PROGRAMATICALLY INJECTED CONTENT SCRIPT](https://developer.chrome.com/extensions/content_scripts#programmatic). This turns the background color of the page the same color as the button. Using programmatic injection allows for user-invoked content scripts, instead of auto inserting unwanted code into web pages. #ril

        The manifest will need the `activeTab` permission to allow the extension TEMPORARY ACCESS to the `tabs` API. This enables the extension to call `tabs.executeScript`.

            {
              "name": "Getting Started Example",
            ...
              "permissions": ["activeTab", "declarativeContent", "storage"],
            ...
            }

        這裡的 `activeTab` 跟 `tabs` permission 有什麼不同 ?? 所謂 temporary access 是指 `tabs` 也只會拿到 active tab ?? 所以才會有 `tabs[0]` 的寫法。為什麼說是 temporary access ??

        所謂 injection，簡單的說就是 extension 的程式在 page content 插入 JS/CSS 或在裡面執行一小段程式。

      - The extension is now fully functional! Reload the extension, refresh this page, open the popup and click the button to turn it green! However, some users may want to change the background to a different color.

    Give Users Options

      - The extension currently only allows users to change the background to green. Including an options page gives users more control over the extension's functionality, further customizing their browsing experience.

      - Start by creating a file in the directory called `options.html` and include the following code, or download it here.

            <!DOCTYPE html>
            <html>
              <head>
                <style>
                  button {
                    height: 30px;
                    width: 30px;
                    outline: none;
                    margin: 10px;
                  }
                </style>
              </head>
              <body>
                <div id="buttonDiv">
                </div>
                <div>
                  <p>Choose a different background color!</p>
                </div>
              </body>
              <script src="options.js"></script>
            </html>

        注意 `options.js` 被擺在 `</html>` 前 (不用宣告在 manifest 裡)，因為 `options.js` 會直接執行一些程式。

      - Then register the options page in the manifest,

            {
              "name": "Getting Started Example",
              ...
              "options_page": "options.html",
              ...
              "manifest_version": 2
            }

      - Reload the extension and click DETAILS.

        ![Inspect Views](https://developer.chrome.com/static/images/get_started/click_details.png)

        Scroll down the details page and select Extension options to view the options page, although it will currently appear blank.

        ![Inspect Views](https://developer.chrome.com/static/images/get_started/options.png)

      - Last step is to add the options logic. Create a file called `options.js` in the extension directory with the following code, or download it here.

            let page = document.getElementById('buttonDiv');
            const kButtonColors = ['#3aa757', '#e8453c', '#f9bb2d', '#4688f1'];
            function constructOptions(kButtonColors) {
              for (let item of kButtonColors) {
                let button = document.createElement('button');
                button.style.backgroundColor = item;
                button.addEventListener('click', function() {
                  chrome.storage.sync.set({color: item}, function() {
                    console.log('color is ' + item);
                  })
                });
                page.appendChild(button);
              }
            }
            constructOptions(kButtonColors);

      - Four color options are provided then generated as buttons on the options page with `onclick` event listeners. When the user clicks a button, it updates the color value in the extension's GLOBAL STORAGE. Since all of the extension's files pull the color information from global storage no other values need to be updated.

  - [Building a simple Google Chrome extension \- Mark Ashley Bell](https://markb.co.uk/building-a-simple-google-chrome-extension.html) (2014-09-30) #ril
  - [Tutorial: Getting Started \- Google Chrome](https://developer.chrome.com/webstore/get_started_simple) #ril

## Chrome API {: #api }

  - [Google Chrome Extensions: Extension API Design \- YouTube](https://www.youtube.com/watch?v=bmxr75CV36A) #ril

## Debugging

  - [Debugging Extensions \- Google Chrome](https://developer.chrome.com/apps/tut_debugging) #ril

## Manifest ??

  - [Manifest File Format \- Google Chrome](https://developer.chrome.com/extensions/manifest) #ril

## UI

  - [Design User Interface \- Google Chrome](https://developer.chrome.com/extensions/user_interface) #ril
  - [chrome\.contextMenus \- Google Chrome](https://developer.chrome.com/apps/contextMenus) #ril
  - [chrome\.omnibox \- Google Chrome](https://developer.chrome.com/extensions/omnibox) #ril
  - [chrome\.commands \- Google Chrome](https://developer.chrome.com/extensions/commands) #ril

## Declarative Content

  - [chrome\.declarativeContent \- Google Chrome](https://developer.chrome.com/extensions/declarativeContent) #ril

## Browser Action ??

  - [chrome\.browserAction \- Google Chrome](https://developer.chrome.com/extensions/browserAction) #ril

## Content Script

  - [Content Scripts \- Google Chrome](https://developer.chrome.com/extensions/content_scripts) #ril

## Background Script

  - [Manage Events with Background Scripts \- Google Chrome](https://developer.chrome.com/extensions/background_pages) #ril

## Options Page

  - [Give Users Options \- Google Chrome](https://developer.chrome.com/extensions/options) #ril

## Context Menu

  - [chrome\.contextMenus \- Google Chrome](https://developer.chrome.com/extensions/contextMenus) #ril

  - [javascript \- Why does chrome\.contextMenus create multiple entries? \- Stack Overflow](https://stackoverflow.com/questions/38190701/) #ril

    Xan: Your background code will execute multiple times - at least on each browser start / extension reload, and at most every time an Event page ("persistent": false) wakes up.

    `chrome.contextMenus.create` does what it says on a tin - creates a new entry. Every time it's run. Which would be fine, as normally you want to setup everything when your extension is run, but context menu entries actually PERSIST BETWEEN EXTENSION RELOADS - so they keep piling up.

    為什麼沒遇到這種狀況?

    If you are actually using `"persistent": false` Event page, note that using `onclick` attribute is not allowed, as it will be invalidated by extension unload. A more robust way is to use `chrome.contextMenus.onClicked` event - the ID of the menu item will be passed to it to distinguish between options.

        Unchecked runtime.lastError: Extensions using event pages cannot pass an onclick parameter to chrome.contextMenus.create. Instead, use the chrome.contextMenus.onClicked event.

        Context: _generated_background_page.html

    錯誤訊息已經講得很清楚，改用 `chrome.contextMenus.onClicked` 即可。

## Search Engine ??

  - [myBit \- Default Search Engine \- Chrome Web Store](https://chrome.google.com/webstore/detail/mybit-default-search-engi/omkmhgmfbpahmkfdobdinpnkoohndnge?hl=en) 看起來 extension 是可以在 search engine 動點手腳的 #ril
  - [Qwant for Chrome \- Chrome Web Store](https://chrome.google.com/webstore/detail/qwant-for-chrome/hnlkiofnhhoahaiimdicppgemmmomijo?hl=en) #ril

## Packaging ??

  - chrome://extensions 啟用 Developer Mode 之後，上方會多出幾個按鈕，其中一個是 Pack extension。

---

參考資料：

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

  - [Automate your chrome extension deployment in minutes\! \- Gokul Kathirvel](https://gokatz.me/blog/automate-your-chrome-extension-deployment-in-minutes/) (2018-05-28) #ril

## Distribution (Enterprise) ??

ZIP 上傳後，後端會做一些基本的檢查，若發現一些顯而異見的問題 (例如 manifest 宣告的檔案不存在)，會收到類似的信件：

> Dear Developer, We routinely review items in the Chrome Web Store for compliance with our Program policies to ensure a safe and trusted experience for our users. Your item “XYZ,” with ID: jfikiggbdcelopifjibfkndkheikjckf, is being taken down as it currently does not work or provide any functionality upon installation. Items on the Chrome Web Store should work and provide the promised functionality that aligns with the description of the item. Please review your item and make necessary changes so that it provides the function/service included in the item’s description. Once your item complies with Chrome Web Store policies, you may request re-publication in your developer dashboard. Your item will be manually reviewed for policy compliance which typically takes a few business days, prior to re-publication. If you have any questions about this item’s removal, you may reply to this email and the Chrome Web Store developer support team will follow up with you. Important Note Repeated or egregious policy violations in the Chrome Web Store may result in your developer account being suspended. This may also result in the suspension of related Google services associated with your Google account. Thank you for your cooperation, Google Chrome Web Store team

---

參考資料：

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
  - Google Chrome 每幾個小時會檢查一次是否有更新，但實際更新的頻率無法掌握，若要馬上更新，可以在 `chrome://extensions` 啟用 Developer Mode，按 Update 可以立即更新所有的 extension；實驗發現，重啟 Chrome 也可以觸發更新。

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
  - [HTML](html.md)
  - [JavaScript](javascript.md)
  - [CSS](css.md)

手冊：

  - [Developer Guide](https://developer.chrome.com/extensions/devguide)
  - [Chrome Extension APIs](https://developer.chrome.com/extensions/api_index)
  - [Manifest File Format](https://developer.chrome.com/extensions/manifest)
  - [Available Permissions](https://developer.chrome.com/extensions/declare_permissions)
