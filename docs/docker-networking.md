---
title: Docker / Networking
---
# [Docker](docker.md) / Networking

  - [Overview \| Docker Documentation](https://docs.docker.com/network/) Docker container/service 的威力在於它們可以連結在一起，甚至也可以連結 non-Docker workloads (工作量)，而且彼此都不需要知道對方是不是 Docker workload。
  - [Container networking \| Docker Documentation](https://docs.docker.com/config/containers/container-networking/) #ril
  - [Docker container networking \| Docker Documentation](https://docs.docker.com/v17.09/engine/userguide/networking/) #ril

## Network Driver

  - [Network drivers - Overview \| Docker Documentation](https://docs.docker.com/network/#network-drivers)
      - Networking subsystem 設計成 pluggable，可以搭配不同的 driver，內建的 driver 有 Bridge (`bridge`)、Host (`host`)、None (`none`)、Overlay 及 Macvlan (括號裡是內建的 network name)，還可以安裝其他 network plugin 擴充。
      - Bridge: 預設的 network driver，用於 application 有多個 standalone container，但其間需要 (直接) 溝通時。User-defined bridge networks are best when you need multiple containers to communicate ON THE SAME DOCKER HOST. 唯一的限制就是要在同一個 Docker host 下。
      - Host: 拿掉 container 與 host 間的 network isolation，直接走 host's networking，只能用在 swarm services。Host networks are best when the network stack should not be isolated from the Docker host, but you want other aspects of the container to be isolated. 只是網路沒隔開而已。
      - Overlay: 連結多個 Docker daemon 使 swarm services 可以相互溝通；也可以用來串接 swarm service 與 standalone container，或是不同 Docker daemon 的 standalone container。好處是可以避開 OS-level routing。相對於 `bridge` 而言，差別在於不同 Docker host。
      - Macvlan: 可以為 container 指定 MAC address，使在網路上像個 physical device，通常用於 legacy application (預期直接連到 physical network)。Macvlan networks are best when you are MIGRATING FROM A VM SETUP or need your containers to look like physical hosts on your network, each with a unique MAC address.
  - [EXPOSE - Dockerfile reference | Docker Documentation](https://docs.docker.com/engine/reference/builder/#expose) 最後提到 `docker network` 可以建立一個讓 container 相互溝通的 network (透過任何 port)，不需要 expose/publish 任何 port。
  - [Disable networking for a container \| Docker Documentation](https://docs.docker.com/network/none/) #ril

## Bridge Network ??

  - Bridge network 完整的說法是 user-defined bridge network，因此 user-defined network 跟 bridge network 指的是相同的東西，但 user-defined network 更強調不是 default `bridge` network。

參考資料：

  - [Networking with standalone containers \| Docker Documentation](https://docs.docker.com/network/network-tutorial-standalone/)

      - 預設的 bridge network (network name = `bridge`) 直接可以用，但不要用在 production；建議用自訂的 custom bridge network 去連結多個在同一個 Docker host 的多個 containers。
      - `docker network ls` 可以列出所有的 network，至少會有 `bridge`、`host` 跟 `none`。

      - Use the default bridge network 試驗連接到 `bridge` network 的多個 container 如何溝通

          - `docker run -dit --name alpine1 alpine ash` 跟 `docker run -dit --name alpine2 alpine ash` (省略預設的 `--network bridge`)，用 `docker network inspect bridge`，在 `Containers:` 下可以看到上面兩個 container 以及各自的 IP。
          - 記住 `alpine2` 的 IP，在 `docker attach alpine1` 裡試著 `ping <IP_OF_ALPINE2>` 是可以的，但 `ping alpine2` 會得到 `ping: bad address 'alpine2'`。

      - Use user-defined bridge networks 試驗連接到 user-defined network (`alpine-net`)、連接到 `bridge` network、及同時連接 `alpine-net` 及 `bridge` 的 4 個 container 如何溝通

          - 首先 `docker network create alpine-net` 建立 user-defined network (省略預設的 `--driver bridge`)。
          - `docker run -dit --name alpineN --network alpine-net aalpine ash` 啟動 3 個 container -- `alpine1`、`alpine2` 跟 `alpine4`，再用 `docker network connect bridge alpine4` 讓 `alpine4` 也同時接到 `bridge` network。
          - `docker run -dit --name alpine3 alpine ash` 啟動 `alpine3`，只接到 `bridge` network；用 `docker network inspect bridge` 確認 `alpine3` 跟 `alpine4` 都接到 `bridge` network，而 `docker network inspect alpine-net` 則可以看到 `alpine1`、`alpine2` 跟 `alpine4`。
          - 在 `apline1` 裡，除可以可用 IP 跟同一個 network 的 `alpine2`、`alpine4` 溝通外，也可以透過 container name (例如 `ping alpine2`)，這項功能叫 "automatic service discovery"，是 `bridge` network 沒有的功能。但 `alpine1` -> `alpine3` 之間，因為沒有共同的 network，無論透過 IP 或 container name 都連接不到 (事實上，`alpine3` 這個名稱也無法解析出 IP)。
          - 在 `alpine4` 裡，跟 `alpine1、`alpine2` 可以用 IP 及 container name 溝通，跟 `alpine3` 還是只能透過 IP 溝通，因為它沒有接到共通的 user-defined bridge network。

  - [Use bridge networks \| Docker Documentation](https://docs.docker.com/network/bridge/) #ril

## Port Mapping ??

  - `docker port CONTAINER` 可以列出 _CONTAINER_ 的 port mappings (running 時才有意義)，也可以搭配 `[PRIVATE_PORT[/PROTOCOL]]` 查詢 container 內的 private port (或稱 container port) 被 map/publish 到 host 的 public port (或稱 host port)。
  - `Dockerfile` 裡的 `EXPOSE` 只是用來說明哪些 container port 可以被 publish，但真正的 publish 發生在 `docker runer` 搭面 `--publish, -p` 或 `--publish-all, -P` 時。
  - 以 `docker run -p 8080:80 -name my-container ...` 為例，用 `docker port my-container 80` (或 `docker port my-container 80/tcp`) 會得到 `0.0.0.0:8080`，而 `docker port my-container 80/udp` 則會丟出 "Error: No public port '80/udp' published for my-container" 的錯誤，注意 public/private port 與 publish 的說法。

參考資料：

  - How to run NGINX as a Docker container - TechRepublic https://www.techrepublic.com/article/how-to-run-nginx-as-a-docker-container/ 提到 `docker run` 時要加 `-p PUBLIC_PORT:PRIVATE_PORT` 做 mapping。
  - docker port | Docker Documentation https://docs.docker.com/engine/reference/commandline/port/ `docker port` 可以列出所有的 port mapping，也可以查詢特定 private port (+ protocol) 是否被 publish 出去，例如 `docker run -p 8080:80 -name my-container...`，用 `docker port my-container 80` (或 `docker port my-container 80/tcp`) 會得到 `0.0.0.0:8080`，而 `docker port my-container 80/udp` 則會丟出 "Error: No public port '80/udp' published for my-container" 的錯誤 (注意 public/private port 與 publish 的說法)
  - docker run | Docker Documentation https://docs.docker.com/engine/reference/commandline/run/ `docker run` 跟 port 相關的參數有 `--publish, -p` - Publish a container’s port(s) to the host，`--publish-all, -P` - Publish all exposed ports to random ports 以及 `--expose` - Expose a port or a range of ports；要 publish 一定要先 expose??
  - EXPOSE - Dockerfile reference | Docker Documentation https://docs.docker.com/engine/reference/builder/#expose `EXPOSE` 只是在說明 container 在 runtime 時有哪些 listen 的 port (TCP/UDP) 可以被 publish，但真正的 publish 發生在 `docker run` 搭配 `--publish, -p` 或 `--publish-all, -P` 時。
  - EXPOSE (incoming ports) - Docker run reference | Docker Documentation https://docs.docker.com/engine/reference/run/#expose-incoming-ports `--link` 可以建立 container 間的連結? 這裡出現 host port 與 container port 的說法 #ril
  - [Exposing a port on a live Docker container \- Stack Overflow](https://stackoverflow.com/questions/19897743/) 從回應整體看起來，事後要做 port mapping 並不容易。
      - reberhardt: 一旦 container 執行起來，可以再做 port mapping 嗎?
      - SvenDowideit: 你不能這麼做，但事實上從 host 可以存取到 un-exposed port? 試不出來 XD
  - [Connect using network port mapping - Legacy container links \| Docker Documentation](https://docs.docker.com/network/links/#connect-using-network-port-mapping) 不知為何要在 link 裡講這麼多 porting mapping? #ril

## Container Link (LEGACY) ??

  - [Legacy container links \| Docker Documentation](https://docs.docker.com/network/links/)
      - 從 [Use bridge networks](https://docs.docker.com/network/bridge/) 大概可以理解，"link" 專指 `--link`；links between the containers 或 linked container 都跟 `--link` 有關，不同於透過 network 連結的機制。
      - The `--link` flag is a LEGACY feature of Docker. It may eventually be removed. Unless you absolutely need to continue using it, we recommend that you use user-defined networks to facilitate communication between two containers instead of using `--link`. 一開始就說，應該用 user-defined network 來取代 `--link`；不過現在還滿多人在用的...
      - One feature that user-defined networks do not support that you can do with `--link` is sharing environmental variables between containers. However, you can use other mechanisms such as VOLUMES to share environment variables between containers in a more controlled way. 透過 volume 也可以共用環境變數??
      - "legacy container links within the Docker DEFAULT bridge network"、"you can still create links but they behave differently between DEFAULT bridge network and user defined networks" 及 "container linking in DEFAULT bridge network" 等說法，看似 container link 跟 bridge network 有關，只是搭配 default `bridge` network 跟 user-defined network 有不同的效果；事實上這份文件也只講 "legacy link feature in the default bridge network"，也就是 `--network bridge` (或省略)。
      - 前面 Connect using network port mapping 講了一堆，只是為了帶出 Network port mappings are not the only way Docker containers can connect to one another。這裡的 linking system 也可以將多個 container 串接在一起，還有 "send connection information from one to another" -- information about a SOURCE container can be sent to a RECIPIENT container，包括 connectivity information 跟 environment variables。
      - 不過 link 是透過 container name，所以 `docker run` 時用 `--name` 取個易懂的名稱很重要 -- a reference point that allows it to refer to other containers
  - [Communication across links - Legacy container links \| Docker Documentation](https://docs.docker.com/network/links/#communication-across-links)
      - 建立 container 間的 link，就像在 source container 與 recipient container 間拉一條導管 (conduit) 一樣，recipient 可以存取 source 的一些資料。
      - 用 `--link` 建立連結，例如 `docker run -d -P --name web --link db:db training/webapp python app.py`，其中 `--link db:db` 的用法是 `--link CONTAINER[:LINK_ALIAS]`，也就由 `web` 往 `db` 建立一個名稱為 `db` 的 link，但因為是 `web` 收到 `db` 的資訊 -- 在 `web` 裡可以 `ping db`，但 `db` 裡認不得 `ping web`，所以 `web` 是 recipient，而 `db` 才是 source，這跟連線的方向剛好相反。
      - Docker creates a SECURE TUNNEL between the containers that doesn’t need to expose any ports externally on the container. That’s a big benefit of linking: we don’t need to expose the source container.
      - 其實這背後的 magic 是 Docker 會自動調整 recipient container 的 `/etc/hosts`:

            $ docker run -it --rm --name web --link db:mydb alpine cat /etc/hosts
            ...
            172.17.0.2  mydb 09bc088666d2 db <-- container name 跟 link alias 都可以用
            172.17.0.4  83a22c0ed4fc <-- 這是 container 自己

  - [Environment variables - Legacy container links \| Docker Documentation](https://docs.docker.com/network/links/#environment-variables) #ril
  - [Differences between user-defined bridges and the default bridge - Use bridge networks \| Docker Documentation](https://docs.docker.com/network/bridge/#differences-between-user-defined-bridges-and-the-default-bridge) User-defined bridges provide automatic DNS resolution between containers. 也提到 `--link` #ril

## `docker network`, `docker run` ??

  - [Work with network commands \| Docker Documentation](https://docs.docker.com/v17.09/engine/userguide/networking/work-with-networks/) #ril
  - [Network settings - `docker run` | Docker Documentation](https://docs.docker.com/engine/reference/run/#network-settings) #ril
  - [EXPOSE (incoming ports) - `docker run` | Docker Documentation](https://docs.docker.com/engine/reference/run/#expose-incoming-ports) #ril

## Host Network ??

  - [Use host networking \| Docker Documentation](https://docs.docker.com/network/host/) 只支援 Linux host #ril
      - If you use the `host` network driver for a container, that container’s network stack is not isolated from the Docker host. For instance, if you run a container which binds to port 80 and you use `host` networking, the container’s application will be available on port 80 on the host’s IP address.

        其中 bind 指的是 container 裡的 application 直接在某個 port listen??

      - The host networking driver only works on Linux hosts, and is NOT supported on Docker Desktop for Mac, Docker Desktop for Windows, or Docker EE for Windows Server.

  - [Networking using the host network \| Docker Documentation](https://docs.docker.com/network/network-tutorial-host/) #ril

  - [nginx \- From inside of a Docker container, how do I connect to the localhost of the machine? \- Stack Overflow](https://stackoverflow.com/questions/24319662/) #ril
      - Phil: So I have a Nginx running inside a docker container, I have a mysql running on localhost, I want to connect to the MySql from within my Nginx.
      - Thomasleveil: If you are using Docker-for-mac or Docker-for-Windows 18.03+, just connect to your mysql service using the host `host.docker.internal`.

        As of Docker 18.09.3, this does not work on Docker-for-Linux. A [fix](https://github.com/docker/libnetwork/pull/2348) has been submitted on March the 8th, 2019 and will hopefully be merged to the code base. Until then, a workaround is to use a container as described in qoomon's answer. 看起來，正解就是 `host.docker.internal`

      - Janne Annala: Docker v 18.03 and above (since March 21st 2018) -- Use your internal IP address or connect to the special DNS name `host.docker.internal` which will resolve to the internal IP address used by the host. 所謂 "internal IP" 是 host 在 container 裡的 IP，跟 host 上看到的 IP 不同。

  - [Networking features in Docker Desktop for Mac \| Docker Documentation](https://docs.docker.com/docker-for-mac/networking/) #ril

    I WANT TO CONNECT FROM A CONTAINER TO A SERVICE ON THE HOST

      - The host has a CHANGING IP address (or none if you have NO NETWORK ACCESS). From 18.03 onwards our recommendation is to connect to the special DNS name `host.docker.internal`, which resolves to the internal IP address used by the host. This is for development purpose and will not work in a production environment outside of Docker Desktop for Mac.

        由於 IP 會變動，也可能沒有網路，用虛擬的 `host.docker.internal` 確實是比較好的選擇。

      - The gateway is also reachable as `gateway.docker.internal`. 什麼情況下會用到 gateway??

  - [Docker Tip \#65: Get Your Docker Host's IP Address from in a Container — Nick Janetakis](https://nickjanetakis.com/blog/docker-tip-65-get-your-docker-hosts-ip-address-from-in-a-container) (2018-07-27) #ril


## Overlay Network ??

  - [Use overlay networks \| Docker Documentation](https://docs.docker.com/network/overlay/) #ril
  - [Networking with overlay networks \| Docker Documentation](https://docs.docker.com/network/network-tutorial-overlay/) #ril

## Macvlan Network ??

  - [Use Macvlan networks \| Docker Documentation](https://docs.docker.com/network/macvlan/) #ril
  - [Networking using a macvlan network \| Docker Documentation](https://docs.docker.com/network/network-tutorial-macvlan/) #ril

## 參考資料 {: #reference }

  - [docker/libnetwork - GitHub](https://github.com/docker/libnetwork)

手冊：

  - [`docker network` | Docker Documentation](https://docs.docker.com/engine/reference/commandline/network/)

