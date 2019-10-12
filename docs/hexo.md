# Hexo

  - [Hexo](https://hexo.io/)

      - A fast, simple & powerful blog framework
      - Blazing Fast -- Node.js brings you incredible generating speed. Hundreds of files take only seconds to build.
      - Markdown Support -- All features of GitHub Flavored Markdown are supported. You can even use most Octopress plugins in Hexo.
      - One-Command Deployment -- You only need one command to deploy your site to GitHub Pages, Heroku or other sites.
      - Various Plugins -- Hexo has a powerful plugin system. You can install more plugins for Jade, CoffeeScript plugins.

  - [What is Hexo? - Documentation \| Hexo](https://hexo.io/docs/#What-is-Hexo)

    Hexo is a fast, simple and powerful blog framework. You write posts in Markdown (or other languages) and Hexo generates static files with a beautiful theme in seconds.

## 新手上路 {: #getting-started }

  - [Hexo](https://hexo.io/)

        npm install hexo-cli -g
        hexo init blog
        cd blog
        npm install
        hexo server

    跟著做一遍：

        $ hexo --version # (1)
        hexo-cli: 2.0.0
        os: Linux 4.9.125-linuxkit linux x64
        http_parser: 2.8.0
        node: 10.15.3
        v8: 6.8.275.32-node.51
        uv: 1.23.2
        zlib: 1.2.11
        ares: 1.15.0
        modules: 64
        nghttp2: 1.34.0
        napi: 3
        openssl: 1.1.0j
        icu: 62.1
        unicode: 11.0
        cldr: 33.1
        tz: 2018e

        $ hexo init blog
        INFO  Cloning hexo-starter https://github.com/hexojs/hexo-starter.git (2)
        Cloning into '/workspace/blog'...
        ...
        Submodule 'themes/landscape' (https://github.com/hexojs/hexo-theme-landscape.git) registered for path 'themes/landscape' (2)
        Cloning into '/workspace/blog/themes/landscape'..
        ...
        Submodule path 'themes/landscape': checked out '73a23c51f8487cfcd7c6deec96ccc7543960d350'
        INFO  Install dependencies
        yarn install v1.13.0
        info No lockfile found.
        [1/4] Resolving packages...
        warning hexo > warehouse > cuid > core-js@1.2.7: core-js@<2.6.8 is no longer maintained. Please, upgrade to core-js@3 or at least to actual version of core-js@2.
        warning hexo > hexo-fs > chokidar > braces > snapdragon > base > mixin-deep@1.3.1: Critical bug fixed in v2.0.1, please upgrade to the latest version.
        warning hexo > hexo-fs > chokidar > braces > snapdragon > base > cache-base > set-value@2.0.0: Critical bug fixed in v3.0.1, please upgrade to the latest version.
        warning hexo > hexo-fs > chokidar > braces > snapdragon > base > cache-base > union-value > set-value@0.4.3: Critical bug fixed in v3.0.1, please upgrade to the latest version.
        [2/4] Fetching packages...
        info fsevents@1.2.9: The platform "linux" is incompatible with this module.
        info "fsevents@1.2.9" is an optional dependency and failed compatibility check. Excluding it from installation.
        [3/4] Linking dependencies...
        [4/4] Building fresh packages...
        success Saved lockfile.
        ...
        Done in 45.45s.
        INFO  Start blogging with Hexo!

        $ cat package.json
        {
          "name": "hexo-site",
          "version": "0.0.0",
          "private": true,
          "hexo": {
            "version": ""
          },
          "dependencies": {
            "hexo": "^3.9.0", // (4)
            "hexo-generator-archive": "^0.1.5",
            "hexo-generator-category": "^0.1.3",
            "hexo-generator-index": "^0.2.1",
            "hexo-generator-tag": "^0.2.0",
            "hexo-renderer-ejs": "^0.3.1",
            "hexo-renderer-stylus": "^0.3.3",
            "hexo-renderer-marked": "^1.0.1",
            "hexo-server": "^0.3.3"
          }
        }

        $ tree -aFL 2
        .
        |-- .gitignore
        |-- _config.yml    (5)
        |-- node_modules/
        ...
        |-- package.json
        |-- scaffolds/     (5)
        |   |-- draft.md
        |   |-- page.md
        |   `-- post.md
        |-- source/        (5)
        |   `-- _posts/
        |-- themes/        (5)
        |   `-- landscape/
        `-- yarn.lock

        276 directories, 8 files

        $ cat .gitignore
        .DS_Store
        Thumbs.db
        db.json       (6)
        *.log
        node_modules/ (6)
        public/
        .deploy*/

        $ hexo server
        INFO  Start processing
        INFO  Hexo is running at http://localhost:4000 . Press Ctrl+C to stop. (7)

     1. `hexo --version` 看的是 `hexo-cli` 套件的版本，跟某個 site 要用 `hexo` 的哪個版本無關。
     2. `hexo init HEXO_ROOT_DIR` 會根據 [`hexo-starter`](https://github.com/hexojs/hexo-starter) 產生一個專案，以 submodule 的方式自帶 [`landscape`](https://github.com/hexojs/hexo-theme-landscape) theme。
     3. `hexo init` 在產生完專案後，會自動呼叫 `yarn install` 根據 `package.json` 安裝套件到 `node_modules/` 並產生 `yarn.lock`；所以首頁說的 `npm install` 這動作就免了。
     4. 這才是 Hexo 的版本，其他 `hexo-*` 套件都是 plugin。
     5. 安裝完成後，跟內容相關的檔案、目錄有 `_config.yml` (設定)、`scaffolds/` (文件樣板)、`source/` (文件)、`themes/` (網站樣板)。
     6. 從自動產生的 `.gitignore` 看來，`db.json` (待會執行 `hexo server` 會產生) 跟 `node_modules/` 都不該進版本控制。
     7. `hexo server` 預設會在 `http://localhost:4000` 服務，跟文件寫的 `0.0.0.0` 不同 ??

## Configuration ??

  - [Configuration \| Hexo](https://hexo.io/docs/configuration)

      - You can modify site settings in `_config.yml` or in an ALTERNATE config file.

    Using an Alternate Config

      - A custom config file path can be specified by adding the `--config` flag to your `hexo` commands with a path to an alternate YAML or JSON config file, or a comma-separated list (no spaces) of multiple YAML or JSON files.

            # use 'custom.yml' in place of '_config.yml'
            $ hexo server --config custom.yml

            # use 'custom.yml' & 'custom2.json', prioritizing 'custom2.json'
            $ hexo server --config custom.yml,custom2.json

      - Using multiple files COMBINES all the config files and saves the merged settings to `_multiconfig.yml`. The later values take precedence. It works with any number of JSON and YAML files with ARBITRARILY DEEP OBJECTS. Note that no spaces are allowed in the list.

        For instance, in the above example if `foo: bar` is in `custom.yml`, but `"foo": "dinosaur"` is in `custom2.json`, `_multiconfig.yml` will contain `foo: dinosaur`.

    Overriding Theme Config

      - Hexo themes are INDEPENDENT PROJECTS, with separate `_config.yml` files.

        INSTEAD OF FORKING A THEME, and maintaining a custom branch with your settings, you can configure it from your site’s primary configuration file.

      - Example configuration:

            # _config.yml
            theme_config:
              bio: "My awesome bio"

            # themes/my-theme/_config.yml
            bio: "Some generic bio"
            logo: "a-cool-image.png"
            Resulting theme configuration:

            {
              bio: "My awesome bio",
              logo: "a-cool-image.png"
            }

        從 `theme_config` 往下覆寫目前 theme 的 `_config.yml`，上面的例子假設目前用 `my-theme`，所以 `_config.yml` 的 `theme_config: bio` 會覆寫 `themes/my-theme/_config.yml` 裡的 `bio`。

        實驗發現 `theme_config: footer: since: 2017` 會覆寫整個 `theme/_config.yml` 裡的 `footer:`，無法單純複寫 `since: 2017` 這項設定。

## Server

  - [Server \| Hexo](https://hexo.io/docs/server.html) #ril

      - With the release of Hexo 3, the server has been separated from the main module. To start using the server, you will first have to install `hexo-server`.

            $ npm install hexo-server --save

        `hexo init` 採用的[樣板已經內建 `hexo-server` 套件](https://github.com/hexojs/hexo-starter/blob/master/package.json#L17)。

      - Once the server has been installed, run the following command to start the server. Your website will run at http://localhost:4000 by default. When the server is running, Hexo will WATCH FOR FILE CHANGES and update automatically so it’s not necessary to manually restart the server.

            $ hexo server

        根據下面 ahuigo 的提問，`_config.xml` 的變動要重啟 server 才會生效：

        > Hexo server does not watch for global file `_config.yml` changes. If you change global file, it doesn't update automatically.

      - If you want to change the port or if you’re encountering `EADDRINUSE` errors, use the `-p` option to set a different port.

            $ hexo server -p 5000

## 顯示作者 ??

  - 若要多人編輯，在文章內顯示作者就很重要。

參考資料：

  - https://github.com/hexojs/hexo/issues/673 加 `author:` 即可
  - 直接從 commit log 來取 author 可能不太對，比如之後增加 tag，可能要修改改人的 post，但 author 應該不變；看來 front matter 裡的 `author:` 是最適合的
  - 顯示 commit 也不錯啦 => https://www.npmjs.com/package/hexo-generator-author 要搭配 Next (小修改)
  - https://github.com/xcatliu/hexo-filter-author-from-git 支援 author 跟 contributor
  - [Create an Hexo Theme - Part 1: Index | CodeBlocQ](http://www.codeblocq.com/2016/03/Create-an-Hexo-Theme-Part-1-Index/) 這裡教人家怎麼宣告 author (有連結更好... 或許也可以來個 author map??)
  - [Project Documentation with Hexo Static Site Generator](https://www.sitepoint.com/project-documentation-hexo/) 自訂 theme 結果只用到 page，這也好怪...

## 安裝設置 {: #setup }

  - 用 npm 安裝 `hexo-cli` 套件 (不是 `hexo`)，就會有 `hexo` 指令可以用。

        npm install -g hexo-cli

    不過這需要 Node.js 與 Git，用 Docker 相對單純。

參考資料：

  - [Installation - Documentation \| Hexo](https://hexo.io/docs/#Installation)

    Requirements

      - Installing Hexo is quite easy. However, you do need to have a couple of other things installed first:

          - Node.js (Should be at least nodejs 6.9)
          - Git

        If your computer already has these, congratulations! Just install Hexo with npm:

            $ npm install -g hexo-cli

      - For Mac users

        You may encounter some problems when compiling. Please install Xcode from App Store first. After Xcode is installed, open Xcode and go to Preferences -> Download -> Command Line Tools -> Install to install command line tools.

        看起來用 Docker 安裝是最單純的。

### Docker

  - [官方文件](https://hexo.io/docs/#Installation) 完全沒提到 Docker，只能自己打包 image。

---

參考資料：

  - [idiswy/hexo \- Docker Hub](https://hub.docker.com/r/idiswy/hexo/) #ril

## 參考資料 {: #reference }

  - [Hexo](https://hexo.io/)
  - [hexojs/hexo - GitHub](https://github.com/hexojs/hexo)
  - [hexojs/hexo-cli - GitHub](https://github.com/hexojs/hexo-cli)

社群：

  - [Issues · hexojs/hexo](https://github.com/hexojs/hexo/issues)
  - [Hexo - Google Groups](https://groups.google.com/forum/#!forum/hexo)

文件：

  - [Documentation | Hexo](https://hexo.io/docs/)

更多：

  - [Theme](hexo-theme.md)

手冊：

  - [Configuration](https://hexo.io/docs/configuration)
  - [Commands](https://hexo.io/docs/commands)
