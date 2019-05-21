# Deep Linking

  - [Deep linking \- Wikipedia](https://en.wikipedia.org/wiki/Deep_linking) #ril

  - [Mobile deep linking \- Wikipedia](https://en.wikipedia.org/wiki/Mobile_deep_linking) #ril

      - In the context of mobile apps, deep linking consists of using a uniform resource identifier (URI) that LINKS TO A SPECIFIC LOCATION WITHIN A MOBILE APP RATHER THAN SIMPLY LAUNCHING THE APP.

        從這一點就能理解為何要叫 "deep" -- 深入 app 裡某個頁面。

        DEFERRED deep linking allows users to deep link to content EVEN IF THE APP IS NOT ALREADY INSTALLED. Depending on the mobile device platform, the URI required to trigger the app may be different.

    Deep linking and mobile operating systems

      - Unlike the Web, where the underlying technology of HTTP and URLs ALLOW FOR DEEP LINKING BY DEFAULT, enabling deep linking on mobile apps requires these apps be configured to properly handle a uniform resource identifier (URI). Just like a URL is an address for a website, a URI is the address for an app on a mobile device. Examples of URIs that launch a mobile app:

          - `twitter://` is the iOS URI to launch Twitter’s mobile app
          - `YouTube://` is the iOS URI to launch YouTube’s mobile app

      - The format of the URI used to trigger or deep link an app is often different depending on the mobile operating system. Android devices work through intents, BlackBerry 10 devices work through BB10's invocation framework, Firefox OS devices work through Web Activities, iOS devices work through the `openUrl` application method, and Windows Phone 8 devices work through the `UriMapper` class.

          - `fb://profile/33138223345` is an example of a mobile DEEP LINK. The URI contains all the information needed to launch directly into a particular location within an app, in this case the profile with id '33138223345', i.e., the Wikipedia page, within the Facebook app, instead of simply launching the Facebook app `fb://`.

          - eBay's apps demonstrate the use of different schemes by platform. `eBay://launch?itm=360703170135` is the URI that deep links into eBay’s iOS app while `eBay://item/view?id=360703170135` links into eBay’s Android app.

            還是有點像，因為平台限制而有這樣的差異??

    Complexity of mobile deep linking and the need for a streamlined solution

      - The greatest benefit of mobile deep linking is the ability for MARKETERS and app developers to bring users directly into the specific location within their app with a dedicated link. JUST AS DEEP LINKS MADE THE WEB MORE USABLE, mobile deep links do the same for mobile apps.

      - Unlike deep links on the web, where the link format is standardized based on HTTP guidelines, mobile deep links DO NOT FOLLOW A CONSISTENT FORMAT. This causes CONFUSION in development because different sets of links are required to access the same app on a different mobile operating system.

        對單一平台的開發人員可能還好，但對於測試人員可能就苦了。

    Passing search data via deep linking

      - Google allows app developers who have BOTH iOS and Android apps to SURFACE IN-APP CONTENT VIA MOBILE GOOGLE SEARCHES. Developers will need to submit their app and deep linking apps on both iOS and Android TO BE INDEXED by Google. Alternatively, developers can use Google's SHORT LINKS to deep link mobile app users if the app is installed and direct OTHERS to the webpage.

        實際上要讓什麼東西讓 Google 索引?? 網頁於 in-app content 的對照關係?

      - One example of a better user experience made possible because of deep link and data passing through install solution is one in which search information is passed into an app to bring the user to the exact information that drove them to the app. Compared to a common web link, this implementation may reduce the number of steps required. For example, to search for hotels in Boston, a user currently needs to:

          - Perform a Google search for a term
          - See that a company has relevant content in its app
          - Manually switch from the browser to the app (download the app first if required)
          - Perform the search again in the app

        That can be shortened to:

          - Search on Google
          - Select the in-app search result to view in-app (if app is installed)

  - [App Deep Linking Guide](http://www.businessofapps.com/news/app-deep-linking-guide/) (2015-03-31) #ril

      - COMMUNICATING BETWEEN APPS is often clumsy and usually results in BREAKING UP THE USER EXPERIENCE and losing customers and users. However, “Deep linking” is changing the way that apps interact with each other, moving from a world of ‘closed gardens’ to a much more open and seamless platform.

        從 browser 往其他 app 切換是常見的情境，但跨其他 app 間的切換也是有的，這當然也包括從其他 app 切換到 browser。

      - The way deep linking works is known to everyone who has used the internet: a link that takes you directly to a page DEEP WITHIN A WEBSITE HIERARCHY, bypassing the upper pages to immediately take you to the content you wanted to see.

        It’s what the internet is built on, and the difference in user experience between that and MOBILE SURFING is obvious: thanks to international standards for URLs, you don’t have to download a new browser or a plug-in every time you reach a new webpage, every browser can read anything in HTTP and take you you directly to the content you want. Unlike for mobile apps, at least until now …

      - Deep-linking for mobile is a URI (Uniform Resource Identifier) that links to a specific location within an application or app, as opposed to the generic homepage or simply launching the app and starting at its home screen.

        The technology has been going mainstream with recent coverage in the likes of the Huffington Post, which examined insights from a Deeplink conference and ReadWriteWeb, who called it the next big thing and a huge asset for marketers. Rightly so, as it promises to radically improve mobile app user experience and replicate the ease of navigation that the internet offers, but BETWEEN APPLICATIONS.

      - As an example, imagine booking a restaurant table on the restaurant’s app. Once complete, the app shows you an ad for a cab company, and a fare from your home location to the restaurant in time for the reservation. Clicking on the link, there are currently a number of possible flows here:

         1. the link takes you to the correct page in the cab’s app, which you have downloaded before, and RETAINS time and location data;
         2. you don’t have the app, so the link takes you to its download page --> 不會把使用者帶到剛剛那個廣告所講的餐廳、活動...
         3. the link takes you to the cab company’s web-app (in a web browser), POTENTIALLY LOSING your data for end location and time of booking.

        The second two effectively BREAK THE USER EXPERIENCE, but if deep-linking is done correctly, you will be able to transition seamlessly from booking a table to booking a cab quickly and efficiently. The deep link, which would take the user to the NATIVE APP OR WEB-APP, would POINT TO THE RIGHT PAGE WITH ALL THE NECESSARY DATA, allowing you to book a cab with a single click after the initial one on the advert.

        如果 app 以廣告為主要營收來源的話，能夠把使用者帶到對的地方就很重要，但這不是廣告平台要提供的?? 換個角度，如果你是廣告主，也會希望投放的廣告，能夠順利把人帶進 app。

      - The technology is still in its nascent stage and is yet to be perfectly streamlined. There are a number of companies tackling the issue, all with their takes and solutions:

          - URX for example will detect whether you have the correct app, and if not, bypass the download process entirely by taking you to the correct web-app page, without losing METADATA.
          - WildCards creates a “card” ?? –  effectively extracting a snippet of code from the app, allowing you to use it without having to download it fully.
          - Button and Branch, which has a handy guide on Deep Linking basics, will INSTALL THE NATIVE APP, BUT WITHOUT LOSING THE METADATA, avoiding having to re-enter it or search for the content again within the website.
          - OneLink aims to produce a single “SMART” LINK able to direct users to the correct URL, a solution similar to that of link-shortening giants Bitly who have recently thrown their considerable weight into the technology.
          - Finally there is Applinks, which has the advantage of being OPEN SOURCE, and DeepLink, who offer a wide support base with translation rules for PRE-EXISTING PAGES INTO DEEP-LINKS.

      - These solutions, as with all new technologies, each present some issues. For starters, for cards and DIRECT ?? deep-links, the entirety of the mobile and web apps need to be CODED TO SUPPORT IT, which can be daunting for smaller developers. If the link does detect which OS your user has, it will need a native app for that OS.

        While UX may be seamless, it’s hard to TRACK USER INFORMATION with deep links, decreasing the precision of your METRICS AND SEGMENTATION. (廣告考量?) Another very important issue is that Apple, for one, does not allow credit card data to be passed between apps: you may have to download the application, sign-up and re-enter details manually regardless of how streamlined the experience is, making “cards” more valuable for content-only websites.

      - Lastly, unlike HTTP, there is no settled, international protocol on deep linking and app structure, and what works for one app, browser or OS might not work for the rest. MobileDeepLinking, however is a collaborative industry effort attempting to bring deep-linking companies together to establish a standard, and is also a great learning resource on SDKs, implementation and protocols. The companies working hard to get the technology off the ground are listed below.

        不過 2019 的今天，[MobileDeepLinking](http://mobiledeeplinking.org/) 似乎消失了 ...

  - [Mobile Deep Linking Basics \| Branch Blog](https://blog.branch.io/mobile-deeplinking-basics/) (2015-04-23)
  - [Deferred deep linking \- Wikipedia](https://en.wikipedia.org/wiki/Deferred_deep_linking) #ril

## 工具 {: #tools }

  - [Dynamic Links | Firebase](https://firebase.google.com/docs/dynamic-links/)
  - [App Links](https://developers.facebook.com/docs/applinks) #ril
  - [OneLink | AppsFlyer](https://www.appsflyer.com/product/one-link-deep-linking/)
  - [Branch](https://branch.io/)
