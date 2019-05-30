# Hexo

### 顯示作者 ??

  - 若要多人編輯，在文章內顯示作者就很重要。

參考資料：

  - https://github.com/hexojs/hexo/issues/673 加 `author:` 即可
  - 直接從 commit log 來取 author 可能不太對，比如之後增加 tag，可能要修改改人的 post，但 author 應該不變；看來 front matter 裡的 `author:` 是最適合的
  - 顯示 commit 也不錯啦 => https://www.npmjs.com/package/hexo-generator-author 要搭配 Next (小修改)
  - https://github.com/xcatliu/hexo-filter-author-from-git 支援 author 跟 contributor
  - [Create an Hexo Theme - Part 1: Index | CodeBlocQ](http://www.codeblocq.com/2016/03/Create-an-Hexo-Theme-Part-1-Index/) 這裡教人家怎麼宣告 author (有連結更好... 或許也可以來個 author map??)
  - [Project Documentation with Hexo Static Site Generator](https://www.sitepoint.com/project-documentation-hexo/) 自訂 theme 結果只用到 page，這也好怪...

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

## 安裝設定 {: #installation }

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

