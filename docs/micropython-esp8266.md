# [MicroPython](micropython.md) / ESP8266

  - [ESP8266 \- Wikipedia](https://en.wikipedia.org/wiki/ESP8266) 提到 MicroPython 被移植到 ESP8266 上。
  - [Firmware for ESP8266 boards - MicroPython \- Python for microcontrollers](https://micropython.org/download#esp8266) #ril

## 新手上路 ?? {: #getting-started }

  - [1\. Getting started with MicroPython on the ESP8266 — MicroPython 1\.9\.4 documentation](http://docs.micropython.org/en/latest/esp8266/tutorial/intro.html) #ril

    以 NodeMCU V3 為例：

        $ esptool.py --port /dev/tty.wchusbserial1420 --baud 460800 write_flash --flash_size=detect 0 ~/Downloads/esp8266-20180511-v1.9.4.bin
        esptool.py v2.5.1
        Serial port /dev/tty.wchusbserial1420
        Connecting....
        Detecting chip type... ESP8266
        Chip is ESP8266EX
        Features: WiFi
        MAC: 38:2b:78:05:1a:ff
        Uploading stub...
        Running stub...
        Stub running...
        Changing baud rate to 460800
        Changed.
        Configuring flash size...
        Auto-detected Flash size: 4MB
        Flash params set to 0x0040
        Compressed 604872 bytes to 394893...
        Wrote 604872 bytes (394893 compressed) at 0x00000000 in 9.5 seconds (effective 509.6 kbit/s)...
        Hash of data verified.

        Leaving...
        Hard resetting via RTS pin...

  - [\[錦囊一\] 從選料開始該注意啥 \(以ESP\-01S為例\) \- iT 邦幫忙::一起幫忙解決難題，拯救 IT 人的一天](https://ithelp.ithome.com.tw/articles/10201776) #ril
  - [\[錦囊二\] 燒錄的時候會遇到大魔王嗎? \[硬體篇\] \- iT 邦幫忙::一起幫忙解決難題，拯救 IT 人的一天](https://ithelp.ithome.com.tw/articles/10202399) #ril

## GPIO ??

  - [MicroPython: GPIO Pins · lvidarte/esp8266 Wiki](https://github.com/lvidarte/esp8266/wiki/MicroPython:-GPIO-Pins) #ril

## Wi-Fi ??

  - [WiFi - 1\. Getting started with MicroPython on the ESP8266 — MicroPython 1\.9\.4 documentation](http://docs.micropython.org/en/latest/esp8266/tutorial/intro.html#wifi)
      - 剛裝完 firmware 重開，Wi-Fi 會處理 AP (Access Point) 模式，其 ESSID 為 `MicroPython-xxxxxx`；其中 `xxxxxx` 是 MAC address 的一部份，例如 `MAC: 38:2b:78:05:1a:ff`，其 ESSID 固定為 `MicroPython-051aff`。
      - 預設的密碼為 `micropythoN` (最後一個字母大寫)，連到 AP 後該裝置的 IP 為 192.168.4.1。

## OTA Update ??

  - [Firmware for ESP8266 boards - MicroPython \- Python for microcontrollers](http://micropython.org/download#esp8266) 官方已提供 Over-The-Air (OTA) builds of the ESP8266 firmware #ril
  - [OTA firmware updates with MicroPython/ESP8266 \- Schinckel\.net](https://schinckel.net/2018/05/26/ota-firmware-updates-with-micropython-esp8266/) (2018-05-26) #ril
  - [\[ESP8266\] Firmware OTA update · Issue \#3570 · micropython/micropython](https://github.com/micropython/micropython/issues/3570) #ril

## 參考資料 {: #reference }

  - [Firmware for ESP8266 boards - MicroPython](https://micropython.org/download#esp8266)

相關：

  - [ESP8266](esp8266.md)
