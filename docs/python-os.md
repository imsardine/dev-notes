---
title: Python / OS
---
# [Python](python.md) / OS

## Hostname

  - 取 hostname 最通用的方法是 `socket.gethostname()`，雖然 `os.uname().nodename` 也可以取到一樣的結果，但只適用於 Unix-lie。

  - 在 Docker 取用 hostname 時，預設會拿到 container ID：

        $ docker run python:2.7 python -c 'import os, socket; print os.uname(), socket.gethostname()'
        ('Linux', '5744e91eadf5', '4.9.125-linuxkit', '#1 SMP Fri Sep 7 08:20:28 UTC 2018', 'x86_64') 5744e91eadf5

        $ docker ps -a | head -2
        CONTAINER ID        IMAGE                                                     COMMAND                  CREATED             STATUS                      PORTS                     NAMES
        5744e91eadf5        python:2.7                                                "python -c 'import o…"   13 seconds ago      Exited (0) 12 seconds ago                             hardcore_panini

    但啟動 container 時若有給定 hostname，就可以拿到辦識度比較高的 hostname：

        $ docker run --hostname python-playground python:2.7 python -c 'import os, socket; print os.uname(), socket.gethostname()'
        ('Linux', 'python-playground', '4.9.125-linuxkit', '#1 SMP Fri Sep 7 08:20:28 UTC 2018', 'x86_64') python-playground

---

參考資料：

  - [`os.uname()` - os — Miscellaneous operating system interfaces — Python 3\.7\.4rc1 documentation](https://docs.python.org/3/library/os.html#os.uname)

      - Returns information identifying the current operating system. The return value is an object with five attributes:

          - `sysname` - operating system name
          - `nodename` - name of machine on network (IMPLEMENTATION-DEFINED)
          - `release` - operating system release
          - `version` - operating system version
          - `machine` - hardware identifier

        For backwards compatibility, this object is also iterable, behaving like a five-tuple containing `sysname`, `nodename`, `release`, `version`, and `machine` in that order.

      - Some systems truncate `nodename` to 8 characters or to the leading component; a better way to get the hostname is `socket.gethostname()` or even `socket.gethostbyaddr(socket.gethostname())`.

        Availability: recent flavors of Unix.

        呼應上面 implementation-defined 的不確定性，加上只有 Unix-like 支援，`socket.gethostname()` 相較通用。

      - Changed in version 3.3: Return type changed from a tuple to a tuple-like object with named attributes.

  - [`socket.gethostname()` - socket — Low\-level networking interface — Python 3\.7\.4rc1 documentation](https://docs.python.org/3/library/socket.html#socket.gethostname)

      - Return a string containing the hostname of the machine where the Python interpreter is currently executing.
      - Note: `gethostname()` doesn’t always return the fully qualified domain name; use `getfqdn()` for that.
