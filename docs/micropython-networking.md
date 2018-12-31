---
title: MicroPython / Networking
---
# [MicroPython](micropython.md) / Networking

## 新手上路 ?? {: #getting-started }

  - [network — network configuration — MicroPython 1\.9\.4 documentation](https://docs.micropython.org/en/latest/library/network.html) #ril
  - [4\. Network basics — MicroPython 1\.9\.4 documentation](https://docs.micropython.org/en/latest/esp8266/tutorial/network_basics.html) #ril
  - [5\. Network \- TCP sockets — MicroPython 1\.9\.4 documentation](https://docs.micropython.org/en/latest/esp8266/tutorial/network_tcp.html) #ril
  - [小狐狸事務所: MicroPython on ESP8266 \(十一\) : urllib\.urequest 模組測試](http://yhhuang1966.blogspot.com/2017/06/micropython-on-esp8266-urlliburequest.html) (2017-06-15) #ril
      - MicroPython 有實作 `urllib.reqeust`，但 module name 是 [`urllib.urequest`](https://github.com/micropython/micropython-lib/tree/master/urllib.urequest)

## Wi-Fi ??

  - [WiFi - 1\. Getting started with MicroPython on the ESP8266 — MicroPython 1\.9\.4 documentation](http://docs.micropython.org/en/latest/esp8266/tutorial/intro.html#wifi)
      - After a fresh install and boot the device configures itself as a WiFi access point (AP) that you can connect to. The ESSID is of the form `MicroPython-xxxxxx` where the x’s are replaced with part of the MAC address of your device (so will be the same everytime, and most likely different for all ESP8266 chips). 剛裝完 firmware 重開，Wi-Fi 會處理 AP (Access Point) 模式，其 ESSID 為 `MicroPython-xxxxxx`；其中 `xxxxxx` 是 MAC address 的一部份，例如 `MAC: 38:2b:78:05:1a:ff`，其 ESSID 固定為 `MicroPython-051aff`。
      - The password for the WiFi is `micropythoN` (note the upper-case N). Its IP address will be 192.168.4.1 once you connect to its network. WiFi configuration will be discussed in more detail later in the tutorial. 預設的密碼為 `micropythoN` (最後一個字母大寫)，連到 AP 後該裝置的 IP 為 192.168.4.1。

