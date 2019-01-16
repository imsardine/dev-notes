---
title: Arduino / Hardware
---
# [Arduino](arduino.md) / Hardware

  - [Hardware - Arduino \- Hacking](https://www.arduino.cc/en/Hacking/HomePage) #ril

## 新手上路 ?? {: #getting-started }

  - [Boards - Arduino \- Environment](https://www.arduino.cc/en/Guide/Environment#boards) #ril
  - [葉難: Arduino與AVR微控制器相關詞彙](http://yehnan.blogspot.com/2013/01/arduinoterms.html) (2013-01-21) #ril

## Core ??

  - [Third-Party Hardware - Arduino \- Environment](https://www.arduino.cc/en/Guide/Environment#thirdpartyhardware) #ril
      - Support for third-party hardware can be added to the `hardware` directory of your sketchbook directory. PLATFORMS installed there may include board definitions (which appear in the board menu), CORE LIBRARIES, bootloaders, and programmer definitions. 把 core 想成是在某個 hardware platform 上增加對 Arduino enviroment 的支援。
      - To install, create the `hardware` directory, then unzip the third-party platform into its own sub-directory. (Don't use `"arduino"` as the sub-directory name or you'll override the built-in Arduino platform.)
      - Boards - Arduino Software (IDE) includes the built in support for the boards in the following list, all based on the AVR CORE. The Boards Manager included in the standard installation allows to add support for the growing number of new boards based on different cores like Arduino Due, Arduino Zero, Edison, Galileo and so on. 不是基於 AVR core 的板子，是不是整個 toolchain 都會不同??
  - [Arduino \- Cores](https://www.arduino.cc/en/Guide/Cores) #ril
  - [Arduino IDE 1\.5 3rd party Hardware specification · arduino/Arduino Wiki](https://github.com/arduino/Arduino/wiki/Arduino-IDE-1.5-3rd-party-Hardware-specification) #ril

## Standalone ??

  - [From Arduino to a Microcontroller on a Breadboard - Arduino \- ArduinoToBreadboard](https://www.arduino.cc/en/Tutorial/ArduinoToBreadboard) #ril
      - This tutorial explains how to MIGRATE from an Arduino board to a STANDALONE microcontroller on a breadboard. 不是把開發板上的 ATmega328 拆下來，而是燒錄至另一個 MCU，因為可能是體積更小的 ATtiny85。
      - Unless you choose to use the minimal configuration described at the end of this tutorial, you'll need four components (besides the Arduino, ATmega328, and breadboard): a 16 MHz crystal, a 10k resistor, and two 18 to 22 picofarad (ceramic) capacitors. 主要的差別在於 clock source 由 ATmega328 內部或外部提供。

    Burning the Bootloader -- If you have a new ATmega328 (or ATmega168), you'll need to burn the BOOTLOADER onto it. You can do this using an Arduino board as an in-system program (ISP). 上傳程式是另一個步驟

     1. Upload the ArduinoISP sketch onto your Arduino board. (You'll need to select the board and serial port from the Tools menu that correspond to your board.) 先把 Arduino 變成燒錄器。

     2. Wire up the Arduino board and microcontroller as shown in the diagram to the right.

        ![](https://www.arduino.cc/en/uploads/Tutorial/BreadboardAVR.png)

     3. Select "Arduino Duemilanove or Nano w/ ATmega328" from the Tools > Board menu. (Or "ATmega328 on a breadboard (8 MHz internal clock)" if using the minimal configuration described below.) 原 Arduino board 變成燒錄器，最終要操作的板子則是 breadboard 上的 MCU。在 Arduino IDE 1.8.8 上選 Tools > Board > Duemilanove or Diecimila，下次打開選單就會多了 Tools > Processor 可選 -- ATmega328P 或 ATmega168，但沒看到 "8 MHz internal clock" 的選項。

     4. Select "Arduino as ISP" from Tools > Programmer 選單裡也有 ArduinoISP，兩者有什麼不同??

     5. Run Tools > Burn Bootloader - You should only need to burn the bootloader ONCE. After you've done so, you can remove the jumper wires connected to pins 10, 11, 12, and 13 of the Arduino board. 要重複拆裝是有點麻煩，可以平常就準備好幾個針對不同 MCU 配置好的麵包板 (洞洞板更好)，直接就可以拿來用。

    Uploading Using an Arduino Board

      - Once your ATmega328p has the Arduino bootloader on it, you can upload programs to it using the USB-to-serial convertor (FTDI chip) on an Arduino board. To do, you remove the microcontroller from the Arduino board so the FTDI chip can talk to the microcontroller on the breadboard instead. 原來的 Arduino board 就只剩 USB-TTL 的功能；若自己提供 USB-TTL，那麼 Arduino IDE 可以直接跟 breadboard 上的 MCU 對話嗎??
      - The diagram at right shows how to connect the RX and TX lines from the Arduino board to the ATmega on the breadboard. To program the microcontroller, select "Arduino Duemilanove or Nano w/ ATmega328" from the the Tools > Board menu (or "ATmega328 on a breadboard (8 MHz internal clock)" if you're using the minimal configuration described below). Then upload as usual.

        ![](https://www.arduino.cc/en/uploads/Tutorial/ArduinoUSBSerial.png)

      - If you don't have the extra 16 MHz crystal and 18-22 picofarad capacitors used in the above examples, you can configure the ATmega328 to use its INTERNAL 8 MHz RC oscillator as a clock source instead. 要有 clock source 才會動。

  - [1\-Day Project: Build Your Own Arduino Uno for $5 \- YouTube](https://www.youtube.com/watch?v=sNIMCdVOHOM) (2014-12-14) #ril
      - 04:10 [Arduino \- PinMapping168](https://www.arduino.cc/en/Hacking/PinMapping168) ping 9, 10 要接 crystal
  - [Eliminating The Arduino Prototyping Board \| ATmega Standalone \- YouTube](https://www.youtube.com/watch?v=N1rLq-AB9yg) #ril
      - 把 ATmega328 從 Arduino UNO 上拔下來裝到 breadboard 上，搭配 16 MHz clock crystal 及兩個 22 pF 的電容
  - [Programming ATtiny85 with Arduino Uno \- Arduino Project Hub](https://create.arduino.cc/projecthub/arjun/programming-attiny85-with-arduino-uno-afb829) #ril
      - Uploading program to ATtiny85 提到 Tools -> Clock -> 8 MHz (internal)，這個動作很關鍵
  - [【Arduino教學】實作15\- arduino最小化\(燒錄至attiny85\) \- YouTube](https://www.youtube.com/watch?v=2nKEA6AUCZM) (2018-07-18) #ril
      - 在開發板上將想法實現後，要縮小有幾種選擇 - Arduino Nano、Arduino Mini (沒有 USB，要接 USB-TTL 才能灌程式)、ATtiny85 (最小)；若程式用到的腳位不多，ATtiny85 會是最好的選擇。
      - 很快地用 Fritzing 及 Arduino IDE 帶過三色蛋的電路配置及程式碼，接著用 Arduino 將程式燒錄到 ATtiny85。
  - [用麵包板組裝Arduino微電腦實驗板 \- 網昱多媒體](https://swf.com.tw/?p=264) (2011-07-19) #ril
  - [Arduino Uno \(ATMEGA328P\) on a breadboard Tutorial DIY project\. Easy guide\. \- YouTube](https://www.youtube.com/watch?v=npc3uzEVvc0) #ril
  - [Arduino \- Setting up an Arduino on a breadboard](https://www.arduino.cc/en/Main/Standalone) #ril
  - [How do I go from arduino breadboard to creating a real device \- Electrical Engineering Stack Exchange](https://electronics.stackexchange.com/questions/14146/) #ril 提到 "without USB"
  - [Arduino \- Setting up an Arduino on a breadboard](https://www.arduino.cc/en/Main/Standalone) 自製 Arduino 開發板 #ril

## Bootloader ??

  - [Arduino \- Environment](https://www.arduino.cc/en/Guide/Environment) #ril
      - Tools > Burn Bootloader - The items in this menu allow you to burn a bootloader onto the microcontroller on an Arduino board. 透過 Arduino 燒錄上面插著的 microcontroller。
      - This is not required for normal use of an Arduino or Genuino board but is useful if you purchase a new ATmega microcontroller (which normally come without a bootloader). 新採購的 ATmega microcontroller 裡沒有 bootloader，要先燒錄 bootloader 才能跟 Arduino Software 溝通。
      - Ensure that you've selected the correct board from the Boards menu before burning the bootloader on the target board. This command also set the right fuses. 不同板子燒錄 bootloader 的方式腳位不同?
      - Uploading - When you upload a sketch, you're using the Arduino bootloader, a small program that has been loaded on to the microcontroller on your board. It allows you to UPLOAD CODE WITHOUT USING ANY ADDITIONAL HARDWARE. The bootloader is active for a few seconds when the board resets; then it starts whichever sketch was most recently uploaded to the microcontroller. The bootloader will blink the on-board (pin 13) LED when it starts (i.e. when the board resets). 所謂 bootloader 是用來載入 uploaded code，否則燒錄 bootware 需要動用到其他硬體；就像 BIOS 的啟動程式一樣，用來載入磁碟上的程式。
  - [Arduino \- Bootloader](https://www.arduino.cc/en/Hacking/Bootloader) #ril
      - Microcontrollers are usually programmed through a programmer unless you have a piece of FIRMWARE in your microcontroller that allows installing NEW FIRMWARE without the need of an external programmer. This is called a bootloader. 有點繞口? 先用 programmer 燒錄 firmware/bootloader，就可以透過它安裝其他 firmware 而不用透過 programmer
      - 燒錄 bootloader 需將 programmer (AVR-ISP 或 USBtinyISP 等) 接到 2 x 3 的 ICSP 腳位；Tool > Burn Bootloader 的過程約 15 秒。

## Hardware Programmer ??

  - [Arduino \- Environment](https://www.arduino.cc/en/Guide/Environment)
      - If you are using an external programmer with your board, you can hold down the "shift" key on your computer when using this icon. The text will change to "Upload using Programmer" 指 toolbar 上的 upload icon，搭配 Shift 會變成 Upload Using Programmer。
      - Sketch > Upload Using Programmer - This will overwrite the BOOTLOADER on the board; you will need to use Tools > Burn Bootloader to restore it and be able to Upload to USB serial port again. However, it allows you to use the FULL CAPACITY OF THE FLASH MEMORY for your sketch. Please note that this command will NOT burn the fuses (保險絲). To do so a Tools -> Burn Bootloader command must be executed. 看似開發板的 bootloader 可以跟 Arduino Software 搭配，一旦被覆寫就只能用 Tools > Burn Bootloader 救回來。
      - Tools > Programmer - For selecting a HARWARE PROGRAMMER when programming a board or CHIP and not using the ONBOARD USB-SERIAL CONNECTION. Normally you won't need this, but if you're burning a bootloader to a new microcontroller, you will use this. 猜想 Tools > Burn Bootloader 背後也是用這裡選定的 programmer。
  - [Arduino \- Programmer](https://www.arduino.cc/en/Hacking/Programmer) #ril
  - [Arduino \- ArduinoISP](https://www.arduino.cc/en/Tutorial/ArduinoISP) 把 Arduino 當做 ISP，搭配另一個 Arduino 做燒錄 #ril

## 參考資料 {: #reference }

相關：

  - [Arduino UNO](arduino-uno.md)
  - [AVR Microcontroller](avr.md) - 多數 Arduino 板子都採用 ATmega 系列 microcontroller
  - [ESP8266 Arduino Core](arduino-esp8266.md)
  - [ESP32 Arduino Core](arduino-esp32.md)
