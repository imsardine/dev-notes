---
title: Docker / Daemon
---
# [Docker](docker.md) / Daemon

  - [Configure and troubleshoot the Docker daemon \| Docker Documentation](https://docs.docker.com/config/daemon/) #ril

      - After successfully installing and starting Docker, the `dockerd` daemon runs with its default configuration. This topic shows how to customize the configuration, start the daemon manually, and troubleshoot and debug the daemon if you run into issues.

    Start the daemon using operating system utilities

      - On a typical installation the Docker daemon is started by a SYSTEM UTILITY, not manually by a user. This makes it easier to automatically start Docker when the machine reboots.

      - The command to start Docker depends on your operating system. Check the correct page under Install Docker. To configure Docker to start automatically at system boot, see Configure Docker to start on boot.

        [Configure Docker to start on boot - Post\-installation steps for Linux \| Docker Documentation](https://docs.docker.com/install/linux/linux-postinstall/#configure-docker-to-start-on-boot):

        > Most current Linux distributions (RHEL, CentOS, Fedora, Ubuntu 16.04 and higher) use `systemd` to manage which services start when the system boots. Ubuntu 14.10 and below use `upstart`.
        >
        >     $ sudo systemctl enable docker
        >
        > To disable this behavior, use `disable` instead.
        >
        >     $ sudo systemctl disable docker

    Start the daemon manually

      - If you don’t want to use a system utility to manage the Docker daemon, or just want to test things out, you can manually run it using the `dockerd` command. You may need to use `sudo`, depending on your operating system configuration.

      - When you start Docker this way, it runs in the foreground and sends its logs directly to your terminal.

            $ dockerd

            INFO[0000] +job init_networkdriver()
            INFO[0000] +job serveapi(unix:///var/run/docker.sock)
            INFO[0000] Listening for HTTP on unix (/var/run/docker.sock)

        To stop Docker when you have started it manually, issue a Ctrl+C in your terminal.

    Docker daemon directory

      - The Docker daemon PERSISTS ALL DATA IN A SINGLE DIRECTORY. This tracks everything related to Docker, including containers, images, volumes, service definition, and secrets.

        By default this directory is:

          - `/var/lib/docker` on Linux.
          - `C:\ProgramData\docker` on Windows.

        You can configure the Docker daemon to use a different directory, using the `data-root` configuration option.

      - Since the state of a Docker daemon is kept on this directory, make sure you use a dedicated directory for each daemon. If two daemons share the same directory, for example, an NFS share, you are going to experience errors that are difficult to troubleshoot.

    Check whether Docker is running

      - The operating-system INDEPENDENT way to check whether Docker is running is to ask Docker, using the `docker info` command.

        前題是 Docker daemon 要活著。

      - You can also use operating system utilities, such as `sudo systemctl is-active docker` or `sudo status docker` or `sudo service docker status`, or checking the service status using Windows utilities.

      - Finally, you can check in the process list for the `dockerd` process, using commands like `ps` or `top`.

        這不一定準，之前就遇到 `dockerd` process 活著但 `docker info` 沒回應的狀況，這時候 `sudo systemctl is-active docker` 還會回 `deactivating`。

## 疑難排解 {: #troubleshooting }

  - [Troubleshoot the daemon - Configure and troubleshoot the Docker daemon \| Docker Documentation](https://docs.docker.com/config/daemon/#troubleshoot-the-daemon) #ril

      - You can enable debugging on the daemon to learn about the runtime activity of the daemon and to aid in troubleshooting. If the daemon is completely non-responsive, you can also force a full stack trace of all threads to be added to the daemon log by sending the `SIGUSR` signal to the Docker daemon. ??

    Read the logs

      - The daemon logs may help you diagnose problems. The logs may be saved in one of a few locations, depending on the operating system configuration and the logging subsystem used:

          - RHEL, Oracle Linux: `/var/log/messages`
          - Debian: `/var/log/daemon.log`
          - Ubuntu 16.04+, CentOS: Use the command `journalctl -u docker.service`
          - Ubuntu 14.10-: `/var/log/upstart/docker.log`
          - macOS (Docker 18.01+): `~/Library/Containers/com.docker.docker/Data/vms/0/console-ring`
          - macOS (Docker <18.01): `~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/console-ring`
          - Windows: `AppData\Local`

### runtime: program exceeds 27720-thread limit fatal error: thread exhaustion ??

```
$ sudo journalctl -u docker.service | grep fatal -i -A 2 -B 2
Aug 05 10:17:55 my-docker-host dockerd[998]: time="2019-08-05T10:17:55.479257642+08:00" level=info msg="Loading containers: start."
Aug 05 10:26:32 my-docker-host dockerd[998]: runtime: program exceeds 27720-thread limit
Aug 05 10:26:32 my-docker-host dockerd[998]: fatal error: thread exhaustion
Aug 05 10:26:32 my-docker-host dockerd[998]: runtime stack:
Aug 05 10:26:32 my-docker-host dockerd[998]: runtime.throw(0x56268f8c4419, 0x11)

$ sudo ls -l /var/lib/docker
total 3036
drwx------     5 root root    4096 May 19  2017 aufs
drwx------     2 root root    4096 Dec 11  2018 builder
drwx------     4 root root    4096 Dec 11  2018 buildkit
drwx------     3 root root    4096 Aug  5 10:12 containerd
drwx------ 28826 root root 3047424 Aug  3 08:59 containers
drwx------     3 root root    4096 May 19  2017 image
drwxr-x---     3 root root    4096 May 19  2017 network
drwx------     4 root root    4096 May 19  2017 plugins
drwx------     2 root root    4096 Aug  5 13:43 runtimes
drwx------     2 root root    4096 May 19  2017 swarm
drwx------     2 root root    4096 Aug  5 13:43 tmp
drwx------     2 root root    4096 May 19  2017 trust
drwx------    10 root root    4096 Jul 24 18:04 volumes
```

這才發現 `/var/lib/docker/containers/` 下的 container 數量相當驚人，跟頻繁地執行 `docker run` (但沒有加 `--rm`) 有關。

  - [Docker crashes when MaxThreads is reached · Issue \#15258 · moby/moby](https://github.com/moby/moby/issues/15258) #ril

  - [orphaned diffs · Issue \#22207 · moby/moby](https://github.com/moby/moby/issues/22207)

      - CVTJNII: Stopping the Docker daemon and erasing all of `/var/lib/docker` will be safer. Erasing `/var/lib/docker/aufs` will cause you to lose your images anyway so it's better to start with a clean `/var/lib/docker` in my opinion. This is the "solution" I've been using for several months for this problem now.

        把 `/var/lib/docker` 全刪真不會出事嗎 ??
