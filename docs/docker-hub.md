# Docker Hub

  - [Docker Hub](https://hub.docker.com/) #ril
      - Build and Ship any Application Anywhere - Docker Hub is the world's easiest way to create, manage, and deliver your teams' container applications.
      - Docker Hub is the world's largest library and community for container images 為什麼要強調這些，感覺市場上有競爭者... 但為什麼 Docker Hub 要擔心其他替代方案? => 有 private repos 的收費方案。
      - Docker Certified: Trusted & Supported Products 提到 Certified Plugins for networking and volumes in containers. 及 Certified Infrastructure delivers an optimized and validated Docker platform for enterprise OS and Cloud Providers. 原來不只提供 image，其中 infra [提供 Docker 的執行環境](https://hub.docker.com/search/?type=edition&offering=community)，例如 Docker Desktop (Mac/Windows)、Docker Engine 等。
      - The perfect home for your teams' applications. 提到 Create and manage users and GRANT ACCESS to your repositories. 看起來 repository 不一定要公開，但如果是非公開的 image，會不會放公司內部 GitLab CI registry 比較好?

  - [Billing - Docker Hub](https://cloud.docker.com/billing) 提示 "0 OF 1 FREE PRIVATE REPOSITORY IN USE Purchase plans starting at $7/ month for 5 private repositories" 原來有提供 private repos，但只免費提供 1 個。

  - [Hosted Docker Registry \| Deploy Docker Container \| Rancher \| Rancher Labs](https://rancher.com/comparing-four-hosted-docker-registries/) (2018-12-10) #ril

## 新手上路 ?? {: #getting-started }

  - [Docker Hub Quickstart \| Docker Documentation](https://docs.docker.com/docker-hub/) #ril
      - Docker Hub is a service provided by Docker for finding and sharing container images with your team. It provides the following major features:
          - Repositories: Push and pull container images.
          - Teams & Organizations: Manage access to private repositories of container images.
          - Official Images: Pull and use high-quality container images provided by Docker.
          - Publisher Images: Pull and use high-quality container images provided by EXTERNAL VENDORS. CERTIFIED images also include support and guarantee compatibility with Docker Enterprise. 原來 official/publisher 是以 Docker 官方的角度在看，offical 是 Docker 自己而非 container application 的開發者；Docker 官方產生的 image 沒有 certified 與否的問題。
          - Builds: Automatically build container images from GitHub and Bitbucket and push them to Docker Hub 感覺 Docker Hub 可以做為 image-based project 的 CI server?? 相較於 Travis CI 的優點是什麼? 自動拿 `README.md` 來當 full description??
          - Webhooks: Trigger actions after a successful push to a repository to integrate Docker Hub with other services. 有新的 image 放進 repository 時要觸發其他 service。
      - Step 1: Sign up for Docker Hub --> Step 2: Create your first repository --> Step 3: Download and install Docker Desktop --> Step 4: Build and push a container image to Docker Hub from your computer 也就是一個 account 下可以有多個 repository，最後產出的 image 就是推進某個 repository。幾個比較重要的步驟有：
          - Open the terminal and sign in to Docker Hub on your computer by running `docker login` 預設登入 Docker Hub 這個 registry
          - Run `docker build -t <your_username>/my-first-repo`. to build your Docker image
          - Test your docker image locally by running `docker run <your_username>/my-first-repo` (tag 採用預設的 `latest`)
          - Run `docker push <your_username>/my-first-repo` to push your Docker image to Docker Hub

  - 由 [docker\-library](https://github.com/docker-library) 及 [nginxinc/docker\-nginx](https://github.com/nginxinc/docker-nginx/) 的命名看來，若 `Dockerfile` 沒有跟 application source 在一起的話，repo 習慣上會命名為 `docker-xxx`。

## Automated Build ??

  - [Set up Automated builds \| Docker Documentation](https://docs.docker.com/docker-hub/builds/) #ril
      - Docker Hub can automatically build images from source code in an external repository and automatically push the built image to your Docker repositories.
      - When you set up automated builds (also called autobuilds), you create a list of BRANCHES and TAGS that you want to build into Docker images. When you push code to a source code branch (for example in GitHub) for one of those listed image tags, the push uses a webhook to trigger a new build, which produces a Docker image. The built image is then pushed to the Docker Hub registry. 這裡的 webhook 指的是 GitHub --> Docker Hub，由 Docker Hub 產生 image；好奇 tag 要怎麼事先列? => 有支援 pattern
      - If you have automated tests configured, these run after building but before pushing to the registry. You can use these tests to create a CONTINUOUS INTEGRATION WORKFLOW where a build that fails its tests does not push the built image. Automated tests do not push images to the registry on their own. 意謂著 test code 會包進 image 裡??
      - You can configure repositories in Docker Hub so that they automatically build an image each time you push new code to your SOURCE PROVIDER. If you have automated tests configured, the new image is only pushed when the tests succeed.

## Travis CI Integration ??

  - [Managing Open\-Source Docker Images on Docker Hub using Travis](https://medium.com/vaidikkapoor/managing-open-source-docker-images-on-docker-hub-using-travis-7fd33bc96d65) (2018-07-09) #ril
  - [Pushing Docker images right from Travis\-CI \| OpsTips](https://ops.tips/blog/travis-ci-push-docker-image/) (2017-11-24) #ril

## 參考資料

  - [Docker Hub](https://hub.docker.com/)
