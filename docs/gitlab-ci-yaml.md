---
title: GitLab CI / .gitlab-ci.yml
---
# [GitLab CI](gitlab-ci.md) / .gitlab-ci.yml

## `.gitlab-ci.yml` ??

手刻 `.gitlab-ci.yml` 的方式，一開始先把 `stages` 列出來，然後逐 job 寫出來，job 一開始宣告 `stage` (什麼時候跑)、`only`/`except` (針對哪些 change)，然後 `tags` (跑在哪裡)、`image`、`script` (要做什麼)，最後才是 `artifacts` 蒐集產出物。例如：

```
image: docker:stable
stages:
  - build
  - deploy

build:
  stage: build
  tags:
    - docker
  script:
    - apk add --no-cache make
    - make build
  artifacts:
    paths:
      - dist/

deploy:
  stage: deploy
  tags:
    - docker
  only:
    - master
  script:
    - apk add --no-cache make
    - make deploy
```

參考資料：

  - [Introduction - Configuration of your jobs with \.gitlab\-ci\.yml \- GitLab Documentation](https://docs.gitlab.com/ee/ci/yaml/README.html)

      - GitLab CI/CD pipelines are configured using a YAML file called `.gitlab-ci.yml` within each project.

        The `.gitlab-ci.yml` file defines the structure and order of the PIPELINES and determines:

          - What to execute using GitLab Runner.
          - What decisions to make when specific CONDITIONS are encountered. For example, when a process succeeds or fails.

      - This topic covers CI/CD pipeline configuration. For other CI/CD configuration information, see:

          - GitLab CI/CD Variables, for configuring the environment the pipelines run in.
          - GitLab Runner advanced configuration, for configuring GitLab Runner.

      - We have complete examples of configuring pipelines:

          - For a quick introduction to GitLab CI, follow our [quick start guide](https://docs.gitlab.com/ee/ci/quick_start/README.html). #ril
          - For a collection of examples, see [GitLab CI/CD Examples](https://docs.gitlab.com/ee/ci/examples/README.html). #ril

          - To see a large .gitlab-ci.yml file used in an enterprise, see the [`.gitlab-ci.yml` file for gitlab](https://gitlab.com/gitlab-org/gitlab/blob/master/.gitlab-ci.yml).

            把 `.gitlab-ci.yml` 搞這麼大，有什麼好自豪的?

      - Note: If you have a mirrored repository where GitLab pulls from, you may need to enable pipeline triggering in your project’s Settings > Repository > Pull from a remote repository > Trigger pipelines for mirror updates.

        有機會做到程式碼在其他地方，但額外自訂 `.gitlab-ci.yml` 嗎 ??

    Introduction

      - Pipeline configuration begins with JOBS. Jobs are the most fundamental element of a `.gitlab-ci.yml` file.

        Jobs are:

          - Defined with CONSTRAINTS stating under what CONDITIONS they should be executed.

          - Top-level elements with an arbitrary name and must contain at least the `script` clause.

            這裡 arbitrary name 的說法言過其實，下面 Unavailable names for jobs 馬上列出一堆不能用的名字。

          - Not limited in how many can be defined.

        For example:

            job1:
              script: "execute-script-for-job1"

            job2:
              script: "execute-script-for-job2"

      - The above example is the simplest possible CI/CD configuration with two separate jobs, where each of the jobs executes a different command. Of course a command can execute code directly (`./configure;make;make install`) or run a script (`test.sh`) in the repository.

      - Jobs are PICKED UP BY RUNNERS and executed within the environment of the Runner. What is important, is that each job is RUN INDEPENDENTLY FROM EACH OTHER.

    Validate the `.gitlab-ci.yml`

      - Each instance of GitLab CI has an embedded debug tool called Lint, which validates the content of your `.gitlab-ci.yml` files. You can find the Lint under the page `ci/lint` of your PROJECT NAMESPACE. For example, `https://gitlab.example.com/gitlab-org/project-123/-/ci/lint`.

        這太難記了 `-/ci/lint`，在 Project > CI/CD 右上角可以看到 CI Lint 的按鈕。

    Unavailable names for jobs

      - Each job must have a unique name, but there are a few RESERVED KEYWORDS that cannot be used as job names:

          - `image`
          - `services`
          - `stages`
          - `types`
          - `before_script`
          - `after_script`
          - `variables`
          - `cache`
          - `include`

        少列了 `default` ?

    Using reserved keywords

      - If you get validation error when using specific values (for example, `true` or `false`), try to:

          - Quote them.
          - Change them to a different form. For example, `/bin/true`.

    Configuration parameters

      - A job is defined as a LIST OF PARAMETERS that define the job’s BEHAVIOR.

        The following table lists available parameters for jobs:

        所謂 "for jobs" 並非這些 parameter 都會出現在 job 下，而是都跟 job 的行為有關，所以才會看到 `stages`、`services` 等 top-level element 的說明。

          - `script`

            Shell script which is executed by Runner.

          - `image`

            Use docker images. Also available: `image:name` and `image:entrypoint`.

          - `services`

            Use docker services images. Also available: `services:name`, `services:alias`, `services:entrypoint`, and `services:command`.

          - `before_script`

            Override a set of commands that are executed before job.

          - `after_script`

            Override a set of commands that are executed after job.

          - `stages`

            Define stages in a pipeline.

          - `stage`

            Defines a job stage (default: `test`).

          - `only`

            Limit when jobs are CREATED. Also available: `only:refs`, `only:kubernetes`, `only:variables`, and `only:changes`.

            對照下面 `when` (when to run job)，這裡的 create 指的是什麼 ??

          - `except`

            Limit when jobs are not created. Also available: `except:refs`, `except:kubernetes`, `except:variables`, and `except:changes`.

          - `rules`

            List of conditions to evaluate and determine SELECTED ATTRIBUTES of a job, and whether or not it is created. May not be used alongside `only`/`except`. ??

          - `tags`

            List of tags which are used to SELECT RUNNER.

          - `allow_failure`

            Allow job to fail. Failed job doesn’t CONTRIBUTE TO COMMIT STATUS. ??

          - `when`

            When to run job. Also available: `when:manual` and `when:delayed`.

          - `environment`

            Name of an environment to which the job DEPLOYS. Also available: `environment:name`, `environment:url`, `environment:on_stop`, and `environment:action`.

          - `cache`

            List of files that should be cached BETWEEN SUBSEQUENT RUNS. Also available: `cache:paths`, `cache:key`, `cache:untracked`, and `cache:policy`.

          - `artifacts`

            List of files and directories to ATTACH TO A JOB ON SUCCESS. Also available: `artifacts:paths`, `artifacts:expose_as`, `artifacts:name`, `artifacts:untracked`, `artifacts:when`, `artifacts:expire_in`, `artifacts:reports`, and `artifacts:reports:junit`.

            In GitLab Enterprise Edition, these are available: `artifacts:reports:codequality`, `artifacts:reports:sast`, `artifacts:reports:dependency_scanning`, `artifacts:reports:container_scanning`, `artifacts:reports:dast`, `artifacts:reports:license_management`, `artifacts:reports:performance` and `artifacts:reports:metrics`.

            原來 GitLab 支援這麼多 report，只是要 EE 才有。

          - `dependencies`

            RESTRICT which artifacts are passed to a specific job by providing a list of jobs to fetch artifacts from.

          - `coverage`

            Code coverage settings for a given job. ??

          - `retry`

            When and how many times a job can be auto-retried in case of a failure.

          - `timeout`

            Define a custom JOB-LEVEL timeout that takes precedence over the project-wide setting.

          - `parallel`

            How many instances of a job should be run in parallel. 跟測試有關 ??

          - `trigger`

            Defines a downstream pipeline trigger. ??

          - `include`

            Allows this job to include external YAML files. Also available: `include:local`, `include:file,` `include:template`, and `include:remote`.

          - `extends`

            Configuration entries that this job is going to inherit from.

          - `pages`

            Upload the result of a job to use with GitLab Pages.

          - `variables`

            Define job variables on a job level.

          - `interruptible`

            Defines if a job can be canceled when made redundant by a newer run. ??

    Setting default parameters

      - Some parameters can be set globally as the default for all jobs using the `default:` keyword. Default parameters can then be overridden by job-specific configuration.

        The following job parameters can be defined inside a `default:` block:

          - `image`
          - `services`
          - `before_script`
          - `after_script`
          - `tags`
          - `cache`
          - `artifacts`
          - `retry`
          - `timeout`
          - `interruptible`

      - In the following example, the `ruby:2.5` image is set as the default for all jobs except the `rspec 2.6` job, which uses the `ruby:2.6` image:

            default:
              image: ruby:2.5

            rspec:
              script: bundle exec rspec

            rspec 2.6:
              image: ruby:2.6
              script: bundle exec rspec

  - [Parameter details - GitLab CI/CD Pipeline Configuration Reference \| GitLab](https://docs.gitlab.com/ee/ci/yaml/README.html#parameter-details) #ril

      - GitLab 7.12 開始以 `.gitlab-ci.yml` 做為 project configuration，放在 repository 的 root，描述 "how to build" -- 一堆 jobs 及何時該執行的 constraints。Job 會被 runner 拿出來執行，而且每個 job 都是獨立執行的。
      - 所謂 job 是指 top-element，包含至少一個 `script` clause。但有些保留字不能做為 job name，包括 `image`、`servies`、`stages`、`before_script`、`after_script`、`variables` 及 `cache`；其中 `image` 跟 `services` 跟 Docker 有關。

  - [dependencies - Configuration of your jobs with \.gitlab\-ci\.yml \- GitLab Documentation](https://docs.gitlab.com/ee/ci/yaml/README.html#dependencies) 這裡 `build:osx:` 之類的 job name 好特別，而且 script 轉到對應的 make target，例如 `make build:osx` #ril
  - [Validate the \.gitlab\-ci\.yml \(API\) \| GitLab](https://docs.gitlab.com/ee/api/lint.html) 透過 API 有機會在本地端驗證 `.gitlab-ci.yml` 是否有語法上的錯誤 #ril
  - [Where is the gitlab\-ci\.yml lint tool? \(\#37338\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/37338) 說 lint tool 在 CI/CD Pipelines/Jobs 的右上方；實驗發現 Pipelines 右上方的 CI Lint 要有跑過 pipeline 才會出現，但 Jobs 右上方的則是專案一開始就會有。

## 參考資料 {: #reference }

  - [GitLab CI/CD Pipeline Configuration Reference](https://docs.gitlab.com/ee/ci/yaml/README.html)
