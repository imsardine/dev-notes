---
title: Unix-like / Networking
---
# [Unix-like](unix.md) / Networking

## DHCP

  - [ip \- use dhcp on eth0 using command line \- Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/319740/use-dhcp-on-eth0-using-command-line)

      - andreatsh: If your `dhcp` is properly configured to give you an IP address, the command:

            dhclient eth0 -v

        should work. The option `-v` enable verbose log messages, it can be useful.

        If your `eth0` is already up, before asking for a new IP address, try to deconfigure `eth0`.

      - To configure the network interfaces based on interface definitions in the file `/etc/network/interfaces` you can use `ifup` and `ifdown` commands.

## 如何反查某個 port 是哪個 process 在 listen?

  - Linux 下用 `netstat -na | grep LISTEN | grep ':<PORT> '`
  - Mac 下用 `netstat -anv | grep .<PORT>`

參考資料：

  - osx - Who is listening on a given TCP port on Mac OS X? - Stack Overflow https://stackoverflow.com/questions/4421633/ 在 Linux 上用 `netstat -pntl | grep <PORT>` 就能找到 PID，在 Mac 上要怎麼做?
      - pts: 用 `lsof -n -i:$PORT | grep LISTEN`，Gordon Davisson: 加上 `sudo` 才能看到不是自己的 process。
      - Sean Hamilton: 在 Mac 上，`netstat` 加 `-v` 可以顯示 associated PID - `netstat -anv | grep [.]<PORT>`，例如 `netstat -anv | grep .4000`

