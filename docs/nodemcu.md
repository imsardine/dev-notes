# NodeMCU

  - [NodeMCU \- Wikipedia](https://en.wikipedia.org/wiki/NodeMCU)
      - NodeMCU is an open source IoT platform. It includes firmware which runs on the ESP8266 Wi-Fi SoC from Espressif Systems, and hardware which is based on the ESP-12 module.
      - The term "NodeMCU" BY DEFAULT refers to the firmware rather than the development kits. The firmware uses the Lua scripting language. It is based on the eLua project, and built on the Espressif Non-OS SDK for ESP8266. 沒有特別講，NodeMCU 指的是 firmware 而非 hardware (development kit)，不過實際上好像 NodeMCU firmware 沒那麼流行，講 NodeMCU 時通常指的是 NodeMCU DEVKIT 硬體本身?
      - NodeMCU was created shortly after the ESP8266 came out. ... NodeMCU started on 13 Oct 2014, when Hong committed the first file of nodemcu-firmware to GitHub. In summer 2015 the creators ABANDONED the firmware project and a group of independent contributors took over. By summer 2016 the NodeMCU included more than 40 different modules. Due to resource constraints users need to select the modules relevant for their project and build a firmware tailored to their needs. => 衍生了 [NodeMCU Custom Builds](https://nodemcu-build.com/) 的服務。

  - [NodeMcu \-\- An open\-source firmware based on ESP8266 wifi\-soc\.](http://www.nodemcu.com/index_en.html)
      - An open-source firmware and development kit that helps you to prototype your IOT product within a few Lua script lines 其中 development kit 指的是硬體板子；搭配 Lua-based firmware 可以直接用 Lua 寫程式；跟 MicroPython 可以用 Python 寫程式的定位很像。
      - The Development Kit based on ESP8266, integates GPIO, PWM, IIC, [1-Wire](https://nodemcu.readthedocs.io/en/master/en/modules/ow/)?? and ADC all in one board.
      - USB-TTL included, plug&play. 10 GPIO, every GPIO can be PWM, I2C, 1-wire. FCC CERTIFIED WI-FI module, PCB antenna 其中 Wi-Fi 跟天線都來自 ESP8266，整合 USB-TTL 才是這板子方便的地方。

  - [nodemcu/nodemcu\-firmware: lua based INTERACTIVE firmware for mcu like esp8266](https://github.com/nodemcu/nodemcu-firmware) #ril
      - NodeMCU is an open source Lua based firmware for the ESP8266 WiFi SOC from Espressif and uses an on-module flash-based [SPIFFS](https://github.com/pellepl/spiffs)?? file system. NodeMCU is implemented in C and is layered on the [Espressif NON-OS SDK](https://github.com/espressif/ESP8266_NONOS_SDK)??.
      - The firmware was initially developed as is a companion project to the popular ESP8266-based NodeMCU development modules, but the project is now community-supported, and the firmware can now be run on any ESP module. 跟 MicroPython 的狀況很像，有自己的板子，但也支援 ESP8266 其他板子...

  - [Getting Started with ESP8266 Development on the Mac \| lost\+found](http://blog.dushin.net/2016/07/getting-started-with-esp8266-development-on-the-mac/) (2016-07) Hardware 提到 There are a lot of development boards out there that intend to be mostly PLUG AND PLAY, and I am interested in playing with some of them. See, for example, the NodeMCU or the WeMOS D1. 內建 USB to UART 比較容易上手

  - [Internet of Home Things » 4 reasons I abandoned NodeMCU/Lua for ESP8266](https://internetofhomethings.com/homethings/?p=424) #ril
      - [小狐狸事務所: 拋棄 NodeMCU 的四個理由](http://yhhuang1966.blogspot.com/2017/06/nodemcu.html) (2017-06-05) 記憶體常不夠用、做為 HTTP 伺服器常無回應、常當機要 restart，但 2017 年的現在應該改進不少?

## 新手上路 ?? {: #getting-started }

  - [第一次購買 NodeMCU 就上手 \- 妖恫程式部落](https://blog.everlearn.tw/nodemcu/%E7%AC%AC%E4%B8%80%E6%AC%A1%E8%B3%BC%E8%B2%B7-nodemcu-%E5%B0%B1%E4%B8%8A%E6%89%8B) (2018-09-05) #ril
  - [Comparison of ESP8266 NodeMCU development boards • my2cents](https://frightanic.com/iot/comparison-of-esp8266-nodemcu-development-boards/) (2015-09-28) #ril
  - [Comparison of tools and IDEs for NodeMCU • my2cents](https://frightanic.com/iot/tools-ides-nodemcu/) (2017-01-16) #ril
  - [Tools and Components : 3 Steps \(with Pictures\)](https://www.instructables.com/id/Getting-Started-With-NodeMCU-All-in-One-Guide/) #ril
  - [Get Started With NodeMCU \(ESP8266\)\.\.\.\.: 3 Steps](https://www.instructables.com/id/Get-Started-With-NodeMCU/) 刷 Arduino Core，把 NodeMCU firmware 蓋掉了；有混淆視聽之嫌 XD #ril

## Lua, Programming ??

  - [nodemcu/nodemcu\-firmware: lua based interactive firmware for mcu like esp8266](https://github.com/nodemcu/nodemcu-firmware) #ril
      - Based on Lua 5.1.4 (without `debug` & `os` modules), Asynchronous event-driven programming model, more than 65 built-in modules
      - The NodeMCU programming model is similar to that of Node.js, only in Lua. It is asynchronous and event-driven. Many functions, therefore, have parameters for CALLBACK functions. 只是跟 Node.js 很像，但 NodeMCU 跟 Node.js 完全沒關係；看到 callback 有點讓人卻步?
  - [nodemcu\-firmware/lua\_examples at master · nodemcu/nodemcu\-firmware](https://github.com/nodemcu/nodemcu-firmware/tree/master/lua_examples) 官方提供不少 Lua 範例 #ril

## V3 ??

  - [NodeMCU v3 — Zerynth Docs documentation](https://docs.zerynth.com/latest/official/board.zerynth.nodemcu3/docs/index.html) #ril
  - [ESP8266 NodeMCU WiFi Devkit - User Manual V1.2](http://www.handsontec.com/pdf_learn/esp8266-V10.pdf) (PDF) 有 pin 與 GPIO 的對照圖 #ril
  - [NodeMCU ESP8266: Details and Pinout: 11 Steps](https://www.instructables.com/id/NodeMCU-ESP8266-Details-and-Pinout/) #ril
  - [Getting Started With ESP\-12E NodeMcu V3 Module Using ArduinoIDE](https://www.c-sharpcorner.com/article/blinking-led-by-esp-12e-nodemcu-v3-module-using-arduinoide/) (2017-06-07) #ril
  - [nodemcu/nodemcu\-devkit\-v1\.0](https://github.com/nodemcu/nodemcu-devkit-v1.0) 內有 `NODEMCU_DEVKIT_V1.0.PDF` #ril

## GPIO ??

  - [gpio \- NodeMCU Documentation](https://nodemcu.readthedocs.io/en/master/en/modules/gpio/) #ril
      - All access is based on the I/O index number on the NodeMCU dev kits, not the internal GPIO pin. For example, the D0 pin on the dev kit is mapped to the internal GPIO pin 16. If not using a NodeMCU dev kit, please refer to the below GPIO pin maps for the index↔gpio mapping. 問題是 I/O index 跟 NodeMCU 外觀上沒有 D9 ~ D12??

            IO Index | ESP8266 Pin
            00         GPIO16
            01         GPIO05
            02         GPIO04
            03         GPIO00
            04         GPIO02
            05         GPIO14
            06         GPIO12
            07         GPIO13
            08         GPIO15
            09         GPIO03
            10         GPIO01
            11         GPIO09
            12         GPIO10

  - [MicroPython: GPIO Pins · lvidarte/esp8266 Wiki - ESP8266 NodeMCU Workshop](https://github.com/lvidarte/esp8266/wiki/MicroPython:-GPIO-Pins) 這張圖清楚很多!!

      ![](https://raw.githubusercontent.com/lvidarte/esp8266/master/nodemcu_pins.png)

      - Not all pins are available to use, in most cases only pins 0, 2, 4, 5, 12, 13, 14, 15, and 16 can be used. 不能用的 1, 3 分別對應 TX 與 DX，而 6 ~ 11 確實圖上面找不到 GPIO 6 ~ 11，為什麼會跳號??

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

## V3 與麵包板 {: #v3-breadboard }

  - [第一次購買 NodeMCU 就上手 \- 妖恫程式部落](https://blog.everlearn.tw/nodemcu/第一次購買-nodemcu-就上手) (2018-09-05) V3 板子有尺寸過大的問題，剛好插進最邊邊的插孔，無法連接其他元件，而 V2 則沒有這個問題；作者推薦 V2，因為 V3 改良的地方不明確，又有尺寸過大的問題。
  - [NodeMCU Breadboard Tweak: 7 Steps \(with Pictures\)](https://www.instructables.com/id/NodeMCU-Breadboard-Tweak/) 把麵包板鋸開，量好距離再重組起來。
  - [lucstechblog: NodeMCU breadboard aid](https://lucstechblog.blogspot.com/2015/09/nodemcu-breadboard-aid.html) (2015-09-18) 用洞洞板 + 平面母座 x 4 排，將 NodeMCU 的接腳引出來，這方法比鋸開麵包板好一點。
  - [Comparison of ESP8266 NodeMCU development boards • my2cents](https://frightanic.com/iot/comparison-of-esp8266-nodemcu-development-boards/) (2015-09-28)
      - William Moore: which is just as wide as the LoLin board and is considered by most people as “breadboard unfriendly” because there is no free (available) pin hole in a MB-102 solderless breadboard when you mount these boards
      - Lotus49: The NodeMCU V2 seems to be the best value (I paid less than £3 including P&P) and has all the features I want. The only drawback is that it’s pretty wide so it spans the breadboard completely. That’s not a disaster but it’s a bit annoying having to RUN JUMPERS UNDERNEATH THE BOARD to connect it to anything. 在板子下面走跳線出來好像也是一招。

## 參考資料 {: #reference }

  - [NodeMCU](http://www.nodemcu.com/index_en.html)
  - [NodeMCU Custom Builds](https://nodemcu-build.com/)
  - [nodemcu/nodemcu-firmware - GitHub](https://github.com/nodemcu/nodemcu-firmware)

文件：

  - [NodeMCU Documentation](https://nodemcu.readthedocs.io/)

相關：

  - [ESP8266](esp8266.md) - NodeMCU 基於 ESP-12
  - [Lua](lua.md) - 官方 firmware 提供 Lua 執行環境及不少 module
