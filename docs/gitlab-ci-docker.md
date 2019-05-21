---
title: GitLab CI/CD / Docker
---
# [GitLab CI/CD](gitlab-ci.md) / Docker

## Hello, World! ??

  - [Building Docker images with GitLab CI/CD \| GitLab](https://docs.gitlab.com/ee/ci/docker/using_docker_build.html) #ril

## Docker

  - [Building Docker images with GitLab CI/CD \| GitLab](https://docs.gitlab.com/ee/ci/docker/using_docker_build.html) #ril
      - 目前 CI/CD 的趨勢是先建立 application image、針對該 image 做測試、把 image 推到 remote registry，最後從拿推上去的 image 直接佈署；這裡有個範例 `docker build -t my-image dockerfiles/` -> `docker run my-docker-image /script/to/run/tests` (test code 是放 image 裡??) -> `docker tag my-image my-registry:5000/my-image` -> `docker push my-registry:5000/my-image`，注意 image 通過測試後才加上另一個 tag。
      - GitLab CI 支援用 Docker Engine 去 build & test docker-based project，也就是 script 可以調用得到 `docker` 或其他 docker-enabled tools (例如 `docker-compose)。用 shell executor 是一個方式 (加裝 Docker)，但採用 docker-in-docker (dind) executor (priviledge mode) 是比較建議的 -- 其實是 docker executor + dind image，因為 `--docker-image` 只是預設的 image，若選用的 image 非 dind，還是調用不到 `docker` 指令。
      - 要在 job 裡執行 `docker build/run` 有 3 種方法 -- shell executor、docker-in-docker executor、使用 Docker socket binding。
      - Use shell executor 的執行身份是 `gitlab-runner`，將它加到可以存取 Docker 的 group (`docker`) 即可。
  - [Setting up GitLab Runner For Continuous Integration \| GitLab](https://about.gitlab.com/2016/03/01/gitlab-runner-with-docker/) (2016-03-01) #ril
      - GitLab runner 在 register 的過程中會被問 Please enter the default Docker image，預設值就是 `ruby:2.1`，而 "Note that the default Docker image specified here will be used only when .gitlab-ci.yml file does not contain an image declaration" 清楚說明了 `image:` 與 `--docker-image` (default) 的關係。
      - 實驗發現 `gitlab register --docker-image` 所描述的 image 只有在 `.gitlab-ci.yml` 沒有自訂 `image:` 時才會作用，也就是預設的 image，可以從 job log 一開頭的 "Using Docker executor with image XXX ..." 及 "Using docker image XXX ID=sha256:... for build container..." 識別出來。
  - [Using Docker images \| GitLab](https://docs.gitlab.com/ee/ci/docker/using_docker_images.html) #ril
      - 原來 job 就是獨立執行，加上 Docker 就變成在獨立的 container 執行，讓 build environment 更為 reproducible。
      - `image` 指定 docker exectutor 要採用哪個 image 來執行 job。
      - `services` 宣告 job 執行過程中要連結的其他 container (透過 hostname 存取)；雖然 Extended Docker configuration options 能擴充的點不多，但 Configuring services 提到可以透過環境變數來組態這些 service #ril
  - [Register Docker Runner - Using Docker images \- GitLab Documentation](https://docs.gitlab.com/ce/ci/docker/using_docker_images.html#register-docker-runner) 出現 `--docker-image ruby:2.1` 的用法，但 `ruby:2.1` 裡並沒有 `docker` 指令。
  - [Run GitLab Runner in a container \- GitLab Documentation](https://docs.gitlab.com/runner/install/docker.html) 跟 docker executor 不同?。
  - [DinD \- Cannot connect to the Docker daemon\. Is the docker daemon running on this host? \(\#1986\) · Issues · GitLab\.org / gitlab\-runner · GitLab](https://gitlab.com/gitlab-org/gitlab-runner/issues/1986) Alexander Herold: 建立 `/var/run/docker.sock:/var/run/docker.sock` 的 mapping，但 Michael Potthoff: 問題在 `DOCKER_DRIVER: overlay` 因為沒這個 module，安裝 module 或拿掉這一行就可以了 (`privileged` 要設為 `true`)，根本不用加 `/var/run/docker.sock:/var/run/docker.sock` #ril

## DinD ??

  - [Use docker-in-docker executor - Building Docker images with GitLab CI/CD \| GitLab](https://docs.gitlab.com/ee/ci/docker/using_docker_build.html#use-docker-in-docker-executor) #ril
      - The second approach is to use the special docker-in-docker (dind) Docker image with all tools installed (docker and docker-compose) and run the job script in context of that image in privileged mode. 這句話應該有誤? 基本上是搭配兩個 image，一個是 service container (`docker:dind`) 提供 Docker daemon，另一個是 build/job/runner container (`docker:stable`) 做為 job script 的執行環境。而且 `docker:dind` 跟 `docker:stable` 裡都找一到 `docker-compose`??
      - 註冊 runner 時採 `--executor docker`、`--docker-image "docker:stable"` (Docker image to be used)、`--docker-privileged` (Give extended privileges to container)。感覺所有包話 service container (`docker:dind`) 也會執行在 priviledged mode，雖然官方 DinD 的說法，只有 `docker:dind` 要...
      - 使用 dind 時，每個 job 都執行在乾淨的環境下，concurrent jobs 間不會互相干擾，但由於沒有 caching of layers 的關係，速度會較慢。
      - Since the `docker:dind` container and the runner container DON'T SHARE THEIR ROOT FILESYSTEM, the job's WORKING DIRECTORY can be used as a mount point for children containers. 搭配 `/builds/$CI_PROJECT_PATH` (用 `$CI_PROJECT_DIR` 更好) 就可以把 working directory 的內容以 bind mount 的方式掛進 child container；這裡沒講清楚的是，也只有 `$CI_PROJECT_DIR` 底下的東西才能掛進 child container。
  - [Docker volumes not mounted when using docker:dind \(\#41227\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/41227) 上面的 Use docker-in-docker executor - Building Docker images with GitLab CI/CD 提到這份文件 -- for a more thorough explanation, check issue #41227 重點都在 Tomasz Maczukin 的答覆
      - Because each container by default is separated from other containers, the / filesystem in context of every one is also separated. Only volume mounts can be shared with HOST or with other container. Runner is creating few volumes (for cache, for job, defined in config.toml). For the purpose of this issue let's consider only the /builds volume. 這段話是關鍵，HOST (執行 GitLab Runner 的地方) 上面有個 `builds` volume，會掛進所有 container 的 `/builds` 下，所以只能先把資料放進 `/builds` 底下，再叫 Docker daemon 掛進 child container。
      - When you're executing `docker run -v /mnt:/mnt ubuntu ls /mnt` you're instructing Docker Engine inside of `docker:dind` service to start a new, internal container and mount the local `/mnt/` directory under containers `/mnt/` directory. The important thing is that local `/mnt` directory is local in context of `docker:dind` service. 因為 Docker daemon 會以自己的角度解讀 `-v host_path:container_path` 中的 `host_path`。
  - [Build directory in service - The Docker executor \| GitLab](https://docs.gitlab.com/runner/executors/docker.html#build-directory-in-service)
      - GitLab Runner 1.5 開始，會把 `/builds` 掛進所有的 shared services。
      - [Mount volume with code from repository in services \(\#1520\) · Issues · GitLab\.org / gitlab\-runner · GitLab](https://gitlab.com/gitlab-org/gitlab-runner/issues/1520) 原來掛進 service 的說法並不正確，範例 `docker run ... -v $(pwd):/tests` 是想把 working directory 的 test code 掛進去 `ruby:2.2` 執行，而非 service (`docker:1.11-dind`)，不過 Tomasz Maczukin 跳出來說，這個問題早就解決，!272 是額外將 `/builds/my/project/` 掛進其他 service -- 這也包括 `docker:dind` service container?
  - [continuous integration \- Role of docker\-in\-docker \(dind\) service in gitlab ci \- Stack Overflow](https://stackoverflow.com/questions/47280922/)
      - 為什麼同時需要 service (`docker:dind`) 與 docker image (`docker:latest`)?
      - saraedum: `docker:latest` 與 `docker:dind` 的內容很像，只不過 `docker:dind` 的 entrypoint 會啟動 Docker daemon，而 `docker:latest` (或 `docker:stable`) 的 entrypoint 會先組態往 `tcp://docker::2375` 找 Docker daemon。寫 `service: docker:dind` 就不需要在 `before_script` 啟動 `dockerd`。
  - [library/docker \- Docker Hub](https://hub.docker.com/_/docker/) 觀察 `docker:dind` 與 `docker:stable` 的 `Dockerfile`，前者 `docker:dind` 的 entrypoint 會啟動 docker daemon 在 2375 port 服務，而後者 `docker:stable` 的 entrypoint 會先做 `export DOCKER_HOST='tcp://docker:2375'` 再執行 command，也因此有搭配 `--link dind-container:docker` 的話，在 `docker:stable` 內需要用到 Docker daemon 時，就會找 `tcp://docker:2375`。

## 在 DinD 裡無法用 Bind Mount 將 Container 裡的檔案掛進另一層 Container ??

`.gitlab-ci.yml`:

```
image: docker:stable
variables:
  CI_DEBUG_TRACE: "true"
  MY_IMAGE: "nginx:1.15.0"

stages:
  - test

test:
  stage: test
  tags:
    - dind
  script:
    - echo 'settings (generated dynamically)' > settings.cfg
    - docker run --rm -v $CI_PROJECT_DIR/settings.cfg:/workspace/settings.cfg $MY_IMAGE cat /workspace/settings.cfg
```

加上下面的宣告就沒問題了：

```
services:
  - docker:dind
```

  - [Docker volumes not mounted when using docker:dind \(\#41227\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/41227) 有討論到 `docker:dind` 的作用? #ril

## Docker Compose {: #docker-compose }

要在 `docker:stable` (Alpine) 下安裝 Docker Compose 其實[不太容易](https://wiki.alpinelinux.org/wiki/Docker#Docker_Compose)，最簡單的方法就是直接利用官方提供的 `docker/compose`。

不過 `docker/compose` 的設定跟 `docker:stable` 不太一樣，要做些調整才能取代 `docker:stable`：

  - `docker/compose` 的 entrypoint 是 `docker-compose`，要改成 `/bin/sh -c`。
  - `docker/compose` 不像 `docker:stable` 的 entrypoint 會自動加上 `DOCKER_HOST='tcp://docker:2375'` 的設定，會有檔案掛不進下一層 container 的問題。

所以使用 `docker/compose` 時，必要的配置會像是：

```
image:
  name: docker/compose:1.24.0
  entrypoint: ["/bin/sh", "-c"]

services:
  - docker:dind

variables:
  DOCKER_HOST: tcp://docker:2375
  DOCKER_DRIVER: overlay2
```

---

參考資料：

  - [Run docker\-compose build in \.gitlab\-ci\.yml \- Stack Overflow](https://stackoverflow.com/questions/39868369)

      - webmaster777: Docker compose also has an official image: `docker/compose`

        This is the ideal solution if you don't want to install it every pipeline. It has currently no latest tag, so you'll have to update manually.

        Since the image uses `docker-compose` as entrypoint you'll need to override the entrypoint back to /`bin/sh -c` in your `.gitlab-ci.yml`. Otherwise your pipeline will fail with `No such command: sh`

            # Official docker compose image.
            image:
              name: docker/compose:1.22.0 # update tag to whatever version you want to use.
              entrypoint: ["/bin/sh", "-c"]

            services:
              - docker:dind

            before_script:
              - docker version
              - docker-compose version

            build:
              stage: build
              script:
                - docker-compose down
                - docker-compose build
                - docker-compose up tester-image

  - [Use docker-in-docker executor - Building Docker images with GitLab CI/CD \| GitLab](https://docs.gitlab.com/ee/ci/docker/using_docker_build.html#use-docker-in-docker-executor) #ril

         image: docker:stable

         variables:
           # When using dind service we need to instruct docker, to talk with the
           # daemon started inside of the service. The daemon is available with
           # a network connection instead of the default /var/run/docker.sock socket.
           #
           # The 'docker' hostname is the alias of the service container as described at
           # https://docs.gitlab.com/ee/ci/docker/using_docker_images.html#accessing-the-services
           #
           # Note that if you're using Kubernetes executor, the variable should be set to
           # tcp://localhost:2375 because of how Kubernetes executor connects services
           # to the job container
           DOCKER_HOST: tcp://docker:2375/
           # When using dind, it's wise to use the overlayfs driver for
           # improved performance.
           DOCKER_DRIVER: overlay2

         services:
           - docker:dind

