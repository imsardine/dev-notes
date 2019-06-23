# APScheduler (Advanced Python Scheduler)

  - [Advanced Python Scheduler — APScheduler 3\.6\.0\.post2 documentation](https://apscheduler.readthedocs.io/en/latest/) #ril

      - Advanced Python Scheduler (APScheduler) is a Python library that lets you schedule your Python code to be executed later, either just ONCE or PERIODICALLY. You can add new jobs or REMOVE OLD ONES on the fly as you please.

        從 "remove old ones" 看來，即便採用預設的 memory 做為 job store，還是有個 queue 記錄著累積的 job，才會有機會移除它。

      - If you store your jobs in a database, they will also survive scheduler restarts and maintain their state. When the scheduler is restarted, it will then run all the jobs it should have run while it was offline. The CUTOFF PERIOD ?? for this is also configurable.

        這要看專案的需求，如果涉及商業流程的話，不該因為服務重啟就消失，但有些小型的應用，這種情況是可以接受的。

      - Among other things, APScheduler can be used as a cross-platform, application specific replacement to PLATFORM SPECIFIC SCHEDULERS, such as the cron daemon or the Windows task scheduler.

        Please note, however, that APScheduler is NOT a daemon or service itself, nor does it come with any command line tools. It is primarily meant to be run inside existing applications. That said, APScheduler does provide some building blocks for you to build a scheduler service or to run a dedicated scheduler process.

        若整個 application 就是個 periodic task，由外部定期起 container 的做法在平時可以將運算資源釋放出來，但如果 application 本身有 background task 要處理所以有自己的 task/job queue，那麼 periodic task 就可以由內部的 scheduler 來做。

        至於 schdeuler 能否跟 web application 綁在一起，則要看應用而定；單純處理 request 引發的 background task 沒問題，但如果是跟個別 request 無關的 background task 就不適合，因為起多個 web 時，會導致某個時間點有多個 scheduler 在做同一件事。

      - APScheduler has three built-in SCHEDULING SYSTEMS you can use:

          - Cron-style scheduling (with optional start/end times)
          - Interval-based execution (runs jobs on EVEN intervals, with optional start/end times)

          - ONE-OFF DELAYED EXECUTION (runs jobs once, on a set date/time)

            其實 task/job queue 在概念上，等同於 "排程儘快執行"，跟 scheduling 也有關係。

      - You can mix and match scheduling systems and the BACKENDS where the JOBS ARE STORED any way you like. Supported backends for storing jobs include:

          - Memory
          - SQLAlchemy (any RDBMS supported by SQLAlchemy works)
          - MongoDB
          - Redis
          - RethinkDB
          - ZooKeeper

      - APScheduler also integrates with several common Python frameworks, like:

          - asyncio (PEP 3156)
          - gevent
          - Tornado
          - Twisted
          - Qt (using either PyQt or PySide)

        跟如何實現 concurrency 有關 ??

    Choosing the right scheduler, job store(s), executor(s) and trigger(s)

      - Your choice of scheduler depends mostly on your programming environment and what you’ll be using APScheduler for. Here’s a quick guide for choosing a scheduler:

          - `BlockingScheduler`: use when the scheduler is THE ONLY THING RUNNING IN YOUR PROCESS

          - `BackgroundScheduler`: use when you’re NOT using any of the frameworks below, and want the scheduler to run in the BACKGROUND INSIDE YOUR APPLICATION

          - `AsyncIOScheduler`: use if your application uses the `asyncio` module
          - `GeventScheduler`: use if your application uses gevent
          - `TornadoScheduler`: use if you’re building a Tornado application
          - `TwistedScheduler`: use if you’re building a Twisted application
          - `QtScheduler`: use if you’re building a Qt application

      - To pick the appropriate job store, you need to determine whether you need JOB PERSISTENCE or not.

        If you always recreate your jobs at the start of your application, then you can probably go with the default (`MemoryJobStore`).

        But if you need your jobs to persist over scheduler restarts or application crashes, then your choice usually boils down to what tools are used in your programming environment. If, however, you are in the position to choose freely, then `SQLAlchemyJobStore` on a PostgreSQL backend is the recommended choice due to its STRONG DATA INTEGRITY protection.

      - Likewise, the choice of executors is usually MADE FOR YOU if you use one of the frameworks above. Otherwise, the default `ThreadPoolExecutor` should be good enough for most purposes.

        If your workload involves CPU INTENSIVE operations, you should consider using `ProcessPoolExecutor` instead to make use of multiple CPU cores. You could even use both at once, adding the process pool executor as a SECONDARY EXECUTOR ??.

      - When you schedule a job, you need to choose a trigger for it. The trigger determines the logic by which the dates/times are calculated when the job will be run. APScheduler comes with three built-in trigger types:

          - `date`: use when you want to run the job just once at a certain point of time
          - `interval`: use when you want to run the job at fixed intervals of time
          - `cron`: use when you want to run the job periodically at certain time(s) of day

        It is also possible to combine multiple triggers into one which fires either on times agreed on by ALL the participating triggers, or when ANY of the triggers would fire. For more information, see the documentation for [COMBINING TRIGGERS](https://apscheduler.readthedocs.io/en/latest/modules/triggers/combining.html#module-apscheduler.triggers.combining). #ril

      - You can find the plugin names of each job store, executor and trigger type on their respective API documentation pages.

    Configuring the scheduler

      - APScheduler provides many different ways to configure the scheduler. You can use a CONFIGURATION DICTIONARY or you can pass in the options as KEYWORD ARGUMENTS.

        You can also instantiate the scheduler first, add jobs and configure the scheduler AFTERWARDS. This way you get maximum flexibility for any environment.

      - The full list of SCHEDULER LEVEL configuration options can be found on the API reference of the `BaseScheduler` class. Scheduler subclasses may also have additional options which are documented on their respective API references.

        Configuration options for INDIVIDUAL JOB STORES and EXECUTORS can likewise be found on their API reference pages.

      - Let’s say you want to run `BackgroundScheduler` in your application with the default job store and the default executor:

            from apscheduler.schedulers.background import BackgroundScheduler

            scheduler = BackgroundScheduler()

            # Initialize the rest of the application here, or before the scheduler initialization

        This will get you a `BackgroundScheduler` with a `MemoryJobStore` named `default` and a `ThreadPoolExecutor` named `default` with a default maximum thread count of `10`.

      - Now, suppose you want more. You want to have two job stores using two executors and you also want to tweak the default values for new jobs and set a different timezone. The following three examples are completely equivalent, and will get you:

          - a `MongoDBJobStore` named `mongo`
          - an `SQLAlchemyJobStore` named `default` (using SQLite)
          - a `ThreadPoolExecutor` named `default`, with a worker count of `20`
          - a `ProcessPoolExecutor` named `processpool`, with a worker count of `5`
          - UTC as the scheduler’s timezone
          - COALESCING ?? turned off for new jobs by default
          - a default MAXIMUM INSTANCE LIMIT ?? of 3 for new jobs

        Method 1:

            from pytz import utc

            from apscheduler.schedulers.background import BackgroundScheduler
            from apscheduler.jobstores.mongodb import MongoDBJobStore
            from apscheduler.jobstores.sqlalchemy import SQLAlchemyJobStore
            from apscheduler.executors.pool import ThreadPoolExecutor, ProcessPoolExecutor

            jobstores = {
                'mongo': MongoDBJobStore(),
                'default': SQLAlchemyJobStore(url='sqlite:///jobs.sqlite')
            }
            executors = {
                'default': ThreadPoolExecutor(20),
                'processpool': ProcessPoolExecutor(5)
            }
            job_defaults = {
                'coalesce': False,
                'max_instances': 3
            }
            scheduler = BackgroundScheduler(jobstores=jobstores, executors=executors, job_defaults=job_defaults, timezone=utc)

        Method 2:

            from apscheduler.schedulers.background import BackgroundScheduler

            # The "apscheduler." prefix is hard coded
            scheduler = BackgroundScheduler({
                'apscheduler.jobstores.mongo': {
                     'type': 'mongodb'
                },
                'apscheduler.jobstores.default': {
                    'type': 'sqlalchemy',
                    'url': 'sqlite:///jobs.sqlite'
                },
                'apscheduler.executors.default': {
                    'class': 'apscheduler.executors.pool:ThreadPoolExecutor',
                    'max_workers': '20'
                },
                'apscheduler.executors.processpool': {
                    'type': 'processpool',
                    'max_workers': '5'
                },
                'apscheduler.job_defaults.coalesce': 'false',
                'apscheduler.job_defaults.max_instances': '3',
                'apscheduler.timezone': 'UTC',
            })

        Method 3:

            from pytz import utc

            from apscheduler.schedulers.background import BackgroundScheduler
            from apscheduler.jobstores.sqlalchemy import SQLAlchemyJobStore
            from apscheduler.executors.pool import ProcessPoolExecutor

            jobstores = {
                'mongo': {'type': 'mongodb'},
                'default': SQLAlchemyJobStore(url='sqlite:///jobs.sqlite')
            }
            executors = {
                'default': {'type': 'threadpool', 'max_workers': 20},
                'processpool': ProcessPoolExecutor(max_workers=5)
            }
            job_defaults = {
                'coalesce': False,
                'max_instances': 3
            }
            scheduler = BackgroundScheduler()

            # .. do something else here, maybe add jobs etc.

            scheduler.configure(jobstores=jobstores, executors=executors, job_defaults=job_defaults, timezone=utc)

    Starting the scheduler

      - Starting the scheduler is done by simply calling `start()` on the scheduler. For schedulers other than `BlockingScheduler`, this call will return immediately and you can continue the initialization process of your application, possibly adding jobs to the scheduler.

      - For `BlockingScheduler`, you will only want to call `start()` after you’re done with any initialization steps.

      - Note: After the scheduler has been started, you can no longer alter its settings.

    Adding jobs

      - There are two ways to add jobs to a scheduler:

          - by calling `add_job()`
          - by decorating a function with `scheduled_job()`

      - The first way is the most common way to do it. The second way is mostly a convenience to declare jobs that DON’T CHANGE DURING THE APPLICATION’S RUN TIME. The `add_job()` method returns a `apscheduler.job.Job` instance that you can use to modify or remove the job later.

      - You can schedule jobs on the scheduler at any time. If the scheduler is not yet running when the job is added, the job will be SCHEDULED TENTATIVELY and its first run time will only be computed when the scheduler starts.

      - It is important to note that if you use an executor or job store that serializes the job, it will add a couple requirements on your job:

          - The target callable must be GLOBALLY ACCESSIBLE ??
          - Any arguments to the callable must be serializable

        Of the builtin job stores, only `MemoryJobStore` DOESN’T SERIALIZE jobs. Of the builtin executors, only `ProcessPoolExecutor` will serialize jobs.

      - Important: If you schedule jobs in a persistent job store during your application’s initialization, you MUST define an explicit ID for the job and use `replace_existing=True` or you will get a new copy of the job every time your application restarts! ??

      - Tip: To run a job IMMEDIATELY, OMIT `trigger` argument when adding the job.

        也就是 task/job queue 的用法。

    Removing jobs

      - When you remove a job from the scheduler, it is removed from its associated job store and will not be executed anymore. There are two ways to make this happen:

          - by calling `remove_job()` with the job’s ID and job store ALIAS
          - by calling `remove()` on the `Job` instance you got from `add_job()`

        Example:

            job = scheduler.add_job(myfunc, 'interval', minutes=2)
            job.remove()
            Same, using an explicit job ID:

            scheduler.add_job(myfunc, 'interval', minutes=2, id='my_job_id')
            scheduler.remove_job('my_job_id')

        The latter method is probably more convenient, but it requires that you store somewhere the `Job` instance you received when adding the job. For jobs scheduled via the `scheduled_job()`, the first way is the only way. 

      - If the job’s schedule ends (i.e. its trigger doesn’t produce any further run times), it is automatically removed.

## 新手上路 {: #getting-started }

  - [User guide — APScheduler 3\.6\.0\.post2 documentation](https://apscheduler.readthedocs.io/en/latest/userguide.html) #ril

    Basic concepts

      - APScheduler has four kinds of components:

          - Triggers
          - Job stores
          - Executors
          - Schedulers

      - Triggers contain the SCHEDULING LOGIC. Each job has its own trigger which determines WHEN THE JOB SHOULD BE RUN NEXT. Beyond their initial configuration, triggers are completely STATELESS.

      - Job stores HOUSE THE SCHEDULED JOBS. The default job store simply keeps the jobs in MEMORY, but others store them in various kinds of databases.

        A job’s data is SERIALIZED when it is saved to a persistent job store, and deserialized when it’s loaded back from it.

        Job stores (other than the default one) don’t keep the job data in memory, but act as middlemen for saving, loading, updating and searching jobs in the backend. Job stores must NEVER BE SHARED BETWEEN SCHEDULERS.

      - Executors are what handle the running of the jobs. They do this typically by SUBMITTING the designated callable in a job to a THREAD or PROCESS POOL. When the job is done, the executor notifies the scheduler which then emits an appropriate EVENT ??.

        感覺這跟 asyncio、gevent 等的選擇有關 ??

      - Schedulers are what BIND THE REST TOGETHER. You typically have only ONE SCHEDULER running in your application.

        The application developer doesn’t normally deal with the job stores, executors or triggers directly. Instead, the scheduler provides the proper INTERFACE to handle all those.

        Configuring the job stores and executors is done through the scheduler, as is adding, modifying and removing jobs.

        所以嚴格來說 scheduler 不是 APScheduler 的一種 component，只是 job store + executor 的組合；帶有不同 trigger 的 job 被加進 scheduler (其實是加進 job store)，之後會被 executor 安排執行。

## Trigger, Job Store, Executor, Scheduler ??

  - [Basic concepts - User guide — APScheduler 3\.5\.0\.post9 documentation](https://apscheduler.readthedocs.io/en/latest/userguide.html#basic-concepts) Cron、interval ... #ril

## 安裝設定 {: #installation }

  - [Installing APScheduler - User guide — APScheduler 3\.6\.0\.post2 documentation](https://apscheduler.readthedocs.io/en/latest/userguide.html#installing-apscheduler)

    The preferred installation method is by using `pip`:

        $ pip install apscheduler

## 參考資料 {: #reference }

  - [Advanced Python Scheduler — APScheduler](https://apscheduler.readthedocs.io/)
  - [agronholm/apscheduler - GitHub](https://github.com/agronholm/apscheduler)

社群：

  - [Voted 'apscheduler' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/apscheduler)

手冊：

  - [APScheduler Documentation](https://apscheduler.readthedocs.io/)
  - [API Reference](http://apscheduler.readthedocs.io/en/latest/py-modindex.html)

      - [Cron Trigger (`apscheduler.triggers.cron`)](http://apscheduler.readthedocs.io/en/latest/modules/triggers/cron.html)
      - [Interval Trigger (`apscheduler.triggers.interval`](https://apscheduler.readthedocs.io/en/latest/modules/triggers/interval.html)
