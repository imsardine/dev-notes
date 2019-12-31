---
title: GitLab / CI/CD
---
# [GitLab](gitlab.md) / CI/CD

  - [GitLab Continuous Integration & Deployment \| GitLab](https://about.gitlab.com/features/gitlab-ci-cd/) #ril

## CI 跟 CD 有什麼不同??

  - [GitLab Continuous Integration \(GitLab CI\) \- GitLab Documentation](https://docs.gitlab.com/ce/ci/) GitLab 內建對 CI (Continuous Integration)、CD (Continuous Deployment/Delivery) 的支援；CI Pipeline 包含 build、unit test、integration tests，而 review、staging、production 則都屬於 CD Pipeline。

## Hello, World! ??

  - 用 Python 寫個 hello world，送到 GitLab 上測試?

## 如何入門 GitLab CI/CD??

  - [Getting started with GitLab CI/CD \- GitLab Documentation](https://docs.gitlab.com/ce/ci/quick_start/) #ril
  - [GitLab Continuous Integration \(GitLab CI\) \- GitLab Documentation](https://docs.gitlab.com/ce/ci/) #ril

## Pipeline、Stage、Job ??

  - [Introduction to pipelines and jobs \- GitLab Documentation](https://docs.gitlab.com/ce/ci/pipelines.html) #ril
  - [stage - Configuration of your jobs with \.gitlab\-ci\.yml \- GitLab Documentation](https://docs.gitlab.com/ce/ci/yaml/README.html#stages)
      - 若沒有用 `stages:` 宣告有哪些 stage，就會假設 `build`、`test` 跟 `deploy`，若沒有宣告 job 的 stage，預設會是 `test` stage。
      - 實驗發現，雖然 `stages` 是宣告小寫，但 pipeline 的 web UI 會顯示 Build、Test、Deploy，不過 job name 倒是維持大小寫不變。

## Scheduled Pipeline ??

  - [Pipeline Schedules \| GitLab](https://docs.gitlab.com/ee/user/project/pipelines/schedules.html) #ril
  - [only:variables - Configuration of your jobs with \.gitlab\-ci\.yml \| GitLab](https://docs.gitlab.com/ee/ci/yaml/README.html#onlyvariables) 搭配 scheduled pipeline variable 似乎可以達到從 schedule 裡指定 job 的效果? 例如 `dailywork: ... variables: - $SCHEDULE == "dailywork"` #ril
  - [Choose jobs in scheduled pipelines \(\#42313\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/42313) #ril

## Artifact, Artifact Passing ??

  - [Introduction to job artifacts \| GitLab](https://docs.gitlab.com/ee/user/project/pipelines/job_artifacts.html) #ril
      - Artifacts 是 job 執行成功後附加的產物 -- a list of files and directories，這項功能預設是啟用的。

```
pdf:
  script: xelatex mycv.tex
  artifacts:
    paths:
    - mycv.pdf
    expire_in: 1 week
```

      - `artifacts.paths` All paths to files and directories are relative to the repository that was CLONED during the build. 根據 `expire_in: 1 week` 會保留在 GitLab 一週；預設會永久保存，但就算加了 `expire_in`，也可以從 web UI 按 [Keep] 將它改為 forever (keep the artifacts from expiring)。

  - [artifacts - Configuration of your jobs with \.gitlab\-ci\.yml \| GitLab](https://docs.gitlab.com/ee/ci/yaml/README.html#artifacts) #ril
      - `artifacts` 用來設定 a list of files and directories which should be attached to the job AFTER SUCCESS；因為 `artifacts:when` 預設是 `on_success`。
      - artifacts:paths` 只能使用 workspace 裡的 path (都是相對於 worksapce 的路徑)。
      - 從 "To disable ARTIFACT PASSING, define the job with empty dependencies:" (`dependencies: []`) 看起來，artifact passing 預設是開啟的。
      - You may want to create artifacts only for tagged releases to avoid filling the build server storage with temporary build artifacts. 這說法好像滿合理的?
  - [dependencies - Configuration of your jobs with \.gitlab\-ci\.yml \- GitLab Documentation](https://docs.gitlab.com/ee/ci/yaml/README.html#dependencies)
      - GitLab 8.6 才支援 `dependencies`，跟 `artifacts` 搭配使用時，可以在 job 間傳遞 artifacts，不過下個 stage 的 job 預設就會拿到上個 stage "所有" job 的 artifact (downloaded and extracted)。
      - 也就是說 `dependencies` 跟 job 的執行順序無關 (順序是由 stage 來控制)，主要是拿來控制 "只想拿到哪些 job 的 artifacts"，設定為 `[]` 表示什麼都不要。
  - [Pass CI build artifacts between stages \(\#3423\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/3423) 希望在 test stage 可以拿到 build stage 的產出物，後來突然出現 `dependencies` 的討論。最後談到 "artifact-passing is enabled by default"，指的是下個 stage 自動會拿到上個 stage 的 artifacts，不用特別宣告 `dependencies`。

## CI/CD Variables ??

  - [GitLab CI/CD Variables \| GitLab](https://docs.gitlab.com/ee/ci/variables/) #ril
      - 當 runner 從 GitLab CI 收到 job，就會準備 build environment -- 包括 predefined variables 及 user-defined variables (泛指非自動產生的 variables)。
      - 不同來源的 variable 有不同的 priority -- trigger variable / scheduled pipeline variable (最高) > project-level variable / protected variable > group-level variable / protected variable > YAML-defined job-level variable > YAML-defined global variable > deployment variable > predefined variable (最低)
      - Unsupported variables 提到有些 variable 不能用在 `.gitlab-ci.yml` 裡??
      - Predefined variable 以 environment variable 的形式出現，不過在 GitLab 9.0 名字有些異動，要儘快改用新的名稱；主要是改掉 `CI_BUILD_*` 的命名。
      - 那麼多 variables 怎麼確認它的值沒問題? 提到 GitLab Runner 1.7 可以啟用 debug tracing，不過 output 會被送到 GitLab server 做為 job trace，記得要將 job 設定為 team members only，若要重新放寬權限，記得要將 job trace 清掉；在 `.gitlab-ci.yml` 加上 `CI_DEBUG_TRACE: "true"` 即可。
  - [Predefined variables (Environment variables) - GitLab CI/CD Variables \| GitLab](https://docs.gitlab.com/ee/ci/variables/#predefined-variables-environment-variables)
      - `CI`/`GITLAB_CI` - 表示在 CI 環境下執行，值固定是 `true`。
      - `CI_REGISTRY` - 若有啟用 container registry，內含 container registry 的位置 (非特定 project)，例如 `gitlab.example.com:4567`
      - `CI_REGISTRY_IMAGE` - 若有啟用 container registry，內含 "特定 project" 的 container registry，例如 `gitlab.example.com:4567/your-group/your-project`
      - `CI_REGISTRY_USER` - 用來 push image 到 container registry 的 username，例如 `gitlab-ci-token`。
      - `CI_REGISTRY_PASSWORD` - 用來 push iamge 到 container registry 的 password。與 `CI_JOB_TOKEN` 同值，但名稱可讀性較高?
      - `CI_JOB_TOKEN` (舊 `CI_BUILD_TOKEN`) - 用來驗證 container registry 的 token。用法像是 `docker login -u gitlab-ci-token -p $CI_JOB_TOKEN $CI_REGISTRY`。
      - `CI_PROJECT_NAMESPACE`、`CI_PROJECT_NAME` - 即 group name (namespace) 與 project name，分別像是 `mygroup` 與 `awesome-project`。
      - `CI_PROJECT_PATH` - 用 `/` 將 group name 與 project name 串起來，例如 `mygroup/awesome-project`。
      - `CI_COMMIT_REF_NAME` - 目前正在建置的 branch/tag name；但 `CI_COMMIT_TAG` 只能拿到 tag name。
      - `CI_COMMIT_SHA` - 目前正在建置的 commit revision。
      - `CI_DEBUG_TRACE` - 設為 `true` 可以啟用 debug tracing。
      - `CI_PROJECT_DIR` - Repository 被 clone 出來的位置，例如 `/builds/mygroup/awesome-project`
  - [Rename CI environment variables \(\#29053\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/29053) 將 `CI_BUILD_*` 更名，另外加入了 `CI_REGISTRY_USER = gitlab-ci-token` 及 `CI_REGISTRY_PASSWORD = $CI_JOB_TOKEN`。

## Merge Request ??

  - [Fast\-forward merge requests \| GitLab](https://docs.gitlab.com/ee/user/project/merge_requests/fast_forward_merge.html) #ril
      - Retain a linear Git history and a way to accept merge requests without creating merge commits. 這話說得真好!
      - `git merge` 搭配 `--ff-only` 時，符合 "the merge can be resolved as a fast-forward" 的條件才能 merge，這時候使用者可以選擇 rebase。
      - Use cases 提到，當 workflow policy 要求 clean commit history 時，fast-forward merge 就是最佳選項；Settings > Merge request > Merge method > Fast-forward merge (預設是 Merge commit)。

## Makefile

`.gitlab-ci.yml`:

```
deploy:
  stage: deploy
  image: python:3.6.4
  script: make deploy-ci
```

對應 `Makefile`：

```
deploy-ci
	pip install awscli
	aws s3 sync dist/ s3://my-bucket
```

要如何在 local 測試呢? 在 local 用相同的 image 執行相同的 make，這不就是 CI 在做的事：

```
deploy:
	docker run --rm --interactive --tty \
		--volume $(WORKSPACE):/workspace \
		--workdir /workspace \
		--env AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) \
		--env AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) \
		python:3.6.4 make deploy-ci
```

而且 `--env` 清楚表明了需要哪些環境變數。

  - 覺得 build script 儘量寫書 `Makefile` 由，才方便在 client 端試東西。
  - 以 [GitLab CI: Deployment & Environments \| GitLab](https://about.gitlab.com/2016/08/26/ci-deployment-and-environments/) 為例，`image: python:latest` 好，還是 `make deploy` 裡用 `docker run` 透過另一個 docker container 執行好?
  - [Using Docker\-in\-Docker for your CI or testing environment? Think twice\.](http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/) (2015-09-03) 不建議用 dind #ril

## AWS

  - [GitLab CI: Deployment & Environments \| GitLab](https://about.gitlab.com/2016/08/26/ci-deployment-and-environments/) (2016-08-26) 把 `AWS_*` 的設定從 `variables:` (也會變成環境變數) 搬到 Settings > CI/CD > Secret variables，接連談到 teamwork 1 & 2，staging 送到 pages 而 master 才送到 S3 (用 `python:latest` 及 `ppi install awscli` 安裝 AWS CLI)，Rollback (按一個鈕就跑上一個 job 重 build??)、手動模式 `when: manual`、Review Apps (對 static website 而言是按 branch name 切 S3 上的子資料夾) #ril

## Container Registry ??

  - [GitLab Container Registry \| GitLab](https://about.gitlab.com/2016/05/23/gitlab-container-registry/) (2016-05-23) #ril
  - [Using the GitLab Container Registry - Using Docker Build \- GitLab Documentation](https://docs.gitlab.com/ce/ci/docker/using_docker_build.html#using-the-gitlab-container-registry) #ril
  - [docker \- What is the special gitlab\-ci\-token user? \- Stack Overflow](https://stackoverflow.com/questions/37468084/) 官方文件找不到 `gitlab-ci-token` 的說明 #ril
  - [New CI job permissions model \| GitLab](https://docs.gitlab.com/ee/user/project/new_ci_build_permissions_model.html#container-registry) 提到 `gitlab-ci-token`，但沒有加以說明 #ril

## Runner、Executor ??

  - [GitLab Runner \- GitLab Documentation](https://docs.gitlab.com/runner/) #ril
      - GitLab Runner 是個 open source project，可以同時執行多個 GitLab CI 交付的 job，並將結果傳回 GitLab。
      - GitLab Runner 只有單一個 binary (用 Go 開發)，沒有其他相依性，可以執行在 GNU/Linux、macOS 及 Windows。
      - 除了可以將 job 執行在 local (就是 shell executor)，也可以執行在透過 SSH 連線的機器，支援各種 Docker container 的用法 -- over SSH、cloud、Kubernetes 等，甚至還有 Paralles、VirtualBox 等 VM 方案。
      - GitLab Runner 跟 GitLab CI 間是走 GitLab API，所以兩方的版本要配合好；參考 Compatibility chart
  - [Executors \| GitLab](https://docs.gitlab.com/runner/executors/) #ril
      - GitLab Runner 實作了許多 executor，推薦用 Docker，從 Compatibility chart 看來支援度比較完整的剩 Docker 與 Kubernetes
  - `gitlab-runner register` 提示 `Please enter the executor: kubernetes, docker, shell, ssh, docker+machine, docker-ssh, parallels, virtualbox, docker-ssh+machine:`。
  - [Configuring GitLab Runners \- GitLab Documentation](https://docs.gitlab.com/ce/ci/runners/README.html) #ril
  - Runner 跟 GitLab 串接，但真正執行的環境由 executor 決定。

## Group Runners ??

  - 在某個 (group) project 的 CI / CD Settings > Runners settings 看到 Group Runners -- GitLab Group Runners can execute code for all the projects in this group. 可以到 Group > CI / CD Settings > Runners settings 下新增 group runner。

## `gitlab-runner` 的用法??

  - `gitlab-runner help` 列出好多 command。
  - [GitLab Runner Commands \- GitLab Documentation](https://docs.gitlab.com/runner/commands/README.html) #ril

## 什麼是 Variable??

  - [GitLab CI/CD Variables \- GitLab Documentation](https://docs.gitlab.com/ee/ci/variables/) #ril

## CD 支援 testing、staging、production 逐步上線??

  - [Introduction to environments and deployments \- GitLab Documentation](https://docs.gitlab.com/ee/ci/environments.html) 可以追蹤 deployment? #ril

## 什麼是 Review App??

  - [GitLab Continuous Integration \(GitLab CI\) \- GitLab Documentation](https://docs.gitlab.com/ce/ci/) CD Pipeline 第一個就是 Review，大概是下面在講的 Review Apps
  - [Getting started with Review Apps \- GitLab Documentation](https://docs.gitlab.com/ce/ci/review_apps/index.html) #ril
  - [Introducing Review Apps \| GitLab](https://about.gitlab.com/2016/11/22/introducing-review-apps/) (2016-11-22) #ril

## 如何揭露 build 的狀態??

  - Settings > General pipelines settings 下有 Pipeline status 與 Coverage report，提供有 Markdown/HTML/AsciiDoc 不同的 code snippet，貼到文件上就會看到 badge。

## 如何使用 Shared Runner??

  - 預設專案是可以用 shared runner 的，但只會跑在有 job 描述 tag 的 runner 上。

## 安裝設置 {: #setup }

### 安裝 & 註冊 Runner ??

  - [Install GitLab Runner - GitLab Runner \| GitLab](https://docs.gitlab.com/runner/#install-gitlab-runner) Debian/Ubuntu/CentOS/RedHat 推薦用 GitLab 自己的 repository 安裝。
  - [Install GitLab Runner \- GitLab Documentation](http://docs.gitlab.com/runner/install/index.html) #ril
  - [Configuring GitLab Runners \- GitLab Documentation](https://docs.gitlab.com/ce/ci/runners/README.html) Shared runner 只能由 admin 來做，而 specific runner 則從專案 Settings > CI/CD > Runners settings 設定 #ril
  - Settings > CI/CD > Runners settings 只說 "Specify the following URL during the Runner setup:" 與 "Use the following registration token during setup:" (然後才是 start)，但沒有講如何指定?
  - [Registering Runners \- GitLab Documentation](http://docs.gitlab.com/runner/register/) 都是執行 `gitlab-runner register` 提供 GitLab instance URL、registration token、description、tag、是否綁定 (lock) 目前的 project (由 token 對應)，最後選 executor - docker-ssh, parallels, shell, ssh, docker-ssh+machine, docker, virtualbox, docker+machie, kubernetes #ril
  - 為什麼 `gitlab-runner start` (exit 0)，再用 `gitlab-runner status` 查詢總會得到 "Service is not running."?? 但同時間用 `gitlab-runner verify` 又說是 alive；但用 `gitlab-runner run` 就真的可以執行。

### 安裝 GitLab Runner (Linux) ??

  - [Install GitLab Runner using the official GitLab repositories \| GitLab](https://docs.gitlab.com/runner/install/linux-repository.html) #ril
  - [Install GitLab Runner manually on GNU/Linux \| GitLab](https://docs.gitlab.com/runner/install/linux-manually.html) 還是得裝成 service? 後來發現用 `gitlab-runner run` 就可以跑在 user mode，不一定要執行 `gitlab-runner start` 執行在 system mode #ril

### 在 Mac 上安裝 & 註冊 Runner?

將最新版的 `gitlab-runner` 直接下載到 `/usr/local/bin/gitlab-runner`：

```
$ sudo curl --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-darwin-amd64
$ sudo chmod +x /usr/local/bin/gitlab-runner
```

接著將它註冊為 service (`LaunchAgents`)，就可以啟動：

```
$ gitlab-runner install # ~/Library/LaunchAgents/gitlab-runner.plist
$ gitlab-runner start
```

之後要昇級，只要重新下載 `gitlab-runner` 即可，但要先停用 service (`gitlab-runner stop`)。

參考資料：

  - [Install GitLab Runner on macOS \- GitLab Documentation](http://docs.gitlab.com/runner/install/osx.html) 未來可以用 Homebrew 裝，但目前只能手動。透過 `LaunchAgents` 而非 `LaunchDaemons` 是為了 UI interaction?? 例如 iOS simulator ... 感覺裝 user 家目錄下也可以?
  - 發現 `gitlab-runner.plist` 裡面設定的 working directory 是執行 `gitlab-runner install` 時所在的目錄，設定檔則指向 `~/.gitlab-runner/config.toml`。

### 如何用 Docker 安裝 & 註冊 Runner??

  - [Run GitLab Runner in a container \- GitLab Documentation](http://docs.gitlab.com/runner/install/docker.html) 用 `gitlab/gitlab-runner:latest` image #ril
  - [Docker - Registering Runners \- GitLab Documentation](http://docs.gitlab.com/runner/register/#docker) 假設 container 名稱是 `gitlab-runner` #ril
  - [Install and configure GitLab Runner for autoscaling \- GitLab Documentation](http://docs.gitlab.com/runner/install/autoscaling.html) #ril
  - [Run GitLab Runner on a Kubernetes cluster \- GitLab Documentation](http://docs.gitlab.com/runner/install/kubernetes.html) 也是用 docker image? #ril

## 參考資料 {: #reference }

更多：

  - [`.gitlab-ci.yml`](gitlab-ci-yaml.md)

手冊：

  - [GitLab CI/CD Variables - GitLab Documentation](https://docs.gitlab.com/ee/ci/variables/README.html)
  - [Configuration of your jobs with .gitlab-ci.yml - GitLab Documentation](https://docs.gitlab.com/ee/ci/yaml/README.html)
  - [GitLab Runner Commands - GitLab Documentation](https://docs.gitlab.com/runner/commands/README.html)

