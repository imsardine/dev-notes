# Docker

  - Docker (碼頭工人) 是一種 (software) container platform，定位在 A Better Way to Build Apps；這說法呼應了 Docker 的 logo - 一隻鯨魚做為一個平台 (platform) 並承載了許多貨櫃 (container)
  - 利用 continer 把 app 及 dependencies 打包隔離開來 (isolated)，這麼做可以避免衝突並提高安全性，在不同開發階段 (development, testing, deployment) 更提供了 portability 與 predictability，有效免除了 "it works on my machine" 的問題，也就是在解決多人協作時環境不一致的問題。
  - 開發完成後，operator 在佈署多個 app 時，就是在管理多個 isolated container，相對單純許多。

參考資料：

  - Docker - Build, Ship, and Run Any App, Anywhere https://www.docker.com/ 用 container 把 app 及 dependencies 打包隔離開來。
  - What is Docker? https://www.docker.com/what-docker 是一種 container platform，佈署 app 就是管理 isolated containers。

## 跟 VM 的不同?? {: #vs-vm }

  - [Containers vs. virtual machines - Get Started, Part 1: Orientation and setup \| Docker Documentation](https://docs.docker.com/get-started/#virtual-machine-diagram) #ril

## Docker 支援 Windows app??

  - 如果多個 container 是共用 OS kernel，那麼內含 Linux app 的 container 不能執行在 Windows host 上，反之亦然?

參考資料：

  - [microsoft \- Docker Hub](https://hub.docker.com/u/microsoft/) 還真的有一堆 image #ril
  - What is Docker? https://www.docker.com/what-docker 提到 "with confidence for both Linux and Windows Server apps"。
  - What is a Container | Docker https://www.docker.com/what-container 提到 "Available for both Linux and Windows based apps"。

## Hello, World!

```
$ docker run hello-world

Hello from Docker!
...
$ docker run hello-world

Hello from Docker!
...

$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES
479d4f07e2fb        hello-world         "/hello"            27 seconds ago      Exited (0) 30 seconds ago                       romantic_galileo
15f9d4284ced        hello-world         "/hello"            29 seconds ago      Exited (0) 31 seconds ago                       hopeful_poincare
```

原來每做一次 `docker run`，都產生一個 container。如何重複看到訊息，但只建立一個 container? 用 `--name` 給個名字：(不要被 `docker run` 中的 "run" 給騙了)

```
$ docker run --name hello hello-world

Hello from Docker!
...

$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES
051fcb601eca        hello-world         "/hello"            29 seconds ago      Exited (0) 32 seconds ago                       hello
```

如何再看到一次訊息呢?

```
$ docker run --name hello hello-world # 這行不通，因為 `hello` 這名字已經有 container 使用
$ docker start hello # 什麼事都沒發生?
hello
$ docker start -a hello # 加上 `--attach, -a` 又可以看得到了

Hello from Docker!
...
```

原來 `run` 會啟動 container 並自動 attach，但 `start` 預設是 detached，所以 `docker start hello` 有執行但看不到輸出。

```
$ docker help start | grep attach
  -a, --attach               Attach STDOUT/STDERR and forward signals
```

`docker run` 或 `docker start` 時，預設會執行 [`Dockerfile`](https://github.com/docker-library/hello-world/blob/master/amd64/hello-world/Dockerfile) 中的 `CMD`：

```
FROM scratch
COPY hello /
CMD ["/hello"]
```

執行完就結束了，呼應 `docker ps -a` 顯示的 "Exited" status。

參考資料：

  - library/hello-world - Docker Hub https://hub.docker.com/_/hello-world/

## 新手上路 ?? {: #getting-started }

  - 跟著 Getting Started with Docker 做一次，對所有的 term 有整體的瞭解。
      - 似乎可以從 `docker run hello-world` 開始?
      - 搞清楚 Docker for Mac、Docker Toolbox、Docker Machine、Docker Engine 的不同、關係...

  - [Get Started, Part 1: Orientation and setup \| Docker Documentation](https://docs.docker.com/get-started/)

    Docker concepts

      - Docker is a platform for developers and sysadmins to develop, deploy, and run applications with containers. The use of Linux containers to deploy applications is called CONTAINERIZATION.

        Containers are not new, but their use for easily DEPLOYING APPLICATIONS is.

      - Containerization is increasingly popular because containers are:

          - Flexible: Even the most complex applications can be containerized.
          - Lightweight: Containers LEVERAGE AND SHARE THE HOST KERNEL.
          - Interchangeable: You can deploy updates and upgrades on-the-fly. ??
          - Portable: You can build locally, deploy to the cloud, and run anywhere.
          - Scalable: You can increase and automatically distribute CONTAINER REPLICAS.
          - Stackable: You can STACK SERVICES VERTICALLY and on-the-fly. ??

      - Images and containers

          - A CONTAINER IS LAUNCHED BY RUNNING AN IMAGE. An image is an EXECUTABLE PACKAGE that includes everything needed to run an application--the code, a runtime, libraries, environment variables, and configuration files.

            通常 configuration 會從外面掛進去。

          - A container is a RUNTIME INSTANCE OF AN IMAGE--what the image becomes in memory when executed (that is, an image with state, or a user process). You can see a list of your running containers with the command, `docker ps`, just as you would in Linux.

      - Containers and virtual machines

          - A container runs NATIVELY on Linux and SHARES THE KERNEL OF THE HOST MACHINE with other containers. It runs a discrete process, taking no more memory than any other executable, making it lightweight.

            不用 `docker ps` 的話，用 `ps` 看得到 container 對應的 process 嗎 ??

      - By contrast, a virtual machine (VM) runs a FULL-BLOWN “guest” operating system with VIRTUAL ACCESS TO HOST RESOURCES THROUGH A HYPERVISOR. In general, VMs provide an environment with more resources than most applications need.

        ![](https://docs.docker.com/images/Container%402x.png)

        每個 application 都用個別 VM 佈署的話，會多一層 Guest OS，資源運用上比較沒效率；若多個 application 共用一個 VM，環境會混在一起也不可能。

    Prepare your Docker environment

      - Install a maintained version of Docker Community Edition (CE) or Enterprise Edition (EE) on a supported platform.

      - For full Kubernetes Integration

          - Kubernetes on Docker Desktop for Mac is available in 17.12 Edge (mac45) or 17.12 Stable (mac46) and higher.
          - Kubernetes on Docker Desktop for Windows is available in 18.02 Edge (win50) and higher edge channels only.

        Docker 不是自己有 Swarm，為什麼也會推 Kubernetes ??

    Test Docker version

      - Run `docker --version` and ensure that you have a supported version of Docker:

            $ docker --version
            Docker version 17.12.0-ce, build c97c6d6

      - Run `docker info` (or `docker version` without `--`) to view even more details about your Docker installation:

            $ docker info
            Containers: 0
             Running: 0
             Paused: 0
             Stopped: 0
            Images: 0
            Server Version: 17.12.0-ce
            Storage Driver: overlay2
            ...

      - To avoid permission errors (and the use of `sudo`), add your user to the `docker` group. Read more.

    Test Docker installation

      - Test that your installation works by running the simple Docker image, `hello-world`:

            $ docker run hello-world
            Unable to find image 'hello-world:latest' locally
            latest: Pulling from library/hello-world
            ca4f61b1923c: Pull complete
            Digest: sha256:ca0eeb6fb05351dfc8759c20733c91def84cb8007aa89a5bf606bc8b315b9fc7
            Status: Downloaded newer image for hello-world:latest

            Hello from Docker!
            This message shows that your installation appears to be working correctly.
            ...

      - List the `hello-world` image that was downloaded to your machine:

            docker image ls

      - List the `hello-world` container (spawned by the image) which exits after displaying its message. If it were STILL RUNNING, you would not need the `--all` option:

            $ docker container ls --all
            CONTAINER ID     IMAGE           COMMAND      CREATED            STATUS
            54f4984ed6a8     hello-world     "/hello"     20 seconds ago     Exited (0) 19 seconds ago

    Conclusion of part one

      - Containerization makes CI/CD seamless. For example:

          - applications have NO SYSTEM DEPENDENCIES
          - updates can be pushed to any part of a distributed application ??
          - resource density can be optimized.

      - With Docker, scaling your application is a matter of spinning up new executables, not running heavy VM hosts.

  - [Get Started, Part 2: Containers \| Docker Documentation](https://docs.docker.com/get-started/part2/) #ril

    Introduction

      - It’s time to begin building an app the Docker way. We start at the bottom of the hierarchy of such app, a container, which this page covers. Above this level is a SERVICE, which defines how containers behave in production, covered in Part 3. Finally, at the top level is the STACK, defining the INTERACTIONS OF ALL THE SERVICES, covered in Part 5.

          - Stack
          - Services
          - Container (you are here)

    Your new development environment

      - In the past, if you were to start writing a Python app, your first order of business was to install a Python runtime onto your machine. But, that creates a situation where the environment on your machine needs to be perfect for your app to run as expected, and also needs to MATCH YOUR PRODUCTION ENVIRONMENT.
      - With Docker, you can just grab a portable Python runtime as an image, no installation necessary. Then, your build can include the base Python image right alongside your app code, ensuring that your app, its dependencies, and the runtime, ALL TRAVEL TOGETHER.
      - These portable images are defined by something called a `Dockerfile`.

    Define a container with `Dockerfile`

      - `Dockerfile` defines what goes on in the environment inside your container. Access to resources like networking interfaces and disk drives is VIRTUALIZED INSIDE THIS ENVIRONMENT, which is isolated from the rest of your system, so you need to MAP ports to the outside world, and BE SPECIFIC about what files you want to “COPY IN” to that environment.

        However, after doing that, you can expect that the build of your app defined in this `Dockerfile` behaves exactly the same wherever it runs.

      - Create an empty directory on your local machine. Change directories (`cd`) into the new directory, create a file called `Dockerfile`, copy-and-paste the following content into that file, and save it. Take note of the comments that explain each statement in your new Dockerfile.

            # Use an official Python runtime as a parent image
            FROM python:2.7-slim

            # Set the working directory to /app
            WORKDIR /app

            # Copy the current directory contents into the container at /app
            COPY . /app

            # Install any needed packages specified in requirements.txt
            RUN pip install --trusted-host pypi.python.org -r requirements.txt

            # Make port 80 available to the world outside this container
            EXPOSE 80

            # Define environment variable
            ENV NAME World

            # Run app.py when the container launches
            CMD ["python", "app.py"]

      - This `Dockerfile` refers to a couple of files we haven’t created yet, namely `app.py` and `requirements.txt`. Let’s create those next.

    The app itself

      - Create two more files, `requirements.txt` and `app.py`, and put them in the same folder with the `Dockerfile`. This completes our app, which as you can see is quite simple. When the above `Dockerfile` is built into an image, `app.py` and `requirements.txt` is present because of that `Dockerfile`’s `COPY` command, and the output from `app.py` is accessible over HTTP thanks to the `EXPOSE` command.

        `requirements.txt`

            Flask
            Redis

        `app.py`

            from flask import Flask
            from redis import Redis, RedisError
            import os
            import socket

            # Connect to Redis
            redis = Redis(host="redis", db=0, socket_connect_timeout=2, socket_timeout=2)

            app = Flask(__name__)

            @app.route("/")
            def hello():
                try:
                    visits = redis.incr("counter")
                except RedisError:
                    visits = "<i>cannot connect to Redis, counter disabled</i>"

                html = "<h3>Hello {name}!</h3>" \
                       "<b>Hostname:</b> {hostname}<br/>" \
                       "<b>Visits:</b> {visits}"
                return html.format(name=os.getenv("NAME", "world"), hostname=socket.gethostname(), visits=visits)

            if __name__ == "__main__":
                app.run(host='0.0.0.0', port=80)

Now we see that pip install -r requirements.txt installs the Flask and Redis libraries for Python, and the app prints the environment variable NAME, as well as the output of a call to socket.gethostname(). Finally, because Redis isn’t running (as we’ve only installed the Python library, and not Redis itself), we should expect that the attempt to use it here fails and produces the error message.

Note: Accessing the name of the host when inside a container retrieves the container ID, which is like the process ID for a running executable.

That’s it! You don’t need Python or anything in requirements.txt on your system, nor does building or running this image install them on your system. It doesn’t seem like you’ve really set up an environment with Python and Flask, but you have.


  - [Get Started, Part 3: Services \| Docker Documentation](https://docs.docker.com/get-started/part3/) #ril

  - Get started with Docker for Mac | Docker Documentation https://docs.docker.com/docker-for-mac/ #ril
  - library/hello-world - Docker Hub https://hub.docker.com/_/hello-world/ #ril
  - library/ubuntu - Docker Hub https://hub.docker.com/_/ubuntu/ #ril
  - library/scratch - Docker Hub https://hub.docker.com/_/scratch/ 從 Docker 1.5 開始 `FROM scratch` 就是個 no-op (不會形成一個 layer) #ril

## Architecture -- Engine, Daemon, Client ??

  - [Docker overview \| Docker Documentation](https://docs.docker.com/engine/docker-overview/) #ril

## Docker Daemon ??

  - [Configure and troubleshoot the Docker daemon \| Docker Documentation](https://docs.docker.com/config/daemon/) #ril
  - [Control Docker with systemd \| Docker Documentation](https://docs.docker.com/config/daemon/systemd/) #ril
  - [Docker object labels \| Docker Documentation](https://docs.docker.com/config/labels-custom-metadata/) #ril
  - [dockerd \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/dockerd/) #ril
  - [Service Name and Transport Protocol Port Number Registry](https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml?search=docker) Port 2376 名為 `docker-s` #ril

## Container ??

  - Container 把 software 用到的東西都打包進去，但不像 VM，這裡面不含 OS，只有 code、libraries、settings 等，不只是 isolated/self-contained 且更為輕量，而且跟最後被佈署到哪無關；這個 container 可能只是整個 application 的一部份 (app component)。

參考資料：

  - [What is Docker?](https://www.docker.com/what-docker) 不像 VM，不含 OS。
  - What is a Container | Docker https://www.docker.com/what-container #ril
  - [Get Started, Part 1: Orientation and setup \| Docker Documentation](https://docs.docker.com/get-started/) 提到 "A container is a runtime instance of an image"

## Container 是 stateless??

  - Containers should be ephemeral - Best practices for writing Dockerfiles | Docker Documentation https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#general-guidelines-and-recommendations #ril
  - The Twelve-Factor App https://12factor.net/processes #ril

## Container 停止後狀態會不見??

  - 習慣換 app 就是換掉整個 image 並重建 container??
  - 應該把資料寫在外面方便備份? 方便更新 image 後採用舊的資料??
  - How to run NGINX as a Docker container - TechRepublic https://www.techrepublic.com/article/how-to-run-nginx-as-a-docker-container/ 這裡 `docker run` 建立的 container，
  - [Understanding Volumes in Docker \- Container Solutions](http://container-solutions.com/understanding-volumes-docker/) (2014-12-09) #ril
  - [Manage data in Docker \| Docker Documentation](https://docs.docker.com/engine/admin/volumes/) 一開始就提到 "The data won’t persist when that container is no longer running"? 但試出來是會留存的 #ril
  - [Use volumes \| Docker Documentation](https://docs.docker.com/engine/admin/volumes/volumes/) #ril

## Restart Policy ??

  - [Start containers automatically \| Docker Documentation](https://docs.docker.com/config/containers/start-containers-automatically/) 啟動 container 時搭配 `--restart always`，這說明了 container 為什麼 stop 後再 start 不能改變設定 #ril
  - [Restart policies (--restart) - Docker run reference | Docker Documentation](https://docs.docker.com/engine/reference/run/#restart-policies---restart) #ril

## One process per container 是個迷思??

  - 正確的說法是 "One concern per container"，而 "Once process per container" 的說法則有點偏頗。

參考資料：

  - 每個 container 都可以想成有獨立環境的 process?
  - docker - Why it is recommended to run only one process in a container? - DevOps Stack Exchange https://devops.stackexchange.com/questions/447/ 為什麼許多人建議 "one process per container"? Jon: 提出 "one function per container"，呼應後來官方 "one concern" 的說法。
  - Each container should have only one concern - Best practices for writing Dockerfiles | Docker Documentation https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#each-container-should-have-only-one-concern 把 application 扮成多個 container，方便 scale horizontally。例如 web stack 可以拆成 web application、database 跟 in-memory cache 三個 container，其間可以透過 container network 溝通? 坊間 "one process per container" 的說法並不完全正確，許多程式都會產生 (spawn) 其他 (worker) processes。
  - Fix "one process per container" -- Add touchups to Dockerfile best practices by nathanleclaire · Pull Request #1418 · docker/docker.github.io https://github.com/docker/docker.github.io/pull/1418 官方認為 one process per container 是個 misleading mantra (真言)，對 Dockerfile Best Practices 做了一點補充
  - Operating System Containers vs. Application Containers (2015-05-19) https://blog.risingstack.com/operating-system-containers-vs-application-containers/ #ril
  - Run Multiple Processes in a Container | Runnable Docker Guides https://runnable.com/docker/rails/run-multiple-processes-in-a-container #ril
  - Using Honcho to Create a Multi-Process Docker Container | via @codeship (2017-05-05) https://blog.codeship.com/using-honcho-create-multi-process-docker-container/ #ril
  - Docker - one process per container? - Stack Overflow https://stackoverflow.com/questions/30003338/ #ril

## Attached/detached? interactive? TTY??

  - `docker start` 預設是 detached mode，而 `docker run` 預設是 attached mode；剛好呼應了 `docker start` 提供了 `--attach` 參數，而 `docker run` 則提供 `--detach`。

參考資料：

  - [Networking with standalone containers \| Docker Documentation](https://docs.docker.com/network/network-tutorial-standalone/#use-the-default-bridge-network) 提到 detached (in the background)、interactive (with the ability to type into it) 及 TTY (so you can see the input and output)；不懂 see the input 是指 typing 時的 echo? 另外也提到 detach (不中斷) 的話要用 `Ctrl-p q`。
  - How to run NGINX as a Docker container - TechRepublic https://www.techrepublic.com/article/how-to-run-nginx-as-a-docker-container/ `docker run` 不加 `-d` 會是 attached，按 Ctrl-C 中斷讓 container 進入 exited status 後，再用 `docker start` 重新啟動，就直接進 detached mode。
  - docker - Correct way to detach from a container without stopping it - Stack Overflow https://stackoverflow.com/questions/25267372/ `docker run` 不加 `-d`，或是 `docker attach` 後，如何不停止 container 就能 detach?  #ril
  - docker - Correct way to detach from a container without stopping it - Stack Overflow https://stackoverflow.com/questions/25267372/ Regan 有提到 "it will be detached by default"。
  - docker run | Docker Documentation https://docs.docker.com/engine/reference/commandline/run/ `--tty` 是 Allocate a pseudo-TTY，而 `--interactive` 則是 Keep STDIN open even if not attached
  - [Cannot kill or detach a docker container using Ctrl\-C or Ctrl\-\\ · Issue \#2838 · moby/moby](https://github.com/moby/moby/issues/2838) Docker 0.6.5 開始，加 `-t` 的話，按 Ctrl-C 會 detach，再加上 `-i` 的話，Ctrl-C 會中斷 container，這個時候要用 `Ctrl-p Ctrl-q` 達到 detach 的效果。



  - 為什麼 `--interactive` 還要搭配 `--tty`?
  - 為什麼 `docker run --name hello-world hello-world` 可以看到 "Hello from Docker!"，但之後再重啟 `docker start hello-world` 就看不到?? 因為 application 已經結束了?

  - What does it mean to attach a tty/std-in-out to dockers or lxc? - Stack Overflow https://stackoverflow.com/questions/22272401/ #ril
  - What does the -t or --tty do in Docker? - Quora https://www.quora.com/What-does-the-t-or-tty-do-in-Docker #ril
  - Detaching from a container in Mac OS X · Issue #20864 · moby/moby https://github.com/moby/moby/issues/20864 在 Mac 上按 Ctrl-p Ctrl-q 無效? 後來證實這個 hotkey 要搭配 `-it` (`--interactive --tty`) 才會有作用。
  - [Docker Explained: Using Dockerfiles to Automate Building of Images \| DigitalOcean](https://www.digitalocean.com/community/tutorials/docker-explained-using-dockerfiles-to-automate-building-of-images) 最後提到 "To detach yourself from the container, use the escape sequence CTRL+P followed by CTRL+Q."。
  - docker attach | Docker Documentation https://docs.docker.com/engine/reference/commandline/attach/ #ril
  - How do you attach and detach from Docker's process? - Stack Overflow https://stackoverflow.com/questions/19688314/ #ril

## `docker run` 如何執行多個指令??

  - [docker run <IMAGE> <MULTIPLE COMMANDS> \- Stack Overflow](https://stackoverflow.com/questions/28490874/) 用 `docker run IMAGE bash -c 'COMMAND1; COMMAND2 ...'`，切換目錄可以用 `-w, --workdir` 取代 #ril

## 什麼是 service??

  - [Manage data in Docker \| Docker Documentation](https://docs.docker.com/engine/admin/volumes/#more-details-about-mount-types) 第一次看到 "Docker can create a volume during container or service creation" #ril
  - [docker service \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/service/) #ril
  - [How services work \| Docker Documentation](https://docs.docker.com/engine/swarm/how-swarm-mode-works/services/) "To deploy an application image when Docker Engine is in swarm mode, you create a service." 跟 swarm 有很深的關係 #ril

## Container 並不是完整的 OS??

  - library/hello-world - Docker Hub https://hub.docker.com/_/hello-world/ 基於 `scratch` image，只有 1.x KB。

## Docker 可以執行在 VM 裡?

  - What is a Container | Docker https://www.docker.com/what-container 提到 "and on any infrastructure including VMs, bare-metal and in the cloud."

## Runtime Constraints??

  - [Runtime constraints on resources - Docker run reference \| Docker Documentation](https://docs.docker.com/engine/reference/run/#runtime-constraints-on-resources) 有些 performance parameters 可以調，包括 memory (`--memory`)、CPU (`--cpus`)、I/O 速度等 #ril
  - [Limit a container’s resources \| Docker Documentation](https://docs.docker.com/engine/admin/resource_constraints/) 預設沒有 resource contraint #ril
  - [Resources - Compose file version 3 reference \| Docker Documentation](https://docs.docker.com/compose/compose-file/#resources) Docker compose 也支援 resource contraints #ril

## Ubuntu 的 Docker image 能夠取代 Ubuntu VM 嗎??

  - library/ubuntu - Docker Hub https://hub.docker.com/_/ubuntu/ 提到 "it is a minimal install of Ubuntu"，而 `Dockerfile` 的最後一行寫 `CMD ["/bin/bash"]` #ril
  - How is Docker different from a normal virtual machine? - Stack Overflow https://stackoverflow.com/questions/16047306/ 好多人在討論... #ril

## 如何為 container 重新命名?

`docker run` 若忘了加 `--name` 自訂名稱，事後還是可以用 `docker rename` 更名：

    docker rename CONTAINER NEW_NAME

參考資料：

  - docker rename | Docker Documentation https://docs.docker.com/engine/reference/commandline/rename/ `docker rename CONTAINER NEW_NAME` 可重新命名。
  - How to copy and rename a Docker container? - Stack Overflow https://stackoverflow.com/questions/19035358/ SergiiKozlov: Docker 1.5 開始提供 `docker rename`。
  - linux - How to assign a name to running container in docker? - Stack Overflow https://stackoverflow.com/questions/40500966/ `docker rename` 也可以用在 running container，在 Docker 1.10 才有?

## root, USER, --user ??

  - [Running a Docker container as a non\-root user – Redbubble – Medium](https://medium.com/redbubble/running-a-docker-container-as-a-non-root-user-7d2e00f8ee15) (2018-02-21) #ril
  - [Processes In Containers Should Not Run As Root – Marc Campbell – Medium](https://medium.com/@mccode/processes-in-containers-should-not-run-as-root-2feae3f0df3b) (2017-09-28) #ril
  - [Difference between docker run \-\-user and \-\-group\-add parameters \- Stack Overflow](https://stackoverflow.com/questions/41100333/) #ril
  - [USER - Docker run reference | Docker Documentation](https://docs.docker.com/engine/reference/run/#user) #ril

## 如何查詢 image/container 暫用的磁碟空間?

```
$ sudo docker system df
TYPE                TOTAL               ACTIVE              SIZE                RECLAIMABLE
Images              214                 34                  12.78GB             12.24GB (95%)
Containers          162                 0                   11.45GB             11.45GB (100%)
Local Volumes       0                   0                   0B                  0B

$ sudo docker system prune --all
WARNING! This will remove:
    - all stopped containers
    - all volumes not used by at least one container
    - all networks not used by at least one container
    - all images without at least one container associated to them
Are you sure you want to continue? [y/N] y

...
Total reclaimed space: xx.xxGB
```

參考資料：

  - [docker system df \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/system_df/) `docker system df` 會印出 Docker daemon 的 disk usage -- 包含 image、container 及 local volume。
  - [docker system prune \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/system_prune/) `docker system prune` 可以刪除用不到的資料。

## 如何建立/暫停/繼續/停止 container??

  - 在 image 的基礎上執行 command，就產生了一個 (running) container，而這個 command 可以從 `docker run` 或 `docker create` 的參數提供 (`[COMMAND] [ARG...]`)，或者 image 通常會提供預設值 (`Dockerfile` 裡的 `CMD`)，這呼應了 "run image as container" 的說法，以及 `docker ps` 會看到 `Exited (0)` 之類的 status。
  - 由於 container 跟 command 的執行脫不了關係，所以 command 在 `docker run` 或 `docker create` 就決定了，所以 `docker start` 沒有 `[COMMAND] [ARG...]` 的用法。只是 `docker create` 建立 container 後沒有馬上執行，可以把 `docker run` 視為 `docker create` + `docker start --attach` 的組合。

  - CMD - Dockerfile reference | Docker Documentation https://docs.docker.com/engine/reference/builder/#cmd `CMD` 的用法有 3 種 - `CMD ["executable","param1","param2"]` (exec form)、`CMD ["param1","param2"]` (做為 `ENTRYPOINT` 的預設參數、`CMD command param1 param2` (shell form)，都跟要 "如何執行" 的預設值有關，也就是說 `CMD` 在 build time 不會執行，只是描述 "intended command for the image"，可以從 command line 覆寫，也就是 `docker run` 或 `docker create` 後面 `[COMMAND] [ARG...]` 的部份。
  - docker create | Docker Documentation https://docs.docker.com/engine/reference/commandline/create/ `docker create` 類似於 `docker run --detach`，準備好執行特定的 command，但
  - `docker run` 可以解讀為 "run image as container"。
  - `docker start` (Start one or more stopped containers) 跟 `docker run` (Run a command in a new container) 是什麼關係? 為什麼 `docker start` 沒有 `--publish`/`-p` 這類參數，感覺 `run` 就要決定了，之後的 `start` 不能再改變?
  - `docker exec` (Run a command in a running container) 跟 `docker run` (Run a command in a new container) 有什麼不同? 

## docker run/start/exec 與 Dockerfile 裡 CMD、ENTRYPOINT 的關係??

  - [ENTRYPOINT - Dockerfile reference \| Docker Documentation](https://docs.docker.com/engine/reference/builder/#entrypoint) `ENTRYPOINT ["executable", "param1", "param2"]` 是其中一種 exec form 的寫法，在 `docker run IMAGE` 提供的參數都會 "附加" 到 `ENTRYPOINT` 之後，同時也覆寫了 `CMD` 的 default arguments (`ENTRYPOINT` 裡提供的 params 固定會有，跟 `CMD` 無關)；但 `ENTRYPOINT` 也可以用 `docker run --entrypoint` 覆寫。
  - [CMD - Dockerfile reference \| Docker Documentation](https://docs.docker.com/engine/reference/builder/#cmd) 提到 `CMD` 若要做為 `ENTRYPOINT` 的 default arguments，那麼 `ENTRYPOINT` 跟 `CMD` 都要用 JSON array format 寫 #ril
  - [Exec form ENTRYPOINT example - Dockerfile reference \| Docker Documentation](https://docs.docker.com/engine/reference/builder/#exec-form-entrypoint-example) 從 `docker exec -it test ps aux` 的例子看來，`docker exec` 跟 `ENTRYPOINT` 或 `CMD` 都無關，而且對象是一個 running container。
  - 若要包裝 image 給別人執行，善用 `ENTRYPOINT` 提供預設的參數 (例如 `ENTRYPOINT ["uwsgi", "--ini", "uwsgi.ini"]`)，搭配 `CMD` 提供可以從 command line 自訂的範例，這樣佈署的人就可以從 `docker run your_image` 後面直接提供參數，覆寫 `ENTRYPOINT` 預設的參數。

## 如何查詢有哪些 container? 刪除用到不到 container?

  - `docker start` - Start one or more stopped containers，應該是對應 `docker stop` - Stop one or more running containers。但
  - docker ps | Docker Documentation https://docs.docker.com/engine/reference/commandline/ps/ `docker ps` 預設會列出執行中 (running) 的 container，加上 `-a` (`--all`) 會列出所有 container，包含 stopped

## `docker build`

  - [Dockerfile reference \| Docker Documentation](https://docs.docker.com/engine/reference/builder/) #ril
  - [docker build \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/build/) #ril
      - 根據 `Dockerfile` 與 build context 裝配一個 image，所謂 context 是 "set of files at a specified location"，可以是 local path 或 (Git) URL。
      - Image 是由 Docker daemon 來 build，一開始會蒐集 context 裡的檔案 (先根據 `.dockerignore` 排除一些檔案) 進 daemon -- recursively (含 subdirectories 或 submodules)，那會成為 `Dockerfile` 裡參照檔案的來源。
      - 習慣上會將 `Dockerfile` 放 root of the context，也可以用 `-f, --file` 指定。
      - 可以用 `-t, --tag` 為最後的 image 加上 repository 及 tag。
  - 觀察 `docker build` 的輸出，一開始會提示 "Sending build context to Docker daemon  XXX MB"

## Tag, Image Name ??

  - [Tag an image (-t) - docker build \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/build/#tag-an-image--t)
      - `--tag, -t` 的說明是 "Name and optionally a tag in the ‘name:tag’ format"，在 `docker help build` 看到的則是 "-t, --tag list   Name and optionally a tag in the 'name:tag' format" 所以 `--tag` 可以是 `name[:tag]`，對照 `docker image ls` 輸出的欄位，name 就是 repository name；而 `list` 是指可以使用多次 (給多個不同的 tag)
      - 從 Docker Hub 的操作介面看來，一個 repository 就是一個 image，但可以有許多 tag；例如 [python 的 repository](https://hub.docker.com/_/python/) 下有[多個 tag](https://hub.docker.com/r/library/python/tags/)，不同的 tag 除了版號不同，也可以區分不同的版本 (variation)，例如 `2.7.15-alpine`、`2.7.15-slim`
      - 為 resulting image 加上 tag，以 `docker build -t vieux/apache:2.0 .` 為例，`vieux/apache` 是 repository name (沒有 repository URL，但 `vieux/` 可以視為 namespace)，`2.0` 才是 tag。使用多個 `-t` 就可以為 image 加上多個 tags，例如 `docker build -t whenry/fedora-jboss:latest -t whenry/fedora-jboss:v2.1 .` (顯然 name 是必要的)。
  - [docker tag \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/tag/) 建立一個 tag TARGET_IMAGE 參照 SOURCE_IMAGE?? #ril
      - `docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]` 建立一個 tag `TARGET_IMAGE` 指向 `SOURCE_IMAGE`?
      - 首次出現 "image name" 與 "tag name" 的說法!! 但由 "You can group your images together using names and tags, and then upload them ..." 這句看來，單純提到 name 時，指的則是 image name，相對於 tag 而言。
      - Image name 由 `/` (slash) 分隔開來的 name components 構成，前面也可以有 registry hostname (可以帶 port，但不能有底線)；所以 image name 的格式為 `[registry_hostname[:port]]name_components`，其中 `registry_hostname` 預設是 `registry-1.docker.io` (central Docker registry)，而 `name_components` 就 Docker Hub 而言，就是 `namespace/repository`，例如 `username/my-project`，完整的表示法像是 `myregistryhost:5000/fedora/httpd:version1.0`。
      - 其中 `name_components` 只能由數字、小寫字母及一些 separator 組成，其中 separator 可以是 `.` (period)、1 ~ 2 個 `_` (underscore)、1 或多個 `-` (dash)，但開頭不能是 separator。而 tag name 則可以由大小寫字母、數字、底線、`.` (period) 及 `-` (dash) 組成 (也就是不能有 `:`、`/` 等)，最長 128 個字元。
      - 從幾個 "Tag an image referenced by ..." 的例子看來，`SOURCE_IMAGE[:TAG]` 的表示法是有問題的，因為 `name[:tag]` 的表示法也是為了找到特定的 soruce image (`tag` 預設為 `latest`)，給 image ID 是最明確的。
  - [Usage - Dockerfile reference \| Docker Documentation](https://docs.docker.com/engine/reference/builder/#usage) 提到 "You can specify a repository and tag at which to save the new image if the build succeeds" 及 "To tag the image into multiple repositories after the build" 的說法，原來 `-t` 不只是 tag，還包含了 repository，例如 `-t shykes/myapp:1.0.2`。
  - Build 出了兩個 image -- `proj1:latest` 與 `proj2:latest`，執行 `docker tag proj1:latest proj2:latest` 後，`proj2:latest` 也指向 `proj1:latest` 相同的 image ID，而原來 `proj2:latest` 指向的 image ID 在 `docker image ls` 裡則呈現 `<none>:<none>`，由此可見 `name[:tag]` 只是 image ID 的 alias。


  - [What are Docker <none>:<none> images? — Project Atomic](https://www.projectatomic.io/blog/2015/07/what-are-docker-none-none-images/) (2015-07-16) #ril
  - [Docker Explained: Using Dockerfiles to Automate Building of Images \| DigitalOcean](https://www.digitalocean.com/community/tutorials/docker-explained-using-dockerfiles-to-automate-building-of-images) 用 `docker build -t IMAGE_NAME .` 來建立 image，但 `-t, --tag list` 的說明是 Name and optionally a tag in the 'name:tag' format ?
  - library/ubuntu - Docker Hub https://hub.docker.com/_/ubuntu/ 看到 Supported tags and respective Dockerfile links 及 The ubuntu:latest tag points to the "latest LTS" 的說法。

## Makefile, GitLab CI ??

```
# Parameters
VERSION ?= $(shell cat VERSION)

# GitLab CI/CD Variables (for testing)
CI_REGISTRY ?= gitlab.example.com:4567
CI_PROJECT_PATH ?= ateam/awesome-project
CI_COMMIT_SHA ?= 0123456789abcdef0123456789abcdef01234567

# Internal Variables
ifdef CI
	image = $(CI_REGISTRY)/$(CI_PROJECT_PATH)/commit:$(CI_COMMIT_SHA) <-- 送往下一層，方便定期清理
else
	image = $(CI_PROJECT_PATH)
endif

build:
	docker build -t $(image) .
ifdef CI
	$(login-ci-registry)
	docker push $(image) <-- CI 下自動往 registry 送，其他 job 才拿得到
endif

ifdef CI_REGISTRY_USER
define login-ci-registry
	@docker login -u '$(CI_REGISTRY_USER)' -p '$(CI_REGISTRY_PASSWORD)' $(CI_REGISTRY)
endef
else
define login-ci-registry
	@docker login $(CI_REGISTRY)
endef
endif

ifdef CI_COMMIT_TAG
release: image_release = $(CI_REGISTRY)/$(CI_PROJECT_PATH):$(CI_COMMIT_TAG)
release:
ifneq ($(CI_COMMIT_TAG),$(VERSION)) <-- 自動檢查 VERSION file 與觸發的 Git tag 是否一致
	$(error CI_COMMIT_TAG ($(CI_COMMIT_TAG)) != VERSION ($(VERSION)))
endif
	$(login-ci-registry)
	docker pull $(image)
	docker tag $(image) $(image_release) <-- 直接把 commit/<sha> 標上版號，送往它該去的地方
	docker push $(image_release)
endif
```

```
image: docker:stable

stages:
  - build
  - deploy

build_image:
  stage: build
  tags:
    - dind
  only:
    - branches
  script:
    - apk add --no-cache make
    - make build

release_image:
  stage: deploy
  tags:
    - dind
  except:
    - branches
  only:
    - /^\d+\.\d+\.\d+$/
  script:
    - apk add --no-cache make
    - make release
```

## Registry ??

  - [Docker Registry \| Docker Documentation](https://docs.docker.com/registry/) #ril
  - [library/registry \- Docker Hub](https://hub.docker.com/_/registry/) 實現了 Docker Registry 2.0 #ril
  - [docker/distribution: The Docker toolset to pack, ship, store, and deliver content](https://github.com/docker/distribution) #ril
  - [Deploy a registry server \| Docker Documentation](https://docs.docker.com/registry/deploying/#get-a-certificate) #ril
  - [GitLab Container Registry \| GitLab](https://about.gitlab.com/2016/05/23/gitlab-container-registry/) (2016-05-23) #ril
      - GitLab 8.8 開始提供 Container Registry -- 一個與 GitLab 整合的 private registry (for Docker images)。
      - Docker-based workflow 的主角是 image -- 有 code change 時，透過 CI 建立並存放在某個地方，方便其他 developer/machine 取用，這個地方就是 container registry。
  - [AWS \| Amazon Elastic Container Registry \| Docker Registry](https://aws.amazon.com/ecr/) AWS 跟 GitLab 都有 Container Registry 的說法 #ril
  - [Difference between Docker registry and repository \- Stack Overflow](https://stackoverflow.com/questions/34004076/) #ril

## .dockerignore ??

要同時維護 `.gitignore` 與 `.dockerignore` 似乎不太容易? 因為兩者不完全重疊，例如 `.git/` 不在 `.gitignore` 裡，但卻要從 `.dockerignore` 裡排除。

按照 [Usage - Dockerfile reference \| Docker Documentation](https://docs.docker.com/engine/reference/builder/#usage) 的說法：

> In most cases, it’s best to start with an empty directory as context and keep your Dockerfile in that directory. Add only the files needed for building the Dockerfile.

可以考慮做 whitelisting - 先用 `*` 排除，再明確把要放進 image 的檔案用 `!` 加回來。例如：

```
*
!Dockerfile
!dist/
```

在 build image 前，可以用 `git clean -xdf` 確保 source 是可以預期的。

參考資料：

  - [Usage - Dockerfile reference \| Docker Documentation](https://docs.docker.com/engine/reference/builder/#usage) 提到 "In most cases, it’s best to start with an empty directory as context and keep your Dockerfile in that directory. Add only the files needed for building the Dockerfile."，是不是用 whitelisting 會比較容易處理?
  - [.dockerignore file - Dockerfile reference \| Docker Documentation](https://docs.docker.com/engine/reference/builder/#dockerignore-file) #ril
      - `.dockerignore` 也可以將 `Dockerfile` 和 `.dockerignore` 排除，但這些檔案還是會送給 daemon，不過 `ADD`/`COPY` 不會將它們寫進 image。
      - rather than which to exclude. To achieve this, specify * as the first pattern, followed by one or more ! exception patterns 明確寫出 whitelisting 的用法。
  - [Have \.dockerignore support Dockerfile/\.dockerignore by duglin · Pull Request \#8748 · moby/moby](https://github.com/moby/moby/pull/8748)
      - 雖然說只要 `.dockerignore` 提到 `Dockerfile` 或 `.dockerignore`，還是會送到 daemon 去，但解析完 `Dockerfile` 就會刪掉，就像 `Dockerfile` 從未出現一樣。不過實測發現，`.dockerignore` 總是不會在 image 裡，但 `Dockerfile` 只有明確寫在 `.dockerignore` 裡時，才真的不會出現在 image。
      - 這很合理，因為 `.dockerignore` 是 CLI 要避免傳送不必要的檔案給 daemon，也就是說 daemon 從來都不需要它。不過若是 `.dockerignore` 沒有進到 context，daemon 又如何得知 `Dockerfile` 要清掉像是從未存在過一樣?
  - [Consider whitelisting on \.dockerignore instead of blacklisting · Issue \#116 · CachetHQ/Docker](https://github.com/CachetHQ/Docker/issues/116) 後來也改用 whitelisting，先用 `*` 全部排除，再用 `!` 一個個加回來。
  - [Do not ignore \.dockerignore \(it's expensive and potentially dangerous\) \- Codefresh](https://codefresh.io/blog/not-ignore-dockerignore/) (2016-12-08) #ril
  - [17.07.0-ce (2017-08-29) - Docker CE release notes \| Docker Documentation](https://docs.docker.com/release-notes/docker-ce/#17070-ce-2017-08-29) 修正了使用 leading slash 的問題 -- Fix `.dockerignore` entries with a leading `/` not matching anything moby/moby#32088
  - [moby/\.dockerignore at master · moby/moby](https://github.com/moby/moby/blob/master/.dockerignore)
  - [Sample dockerignore for a Rails app](https://gist.github.com/neckhair/ace5d1679dd896b71403fda4bc217b9e)
  - [python\-docs\-samples/\.dockerignore at master · GoogleCloudPlatform/python\-docs\-samples](https://github.com/GoogleCloudPlatform/python-docs-samples/blob/master/container_engine/django_tutorial/.dockerignore)

## 如何打造自己的 image??

  - [library/ubuntu \- Docker Hub](https://hub.docker.com/_/ubuntu/) Supported tags and respective Dockerfile links 提及那麼多個 `Dockerfile`，要如何指定從哪個版本/tag 開始??
  - [Docker Explained: Using Dockerfiles to Automate Building of Images \| DigitalOcean](https://www.digitalocean.com/community/tutorials/docker-explained-using-dockerfiles-to-automate-building-of-images) (2013-12-13) 說明 `Dockerfile` 裡逐層往上疊的概念 (layer-by-layer)，簡單說明 11 個 command 的用法 (有些說明不完整，甚或過時)，最後示範一個 MongoDB 的 image。
  - [wagoodman/dive: A tool for exploring each layer in a docker image](https://github.com/wagoodman/dive) #ril

## 如何管理 image??

  - [docker image \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/image/) 用 `docker image ls` 列出 image，要刪除則用 `docker image rm` #ril
  - [Where are Docker images stored on the host machine? \- Stack Overflow](https://stackoverflow.com/questions/19234831/) Matt: `/var/lib/docker` 會因 Docker 使用的 storage driver 而異；這個討論有點舊，但在 Ubuntu 16.04 + Docker 17.09.0-ce + overlay2 上試過，`/var/lib/docker/` 的結構已經很不一樣 #ril

## 拿到一個 image 後，如何知道它是怎麼被建構出來的??

  - How can I view the Dockerfile in an image? - General Discussions - Docker Forums https://forums.docker.com/t/how-can-i-view-the-dockerfile-in-an-image/5687 andyneff: 除非不是從 Git repo 建出來? 否則在 Docker hub 上應該都看得到 #ril
  - repository - How to generate a Dockerfile from an image? - Stack Overflow https://stackoverflow.com/questions/19104847/ #ril

## Docker Hub?

  - library/nginx - Docker Hub https://hub.docker.com/_/nginx/ 發現 official image 都沒有 namespace，例如 `nginx`，不像 `user/nginx` 之類的。

## 如何建立自己的 Container Registry (Docker Hub)??

  - [GitLab Container Registry \| GitLab](https://about.gitlab.com/2016/05/23/gitlab-container-registry/) #ril
  - [Share your image - Get Started, Part 2: Containers \| Docker Documentation](https://docs.docker.com/get-started/part2/#share-your-image) 除了 Docker's public registry 外還有許多選擇，也可以用 Docker Trusted Registry 建造自己的 private registry。
  - [Docker Trusted Registry 2\.2 overview \| Docker Documentation](https://docs.docker.com/datacenter/dtr/2.2/guides/) #ril

## 多個 Dockerfile??

  - [nodejs/docker\-node: Official Docker Image for Node\.js](https://github.com/nodejs/docker-node) 看到 `Docker*.template` 的用法 #ril

## 如何將 Docker 應用在平時的開發??

  - [From Vagrant to Docker: How to use Docker for local web development — osteel's blog](http://tech.osteel.me/posts/2015/12/18/from-vagrant-to-docker-how-to-use-docker-for-local-web-development.html) (2015-12-18) #ril

## 如何將現有的 app 搬到 container 裡??

  - Docker - Build, Ship, and Run Any App, Anywhere https://www.docker.com/ WORKS WITH ANY STACK 提到 "Deploy both microservices and traditional apps anywhere without costly rewrites." 不用重寫，但要做哪些調整? 可以把所有 component 都裝在同一個 container 裡?

## 如何在 Pi 上執行 Docker??

  - 在 Raspberry Pi 2 運行 Docker https://openhome.cc/Gossip/CodeData/DockerLayman/DockerLayman2.html #ril
  - Docker comes to Raspberry Pi - Raspberry Pi https://www.raspberrypi.org/blog/docker-comes-to-raspberry-pi/ #ril

## 其他

其他：

  - Learn Docker - Docker https://docs.docker.com/learn/ #ril
  - Get started with Docker - Docker https://docs.docker.com/engine/getstarted/ #ril
  - Learn Docker in 12 Minutes 🐳 - YouTube https://www.youtube.com/watch?v=YFl2mCHdv24 #ril

  - 感覺一個 container 就是一個 process 執行在裡面??
      - 從 `Dockerfile` 裡 `CMD` 的用法看來，一個 container 似乎可以想成一個 application??
      - 假設 app 要連資料庫怎麼辦? 資料庫要運作在另一個 container 裡?? 中間要怎麼連結??
      - docker run 的行為最難懂，什麼是 attach/detach?? 為什麼 container 一跑完就會 exited??
  - Docker Hub 跟 Docker Cloud 有什麼差別??
      - 按 [這裡](https://docs.docker.com/docker-for-mac/) "As an alternative to using Docker Hub to store your public or private images or Docker Trusted Registry," 的說法，Docker Hub 也支援 private image ...
  - Docker 有好多元件組成，一開始好難搞懂其間的關係?? Docker Engine、Docker Compose、Docker Machine ... 另外還有個 Docker Daemon
  - `docker run hello-world` 建議試試 `docker run -it ubuntu bash`
      - 其中 `-i` (`--interactive`) 的作用是 "Keep STDIN open even if not attached"，而 `-t` (`--tty`) 的作用則是 "Allocate a pseudo-TTY"。
      - 最後的 `bash` 是傳給 application 的指令?? 但 `Dockerfile` 裡已經寫 `CMD ["/bin/bash"]`??

## 如何在 Docker 裡包 image??

```
$ docker run --rm --tty \
  --volume $(PWD):/workspace \
  --workdir /workspace \
  docker:dind docker info
Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
```

加上 `/var/run/docker.sock:/var/run/docker.sock` 的對應即可：

```
$ docker run --rm --tty \
  --volume $(PWD):/workspace \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --workdir /workspace \
  docker:dind docker info
...
```

參考資料：

  - [The solution - Using Docker\-in\-Docker for your CI or testing environment? Think twice\.](http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/#the-solution) (2015-09-03) 用 `-v /var/run/docker.sock:/var/run/docker.sock` 來解，但這不是 Docker in Docker? 因為 container 會建在 top-level Docker。

## Timezone ??

  - `docker run --env TZ=XXX` 的做法似乎只能作用在該 process，比較全面的做法應該是改寫 `/etc/localtime`?

參考資料：

  - [date \- Docker Container time & timezone \(will not reflect changes\) \- Server Fault](https://serverfault.com/questions/683605/) 可以從 `TZ` 環境變數下手，例如 `docker run --env TZ=Asia/Taipei` #ril
  - [Be Careful About TimeZone Configuration While Playing With Docker](https://medium.com/@ibrahimgunduz34/be-careful-while-playing-docker-about-timezone-configuration-e7a2217e9b76) (2018-07-26) #ril
  - [Time in Docker Containers – The Blog of Ivan Krizsan](https://www.ivankrizsan.se/2015/10/31/time-in-docker-containers/) (2015-10-31) #ril

## The input device is not a TTY

  - 在 GitLab CI 上執行 `docker run -it` 會直接噴 `The input device is not a TTY` 的錯誤，不過只用 `-t, --tty` 時就沒這個問題，而且在本地開發時，也可以按 `Ctrl-C` 中斷 container (而且輸出也會有顏色)，那 `-i` 什麼時候要加?

參考資料：

  - [docker \- Error "The input device is not a TTY" \- Stack Overflow](https://stackoverflow.com/questions/43099116/) #ril
      - Anthony: 在 `Jenkinsfile` 裡執行 `docker run --it ...` 時遇到 `The input device is not a TTY` 的錯誤。
      - Gareth A. Lloyd: 在本地端開發時，可以按 `Ctrl-C` 很方便；用 `test -t 1 && USE_TTY="-t"` 判斷，再用 `docker run ${USE_TTY}` 執行。
  - [gruntjs \- How to workaround "the input device is not a TTY" when using grunt\-shell to invoke a script that calls docker run? \- Stack Overflow](https://stackoverflow.com/questions/40536778/) #ril

## 環境變數 {: #environment-variables }

  - [docker run \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/run/) #ril

      - `--env , -e` -- Set environment variables
      - `--env-file` -- Read in a file of environment variables

    Set environment variables (`-e`, `--env`, `--env-file`)

        $ docker run -e MYVAR1 --env MYVAR2=foo --env-file ./env.list ubuntu bash

      - Use the `-e`, `--env`, and `--env-file` flags to set simple (non-array) environment variables in the container you’re running, or overwrite variables that are defined in the `Dockerfile` of the image you’re running.

      - You can define the variable and its value when running the container:

            $ docker run --env VAR1=value1 --env VAR2=value2 ubuntu env | grep VAR
            VAR1=value1
            VAR2=value2

      - You can also use variables that you’ve EXPORTED to your local environment:

            export VAR1=value1
            export VAR2=value2

            $ docker run --env VAR1 --env VAR2 ubuntu env | grep VAR
            VAR1=value1
            VAR2=value2

      - When running the command, the Docker CLI client checks the value the variable has in your local environment and PASSES IT TO THE CONTAINER. If no `=` is provided and that variable is not exported in your local environment, the variable won’t be set in the container.
      - You can also load the environment variables from a file. This file should use the syntax `<variable>=value` (which sets the variable to the given value) or `<variable>` (which TAKES THE VALUE FROM THE LOCAL ENVIRONMENT), and `#` for comments.

## Testing ??

  - [Container Structure Tests: Unit Tests for Docker Images \| Google Open Source Blog](https://opensource.googleblog.com/2018/01/container-structure-tests-unit-tests.html) (2018-01-09) #ril
  - [Testing Strategies for Docker Containers · Terra Nullius](https://alexei-led.github.io/post/docker_testing/) (2016-03-07) #ril
  - [Tutorial: How to test your docker image in half a second](https://medium.com/@aelsabbahy/tutorial-how-to-test-your-docker-image-in-half-a-second-bbd13e06a4a9) (2017-03-15) #ril

## 安裝設定 {: #installation }

  - [Docker for Mac Release Notes](https://docs.docker.com/docker-for-mac/release-notes/)
  - Install Docker for Mac | Docker Documentation https://docs.docker.com/docker-for-mac/install/ Docker for Mac 是 Docker Community Edition (CE) 的一部份?
  - The Community Edition https://www.docker.com/community-edition #ril

### macOS

  - OS 要求 macOS El Capitan 10.11 以上，硬體要是 2012 年後，用 `sysctl kern.hv_support` 檢查 (要是 `kern.hv_support: 1`)，要求 4GB RAM。
  - 下載 `Docker.dmg` 安裝。
  - 視情況取消 Preferences > Daemon > Experimental features

參考資料：

  - [Install Docker Desktop for Mac \| Docker Documentation](https://docs.docker.com/docker-for-mac/install/) #ril

  - [Docker for Mac doesn't listen on 2375 · Issue \#770 · docker/for\-mac](https://github.com/docker/for-mac/issues/770)

      - Docker for Mac should listen on 2375, providing an HTTP API server.
      - samoht (contributor): For security reasons, we choose to not expose that port directly. However, as described in our FAQ you can run a SOCAT CONTAINER to redirect the Docker API exposed on the unix domain socket in Linux to the port of your choice on your OSX host:

            $ docker run -d -v /var/run/docker.sock:/var/run/docker.sock -p 127.0.0.1:1234:1234 \
                         bobrik/socat TCP-LISTEN:1234,fork UNIX-CONNECT:/var/run/docker.sock

        and then:

            export DOCKER_HOST=tcp://localhost:1234

        採慣用的 2375 port 更直覺。

### Ubuntu

```
$ sudo apt-get update
$ # 讓 apt 可以透過 HTTPS 用 repository?
$ sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
$ # 增加 Docker 官方的 GPG key
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ # 加入 stable repository (這裡以 amd64 為例)
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# 安裝 docker-ce 套件，可以用 docker-ce=VERSION 指定版本
$ apt-get update
$ sudo apt-get install docker-ce

# 最後執行 hello-world image 試看看
$ docker run --rm hello-world
```

執行 `docker` 要 `sudo` 的問題，可以把使用者加到 `docker` group 即可：

```
$ sudo usermod -aG docker USER
$ newgrp docker # 刷新 login session 的群組，不用重新登入
```

參考資料：

  - Docker For Ubuntu | Docker https://www.docker.com/docker-ubuntu 針對 bare metal 及 VM 上的 Ubuntu 優化，分為 Edge (每月) 與 Stable (每季) 兩種版本，也支援 ARM 32 的架構??
  - [Docker Community Edition for Ubuntu \- Docker Store](https://store.docker.com/editions/community/docker-ce-server-ubuntu) 只是一個介紹的頁面，有另一份文件說明詳細的安裝步驟。
  - Get Docker CE for Ubuntu | Docker Documentation https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/ 要花一點時間設定 Docker repository，之後安裝 `docker-ce` 套件即可。
  - How To Install and Use Docker on Ubuntu 16.04 | DigitalOcean https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04 #ril
  - [How To Install and Use Docker on Ubuntu 16\.04 \| DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04) (2016-11-03) Step 2 — Executing the Docker Command Without Sudo (Optional) 提到預設只有 `docker` group 裡的人可以執行，否則要加 `sudo`，把人用 `sudo usermod -aG docker ${USER}` 加入 group 即可 #ril
  - [Post\-installation steps for Linux \| Docker Documentation](https://docs.docker.com/engine/installation/linux/linux-postinstall/) Manage Docker as a non-root user 也是將使用者加入 `docker` 群組，但似乎還有其他設定要調? #ril
  - [How can I use docker without sudo? \- Ask Ubuntu](https://askubuntu.com/questions/477551/) 用 `sudo gpasswd -a USER docker` 加入群組，再重新登入即可 (或用 `newgrp docker` 直接在這個 login session 生效)

### Mac 上的 Docker 要用到 VirtualBox?

  - 早期的 Docker Toolbox 確實採用 VirtualBox，但後來的 Docker for Mac 已改用新的 virtualization system - HyperKit - 基於 macOS 10.10 才有的 `Hypervisor.framework`。

參考資料：

  - Install Docker for Mac | Docker Documentation https://docs.docker.com/docker-for-mac/install/#what-to-know-before-you-install 明確提到 "With Docker for Mac, you have a new, native virtualization system running (HyperKit) which takes the place of the VirtualBox system." 及 "If your system does not satisfy these requirements, you can install Docker Toolbox, which uses Oracle VirtualBox instead of HyperKit."，但為什麼又說 VirtualBox prior to version 4.3.30 must NOT be installed?
  - Docker Toolbox overview | Docker Documentation https://docs.docker.com/toolbox/overview/ Docker Toolbox 已被 Docker for Mac 與 Docker for Windows 取代，What’s in the box 提到內含 Oracle VirtualBox。
  - Frequently asked questions (FAQ) | Docker Documentation https://docs.docker.com/docker-for-mac/faqs/#what-is-dockerapp 明確指出 Docker for Mac 使用 macOS Hypervisor.framework (macOS 10.10 Yosemite 才有)，不需要 VirtualBox。
  - Frequently asked questions (FAQ) | Docker Documentation https://docs.docker.com/docker-for-mac/faqs/#what-is-the-benefit-of-hyperkit HyperKit 是基於 Hypervisor.framework 的 hypervisor，不需要依賴 Oracle VirtualBox 或 VMware Fusion。

### Raspberry Pi ??

  - Docker comes to Raspberry Pi - Raspberry Pi https://www.raspberrypi.org/blog/docker-comes-to-raspberry-pi/ #ril
  - Getting started with Docker on your Raspberry Pi · Docker Pirates ARMed with explosive stuff https://blog.hypriot.com/getting-started-with-docker-on-your-arm-device/ #ril
  - 5 things about Docker on Raspberry Pi https://blog.alexellis.io/5-things-docker-rpi/ #ril
  - How to install Docker on your Raspberry Pi - howchoo https://howchoo.com/g/nmrlzmq1ymn/how-to-install-docker-on-your-raspberry-pi #ril

## 參考資料 {: #reference }

  - [Docker Hub](https://hub.docker.com/)
  - [Awesome-docker](https://awesome-docker.netlify.com/) 整理 Docker 相關資源、工具

社群：

  - [Docker Forums](https://forums.docker.com/)
  - ['docker' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/docker)

工具：

  - [Dockly](dockly.md) - Docker TUI

更多：

  - [Daemon](docker-daemon.md)
  - [Networking](docker-networking.md)
  - [Compose](docker-compose.md)
  - [Swarm](docker-swarm.md)

手冊：

  - [Docker CE Release Notes](https://docs.docker.com/release-notes/docker-ce/)
  - [`Dockerfile` reference](https://docs.docker.com/engine/reference/builder/)
  - [`docker`](https://docs.docker.com/engine/reference/commandline/docker/)
  - [`dockerd`](https://docs.docker.com/engine/reference/commandline/dockerd/)

