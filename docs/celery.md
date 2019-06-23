# Celery

  - [Homepage \| Celery: Distributed Task Queue](http://www.celeryproject.org/)

      - Celery is an ASYNCHRONOUS TASK QUEUE/JOB QUEUE based on DISTRIBUTED MESSAGE PASSING. It is focused on REAL-TIME OPERATION, but supports SCHEDULING as well.

        相對於指定時間或定期執行的 scheduling，所謂 real-time operation 指的是進 task queue 就儘快處理。

      - The EXECUTION UNITS, called TASKS, are executed CONCURRENTLY on a single or more WORKER SERVERS using multiprocessing, Eventlet, or gevent. Tasks can execute asynchronously (in the background) or synchronously (wait until ready).

        本質上是 asynchronously，但可以繼續做點其他事再等背景的工作處理完，某種程度上又是 synchronously 了；[Keeping Results - First Steps with Celery — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/first-steps-with-celery.html#keeping-results) 印證了這樣的說法：

        > You can wait for the result to complete, but this is rarely used since it turns the asynchronous call into a synchronous one:

      - Celery is used in production systems to process millions of tasks a day.

    EASY TO INTEGRATE

      - Celery is easy to integrate with web frameworks, some of which even have integration packages.

        [Introduction to Celery](http://docs.celeryproject.org/en/latest/getting-started/introduction.html#framework-integration) 中多數 web framework 都有相應的套件，但 Flask 為什麼這麼特別寫 "not needed" ?? [Celery Background Tasks — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/patterns/celery/) 也沒提到其他套件。

      - Celery is written in Python, but the [PROTOCOL](http://docs.celeryproject.org/en/latest/internals/protocol.html) can be implemented in any language. It can also operate with other languages using WEBHOOKS.

    MULTI BROKER SUPPORT

      - The recommended MESSAGE BROKER is RabbitMQ, but support for Redis, Beanstalk, MongoDB, CouchDB, and databases (using SQLAlchemy or the Django ORM) is also available.

        雖然 [Introduction to Celery — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/introduction.html#what-do-i-need) 提到 RabbitMQ 與 Redis 的支援都是完整的：

        > The RabbitMQ and Redis broker transports are feature complete, but there’s also support for a myriad of other experimental solutions, including using SQLite for local development.

        但 [Choosing a Broker - First Steps with Celery — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/first-steps-with-celery.html#redis) 又說：

        > Redis is also feature-complete, but is more SUSCEPTIBLE TO DATA LOSS in the event of abrupt termination or power failures.

    Related Projects

      - [Celery Flower](https://github.com/mher/flower) #ril

        Real-time monitor and web admin for Celery 管理介面

          - Real-time monitoring using Celery Events
          - Remote Control
          - Broker monitoring
          - HTTP API
          - Basic Auth and Google OpenID authentication

      - [Jobtastic](http://policystat.github.io/jobtastic/) #ril

        A Celery library that makes your USER-RESPONSIVE long-running jobs totally awesomer. 可以持續更新進度 ??

        Jobtastic is a python library that adds useful features to your Celery tasks. Specifically, these are features you probably want if the results of your jobs are EXPENSIVE or if your users NEED TO WAIT while they compute their results.

## 替代方案 {: #alternatives }

  - [Scheduling with APScheduler \- Mastering Concurrency in Python](https://subscription.packtpub.com/book/application_development/9781789343052/19/ch19lvl1sec144/scheduling-with-apscheduler)

      - Some might think of Celery (http://www.celeryproject.org/) as the go-to scheduling tool for Python. However, while Celery is a distributed task queue with BASIC SCHEDULING capabilities, APScheduler is quite the OPPOSITE: a scheduler with BASIC TASK QUEUING options and ADVANCED SCHEDULING functionalities. Additionally, users of both tools have reported that APScheduler is easier to set up and implement.

  - [Task Queues \- Full Stack Python](https://www.fullstackpython.com/task-queues.html) #ril
  - [Python定時任務\-schedule vs\. Celery vs\. APScheduler \- 台部落](https://www.twblogs.net/a/5ba17f452b71771a4da8cb6b) (2018-09-19) APScheduler 適用於小型的應用? #ril

## 新手上路 {: #getting-started }

  - [Getting Started — Celery 4\.2\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/index.html) #ril

  - [Introduction to Celery — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/introduction.html)

    What’s a Task Queue?

      - Task queues are used as a mechanism to DISTRIBUTE WORK ACROSS THREADS OR MACHINES.

        A task queue’s input is a UNIT OF WORK called a TASK. Dedicated worker processes constantly monitor task queues for new work to perform.

        不同的 task 會進到不同的 queue ??

      - Celery communicates via MESSAGES, usually using a BROKER to MEDIATE BETWEEN CLIENTS AND WORKERS. To initiate a task the client adds a message to the queue, the broker then delivers that message to a worker.

        從 "mediate between clients and workers" 看來，很明顯 client 跟 (Celery) worker 並不會直接溝通，雙方都是面對中間的 message broker，只是 client 負責塞 task，而 worker 負責消化。

      - A Celery system can consist of multiple workers and brokers, giving way to high availability and horizontal scaling.

      - Celery is written in Python, but the PROTOCOL can be implemented in any language. In addition to Python there’s [node-celery](https://github.com/mher/node-celery) for Node.js, and a [PHP client](https://github.com/gjedeer/celery-php).

        雖然 client 面對的是 message broker，為什麼 Celery 會有自己的 protoco? 以 Redis 做為 message broker 為例，固然 client 要知道如何與 Redis 溝通 (這一層是 Redis protocol)，但接下來的問題是資料要怎麼擺放進 Redis，才能讓 worker 知道這是哪個 task、參數有哪些、如何記錄結果、如何回報進度等，這就是所謂的 [message protocol](http://docs.celeryproject.org/en/latest/internals/protocol.html)。

        從 [Usage - mher/node\-celery: Celery client for Node\.js](https://github.com/mher/node-celery#usage) 的範例看來，client 只需要知道 broker 及 result store 的位置，以及 task name 即可：

            var celery = require('node-celery'),
                client = celery.createClient({
                    CELERY_BROKER_URL: 'amqp://guest:guest@localhost:5672//',
                    CELERY_RESULT_BACKEND: 'amqp://'
                });

            client.on('connect', function() {
                client.call('tasks.echo', ['Hello World!'], function(result) {
                    console.log(result);
                    client.end();
                });
            });

        不過 worker 做事情這一段，只能用 Python 寫 ??

      - Language interoperability can also be achieved EXPOSING an HTTP endpoint and having a task that requests it (WEBHOOKs).

    What do I need?

      - Version Requirements: Celery is a project with minimal funding, so we don’t support Microsoft Windows. Please don’t open any issues related to that platform.

      - Celery requires a MESSAGE TRANSPORT to send and receive messages. The RabbitMQ and Redis broker transports are feature complete, but there’s also support for a myriad of other experimental solutions, including using SQLite for local development.

      - Celery can run on a single machine, on multiple machines, or even across data centers.

    Celery is…

      - Simple

        Celery is easy to use and maintain, and it DOESN’T NEED CONFIGURATION FILES. 因為都由 worker 啟動時決定了 ??

        It has an active, friendly community you can talk to for support, including a mailing-list and an IRC channel.

        Here’s one of the simplest applications you can make:

            from celery import Celery

            app = Celery('hello', broker='amqp://guest@localhost//')

            @app.task
            def hello():
                return 'hello world'

      - Highly Available

        Workers and clients will automatically retry in the event of connection loss or failure, and some brokers support HA in way of Primary/Primary or Primary/Replica replication.

      - Fast

        A single Celery process can process millions of tasks a minute, with sub-millisecond ROUND-TRIP LATENCY (using RabbitMQ, librabbitmq, and optimized settings).

        這裡要強調的是 overhead 很低，而不是 task 自己花多少時間在處理。

      - Flexible

        Almost every part of Celery can be extended or used on its own, Custom pool implementations, serializers, compression schemes, LOGGING, schedulers, consumers, producers, broker transports, and much more. #ril

    It supports

      - Brokers

        RabbitMQ, Redis, Amazon SQS, and more…

      - Concurrency

        prefork (multiprocessing), Eventlet, gevent solo (single threaded)

      - Result Stores

        AMQP, Redis, Memcached, SQLAlchemy, Django ORM, Apache Cassandra, Elasticsearch

      - Serialization

          - pickle, json, yaml, msgpack.
          - zlib, bzip2 compression.
          - Cryptographic message signing.

    Features

      - Monitoring

        A stream of MONITORING EVENTS is EMITTED BY WORKERS and is used by built-in and external tools to tell you what your cluster is doing – in real-time.

      - Work-flows

        Simple and complex work-flows can be composed using a set of powerful primitives we call the “CANVAS”, including grouping, chaining, chunking, and more. ??

        把一個 task 切細 ??

      - Time & Rate Limits

        You can control how many tasks can be executed per second/minute/hour, or how long a task can be allowed to run, and this can be set as a default, for a specific worker or individually for each TASK TYPE.

      - Scheduling

        You can SPECIFY THE TIME TO RUN a task in seconds or a datetime, or you can use periodic tasks for recurring events based on a simple interval, or Crontab expressions supporting minute, hour, day of week, day of month, and month of year.

        如果一個 application 有一些定期作業要在背景處理，可以交由 Celery 來排程；像 [Flask-APScheduler](https://github.com/viniciuschiele/flask-apscheduler) 的用法就很不恰當? 但為什麼之前搭配 uWSGI `processes = 5` 的設定不會有多個 scheduler 起來，因為 preforking ??

      - Resource Leak Protection

        The `--max-tasks-per-child` option is used for USER TASKS LEAKING RESOURCES, like memory or file descriptors, that are simply out of your control. ??

        [Workers Guide — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/userguide/workers.html#worker-max-tasks-per-child) #ril

      - User Components

        Each worker COMPONENT can be customized, and additional components can be defined by the user. The worker is built up using “bootsteps” — a dependency graph enabling fine grained control of the worker’s internals. ??

  - [First Steps with Celery — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/first-steps-with-celery.html) #ril

      - Celery is a task queue with batteries included. It’s easy to use so that you can get started without learning the full complexities of the problem it solves. It’s designed around best practices so that your product can scale and integrate with other languages, and it comes with the tools and support you need to run such a system in production.

        In this tutorial you’ll learn the absolute basics of using Celery. Learn about;

          - Choosing and installing a message transport (broker).
          - Installing Celery and creating your first task.
          - Starting the worker and calling tasks.
          - Keeping track of tasks as they TRANSITION THROUGH DIFFERENT STATES ??, and inspecting return values.

      - Celery may seem daunting at first - but don’t worry - this tutorial will get you started in no time. It’s deliberately kept simple, so as to not confuse you with advanced features. After you have finished this tutorial, it’s a good idea to browse the rest of the documentation. For example the Next Steps tutorial will showcase Celery’s capabilities.

    Choosing a Broker

      - Celery requires a solution to send and receive messages; usually this comes in the form of a SEPARATE SERVICE called a message broker.

        There are several choices available, including: RabbitMQ, Redis, Other brokers

      - RabbitMQ

          - RabbitMQ is feature-complete, stable, durable and easy to install. It’s an excellent choice for a production environment. Detailed information about using RabbitMQ with Celery: [Using RabbitMQ](http://docs.celeryproject.org/en/latest/getting-started/brokers/rabbitmq.html#broker-rabbitmq) #ril

          - If you’re using Ubuntu or Debian install RabbitMQ by executing this command:

                $ sudo apt-get install rabbitmq-server

            Or, if you want to run it on Docker execute this:

                $ docker run -d -p 5462:5462 rabbitmq

            When the command completes, the broker will already be running in the background, ready to MOVE MESSAGES for you: `Starting rabbitmq-server: SUCCESS`.

      - Redis

          - Redis is also feature-complete, but is more SUSCEPTIBLE TO DATA LOSS in the event of abrupt termination or power failures. Detailed information about using Redis: [Using Redis](http://docs.celeryproject.org/en/latest/getting-started/brokers/redis.html#broker-redis) #ril

          - If you want to run it on Docker execute this:

                $ docker run -d -p 6379:6379 redis

      - Other brokers

          - In addition to the above, there are other EXPERIMENTAL transport implementations to choose from, including Amazon SQS.

            See Broker Overview for a full list.

    Application

      - The first thing you need is a CELERY INSTANCE. We call this the CELERY APPLICATION or just app for short. As this instance is used as the ENTRY-POINT for everything you want to do in Celery, like creating tasks and managing workers, it must be possible FOR OTHER MODULES TO IMPORT IT.

        這裡 "Celery instance" 的說法很容易讓人誤以為是 worker，但它其實是 Celery client，說是 Celery application 也有點奇怪，與其說是 entry-point 倒不如說是 "interface to Celery"，我們透過它跟 message broker 對話，間接跟 worker 溝通。

        如果將 worker 包裝成另一個 Docker image，但 worker 的工作又涉及複雜的處理，需要用到許多套件，這時候 client 要 import 它就被逼得要安裝那些用不到的套件 ??

      - In this tutorial we keep everything contained in a SINGLE MODULE, but for larger projects you want to create a DEDICATED MODULE.

        [Next Steps — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/next-steps.html#project-layout) 大致將 `celery.Celery` instance 的建立與 task 的宣告拆開，但 client 要調用 task 時還是得 import 宣告 task 的那個 module，問題還是一樣 ??

        不過若是採用跟 application 一樣的 image，只是要做為 worker 時將 entrypoint 改一下，就沒這個問題了 ??

        [Can I call a task by name? - Frequently Asked Questions — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/faq.html#can-i-call-a-task-by-name) 似乎是解法? 不過 `send_task()` 的參數很多，感覺是個 low-level API，但範例看起來又很簡單 #ril

      - Let’s create the file `tasks.py`:

            from celery import Celery

            app = Celery('tasks', broker='pyamqp://guest@localhost//')

            @app.task
            def add(x, y):
                return x + y

        The first argument to `Celery` is the name of the current module. This is only needed so that NAMES CAN BE AUTOMATICALLY GENERATED when the tasks are defined in the `__main__` module. 產生什麼 name ??

        The second argument is the `broker` keyword argument, specifying the URL of the message broker you want to use. Here using RabbitMQ (also the default option).

        See Choosing a Broker above for more choices – for RabbitMQ you can use `amqp://localhost`, or for Redis you can use `redis://localhost`. 那這裡的 `pyamqp://` 又是 ??

        You defined a single task, called `add`, returning the sum of two numbers.

    Running the Celery worker server

      - You can now run the worker by executing our program with the `worker` argument:

            $ celery -A tasks worker --loglevel=info

        Note: See the [Troubleshooting](http://docs.celeryproject.org/en/latest/getting-started/first-steps-with-celery.html#celerytut-troubleshooting) section if the worker doesn’t start. #ril

      - In production you’ll want to run the worker in the background as a daemon. To do this you need to use the tools provided by your platform, or something like supervisord (see [Daemonization](http://docs.celeryproject.org/en/latest/userguide/daemonizing.html#daemonizing) for more information). #ril

      - For a complete listing of the command-line options available, do:

            $  celery worker --help

        There are also several other commands available, and help is also available:

            $ celery help

        原來 `worker` 是個 subcommand ??

    Calling the task

      - To call our task you can use the `delay()` method.

        This is a handy shortcut to the `apply_async()` method that gives greater control of the task execution (see Calling Tasks):

            >>> from tasks import add
            >>> add.delay(4, 4)

        The task has now been processed by the worker you started earlier. You can verify this by looking at the worker’s console output.

      - Calling a task returns an `AsyncResult` instance. This can be used to check the STATE of the task, WAIT for the task to finish, or get its RETURN VALUE (or if the task failed, to get the exception and traceback).

      - Results are NOT enabled by default. In order to do REMOTE PROCEDURE CALLS or keep track of task results in a database, you will need to configure Celery to use a RESULT BACKEND. This is described in the next section.

        按照 [How to Set Up a Task Queue with Celery and RabbitMQ](https://www.linode.com/docs/development/python/task-queue-celery-rabbitmq/)，這裡 remote procedure call 跟 "等待執行結果" 的用法有關，但好像只有 RabbitMQ 支援 ??

        > If you omit `backend`, the task will still run, but the return value will be lost. `rpc` means the response will be sent to a RabbitMQ queue in a REMOTE PROCEDURE CALL PATTERN.

    Keeping Results

      - If you want to keep track of the tasks’ states, Celery needs to store or send the states somewhere. There are several built-in result backends to choose from: SQLAlchemy/Django ORM, Memcached, Redis, RPC (RabbitMQ/AMQP), and – or you can define your own.

        RPC 只有 RabbitMQ 支援的意思 ??

      - For this example we use the `rpc` result backend, that sends states back as TRANSIENT MESSAGES. The backend is specified via the `backend` argument to Celery, (or via the `result_backend` setting if you choose to use a CONFIGURATION MODULE):

            app = Celery('tasks', backend='rpc://', broker='pyamqp://')

        Or if you want to use Redis as the result backend, but still use RabbitMQ as the message broker (a POPULAR COMBINATION):

            app = Celery('tasks', backend='redis://localhost', broker='pyamqp://')

        To read more about result backends please see Result Backends.

      - Now with the result backend configured, let’s call the task again. This time you’ll hold on to the `AsyncResult` instance returned when you call a task:

            >>> result = add.delay(4, 4)

        The `ready()` method returns whether the task has finished processing or not:

            >>> result.ready()
            False

      - You can wait for the result to complete, but this is RARELY USED since it TURNS THE ASYNCHRONOUS CALL INTO A SYNCHRONOUS ONE:

            >>> result.get(timeout=1)
            8

        In case the task raised an exception, `get()` will RE-RAISE the exception, but you can override this by specifying the `propagate` argument:

            >>> result.get(propagate=False)

        If the task raised an exception, you can also gain access to the original traceback:

            >>> result.traceback

      - Warning: Backends use resources to store and transmit results. To ensure that resources are released, you must eventually call `get()` or `forget()` on EVERY `AsyncResult` instance returned after calling a task.

        如果沒想拿 result，就別啟用 result backend，否則沒人拿走/取消結果，就會一直累積。

      - See `celery.result` for the complete result object reference.

  - [Internals — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/internals/index.html) #ril

## Calling Tasks ??

  - [Calling Tasks — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/userguide/calling.html#guide-calling) #ril

## Project Layout ??

  - [Next Steps — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/next-steps.html#project-layout) #ril

## Configuration ??

  - [Configuration - First Steps with Celery — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/first-steps-with-celery.html#configuration) #ril

      - Celery, like a consumer appliance, doesn’t need much configuration to operate. It has an input and an output. The INPUT must be connected to a BROKER, and the OUTPUT can be OPTIONALLY connected to a RESULT BACKEND.

        However, if you look closely at the back, there’s a lid revealing loads of sliders, dials, and buttons: this is the configuration.

      - The default configuration should be good enough for most use cases, but there are many options that can be configured to make Celery work exactly as needed. Reading about the options available is a good idea to familiarize yourself with what can be configured. You can read about the options in the Configuration and defaults reference.

      - The configuration can be set on the APP directly or by using a dedicated CONFIGURATION MODULE. As an example you can configure the DEFAULT SERIALIZER used for serializing TASK PAYLOADS by changing the `task_serializer` setting:

            app.conf.task_serializer = 'json'

      - If you’re configuring many settings at once you can use `update`:

            app.conf.update(
                task_serializer='json',
                accept_content=['json'],  # Ignore other content
                result_serializer='json',
                timezone='Europe/Oslo',
                enable_utc=True,
            )

      - For larger projects, a dedicated configuration module is recommended. Hard coding periodic task intervals and TASK ROUTING ?? options is discouraged. It is much better to keep these in a CENTRALIZED location.

        This is especially true for LIBRARIES, as it enables users to control how their tasks behave. A centralized configuration will also allow your SysAdmin to make simple changes in the event of system trouble. 跟 library 什麼關係 ??

      - You can tell your `Celery` instance to use a configuration module by calling the `app.config_from_object()` method:

            app.config_from_object('celeryconfig')

        This module is often called “`celeryconfig`”, but you can use any module name.

      - In the above case, a module named `celeryconfig.py` must be available to load from the CURRENT DIRECTORY OR ON THE PYTHON PATH. It could look something like this:

        `celeryconfig.py`:

            broker_url = 'pyamqp://'
            result_backend = 'rpc://'

            task_serializer = 'json'
            result_serializer = 'json'
            accept_content = ['json']
            timezone = 'Europe/Oslo'
            enable_utc = True

      - To verify that your configuration file works properly and doesn’t contain any syntax errors, you can try to import it:

            $ python -m celeryconfig

        For a complete reference of configuration options, see Configuration and defaults.

      - To demonstrate the power of configuration files, this is how you’d route a misbehaving task to a dedicated queue:

        `celeryconfig.py`:

            task_routes = {
                'tasks.add': 'low-priority',
            }

      - Or instead of routing it you could RATE LIMIT the task instead, so that only 10 tasks of this type can be processed in a minute (10/m):

        `celeryconfig.py`:

            task_annotations = {
                'tasks.add': {'rate_limit': '10/m'}
            }

      - If you’re using RabbitMQ or Redis as the broker then you can also direct the workers to set a new rate limit for the task at runtime:

            $ celery -A tasks control rate_limit tasks.add 10/m
            worker@example.com: OK
                new rate limit set successfully

      - See Routing Tasks to read more about TASK ROUTING, and the `task_annotations` setting for more about annotations, or Monitoring and Management Guide for more about remote control commands and how to monitor what your workers are doing.

  - [Configuration and defaults — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/userguide/configuration.html) #ril

## Routing ??

  - [Routing Tasks — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/userguide/routing.html) #ril

## Annotation ??

  - [`task_annotations` - Configuration and defaults — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/userguide/configuration.html#std:setting-task_annotations) #ril

## Broker ??

  - [Brokers — Celery 4\.2\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/brokers/) 支援 RabbitMQ、Redis 與 Amazon SQS #ril

## Result Backend ??

  - [Result Backends - Tasks — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/userguide/tasks.html#task-result-backends) #ril

## Worker ??

  - [Workers Guide — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/userguide/workers.html) #ril

## Testing ??

  - [Testing with Celery — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/userguide/testing.html) #ril

## Monitoring ??

  - [Monitoring and Management Guide — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/userguide/monitoring.html) #ril

## Workflow ??

  - [Canvas: Designing Work\-flows — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/userguide/canvas.html#guide-canvas) #ril

## Scheduling ??

  - [Periodic Tasks — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/userguide/periodic-tasks.html) #ril

## Webhook ??

  - [What’s a Task Queue? - Introduction to Celery — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/introduction.html#what-s-a-task-queue)

      - Language interoperability can also be achieved EXPOSING an HTTP endpoint and having a task that requests it (WEBHOOKs).

        改讓 client 面對 HTTP endpoint，不用面對 message broker 與 Celery protocol，聽起來好像不錯；但 `celery` CLI 可以直接將 task 揭露成 HTTP endpoints 嗎 ??

        雖然 webhook task machinery [在 4.0 被移除了](http://docs.celeryproject.org/en/latest/history/whatsnew-4.0.html#features-removed-for-simplicity)，但好像也可以自己做 ??

  - [celery/http\.py at 3\.1 · celery/celery](https://github.com/celery/celery/blob/3.1/celery/task/http.py) #ril

## App Binding ??

  - [`celery.Celery.task` - celery — Distributed processing — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/reference/celery.html#celery.Celery.task) #ril

      - Note: APP BINDING: For custom apps the task decorator will return a proxy object, so that the act of creating the task is not performed until the task is used or the TASK REGISTRY is accessed.

        If you’re depending on binding to be DEFERRED, then you must not access any attributes on the returned object until the application is fully set up (finalized).

        讓人想到 [Application Factories — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/patterns/appfactories/)，跟好不好測有關 ??

  - [Testing with Celery — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/userguide/testing.html) 出現 `@app.task(bind=True)` 的用法 #ril

  - [The Task base class no longer automatically register tasks - What’s new in Celery 4\.0 \(latentcall\) — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/history/whatsnew-4.0.html#the-task-base-class-no-longer-automatically-register-tasks) 出現 `app.register_task(CustomTask())`，但又說 class based tasks 不是 best practice ?? #ril

  - [Bound tasks - Tasks — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/userguide/tasks.html#bound-tasks) #ril

  - [First steps with Django — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/django/first-steps-with-django.html) 出現 `app.autodiscover_tasks()` 的用法 #ril

  - [`autodiscover_tasks()` - celery — Distributed processing — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/reference/celery.html#celery.Celery.autodiscover_tasks) 這些 task 如何不用 `@app.task` 宣告 ??

  - [Instantiation - Tasks — Celery 4\.3\.0 documentation](https://docs.celeryproject.org/en/latest/userguide/tasks.html#instantiation) 繼承自 `celery.Task` 自訂 task #ril

## 疑難排解 {: #troubleshooting }

### Celery Received unregistered task of type ??

  - [python \- Celery Received unregistered task of type \(run example\) \- Stack Overflow](https://stackoverflow.com/questions/9769496/) `please include=['proj.tasks']` 是關鍵 #ril

      - CK.Nguyen: The include param need to be add if you're using RELATIVE IMPORTS. I've solved my issue by adding it

## 安裝設定 {: #installation }

  - [Installing Celery - First Steps with Celery — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/first-steps-with-celery.html#installing-celery)

    Celery is on the Python Package Index (PyPI), so it can be installed with standard Python tools like pip or easy_install:

        $ pip install celery

  - [Getting Started - Homepage \| Celery: Distributed Task Queue](http://www.celeryproject.org/#getStarted)

      - Install celery by download or `pip install -U Celery`
      - Set up RabbitMQ, Redis or one of the other supported BROKERS

  - [Download and Install \| Celery: Distributed Task Queue](http://www.celeryproject.org/install/) #ril

  - [Using Redis — Celery 4\.3\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/brokers/redis.html) #ril

## 參考資料 {: #reference }

  - [Celery](http://www.celeryproject.org/)
  - [celery/celery - GitHub](https://github.com/celery/celery)

社群：

  - ['celery' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/celery)

手冊：

  - [API Reference](http://docs.celeryproject.org/en/latest/reference/index.html)

      - [Class `celery.app.task.Task`](http://docs.celeryproject.org/en/latest/reference/celery.app.task.html#celery.app.task.Task)
      - [Class `celery.result.AsyncResult`](http://docs.celeryproject.org/en/latest/reference/celery.result.html#celery.result.AsyncResult)

  - [Message Protocol](http://docs.celeryproject.org/en/latest/internals/protocol.html)
