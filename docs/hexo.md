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

### Docker ??

## 參考資料 {: #reference }

  - [Hexo](https://hexo.io/)
  - [hexojs/hexo - GitHub](https://github.com/hexojs/hexo)
  - [hexojs/hexo-cli - GitHub](https://github.com/hexojs/hexo-cli)

社群：

  - [Issues · hexojs/hexo](https://github.com/hexojs/hexo/issues)
  - [Hexo - Google Groups](https://groups.google.com/forum/#!forum/hexo)

文件：

  - [Documentation | Hexo](https://hexo.io/docs/)

手冊：

  - [Commands | Hexo](https://hexo.io/docs/commands)

