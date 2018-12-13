# esptool

  - [espressif/esptool: ESP8266 and ESP32 serial bootloader utility](https://github.com/espressif/esptool) #ril
      - A Python-based, open source, platform independent, utility to communicate with the ROM bootloader in Espressif ESP8266 & ESP32 chips.

## Bootloader Mode ??

  - [ESP8266 Boot Mode Selection · espressif/esptool Wiki](https://github.com/espressif/esptool/wiki/ESP8266-Boot-Mode-Selection) 什麼是 pull high/low?? #ril

## 疑難排解 {: #troubleshooting }

### Failed to connect to Espressif device: Timed out waiting for packet header ??

  - [A fatal error occurred: Failed to connect to Espressif device: Timed out waiting for packet header · Issue \#293 · espressif/esptool](https://github.com/espressif/esptool/issues/293) #ril
      - projectgus: Correct boot mode selection (see https://github.com/espressif/esptool/wiki/ESP8266-Boot-Mode-Selection) - you'll need to hold GPIO0 while pressing and releasing Reset, and then run `esptool.py`. 什麼是 "hold GPIO0" 與 "releasing Reset"??
      - theproxy 也貼了錯誤 (會看到 `0707122055555555 5555555555555555 | ... UUUUUUUUUUUU`)，projectgus 說這跟 JKThrowling 的狀況不同，通常是因為 not resetting into bootloader mode correctly

## 安裝設定 {: #installation }

  - [Installation / dependencies - espressif/esptool: ESP8266 and ESP32 serial bootloader utility](https://github.com/espressif/esptool#user-content-installation--dependencies) `pip install esptool` (支援 Python 2.7 或 3.4+)，安裝完成就有 `esptool.py` 可以用。

## 參考資料 {: #reference }

  - [espressif/esptool - GitHub](https://github.com/espressif/esptool) #ril

相關：

  - [ESP8266](esp8266.md)
