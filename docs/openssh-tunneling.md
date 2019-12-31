---
title: OpenSSH / SSH Tunneling
---
# [OpenSSH](openssh.md) / SSH Tunneling

  - [ssh\(1\) \- OpenBSD manual pages](https://man.openbsd.org/ssh) #ril

      - `-J destination`

        Connect to the target host by first making a ssh connection to the JUMP HOST described by `destination` and then establishing a TCP forwarding to the ULTIMATE DESTINATION FROM THERE.

        Multiple JUMP HOPS may be specified separated by comma characters. This is a shortcut to specify a `ProxyJump` configuration directive. Note that configuration directives supplied on the command-line generally apply to the DESTINATION HOST and not any specified JUMP HOSTS. Use `~/.ssh/config` to specify configuration for jump hosts.

        原來 SSH 連線有 `-J` 可以用，不需要再透過 `ssh -L <local-port-to-listen>:<remote-host>:<remote-port>` 另外建立 tunnel!!

    TCP FORWARDING

      - Forwarding of arbitrary TCP connections over a SECURE CHANNEL can be specified either on the command line or IN A CONFIGURATION FILE. One possible application of TCP forwarding is a secure connection to a mail server; another is going through firewalls.

        常用的 port forwarding 能寫在 configuration file 確實方便許多，例如：

            Host <alias>
              HostName <remote_host>
              ProxyJump <jump_host>

        這樣直接用 `ssh <alias>` 就可以透過 `<jump_host>` 連往 `<remote_host>`，其中 `<alias>` 跟 DNS 解析無關。

      - In the example below, we look at encrypting communication for an IRC client, even though the IRC server it connects to does not directly support encrypted communication. This works as follows: the user connects to the remote host using `ssh`, specifying the ports to be used to forward the connection. After that it is possible to start the program locally, and `ssh` will encrypt and forward the connection to the REMOTE SERVER.

      - The following example tunnels an IRC session from the client to an IRC server at “server.example.com”, joining channel “#users”, nickname “pinky”, using the standard IRC port, 6667:

            $ ssh -f -L 6667:localhost:6667 server.example.com sleep 10
            $ irc -c '#users' pinky IRC/127.0.0.1

        The `-f` option BACKGROUNDS `ssh` and the remote command `sleep 10` is specified to allow an amount of time (10 seconds, in the example) to start the program which is going to use the tunnel. If no connections are made within the time specified, `ssh` will exit.

  - [Using ProxyJump with SSH and SCP](https://www.madboa.com/blog/2017/11/02/ssh-proxyjump/) (2017-11-02) #ril

      - `scp` 也支援 jump host，只是沒有像 `ssh` 有 `-J` 可以用，要自己給 option，例如 `scp -o 'ProxyJump your.jump.host'`。

## 參考資料 {: #reference }

  - [SSH Tunneling](ssh-tunneling.md)
