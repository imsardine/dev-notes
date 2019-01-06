---
title: MicroPython / ESP8266
---
# [MicroPython](micropython.md) / ESP8266

  - [ESP8266 \- Wikipedia](https://en.wikipedia.org/wiki/ESP8266) 提到 MicroPython 被移植到 ESP8266 上。

## 新手上路 ?? {: #getting-started }

  - [1\. Getting started with MicroPython on the ESP8266 — MicroPython 1\.9\.4 documentation](http://docs.micropython.org/en/latest/esp8266/tutorial/intro.html)
      - The MicroPython software supports the ESP8266 chip itself and ANY BOARD SHOULD WORK. The main characteristic of a board is how much flash it has, how the GPIO pins are connected to the outside world, and whether it includes a built-in USB-serial convertor to make the UART available to your PC. 但這些特徵不會影響 MicroPython 的實作嗎??
      - The minimum requirement for flash size is 1Mbyte. There is also a special build for boards with 512KB, but it is highly limited comparing to the normal build: there is no support for filesystem, and thus features which depend on it won’t work (WebREPL, upip, etc.). 例如 ESP-01 就是 512K，但 ESP-01S 已經有 1MB flash。

  - [Basics — Micropython on ESP8266 Workshop 1\.0 documentation](https://micropython-on-esp8266-workshop.readthedocs.io/en/latest/basics.html) #ril
      - The traditional first program for HOBBY ELECTRONICS is a blinking light. We will try to build that. 跟程式語言的 Hello, World! 一樣。
      - There is a LED (light-emitting diode) near the antenna (the golden zig-zag). The plus side of that LED is connected to the `3v3` pins internally, and the minus side is connected to `gpio2`. So we should be able to make that LED shine with our program by making `gpio2` behave like the `gnd` pins. We need to “bring the gpio2 low”, or in other words, make it connected to `gnd`. LED 對於 ESP8266 也是外接的；它的接法是正極在 Vcc (3.3V)，負極接在 GPIO2 (以 NodeMCU 而言，就是 D4 腳位)，也就是所謂潛流 (sink current) 的接法 -- GPIO2 要處於低電位，電流才會從 LED 正極流向負極並將它點亮：

            from machine import Pin

            led = Pin(2, Pin.OUT)
            led.low()

        [v1.9.1+](https://github.com/micropython/micropython/releases/tag/v1.9.1) 後 `Pin.low()/high()` 要改用 `Pin.value(0)/value(1)`。

      - The `machine` module contains most of the hardware-specific functions in Micropython. Once we have the `Pin` function (嚴格來說是 class) imported, we use it to create a pin object, with the first parameter telling it to use `gpio2`, and the second parameter telling it to switch it into OUTPUT MODE. Finally, we bring the pin low, by calling the `low` method on the `led` variable. At this point the LED should start shining. In fact, it may have started shining a line earlier, because once we switched the pin into output mode, its default state is low. 確實是這樣，`Pin(2, Pin.OUT)` 就會點亮 LED，但這跟[官方文件的說法](http://docs.micropython.org/en/latest/library/machine.Pin.html#machine.Pin) `Pin(id, mode=-1, pull=-1, *, value, drive, alt)` 不太一致 -- `value` is valid only for `Pin.OUT` and `Pin.OPEN_DRAIN` modes and specifies initial output pin value if given, otherwise the state of the pin peripheral REMAINS UNCHANGED. 為什麼文件沒提到預設 `value=0` 的事?? 但預設 Pin 2 是高電位也滿奇怪的?
      - Now, how to make the LED stop shining? There are two ways. We could switch it back into “input” mode, where the pin is not connected to anything. Or we could bring it “high”. If we do that, both ends of the LED will be connected to “plus”, and the CURRENT WON’T FLOW. 為此轉回去 input mode 是有點怪，後者提高電位讓電流不會流經 LED 比較合理。
      - What happened? Nothing interesting, the LED just shines like it did. That’s because the program blinked that LED as fast as it could – so fast, that we didn’t even see it. We need to make it wait a little before the blinks, and for that we are going to use the `time` module.

            for i in range(10):
                led.low()
                time.sleep(0.5) # 中間要停頓才看得出效果
                led.high()
                time.sleep(0.5)

      - Let’s connect an external LED and try to use that. ... We are connecting the LED in OPPOSITE way than the internal one is connected – between the pin and `gnd`. That means that it will shine when the pin is high, and be dark when it’s low. Also note how we added a resistor in there. That is necessary to limit the amount of current that is going to flow through the LED, and with it, its brightness. Without the resistor, the LED would shine very bright for a short moment, until either it, or the board, would overheat and break. 回到源流 (source current) 的接法，GPIO pin 處於高電位時才能輸出電流；另外避免 LED 過熱燒毀，pin (這裡用 D5，也就是 GPIO14) 會先接電阻，然後才是 LED，最後接回 GND。

            from machine import Pin
            import time

            led = Pin(14, Pin.OUT)
            for i in range(10):
                led.high()
                time.sleep_ms(500) # sleep_ms() 是 MicroPython 特有的
                led.low()
                time.sleep_ms(500)

## REPL ??

  - [1.5 Serial prompt - 1\. Getting started with MicroPython on the ESP8266 — MicroPython 1\.9\.4 documentation](http://docs.micropython.org/en/latest/esp8266/tutorial/intro.html#serial-prompt)
      - Once you have the firmware on the device you can access the REPL (Python prompt) over UART0 (GPIO1=TX, GPIO3=RX), which might be connected to a USB-serial convertor, depending on your board. The baudrate is 115200. 其中 "GPIO1=TX, GPIO3=RX" 的說法是哪來的?? 通用於所有 ESP8266 的板子? 確實根據 [MicroPython: GPIO Pins · lvidarte/esp8266 Wiki](https://github.com/lvidarte/esp8266/wiki/MicroPython:-GPIO-Pins) 的圖看來 TX 與 RX 分別對應到 GPIO01 跟 GPIO03 沒錯。

## OTA Update ??

  - [Firmware for ESP8266 boards - MicroPython \- Python for microcontrollers](http://micropython.org/download#esp8266) 官方已提供 Over-The-Air (OTA) builds of the ESP8266 firmware #ril
  - [OTA firmware updates with MicroPython/ESP8266 \- Schinckel\.net](https://schinckel.net/2018/05/26/ota-firmware-updates-with-micropython-esp8266/) (2018-05-26) #ril
  - [\[ESP8266\] Firmware OTA update · Issue \#3570 · micropython/micropython](https://github.com/micropython/micropython/issues/3570) #ril

## 安裝設定 {: #installation }

  - [Firmware for ESP8266 boards - MicroPython \- Python for microcontrollers](https://micropython.org/download#esp8266)
      - 主要是 stable firmware for the ESP8266，這正是 Getting started with MicroPython on the ESP8266 所用的版本
      - 另外還有專為 512K flash 型號客製的 daily build，以及 Over-The-Air (OTA) builds of the ESP8266 firmware，看似是 pyboard 外支援最完整的 board。
  - [1.3. Getting the firmware - 1\. Getting started with MicroPython on the ESP8266 — MicroPython 1\.9\.4 documentation](http://docs.micropython.org/en/latest/esp8266/tutorial/intro.html#getting-the-firmware)
      - The first thing you need to do is download the most recent MicroPython firmware `.bin` file to load onto your ESP8266 device. ... From here, you have 3 main choices: 1) Stable firmware builds for 1024kb modules and above. 2) Daily firmware builds for 1024kb modules and above. 3) Daily firmware builds for 512kb modules.
      - If you are just starting with MicroPython, the best bet is to go for the Stable firmware builds. If you are an advanced, experienced MicroPython ESP8266 user who would like to follow development closely and help with testing new features, there are daily builds 雖然目前 stable 最新版 `esp8266-20180511-v1.9.4.bin`，但 daily build 一直有在更新 (revision 有變)
      - Once you have the MicroPython firmware (compiled code), you need to load it onto your ESP8266 device. There are two main steps to do this: first you need to put your device in BOOT-LOADER MODE, and second you need to copy across the firmware. The exact procedure for these steps is highly dependent on the particular board and you will need to refer to its documentation for details. 這就是最難的部份，建議入門還是用下面被點名的 NodeMCU。
      - If you have a board that has a USB connector, a USB-serial convertor, and has the DTR and RTS pins wired in a special way then deploying the firmware should be easy as all steps can be done automatically. Boards that have such features include the Adafruit Feather HUZZAH and NodeMCU boards.
      - For best results it is recommended to first erase the entire flash of your device before putting on new MicroPython firmware. Currently we only support `esptool.py` to copy across the firmware. Using `esptool.py` you can erase the flash with the command: 其中 `--port` 要依實際狀況調整，`--baud` 也可能要降到 115200

            esptool.py --port /dev/ttyUSB0 erase_flash

        And then deploy the new firmware using:

            esptool.py --port /dev/ttyUSB0 --baud 460800 write_flash --flash_size=detect 0 esp8266-20170108-v1.8.7.bin

        For some boards with a particular FlashROM configuration (e.g. some variants of a NodeMCU board) you may need to use the following command to deploy the firmware (note the `-fm dio` option):

            esptool.py --port /dev/ttyUSB0 --baud 460800 write_flash --flash_size=detect -fm dio 0 esp8266-20170108-v1.8.7.bin

        以 NodeMCU V3 為例：(不用加 `-fm dio`)

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

## 參考資料 {: #reference }

  - [Firmware for ESP8266 boards - MicroPython](https://micropython.org/download#esp8266)
  - [micropython/ports/esp8266 - GitHub](https://github.com/micropython/micropython/tree/master/ports/esp8266)

學習資源：

  - [Micropython on ESP8266 Workshop Documentation](https://micropython-on-esp8266-workshop.readthedocs.io/en/latest/)

相關：

  - [ESP8266](esp8266.md)
  - [esptool](esptool.md) - 官方只支援用 esptool 安裝 firmware
