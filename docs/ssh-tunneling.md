---
title: SSH / Tunneling
---
# [SSH](ssh.md) / Tunneling

  - [SSH Tunneling Explained \| Source Open](https://chamibuddhika.wordpress.com/2012/03/21/ssh-tunnelling-explained/) (2012-03-21)

      - Recently I wanted to set up a remote desktop sharing session from home pc to my laptop. While going through the set up guide I came across SSH TUNNELING. Even though there are many articles on the subject still it took me a considerable amount of googling, some experimenting and couple of Wireshark sessions to grasp what’s going under the hood. Most of the guides were incomplete in terms of explaining the concept which left me desiring for a good article on the subject with some explanatory illustrations. So I decided to write it my self. So here goes…

    Introduction

      - A SSH tunnel consists of an encrypted tunnel created through a SSH protocol connection. A SSH tunnel can be used to transfer UNENCRYPTED TRAFFIC over a network through an ENCRYPTED CHANNEL.

        這段是抄 [Wikipedia](https://en.wikipedia.org/wiki/Tunneling_protocol#Secure_Shell_tunneling) 的。

      - For example we can use a ssh tunnel to securely transfer files between a FTP server and a client even though the FTP protocol itself is not encrypted. SSH tunnels also provide a means to bypass firewalls that prohibits or filter certain internet services. For example an organization will block certain sites using their proxy filter. But users may not wish to have their web traffic monitored or blocked by the organization proxy filter.

        If users can connect to an external SSH server, they can create a SSH tunnel to FORWARD a given port on their local machine to port 80 on remote web-server via the EXTERNAL SSH SERVER. I will describe this scenario in detail in a little while.

        關鍵在於把外部 SSH server 當做跳板。

      - To set up a SSH tunnel a given port of one machine needs to be forwarded (of which I am going to talk about in a little while) to a port in the other machine which will be the other end of the tunnel. Once the SSH tunnel has been established, the user can connect to EARLIER SPECIFIED PORT at first machine to access the network service.

        與 external SSH server 搭建好 tunnel 時，就要指定 remote server 的 IP & port ??

    Port Forwarding

      - SSH tunnels can be created in several ways using different kinds of PORT FORWARDING mechanisms. Ports can be forwarded in three ways.

          - Local port forwarding
          - Remote port forwarding
          - Dynamic port forwarding

        I didn’t explain what port forwarding is. I found Wikipedia’s definition more explanatory.

        > Port forwarding or PORT MAPPING is a name given to the combined technique of
        >
        > - TRANSLATING the address and/or port number of a packet to a new destination
        > - possibly accepting such packet(s) in a packet filter(firewall)
        > - forwarding the packet according to the routing table.

      - Here the first technique will be used in creating an SSH tunnel. When a client application connects to the local port (LOCAL ENDPOINT) of the SSH tunnel and transfer data these data will be forwarded to the REMOTE END by TRANSLATING the host and port values to that of the remote end of the channel.

        So with that let’s see how SSH tunnels can be created using forwarded ports with an examples.

    Tunnelling with Local port forwarding

      - Let’s say that yahoo.com is being blocked using a proxy filter in the University. (For the sake of this example. :). Cannot think any valid reason why yahoo would be blocked). A SSH tunnel can be used to bypass this restriction.

        Let’s name my machine at the university as ‘work’ and my home machine as ‘home’. ‘home’ needs to have a public IP for this to work. And I am running a SSH server on my home machine. Following diagram illustrates the scenario.

        ![](https://chamibuddhika.files.wordpress.com/2012/03/scenario.jpg)

        人在公司，把自己家裡的機器 (有 public IP，執行有 SSH server) 當做跳板；下面 Reverse Tunneling 則反過來要從家裡連到公司的機器。

      - To create the SSH tunnel execute following from ‘work’ machine.

            ssh -L 9001:yahoo.com:80 home

        The `L` switch indicates that a LOCAL PORT FORWARD is need to be created. The switch syntax is as follows.

            -L <local-port-to-listen>:<remote-host>:<remote-port>

        Now the SSH client at ‘work’ will connect to SSH server running at ‘home’ (usually running at port 22) binding port 9001 of ‘work’ to listen for LOCAL REQUESTS thus creating a SSH tunnel between ‘home’ and ‘work’. At the ‘home’ end it will create a connection to ‘yahoo.com’ at port 80.

        So ‘work’ doesn’t need to know how to connect to yahoo.com. Only ‘home’ needs to worry about that. The channel between ‘work’ and ‘home’ will be encrypted while the connection between ‘home’ and ‘yahoo.com’ will be unencrypted.

        呼應上面講的 "forwarding the packet according to the routing table"，因為 gateway 如何能接觸到 remote server 溝通，跟 gateway 那台的 routing table 很有關係 -- `remote-host` 的解讀是發生在 gateway 上，是相對於 gateway 的。

      - Now it is possible to browse yahoo.com by visiting http://localhost:9001 in the web browser at ‘work’ computer. The ‘home’ computer will act as a GATEWAY which would accept requests from ‘work’ machine and fetch data and tunnelling it back. So the syntax of the full command would be as follows.

            ssh -L <local-port-to-listen>:<remote-host>:<remote-port> <gateway>

        The image below describes the scenario.

        ![](https://chamibuddhika.files.wordpress.com/2012/03/localportforwarding.jpg)

        Here the ‘host’ (指 'home') to ‘yahoo.com’ connection is only made when browser makes the request NOT AT THE TUNNEL SETUP TIME.

      - It is also possible to specify a port in the ‘home’ computer itself instead of connecting to an external host. This is useful if I were to set up a VNC session between ‘work’ and ‘home’. Then the command line would be as follows.

            ssh -L 5900:localhost:5900 home (Executed from 'work')

        So here what does `localhost` refer to? Is it the ‘work’ since the command line is executed from ‘work’? Turns out that it is not. As explained earlier is RELATIVE TO THE GATEWAY (‘home’ in this case) , not the machine from where the tunnel is initiated. So this will make a connection to port 5900 of the ‘home’ computer where the VNC client would be listening in.

      - The created tunnel can be used to transfer all kinds of data not limited to web browsing sessions. We can also tunnel SSH sessions from this as well. Let’s assume there is another computer (‘banned’) to which we need to SSH from within University but the SSH access is being blocked. It is possible to tunnel a SSH session to this host using a local port forward. The setup would look like this.

        ![](https://chamibuddhika.files.wordpress.com/2012/03/sshsessionforwarding.jpg)

        As can be seen now the transferred data between ‘work’ and ‘banned’ are encrypted end to end. For this we need to create a local port forward as follows.

            ssh -L 9001:banned:22 home

        Now we need to create a SSH session to local port 9001 from where the session will get tunneled to ‘banned’ via ‘home’ computer.

            ssh -p 9001 localhost

        With that let’s move on to next type of SSH tunnelling method, reverse tunnelling.

    Reverse Tunnelling with remote port forwarding

      - Let’s say it is required to connect to an internal university website from home.

        The university firewall is blocking all incoming traffic. How can we connect from ‘home’ to internal network so that we can browse the internal site? A VPN setup is a good candidate here. However for this example let’s assume we don’t have this facility. Enter SSH reverse tunnelling..

        也因此 SSH Tunneling 有 "窮人的 VPN" 這種說法。

      - As in the earlier case we will initiate the tunnel from ‘work’ computer behind the firewall. This is possible since only incoming traffic is blocking and outgoing traffic is allowed. However instead of the earlier case the client will now be at the ‘home’ computer. Instead of `-L` option we now define `-R` which specifies a REVERSE TUNNEL need to be created.

            ssh -R 9001:intra-site.com:80 home (Executed from 'work')

        Once executed the SSH client at ‘work’ will connect to SSH server running at home creating a SSH channel. Then the server will bind port 9001 on ‘home’ machine to listen for incoming requests which would subsequently be routed through the created SSH channel between ‘home’ and ‘work’. Now it’s possible to browse the internal site by visiting http://localhost:9001 in ‘home’ web browser.

        The ‘work’ will then create a connection to intra-site and relay back the response to ‘home’ via the created SSH channel.

        ![](https://chamibuddhika.files.wordpress.com/2012/03/remoteportforwarding.jpg)

      - As nice all of these would be still you need to create another tunnel if you need to connect to another site in both cases. Wouldn’t it be nice if it is possible to proxy traffic to ANY SITE using the SSH channel created? That’s what DYNAMIC PORT FORWARDING is all about.

    Dynamic Port Forwarding

      - Dynamic port forwarding allows to configure ONE local port for tunnelling data to all remote destinations. However to utilize this the client application connecting to local port should send their traffic using the SOCKS protocol. At the client side of the tunnel a SOCKS PROXY would be created and the application (eg. browser) uses the SOCKS protocol to specify where the traffic should be sent when it leaves the other end of the ssh tunnel.

            ssh -D 9001 home (Executed from 'work')

        Here SSH will create a SOCKS proxy listening in for connections at local port 9001 and upon receiving a request would route the traffic via SSH channel created between ‘work’ and ‘home’. For this it is required to CONFIGURE THE BROWSER to point to the SOCKS proxy at port 9001 at localhost.

        ![](https://chamibuddhika.files.wordpress.com/2012/03/dynamicportforwarding.jpg)

        有機會用在 SSH 嗎??

  - [Secure Shell tunneling - Tunneling protocol \- Wikipedia](https://en.wikipedia.org/wiki/Tunneling_protocol#Secure_Shell_tunneling) #ril

      - A Secure Shell (SSH) tunnel consists of an encrypted tunnel created through an SSH protocol connection. Users may set up SSH tunnels to transfer UNENCRYPTED TRAFFIC over a network through an ENCRYPTED CHANNEL.

        For example, Microsoft Windows machines can share files using the Server Message Block (SMB) protocol, a non-encrypted protocol. If one were to mount a Microsoft Windows file-system remotely through the Internet, someone snooping on the connection could see transferred files. To mount the Windows file-system securely, one can establish a SSH tunnel that routes all SMB traffic to the remote fileserver through an encrypted channel.

        Even though the SMB protocol itself contains no encryption, the encrypted SSH channel through which it travels offers security.

      - Once an SSH connection has been established, the tunnel starts with SSH listening to a port on the remote OR LOCAL HOST. Any connections to it are FORWARDED to the specified address and port originating from the opposing (remote or local, as previously) host.

        ![](https://upload.wikimedia.org/wikipedia/commons/d/dc/Ssh-L-Tunnel.png)

        Local and remote port forwarding with ssh executed on the blue computer. 紫色圓點的移動代表什麼?? 注意 `123:localhost:456` 變成 `123:remoteserver:456`。

## 參考資料 {: #reference }

相關：

  - [OpenSSH](openssh-tunneling.md)
