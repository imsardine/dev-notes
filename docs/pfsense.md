# pfSense

  - [pfSense \- Wikipedia](https://en.wikipedia.org/wiki/PfSense)

      - pfSense is a firewall/router computer SOFTWARE DISTRIBUTION based on FreeBSD. The open source pfSense Community Edition (CE) and pfSense Plus is installed on a physical computer or a virtual machine to make a dedicated firewall/router for a network.
      - It can be configured and upgraded through a web-based interface, and requires no knowledge of the underlying FreeBSD system to manage.

    Overview

      - The pfSense project started in 2004 as a fork of the m0n0wall project by Chris Buechler and Scott Ullrich and the first release was in 2006. The name was derived from the fact that the software uses the PACKET-FILTERING tool, PF.

      - In February 2021, feature updates of pfSense CE 2.5.0 and pfSense Plus 21.02 included a kernel WireGuard implementation, however, following the reporting of issues in the code by WireGuard founder Jason Donenfeld, it was discontinued in March 2021. The July 2021 release of pfSense CE 2.5.2 version includes the WireGuard.

        > WireGuard has been removed from the base system in releases after pfSense Plus 21.02-p1 and pfSense CE 2.5.0, when it was removed from FreeBSD.
        >
        > -- [Virtual Private Networks — WireGuard \| pfSense Documentation](https://docs.netgate.com/pfsense/en/latest/vpn/wireguard/index.html)

      - Notable functions of pfSense include traffic shaping, VPNs using IPsec or PPTP, captive portal, stateful firewall, network address translation, 802.1q support for VLANs, and dynamic DNS. pfSense is installed on hardware with x86 and x86-64 architecture. It is also installed on embedded hardware using Compact Flash or SD cards, as well as supports virtualized installation.

## L2TP

  - [L2TP VPN — L2TP Server Configuration \| pfSense Documentation](https://docs.netgate.com/pfsense/en/latest/vpn/l2tp/configuration.html)

      - To use L2TP, first browse to VPN > L2TP. Select Enable L2TP server.

      - Warning: L2TP is not a secure protocol by itself; it only provides tunneling, it does not perform encryption.

        相較於其他 VPN 較不安全??

        L2TP/IPsec is a way to secure L2TP traffic by sending it through an encrypted IPsec tunnel. This may be used in combination with a mobile IPsec setup to configure L2TP+IPsec; see L2TP/IPsec Remote Access VPN Configuration Example for details.

    Interface

      - The Interface setting controls where the L2TP daemon will bind and listen for connections. This is typically the WAN interface accepting INBOUND connections.

        有 WAN 跟 LAN 兩個選項。

    IP Addressing

      - Before starting, determine which IP addresses to use for the L2TP server and clients and now many concurrent clients to support.

          - Server Address: An unused IP address outside of the Remote Address Range, such as 10.3.177.1 as shown in Figure L2TP IP Addressing.

            畫面上的說明：

            > Enter the IP address the L2TP server should give to clients for use as their "gateway". Typically this is set to an unused IP just outside of the client range.

            又不同於 WAN/LAN interface 的 IP。

          - Remote Address Range: Usually a new and unused subnet, such as 10.3.177.128/25 (.128 through .255). These are the addresses to be ASSIGNED TO CLIENTS when they connect.

            畫面上的說明：

            > Specify the starting address for the client IP address subnet.

          - Number of L2TP users: Controls how many L2TP users will be allowed to connect at the same time, in this example 13 has been selected.

## 參考資料 {: #reference }

文件：

  - [pfSense Documentation](https://docs.netgate.com/pfsense/en/latest/)
  - [L2TP VPN | pfSense Documentation](https://docs.netgate.com/pfsense/en/latest/vpn/l2tp/index.html)

書籍：

  - [Search results for: 'pfsense' | Packt](https://www.packtpub.com/catalogsearch/result?q=pfsense)
