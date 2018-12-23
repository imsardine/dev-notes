# MkDocs

  - 跟 Hexo 不同，MkDocs 只能寫 pages，跟 Hexo 以 blog posts 為主 (pages 為輔) 的應用不同。

參考資料：

  - [Automate publishing to PyPI with pbr and Travis \- Dougal Matthews](http://www.dougalmatthews.com/2016/Sep/01/automate-publishing-to-pypi-with-pbr-and-travis/) (2016-09-01) 提到 `retrace` 用 MkDocs 來產生文件 -- 就是 [retrace 的官網](http://d0ugal.github.io/retrace/)，採用 Materials theme (Google 風)。
  - [MkDocs](https://www.mkdocs.org/) MkDocs is a fast, simple and downright gorgeous static site generator that's geared towards building PROJECT DOCUMENTATION. 專用於 project 網站，再適合不過 GitHub Pages 之類的應用。
  - [Dougal Matthews \- MkDocs: Documenting projects with Markdown \- YouTube](https://youtu.be/pzoOQg6BNG4?t=25) 00:25 作者唸做 "m-k-ducks"

## 應用實例 {: #powered-by }

  - [python\-fire/mkdocs\.yml at master · google/python\-fire](https://github.com/google/python-fire/blob/master/mkdocs.yml) => [Using a CLI \- Python Fire](https://google.github.io/python-fire/using-cli/)
  - [pinax/mkdocs\.yml at master · pinax/pinax](https://github.com/pinax/pinax/blob/master/mkdocs.yml) => [Pinax Moves from Sphinx to MkDocs \| The Pinax Project Blog](http://blog.pinaxproject.com/2015/10/19/pinax-moves-sphinx-mkdocs/) (2015-10-19) 從 Sphinx 遷移到 MkDocs，因為寫了許多年的 reStructuredText，還是很常需要查詢語法；[Pinax](http://pinaxproject.com/) 在 Django 上發展出許多 starter projects。
  - [markdown/mkdocs\.yml at master · Python\-Markdown/markdown](https://github.com/Python-Markdown/markdown/blob/master/mkdocs.yml)
  - [Swap out Sphinx for mkdocs · Issue \#7 · drivendata/cookiecutter\-data\-science](https://github.com/drivendata/cookiecutter-data-science/issues/7) #ril
  - [nodemcu\-firmware/mkdocs\.yml at master · nodemcu/nodemcu\-firmware](https://github.com/nodemcu/nodemcu-firmware/blob/master/mkdocs.yml)
  - [Search · filename:mkdocs\.yml](https://github.com/search?q=filename%3Amkdocs.yml) 更多 ...

## Hello, World!

```
$ mkdocs new helloworld
INFO    -  Creating project directory: helloworld
INFO    -  Writing config file: helloworld/mkdocs.yml
INFO    -  Writing initial docs: helloworld/docs/index.md

$ cd helloworld
$ mkdocs serve
INFO    -  Building documentation...
INFO    -  Cleaning site directory
[I 180831 04:52:38 server:292] Serving on http://127.0.0.1:8000
[I 180831 04:52:38 handlers:59] Start watching changes
[I 180831 04:52:38 handlers:61] Start detecting changes

$ open http://localhost:8000
$ vi mkdocs.yml
site_name: Hello, World!
```

## 新手上路 ?? {: #getting-started }

  - [Getting Started - MkDocs](https://www.mkdocs.org/#getting-started)
      - `mkdocs new my-project` 會產生 `my-project/`，底下有 `mkdocs.yml` 及 `docs/index.md` -- 其中 `mkdocs.yml` 是 configuration file，而 `docs/` 則是放置 documentation source files 的地方。
      - 內建 dev-server，在 `mkdocs.yml` 的目錄執行 `mkdocs serve` 即可，就可以從 http://127.0.0.1:8000 看到內容
      - 從 `Start watching/detecting changes` 的訊息看來，預設就有 auto-reloading 的功能 -- 當 configuration file (`mkdocs.yml`)、documentation directory (`docs/`) 或 theme directory 有異動時就會自動 rebuild，而且 browser 也會 auto-reload。
      - 透過 `pages:` 可以列舉 navigation header 的項目，例如 `- Home: index.md`、`Aboud: about.md`；雖然還是有效，但這在 configuration 的手冊裡已經找不到，原來在 [Version 1.0 (2018-08-03)](https://www.mkdocs.org/about/release-notes/#version-10-2018-08-03) 被 `nav:` 取代。

## File Layout

  - [File Layout - Writing Your Docs \- MkDocs](https://www.mkdocs.org/user-guide/writing-your-docs/#file-layout)
      - Documentation source (Markdown files) 必須放在 documentation directory (`docs_dir`) 下，預設是 `docs/` (跟 `mkdocs.yml` 同一層)；實驗發現，試圖設定 `docs_dir: .` 會出錯，也就是 `mkdocs.yml` 跟 `.md` 不能在同一個目錄。
      - Markdown source files 的副檔名是 `.md` (或 `.markdown`、`.mdown`、`.mkdn`、`.mkd`)，只要是在 `docs_dir` 下的 Markdown source file 都會被 render，不管設定為何；這間接說明了，文件不一定要列入 `nav` configuration。通常 project homepage 的主檔名是 `index` (也可以是 `README`)。
      - The file layout you use determines the URLs that are used for the generated pages. You can also include your Markdown files in NESTED DIRECTORIES if that better suits your documentation layout. `docs/license.md` 對應 URL `/license/` (背後是 `site/license/index.html`)，而 `user-guide/getting-started.md` 則對應 URL `/user-guide/getting-started/` (背後是 `site/user-guide/getting-started/index.html`)；這一點很適合拿來做筆記，因為單篇 `xxx.md` 未來都可以往下展開細節。
  - [Index pages - Writing Your Docs \- MkDocs](https://www.mkdocs.org/user-guide/writing-your-docs/#index-pages)
      - When a directory is requested, by default, most web servers will return an index file (usually named `index.html`) contained within that directory if one exists. 因些上面的 homepage 才會取名 `index.md` -- 產生 `index.html`；不過有些 repository hosting 會顯示 `README` file，所以 MkDocs 也接受 `README.md` 做為 homepage -- 也會產生 `index.html`。
      - 如果同時存在 `index.md` 與 `README.md`，則 MkDocs 會優先採用 `index.md`。

## Navigation

原來 navigation 打破階層後，page 之間還是有順序的，使用者可以依序看，也可以跳著看，但都在安排好的脈絡上，這一點還滿特別的。以內建的兩個 theme 而言，套上 `mkdocs` 看起像個網站，但套上 `readthedocs` 後，看起來又像本書了。

參考資料：

  - [Configure Pages and Navigation - Writing Your Docs \- MkDocs](https://www.mkdocs.org/user-guide/writing-your-docs/#configure-pages-and-navigation)
      - `nav` configuration 定義了哪些 page 會出現在 global site navigation menu 以及 menu 本身的結構；如果沒有設定 `nav`，預設會找出 `docs_dir` 下所有的 Markdown files，並按照檔名的字母順序排列 (當然 index file 會被排在第一個位置)，可想而知，這通常都不會是你想要的。
      - `nav` configuration 有兩種寫法 -- `- 'index.md'` 或 `- Home: 'index.md'` (路徑總是相對於 `docs_dir`)，後者會採用 `Home` 做為 title，前者則會從檔案內容取得 title；不過若是後者的表示法自訂 title 後，檔案內容的 title 也會被覆寫，聽起來不太妙 XD
      - Navigation sub-sections，可以將相關的 page 列在一個 section title 下，例如 `- User Guide:`，但本身不能指向 page -- sections are only containers for child pages and sub-sections。雖然階層數沒有限制，但別讓使用者迷失了。
      - Any pages not listed in your navigation configuration will still be rendered and included with the built site, however, they will not be linked from the global navigation and will not be included in the PREVIOUS AND NEXT LINKS. 這一點比 GitBook 好多了。
  - 實驗發現沒列在 `nav:` 裡的 `.md` 也會被解析，在 dev-server 的 log 會看到類 `INFO    -  The following pages exist in the docs directory, but are not included in the "nav" configuration: ...` 的訊息，在 Search 裡也找得到。

## Writing ??

  - [Writing Your Docs \- MkDocs](https://www.mkdocs.org/user-guide/writing-your-docs/) #ril

## Markdown ??

  - [markdown_extensions - Configuration \- MkDocs](https://www.mkdocs.org/user-guide/configuration/#markdown_extensions) #ril
      - MkDocs 是用 Python-Markdown 將 Markdown 轉成 HTML，而 Python-Markdown 支援許多 extension 用來自訂 "how pages are formatted"，`markdown_extensions` 就是用來啟用額外的 extension。MkDocs 預設會啟用 `meta`、`toc`、`tables`、`fenced_code`；根據 [source code](https://github.com/mkdocs/mkdocs/blob/1.0.4/mkdocs/config/defaults.py#L89) 看來，預設並沒有 `meta`。
      - 從範例 `- toc: permalink: True` 看來，`markdown_extension` 不只可以用來啟用其他 extension，也可以用來設定預設會被啟用的 extension。

        markdown_extensions:
            - smarty
            - toc:
                permalink: True
            - sane_lists

  - [Incorrect rendering of nested lists · Issue \#545 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/issues/545) #ril
      - d0uga: (member) 因為上遊 Python-Markdown 要求 2nd level list 要內縮 4 格，不認為這是個 bug。
      - waylan: 建議 rufuspollock 應該把時間花在 making well-formed Markdown documents ...
      - rufuspollock: 手邊有很多文件都是內縮 2 格 (很多都是別人提供的)，`markdown.pl` 也沒這麼做，而且 CommonMark 看似也允許 2 個空格。
  - [Nested lists require 4 spaces of indent · Issue \#3 · Python\-Markdown/markdown](https://github.com/Python-Markdown/markdown/issues/3)
      - 結論是不修，但後來 radude 發表了一個 Python-Markdown extension；如何讓 MkDocs 套用? => 在 `markdown_extension` 加上 `mdx_truly_sane_lists` 即可。
  - [Indented code block not transformed · Issue \#282 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/issues/282) #ril
      - jsaintro: MkDocs 的 backticks 只能用在 non-indented code block，但 1st level list 可以搭配內縮 8 格，2st level list 內縮 12 格，依此類推。

## Title ??

  - Meta data 裡可以定義 `title:`，否則就會抓取 heading 1。

## Image ??

  - [Linking to images and media - Writing Your Docs \- MkDocs](https://www.mkdocs.org/user-guide/writing-your-docs/#linking-to-images-and-media) #ril

## Custom CSS ??

  - [Customizing a Theme - Styling Your Docs \- MkDocs](https://www.mkdocs.org/user-guide/styling-your-docs/#customizing-a-theme) #ril
      - MkDocs includes a couple built-in themes as well as various third party themes, all of which can easily be customized with extra CSS or JavaScript or overridden from the theme's `custom_dir`. 可以在 theme 上面再疊加一層自訂；不過還有比 `custom_dir` 更簡單的做法 -- `extra_css`/`extra_docs` (搭配 `docs_dir` 使用)。
      - If you would like to make a few tweaks to an existing theme, there is no need to create your own theme from scratch. For minor tweaks which only require some CSS and/or JavaScript, you can use the `docs_dir`. However, for more complex customizations, including overriding templates, you will need to use the theme `custom_dir` setting. 簡單的透過 `docs_dir`，複雜的再用 `custom_dir`。
  - [Build directories - Configuration \- MkDocs](https://www.mkdocs.org/user-guide/configuration/#build-directories) #ril
  - [MkDocs Recipes · mkdocs/mkdocs Wiki](https://github.com/mkdocs/mkdocs/wiki/MkDocs-Recipes) 一些 recipes 跟 custom CSS 有關 #ril

## Theme ??

  - 文件內容的 HTML 是由 Python-Markdown (及啟用的 extensions) 產生，所以 theme 只是針對 Markdown 會產生的 HTML 先設計好 stylesheets 而已，並無法改變它的結構??

推薦的 theme 有：

  - [Cinder](mkdocs-cinder.md)
  - [Material](mkdocs-material.md)

參考資料：

  - [mkdocs/build\.py at 1\.0\.4 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/blob/1.0.4/mkdocs/commands/build.py#L274) `_populate_page(file.page, config, files, dirty)` 內部會呼叫 Python Markdown 產生本文的 HTML (`page.content`) 及 TOC (`page.toc`)，之後 `_build_page(file.page, config, files, nav, env, dirty)` 會寫出檔案。
  - [MkDocs](https://www.mkdocs.org/) Great themes available: 除了內建的 `mkdocs` 與 `readthedocs`，還有許多 3rd-party themes，當然也可以自己做。
  - [Theming our documentation - MkDocs](https://www.mkdocs.org/#theming-our-documentation) 在 `mkdocs.yml` 加上 `theme: readthedocs`，神奇的事發生了!! 不要重啟 server，整個變成 Read the Docs 風 ~
  - [Styling Your Docs \- MkDocs](https://www.mkdocs.org/user-guide/styling-your-docs/) #ril
  - [Custom Themes \- MkDocs](https://www.mkdocs.org/user-guide/custom-themes/) #ril
  - [MkDocs Themes · mkdocs/mkdocs Wiki](https://github.com/mkdocs/mkdocs/wiki/MkDocs-Themes) #ril
  - [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) 很專業的感覺!! #ril
  - [MkDocs Bootswatch Themes](http://mkdocs.github.io/mkdocs-bootswatch/) 文件的 TOC 在左側 (只到 L2?)，就沒有所有文件的導覽；適用數量很多的筆記。
  - [Lucas Ramage / mkdocs\-bootstrap386 · GitLab](https://gitlab.com/lramage94/mkdocs-bootstrap386) 模擬 console 的感覺，但 TOC 只到 L2。
  - [Search results · PyPI](https://pypi.org/search/?q=mkdocs+theme) ... 更多

## TOC ??

  - [Internal links - Writing Your Docs \- MkDocs](https://www.mkdocs.org/user-guide/writing-your-docs/#internal-links) 提到 `toc` extension #ril
  - [Anchor Linking with Heading Sections · Issue \#744 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/issues/744) 搭配 `attr_list` extension 可以自訂 ID；這對中文 header 尤其重要，例如 `## 新手上路 {: #getting-started }`
      - waylan: (member) if you have the `permalink` option of the `toc` extension enabled, then every header will be assigned an `id`. For example, the following header: `# A Header` Will produce the following HTML: `<h1 id="a-header">A Header</h1>`. Note that the `id` is assigned the SLUG: `a-header`.
      - waylan: if you enable the `attr-list` extension, that will allow you to define custom ids for your headers. Those ids will then be used rather than the auto-generated ones. [Attribute Lists — Python\-Markdown 3\.0\.1 documentation](https://python-markdown.github.io/extensions/attr_list/) 提到 `### A hash style header ### {: #hash }` 會產生 `<h3 id="hash">A hash style header</h3>`，因為 A word which starts with a hash (`#`) will set the id of an element.
  - 預設就會有 TOC，如何在特定頁面關閉??

## Meta Data - Author(s), Date ??

  - [Meta-Data - Writing Your Docs \- MkDocs](https://www.mkdocs.org/user-guide/writing-your-docs/#meta-data) #ril
  - [YAML Style Meta-Data - Writing Your Docs \- MkDocs](https://www.mkdocs.org/user-guide/writing-your-docs/#yaml-style-meta-data) 範例提到 `author:` (list) 與 `date:`，但試過 `theme`、`readthedocs` 及 `material` 都不會顯示這兩項資訊??

## Tagging ??

  - [tag and category support? · Issue \#1411 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/issues/1411) 靠 meta data，但好像沒有 plugin? #ril
  - [Tagging support · Issue \#759 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/issues/759) 未來可以透過 plugin 提供。

## Dev-Server ??

  - [Preview your site as you work - MkDocs](https://www.mkdocs.org/#preview-your-site-as-you-work) 內建 dev-server 可以預覽文件，甚至存檔時 browser 會自動 reload!

## Configuration (mkdocs.yml) ??

  - [Getting Started - MkDocs](https://www.mkdocs.org/#getting-started) `mkdocs.yml` 是 configuration file，示範 `site_name` 可以改變網站的名稱。
  - [Project Information - Configuration \- MkDocs](https://www.mkdocs.org/user-guide/configuration/#project-information) #ril
      - 全部的組態都集中在 project directory 的 `mkdocs.yml`，裡面除了 `site_name` 之外，其他都是非必要的。
      - `site_name` - 做為 main title
      - `site_url` - 設定 canonical URL。This will add a LINK TAG with the canonical URL to the generated HTML header. 例如 `<link rel="canonical" href="https://imsardine.github.io/dev-notes/markdown/">`。實驗確認可以帶 path，例如 `https://imsardine.github.io/dev-notes`，產生的文件其間都用相對路徑串聯，所以不會有問題。
      - `repo_url` - 提供 repository (GitHub、Bitbucket、GitLab 等) 的連結，例如 `https://github.com/example/repository/`；試過 Material theme，會根據 URL 顯示 GitHub、GitLab 不同的圖示。
  - [Documentation Layout - Configuration \- MkDocs](https://www.mkdocs.org/user-guide/configuration/#documentation-layout) #ril
  - [Build Directories - Configuration \- MkDocs](https://www.mkdocs.org/user-guide/configuration/#build-directories) #ril
  - [Preview Controls - Configuration \- MkDocs](https://www.mkdocs.org/user-guide/configuration/#preview-controls) #ril
  - [Formatting Options - Configuration \- MkDocs](https://www.mkdocs.org/user-guide/configuration/#formatting-options) #ril

## `mkdocs` CLI ??

  - [Other Commands and Options - MkDocs](https://www.mkdocs.org/#other-commands-and-options) `mkdocs --help` 或 `mkdocs <command> --help`。

## Search ??

## Favicon ??

  - [Changing the Favicon Icon - MkDocs](https://www.mkdocs.org/#changing-the-favicon-icon) Markdown 預設採用同 MkDocs 官網的 favicon (黑色的筆記本)，將自訂的圖放在 `docs/img/favicon.ico`，MkDocs 就會自動偵測到並採用它。

## Build ??

  - [Building the site - MkDocs](https://www.mkdocs.org/#building-the-site) #ril
      - `mkdocs build` 會在 `site/` 輸出 HTML；注意 `docs/index.md` 與 `docs/about.md` 會分別被輸出成 `site/index.html` 與 `site/about/index.html`，其他 media 也被複製進 `site/`。
      - 還有 `sitemap.xml`、`mkdocs/search_index.json`? MkDocs 1.0.3 實際的輸出是 `sitemap.xml` (外加 `sitemap.xml.gz`)、`search/search_index.json`，另外還有 `404.html`
      - 加 `--clean` 才會清理 `site/` 多出來的東西? 不過為什麼不加 `--clean` 前，`mkdocs build` 就會看到 `INFO    -  Cleaning site directory` 的 log??
  - [Version 1.0 (2018-08-03) - Release Notes \- MkDocs](https://www.mkdocs.org/about/release-notes/#version-10-2018-08-03) Support for hidden pages. All Markdown pages are now included in the build regardless of whether they are included in the navigation configuration (#699).
  - [Building hidden pages · Issue \#699 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/issues/699) (2015-07-27) #ril
  - [Build pages without adding them to sidebar? · Issue \#230 · JuliaDocs/Documenter\.jl](https://github.com/JuliaDocs/Documenter.jl/issues/230) (2016-08-23)
      - tlnagy: 有沒有可能限制 content tree 的深度，會讓 sidebar 變得很長，但有些 page 又不那麼重要 (要列在 sidebar 裡)。
      - MichaelHatherly: (member) 或許 navmenu 可以預設合起來? 又或者像 GitBook 一樣把 navmenu 安排在分開的 frame 裡。
      - mortenpi: (member) We could introduce the system that all .md files get built, even if they're not in the navmenu 過去有個決定會略過不在 `pages` 裡的檔案，但這做法可以討論。
      - tlnagy: 實務上會安排 "link to all the pages" 的頁面，猜想大部份的人不會在意多點一下，而且這樣會讓 navbar 不那麼雜亂。
      - MichaelHatherly: (member) Yes, that approach looks good — just keep the "MAIN" TOPICS easily reachable from the navmenu and have the others reachable through IN-PAGE CONTENTS seems like a good compromise to me. 開發團隊接受了 tlnagy 的提議，而這正是 GitBook 的缺點。
      - mortenpi: (member) what about pages that are completely disconnected (i.e. no links to them) -- should we try to find them and warn the user?
      - 後續的討論都沒有看到 MkDocs 有上述的修改，這才發現這個 issue 屬於 JUliaDocs，看似受到 MkDocs 的影響很深，中間一度提到 "decided to be consistent with MkDocs"

## Sitemap ??

  - [Project Information - Configuration \- MkDocs](https://www.mkdocs.org/user-guide/configuration/#project-information) 發現 `site_url` 也用在產生 `build/sitemap.xml`，否則裡面的 `<loc>` 的內容會是 `None` (1.0.4)；顯然 "As a minimum this configuration file must contain the site_name setting." 這句話是有問題的，因為 sitemap 預設就會產生。
  - [Release Notes \- MkDocs](https://www.mkdocs.org/about/release-notes/)
      - Version 1.0 (2018-08-03) - Compress sitemap.xml (#1130).
      - Version 0.17.4 (2018-06-08) - Bugfix: Add multi-level nesting support to sitemap.xml (#1482).
      - Version 0.13.0 (2015-05-26) - Generate sitemaps for documentation builds. (#436)
  - MkDocs 開始有 "Support for hidden pages"，但 sitemap 卻沒有考慮到 hidden pages (1.0.4) ??
      - [mkdocs/build\.py at master · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/blob/master/mkdocs/commands/build.py#L123) `if template_name == 'sitemap.xml':` 看來是 `def _build_theme_template(template_name, env, files, config, nav):` 的 `files` 一開始就少了 hidden files?
      - [mkdocs/sitemap\.xml at 1\.0\.4 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/blob/1.0.4/mkdocs/templates/sitemap.xml) 原來 `templates/sitemap.xml` 就只會遶 `nav` 而非 `files`，可能是為了要與 navigation menu 階層對應的關係?
  - Sitemap 裡的 `<lastmod>` 是如何決定的 => 1.0.4 採用 `SOURCE_DATE_EPOCH` 或系統時間
      - [mkdocs/sitemap\.xml at 1\.0\.4 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/blob/1.0.4/mkdocs/templates/sitemap.xml#L9) `{% if item.update_date %}<lastmod>{{item.update_date}}</lastmod>{% endif %}`
      - [mkdocs/pages\.py at 1\.0\.4 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/blob/1.0.4/mkdocs/structure/pages.py#L39) 由 `SOURCE_DATE_EPOCH` 決定，或是取當下系統時間；也就是重新產生就更新，或許可以把最後一個 commit 的時間寫進 `SOURCE_DATE_EPOCH`，就能達成 reproducible build 的效果?

            # Support SOURCE_DATE_EPOCH environment variable for "reproducible" builds.
            # See https://reproducible-builds.org/specs/source-date-epoch/
            if 'SOURCE_DATE_EPOCH' in os.environ:
                self.update_date = datetime.datetime.utcfromtimestamp(
                    int(os.environ['SOURCE_DATE_EPOCH'])
                ).strftime("%Y-%m-%d")
            else:
                self.update_date = datetime.datetime.now().strftime("%Y-%m-%d")

## Deployment ??

  - [MkDocs](https://www.mkdocs.org/#deploying) 把 `site/` 的內容上傳，這裡提到 GitHub project pages、Amazon S3。

## Syntax Highlighting ??

  - 拿 `mkdocs new .` 產生的 `docs/index.md` 來測試，先改寫裡面只有 code block，再觀察搭配不同設定所產生的 HTML。

        # Welcome to MkDocs

            from __future__ import print_function
            print("Hello, World!") # Python 2-3 compatible code

    在沒有自訂其他 extension 的情況下，產生的 HTML source 為：

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/github.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script>
        <script>hljs.initHighlightingOnLoad();</script>

        <pre><code>from __future__ import print_function
        print("Hello, World!") # Python 2-3 compatible code
        </code></pre>

    DOM 會被加工成：(針對 `<code>`)

        <pre><code class="hljs coffeescript"><span class="hljs-keyword">from</span> __future__ <span class="hljs-keyword">import</span> print_function
        <span class="hljs-built_in">print</span>(<span class="hljs-string">"Hello, World!"</span>) <span class="hljs-comment"># Python 2-3 compatible code</span>
        </code></pre>

    由 `class="hljs coffeescript"` 看來，highlight.js 判斷失準。改寫成 fenced code block 並提示 language：

        ```python
        from __future__ import print_function
        print("Hello, World!") # Python 2-3 compatible code
        ```

    HTML source 帶有 `python` 的提示：

        <pre><code class="python">from __future__ import print_function
        print(&quot;Hello, World!&quot;) # Python 2-3 compatible code
        </code></pre>

    DOM 會被加工成：

        <pre><code class="python hljs"><span class="hljs-keyword">from</span> __future__ <span class="hljs-keyword">import</span> print_function
        print(<span class="hljs-string">"Hello, World!"</span>) <span class="hljs-comment"># Python 2-3 compatible code</span>
        </code></pre>

    但 indented code block 如何提示 langage??

  - 重複上面的實驗 (回到 indented code block)，試試加入 `codehilite` markdown extension 後，會起什麼變化? HTML source 變成：

        <pre class="codehilite"><code>from __future__ import print_function
        print(&quot;Hello, World!&quot;) # Python 2-3 compatible code</code></pre>

    從 `<pre class="codehilite">` 看到 `codehilite` extension 開始作用。由於這時候 highlight.js 的程式都還在，所以 DOM 還是會被加工：

        <pre class="codehilite"><code class="hljs coffeescript"><span class="hljs-keyword">from</span> __future__ <span class="hljs-keyword">import</span> print_function
        <span class="hljs-built_in">print</span>(<span class="hljs-string">"Hello, World!"</span>) <span class="hljs-comment"># Python 2-3 compatible code</span></code></pre>

    事實上，因為還沒裝 Pygments 套件的關係，所以 `codehilite` extension 等同沒有效果 (`use_pygments: false`)。安裝 Pygments 套件後，HTML source 變成：

        <div class="codehilite"><pre><span></span><span class="kn">from</span> <span class="nn">__future__</span> <span class="kn">import</span> <span class="n">print_function</span>
        <span class="k">print</span><span class="p">(</span><span class="s2">&quot;Hello, World!&quot;</span><span class="p">)</span> <span class="c1"># Python 2-3 compatible code</span>
        </pre></div>

    很明顯地 `<pre class="codehilite">` 變成 `<div class="codehilite">`，而且 `<pre>` 底下沒有 `<code>` 了，也之所以雖然 highlight.js 的程式都還在，但 DOM 不會被加工，但為何 `class="kn"`、`class="nn"` 等都沒有效果？

    但因為沒有 Pygments CSS 的關係，不會有 highlighting 的效果。按照 [CodeHilite — Python\-Markdown 3\.0\.1 documentation](https://python-markdown.github.io/extensions/code_hilite/#step-2-add-css-classes) 的說法：

    > You will need to define the appropriate CSS classes with appropriate rules. The CSS rules either need to be defined in or linked from the header of your HTML templates. Pygments can generate CSS rules for you. Just run the following command from the command line:
    >
    > `pygmentize -S default -f html -a .codehilite > styles.css`

    也就是 Pygments 的 CSS 要自己安排：

        pygmentize -S default -f html -a .codehilite > docs/pygments.css

    然後在 `mkdocs.yml` 增加 `extra_css: ["pygments.css"]`，就可以看到 highlighting 的效果：

        <link href="pygments.css" rel="stylesheet">

        <div class="codehilite"><pre><span></span><span class="kn">from</span> <span class="nn">__future__</span> <span class="kn">import</span> <span class="n">print_function</span>
        <span class="k">print</span><span class="p">(</span><span class="s2">&quot;Hello, World!&quot;</span><span class="p">)</span> <span class="c1"># Python 2-3 compatible code</span>
        </pre></div>

  - [Fenced code blocks - Writing Your Docs \- MkDocs](https://www.mkdocs.org/user-guide/writing-your-docs/#fenced-code-blocks) 提到 syntax highlighter #ril
  - [CodeHilite \- Material for MkDocs](https://squidfunk.github.io/mkdocs-material/extensions/codehilite/) Syntax highlighting 是 theme 的功能? #ril

## Plugin ??

  - [Plugins \- MkDocs](https://www.mkdocs.org/user-guide/plugins/) #ril
  - [Plugin API\. · Issue \#206 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/issues/206) #ril
  - [MkDocs Plugins · mkdocs/mkdocs Wiki](https://github.com/mkdocs/mkdocs/wiki/MkDocs-Plugins) 條列外部開發的 plugin #ril

## Read the Docs ??

  - [MkDocs](https://www.mkdocs.org/) 內建 `readthedocs` theme，效果跟 Read the Docs 上的文件很像。
  - [Read the Docs - Deploying Your Docs \- MkDocs](https://www.mkdocs.org/user-guide/deploying-your-docs/#read-the-docs) #ril

## API Reference ??

  - 最糟是轉向 Sphinx 產生的文件，若能將 Sphinx 產生的文件整進來也是個方式 ...
  - 或許 MkDocs 內建 `readthedocs` theme 的關係，讓我們混淆了 MkDocs 的定位；目前看來 Sphinx 還是寫 Read the Docs 這類文件的最佳方案，而 MkDocs 則較適合用在建立 project site？

參考資料：

  - [How to build API reference docs · Issue \#641 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/issues/641)
      - twiecki: Along with documentation, sphinx can auto-generate references by walking through the files and looking at the doc-strings. Is this possible or are there any plans to add this? 聽起來 Sphinx 是 MkDocs 的父集合，只是它不支援 Markdown
      - d0ugal (Member): This isn't currently possible and we have no plans to add it to MkDocs itself. I would like to see this happen via the extension API when we add one. See #206. 但隨後補上 FWIW, API docs (and a general plugin API) is something that I really want in some cases. So it is bubbling up in priority for me but I have a few critical things I need to take care of first. So I have no idea when I would have time to take it on. ... 開發團隊慢慢理解到這樣的需求。
      - waylan (Member) 引用了 [How I Judge the Quality of Documentation in 30 Seconds — Eric Holscher \- Surfing in Kansas](http://ericholscher.com/blog/2014/feb/27/how-i-judge-documentation-quality/#prose) 的說法 -- If your documentation is generated from source code, I am immediately skeptical. You should use words to communicate with your users, and those words shouldn’t live in your source code. If you included all of the things needed to document a project in source, your code would be unreadable. So please, use a tool that allows you to write prose documentation outside of your source code. Your users will thank you. ... 是有些道理，但 API 文件不同啊?
      - d0ugal: Yeah, I almost totally agree. They are not a replacement to well written docs. So if all your docs are generated from code, then I think you are doing it wrong :) However, I do like them as an additional resource to prose documentation. Personally, for example, I find them particularly useful when I know a project well but I just want to look up something I've not used in a while.
      - kernc: User's manual is one thing, and API reference (docstrings) is another. A minimally usable documentation tool should be able to produce a HTML of the latter. 確實是如此
      - d0ugal: MkDocs has proven that automatically creating an API reference isn't required to be minimally usable given that we have many users. 認為這不是 MkDocs 最低限度要支援的功能，最後還是導向 plugin API #206 的討論。
  - [generate or link to API docs · Issue \#20 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/issues/20)
      - tomchristie (Contributor): Autogenerated docs isn't something I'm particular interested in pulling into mkdocs. The best documentation sites that I've seen DON'T TEND TO INCLUDE AUTOGENERATED DOCS. 不過 "I'm planning for you to be able to add regular HTML pages as well as MD pages." 的選項似乎出現了一線希望 ... tomchristie 隨後將這個 issue 關閉，轉向 #28 討論。
      - rossant: 自己寫了個[工具](https://github.com/kwikteam/phy/blob/master/tools/api.py)，可以根據 docstrings 產生 `api.md`，然後就可以交給 MkDocs 使用。
      - d0ugal (Member): 如果在產生 Markdown 為什麼不直接用 Markdown 寫文件? ... 沒進入狀況 XD 隨後 AbdealiJK 與 isms 引用其他專案想用 MkDocs 取代 Sphinx 的 issue。
      - raghakot: 也寫了個 https://github.com/raghakot/markdown-apidocs。
  - [Plugin API\. · Issue \#206 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/issues/206) #ril
      - erichulser: One of the requirements I have for documentation is auto-module/class docs as a means to augment the prose style. 看起來 prose 指的是非 docstrings 那種硬梆梆的寫法 ... . I would propose simply adding a plugin architecture to mkdocs (similar to django/pyramid) that would allow a developer to run additional addons so as to not pollute the core of the project. 原來 plugin 的想法是從這裡開始的。
      - d0ugal: We absolutely don't want to include auto-generated docs for MkDocs. Doing so would be a promise to support a Python API.
      - erichulser: 做了個 [erichulser/mkdocs\_autodoc](https://github.com/erichulser/mkdocs_autodoc) extension
  - [Allow HTML pages\. · Issue \#28 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/issues/28) #ril

  - [NiklasRosenstein/pydoc\-markdown: Create Python API documentation in Markdown format\.](https://github.com/NiklasRosenstein/pydoc-markdown)
  - [Actions \- Pinax Stripe](https://pinax-stripe.readthedocs.io/en/latest/reference/actions/) 怎麼把 API reference 拼進 MkDocs 的?
      - [History for docs/reference/actions\.md \- pinax/pinax\-stripe](https://github.com/pinax/pinax-stripe/commits/master/docs/reference/actions.md) 看起來不是從 source code 自動產生的?
      - [pinax\-stripe/charges\.py at master · pinax/pinax\-stripe](https://github.com/pinax/pinax-stripe/blob/master/pinax/stripe/actions/charges.py) 不過 `docs/reference/*.md` 的內容與 source code 裡的 docstrings 是一致的。
      - [add\_event: get stripe\_account from message · pinax/pinax\-stripe@274abcf](https://github.com/pinax/pinax-stripe/commit/274abcf9d6fb25a29e6531a468d75333f05b6ed3#diff-85aca1129704024a07435fb565b3f92f) 從 `reference/actions.md` 反推 history，每個 commit 都會跟 source code 裡的 docstrings 一起修改，感覺有用什麼工具?
      - [Sync subscription data immediately · pinax/pinax\-stripe@86bed63](https://github.com/pinax/pinax-stripe/commit/86bed63f316040f7ff435fbbeadd3ff715d43a40#diff-85aca1129704024a07435fb565b3f92f) 從這個 commit 看來是手動同步的；在 docstrings 寫 "Returns: the data representing the subscription object that was created"，但到 `reference/actions.md` 就改成 "Returns: the `pinax.stripe.models.Subscription` object that was created" 了。

## 安裝設定 {: #installation }

  - [Installation - MkDocs](https://www.mkdocs.org/#installation) 可以用 OS package manager 裝，但如果版本不夠新，還是建議用 pip 安裝 `mkdocs` 套件，就會有 `mkdocs` 指令可用。

### Docker ??

  - [squidfunk/mkdocs\-material \- Docker Hub](https://hub.docker.com/r/squidfunk/mkdocs-material/) #ril
  - [Search \- Docker Hub](https://hub.docker.com/search/?isAutomated=0&isOfficial=0&page=1&pullCount=0&q=mkdocs&starCount=0) 感覺自己可以弄個預裝很多 theme 及 Python-Markdown extenion 者，調整組態就能套用 ??
  - [Running mkdocs with Docker – Edson Alcala – Medium](https://medium.com/@edsonalcalamx/running-nethereum-docs-with-docker-5b8a4c25d42f) (2018-03-09) 重點是 `mkdocs.yml` 裡要加 `dev_addr: 0.0.0.0:8080` 才能搭配 `docker run --publish 8080:8080` 使用。

## 參考資料 {: #reference }

  - [MkDocs](https://www.mkdocs.org/)
  - [mkdocs/mkdocs - GitHub](https://github.com/mkdocs/mkdocs)
  - [mkdocs - PyPI](https://pypi.org/project/mkdocs/)

社群：

  - [MkDocs - Google Groups](https://groups.google.com/forum/#!forum/mkdocs)
  - [Issues · mkdocs/mkdocs - GitHub](https://github.com/mkdocs/mkdocs/issues)

文件：

  - [mkdocs/mkdocs Wiki](https://github.com/mkdocs/mkdocs/wiki)

相關：

  - [Python-Markdown](python.markdown.md) - MkDocs 背後用 Python-Markdown 將 Markdown 轉換成 HTML

手冊：

  - [Release Notes](https://www.mkdocs.org/about/release-notes/)
  - [Configuration - MkDocs](https://www.mkdocs.org/user-guide/configuration/)
