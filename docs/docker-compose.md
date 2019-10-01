---
title: Docker / Compose
---
# [Docker](docker.md) / Compose

  - [Overview of Docker Compose \| Docker Documentation](https://docs.docker.com/compose/overview/)

      - Compose is a tool for defining and running MULTI-CONTAINER Docker applications.

        With Compose, you use a YAML file to configure your application’s SERVICES. Then, with a single command, you create and start all the services from your configuration.

        包括 volume、networking 等的建立。

      - Compose works in all environments: production, staging, development, testing, as well as CI workflows.

        主要是 (local) development、testing 跟 CI 可以共用 composition，專案初期自己 hosting 時也很實用，雖然真正的 production 跟 staging 不一定會用 compose。

  - [docker/compose: Define and run multi\-container applications with Docker](https://github.com/docker/compose) #ril

## 跟 Swarm Mode 的關係??

  - [Version 3 - Compose file versions and upgrading \| Docker Documentation](https://docs.docker.com/compose/compose-file/compose-versioning/#version-3) Version 3 的定位是 "Designed to be cross-compatible between Compose and the Docker Engine’s swarm mode"
  - [Use Compose with Swarm \| Docker Documentation](https://docs.docker.com/compose/swarm/) 這份文件在講 standalone Swarm，但 Docker 1.12 開始已經 Swarm Mode 整合進 Docker Engine #ril

## Hello, World! ??

`docker-compose.yaml`:

```
proxy:
    image: nginx
    volumes:
        - ./proxy-default.conf:/etc/nginx/conf.d/default.conf
    ports:
        - "80:80"

web:
    image: nginx
    volumes:
        - ./web.conf:/etc/nginx/conf.d/deafault.conf
        - ./dist:/usr/share/nginx/html
    expose:
        - "3030"
    ports:
        - "3030:3030"
```

## 新手上路 {: #getting-started }

  - [Overview of Docker Compose \| Docker Documentation](https://docs.docker.com/compose/overview/)

      - Using Compose is basically a three-step process:

          - Define your app’s environment with a `Dockerfile` so it can be reproduced anywhere.

          - Define the services that make up your app in `docker-compose.yml` so they can be RUN TOGETHER IN AN ISOLATED ENVIRONMENT.

            通常位在同一個 network 裡，但各自執行不在同的 container 裡。

          - Run `docker-compose up` and Compose starts and runs your entire app.

      - A `docker-compose.yml` looks like this:

            version: '3' # 必須要是個 string
            services:
              web:       # service name，會成為 image/container name 的一部份
                build: . # 包括 application 自己，都是 service，只是自己要先 build
                ports:
                - "5000:5000"
                volumes: # 支援 bind mount 跟 volume
                - .:/code
                - logvolume01:/var/log
                links:   # container link (legacy)
                - redis
              redis:
                image: redis
            volumes:
              logvolume01: {}

      - Compose has commands for managing the whole lifecycle of your application:

          - Start, stop, and rebuild services
          - View the status of running services
          - Stream the log output of running services
          - Run a ONE-OFF COMMAND on a service ??

    Multiple isolated environments on a single host

      - Compose uses a PROJECT NAME to isolate environments from each other. You can make use of this project name in several different contexts:

          - on a dev host, to create multiple copies of a single environment, such as when you want to run a stable copy for each feature branch of a project
          - on a CI server, to keep builds from interfering with each other, you can set the project name to a UNIQUE BUILD NUMBER
          - on a shared host or dev host, to prevent different projects, which may use the same service names, from interfering with each other

        原來 `services:` 下面定義的 (service) name，只是做為 container name 的一部份 (甚至是 image name 的一部份)，不用擔心多個 user/project 間會有命名上的衝突。例如上面的 `redis` service，在執行期的 container name 可能是 `myproject_redis_1`。

        類似的機制在 volume 上也會有，例如上面的 `logvolume01` 最後的名稱可能是 `myproject_logvolume01`。

        只是 port mapping 如何避免衝突 ??

      - The default project name is the BASENAME OF THE PROJECT DIRECTORY. You can set a custom project name by using the `-p` command line option or the `COMPOSE_PROJECT_NAME` environment variable.

        實驗發現，如果沒有自訂 project name，在 compose file 裡取 `COMPOSE_PROJECT_NAME` 並不會拿到預設值。

    Preserve volume data when containers are created

      - Compose preserves all volumes used by your services. When `docker-compose up` runs, if it finds any containers from previous runs, it COPIES THE VOLUMES from the old container to the new container. This process ensures that any data you’ve created in volumes isn’t lost.

        不過 `docker-compose down` 會把 container 都刪除，就算是用 Ctrl-C (或 `docker-compose stop) 停掉 container，下次也會延用相同的 container，何來 "copies the volumes from the old container" 的效果 ??

    Only recreate containers that have changed

      - Compose caches the CONFIGURATION used to create a container. When you RESTART a service that has not changed, Compose re-uses the existing containers. Re-using containers means that you can make changes to your environment very quickly.

        針對 `docker-compose restart`。所謂 not changed 是指 variable substitution、`extends` 合併後的結果沒有變 ??

    Variables and moving a COMPOSITION between environments

      - Compose supports VARIABLES in the Compose file. You can use these variables to customize your composition for different environments, or different users. See VARIABLE SUBSTITUTION for more details.

      - You can extend a Compose file using the `extends` field or by creating MULTIPLE Compose files.

        其中 `extends` 的做法在 Compose v2.1 後就不支援。

  - [Common Use Cases - Overview of Docker Compose \| Docker Documentation](https://docs.docker.com/compose/overview/#common-use-cases)

    Development environments

      - When you’re developing software, the ability to run an application in an isolated environment and interact with it is crucial. The Compose command line tool can be used to create the environment and interact with it.

        這奠定了 automated testing 的基礎

      - The Compose file provides a way to DOCUMENT and configure all of the application’s service DEPENDENCIES (databases, queues, caches, web service APIs, etc). Using the Compose command line tool you can create and start one or more containers for each dependency with a single command (`docker-compose up`).

      - Together, these features provide a convenient way for developers to GET STARTED ON A PROJECT. Compose can reduce a multi-page “developer getting started guide” to a single machine readable Compose file and a few commands.

        做為簡化開發流程的工具，同時也是 documentation；[搭配 `Makefile` 更好用](https://github.com/search?q=filename%3AMakefile+docker-compose&type=Code)。

    Automated testing environments

      - An important part of any Continuous Deployment or Continuous Integration process is the automated test suite. AUTOMATED END-TO-END TESTING requires an environment in which to run tests.

      - Compose provides a convenient way to create and destroy ISOLATED TESTING ENVIRONMENTS for your test suite. By defining the full environment in a Compose file, you can create and destroy these environments in just a few commands:

            $ docker-compose up -d
            $ ./run_tests
            $ docker-compose down

        如何確保 `docker-compose down` 一定會被執行 ??

    Single host deployments

      - Compose has traditionally been focused on development and testing workflows, but with each release we’re making progress on more PRODUCTION-ORIENTED FEATURES.

      - You can use Compose to deploy to a remote Docker Engine. The Docker Engine may be a single instance provisioned with Docker Machine or an entire Docker Swarm cluster.

        也可以用在 deployment!! 用 Docker Machine 將 `docker` 轉向，自然 `docker-compose` 就能作用在另一個 Docker host。

  - [Get started with Docker Compose \| Docker Documentation](https://docs.docker.com/compose/gettingstarted/)

      - On this page you build a simple Python web application running on Docker Compose. The application uses the Flask framework and maintains a hit counter in Redis. While the sample uses Python, the concepts demonstrated here should be understandable even if you’re not familiar with it.

    Step 1: Setup

      - Define the application dependencies.

        Create a directory for the project:

            $ mkdir composetest
            $ cd composetest

      - Create a file called `app.py` in your project directory and paste this in:

            import time

            import redis
            from flask import Flask

            app = Flask(__name__)
            cache = redis.Redis(host='redis', port=6379)

            def get_hit_count():
                retries = 5
                while True:
                    try:
                        return cache.incr('hits')
                    except redis.exceptions.ConnectionError as exc:
                        if retries == 0:
                            raise exc
                        retries -= 1
                        time.sleep(0.5)

            @app.route('/')
            def hello():
                count = get_hit_count()
                return 'Hello World! I have been seen {} times.\n'.format(count)

            if __name__ == "__main__":
                app.run(host="0.0.0.0", debug=True)

        In this example, `redis` is the hostname of the redis container on the APPLICATION’S NETWORK. We use the default port for Redis, 6379.

      - Handling TRANSIENT ERRORS

        Note the way the `get_hit_count` function is written. This basic retry loop lets us attempt our request multiple times if the redis service is not available.

        This is useful at STARTUP while the application comes online, but also makes our application more RESILIENT if the Redis service needs to be restarted anytime during the app’s lifetime. In a cluster, this also helps handling MOMENTARY CONNECTION DROPS between nodes.

      - Create another file called `requirements.txt` in your project directory and paste this in:

            flask
            redis

    Step 2: Create a Dockerfile

      - In this step, you write a `Dockerfile` that builds a Docker image. The image contains all the dependencies the Python application requires, including Python itself.

      - In your project directory, create a file named `Dockerfile` and paste the following:

            FROM python:3.4-alpine
            ADD . /code
            WORKDIR /code
            RUN pip install -r requirements.txt
            CMD ["python", "app.py"]

    Step 3: Define services in a Compose file

      - Create a file called `docker-compose.yml` in your project directory and paste the following:

            version: '3'
            services:
              web:
                build: .
                ports:
                 - "5000:5000"
              redis:
                image: "redis:alpine"

      - This Compose file defines two services, `web` and `redis`. The `web` service:

          - Uses an image that’s built from the `Dockerfile` in the current directory.
          - Forwards the exposed port 5000 on the container to port 5000 on the host machine. We use the default port for the Flask web server, 5000.

        也就是 image 的來源有兩種 -- 自己建立 (`build:`) 或用現成的 (`image:`)。

      - The `redis` service uses a public Redis image pulled from the Docker Hub registry.

    Step 4: Build and run your app with Compose

      - From your project directory, start up your application by running `docker-compose up`.

            $ docker-compose up
            Creating network "composetest_default" with the default driver
            Creating composetest_web_1 ...
            Creating composetest_redis_1 ...
            Creating composetest_web_1
            Creating composetest_redis_1 ... done
            Attaching to composetest_web_1, composetest_redis_1
            web_1    |  * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
            redis_1  | 1:C 17 Aug 22:11:10.480 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
            redis_1  | 1:C 17 Aug 22:11:10.480 # Redis version=4.0.1, bits=64, commit=00000000, modified=0, pid=1, just started
            redis_1  | 1:C 17 Aug 22:11:10.480 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
            web_1    |  * Restarting with stat
            redis_1  | 1:M 17 Aug 22:11:10.483 * Running mode=standalone, port=6379.
            redis_1  | 1:M 17 Aug 22:11:10.483 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
            web_1    |  * Debugger is active!
            redis_1  | 1:M 17 Aug 22:11:10.483 # Server initialized
            redis_1  | 1:M 17 Aug 22:11:10.483 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
            web_1    |  * Debugger PIN: 330-787-903
            redis_1  | 1:M 17 Aug 22:11:10.483 * Ready to accept connections

        Compose pulls a Redis image, builds an image for your code, and starts the services you defined. In this case, the code is statically copied into the image at build time.

      - Enter http://0.0.0.0:5000/ in a browser to see the application running.

        If you’re using Docker natively on Linux, Docker Desktop for Mac, or Docker Desktop for Windows, then the web app should now be listening on port 5000 on your Docker daemon host. Point your web browser to http://localhost:5000 to find the Hello World message. If this doesn’t resolve, you can also try http://0.0.0.0:5000.

        If you’re using Docker Machine on a Mac or Windows, use `docker-machine ip MACHINE_VM` to get the IP address of your Docker host. Then, open `http://MACHINE_VM_IP:5000` in a browser.

      - You should see a message in your browser saying:

            Hello World! I have been seen 1 times.

        Refresh the page. The number should increment.

      - Switch to another terminal window, and type `docker image ls` to list local images.

        Listing images at this point should return `redis` and `web`.

            $ docker image ls
            REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
            composetest_web         latest              e2c21aa48cc1        4 minutes ago       93.8MB
            python                  3.4-alpine          84e6077c7ab6        7 days ago          82.5MB
            redis                   alpine              9d8fa9aa0e5b        3 weeks ago         27.5MB

        You can inspect images with `docker inspect <tag or id>`.

        從 `composetest_web` 觀察到，不只 container 會被冠上 project name，連 image 也會。

      - Stop the application, either by running `docker-compose down` from within your project directory in the second terminal, or by hitting `CTRL+C` in the original terminal where you started the app.

        實驗發現，`docker-compose down` 跟 Ctrl-C 的效果不同，前者會把 container、network 等都刪除，但 Ctrl-C 會留著，效果同 `docker-compose stop`。

        另外重複執行 `docker-compose down` 並不會出錯，用在專案 cleanup 很方便。

    Step 5: Edit the Compose file to add a bind mount

      - Edit `docker-compose.yml` in your project directory to add a bind mount for the `web` service:

            version: '3'
            services:
              web:
                build: .
                ports:
                 - "5000:5000"
                volumes:
                 - .:/code
              redis:
                image: "redis:alpine"

      - The new `volumes` key mounts the project directory (current directory) on the host to `/code` inside the container, allowing you to MODIFY THE CODE ON THE FLY, without having to rebuild the image.

    Step 6: Re-build and run the app with Compose

      - From your project directory, type `docker-compose up` to build the app with the updated Compose file, and run it.

            $ docker-compose up
            Creating network "composetest_default" with the default driver
            Creating composetest_web_1 ...
            Creating composetest_redis_1 ...
            Creating composetest_web_1
            Creating composetest_redis_1 ... done
            Attaching to composetest_web_1, composetest_redis_1
            web_1    |  * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
            ...

      - Check the Hello World message in a web browser again, and refresh to see the count increment.

    Step 7: Update the application

      - Because the application code is now mounted into the container using a volume, you can make changes to its code and see the changes instantly, without having to rebuild the image.

      - Change the greeting in `app.py` and save it. For example, change the `Hello World!` message to `Hello from Docker!`:

            return 'Hello from Docker! I have been seen {} times.\n'.format(count)

      - Refresh the app in your browser. The greeting should be updated, and the counter should still be incrementing.

        注意過程中 counter 並不會歸零。

    Step 8: Experiment with some other commands

      - If you want to run your services in the background, you can pass the `-d` flag (for “detached” mode) to `docker-compose up` and use `docker-compose ps` to see what is currently running:

            $ docker-compose up -d
            Starting composetest_redis_1...
            Starting composetest_web_1...

            $ docker-compose ps
            Name                 Command            State       Ports
            -------------------------------------------------------------------
            composetest_redis_1   /usr/local/bin/run         Up
            composetest_web_1     /bin/sh -c python app.py   Up      5000->5000/tcp

      - The `docker-compose run` command allows you to run ONE-OFF commands for your services. For example, to see what environment variables are available to the web service:

            $ docker-compose run web env

        實驗發現，在 `docker-compose up` 所有 container 都執行起來後，`docker-compose run` 並不是執行在現有的 container 裡，而是另起一個 container；若要執行在現有的 container 裡，要改用 `docker-compose exec`。

        `docker-compose run` 執行 one-off command 時，通常會搭配 `--no-deps` 避免其他相關的 service 跟著被帶起來。

      - If you started Compose with `docker-compose up -d`, stop your services once you’ve finished with them:

            $ docker-compose stop

      - You can BRING EVERYTHING DOWN, removing the containers entirely, with the `down` command. Pass `--volumes` to also remove the data volume used by the Redis container:

            $ docker-compose down --volumes

        本以為 anonymous volume 會因為 `docker-compose down` 將 container 刪除而跟著消失，但實驗發現並不會，所以真的要用 `--volumes` 才會一併刪除。

  - [Frequently asked questions \| Docker Documentation](https://docs.docker.com/compose/faq/) #ril

## Multiple Isolated Environments ??

  - [Use Compose in production \| Docker Documentation](https://docs.docker.com/compose/production/)

      - When you define your app with Compose in development, you can use this definition to run your application in different environments such as CI, staging, and production.

      - The easiest way to deploy an application is to run it ON A SINGLE SERVER, similar to how you would run your development environment. If you want to scale up your application, you can run Compose apps on a Swarm cluster.

        這在專案初期由開發團隊 self-hosting 時很方便。

    Modify your Compose file for production

      - You probably need to make changes to your app configuration to make it ready for production. These changes may include:

          - Removing any volume bindings for application code, so that code stays inside the container and can’t be changed from outside
          - Binding to different ports on the host
          - Setting environment variables differently, such as when you need to decrease the verbosity of logging, or to enable email sending)
          - Specifying a RESTART POLICY like `restart: always` to avoid downtime
          - Adding extra services such as a LOG AGGREGATOR ??

      - For this reason, consider defining an ADDITIONAL Compose file, say `production.yml`, which specifies production-appropriate configuration. This configuration file only needs to include the changes you’d like to make from the original Compose file.

        The additional Compose file can be APPLIED OVER the original `docker-compose.yml` to create a new configuration.

      - Once you’ve got a second configuration file, tell Compose to use it with the `-f` option:

            docker-compose -f docker-compose.yml -f production.yml up -d

        See Using multiple compose files for a more complete example.

        注意預設的 `docker-compose.yml` 也要明確寫出來。

    Deploying changes

      - When you make changes to your app code, remember to rebuild your image and recreate your app’s containers. To redeploy a service called `web`, use:

            $ docker-compose build web
            $ docker-compose up --no-deps -d web

        This first rebuilds the image for `web` and then stop, destroy, and recreate just the `web` service. The `--no-deps` flag prevents Compose from also recreating any services which `web` depends on.

        其中 "depends on" 指的應該是 `depends_on:` 的用法，跟 `links:` 有關嗎 ??

    Running Compose on a single server

      - You can use Compose to deploy an app to a remote Docker host by setting the `DOCKER_HOST`, `DOCKER_TLS_VERIFY`, and `DOCKER_CERT_PATH` environment variables appropriately.

        For tasks like this, Docker Machine makes managing local and remote Docker hosts very easy, and is recommended even if you’re not deploying remotely.

      - Once you’ve set up your environment variables, all the normal `docker-compose` commands work with no further configuration.

        透過 Docker Machine 可以簡化上面環境變數的設定，一旦 Docker host 轉向後，`docker-compose` 就會作用在另一台機器上。

    Running Compose on a Swarm cluster

      - Docker Swarm, a Docker-native clustering system, exposes the same API as a SINGLE DOCKER HOST, which means you can use Compose against a Swarm instance and run your apps ACROSS MULTIPLE HOSTS.

        Read more about the Compose/Swarm integration in the integration guide.

        原來 Swam 從外面看起來就像一般的 Docker host，背後會自動協調多台實體機器。

  - [Share Compose configurations between files and projects \| Docker Documentation](https://docs.docker.com/compose/extends/)

      - Compose supports two methods of sharing common configuration:

          - Extending an ENTIRE Compose file by using multiple Compose files

          - Extending INDIVIDUAL SERVICES with the `extends` field (for Compose file versions up to 2.1)

            也就是 v3 已不支援這種用法。

      - Using multiple Compose files enables you to customize a Compose application for different environments or DIFFERENT WORKFLOWS.

    Understanding multiple Compose files

      - By default, Compose reads two files, a `docker-compose.yml` and an optional `docker-compose.override.yml` file. By convention, the `docker-compose.yml` contains your base configuration. The override file, as its name implies, can contain configuration OVERRIDES FOR EXISTING SERVICES or ENTIRELY NEW SERVICES.

        If a service is defined in both files, Compose MERGES the configurations using the rules described in Adding and overriding configuration.

        下面提到，其他 override file 不一定要是完整的 compose file。

      - To use multiple OVERRIDE FILES, or an override file with a different name, you can use the `-f` option to specify the list of files. Compose merges files IN THE ORDER they’re specified on the command line. See the `docker-compose` command reference for more information about using `-f`.

      - When you use multiple configuration files, you must make sure all paths in the files are RELATIVE to the BASE Compose file (the first Compose file specified with `-f`).

        This is required because override files need NOT be valid Compose files. Override files can contain small FRAGMENTS of configuration. Tracking which fragment of a service is relative to which path is difficult and confusing, so to keep paths easier to understand, all paths must be defined relative to the BASE FILE.

        從 base compose file 就是第一個 `-f` 看來，`docker-compose.yml` 在使用 override files 時也要給。

        雖然說 "not to be valid compose file"，但是至少要宣告相同的 `version:`，否則會遇到類似下面的錯誤：

            ERROR: Version mismatch: file ./docker-compose.yml specifies version 3.0 but extension file ./docker-compose.local.yml uses version 1

    DIFFERENT ENVIRONMENTS

      - A common use case for multiple files is changing a development Compose app for a production-like environment (which may be production, staging or CI). To support these differences, you can SPLIT your Compose configuration into a few different files:

      - Start with a base file that defines the canonical configuration for the services.

            docker-compose.yml

            web:
              image: example/my_web_app:latest
              links:
                - db
                - cache

            db:
              image: postgres:latest

            cache:
              image: redis:latest

      - In this example the development configuration exposes some ports to the host, mounts our code as a volume, and builds the `web` image.

            docker-compose.override.yml

            web:
              build: . # 原本採用指定的 image，這裡改成自己 build
              volumes:
                - '.:/code'
              ports:
                - 8883:80
              environment:
                DEBUG: 'true'

            db:
              command: '-d'
              ports:
                - 5432:5432

            cache:
              ports:
                - 6379:6379

        When you run `docker-compose up` it reads the overrides automatically.

      - Now, it would be nice to use this Compose app in a production environment. So, create another override file (which might be stored in a different git repo or managed by a different team).

        實務上 `docker-compose.prod.yml` 要共用 source repo 裡的 `docker-compose.yml` 也有困難，不過這並代表 multiple compose file 的需求不存在，因為除了 dev 之外，還有 CI 要顧到。

            docker-compose.prod.yml

            web:
              ports:
                - 80:80
              environment:
                PRODUCTION: 'true'

            cache:
              environment:
                TTL: '500'

        To deploy with this production Compose file you can run

            docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

        This deploys all three services using the configuration in `docker-compose.yml` and `docker-compose.prod.yml` (but not the dev configuration in `docker-compose.override.yml`).

    ADMINISTRATIVE TASKS

      - Another common use case is running ADHOC or administrative tasks against one or more services in a Compose app. This example demonstrates running a database backup.

      - Start with a docker-compose.yml.

            web:
              image: example/my_web_app:latest
              links:
                - db

            db:
              image: postgres:latest

      - In a `docker-compose.admin.yml` ADD A NEW SERVICE to run the database export or backup.

            dbadmin:
              build: database_admin/
              links:
                - db

      - To start a normal environment run `docker-compose up -d`. To run a database backup, include the `docker-compose.admin.yml` as well.

            docker-compose -f docker-compose.yml -f docker-compose.admin.yml \
                run dbadmin db-backup

        注意這裡是用 `docker-compose run`，會執行在同 `docker-compose up` 的環境裡，可以連結到 DB。但不能一開始就宣告在 `docker-compose.yml` 裡，但 `docker-compose` 不要執行 ??

    Adding and overriding configuration

      - Compose copies configurations from the original service over to the local one. If a configuration option is defined in both the original service and the local service, the local value replaces or extends the original value.

  - [Exclude service on docker\-compose up, docker\-compose rm, etc · Issue \#1294 · docker/compose](https://github.com/docker/compose/issues/1294)

      - olalonde: I have a service that I just need to run once (dc run createdbs):

            createdbs:
              image: postgres:9.3
              links:
                - db
              command: >
                /bin/bash -c "
                  psql --host=db --username=postgres -c 'CREATE DATABASE testnet;';
                  psql --host=db --username=postgres -c 'CREATE DATABASE livenet;';
                "

        Is it possible to not have it launched every time I run `docker-compose up`? I have looked at alternatives for creating the databases, but I'd rather not have separate file(s) just for this.

      - olalonde: I've solved my problem by using the `docker-compose up myservice` command instead which automatically only launches myservice's dependencies. I realised I actually never really need to do a `docker-compose up`.

        這做法看起來很不錯，不過不小心執行了 `docker-compose up` 會像是踩到雷一樣。

      - dnephin: (contributor) The current options are the list the services in the up command, or split the services between multiple compose files, and only specify some of them when running some commands.

        這就是 [Administrative Tasks - Share Compose configurations between files and projects \| Docker Documentation](https://docs.docker.com/compose/extends/#administrative-tasks) 的用法 -- 在 base file 之上另寫一個 `docker-compose.admin.yml`。

      - dnephin: (contributor) Yes, I think this is covered by #1896.

        In general I think trying to exclude services is NOT GOING TO FIT WELL WITH THE DESIGN OF COMPOSE. Almost all the uses cases that require this are actually trying to do something like "build automation" NOT ACTUALLY RUNNING SERVICES.

        I've been working on a prototype of a tool designed for that purpose. [dobi](https://dnephin.github.io/dobi/) integrates with Compose, so you can do thing adhoc/admin/initialize tasks outside of the `docker-compose.yml`.

      - TMiguelT: Can we not just scale it down to zero? e.g.

            docker-compose up --scale service3=0

        This starts all the services except `service3`

  - [Efficient development with Docker and docker\-compose](https://hackernoon.com/efficient-development-with-docker-and-docker-compose-e354b4d24831) (2018-11-09) #ril
  - [Define services which are not started by default · Issue \#1896 · docker/compose](https://github.com/docker/compose/issues/1896) #ril

## Variable Substitution ??

  - [Environment variables in Compose \| Docker Documentation](https://docs.docker.com/compose/environment-variables/)

    Substitute environment variables in Compose files

      - It’s possible to use environment variables in your shell to populate values inside a Compose file:

            web:
              image: "webapp:${TAG}"

        搭配 Makefile 的話，會更方便對 compose file 填值。

      - `.env` 可以提供 compose file 裡引用到的變數的預設值。

    Set environment variables in containers

      - You can set environment variables in a service’s containers with the `environment` key, just like with `docker run -e VARIABLE=VALUE ...`:

            web:
              environment:
                - DEBUG=1

        注意 `environment` 沒有 `s`，而且底下的寫法有 sequence (`- KEY=VALUE`) 與 mapping (`KEY: VALUE`) 兩種寫法。

    Pass environment variables to containers

      - You can pass environment variables from your shell straight through to a service’s containers with the `environment` key by NOT GIVING THEM A VALUE, just like with `docker run -e VARIABLE ...`:

        注意 set 與 pass 用字上的差別。

            web:
              environment:
                - DEBUG

        The value of the `DEBUG` variable in the container is taken from the value for the same variable in the shell in which Compose is run.

    The “env_file” configuration option

      - You can pass multiple environment variables from an external file through to a service’s containers with the `env_file` option, just like with `docker run --env-file=FILE ...`:

            web:
              env_file:
                - web-variables.env

    Set environment variables with ‘docker-compose run’

      - Just like with `docker run -e`, you can set environment variables on a ONE-OFF container with `docker-compose run -e`:

            docker-compose run -e DEBUG=1 web python console.py

      - You can also pass a variable through from the shell by not giving it a value:

            docker-compose run -e DEBUG web python console.py

        The value of the `DEBUG` variable in the container is taken from the value for the same variable in the shell in which Compose is run.

    The “.env” file

      - You can set DEFAULT VALUES for any environment variables referenced in the Compose file, or used to configure Compose, in an environment file named `.env`:

            $ cat .env
            TAG=v1.5

            $ cat docker-compose.yml
            version: '3'
            services:
              web:
                image: "webapp:${TAG}"

       - When you run `docker-compose up`, the `web` service defined above uses the image `webapp:v1.5`. You can verify this with the `config` command, which prints your RESOLVED application config to the terminal:

            $ docker-compose config

            version: '3'
            services:
              web:
                image: 'webapp:v1.5'

        Values in the shell TAKE PRECEDENCE over those specified in the `.env` file. If you set `TAG` to a different value in your shell, the substitution in image uses that instead:

            $ export TAG=v2.0
            $ docker-compose config

            version: '3'
            services:
              web:
                image: 'webapp:v2.0'

      - When you set the same environment variable in multiple files, here’s the priority used by Compose to choose which value to use:

          - Compose file -- 指 compose file 裡的 `environment:`
          - Shell environment variables
          - Environment file
          - Dockerfile
          - Variable is not defined -- 會出錯 ??

      - In the example below, we set the same environment variable on an Environment file, and the Compose file:

            $ cat ./Docker/api/api.env
            NODE_ENV=test

            $ cat docker-compose.yml
            version: '3'
            services:
              api:
                image: 'node:6-alpine'
                env_file:
                 - ./Docker/api/api.env
                environment:
                 - NODE_ENV=production

        When you run the container, the environment variable defined in the Compose file takes precedence.

            $ docker-compose exec api node

            > process.env.NODE_ENV
            'production'

      - Having any `ARG` or `ENV` setting in a `Dockerfile` evaluates only if there is no Docker Compose entry for environment or `env_file`.

        `ARG` 不會留在 image 裡，為何在 runtime 會有作用 ??

    Configure Compose using environment variables

      - Several environment variables are available for you to configure the Docker Compose command-line behavior. They begin with `COMPOSE_` or `DOCKER_`, and are documented in CLI Environment Variables.

    Environment variables created by links

      - When using the `links` option in a v1 Compose file, environment variables are CREATED FOR EACH LINK. They are documented in the Link environment variables reference. ??

        However, these variables are DEPRECATED. Use the link alias as a hostname instead. 其中 link alias 的用法是什麼 ??

  - [Variable Substitution - Compose file version 3 reference \| Docker Documentation](https://docs.docker.com/compose/compose-file/#variable-substitution)

      - Your configuration options can contain environment variables. Compose uses the variable values from the shell environment in which `docker-compose` is run. For example, suppose the shell contains `POSTGRES_VERSION=9.3` and you supply this configuration:

            db:
              image: "postgres:${POSTGRES_VERSION}"

        When you run `docker-compose up` with this configuration, Compose looks for the `POSTGRES_VERSION` environment variable in the shell and substitutes its value in. For this example, Compose resolves the image to `postgres:9.3` before running the configuration.

      - If an environment variable is not set, Compose substitutes with an EMPTY STRING. In the example above, if `POSTGRES_VERSION` is not set, the value for the image option is `postgres:`.

        為什麼 `$VAR` 不會像 `$$VAR` 一樣發出警告 ??

        You can set default values for environment variables using a `.env` file, which Compose automatically looks for. Values set in the shell environment override those set in the `.env` file.

      - Important: The `.env` file feature only works when you use the `docker-compose up` command and does not work with `docker stack deploy`.

      - Both `$VARIABLE` and `${VARIABLE}` syntax are supported. Additionally when using the 2.1 file format, it is possible to provide INLINE DEFAULT VALUES using typical shell syntax:

          - `${VARIABLE:-default}` evaluates to `default` if `VARIABLE` is UNSET OR EMPTY in the environment.
          - `${VARIABLE-default}` evaluates to `default` ONLY if `VARIABLE` is UNSET in the environment.

      - Similarly, the following syntax allows you to specify MANDATORY variables:

          - `${VARIABLE:?err}` EXITS with an error message containing `err` if `VARIABLE` is unset or empty in the environment.
          - `${VARIABLE?err}` exits with an error message containing `err` if `VARIABLE` is unset in the environment.

      - Other extended shell-style features, such as `${VARIABLE/foo/bar}`, are not supported.

      - You can use a `$$` (double-dollar sign) when your configuration needs a LITERAL DOLLAR SIGN. This also prevents Compose from interpolating a value, so a `$$` allows you to refer to environment variables that you don’t want processed by Compose.

            web:
              build: .
              command: "$$VAR_NOT_INTERPOLATED_BY_COMPOSE"

        If you forget and use a single dollar sign ($), Compose interprets the value as an environment variable and warns you:

            The VAR_NOT_INTERPOLATED_BY_COMPOSE is not set. Substituting an empty string.

  - [environment - Compose file version 3 reference \| Docker Documentation](https://docs.docker.com/compose/compose-file/#environment)

      - Add environment variables. You can use either an array or a dictionary.

        Any boolean values; `true`, `false`, `yes` `no`, need to be ENCLOSED IN QUOTES to ensure they are NOT CONVERTED to `True` or `False` by the YML parser.

        這是採用 dictionary 可能會踩到的雷。

      - Environment variables with ONLY A KEY are resolved to their values on the machine Compose is running on, which can be helpful for SECRET or host-specific values.

            environment:
              RACK_ENV: development
              SHOW: 'true'
              SESSION_SECRET:

            environment:
              - RACK_ENV=development
              - SHOW=true
              - SESSION_SECRET

        只寫 key 的用法也適用於 dictionary 的表示法。

  - [Declare default environment variables in file \| Docker Documentation](https://docs.docker.com/compose/env-file/) #ril

## Networking ??

  - [Networking in Compose \| Docker Documentation](https://docs.docker.com/compose/networking/)

      - By default Compose sets up a SINGLE NETWORK for your app. Each container for a service JOINS the DEFAULT network and is both REACHABLE by other containers on that network, and DISCOVERABLE by them at a hostname IDENTICAL TO THE CONTAINER NAME.

        這裡 "hostname identical to the container name" 的說法不完全正確，從下面的例子看來，雖然 container 最後會被冠上 project name，但 hostname 還是等同 service name；預設的 network 還真的叫做 `<project_name>_default`。

      - For example, suppose your app is in a directory called `myapp`, and your `docker-compose.yml` looks like this:

            version: "3"
            services:
              web:
                build: .
                ports:
                  - "8000:8000"
              db:
                image: postgres
                ports:
                  - "8001:5432"

        When you run `docker-compose up`, the following happens:

          - A network called `myapp_default` is created.
          - A container is created using web’s configuration. It joins the network `myapp_default` under the name `web`.
          - A container is created using db’s configuration. It joins the network `myapp_default` under the name `db`.

        Each container can now look up the hostname `web` or `db` and get back the appropriate container’s IP address. For example, web’s application code could connect to the URL `postgres://db:5432` and start using the Postgres database.

      - It is important to note the distinction between `HOST_PORT` and `CONTAINER_PORT`. In the above example, for `db`, the `HOST_PORT` is `8001` and the container port is `5432` (postgres default). Networked SERVICE-TO-SERVICE COMMUNICATION use the `CONTAINER_PORT`. When `HOST_PORT` is defined, the service is accessible outside the swarm as well.

        通常是 dev 才會把 port 公開出來，否則在環境內 container 本來就可以溝通。

      - Within the `web` container, your connection string to `db` would look like `postgres://db:5432`, and from the host machine, the connection string would look like `postgres://{DOCKER_IP}:8001`.

    Update containers

      - If you make a configuration change to a service and run `docker-compose up` to UPDATE IT, the old container is removed and the new one joins the network under a DIFFERENT IP ADDRESS BUT THE SAME NAME. Running containers can look up that name and connect to the new address, but the old address stops working.

        原來 up 除了有 bring up，還有 update 的意思。

      - If any containers have connections open to the old container, they are CLOSED. It is a CONTAINER’S RESPONSIBILITY to detect this condition, look up the name again and reconnect.

        也就是 [Get started with Docker Compose \| Docker Documentation](https://docs.docker.com/compose/gettingstarted/) 提到的 "makes our application more resilient"。

    Links

      - Links allow you to define extra aliases by which a service is reachable from another service. They are NOT REQUIRED to enable services to communicate - by default, any service can reach any other service at that SERVICE’S NAME. In the following example, `db` is reachable from `web` at the hostnames `db` AND `database`:

            version: "3"
            services:

              web:
                build: .
                links:
                  - "db:database"
              db:
                image: postgres

        See the links reference for more information.

        如果本來 container 間就可以透過 service name 溝通，那 compose 裡為什麼要有 `links:` 的設計 ??

    Specify custom networks

      - Instead of just using the DEFAULT APP NETWORK, you can specify your own networks with the TOP-LEVEL `networks` key. This lets you create more complex TOPOLOGIES and specify custom network drivers and options. You can also use it to connect services to EXTERNALLY-CREATED NETWORKS which aren’t managed by Compose.

      - Each service can specify what networks to connect to with the SERVICE-LEVEL `networks` key, which is a list of names referencing entries under the top-level `networks` key.

        一個 service 可以同時接到多個 network。

      - Here’s an example Compose file defining two custom networks. The `proxy` service is ISOLATED from the `db` service, because they do not share a network in common - only `app` can talk to both.

        呼應上面 "more topologies" 的訴求，開發時期可以儘可能模擬 production 的環境。

            version: "3"
            services:

              proxy:
                build: ./proxy
                networks:
                  - frontend
              app:
                build: ./app
                networks:
                  - frontend
                  - backend
              db:
                image: postgres
                networks:
                  - backend

            networks:
              frontend:
                # Use a custom driver
                driver: custom-driver-1
              backend:
                # Use a custom driver which takes special options
                driver: custom-driver-2
                driver_opts:
                  foo: "1"
                  bar: "2"

      - Networks can be configured with static IP addresses by setting the `ipv4_address` and/or `ipv6_address` for each attached network.

      - Networks can also be given a custom name (since version 3.5):

            version: "3.5"
            networks:
              frontend:
                name: custom_frontend
                driver: custom-driver-1

    Configure the default network

      - Instead of (or as well as) specifying your own networks, you can also change the settings of the APP-WIDE DEFAULT NETWORK by defining an entry under `networks` named `default`:

            version: "3"
            services:

              web:
                build: .
                ports:
                  - "8000:8000"
              db:
                image: postgres

            networks:
              default:
                # Use a custom driver
                driver: custom-driver-1

    Use a pre-existing network

      - If you want your containers to join a PRE-EXISTING NETWORK, use the external option:

            networks:
              default:
                external:
                  name: my-pre-existing-network

        Instead of attempting to create a network called `[projectname]_default`, Compose looks for a network called `my-pre-existing-network` and connect your app’s containers to it.

## Compose File ??

  - [Compose file version 3 reference \| Docker Documentation](https://docs.docker.com/compose/compose-file/) #ril

    Compose and Docker compatibility matrix

      - There are several versions of the Compose file format – 1, 2, 2.x, and 3.x. The table below is a quick look. For full details on what each version includes and how to upgrade, see About versions and upgrading.

        This table shows which Compose file versions support specific Docker releases.

        因為某個 option 的加入通常跟 Docker Engine 支援新的功能有關，所以整理了 format version 跟 Docker Engine 版本的關係；注意這裡講的是 format version 而非 Docker Compose 工具本身的 version。

      - In addition to Compose file format versions shown in the table, the Compose itself is on a release schedule, as shown in Compose releases, but file format versions do not necessarily increment with each release.

        For example, Compose file format 3.0 was first introduced in Compose release 1.10.0, and versioned gradually in subsequent releases.

    Specifying durations

      - Some configuration options, such as the `interval` and `timeout` sub-options for `check`, accept a duration as a string in a format that looks like this:

            2.5s
            10s
            1m30s
            2h32m
            5h34m56s

        The supported units are `us` ??, `ms`, `s`, `m` and `h`.

  - [Docker Compose release notes \| Docker Documentation](https://docs.docker.com/release-notes/docker-compose/) 很多變更都是針對 compose file version XXX，也通常會補充 "This version requires to be used with Docker Engine XXX or above"，也就是說 compose file 某個新版本，需要 Docker Compose 與 Docker Engine 配合好。
  - [Compose file versions and upgrading \| Docker Documentation](https://docs.docker.com/compose/compose-file/compose-versioning/) Compose 有自己的 release schedule，但不一定每次都會有新的 file format；就算 Compose 可以讀取 compose file，也要看 Engine 支不支援某項設定，也之所以 Compatibility matrix 才會用 Compose file format x Docker Engine release 來表現?
  - [Versioning - Compose file versions and upgrading \| Docker Documentation](https://docs.docker.com/compose/compose-file/compose-versioning/#versioning) 在 YAML root 用 `version: '3'` 指明 file version (預設視為 legacy version 1)，建議使用 version 3.x。而 version 會影響到 configuration keys 的用法、要求的 Docker Engine 版本、Compose 跟 networking 相關的行為。

## Build ??

---

參考資料：

  - [docker\-compose build \| Docker Documentation](https://docs.docker.com/compose/reference/build/)

      - Services are built once and then tagged, by default as `project_service`. For example, `composetest_db`.

        If the Compose file specifies an image name, the image is tagged with that name, SUBSTITUTING ANY VARIABLES BEFOREHAND. See variable substitution.

        這表示可以透過變數來指定 image name 跟 tag。

        由於 image name 的規則 `project_service`，如果需要對同一個 image 做多個 tag，可以按規則推導 image name，直接調用 `docker tag` -- 因為沒有 `docker-compose tag` 的用法。

      - If you change a service’s `Dockerfile` or the CONTENTS OF ITS BUILD DIRECTORY, run `docker-compose build` to rebuild it.

  - [image - Compose file version 3 reference \| Docker Documentation](https://docs.docker.com/compose/compose-file/#image)

      - Specify the image to start the container from. Can either be a repository/tag or a partial image ID.

            image: redis
            image: ubuntu:14.04
            image: tutum/influxdb
            image: example-registry.com:4000/postgresql
            image: a4bc65fd

      - If the image does not exist, Compose attempts to pull it, unless you have also specified `build`, in which case it builds it using the specified options AND TAGS IT with the specified tag.

  - [docker\-compose push \| Docker Documentation](https://docs.docker.com/compose/reference/push/) #ril

  - [docker\-compose tag \[service\] \[image\]:\[tag\] · Issue \#5984 · docker/compose](https://github.com/docker/compose/issues/5984)

      - y3ti: Would be nice to be able to tag images created by `docker-compose build` e.g.

      - shin-: (contributor) Thanks for the suggestion! However, it's not part of the featureset we envision for Compose.

        Note that you can already give your built image a custom name by adding an `image` property to your service definition.

        但如果要對同一個 image 做多個 tag 就無法了。

  - [docker\-compose build multiple tags · Issue \#4976 · docker/compose](https://github.com/docker/compose/issues/4976)

      - Puneeth-n: I was wondering if it is possible to build docker images using docker-compose file with multiple tags?
      - shin-: (contributor) No, that is not currently possible.
      - dirkschneemann: See [this answer on StackOverflow](https://stackoverflow.com/a/47327980/2545732) for a couple of possible work-arounds to this issue.

      - mixja: you can do this natively in docker-compose as follows:

            services:
              # build is your actual build spec
              build:
                image: myrepo/myimage
                build:
                  context: .
                ...
                ...
              # these extend from build and just add new tags statically or from environment variables
              version_tag:
                extends: build
                image: myrepo/myimage:v1.0
              some_other_tag:
                extends: build
                image: myrepo/myimage:${SOME_OTHER_TAG}

        With the above in place, you can then just run `docker-compose build` and `docker-compose push` and you will build and push the correct set of tagged images

        不過 `extends` 在 compose v3 後就不支援了，而且因此而虛增很多不是 service 的 service 也很奇怪。

  - [How to use multiple image tags with docker\-compose \- Stack Overflow](https://stackoverflow.com/questions/47327979/) #ril

## Storage ??

  - [volumes - Compose file version 3 reference \| Docker Documentation](https://docs.docker.com/compose/compose-file/#volumes) #ril

      - Mount HOST PATHS or NAMED VOLUMES, specified as sub-options to a service.

        其中 host paths 指的就是 bind mount，跟 volume 不同。

      - You can mount a host path as part of a definition for a single service, and there is no need to define it in the top level `volumes` key.

        But, if you want to reuse a volume ACROSS MULTIPLE SERVICES, then define a named volume in the top-level `volumes` key. Use named volumes with services, swarms, and stack files.

        Note: The top-level `volumes` key defines a named volume and REFERENCES ?? it from each service’s `volumes` list. This replaces `volumes_from` in earlier versions of the Compose file format. See Use volumes and Volume Plugins for general information on volumes.

      - This example shows a named volume (`mydata`) being used by the `web` service, and a bind mount defined FOR A SINGLE SERVICE (first path under `db` service `volumes`).

        The `db` service also uses a named volume called `dbdata` (second path under `db` service `volumes`), but defines it using the OLD STRING FORMAT for mounting a named `volume`. Named volumes must be listed under the top-level `volumes` key, as shown.

            version: "3.7"
            services:
              web:
                image: nginx:alpine
                volumes:
                  - type: volume
                    source: mydata
                    target: /data
                    volume:
                      nocopy: true
                  - type: bind
                    source: ./static
                    target: /opt/app/static

              db:
                image: postgres:latest
                volumes:
                  - "/var/run/postgres/postgres.sock:/var/run/postgres/postgres.sock" # bind mount
                  - "dbdata:/var/lib/postgresql/data" # named volume

            volumes:
              mydata:
              dbdata:

        Note: See Use volumes and Volume Plugins for general information on volumes.

        感覺 short syntax (old string format) 明顯比 long syntax 簡潔許多。

    SHORT SYNTAX

      - Optionally specify a path on the host machine (`HOST:CONTAINER`), or an access mode (`HOST:CONTAINER:ro`).

      - You can mount a RELATIVE PATH on the host, that expands relative to the directory of the Compose configuration file being used. Relative paths should always begin with `.` or `..`.

            volumes:
              # Just specify a path and let the Engine create a volume
              - /var/lib/mysql

              # Specify an absolute path mapping
              - /opt/data:/var/lib/mysql

              # Path on the host, relative to the Compose file
              - ./cache:/tmp/cache

              # User-relative path
              - ~/configs:/etc/configs/:ro

              # Named volume
              - datavolume:/var/lib/mysql

        可以解讀 `~` 也滿酷了。注意 relative path 一定要以 `.` 或 `..` 開頭。

## Health Check ??

  - [healthcheck - Compose file version 3 reference \| Docker Documentation](https://docs.docker.com/compose/compose-file/#healthcheck)

      - Configure a check that’s run to determine whether or not containers for this service are “healthy”. See the docs for the `HEALTHCHECK` Dockerfile instruction for details on how healthchecks work.

        原來 `Dockerfile` 可以提供 default health check #ril

            healthcheck:
              test: ["CMD", "curl", "-f", "http://localhost"]
              interval: 1m30s
              timeout: 10s
              retries: 3
              start_period: 40s

        `interval`, `timeout` and `start_period` are specified as durations.

        Note: `start_period` is only supported for v3.4 and higher of the compose file format.

      - `test` must be either a string or a list. If it’s a list, the first item must be either `NONE`, `CMD` or `CMD-SHELL`. If it’s a string, it’s equivalent to specifying `CMD-SHELL` followed by that string.

            # Hit the local web app
            test: ["CMD", "curl", "-f", "http://localhost"]

        As above, but wrapped in `/bin/sh`. Both forms below are equivalent.

            test: ["CMD-SHELL", "curl -f http://localhost || exit 1"]
            test: curl -f https://localhost || exit 1

      - To disable any DEFAULT HEALTHCHECK SET BY THE IMAGE, you can use `disable: true`. This is equivalent to specifying `test: ["NONE"]`.

            healthcheck:
              disable: true

## `docker-compose` CLI {: #cli }

`docker-compose` 的用法：

```
docker-compose [OPTIONS] COMMAND [OPTIONS] SERVICE [COMMAND] [ARG...]
```

注意第一個 `OPTIONS` 是給 `docker-compose` 的 (`docker-compose help`)，第二個 `OPTIONS` 則是給特定 `COMMAND` 的 (`docker-compose help COMMAND`)，而且兩者不能混用。

`docker` 與 `docker-compose` 的用法很像，以 `run` 為例：

```
docker         run [OPTIONS] IMAGE   [COMMAND] [ARG...]
docker-compose run [OPTIONS] SERVICE [COMMAND] [ARG...]
```

最明顯的差別在於 `docker` 面對的是特定的 image，而 `docker-compose` 面對的則是 compose file 裡邏輯上的 service，可惜少數 option 不太一樣，否則從 `docker` 遷移到 `docker-compose` 時會更為平順，例如：

  - `docker` 可以用 `-e KEY[=VALUE]` 或 `--env KEN[=VALUE]` 設定環境變數，但 `docker-compose` 只接受 `-e KEY[=VALUE]` 的用法。
  - `docker` 有 `-i, --interactive` 與 `-t, --tty` 分別控制是否綁定/配置 STDIN 與 pseudo-TTY ，但 `docker-compose` 反過來只有 `-T` 取消 pseudo-TTY 的配置。

---

參考資料：

  - [Overview of docker\-compose CLI \| Docker Documentation](https://docs.docker.com/compose/reference/overview/)

    Command options overview and help

      - You can also see this information by running `docker-compose --help` from the command line.
      - You can use Docker Compose binary, `docker-compose [-f <arg>...] [options] [COMMAND] [ARGS...]`, to build and manage multiple services in Docker containers.

    Specifying multiple Compose files

      - You can supply multiple `-f` configuration files. When you supply multiple files, Compose COMBINES them into a single configuration. Compose builds the configuration IN THE ORDER you supply the files. Subsequent files override and add to their predecessors.

      - For example, consider this command line:

            $ docker-compose -f docker-compose.yml -f docker-compose.admin.yml run backup_db

        The `docker-compose.yml` file might specify a `webapp` service.

            webapp:
              image: examples/web
              ports:
                - "8000:8000"
              volumes:
                - "/data"

        If the `docker-compose.admin.yml` also specifies this same service, any MATCHING FIELDS OVERRIDE the previous file. New values, ADD TO the `webapp` service configuration.

            webapp:
              build: .
              environment:
                - DEBUG=1

      - Use a `-f` with `-` (dash) as the filename to read the configuration from `stdin`. When `stdin` is used all paths in the configuration are relative to the current working directory.

      - The `-f` flag is optional. If you don’t provide this flag on the command line, Compose TRAVERSES THE WORKING DIRECTORY AND ITS PARENT DIRECTORIES looking for a `docker-compose.yml` and a `docker-compose.override.yml` file.

        You must supply at least the `docker-compose.yml` file. If both files are present ON THE SAME DIRECTORY LEVEL, Compose combines the two files into a single configuration.

        The configuration in the `docker-compose.override.yml` file is applied over and in addition to the values in the `docker-compose.yml` file.

    Specifying a path to a single Compose file

      - You can use `-f` flag to specify a path to Compose file that is not located in the current directory, either from the command line or by setting up a `COMPOSE_FILE` environment variable in your shell or in an environment file.

      - For an example of using the `-f` option at the command line, suppose you are running the [Compose Rails sample](https://docs.docker.com/compose/rails/), and have a `docker-compose.yml` file in a directory called `sandbox/rails`. You can use a command like `docker-compose pull` to get the postgres image for the `db` service from anywhere by using the `-f` flag as follows: `docker-compose -f ~/sandbox/rails/docker-compose.yml pull db`

        Here’s the full example:

            $ docker-compose -f ~/sandbox/rails/docker-compose.yml pull db
            Pulling db (postgres:latest)...
            latest: Pulling from library/postgres
            ef0380f84d05: Pull complete
            50cf91dc1db8: Pull complete
            d3add4cd115c: Pull complete
            467830d8a616: Pull complete
            089b9db7dc57: Pull complete
            6fba0a36935c: Pull complete
            81ef0e73c953: Pull complete
            338a6c4894dc: Pull complete
            15853f32f67c: Pull complete
            044c83d92898: Pull complete
            17301519f133: Pull complete
            dcca70822752: Pull complete
            cecf11b8ccf3: Pull complete
            Digest: sha256:1364924c753d5ff7e2260cd34dc4ba05ebd40ee8193391220be0f9901d4e1651
            Status: Downloaded newer image for postgres:latest

    Use `-p` to specify a project name

      - Each configuration has a project name. If you supply a `-p` flag, you can specify a project name. If you don’t specify the flag, Compose uses the current directory name. See also the `COMPOSE_PROJECT_NAME` environment variable.

    Set up environment variables

      - You can set environment variables for various `docker-compose` options, including the `-f` and `-p` flags.

        For example, the `COMPOSE_FILE` environment variable relates to the `-f` flag, and `COMPOSE_PROJECT_NAME` environment variable relates to the `-p` flag.

        Also, you can set some of these variables in an environment file.

  - [Compose CLI environment variables \| Docker Documentation](https://docs.docker.com/compose/reference/envvars/) #ril

## Resource Constraints??

  - [Version 3 - Compose file versions and upgrading \| Docker Documentation](https://docs.docker.com/compose/compose-file/compose-versioning/#version-3) `mem_limit`、`cpu_quota` 等在 version 3 由 `deploy` > `resources` 取代，但為什麼說 "Note that deploy configuration only takes effect when using docker stack deploy, and is ignored by docker-compose"?? #ril
  - [Resources - Compose file version 3 reference \| Docker Documentation](https://docs.docker.com/compose/compose-file/#resources) Looking for options to set resources on non swarm mode containers? 提到這裡的 options 是針對 swarm mode，就 non swarm deployment 而言則要改用 version 2 的寫法。
  - [Runtime constraints on resources - Docker run reference \| Docker Documentation](https://docs.docker.com/engine/reference/run/#runtime-constraints-on-resources) `docker run` 有很多跟 resource contraints 相關的參數。
  - [How to specify Memory & CPU limit in version 3 · Issue \#4513 · docker/compose](https://github.com/docker/compose/issues/4513) #ril

## 控制啟動順序 ??

  - [Control startup order in Compose \| Docker Documentation](https://docs.docker.com/compose/startup-order/) #ril

## 如何決定/限定記憶體用量?? (v2)

用 `mem_limit: <number>[<unit>]` 指定，例如：

```
services:
  db:
    image: db
    mem_limit: 100m
```

之後用 `docker stats --all` 驗證，可以看到 MEM USAGE/LIMIT 與 MEM %，例如：

```
CONTAINER           CPU %               MEM USAGE / LIMIT   MEM %               NET I/O             BLOCK I/O           PIDS
118ec3fabe0f        0.70%               39.44MiB / 100MiB   39.44%              2.3kB / 0B          0B / 0B             13
```

參考資料：

  - [CPU and other resources - Compose file version 2 reference \| Docker Documentation](https://docs.docker.com/compose/compose-file/compose-file-v2/#cpu-and-other-resources) 用個別的 `key: value` 指定，對應 `docker run` 的參數。
  - [Runtime constraints on resources - Docker run reference \| Docker Documentation](https://docs.docker.com/engine/reference/run/#runtime-constraints-on-resources) `-m, --memory=""` 搭配 `<number>[<unit>]`，其中 `unit` 可以是 `b`/`k`/`m`/`g`，最小值是 4 MB。
  - [Out Of Memory Exceptions (OOME) - Compose file version 3 reference \| Docker Documentation](https://docs.docker.com/compose/compose-file/#restart_policy) 記憶體用量超過限制時，container 或 Docker daemon 會被 kernel OOM killer 殺掉。
  - [fig \- Can I use mem\_limit in docker\-compose? and How? \- Stack Overflow](https://stackoverflow.com/questions/28837544/) 如何檢驗 `mem_limit` 有生效? maniekq: 用 `docker stats -a` 檢查。
  - [What is Docker container exit code 137? · Issue \#21083 · moby/moby](https://github.com/moby/moby/issues/21083) Error 137 可能是 Linux OOM Killer 造成，用 `mem_limit` 增加配置的記憶體即可；另外 Docker daemon 自己的限制可以從 Docker App > Preferences > Advanced 調整。
  - [Container crashes with code 137 when given high load · Issue \#22211 · moby/moby](https://github.com/moby/moby/issues/22211) 137 就是 SIGKILL，源自 OOM Killer。
  - [Exit Codes With Special Meanings](http://tldp.org/LDP/abs/html/exitcodes.html) 137 (128 +9) 就是 SIGKILL
  - [Understand the risks of running out of memory - Limit a container’s resources \| Docker Documentation](https://docs.docker.com/engine/admin/resource_constraints/#understand-the-risks-of-running-out-of-memory) #ril

## 安裝設定 {: #installation }

  - [Install Docker Compose \| Docker Documentation](https://docs.docker.com/compose/install/) #ril

      - You can run Compose on macOS, Windows, and 64-bit Linux.

    Prerequisites

      - Docker Compose relies on Docker Engine for any meaningful work, so make sure you have Docker Engine installed either locally or remote, depending on your setup.

      - On desktop systems like Docker Desktop for Mac and Windows, Docker Compose is included as part of those desktop installs.

        不過可以用 pip 安裝，或是 install Compose as a container 是怎麼回事 ??

      - On Linux systems, first install the Docker for your OS as described on the Get Docker page, then come back here for instructions on installing Compose on Linux systems.
      - To run Compose as a non-root user, see Manage Docker as a non-root user.

### Ubuntu ??

Linux 下的 Docker Compose 要手動安裝，到 [GitHub 上的 release page](https://github.com/docker/compose/releases)，用 curl 把 `docker-compose` 下載到 `/usr/local/bin/docker-compose`，再給它執行權限即可。

### Docker ??

  - [docker/compose \- Docker Hub](https://hub.docker.com/r/docker/compose/)

    沒有針對 `docker/compose` 這個 image 做說明，但很特別的是沒有 `latest` 或 `stable` tag。

  - [Run docker\-compose build in \.gitlab\-ci\.yml \- Stack Overflow](https://stackoverflow.com/questions/39868369/) #ril

## 參考資料 {: #reference }

  - [Docker Compose](https://docs.docker.com/compose/)
  - [docker/compose - GitHub](https://github.com/docker/compose)

更多：

  - [在 GitLab CI 裡用 Docker Compose](gitlab-ci-docker.md#docker-compose)。

手冊：

  - [Release Notes](https://docs.docker.com/release-notes/docker-compose/) / [CHANGELOG](https://github.com/docker/compose/blob/master/CHANGELOG.md)
  - [Compose file v3 reference](https://docs.docker.com/compose/compose-file/) / [v2](https://docs.docker.com/compose/compose-file/compose-file-v2/)
  - [Compatibility matrix - Compose file versions and upgrading \| Docker Documentation](https://docs.docker.com/compose/compose-file/compose-versioning/#compatibility-matrix) - Compose file format x Docker Engine release
  - [Command-line Reference](https://docs.docker.com/compose/reference/)
  - [Environment Variables](https://docs.docker.com/compose/reference/envvars/)
