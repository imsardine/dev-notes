# Redis

  - [Redis](https://redis.io/)

      - Redis is an open source (BSD licensed), IN-MEMORY DATA STRUCTURE STORE, used as a DATABASE, CACHE and MESSAGE BROKER.

        本質上是 key-value store，除了 cache 跟 messaging，雖然稱 in-memory database，因為可以長期儲存資料，是個名符其實的 NoSQL database，不一定要跟 cache 有關。

      - It supports data structures such as strings, hashes, lists, sets, sorted sets with RANGE QUERIES, bitmaps, hyperloglogs, geospatial indexes with RADIUS QUERIES and streams.

        不只資料型態豐富，查詢方式也很多元。

      - Redis has built-in REPLICATION, LUA SCRIPTING, LRU eviction, TRANSACTIONS and different levels of ON-DISK PERSISTENCE, and provides high availability via Redis Sentinel and automatic partitioning with Redis Cluster.

        做為 database，支援 persistence 與 transaction 自然不意外。

  - [Redis \+ MySQL = Fast, Economic Scaling \- DZone Database](https://dzone.com/articles/redis-mysql-fast-economic-scaling) (2018-10-04)

      - One of the things that is so great about Redis is how well it can COMPLEMENT AND EXTEND OTHER DATABASES in your ecosystem. While replacing LEGACY BACKEND DATABASES with newer ones is often seen as expensive and risky, they don't easily scale in the linear fashion required for users' 'instant experience' expectations.

      - Some of the things that make it difficult to accommodate modern application needs using a traditional MySQL architecture are:

          - Read/write speeds of traditional databases are not good enough for use cases such as SESSION STORES.
          - Introducing new tables or modifying an existing schema can be EXTREMELY COMPLEX, which makes adding new features and applications extremely difficult.

          - Legacy databases are limited by the number of OPERATIONS YOU CAN PERFORM PER SECOND and by the number of concurrent connections you can have. As a result, you end up having to invest in more database instances - increasing your infrastructure and maintenance costs.

            如果遇到交易衝突，locking 還會讓時間拉得更長。

          - On the other hand, in-memory databases like Redis can help you future-proof and increase the value of your investment. For instance, if your application stores data in MySQL or any other relational database, you can easily insert Redis as a FRONT-END DATABASE in between the application and MySQL.

            By designing LOOK-ASIDE AND WRITE-THROUGH CACHING solutions, session stores and RATE-LIMITERS with Redis, you'll boost performance, speed innovation, scale with fewer resources and ultimately deliver the best experience for your users.

            [Cache Usage Patterns - Ehcache](https://www.ehcache.org/documentation/3.7/caching-patterns.html) 清楚說明了 cache-aside 與 write-through。所謂 cache-aside 是 app 會先去問 cache，沒有才去跟資料來源 system-of-record (SoR) 拿並更新回 cache，而 write-through 則是經由 cache 寫入 SoR (也要搭配 read-through?)，所以 cache 總有最新的資料可以拿。

    Redis as a 'System of Engagement'

      - Redis' in-memory key-value data store can deliver LOW LATENCY RESPONSES for your users because it's extremely fast and flexible and includes built-in data structures (e.g. Lists, Hashes, Sets, Sorted Sets, Bitmaps, Hyperloglog, and Geospatial Indices) that perform some data operations more efficiently and effectively than relational databases.

        We recommend USING REDIS BEHIND THE DATA ACCESS LAYER as a 'system of engagement' to store the HOT DATA users engage with, while designating your MySQL as the 'system of record.'

        用 ORM 的話，ORM 本身就是 DAO，要把 cache 做在裡面可能有困難? 或許做在 repository 是個折衷，況且 repository 本來就可以做 cache，例如 [Using Repository Pattern for Abstracting Data Access from a Cache and Data Store • Rahul Nath](https://www.rahulpnath.com/blog/using-repository-pattern-for-abstracting-data-access-from-a-cache-and-data-store/) (2014-11-22) #ril

      - To avoid creating a bottleneck in their application, database or network layers, many developers use Redis for the following use cases:

          - Cache: This provides a TIERED MODEL FOR MEMORY ACCESS, in which applications store COMMON, REPEATEDLY READ OBJECTS in Redis. Caching helps applications retrieve data quickly and limit the load on the database server.

          - Session Store: In all interactive apps, the server maintains a unique session for each active user. Rather than relying on MySQL-like relational databases to persist session data, a single cluster of Redis on decently sized servers with sufficient RAM can manage thousands, if not millions of sessions.

          - Real-time Analytics: Gamification through leaderboards, dashboards, polls, messages, counters and other real-time aggregators require constant processing and communication with end-users. Redis' powerful and highly efficient data structures enable you to collect, process and dissipate millions of simultaneous activities or objects to thousands of active users in real time.

            但 Redis 跟 constant processing 似乎沒什麼關係? 只是 Redis 適合用來存放消化後的結果，大量的取用也沒問題。

          - Metering: Redis can also help developers cost-effectively manage the load on legacy servers during peak usage times by rate limiting the number of calls applications make every few seconds.

      - In addition to the examples above, Redis can be used as a MESSAGE BROKER, data structure store, and TEMPORARY DATA STORE for a variety of use cases. Essentially, Redis gets your data closer and faster to your end user while collecting their data more quickly.

        Taking things to the next level, REDIS ENTERPRISE offers high availability, in-memory replication, auto-scaling, and re-sharding along with leading-edge CRDT-based active-active support for distributed databases and built-in Redis modules such as RediSearch, ReJSON, Rebloom, and Redis Graph.

        所以 HA 是 Redis Enterprise 收費版本才有的東西 ??

      - Thanks to this powerful database, today's 'instant experience' demands can be met without ripping out your legacy solutions. Using a bit of creativity, you can instead leverage Redis to BALANCE the need for business continuity and time-to-market with the benefits of superior performance, flexibility, extensibility and scalability.

  - [Redis \- Wikipedia](https://en.wikipedia.org/wiki/Redis) #ril
  - [Why Redis Open Source \| Redis Labs](https://redislabs.com/why-redis/) #ril
  - [Introduction to Redis – Redis](https://redis.io/topics/introduction) #ril
  - [FAQ – Redis](https://redis.io/topics/faq) #ril

## 應用實例 {: #powered-by }

  - [Amazon ElastiCache\- In\-memory data store and cache](https://aws.amazon.com/elasticache/)

      - Amazon ElastiCache offers fully managed Redis and Memcached. Seamlessly deploy, run, and scale popular open source compatible in-memory data stores. Build DATA-INTENSIVE apps or improve the performance of your existing apps by RETRIEVING DATA FROM high throughput and low latency IN-MEMORY DATA STORES.

        Amazon ElastiCache is a popular choice for Gaming, Ad-Tech, Financial Services, Healthcare, and IoT apps.

        會提到 IoT apps，大概是因為 client 的數量很多??

## 新手上路 {: #getting-started }

  - 先走過一遍 [Try Redis](http://try.redis.io/)。

---

參考資料：

  - [Try Redis](http://try.redis.io/)

      - Welcome to Try Redis, a demonstration of the REDIS DATABASE!

      - Please type `TUTORIAL` to begin a brief tutorial, `HELP` to see a list of supported commands, or any valid REDIS COMMAND to play with the database.

        例如 `HELP SET` 可以顯示 `SET` Redis command 的用法；不分大小寫。

    STEP 1

      - Redis is what is called a KEY-VALUE STORE, often referred to as a NoSQL DATABASE. The essence of a key-value store is the ability to store some data, called a value, inside a key. This data can later be retrieved only if we know the EXACT KEY used to store it. We can use the command `SET` to store the value `"fido"` at key `"server:name"`:

            SET server:name "fido"

        注意 key `server:name` 不用引號，但 value `"fido"` 就要加引號。

      - Redis will store our data PERMANENTLY, so we can later ask "What is the value stored at key `server:name`?" and Redis will reply with `"fido"`:

            GET server:name => "fido"

      - Tip: You can click the commands above to automatically execute them. The text after the arrow (=>) shows the expected output.

    STEP 2

      - Other common operations provided by key-value stores are `DEL` to delete a given key and ASSOCIATED VALUE, SET-if-not-exists (called `SETNX` on Redis) that sets a key only if it does not already exist, and `INCR` to atomically increment a number stored at a given key:

            SET connections 10
            INCR connections => 11
            INCR connections => 12
            DEL connections
            INCR connections => 1

        `INCR` 不用讀出來就可以加 1，少了一次與 Redis 的溝通，用來實現計數器很有效率。

    STEP 3

      - There is something special about `INCR`. Why do we provide such an operation if we can do it ourself with a bit of code? After all it is as simple as:

            x = GET count
            x = x + 1
            SET count x

      - The problem is that doing the increment in this way will only work as long as there is a SINGLE CLIENT USING THE KEY. See what happens if two clients are accessing this key at the same time:

            Client A reads count as 10.
            Client B reads count as 10.
            Client A increments 10 and sets count to 11.
            Client B increments 10 and sets count to 11.

        We wanted the value to be 12, but instead it is 11! This is because incrementing the value in this way is not an ATOMIC OPERATION. Calling the `INCR` command in Redis will prevent this from happening, because it is an atomic operation. Redis provides many of these atomic operations on different types of data.

        複雜一點的操作就得透過 transaction。

    STEP 4

      - Redis can be told that a key should only EXIST FOR A CERTAIN LENGTH OF TIME. This is accomplished with the `EXPIRE` and `TTL` commands.

            SET resource:lock "Redis Demo"
            EXPIRE resource:lock 120

      - This causes the key `resource:lock` to be deleted in 120 seconds. You can test how long a key will exist with the `TTL` command. It returns the number of seconds until it will be deleted.

            TTL resource:lock => 113
            // after 113s
            TTL resource:lock => -2

        The `-2` for the `TTL` of the key means that THE KEY DOES NOT EXIST (ANYMORE). A `-1` for the `TTL` of the key means that it will NEVER EXPIRE.

      - Note that if you `SET` a key, its `TTL` will be RESET.

            SET resource:lock "Redis Demo 1"
            EXPIRE resource:lock 120
            TTL resource:lock => 119
            SET resource:lock "Redis Demo 2"
            TTL resource:lock => -1

        所謂 reset 不是回到上次的 TTL 重新倒數，而是沒有 TTL 了，也就是不會過期。

    STEP 5

      - Redis also supports several more complex data structures. The first one we'll look at is a LIST. A list is a series of ordered values. Some of the important commands for interacting with lists are `RPUSH`, `LPUSH`, `LLEN`, `LRANGE`, `LPOP`, and `RPOP`.

        大部份 list 相關的指都以 `L` 開頭，但區分 left/right 兩側時，`L` 代表 left，例如 `LPOP`/`RPOP`。

        You can IMMEDIATELY BEGIN WORKING WITH A KEY AS A LIST, as long as it doesn't already exist as a different type.

        不用先放進一個 (空的) list，就能直接用操作 list 的指令，例如下面 `RPUSH friends "Alice"。

      - `RPUSH` puts the new value at the end of the list.

            RPUSH friends "Alice"
            RPUSH friends "Bob"

      - `LPUSH` puts the new value at the start of the list.

            LPUSH friends "Sam"

      - `LRANGE` gives a SUBSET of the list. It takes the index of the first element you want to retrieve as its first parameter and the index of the last element you want to retrieve as its second parameter. A value of `-1` for the second parameter means to retrieve elements UNTIL THE END of the list.

            LRANGE friends 0 -1 => 1) "Sam", 2) "Alice", 3) "Bob"
            LRANGE friends 0 1 => 1) "Sam", 2) "Alice"
            LRANGE friends 1 2 => 1) "Alice", 2) "Bob"

        從結果來看，index 是 0-based，而且第 2 個 index 會包含在結果裡，也就是 `[start, end]` 而非 `[start, end)`。

    STEP 6

      - `LLEN` returns the current length of the list.

            LLEN friends => 3

      - `LPOP` removes the first element from the list and returns it.

            LPOP friends => "Sam"

      - `RPOP` removes the last element from the list and returns it.

            RPOP friends => "Bob"

      - Note that the list now only has one element:

            LLEN friends => 1
            LRANGE friends 0 -1 => 1) "Alice"

    STEP 7

      - The next data structure that we'll look at is a SET. A set is similar to a list, except it does not have a specific order and each element may only appear once. Some of the important commands in working with sets are `SADD`, `SREM`, `SISMEMBER`, `SMEMBERS` and `SUNION`.

        跟 list 相關的指令以 `L` 開頭一樣，set 相關的指令都以 `S` 開頭。

      - `SADD` adds the given value to the set.

            SADD superpowers "flight"
            SADD superpowers "x-ray vision"
            SADD superpowers "reflexes"

      - `SREM` removes the given value from the set.

            SREM superpowers "reflexes"

    STEP 8

      - `SISMEMBER` tests if the given value is in the set. It returns `1` if the value is there and `0` if it is not.

            SISMEMBER superpowers "flight" => 1
            SISMEMBER superpowers "reflexes" => 0

      - `SMEMBERS` returns a list of all the members of this set.

            SMEMBERS superpowers => 1) "flight", 2) "x-ray vision"

      - `SUNION` COMBINES two or more sets and returns the list of all elements.

            SADD birdpowers "pecking"
            SADD birdpowers "flight"
            SUNION superpowers birdpowers => 1) "pecking", 2) "x-ray vision", 3) "flight"

        原來 Redis command 也可以同時操作兩個 key。

    STEP 9

      - Sets are a very handy data type, but as they are unsorted they don't work well for a number of problems. This is why Redis 1.2 introduced SORTED SETS.

      - A sorted set is similar to a regular set, but now each value has an ASSOCIATED SCORE. This score is used to sort the elements in the set.

            ZADD hackers 1940 "Alan Kay"            # 3
            ZADD hackers 1906 "Grace Hopper"        # 0
            ZADD hackers 1953 "Richard Stallman"    # 4
            ZADD hackers 1965 "Yukihiro Matsumoto"  # 6
            ZADD hackers 1916 "Claude Shannon"      # 2
            ZADD hackers 1969 "Linus Torvalds"      # 7
            ZADD hackers 1957 "Sophie Wilson"       # 5
            ZADD hackers 1912 "Alan Turing"         # 1

        In these examples, the scores are years of birth and the values are the names of famous hackers.

            ZRANGE hackers 2 4 => 1) "Claude Shannon", 2) "Alan Kay", 3) "Richard Stallman"

        也就是跟加入的順序無關，而是依 score 排序；這裡對 sorted set 的說明不多，相關的指令還有 `ZCARD` (總數)、`ZPOPMIN` (取出分數最低者)、`ZPOPMAX` (取出分數最高者) 等，完整的列表在 [Command Reference](https://redis.io/commands#sorted_set)。

    STEP 10

      - Simple strings, sets and sorted sets already get a lot done but there is one more data type Redis can handle: HASHES.

        Hashes are MAPS BETWEEN STRING FIELDS AND STRING VALUES, so they are the perfect data type to represent OBJECTS (eg: A User with a number of fields like `name`, `surname`, `age`, and so forth):

            HSET user:1000 name "John Smith"
            HSET user:1000 email "john.smith@example.com"
            HSET user:1000 password "s3cret"

        原來 hash 可以用來表現 object，且 value 並不是只能用 string，下一頁就會明數字做為 value。

      - To get back the saved data use `HGETALL`:

            HGETALL user:1000

      - You can also set multiple fields at once:

            HMSET user:1001 name "Mary Jones" password "hidden" email "mjones@example.com"

      - If you only need a single field value that is possible as well:

            HGET user:1001 name => "Mary Jones"

    STEP 11

      - Numerical values in hash fields are handled exactly the same as in simple strings and there are operations to increment this value in an ATOMIC WAY.

            HSET user:1000 visits 10
            HINCRBY user:1000 visits 1 => 11
            HINCRBY user:1000 visits 10 => 21
            HDEL user:1000 visits
            HINCRBY user:1000 visits 1 => 1

  - [Get Started with Redis \| Redis Labs](https://redislabs.com/resources/get-started-with-redis/) #ril
  - [Tutorial: Design and implementation of a simple Twitter clone using PHP and the Redis key\-value store – Redis](https://redis.io/topics/twitter-clone) #ril

## CLI ??

  - [redis\-cli, the Redis command line interface – Redis](https://redis.io/topics/rediscli) #ril

      - `redis-cli` is the Redis command line interface, a simple program that allows to send commands to Redis, and read the replies sent by the server, directly from the terminal.

      - It has two MAIN MODES: an INTERACTIVE MODE where there is a REPL (Read Eval Print Loop) where the user types commands and get replies; and another mode where the command is sent as arguments of `redis-cli`, executed, and printed on the standard output.

        In interactive mode, `redis-cli` has basic LINE EDITING capabilities to provide a good typing experience.

      - However `redis-cli` is not just that. There are options you can use to launch the program in order to put it into SPECIAL MODES, so that `redis-cli` can definitely do more complex tasks, like simulate a SLAVE and print the REPLICATION STREAM it receives from the master, check the LATENCY of a Redis server and show STATISTICS or even an ASCII-art spectrogram of latency samples and frequencies, and many other things.

        This guide will cover the different aspects of `redis-cli`, starting from the simplest and ending with the more advanced ones.

    Command line usage

      - To just run a command and have its reply printed on the standard output is as simple as typing the command to execute as separated arguments of `redis-cli`:

            $ redis-cli incr mycounter
            (integer) 7

      - The reply of the command is "7". Since Redis replies are TYPED (they can be strings, arrays, integers, `NULL`, errors and so forth), you see the TYPE OF THE REPLY between brackets. However that would be not exactly a great idea when the output of `redis-cli` must be used as input of another command, or when we want to redirect it into a file.

        Actually `redis-cli` only shows additional information which improves readability for humans when it detects the STANDARD OUTPUT IS A TTY (a terminal basically). Otherwise it will AUTO-ENABLE THE RAW OUTPUT MODE, like in the following example:

            $ redis-cli incr mycounter > /tmp/output.txt
            $ cat /tmp/output.txt
            8

        This time `(integer)` was omitted from the output since the CLI detected the output was no longer written to the terminal. You can FORCE RAW OUTPUT even on the terminal with the `--raw` option:

          $ redis-cli --raw incr mycounter
          9

        Similarly, you can force human readable output when writing to a file or in pipe to other commands by using `--no-raw`.

      - If you are going to use Redis extensively, or if you already do, chances are you happen to use `redis-cli` a lot. Spending some time to familiarize with it is likely a very good idea, you'll see that you'll work more effectively with Redis once you know all the TRICKS of its command line interface.

## Python

  - [redis-py](redis-py.md)
  - [aioredis](https://github.com/aio-libs/aioredis)

參考資料：

  - [Get Started, Part 2: Containers \| Docker Documentation](https://docs.docker.com/get-started/part2/) 用 Docker + Flask + Redis 來做計數器

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

    搭配的 Redis 在 [Get Started, Part 5: Stacks \| Docker Documentation](https://docs.docker.com/get-started/part5/#persist-the-data) 在 `docker-compose.yml` 裡設定：

        version: "3"
        services:
          web:
            ...
          visualizer:
            ...
          redis:
            image: redis
            ports:
              - "6379:6379"
            volumes:
              - "/home/docker/data:/data"
            deploy:
              placement:
                constraints: [node.role == manager]
            command: redis-server --appendonly yes
            networks:
              - webnet
        networks:
          webnet:

  - [Python Clients - Redis](https://redis.io/clients#python) - 星星數最高的是 `redis-py`，也就是 PyPI 下的 `redis`；有 async 裡星星數最高的則是 [`aioredis`](https://github.com/aio-libs/aioredis)。

## Type ??

  - [Data types – Redis](https://redis.io/topics/data-types) #ril
  - [An introduction to Redis data types and abstractions – Redis](https://redis.io/topics/data-types-intro) #ril

## Cache ??

  - [Redis](https://redis.io/) 可以做為 cache，也支援 LRU eviction (逐出/收回)。
  - [EXPIRE – Redis](https://redis.io/commands/expire) #ril
  - [Using Redis as an LRU cache – Redis](https://redis.io/topics/lru-cache) #ril
  - [Least recently used (LRU) - Cache replacement policies \- Wikipedia](https://en.wikipedia.org/wiki/Cache_replacement_policies#Least_recently_used_(LRU)) #ril

## Messaging ??

  - [Pub/Sub – Redis](https://redis.io/topics/pubsub) #ril

## Session Store ??

  - [Cache vs\. Session Store \| Redis Labs](https://redislabs.com/blog/cache-vs-session-store/) (2017-11-15) #ril

## Rate Limiter ??

  - [Redis \+ MySQL = Fast, Economic Scaling \- DZone Database](https://dzone.com/articles/redis-mysql-fast-economic-scaling) (2018-10-04)

      - Metering: Redis can also help developers cost-effectively manage the LOAD ON LEGACY SERVERS during peak usage times by RATE LIMITING the number of calls applications make every few seconds.

  - [Basic Rate Limiting Pattern \| Redis Labs](https://redislabs.com/redis-best-practices/basic-rate-limiting/) 若 rate limiting 可以做在 Redis 這一層，猜想 API key 也是存在 Redis 裡? #ril

  - [Flask\-Limiter — Flask\-Limiter 1\.0\.1\+0\.gb390e64\.dirty documentation](https://flask-limiter.readthedocs.io/en/stable/) #ril

## Time Series Database ??

  - [Using Redis as a Time Series Database: Why and How](https://www.infoq.com/articles/redis-time-series) (2016-01-02) #ril

## Performance ??

  - [Using pipelining to speedup Redis queries – Redis](https://redis.io/topics/pipelining) #ril
  - [Memory optimization - Redis](https://redis.io/topics/memory-optimization) #ril
  - [Redis Mass Insertion – Redis](https://redis.io/topics/mass-insert) 可能跟 IoT 有關? #ril

## 安裝設定 {: #installation }

  - [Download - Redis](https://redis.io/download) #ril

### Docker

```
$ REDIS_VERSION=5.0.4
$ docker run --rm -d --name myredis \
    --publish 6379:6379 \
    --volume ${PWD}/data:/data \
    redis:${REDIS_VERSION}-alpine \
    redis-server --appendonly yes

$ ls data
appendonly.aof

$ docker run --rm -it --link myredis redis \
    redis-cli -h myredis ping
PONG
```

讓 CLI 用起來更直覺：

```
$ alias redis-cli="docker run -it --rm redis redis-cli -h host.docker.internal"
$ redis-cli ping
PONG
$ redis-cli ping -h other-redis-server
...
```

---

參考資料：

  - [Download - Redis](https://redis.io/download)

      - It is possible to get Docker images of Redis from the Docker Hub. Multiple versions are available, usually updated in a short time after a new release is available.

  - [How to use this image - redis \- Docker Hub](https://hub.docker.com/_/redis#how-to-use-this-image) #ril

    Start a redis instance

        $ docker run --name some-redis -d redis

    Start with PERSISTENT STORAGE

      - If persistence is enabled, data is stored in the VOLUME `/data`, which can be used with `--volumes-from some-volume-container` or `-v /docker/host/dir:/data`.

            $ docker run --name some-redis -d redis redis-server --appendonly yes

        其中 `--appendonly yes` 表示採用 AOF persistence。

    Connecting via redis-cli

        $ docker run -it --network some-network --rm redis redis-cli -h some-redis

    Additionally, If you want to use your own `redis.conf` ...

      - You can create your own `Dockerfile` that adds a `redis.conf` from the context into `/data/`, like so.

            FROM redis
            COPY redis.conf /usr/local/etc/redis/redis.conf
            CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]

      - Alternatively, you can specify something along the same lines with `docker run` options.

            $ docker run -v /myredis/conf/redis.conf:/usr/local/etc/redis/redis.conf \
                     --name myredis redis redis-server /usr/local/etc/redis/redis.conf

        Where `/myredis/conf/` is a local directory containing your `redis.conf` file. Using this method means that there is no need for you to have a `Dockerfile` for your redis container.

    `32bit` variant

      - This variant is not a 32bit image (and will not run on 32bit hardware), but includes Redis compiled as a 32BIT BINARY, especially for users who need the DECREASED MEMORY REQUIREMENTS associated with that.

    `redis:<version>`

      - This is the defacto image. If you are unsure about what your needs are, you probably want to use this one. It is designed to be used both as a THROW AWAY CONTAINER (mount your source code and start the container to start your app), as well as the BASE TO BUILD OTHER IMAGES off of.

    `redis:<version>-alpine`

      - This image is based on the popular Alpine Linux project, available in the alpine official image. Alpine Linux is MUCH SMALLER than most distribution base images (~5MB), and thus leads to much slimmer images in general.

      - This variant is highly recommended when final image size being as small as possible is desired. The main caveat to note is that it does use musl libc instead of glibc and friends, so CERTAIN SOFTWARE MIGHT RUN INTO ISSUES depending on the depth of their libc requirements. However, most software doesn't have an issue with this, so this variant is usually a VERY SAFE CHOICE.

        如果是這樣，為什麼不是它成為 defacto image? 因為通常不會在 Redis container 裡再運作其他東西，上面的問題應該不存在。

## 參考資料 {: #reference }

  - [Redis](https://redis.io/)
  - [antirez/redis - GitHub](https://github.com/antirez/redis)
  - [Tech Blog | Redis Labs](https://redislabs.com/community/tech-blog/)

社群：

  - ['redis' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/redis/)
  - [Redis News Feed (@redisfeed) | Twitter](https://twitter.com/redisfeed)

書籍：

  - [Redis in Action | Redis Labs](https://redislabs.com/community/ebook/) (free)
  - [Redis 4.x Cookbook - PACKT](https://www.packtpub.com/big-data-and-business-intelligence/redis-4x-cookbook) (2018-02)
  - [Mastering Redis - PACKT](https://www.packtpub.com/big-data-and-business-intelligence/mastering-redis) (2016-05)
  - [Redis Essentials - PACKT](https://www.packtpub.com/big-data-and-business-intelligence/redis-essentials) (2015-09)
  - [Learning Redis - PACKT](https://www.packtpub.com/big-data-and-business-intelligence/learning-redis) (2015-06)
  - [Redis Applied Design Patterns - PACKT](https://www.packtpub.com/big-data-and-business-intelligence/redis-applied-design-patterns) (2014-09)
  - [Building Scalable Apps with Redis and Node.js - PACKT](https://www.packtpub.com/web-development/building-scalable-apps-redis-and-nodejs) (2014-09)
  - [Redis in Action - Manning](https://www.manning.com/books/redis-in-action) (2013-06)
  - [The Little Redis Book](https://www.openmymind.net/2012/1/23/The-Little-Redis-Book/) (2012-01)
  - [Redis Cookbook - O'Reilly](http://shop.oreilly.com/product/0636920020127.do) (2011-07)

文件：

  - [Redis Docuementation](https://redis.io/documentation)
  - [FAQ – Redis](https://redis.io/topics/faq)
  - [Best Practices | Redis Labs](https://redislabs.com/community/redis-best-practices/)

更多：

  - [Backup](redis-backup.md)

手冊：

  - [Command Reference – Redis](https://redis.io/commands)
