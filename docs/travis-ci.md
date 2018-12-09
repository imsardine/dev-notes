# Travis CI

  - 定位成 the home of open source testing (針對 GitHub)，對 open source project 是免費的，但 private project 的計費也只根據 concurrent job，不限 repo 數量。
  - 測試是核心，除了 branch build flow，也支援 pull request build flow 在 PR 的 merge 發生前就先行測試 (test your pull requests)。
  - 測試通過後，也可以自動佈署到 S3 或 Heroku。

參考資料：

  - [Travis CI \- Test and Deploy Your Code with Confidence](https://travis-ci.org/)
      - Test and Deploy with Confidence - Easily sync your GitHub projects with Travis CI and you’ll be testing your code in minutes! 專注在 GitHub + Test + Deploy
      - Testing your open source projects will always be FREE!
      - TEST YOUR PULL REQUESTS - Make sure every Pull Request to your project is tested before it's merged.
      - DEPLOY ANYWHERE - Updating staging or production as soon as your tests pass has never been easier! 內建支援不同的 deployment provider，包括 GitHub Pages。
      - 支援兩種流程：Branch build flow (通過測試後直接 deploy) 與 Pull request build flow (PR 通過測試後，通知可以 merge)。
  - [Profile \- Travis CI](https://travis-ci.org/account/repositories) 在 profile 頁看到 "We're only showing your public repositories. You can find your private projects on travis-ci.com." 原來 travis-ci.org 跟 travis-ci.com 是根據 public/private repo 區分的。
  - [Travis CI \- Wikipedia](https://en.wikipedia.org/wiki/Travis_CI) #ril

## 基礎

### Hello, World!

這裡用 GitHub project pages site 來示範。

在 GitHub 新建 `hello-travis` repo、在 Travis CI 啟用 (Activate repository) 並設定 `GITHUB_TOKEN` 環境變數，然後推送第一個 commit：

`.travis.yml`:

```
script:
- mkdir site
- echo "Hello, World! `date`" > site/index.html
deploy:
  provider: pages
  github-token: $GITHUB_TOKEN
  skip-cleanup: true
  local-dir: site
```

就可在 https://<username>.github.io/hello-travis 看到內容。

### 新手上路 ??

  - [Core Concepts for Beginners \- Travis CI](https://docs.travis-ci.com/user/for-beginners/)
      - Continuous Integration is the practice of merging in SMALL CODE CHANGES FREQUENTLY - rather than merging in a large change at the end of a development cycle. The goal is to build healthier software by developing and testing in SMALLER INCREMENTS.
      - When you run a build, Travis CI clones your GitHub repository into a brand new VIRTUAL ENVIRONMENT, and carries out a series of TASKS to build and test your code. 如果這中間有個環節出狀況，我們說這個 build 是 broken，否則就是 passed，接著就可以考慮進 deploy。
      - 上面的 broken 依據出狀況的時間點，又區分為 errored、failed、canceled：
     * errored - 在 `before_install`、`install` 或 `before_script` phase 裡的 command 傳回 non-zero exit code 時，視為 errored (正事都還沒開始做)，該 job 會立即停止。
     * failed - 在 `script` phase 的 command 傳回 non-zero exit code 時，視為 failed，但 job 為什麼還要執行完??
     * canceled - 使用者在 job 執行完之前取消。
  - [Travis CI \- Test and Deploy Your Code with Confidence](https://travis-ci.org/getting_started) Sign in with GitHub 會看到這份文件
      - Activate your GitHub repositories - 到 profile page，可以對 organization 啟用 GitHub App integration；沒看到 Activate GitHub Apps integration 的按鈕 ??
      - Add a .travis.yml file to your repository - 必須在每個 repo 的根目錄下放置 `.travis.yml`，可以參考 Language-specific Guides 的寫法。
      - Trigger your first build - 接著推一個新的 commit 到 GitHub，就會觸發 CI build。
  - [Travis CI Tutorial \- Travis CI](https://docs.travis-ci.com/user/tutorial/) #ril

### Phase, Job, Build, Stage ??

  - [Builds, Jobs, Stages and Phases - Core Concepts for Beginners \- Travis CI](https://docs.travis-ci.com/user/for-beginners/#builds-jobs-stages-and-phases) 常見的用詞有 job、phase、build、stage；很明顯 build > job > phase，但 build 跟 stage 的關係是什麼??
      - job - an automated process that clones your repository into a virtual environment and then carries out a series of PHASES such as compiling your code, running tests, etc. A job fails if the RETURN CODE of the `script` PHASE is non zero. 一個 job 一連串的 phase 組成，依序執行；注意一個 phase 不一定由多個 commands 組成，`install` 跟 `script` 是一連串的 commands，但 `deploy` 通常就是設定 deployment provider，而非自訂 commands。
      - phase - the SEQUENTIAL steps of a job. For example, the `install` phase, comes before the `script` phase, which comes before the OPTIONAL `deploy` phase. 也就是 install -> script -> (deploy)，其中 `install` phase 用來準備測試環境??
      - build - a GROUP OF JOBS. For example, a build might have two jobs, each of which tests a project with a different version of a programming language. A build finishes when all of its jobs are finished. 分不同的 configuration/matrix ??
      - stage - a group of jobs that run in PARALLEL as part of sequential build process composed of multiple stages.
  - [Job Lifecycle \- Travis CI](https://docs.travis-ci.com/user/job-lifecycle/) #ril
  - [Build Matrix \- Travis CI](https://docs.travis-ci.com/user/build-matrix/) #ril
  - [Build Stages \- Travis CI](https://docs.travis-ci.com/user/build-stages/) #ril
  - [Conditional Builds, Stages, and Jobs \- Travis CI](https://docs.travis-ci.com/user/conditional-builds-stages-jobs/) #ril

### .travis.yml ??

  - [Customizing the Build \- Travis CI](https://docs.travis-ci.com/user/customizing-the-build/) #ril
  - [Language\-specific Guides \- Travis CI](https://docs.travis-ci.com/user/language-specific/) #ril
  - [Community\-Supported Languages \- Travis CI](https://docs.travis-ci.com/user/languages/community-supported-languages/) #ril

### Environment Variable ??

  - [Environment Variables \- Travis CI](https://docs.travis-ci.com/user/environment-variables) #ril
      - 環境變數是自訂 build process 常見的方式，只是該宣告在哪裡，會依資料本身的性質不同 -- 敏感? or 每個 branch 不同?
      - 如果不含敏感資訊，且每個 branch 可能有不同的值，直接宣告在 `.travis.yml` 即可。
      - 如果含有敏感資訊，最好是由環境變數提供 (Repository Settings)，但如果每個 branch 有不同的值，就只能加進 `.travis.yml` 裡，但必須要加密過；沒有被解密的風險??
  - [Defining encrypted variables in .travis.yml - Environment Variables \- Travis CI](https://docs.travis-ci.com/user/environment-variables#defining-encrypted-variables-in-travisyml) #ril

### Build Environment ??

  - [Infrastructure and environment notes - Core Concepts for Beginners \- Travis CI](https://docs.travis-ci.com/user/for-beginners/#infrastructure-and-environment-notes) 提供了一些 infrastructure environment 供選擇，大致分為 container-based、sudo-enabled 及 OS X：
      - Container-based (預設) - a Linux Ubuntu environment running in a container，啟動比 sudo-enable 還快，但可用的 resource 較少，也沒有 `sudo`、`setuid` 或 `setgid` 可用 ??
      - Sudo-enabled - Linux Ubuntu environment runs on full virtual machine. 完整的 VM
      - OS X - 提供不同版本的 OS X，適用於建構 OS X 的軟體；跟 iOS 無關??
  - [Build Environment Overview \- Travis CI](https://docs.travis-ci.com/user/reference/overview/) 其實也有 Windows #ril

### Docker ??

  - [Infrastructure and environment notes - Core Concepts for Beginners \- Travis CI](https://docs.travis-ci.com/user/for-beginners/#infrastructure-and-environment-notes) 預設是 container-based。
  - [Using Docker in Builds \- Travis CI](https://docs.travis-ci.com/user/docker/) #ril

### Deployment ??

  - [Deployment \- Travis CI](https://docs.travis-ci.com/user/deployment/) 內建支援許多不同 service 的 (deployment) provider #ril
  - [Script deployment \- Travis CI](https://docs.travis-ci.com/user/deployment/script/) 還是可以透過 script 自訂 #ril
  - [Uploading Artifacts on Travis CI \- Travis CI](https://docs.travis-ci.com/user/uploading-artifacts/) 單純上傳 build artifact 到 S3 #ril

### GitHub Pages

官方的範例完全沒提到 source 在哪? 是如何產生 website 的? 雖然 generator 各有不同，但整個 workflow 還是有些共通點，以 Hexo 產生 user/organization site 為例：

(reop 專用於 website，且內容來自 `master` branch，假設 website source 放在 `source` branch)

```
language: node_js
node_js: stable
branches:
  only:
  - source                  # website source 所在的 branch
cache:
  directories:
  - node_modules
before_install:             # 安裝 generator
- npm install -g hexo-cli
install:
- npm install
script:                     # 產生 website
- hexo generate
deploy:                     # 上傳 website
  provider: pages
  github-token: $GITHUB_TOKEN
  skip-cleanup: true        # 保留上階段產生的 website
  local-dir: public         # website 所在的目錄
  target-branch: master     # 上傳到哪個 branch (同一 repo)
  on:
    branch: source          # website source 所在的 branch
```

若改用 MkDocs 產生 project site：

(repo 混雜了 code 跟 website，內容來自 `gh-pages` branch，假設 website source 放在 `master` branch 的 `/docs` 下)

```
language: python
branches:
  only:
  - master                  # website source 在 docs/ (master branch)
before_install:
- pip install mkdocs
script:
- mkdocs build
deploy:
  provider: pages
  github-token: $GITHUB_TOKEN
  skip-cleanup: true
  local-dir: site           # MkDocs 的產出在 site/
  target-branch: gh-pages   # project site 內容來自 gh-pages branch
  on:
    branch: master
```

參考資料：

  - [GitHub Pages Deployment \- Travis CI](https://docs.travis-ci.com/user/deployment/pages/)
      - provider `pages` 可以將 static files 推送到 GitHub Pages，需要提供 personal access token。例如：

            deploy:
              provider: pages
              skip-cleanup: true           # 否則 script phrase 產生的檔案會被清掉
              github-token: $GITHUB_TOKEN  # 由 Travis CI 的環境變數提供
              keep-history: true           # 預設是 false，不會保留 target branch 的 history
              on:
                branch: master # 只有 master branch 才會觸發 deployment

      - Deploying to GitHub Pages uses `git push --force` to overwrite the history on the target branch (跟 `keep-history` 預設是 `false` 有關), so make sure you only deploy to a branch used for that specific purpose, such as `gh-pages`. 由於這個動作有危險性，要確保 `target-branch` (預設是 `gh-pages`) 真的是用來存放產出的結果。
      - Make sure you have `skip-cleanup` set to `true`, otherwise Travis CI will DELETE ALL THE FILES CREATED DURING THE BUILD, which will probably delete what you are trying to upload. 不太懂為什麼在 `deploy` phase 預設要重置 working directory?
      - `local-dir` -> `repo` + `target-branch` (`keep-history`, `fqdn`)，這幾個 option 的關係可以讀做 "將 `local-dir` 的內容上傳到 `repo` 的 `target-branch`"。
          - `local-dir` 預設是當前的目錄，可以用 absoulte/relative 表示；這會依 generator 不同，例如 MkDocs 慣用 `site`，而 Hexo 則慣用 `public`。
          - `repo` 預設是當前的 repo，通常不需要調整，因為不論是 user/organization 或 project site 都可以把 source 跟 generated HTML 存在同一個 repo 的不同 branch。
          - `target-branch` 預設是 `gh-pages`，這只適用於 project page，若是 user/organization site 的話，則要改用 `master`。
          - 另外可以用 `keep-history` 來控制要不要保留 `target-branch` 的 history，而 `fqdn` 大概是決定要不要在 `local-dir` 多放一支 `CNAME` 的檔案??
      - `name` 跟 `email` 用來識別 commiter，預設分別是 `Deployment Bot` 與 `deploy@travis-ci.org`；若 `committer-from-gh` 設為 `true`，就會採用 personal access token 的 owner。
  - [What's the meaning of on: branch of GitHub Pages Deployment ? · Issue \#1091 · travis\-ci/docs\-travis\-ci\-com](https://github.com/travis-ci/docs-travis-ci-com/issues/1091)
      - danielo515: 範例提到 `deploy: on: branch: master` 的用法，但完全沒有解釋? 跟 target branch 無關 (因為下面有 `target-branch`)，但它跟 `branches: only:` 又是什麼關係?
      - plaindocs: (contributor) `on:` 指的是 "conditional deployment FROM the specific branch"，在官方的文件有說明 (雖然沒有連結)，之後會修文件。
      - plaindocs: When the build succeeds ON master, deployment happens. 這說法還滿容易懂的。
      - markuszoeller: Skipping a deployment with the pages provider because this branch is not permitted: xxx
  - [Skipping deployment because this branch is not permitted · Issue \#8289 · travis\-ci/travis\-ci](https://github.com/travis-ci/travis-ci/issues/8289) #ril
  - [Deploying your Angular app to Github Pages using Travis\-CI](https://medium.com/angularmedellin/deploying-your-angular-app-to-github-pages-using-travis-ci-baca2e1c30e7) (2018-06-05) #ril

### Notification ??

  - [Configuring Build Notifications \- Travis CI](https://docs.travis-ci.com/user/notifications/) #ril

### iOS ??

  - [Travis CI for iOS · objc\.io](https://www.objc.io/issues/6-build-tools/travis-ci/) (2013-11) #ril

### CLI ??

  - [travis\-ci/travis\.rb: Travis CI Client \(CLI and Ruby library\)](https://github.com/travis-ci/travis.rb#readme) #ril

## 疑難排解

  - [Common Build Problems \- Travis CI](https://docs.travis-ci.com/user/common-build-problems/) #ril

## 參考資料

  - [Travis CI](https://travis-ci.org/)
  - [Travis CI Blog](https://blog.travis-ci.com/)
  - [Travis CI - GitHub](https://github.com/travis-ci)

社群：

  - [Travis CI (@travisci) | Twitter](https://twitter.com/travisci)
  - ['travis-ci' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/travis-ci)

文件：

  - [Travis CI User Documentation](https://docs.travis-ci.com/)

手冊：

  - [Travis CI Changelog](https://changelog.travis-ci.com/)
  - [Languages - Travis CI](https://docs.travis-ci.com/user/languages/)
  - [Default Environment Variables](https://docs.travis-ci.com/user/environment-variables#default-environment-variables)
