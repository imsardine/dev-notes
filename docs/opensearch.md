# OpenSearch

  - [OpenSearch \- Wikipedia](https://en.wikipedia.org/wiki/OpenSearch) #ril

## 新手上路 ?? {: #getting-started }

  - [OpenSearch description format \| MDN](https://developer.mozilla.org/en-US/docs/Web/OpenSearch) #ril
      - The OpenSearch description format lets a website describe a search engine FOR ITSELF, so that a browser or other client application can use that search engine. OpenSearch is supported by (at least) Firefox, Edge, Internet Explorer, Safari, and Chrome. 使用者會如何被提示有 search engine 可以安裝?
      - Firefox also supports additional features not in the OpenSearch standard, such as search suggestions and the `<SearchForm>` element. This article focuses on creating OpenSearch-compatible search PLUGINs that support these additional Firefox features. 為什麼是 plugin?? 如何通用於各 browser?
      - OpenSearch DESCRIPTION FILES can be ADVERTISED as described in Autodiscovery of search plugins, and can be installed programmatically as described in Adding search engines from web pages. 只有 Firefox 支援用 JavaScript 要求權限安裝 search engine plugin，但通用的方法是提供 description file 讓 browser 知道，有各自的實作讓使用者方便安裝。

  - [Opensearch \| Building Search UI Guide \| Algolia Documentation](https://www.algolia.com/doc/guides/building-search-ui/resources/ui-and-ux-patterns/in-depth/opensearch/js/) 提到 URL synchronization 的概念 (2018-12-20) #ril
  - [How to let Google power OpenSearch on your website • Aaron Parecki](https://aaronparecki.com/2011/07/11/3/how-to-let-google-power-opensearch-on-your-website) (2011-07-11) #ril

## Description File ??

  - [OpenSearch description file - OpenSearch description format \| MDN](https://developer.mozilla.org/en-US/docs/Web/OpenSearch#OpenSearch_description_file) #ril
      - The XML file that describes a search engine follows the basic template below. Sections in [square brackets] should be customized for the specific plugin you're writing.

            <OpenSearchDescription xmlns="http://a9.com/-/spec/opensearch/1.1/"
                                   xmlns:moz="http://www.mozilla.org/2006/browser/search/"> <-- moz namespace 用在 <SearchForm>
              <ShortName>[SNK]</ShortName>
              <Description>[Search engine full name and summary]</Description>
              <InputEncoding>[UTF-8]</InputEncoding>
              <Image width="16" height="16" type="image/x-icon">[https://example.com/favicon.ico]</Image>
              <Url type="text/html" template="[searchURL]">
                <Param name="[key name]" value="{searchTerms}"/>
                <!-- other Params if you need them… -->
                <Param name="[other key name]" value="[parameter value]"/>
              </Url>
              <Url type="application/x-suggestions+json" template="[suggestionURL]"/> <-- 以下是 Firefox 特有的
              <moz:SearchForm>[https://example.com/search]</moz:SearchForm>
            </OpenSearchDescription>

      - `ShortName` - A short name for the search engine. It must be 16 or fewer characters of plain text, with no HTML or other markup.
      - `Description` - A brief description of the search engine. It must be 1024 or fewer characters of plain text, with no HTML or other markup.
      - `InputEncoding` - The character encoding to use when submitting input to the search engine.
      - `Image` - URI of an icon for the search engine. When possible, include a 16×16 image of type `image/x-icon` (such as `/favicon.ico`) and a 64×64 image of type `image/jpeg` or `image/png`. The URI may also use the `data:` URI scheme. 可以多個??

            <Image height="16" width="16" type="image/x-icon">https://example.com/favicon.ico</Image>
              <!-- or -->
            <Image height="16" width="16">data:image/x-icon;base64,AAABAAEAEBAAA … DAAA=</Image>

      - `Url` - Describes the URL or URLs to use for the search. The `template` attribute indicates the base URL for the search query.

        Firefox supports three URL types: (後 2 個 URL type 其他 browser 都不支援)

          - `type="text/html"` - specifies the URL for the actual search query.
          - `type="application/x-suggestions+json"` specifies the URL for fetching search suggestions. In Firefox 63 onwards, `type="application/json"` is accepted as an alias of this.
          - `type="application/x-moz-keywordsearch"` specifies the URL used when a keyword search is entered in the LOCATION BAR. This is supported only in Firefox.

        For these URL types, you can use `{searchTerms}` to substitute the search terms entered by the user in the search bar or location bar. Other supported DYNAMIC search parameters are described in OpenSearch 1.1 parameters. 其中 location bar 跟 search bar 有什麼不同?? Chrome 並沒有像 Firefox 這樣區分

      - `Param` - The parameters that must be passed in along with the search query as key/value pairs. When specifying values, you can use `{searchTerms}` to insert the search terms entered by the user in the search bar.

      - `moz:SearchForm` - The URL for the site's search page for which the plugin. This lets Firefox users visit the web site directly.

        Since this element is Firefox-specific, and not part of the OpenSearch specification, we use the `moz:` XML namespace prefix in the example above to ensure that other user agents that don't support this element can SAFELY IGNORE IT.

## 參考資料

  - [OpenSearch.org](http://www.opensearch.org/Home)
  - [dewitt/opensearch - GitHub](https://github.com/dewitt/opensearch)

社群：

  - ['opensearch' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/opensearch)

手冊：

  - [OpenSearch 1.1 Draft 6](https://github.com/dewitt/opensearch/blob/master/opensearch-1-1-draft-6.md)