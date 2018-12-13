# NodeMCU

  - [NodeMcu \-\- An open\-source firmware based on ESP8266 wifi\-soc\.](http://www.nodemcu.com/index_en.html)
      - An open-source firmware and development kit that helps you to prototype your IOT product within a few Lua script lines 其中 development kit 指的是硬體板子；搭配 Lua-based firmware 可以直接用 Lua 寫程式；跟 MicroPython 可以用 Python 寫程式的定位很像。
      - The Development Kit based on ESP8266, integates GPIO, PWM, IIC, 1-Wire and ADC all in one board.
      - USB-TTL included, plug&play. 10 GPIO, every GPIO can be PWM, I2C, 1-wire. FCC CERTIFIED WI-FI module, PCB antenna
  - [nodemcu/nodemcu\-firmware: lua based INTERACTIVE firmware for mcu like esp8266](https://github.com/nodemcu/nodemcu-firmware) #ril
      - NodeMCU is an open source Lua based firmware for the ESP8266 WiFi SOC from Espressif and uses an on-module flash-based [SPIFFS](https://github.com/pellepl/spiffs)?? file system. NodeMCU is implemented in C and is layered on the [Espressif NON-OS SDK](https://github.com/espressif/ESP8266_NONOS_SDK)??.
      - The firmware was initially developed as is a companion project to the popular ESP8266-based NodeMCU development modules, but the project is now community-supported, and the firmware can now be run on any ESP module.
  - [Getting Started with ESP8266 Development on the Mac \| lost\+found](http://blog.dushin.net/2016/07/getting-started-with-esp8266-development-on-the-mac/) (2016-07) Hardware 提到 There are a lot of development boards out there that intend to be mostly PLUG AND PLAY, and I am interested in playing with some of them. See, for example, the NodeMCU or the WeMOS D1. 內建 USB to UART 比較容易上手
  - [NodeMCU \- Wikipedia](https://en.wikipedia.org/wiki/NodeMCU) It is based on the [eLua](http://www.eluaproject.net/) project #ril

## 新手上路 ?? {: #getting-started }

  - [Comparison of ESP8266 NodeMCU development boards • my2cents](https://frightanic.com/iot/comparison-of-esp8266-nodemcu-development-boards/) (2015-09-28) #ril
  - [Comparison of tools and IDEs for NodeMCU • my2cents](https://frightanic.com/iot/tools-ides-nodemcu/) (2017-01-16) #ril
  - 用 terminal 接上，按下 RST 鈕會看到 `ready`，然後呢 ??
  - [Tools and Components : 3 Steps \(with Pictures\)](https://www.instructables.com/id/Getting-Started-With-NodeMCU-All-in-One-Guide/) #ril
  - [Get Started With NodeMCU \(ESP8266\)\.\.\.\.: 3 Steps](https://www.instructables.com/id/Get-Started-With-NodeMCU/) 刷 Arduino Core，把 NodeMCU firmware 蓋掉了；有混淆視聽之嫌 XD #ril

## Lua, Programming ??

  - [nodemcu/nodemcu\-firmware: lua based interactive firmware for mcu like esp8266](https://github.com/nodemcu/nodemcu-firmware) #ril
      - Based on Lua 5.1.4 (without `debug` & `os` modules), Asynchronous event-driven programming model, more than 65 built-in modules
      - The NodeMCU programming model is similar to that of Node.js, only in Lua. It is asynchronous and event-driven. Many functions, therefore, have parameters for CALLBACK functions. 只是跟 Node.js 很像，但 NodeMCU 跟 Node.js 完全沒關係；看到 callback 有點讓人卻步?
  - [nodemcu\-firmware/lua\_examples at master · nodemcu/nodemcu\-firmware](https://github.com/nodemcu/nodemcu-firmware/tree/master/lua_examples) 官方提供不少 Lua 範例 #ril

## Flashing, Firmware ??

  - [Firmware - nodemcu/nodemcu\-firmware: lua based interactive firmware for mcu like esp8266](https://github.com/nodemcu/nodemcu-firmware#releases) Due to the ever-growing number of modules available within NodeMCU, pre-built binaries are no longer made available. Use the automated [custom firmware build service](http://nodemcu-build.com/) to get the specific firmware configuration you need, or consult the documentation for other options to build your own firmware.
  - [Building the firmware \- NodeMCU Documentation](https://nodemcu.readthedocs.io/en/master/en/build/) #ril
      - 選擇 NodeMCU source branch、module 及其他 options，按 Start your build 就會線上幫產生 firmware!! 收到的 email 像：

            Your NodeMCU custom build finished successfully. You may now download the firmware:
            - float: https://transfer.sh/CGnPe/nodemcu-master-7-modules-2018-12-13-01-06-39-float.bin
            - integer: https://transfer.sh/pj3Jh/nodemcu-master-7-modules-2018-12-13-01-06-39-integer.bin

            ...
            *** NEW FLASHING TOOL *** NEW FLASHING TOOL *** NEW FLASHING TOOL ***
            I invite you to try the new GUI tool https://github.com/marcelstoer/nodemcu-pyflasher

  - [marcelstoer/nodemcu\-pyflasher: Self\-contained NodeMCU flasher with GUI based on esptool\.py and wxPython\.](https://github.com/marcelstoer/nodemcu-pyflasher) #ril
  - [Flashing the firmware \- NodeMCU Documentation](https://nodemcu.readthedocs.io/en/master/en/flash/) #ril

## 參考資料 {: #reference }

  - [NodeMCU](http://www.nodemcu.com/index_en.html)
  - [NodeMCU Custom Builds](https://nodemcu-build.com/)
  - [nodemcu/nodemcu-firmware - GitHub](https://github.com/nodemcu/nodemcu-firmware)

文件：

  - [NodeMCU Documentation](https://nodemcu.readthedocs.io/)

相關：

  - [ESP8266](esp8266.md) - NodeMCU 採用的微處理器
  - [Lua](lua.md) - 官方 firmware 提供 Lua 執行環境及不少 module
