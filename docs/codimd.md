# CodiMD

  - [hackmdio/codimd: CodiMD \- Realtime collaborative markdown notes on all platforms\.](https://github.com/hackmdio/codimd)

      - CodiMD lets you collaborate in real-time with markdown. Built on HackMD source code, CodiMD lets you HOST and control your team's content with speed and ease.

    CodiMD - The Open Source HackMD

      - HackMD helps developers write better documents and build active communities with open collaboration. HackMD is built with one promise - You own and control all your content:

          - You should be able to easily download all your online content at once.
          - Your content formatting should be portable as well. (That's why we choose markdown.)
          - You should be able to control your content's presentation with HTML, slide mode, or BOOK MODE.

      - With the same promise of you owning your content, CodiMD is the free software version of HackMD, developed and opened source by the HackMD team with REDUCED FEATURES, so you can use CodiMD for your community and own your data. (See the origin of the name CodiMD.)

        少了哪些功能沒有說明 [Provide a feature matrix CodiMD vs HackMD · Issue \#1145 · hackmdio/codimd](https://github.com/hackmdio/codimd/issues/1145) #ril

      - CodiMD is perfect for open communities, while HackMD emphasizes on permission and access controls for COMMERCIAL USE CASES.

        HackMD team is committed to keep CodiMD open source. All contributions are welcome!

        從 [`codimd/LICENSE`](https://github.com/hackmdio/codimd/blob/develop/LICENSE) 有提到 "Commercial use"，是可以商用的。

  - [codimd/server: CodiMD \- Realtime collaborative markdown notes on all platforms\.](https://github.com/codimd/server) #ril

      - CodiMD lets you create real-time collaborative markdown notes. You can test-drive it by visiting our [CodiMD demo server](https://demo.codimd.org/).

      - It is inspired by Hackpad, Etherpad and similar collaborative editors. This project originated with the team at HackMD and NOW FORKED INTO ITS OWN ORGANISATION. A longer writeup can be read in the history doc.

  - [server/history\.md at master · codimd/server](https://github.com/codimd/server/blob/master/docs/history.md)

    It started with HackMD

      - HackMD is the origin of this project, which was mostly developed by Max Wu and Yukai Huang. Originally, this was open source under MIT license, but was relicensed in October 2017 to be AGPLv3. At the same time, hackmd.io was founded to offer a commercial version of HackMD.

      - The AGPLv3-version was developed and released by the community, this was for a while referred to as "HackMD community edition".

        For more on the splitting of the projects, please refer to [A note to our community](2017-10-11)(https://hackmd.io/c/community-news/https%3A%2F%2Fhackmd.io%2Fs%2Fr1_4j9_hZ).

        說明授權為何從 MIT 改為 AGPL 3.0，也就是 HackMD Community Edition (CE)，順勢也將推出 HackMD Enterprise Edition (EE)。

    HackMD CE became CodiMD

      - In June 2018, CodiMD was renamed from its former name "HackMD" and continued to be developed under AGPLv3 by the community. We decided to change the name to break the CONFUSION between HackMD (enterprise offering) and CodiMD (community project), as people mistook it for an OPEN CORE development model.

        不像 GitLab CE 與 EE 的關係。

        For the whole renaming story, see the [issue where the renaming was discussed](https://github.com/hackmdio/hackmd/issues/720).

    CodiMD went independent

      - In March 2019, a discussion over licensing, governance and the future of CodiMD lead to the formation of a distinct GitHub organization. Up to that point, the community project resided in the organization of hackmdio but was for the MOST PART SELF-ORGANIZED.

      - During that DEBATE, we did not reach an agreement that would have allowed us to MOVE THE REPOSITORY, so we simply forked it. We still welcome the HackMD team as part of our community, especially since a large portion of this code base originated with them.

        For the debate that lead to this step, please refer to the [governance debate](https://github.com/hackmdio/hackmd/issues/1170) and the [announcement of the new repository](https://github.com/codimd/server/issues/10). #ril

        未達成協議只是 fork 出來事小，問題是 CodiMD 搜尋的結果會跑出不少 demo.codimd.org 的資料，讓人搞不清楚要用哪一個。

  - [HackMD Community Announcement · Issue \#579 · hackmdio/codimd](https://github.com/hackmdio/codimd/issues/579) #ril
  - [Rename the project · Issue \#720 · hackmdio/codimd](https://github.com/hackmdio/codimd/issues/720) #ril
  - [Rebrand HackMD CE to CodiMD by SISheogorath · Pull Request \#850 · hackmdio/codimd](https://github.com/hackmdio/codimd/pull/850) #ril

## 安裝設定 {: #installation }

  - [Deployment - hackmdio/codimd: CodiMD \- Realtime collaborative markdown notes on all platforms\.](https://github.com/hackmdio/codimd#deployment)

    If you want to spin up an instance and start using immediately, see Docker deployment. If you want to contribute to the project, start with manual deployment.

  - [Installation / Upgrading - codimd/server: CodiMD \- Realtime collaborative markdown notes on all platforms\.](https://github.com/codimd/server#installation--upgrading) #ril

### Docker

  - [Docker Deployment \- HackMD](https://hackmd.io/c/codimd-documentation/%2Fs%2Fcodimd-docker-deployment)

    The easiest way to setup CodiMD using docker are using the following three commands:

        git clone https://github.com/hackmdio/docker-hackmd.git
        cd docker-hackmd
        docker-compose up

    Read more about it in the container repository.

    不是 Docker Hub 上沒有已包裝好的 image，而是 CodiMD 執行期要搭配 database，所以透過 Docker Compose 來執行。

  - [hackmdio/docker\-hackmd: docker hackmd image](https://github.com/hackmdio/docker-hackmd)

      - This repository has been archived by the owner. It is now read-only. ...

        XD 這什麼狀況 (2019-08-16)，文件說用 https://github.com/hackmdio/docker-hackmd，這已經 archive，也沒說替代方案是什麼。

      - [`docker-compose.yml`](https://github.com/hackmdio/docker-hackmd/blob/master/docker-compose.yml) 裡面用的 image 還是 `hackmdio/hackmd:1.2.0`
      - [hackmdio/hackmd \- Docker Hub](https://hub.docker.com/r/hackmdio/hackmd/) 但 Docker Hub 上的抬頭已經是 CodiMD

  - [hackmdio/hackmd \- Docker Hub](https://hub.docker.com/r/hackmdio/hackmd/) #ril

      - If you used the `docker-hackmd` repository before, migrating to [`codimd-container`](https://github.com/hackmdio/codimd-container) is easy.

        https://github.com/hackmdio/codimd-container 竟然轉向 https://github.com/codimd/container !! 然後 [`docker-compose.yml`](https://github.com/codimd/container/blob/master/docker-compose.yml) 裡面的 image 改用 `quay.io/codimd/server:1.5.0`

        雖然 Source Repository 還是指向 hackmdio/docker-hackmd

  - [codimd/container: CodiMD container image ressources](https://github.com/codimd/container) #ril

      - Debian based version: Main docker image based on Debian and used by default in the `docker-compose.yml`. Recommended for test and PRODUCTION DEPLOYMENTS.

      - Alpine based version: Minimal docker image based on Alpine can be used for EXPERT SETUPS. In order to prevent crashes due to dependency problems, this version comes WITHOUT PDF EXPORT.

    Get started

      - Install docker and docker-compose, "Docker for Windows" or "Docker for Mac"
      - Run `git clone https://github.com/codimd/container.git codimd-container`
      - Change to the directory `codimd-container` directory
      - Run `docker-compose up` in your terminal
      - Wait until see the log `HTTP Server listening at port 3000`, it will take few minutes based on your internet connection.
      - Open http://127.0.0.1:3000

## 參考資料 {: #reference }

  - [hackmdio/codimd - GitHub](https://github.com/hackmdio/codimd)
  - [codimd/server - GitHub](https://github.com/codimd/server)

文件：

  - [CodiMD Documentation - HackMD](https://hackmd.io/c/codimd-documentation/)

