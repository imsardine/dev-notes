# Scrapy

  - 從網站 (或 API) 萃取結構化資料的 framework -- 只要提供如何取出資料 (及衍生的連結) 的演算法，剩下的排程下載、流量控制、快取等，Scrapy 都可以幫處理掉。
  - 雖然官方文件沒有說明，但 logo 的那把 "鏟子"，應該就是 "刮刀/刮泥板" (scraper)。

參考資料：

  - [Scrapy \| A Fast and Powerful Scraping and Web Crawling Framework](https://scrapy.org/)
      - An open source and collaborative framework for extracting the data you need from websites. In a fast, simple, yet extensible way.
      - Fast and powerful - write the RULES to extract the data and let Scrapy do the rest
  - [Scrapy at a glance — Scrapy 1\.5\.0 documentation](https://doc.scrapy.org/en/1.5/intro/overview.html)
      - Scrapy is an application framework for crawling web sites and extracting STRUCTURED DATA which can be used for a wide range of useful applications, like data mining, information processing or historical archival (類 [Wayback Machine](https://web.archive.org/) 的應用?).
      - Even though Scrapy was originally designed for web scraping, it can also be used to extract data using APIs (such as Amazon Associates Web Services) or as a GENERAL PURPOSE web crawler.
  - [Scrapy \- Wikipedia](https://en.wikipedia.org/wiki/Scrapy) #ril

## 新手上路 ?? {: #getting-started }

  - [Scrapy \| A Fast and Powerful Scraping and Web Crawling Framework](https://scrapy.org/)
      - Build and run your web spiders

            import scrapy

            class BlogSpider(scrapy.Spider):
                name = 'blogspider'
                start_urls = ['https://blog.scrapinghub.com'] # 可以有多個起點

                def parse(self, response): # response 已是解析過的 HTML，型態 scrapy.http.Response
                    for title in response.css('.post-header>h2'):
                        yield {'title': title.css('a ::text').extract_first()} # 用 yield 拋出資料

                    for next_page in response.css('div.prev-post > a'):
                        yield response.follow(next_page, self.parse) # 用 yield 及 .follow() 往下一頁鑽

      - 用 `scrapy runspider myspider.py` 執行，過程中看到 extension、downloader/spider middleware、item pipeline，其間的關係是什麼?? 不過很明顯 crawl 是指抓取網頁 (而且會順著 link 走)，而 scrape 則是從 response 中刮取資料。

            $ scrapy runspider myspider.py
            2018-08-18 14:44:43 [scrapy.utils.log] INFO: Scrapy 1.5.1 started (bot: scrapybot)
            ...
            2018-08-18 14:44:43 [scrapy.middleware] INFO: Enabled extensions:
            ['scrapy.extensions.memusage.MemoryUsage',
             'scrapy.extensions.logstats.LogStats',
             'scrapy.extensions.telnet.TelnetConsole',
             'scrapy.extensions.corestats.CoreStats']
            2018-08-18 14:44:43 [scrapy.middleware] INFO: Enabled downloader middlewares:
            ['scrapy.downloadermiddlewares.httpauth.HttpAuthMiddleware',
             'scrapy.downloadermiddlewares.downloadtimeout.DownloadTimeoutMiddleware',
             'scrapy.downloadermiddlewares.defaultheaders.DefaultHeadersMiddleware',
             'scrapy.downloadermiddlewares.useragent.UserAgentMiddleware',
             'scrapy.downloadermiddlewares.retry.RetryMiddleware',
             'scrapy.downloadermiddlewares.redirect.MetaRefreshMiddleware',
             'scrapy.downloadermiddlewares.httpcompression.HttpCompressionMiddleware',
             'scrapy.downloadermiddlewares.redirect.RedirectMiddleware',
             'scrapy.downloadermiddlewares.cookies.CookiesMiddleware',
             'scrapy.downloadermiddlewares.httpproxy.HttpProxyMiddleware',
             'scrapy.downloadermiddlewares.stats.DownloaderStats']
            2018-08-18 14:44:43 [scrapy.middleware] INFO: Enabled spider middlewares:
            ['scrapy.spidermiddlewares.httperror.HttpErrorMiddleware',
             'scrapy.spidermiddlewares.offsite.OffsiteMiddleware',
             'scrapy.spidermiddlewares.referer.RefererMiddleware',
             'scrapy.spidermiddlewares.urllength.UrlLengthMiddleware',
             'scrapy.spidermiddlewares.depth.DepthMiddleware']
            2018-08-18 14:44:43 [scrapy.middleware] INFO: Enabled item pipelines:
            []
            2018-08-18 14:44:43 [scrapy.core.engine] INFO: Spider opened
            2018-08-18 14:44:43 [scrapy.extensions.logstats] INFO: Crawled 0 pages (at 0 pages/min), scraped 0 items (at 0 items/min)
            2018-08-18 14:44:43 [scrapy.extensions.telnet] DEBUG: Telnet console listening on 127.0.0.1:6023
            2018-08-18 14:44:43 [scrapy.core.engine] DEBUG: Crawled (200) <GET https://blog.scrapinghub.com> (referer: None)
            2018-08-18 14:44:44 [scrapy.core.scraper] DEBUG: Scraped from <200 https://blog.scrapinghub.com>
            {'title': u'GDPR Compliance For Web Scrapers: The Step-By-Step Guide'}
            ...
            2018-08-18 14:44:44 [scrapy.core.engine] INFO: Closing spider (finished)
            2018-08-18 14:44:44 [scrapy.statscollectors] INFO: Dumping Scrapy stats:
            {'downloader/request_bytes': 219,
            ...
             'start_time': datetime.datetime(2018, 8, 18, 6, 44, 43, 885166)}
            2018-08-18 14:44:44 [scrapy.core.engine] INFO: Spider closed (finished)

  - [Scrapy at a glance — Scrapy 1\.5\.0 documentation](https://doc.scrapy.org/en/1.5/intro/overview.html) #ril
      - 從 http://quotes.toscrape.com 抓取名言佳句 (quote)。存成 `quotes_spider.py`，執行 `scrapy runspider quotes_spider.py -o quotes.json` 就可以在 `quotes.json` 看到 yield 出來的資料；其中 `-o` 的作用是 dump scraped items into file。

            import scrapy

            class QuotesSpider(scrapy.Spider):
                name = "quotes"
                start_urls = [
                    'http://quotes.toscrape.com/tag/humor/',
                ]

                def parse(self, response):
                    for quote in response.css('div.quote'):
                        yield {
                            'text': quote.css('span.text::text').extract_first(),
                            'author': quote.xpath('span/small/text()').extract_first(), # 用了 XPath
                        }

                    next_page = response.css('li.next a::attr("href")').extract_first()
                    if next_page is not None:
                        yield response.follow(next_page, self.parse)

        由於 `Response.follow()` 會回傳 `scrapy.http.Request`，看似 crawl engine 只會將非 `Request` 的 `yield` 視為 scraped item；什麼時候 item 要繼承 `scrapy.Item`??

      - When you ran the command `scrapy runspider quotes_spider.py`, Scrapy looked for a Spider definition inside it and ran it through its CRAWLER ENGINE. 在 Python module 裡找出 spider definition -- 繼承 `scrapy.Spider` 的 class。
      - The crawl started by making requests to the URLs defined in the `start_urls` attribute (in this case, only the URL for quotes in humor category) and called the DEFAULT CALLBACK METHOD `parse`, passing the response object as an argument. In the `parse` callback, we loop through the quote elements using a CSS Selector, yield a Python dict with the extracted quote text and author, look for a LINK TO THE NEXT PAGE and SCHEDULE ANOTHER REQUEST using the same `parse` method as callback. 整個 crawl 從 spider 裡的 `start_urls` attribute 開始，crawler engine 會往 start URLs 送出 request，再把 response 送回 `parse()` (default callback method)，而 callback method 的責任就是 "取出資料，並排程接下來可以往哪走"。接下來的排程可以自訂另一個 callback method 來接收 response，跟 start URLs 的處理區分開來。
      - Here you notice one of the main advantages about Scrapy: requests are SCHEDULED AND PROCESSED ASYNCHRONOUSLY. This means that Scrapy doesn’t need to wait for a request to be finished and processed, it can send another request or do other things in the meantime. This also means that other requests can keep going even if some request fails or an error happens while handling it.
      - While this enables you to do VERY FAST CRAWLs (sending multiple concurrent requests at the same time, in a FAULT-TOLERANT way) Scrapy also gives you control over the politeness of the crawl through a few settings. You can do things like setting a download delay between each request, limiting amount of concurrent requests per domain or per IP, and even using an AUTO-THROTTLING extension that tries to figure out these automatically. 這類流量控制統稱為 throttling。

  - [Scrapy Tutorial — Scrapy 1\.5\.0 documentation](https://doc.scrapy.org/en/1.5/intro/tutorial.html) #ril

## Spider ??

  - [Spiders — Scrapy 1\.5\.1 documentation](https://doc.scrapy.org/en/1.5/topics/spiders.html)
      - Spiders are classes which define how a CERTAIN SITE (or a GROUP OF SITES) will be scraped, including how to perform the crawl (i.e. follow links) and how to extract structured data from their pages (i.e. scraping items). 也就是說 spider 裡實作了 crawling (跟著連結走) 與 scraping (取出頁面資料) 的 HOW；不過 spider 會以 site 做為區分，而非 content 的型態? => 這是下面 `CrawlSpider` rules 給人的錯誤印象? 如何從 URL 就知道要用哪個 callback 做 parsing??
      - For spiders, the scraping CYCLE goes through something like this:
          - You start by generating the INITIAL `Request`s to crawl the first URLs, and specify a CALLBACK function to be called with the response downloaded from those requests. `Request` constructor 其中一個參數是 `callback` (callable)
          - In the callback function, you parse the response (web page) and return either DICTS WITH EXTRACTED DATA, `Item` objects, `Request` objects, or an ITERABLE of these objects. (通常搭配 `yield`，dict/item 往 item pipeline 去，而 request 則進排程繼續 follow) Those `Request`s will also contain a callback (maybe the same) and will then be downloaded by Scrapy and then their response handled by the specified callback.
          - In callback functions, you parse the page contents, typically using selectors (but you can also use BeautifulSoup, lxml or whatever mechanism you prefer) and generate items with the parsed data. 雖然這裡只提 HTML/XML，但概念上就是從 response 取出資料，而 response 可能是其他的型態。
          - Finally, the items returned from the spider will be typically persisted to a database (in some ITEM PIPELINE) or written to a file using FEED EXPORTS. 感覺 feed export 像是特化過的 item pipeline。

  - [scrapy.Spider - Spiders — Scrapy 1\.6\.0 documentation](https://docs.scrapy.org/en/1.6/topics/spiders.html#scrapy-spider) #ril

    `class scrapy.spiders.Spider`

      - This is the simplest spider, and the one from which EVERY OTHER SPIDER MUST INHERIT (including spiders that come bundled with Scrapy, as well as spiders that you write yourself).

        It doesn’t provide any special functionality. It just provides a default `start_requests()` implementation which sends requests from the `start_urls` spider attribute and calls the spider’s method `parse` for each of the resulting responses.

    `name`

      - A string which defines the name for this spider. The spider name is how the spider is located (and instantiated) by Scrapy, so it must be UNIQUE. However, nothing prevents you from instantiating more than one instance of the same spider. This is the most important spider attribute and it’s required.
      - If the spider scrapes a SINGLE DOMAIN, a common practice is to name the spider AFTER THE DOMAIN, with or without the TLD. So, for example, a spider that crawls `mywebsite.com` would often be called `mywebsite`.

    `allowed_domains`

      - An optional list of strings containing domains that this spider is allowed to crawl. Requests for URLs not belonging to the domain names specified in this list (or their subdomains) won’t be followed if `OffsiteMiddleware` is enabled.

        [`OffsiteMiddleware`](https://docs.scrapy.org/en/1.6/topics/spider-middleware.html#scrapy.spidermiddlewares.offsite.OffsiteMiddleware) -- Filters out `Request`s for URLs outside the domains covered by the spider. This middleware filters out every request whose host names aren’t in the spider’s `allowed_domains` attribute. 預設會啟用 ??

      - Let’s say your target url is `https://www.example.com/1.html`, then add `'example.com'` to the list.

    `start_urls`

      - A list of URLs where the spider will begin to crawl from, when NO PARTICULAR URLs ARE SPECIFIED ??. So, the first pages downloaded will be those listed here. The subsequent `Request` will be generated successively from data contained in the start URLs.

    ...

    `start_requests()`

      - This method must return an iterable with the first `Request`s to crawl for this spider. It is called by Scrapy when the spider is OPENED for scraping. Scrapy calls it ONLY ONCE, so it is SAFE to implement `start_requests()` as a GENERATOR.

        但為何寫成 generator 會卡住? [\[bug?\] while True in start\_requests\(self\): make scrapy is unable to consume the yields\. · Issue \#3259 · scrapy/scrapy](https://github.com/scrapy/scrapy/issues/3259)

        > when you yield a request, scrapy will put the request object into a SCHEDULE POOL, and the scheduler will do this request concurrently when there is ENOUGH REQUEST OBJECTS or SOME TINY TIME IS UP.

        因為 Scrapy 呼叫 `generator.next()`，一定要 yield 東西回去 (不能丟 `StopIteration`，否則就不會再來要了)，否則會卡在 while loop 裡；可以考慮丟出沒用的 `Request`，例如 `Request('http://', callback=do_nothing, errback=do_nothing)`。

      - The default implementation generates `Request(url, dont_filter=True)` for each url in `start_urls`.
      - If you want to change the `Request`s used to start scraping a domain, this is the method to override. For example, if you need to start by logging in using a POST request, you could do:

            class MySpider(scrapy.Spider):
                name = 'myspider'

                def start_requests(self):
                    return [scrapy.FormRequest("http://www.example.com/login",
                                               formdata={'user': 'john', 'pass': 'secret'},
                                               callback=self.logged_in)]

                def logged_in(self, response):
                    # here you would extract links to follow and return Requests for
                    # each of them, with another callback
                    pass`

      - [scrapy/\_\_init\_\_\.py at 1\.5\.1 · scrapy/scrapy](https://github.com/scrapy/scrapy/blob/1.5.1/scrapy/spiders/__init__.py#L69) 
      - `start_requests()` - This method must return an iterable with the first `Request`s to crawl for this spider. It is called by Scrapy when the spider is OPENED FOR SCRAPING. Scrapy calls it only once, so it is safe to implement `start_requests()` as a GENERATOR. [預設的實作](https://github.com/scrapy/scrapy/blob/1.5.1/scrapy/spiders/__init__.py#L69)是 `for url in self.start_urls: yield Request(url, dont_filter=True)` -- 都走 GET method；為什麼沒給 `callback` 卻知道要往 `Spider.parse` 去? => `Request` 是由 spider 吐出來的，可以自動將 `Request` 跟 `Spider.parse` 關聯起來也沒什麼好奇怪的。
      - `parse(response)` - This is the default callback used by Scrapy to process downloaded responses, when their requests don’t specify a callback. This method, as well as any other `Request` callback, must return an iterable of `Request` and/or dicts or `Item` objects.
      - `allowed_domains` - An optional list of strings containing domains that this spider is allowed to crawl. Requests for URLs not belonging to the domain names specified in this list (or their subdomains) won’t be followed if `OffsiteMiddleware` is enabled. 雖然 request 不帶 spider，系統還是可以把 request 與 spider 關聯起來，回頭來參考 spider 上的設定。

## Item ??

  - [Items — Scrapy 1\.5\.1 documentation](https://doc.scrapy.org/en/1.5/topics/items.html) #ril
      - The main goal in scraping is to EXTRACT STRUCTURED DATA FROM UNSTRUCTURED SOURCES, typically, web pages. Scrapy spiders can return the extracted data as Python dicts. While convenient and familiar, Python dicts lack structure: it is easy to make a typo in a field name or return inconsistent data, especially in a larger project with many spiders. 入門文件 Scrapy at a glance 就是用 Python dict，不太懂這問題跟 multiple spiders 有什麼關係??

## Item Pipeline ??

  - [Item Pipeline — Scrapy 1\.5\.1 documentation](https://doc.scrapy.org/en/1.5/topics/item-pipeline.html) #ril
      - After an item has been scraped by a spider, it is sent to the Item Pipeline which processes it through several COMPONENTs that are executed SEQUENTIALLY.
      - Each item pipeline component (sometimes referred as just “Item Pipeline”) is a Python class that implements a simple method. They receive an item and perform an action over it, also deciding if the item should continue through the pipeline or be dropped and no longer processed. 這聽起來有點怪，前一句 item pipeline 是指由許多 component，但這裡又說 component 也稱做 "item pipeline"，難怪 setting 是透過 `ITEM_PIPELINES` (複數)。
      - Typical uses of item pipelines are:
          - cleansing HTML data 包裝成 item 後應該就已去掉 HTML 了吧??
          - validating scraped data (checking that the items contain certain fields)
          - checking for duplicates (and dropping them) 丟出 `DropItem` exception。
          - storing the scraped item in a database 跟入門時用的 feed exports (`-o quotes.json`) 有什麼不同?? 因為下面也示範了 `JsonWriterPipeline`。

## Broad Crawl ??

  - [Broad Crawls — Scrapy 1\.5\.1 documentation](https://doc.scrapy.org/en/1.5/topics/broad-crawls.html) #ril
      - Scrapy defaults are optimized for crawling SPECIFIC SITES. These sites are often handled by a single Scrapy spider, although this is not necessary or required (for example, there are GENERIC SPIDERs that handle any given site thrown at them). In addition to this “FOCUSED CRAWL”, there is another common type of crawling which covers a large (potentially unlimited) number of domains, and is only limited by time or other arbitrary constraint, rather than stopping when the domain was crawled to completion or when there are no more requests to perform. These are called “BROAD CRAWLS” and is the typical crawlers employed by SEARCH ENGINES. 一個 spider 爬特定單個/數個網站的做法稱做 focused crawl，但 search engine 的做法通常是 broad crawl -- 一直往下爬，直到沒東西可爬為止 (可以限定大範圍)。
      - These are some common properties often found in broad crawls:
          - they crawl many domains (often, UNBOUNDED) instead of a specific set of sites
          - they don’t necessarily crawl domains to completion (爬完特定 domain 就結束?), because it would be impractical (or impossible) to do so, and instead limit the crawl by time or number of pages crawled
          - they are simpler in logic (as opposed to very complex spiders with many extraction rules) because data is often post-processed in a separate stage 乍看合理，但當下沒分析內容，要如何知道接下來往哪裡走?? 還是單純取所有的連結?
          - they crawl many domains concurrently, which allows them to achieve faster crawl speeds by not being limited by any particular site constraint (each site is crawled slowly to respect politeness, but many sites are crawled in parallel) 雖然 per domain/site 還是會限制，但不同 domain/site 可以同時爬，所以整體的速度可以很快；當然這要搭配解開 `CONCURRENT_REQUESTS` (預設 16) 的限制才行。
      - As said above, Scrapy DEFAULT SETTINGS are optimized for focused crawls, not broad crawls. However, due to its asynchronous architecture, Scrapy is VERY WELL SUITED for performing FAST BROAD CRAWLs. This page summarizes some things you need to keep in mind when using Scrapy for doing broad crawls, along with concrete suggestions of Scrapy settings to tune in order to achieve an EFFICIENT broad crawl. 所謂 Scrapy 針對 focused crawl 優化，指的是 default settings，並非 Scrapy 不適合 broad crawl，只是有些 settings 要解開限制，讓 Scrapy 得以施展開來。

  - [Increase concurrency - Broad Crawls — Scrapy 1\.5\.1 documentation](https://doc.scrapy.org/en/1.5/topics/broad-crawls.html#increase-concurrency) #ril

## Deployment ??

  - [Scrapy \| A Fast and Powerful Scraping and Web Crawling Framework](https://scrapy.org/)
      - Deploy them to Scrapy Cloud or use Scrapyd to host the spiders on your own server 由於 `shub` CLI 完全沒提到 Scrapyd，加上 Scrapyd 文件建議用 `scrapyd-client`，猜想 Scrapy Cloud 背後並不是用 Scrapyd。
      - 範例用 `shub deploy` 將 spider 佈署到 Scrapy Cloud，並用 `shub schedule xxx` 排程；其中 [`shub`](https://pypi.org/project/shub/) 是 Scrapinghub 的 CLI。
  - [Scrapy Cloud](https://scrapinghub.com/scrapy-cloud) 是 Scrapinghub 的一個元件 #ril
  - [Deploying your project — Scrapyd 1\.2\.0 documentation](https://scrapyd.readthedocs.io/en/latest/deploy.html) 產生 egg 並上傳到 Scrapyd 的 `addversion.json` endpoint，建議透過 `scrapyd-client` 來做。
  - [Deploying Spiders — Scrapy 1\.5\.0 documentation](https://doc.scrapy.org/en/1.5/topics/deploy.html) #ril
  - [Common Practices — Scrapy 1\.5\.0 documentation](https://doc.scrapy.org/en/1.5/topics/practices.html) #ril

## 安裝設置 {: #setup }

  - [Installation guide — Scrapy 1\.5\.1 documentation](https://docs.scrapy.org/en/latest/intro/install.html)
      - 需要 CPython 2.7+ / 3.4+ 或 PyPy 5.9+
      - 用 Pip 安裝 `scrapy` 套件即可；建議裝在 virtualenv 裡。
      - 雖然 Scrapy 本身用 Python 寫，但有些相依的套件用到 non-Python package，所以一開始才會提到用 Anaconda/Miniconda 安裝的選項。

### Docker ??

以 Python 3.7.0 為基礎：

`Dockerfile`:

```
FROM python:3.7.0

pip install scrapy==1.5.1
```

```
$ docker build -t scrapy.local
$ docker run --rm -it local.scrapy python -c 'import scrapy; print(scrapy.__version__)'
1.5.1
```

參考資料：

  - [aciobanu/scrapy \- Docker Hub](https://hub.docker.com/r/aciobanu/scrapy/) #ril

## 參考資料 {: #reference }

  - [Scrapy](https://scrapy.org/)
  - [scrapy/scrapy - GitHub](https://github.com/scrapy/scrapy)
  - [Scrapy - PyPI](https://pypi.org/project/Scrapy/)

社群：

  - [Scrapy (@ScrapyProject) | Twitter](https://twitter.com/ScrapyProject)
  - ['scrapy' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/scrapy)

書籍：

  - [Website Scraping with Python - Using BeautifulSoup and Scrapy - Apress](https://www.apress.com/gp/book/9781484239247) (2018-11)
  - [Web Scraping with Python, 2nd Edition - O'Reilly](http://shop.oreilly.com/product/0636920078067.do) (2018-04)
  - [Python Web Scraping, 2nd Edition - Packt](https://www.packtpub.com/big-data-and-business-intelligence/python-web-scraping-second-edition) (2017-05)
  - [Learning Scrapy - Packt](https://www.packtpub.com/big-data-and-business-intelligence/learning-scrapy) (2016-01)
  - [Web Scraping with Python - Packt](https://www.packtpub.com/big-data-and-business-intelligence/web-scraping-python) (2015-10)

更多：

  - [Testing](scrapy-testing.md)

手冊：

  - [Scrapy Documentation](https://docs.scrapy.org/en/latest/)
  - [Built-in Selectors reference - Scrapy Documentation](https://doc.scrapy.org/en/1.5/topics/selectors.html#topics-selectors-ref)
  - [Command line tool - Scrapy Documentation](https://doc.scrapy.org/en/1.5/topics/commands.html)
  - [Class `scrapy.spiders.Spider`](https://docs.scrapy.org/en/latest/topics/spiders.html#scrapy.spiders.Spider)
  - [Class `scrapy.item.Item`](https://docs.scrapy.org/en/latest/topics/items.html#scrapy.item.Item)
  - [Class `scrapy.http.Request`](https://docs.scrapy.org/en/latest/topics/request-response.html#scrapy.http.Request)
  - [Class `scrapy.http.Response`](https://docs.scrapy.org/en/latest/topics/request-response.html#scrapy.http.Response)
