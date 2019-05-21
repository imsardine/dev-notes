# Celery

  - [Homepage \| Celery: Distributed Task Queue](http://www.celeryproject.org/)

      - Celery is an ASYNCHRONOUS TASK QUEUE/JOB QUEUE based on DISTRIBUTED MESSAGE PASSING. It is focused on REAL-TIME OPERATION??, but supports SCHEDULING as well.
      - The EXECUTION UNITS, called TASKS, are executed CONCURRENTLY on a single or more WORKER SERVERS using multiprocessing, Eventlet, or gevent. Tasks can execute asynchronously (in the background) or synchronously (wait until ready). 說是 concurrently，又說有 asynchronously/synchronously 兩種選擇??
      - Celery is used in production systems to process millions of tasks a day.

    EASY TO INTEGRATE

      - Celery is easy to integrate with web frameworks, some of which even have integration packages.
      - Celery is written in Python, but the PROTOCOL?? can be implemented in any language. It can also operate with other languages using WEBHOOKS??.

    MULTI BROKER SUPPORT

      - The recommended message broker is RabbitMQ, but support for Redis, Beanstalk, MongoDB, CouchDB, and databases (using SQLAlchemy or the Django ORM) is also available.

    Related Projects

      - [Celery Flower](https://github.com/mher/flower) - Real-time monitor and web admin for Celery 管理介面

          - Real-time monitoring using Celery Events
          - Remote Control
          - Broker monitoring
          - HTTP API
          - Basic Auth and Google OpenID authentication

      - [Jobtastic](http://policystat.github.io/jobtastic/) - A Celery library that makes your USER-RESPONSIVE long-running jobs totally awesomer.

        Jobtastic is a python library that adds useful features to your Celery tasks. Specifically, these are features you probably want if the results of your jobs are EXPENSIVE or if your users NEED TO WAIT while they compute their results. 可以持續更新進度??

## 新手上路 ?? {: #getting-started }

  - [Getting Started — Celery 4\.2\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/index.html) #ril
  - [First Steps with Celery — Celery 4\.2\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/first-steps-with-celery.html) #ril

## Broker ??

  - [Brokers — Celery 4\.2\.0 documentation](http://docs.celeryproject.org/en/latest/getting-started/brokers/) 支援 RabbitMQ、Redis 與 Amazon SQS #ril

## 安裝設定 {: #installation }

  - [Getting Started - Homepage \| Celery: Distributed Task Queue](http://www.celeryproject.org/#getStarted)

      - Install celery by download or `pip install -U Celery`
      - Set up RabbitMQ, Redis or one of the other supported BROKERS

  - [Download and Install \| Celery: Distributed Task Queue](http://www.celeryproject.org/install/) #ril

## 參考資料 {: #reference }

  - [Celery](http://www.celeryproject.org/)
  - [celery/celery - GitHub](https://github.com/celery/celery)
