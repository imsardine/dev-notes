---
title: Arduino / ESP8266 Arduino Core
---
# [Ardunio](arduino.md) / ESP8266 Arduino Core

  - [Arduino on ESP8266 - esp8266/Arduino: ESP8266 core for Arduino](https://github.com/esp8266/Arduino#arduino-on-esp8266) 這專案相當活躍，有 303 個 contributor、5824 個 fork，星星數也高達 8404!! #ril
      - This project brings support for ESP8266 chip to the Arduino environment. It lets you write SKETCHES using familiar Arduino functions and libraries, and run them directly on ESP8266, no external microcontroller required. 在 ESP8266 上執行 Arduino 的程式。
      - ESP8266 Arduino core comes with libraries to communicate over WiFi using TCP and UDP, set up HTTP, mDNS, SSDP, and DNS servers, do OTA updates, use a file system in flash memory, work with SD cards, servos, SPI and I2C peripherals. 支援程度還滿高的!!
  - [Arduino/core\_esp8266\_main\.cpp at 2\.4\.2 · esp8266/Arduino](https://github.com/esp8266/Arduino/blob/2.4.2/cores/esp8266/core_esp8266_main.cpp#L117) 看起來跟 AVR Core 一樣有 `setup()` 與 `loop()`。
  - [ESP8266 Arduino Core - NodeMCU \- Wikipedia](https://en.wikipedia.org/wiki/NodeMCU#ESP8266_Arduino_Core) #ril

## 疑難排解 {: #troubleshooting }

### espcomm_sync failed ??

```
...
warning: espcomm_sync failed
error: espcomm_open failed
error: espcomm_upload_mem failed
error: espcomm_upload_mem failed
```

  - [I am getting “espcomm\_sync failed” error when trying to upload my ESP\. How to resolve this issue? — ESP8266 Arduino Core 2\.4\.0 documentation](https://arduino-esp8266.readthedocs.io/en/latest/faq/a01-espcomm_sync-failed.html) #ril
      - This message indicates issue with uploading ESP module over a serial connection. If you are just starting with ESP, to reduce potential issues with uploading, select ESP board with INTEGRATED USB to serial converter. 內建 USB to UART 晶片的板子比較容易上手；ESP-01 就沒有內建。
      - Example boards with USB to serial converter build in, that will make your initial project development easier. 圖片沒有標示型號，看起來像是 NodeMCU 與 WeMOS D1
      - If you are using a Generic ESP8266 module, separate USB to serial converter and connect them by yourself, please make sure you have the following three things right: 1. Module is provided with enough power, 2. GPIO0, GPIO15 and CH_PD are connected using pull up / pull down resistors, 3. Module is put into boot loader mode. 重點還是要進 boot loader mode!!

## 安裝設定 {: #installation }

  - [esp8266/Arduino: ESP8266 core for Arduino](https://github.com/esp8266/Arduino#installing-with-boards-manager) #ril
      - Starting with 1.6.4, Arduino allows installation of third-party platform packages using Boards Manager.
      - 使用 Arduino IDE 1.8+，在 Preferneces > Additional Board Manager URLs 輪入 `http://arduino.esp8266.com/stable/package_esp8266com_index.json` (多個 URL 用逗號隔開)，然後用 Tools > Board > Boards Manager... 安裝 `esp8266` platform 即可；Boards included in this package 板子的數量真是驚人!!
      - 安裝完後 Tools > Board 選 Generic ESP8266 Module，會發現 Tools 選單多了很多東西，File > Examples 也多了 ESP8266 專有的範例!! 一樣有 ESP8266 > Blink 可以測試。
  - [Why esptool is not listed in “Programmer” menu? How do I upload ESP without it? - FAQ — ESP8266 Arduino Core 2\.4\.0 documentation](https://arduino-esp8266.readthedocs.io/en/latest/faq/readme.html#why-esptool-is-not-listed-in-programmer-menu-how-do-i-upload-esp-without-it) Do not worry about “Programmer” menu of Arduino IDE. It doesn’t matter what is selected in it — upload now always defaults to using `esptool`. 總是透過 programmer?
  - [Burning the bootloader · Issue \#24 · esp8266/Arduino](https://github.com/esp8266/Arduino/issues/24) #ril
      - rogerclarkmelb: Programmer 要選 esptool => 但實際上沒這個選項? 可以打開 Preferences > Show verbose output during: compilation 及 upload 的選項；確實可以看到對 esptool 的調用。
      - nerdralph: There really isn't any point to the burn bootloader function. When you hold GPIO0 low during reset, it enters the ROM bootloader which can't be replaced. The upload button uses esptool to upload the sketch code to 0x0001000 and the espressif sdk lib to 0x0004000. It would be nice if the burn bootloader function was used to flash the sdk libs, and then the upload would only have to flash the sketch, saving ~145KB on each upload. ??
  - [arduino ide \- Wiring when burning the bootloader of esp8266 \- Arduino Stack Exchange](https://arduino.stackexchange.com/questions/45717/) 不用刷 bootloader? #ril

## 參考資料 {: #reference }

  - [esp8266/Arduino - GitHub](https://github.com/esp8266/Arduino)

文件：

  - [ESP8266 Arduino Core - Read the Docs](https://arduino-esp8266.readthedocs.io/en/latest/)

相關：

  - [Arduino Hardware](arduino-hardware.md)
  - [esptool](esptool.md)
