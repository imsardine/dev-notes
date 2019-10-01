---
title: macOS / Networking
---
# [macOS](macos.md) / Networking

## 如何在 command line 查詢 IP?

  - `ifconfig | grep netmask` 可以查詢到 loopback 及其他 network interface。
  - `ipconfig getifaddr <INTERFACE>` 可以直接查詢某個 interface 的 IP，例如 `ipconfig getifaddr en0`。

參考資料：

  - Find your IP Address on a Mac http://osxdaily.com/2010/11/21/find-ip-address-mac/ 用 `ifconfig | grep inet`，通常 IP 在最後一個 `inet` 後面，格式是 n.n.n.n。另外 `ipconfig getifaddr <NIC>` 則可以直接取得 IP。
  - How to find your IP address in Mac OS X - howchoo https://howchoo.com/g/yzrjmjyymjq/how-to-find-your-ip-address-in-mac-os-x 也是教人用 `grep inet`。
  - Terminal 101: Find your IP Address | TechRadar http://www.techradar.com/how-to/computing/apple/terminal-101-find-your-ip-address-1305629 教人用 `ipconfig getifaddr`，不過 `ipconfig` 可以列出所有 interface 的說法似乎有誤? 應該是用 `ifconfig`?
  - terminal - How do I find my IP Address from the command line? - Ask Different https://apple.stackexchange.com/questions/20547/ 最多人同意 `ipconfig getifaddr`。
  - 後來發現 `grep netmask` 會更為精確。

## DNS

  - System Preferences > Network -> Advanced... > DNS 可以看到目前套用的 DNS 設定

    實驗發現，剛接上 Wi-Fi 時，由 DHCP 配置的 DNS 會呈現灰色，用 Tunnelblick 建立 VPN 連線後就會整個被換掉 (呈現黑色)，結束 VPN 連線後又會回復原來 DHCP 的設定；不過這現象在使用 Pulse Secure 時並沒有，建立 VPN 連線後 DNS 設定並不會被修改。

  - 也可以從 command line 查詢 DNS 設定：

        $ networksetup -listallnetworkservices # 先找出 network service
        $ networksetup -getdnsservers <NETWORK_SERVICE> # 再查看特定 network service 的 DNS servers

    例如：

        $ networksetup -getdnsservers Wi-Fi

---

參考資料

  - [Get DNS Server IP Addresses from the Command Line in Mac OS X](http://osxdaily.com/2011/06/03/get-dns-server-ip-command-line-mac-os-x/) (2011-06-03) #ril

      - 用 `networksetup -getdnsservers NETWORK_SERVICE`；其中 `NETWORK_SERVICE` 可以用 `networksetup -listallnetworkservices` 查詢，例如 `networksetup -getdnsservers 'Ethernet 1'`

  - [How to Use OpenDNS or Google DNS on Your Mac](https://www.howtogeek.com/howto/38793/how-to-switch-mac-os-x-to-use-opendns-or-google-dns/) (2017-09-11)

      - Are you still using your internet provider’s DNS servers? You probably shouldn’t be. In most cases, ISP-provided DNS is slow, and occasionally goes down completely. Some even redirect unresolved URLs to a branded search page. Gross!

      - For these reasons, it’s better to instead use OpenDNS or Google’s DNS service instead of what your ISP offers. They’re more reliable, and in the case of OpenDNS, even offer extra features like content filtering, typo correction, anti-phishing, and child protection controls.

      - First, head into the System Preferences, then click on the Network icon.

        Once you’re there, switch over to the DNS tab, and you can start adding in DNS entries into the list. If you see entries that are GRAYED OUT, just ignore them, and click the + symbol at the bottom to add new ones.

      - If you want to use Google’s DNS servers, you can add the following two items to the list:

            8.8.8.8
            8.8.4.4

        If you’d rather use OpenDNS instead, which has lots of extra features, you can use the following two entries:

            208.67.222.222
            208.67.220.220

