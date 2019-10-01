---
title: Redis / Persistence
---
# [Redis](redis.md) / Persistence

  - [Redis Persistence – Redis](https://redis.io/topics/persistence) #ril

      - Redis provides a different range of persistence options:

          - The RDB persistence performs POINT-IN-TIME SNAPSHOTS of your dataset at specified INTERVALS.

          - The AOF persistence LOGS EVERY WRITE OPERATION received by the server, that will be PLAYED AGAIN AT SERVER STARTUP, reconstructing the original dataset.

            Commands are logged using the same format as the Redis protocol itself, in an APPEND-ONLY fashion. Redis is able to REWRITE the log on background when it gets too big.

          - If you wish, you can disable persistence at all, if you want your data to just exist as long as the server is running.

            聽起來 RDB/AOF persistence 預設是啟用的 ??

          - It is possible to COMBINE both AOF and RDB in the same instance. Notice that, in this case, when Redis restarts the AOF file will be used to reconstruct the original dataset since it is guaranteed to be the MOST COMPLETE.

          - The most important thing to understand is the different TRADE-OFFS between the RDB and AOF persistence.

  - [Redis persistence demystified](http://oldblog.antirez.com/post/redis-persistence-demystified.html) (2012-03-26) #ril

## Backup

  - [Backing up Redis data - Redis Persistence – Redis](https://redis.io/topics/persistence#backing-up-redis-data) #ril
  - [How To Back Up and Restore Your Redis Data on Ubuntu 14\.04 \| DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-back-up-and-restore-your-redis-data-on-ubuntu-14-04) (2015-09-14) #ril
