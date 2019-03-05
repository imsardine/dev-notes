---
title: Scrapy / Testing
---
# [Scrapy](scrapy.md) / Testing

  - [Re: Recommendations for testing scrapy code offline? \- Google Groups](https://groups.google.com/forum/#!topic/scrapy-users/9pkJUptUQEM) (2012-09-08)
      - Steven Almeroth: Have you tried the [`HttpCacheMiddleware`](http://doc.scrapy.org/en/latest/topics/downloader-middleware.html#module-scrapy.contrib.downloadermiddleware.httpcache)?

            HTTPCACHE_ENABLED = True
            HTTPCACHE_EXPIRATION_SECS = 0

        引用了 Asheesh Laroia 最初的問題，希望可以安排不同 URL 的 status code 及 response body：

          - The one feature I'm missing is how to use pre-saved data to seed `Response` objects so that, instead of hitting the network, they USE DATA FROM THE FILESYSTEM. The reason we want that feature is that it permits us to write automated tests very easily for scrapers. ("Automated tests" in the sense of python's `unittest` module.)
          - There could be some generic "offline mode" for scrapy, but if so, I haven't seen it. (Is there?) It'd be convenient if you could configure it with e.g. a YAML file mapping URLs to HTTP status codes and file paths for the content to use as their bodies.
          - Presumably one enchancement of that would be to have a dict of URLs to STATUS CODES, so that you can test the errback as well, not just the callback. (In the past, we did that through the "python-mock" module, but the architecture of Scrapy makes it seemingly possible to do all this without ever using mocks, which is lovely!)

        [Steven Almeroth](https://www.linkedin.com/in/stevenalmeroth/) 也是 Scrapinghub 的開發者。

      - 確實在 `HttpCacheMiddleware` > Dummy policy (default) 有提到一些跟測試相關的東西：
          - This policy has NO AWARENESS of any HTTP Cache-Control directives. Every request and its corresponding response are cached. When the same request is seen again, the response is returned without transferring anything from the Internet.
          - The Dummy policy is useful for testing spiders faster (without having to wait for downloads every time) and for trying your spider offline, when an Internet connection is not available. The goal is to be able to “REPLAY” a spider run exactly AS IT RAN BEFORE.

            問題是如何事先安排好 cache??

  - [How do I write tests for Scrapy project? \- Quora](https://www.quora.com/How-do-I-write-tests-for-Scrapy-project) (2017-03-09)

    Niranjan Sagar: There are two ways for this.

      - [Spiders Contracts](https://doc.scrapy.org/en/latest/topics/contracts.html) - We have somethings call Spider contracts available under Scrapy. This enables you to TEST EACH CALLBACK of your spider by HARDCODING a sample url and check various constraints for how the callback processes the response. Not only callback other things can also be tested.

      - Other way is. Most of the people prefer running Scrapy crawlers using `scrapy crawl <spider-name>`. But instead we have one more way of running the crawler. The crawler can we written as Python Script, with main function and can be written as python `crawler_name.py` (from the same directory). For more information please refer this link [Common Practices](https://doc.scrapy.org/en/latest/topics/practices.html#run-scrapy-from-a-script). Similar to other Python script we can write the Unittest cases here.

        問題不在如何執行 spider，而是如何控制 response 不是?

  - [python \- How to work with the scrapy contracts? \- Stack Overflow](https://stackoverflow.com/questions/25764201/) (2014-09-10)

    alecxe: Yes, Spiders Contracts is FAR FROM being clear and detailed. 確實是如此 XD

      - I'm not an expert in writing spider contracts (actually wrote them only once while working on [web-scraping tutorial](http://newcoder.io/scrape/) at newcoder.io). But whenever I needed to write tests for Scrapy spiders, I preferred to follow the approach [suggested here](https://stackoverflow.com/a/12741030/771848) (2011 年的討論) - create a fake response from a local html file. It is ARGUABLE IF THIS IS STILL A UNIT TESTING PROCEDURE, but this gives you way more flexibility and robustness.
      - Note that you can still write contracts but you will quickly feel the need of extending them and writing CUSTOM CONTRACTS. Which is pretty much ok. 常要自訂 contract，聽起來不 okay，但又說 okay?

  - [Unit testing \- Google Groups](https://groups.google.com/forum/#!topic/scrapy-users/uh-t_UCRbnE) (2011-06-23)
      - Pablo Hoffman: There's an idea for automating some spider tests that never got implemented (so far): http://dev.scrapy.org/wiki/SEP-017

        But nothing prevents you from using standard Python unit-testing facilities to test the Spider object methods (ie. the callbacks). You build the `Response` in the test code, and then call the method with the response and assert that you get the expected items/requests in the output.

        A warning though: automating is the key. Otherwise, if you manage a lot of spiders, you may find that testing may take even longer than writing the spiders themselves - though this applies to other software testing as well, not only spiders :)

        Pablo Hoffman 是 [Scrapy 跟 Scrapinghub co-founder](https://twitter.com/PabloHoffman)。

  - [python \- Scrapy Unit Testing \- Stack Overflow](https://stackoverflow.com/questions/6456304/) (2011-06-23)
      - ciferkey: I've been talking on [Scrapy-Users](http://groups.google.com/group/scrapy-users/browse_thread/thread/ba1fadfd40916e71) and I guess I am supposed to "build the Response in the test code, and then call the method with the response and assert that I get the expected items/requests in the output". 提供這想法的是 Scrapy & Scrapinghub 的 co-founder -- Pablo Hoffman。
      - Sam Stoelinga: (2012-10-05) The way I've done it is create FAKE RESPONSES, this way you can test the parse function offline. But you get the real situation by using real HTML. #ril
      - ciferkey: (2011-06-27) You can follow this [snippet](https://snipplr.com/view/67006/) from the scrapy site to run it from a script. Then you can make any kind of asserts you'd like on the returned items. 又提到從 script 執行 spider，似乎跟測試真有些關係??
      - Shane Evans: (2012-10-05) The newly added Spider Contracts are worth trying. It gives you a simple way to add tests without requiring a lot of code.
      - Anton Egorov: (2013-10-21) It is very poor at the current moment. You have to write your own contracts to check something more complicated than parsing of this page returns N items with fields `foo` and `bar` filled with any data 好像 2019 的現在還是一樣 XD，稍微複雜一點的檢查就要自訂 contract ...
      - Hadrien: (2016-07-05) I use [Betamax](http://betamax.readthedocs.io/) to run test on real site the first time and keep http responses locally so that next tests run super fast after: #ril 像是 `HttpCacheMiddleware` 的做法?

  - [Run Scrapy from a script - Common Practices — Scrapy 1\.6\.0 documentation](https://doc.scrapy.org/en/latest/topics/practices.html#run-scrapy-from-a-script) 還真有提到 "using the testspiders project as example." #ril

  - [Snip2Code \- Scrapy Contracts Evolution](http://www.snip2code.com/Snippet/82002/Scrapy-Contracts-Evolution) (2014-07-02) #ril

## Spider Contract ??

  - [Spiders Contracts — Scrapy 1\.6\.0 documentation](https://doc.scrapy.org/en/latest/topics/contracts.html) #ril
      - This is a new feature (introduced in Scrapy 0.15) and may be subject to minor functionality/API updates. Check the release notes to be notified of updates. 其實是 Scrapy 0.16.0 -- added Spiders Contracts, a mechanism for testing spiders in a formal/reproducible way，時間是 2012-10-18

      - Testing spiders can get particularly annoying and while nothing prevents you from writing unit tests the task gets cumbersome quickly. Scrapy offers an integrated way of testing your spiders by the means of CONTRACTS??.
      - This allows you to TEST EACH CALLBACK of your spider by hardcoding a sample url and CHECK VARIOUS CONSTRAINTS for how the callback processes the response. Each contract is prefixed with an `@` and included in the DOCSTRING. See the following example:

            def parse(self, response):
                """ This function parses a sample response. Some contracts are mingled (混合)
                with this docstring.

                @url http://www.amazon.com/s?field-keywords=selfish+gene
                @returns items 1 16
                @returns requests 0 0
                @scrapes Title Author Year Price
                """

    測試要如何執行? 總有人要去解讀 `@xxx` (其間有順序??) ... 若 `SPIDER_CONTRACTS_BASE` 有些 contract 預設啟用，都用 `scrapy crawl` 執行的話，Scrapy 如何知道現在是不是在測試? --> 用 `scrapy check <spider>`

    以 Python 的 Simple HTTP Server 觀察真正送出的 request：

        class QuotesSpider(scrapy.Spider):
            name = "quotes"
            start_urls = [
                'http://localhost:8000/0',
            ]

            def parse(self, response):
                """
                @url http://localhost:8000/1
                @returns items 1

                @url http://localhost:8000/2
                @returns items 2
                @scrapes text author

                @url http://localhost:8000/3 <-- 故意沒有安排 @returns 或 @scrapes
                """

                for quote in response.css('div.quote'):
                    ...

        $ touch 0 1 2 3 # 使 request 不會遇到 404
        $ python -m SimpleHTTPServer

        $ scrapy check -l
        quotes
          * parse

        $ scrapy check --verbose
        [quotes] parse (@returns post-hook) ... FAIL
        [quotes] parse (@returns post-hook) ... FAIL
        [quotes] parse (@scrapes post-hook) ... ok

        ======================================================================
        FAIL: [quotes] parse (@returns post-hook)
        ----------------------------------------------------------------------
        Traceback (most recent call last):
          File "/private/tmp/scrapy/lib/python2.7/site-packages/scrapy/contracts/__init__.py", line 151, in wrapper
            self.post_process(output)
          File "/private/tmp/scrapy/lib/python2.7/site-packages/scrapy/contracts/default.py", line 74, in post_process
            (occurrences, self.obj_name, expected))
        ContractFail: Returned 0 items, expected 1..inf

        ======================================================================
        FAIL: [quotes] parse (@returns post-hook)
        ----------------------------------------------------------------------
        Traceback (most recent call last):
          File "/private/tmp/scrapy/lib/python2.7/site-packages/scrapy/contracts/__init__.py", line 151, in wrapper
            self.post_process(output)
          File "/private/tmp/scrapy/lib/python2.7/site-packages/scrapy/contracts/default.py", line 74, in post_process
            (occurrences, self.obj_name, expected))
        ContractFail: Returned 0 items, expected 2..inf

        ----------------------------------------------------------------------
        Ran 3 contracts in 0.131s

        FAILED (failures=2)

    對照 Simple HTTP Server 的輸出，會發現：

        $ python -m SimpleHTTPServer
        Serving HTTP on 0.0.0.0 port 8000 ...
        127.0.0.1 - - [13/Feb/2019 22:49:54] code 404, message File not found
        127.0.0.1 - - [13/Feb/2019 22:49:54] "GET /robots.txt HTTP/1.1" 404 -
        127.0.0.1 - - [13/Feb/2019 22:49:54] "GET /3 HTTP/1.1" 200 -

      - 一個 callback 就算有多個 `@url`，也只會往最後一個 `@url` 送出 "一次" request；完全不理會 `starts_url` 的設定。
      - Docstring 裡除 `@url` 外的 `@xxx` 會依序做檢查，也就是最後報告的 Run N contracts in ...s。

    顯然無法測試不同的 response，看來用 scriptable proxy (例如 mitmproxy) 安排不同的回應才是可行的?? 讓大部份的邏輯不要跟 Scrapy framework 相依就方便做單元測試 ...

  - [Release notes — Scrapy 1\.6\.0 documentation](https://doc.scrapy.org/en/latest/news.html)

    由於 Spiders Contracts 很難入手，從 Release Notes 追 contract 的歷史；看來官方有持續在強化 Contract，只是文件沒寫好?

    Scrapy 0.16.0 (released 2012-10-18)

      - added Spiders Contracts, a mechanism for testing spiders in a formal/reproducible way

    Scrapy 0.16.2 (released 2012-11-09)

      - scrapy contracts: python2.6 compat (commit a4a9199)
      - scrapy contracts verbose option (commit ec41673)

    Scrapy 0.18.0 (released 2013-08-09)

      - Several improvements to spider contracts

    Scrapy 0.24.0 (2014-06-26)

      - Set exit code to non-zero when contracts fails (issue 727)
      - Improve scrapy check contracts command (issue 733, issue 752)

    Scrapy 1.3.1 (2017-02-08)

      - Enforce numeric values for COMPONENTS ORDER in `SPIDER_MIDDLEWARES`, `DOWNLOADER_MIDDLEWARES`, `EXTENIONS` and `SPIDER_CONTRACTS` (issue 2420).

    Scrapy 1.6.0 (2019-01-30)

      - `scrapy.contracts` fixes and new features;
      - `scrapy.contracts` improvements
          - Exceptions in contracts code are handled better (issue 3377);
          - `dont_filter=True` is used for contract requests, which allows to test different callbacks with the same URL (issue 3381);
          - `request_cls` attribute in Contract subclasses allow to use different Request classes in contracts, for example `FormRequest` (issue 3383).
          - Fixed errback handling in contracts, e.g. for cases where a contract is executed for URL which returns non-200 response (issue 3371).

  - [`scrapy/default.py` at master · scrapy/scrapy](https://github.com/scrapy/scrapy/blob/master/scrapy/contracts/default.py) #ril

    內建的 `UrlContract`、`ReturnsContract`、`ScrapesContract` 都在這裡，有助於理解 contract 的定位。

      - 除 `UrlContract` 實作 `adjust_request_args()` 外，其餘都在 `post_process()` 裡檢查 output，有狀況時丟出 `scrapy.exceptions.ContractFail`。
      - `UrlContract.adjust_request_args()` 固定將 `args['url']` 設定成 `@url ...` 所提供的 URL，感覺 Contract 不涉入如何提供 response 這一段，反正 `@url` 提供的 URL 的回應要自己控制?? 跟 `HttpCacheMiddleware` 有關? 如果要測試各種狀況，可以提供多個 `@url` 嗎??

  - [`check` - Command line tool — Scrapy 1\.6\.0 documentation](https://doc.scrapy.org/en/latest/topics/commands.html#std:command-check)
      - Syntax: `scrapy check [-l] <spider>`
      - Requires project: YES
      - Run contract checks. Usage examples:

            $ scrapy check -l
            first_spider   <-- spider name
              * parse
              * parse_item <-- 有哪些 callback 的 docstring 含有 `@xxx`
            second_spider
              * parse
              * parse_item

            $ scrapy check
            [FAILED] first_spider:parse_item
            >>> 'RetailPricex' field is missing

            [FAILED] first_spider:parse
            >>> Returned 92 requests, expected 0..4

  - [Part 2: Writing our Spider – New Coder](http://newcoder.io/scrape/part-2/) 程式碼有提及 `Testing contracts:` 及 `@xxx` 等，但沒有說明怎麼用?
  - [`SPIDER_CONTRACTS` - Settings — Scrapy 1\.6\.0 documentation](https://docs.scrapy.org/en/latest/topics/settings.html#spider-contracts)
      - Default: `{}`. A dict containing the SPIDER CONTRACTS ENABLED in your project, used for testing spiders. For more info see Spiders Contracts.
  - [`SPIDER_CONTRACTS_BASE` - Settings — Scrapy 1\.6\.0 documentation](https://docs.scrapy.org/en/latest/topics/settings.html?highlight=testing#spider-contracts-base)
      - Default:

        Key-value pair 中的 value 是什麼數值? --> 按 [Scrapy 1.3.1 (2017-02-08) Release Note](https://doc.scrapy.org/en/latest/news.html#scrapy-1-3-1-2017-02-08) 的說法，是 components order。

            {
                'scrapy.contracts.default.UrlContract' : 1,
                'scrapy.contracts.default.ReturnsContract': 2,
                'scrapy.contracts.default.ScrapesContract': 3,
            }

      - A dict containing the scrapy contracts ENABLED BY DEFAULT in Scrapy. You should never modify this setting in your project, modify `SPIDER_CONTRACTS` instead. For more info see Spiders Contracts.
      - You can disable any of these contracts by assigning `None` to their CLASS PATH in `SPIDER_CONTRACTS`. E.g., to disable the built-in `ScrapesContract`, place this in your `settings.py`:

            SPIDER_CONTRACTS = {
                'scrapy.contracts.default.ScrapesContract': None,
            }

  - [Scrapy shell — Scrapy 1\.5\.0 documentation](https://doc.scrapy.org/en/1.5/topics/shell.html) INTERACTIVELY test your expressions while you’re writing your spider #ril
  - [Telnet Console — Scrapy 1\.5\.0 documentation](https://doc.scrapy.org/en/1.5/topics/telnetconsole.html?highlight=scraper) 跟測試好像沒什麼關係? #ril

