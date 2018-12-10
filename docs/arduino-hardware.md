# Arduino Hardware

  - [Hardware - Arduino \- Hacking](https://www.arduino.cc/en/Hacking/HomePage) #ril

## 基礎

### 新手上路 ??

  - [Boards - Arduino \- Environment](https://www.arduino.cc/en/Guide/Environment#boards) #ril
  - [葉難: Arduino與AVR微控制器相關詞彙](http://yehnan.blogspot.com/2013/01/arduinoterms.html) (2013-01-21) #ril

### Core ??

  - [Third-Party Hardware - Arduino \- Environment](https://www.arduino.cc/en/Guide/Environment#thirdpartyhardware) #ril
      - Support for third-party hardware can be added to the `hardware` directory of your sketchbook directory. PLATFORMS installed there may include board definitions (which appear in the board menu), CORE LIBRARIES, bootloaders, and programmer definitions. 把 core 想成是在某個 hardware platform 上增加對 Arduino enviroment 的支援。
      - To install, create the `hardware` directory, then unzip the third-party platform into its own sub-directory. (Don't use `"arduino"` as the sub-directory name or you'll override the built-in Arduino platform.)
      - Boards - Arduino Software (IDE) includes the built in support for the boards in the following list, all based on the AVR CORE. The Boards Manager included in the standard installation allows to add support for the growing number of new boards based on different cores like Arduino Due, Arduino Zero, Edison, Galileo and so on. 不是基於 AVR core 的板子，是不是整個 toolchain 都會不同??
  - [Arduino \- Cores](https://www.arduino.cc/en/Guide/Cores) #ril
  - [Arduino IDE 1\.5 3rd party Hardware specification · arduino/Arduino Wiki](https://github.com/arduino/Arduino/wiki/Arduino-IDE-1.5-3rd-party-Hardware-specification) #ril

### Bootloader ??

  - [Arduino \- Environment](https://www.arduino.cc/en/Guide/Environment) #ril
      - Tools > Burn Bootloader - The items in this menu allow you to burn a bootloader onto the microcontroller on an Arduino board. 透過 Arduino 燒錄上面插著的 microcontroller。
      - This is not required for normal use of an Arduino or Genuino board but is useful if you purchase a new ATmega microcontroller (which normally come without a bootloader). 新採購的 ATmega microcontroller 裡沒有 bootloader，要先燒錄 bootloader 才能跟 Arduino Software 溝通。
      - Ensure that you've selected the correct board from the Boards menu before burning the bootloader on the target board. This command also set the right fuses. 不同板子燒錄 bootloader 的方式腳位不同?
      - Uploading - When you upload a sketch, you're using the Arduino bootloader, a small program that has been loaded on to the microcontroller on your board. It allows you to UPLOAD CODE WITHOUT USING ANY ADDITIONAL HARDWARE. The bootloader is active for a few seconds when the board resets; then it starts whichever sketch was most recently uploaded to the microcontroller. The bootloader will blink the on-board (pin 13) LED when it starts (i.e. when the board resets). 所謂 bootloader 是用來載入 uploaded code，否則燒錄 bootware 需要動用到其他硬體；就像 BIOS 的啟動程式一樣，用來載入磁碟上的程式。
  - [Arduino \- Bootloader](https://www.arduino.cc/en/Hacking/Bootloader) #ril
      - Microcontrollers are usually programmed through a programmer unless you have a piece of FIRMWARE in your microcontroller that allows installing NEW FIRMWARE without the need of an external programmer. This is called a bootloader. 有點繞口? 先用 programmer 燒錄 firmware/bootloader，就可以透過它安裝其他 firmware 而不用透過 programmer
      - 燒錄 bootloader 需將 programmer (AVR-ISP 或 USBtinyISP 等) 接到 2 x 3 的 ICSP 腳位；Tool > Burn Bootloader 的過程約 15 秒。

### Hardware Programmer ??

  - [Arduino \- Environment](https://www.arduino.cc/en/Guide/Environment)
      - If you are using an external programmer with your board, you can hold down the "shift" key on your computer when using this icon. The text will change to "Upload using Programmer" 指 toolbar 上的 upload icon，搭配 Shift 會變成 Upload Using Programmer。
      - Sketch > Upload Using Programmer - This will overwrite the BOOTLOADER on the board; you will need to use Tools > Burn Bootloader to restore it and be able to Upload to USB serial port again. However, it allows you to use the FULL CAPACITY OF THE FLASH MEMORY for your sketch. Please note that this command will NOT burn the fuses (保險絲). To do so a Tools -> Burn Bootloader command must be executed. 看似開發板的 bootloader 可以跟 Arduino Software 搭配，一旦被覆寫就只能用 Tools > Burn Bootloader 救回來。
      - Tools > Programmer - For selecting a HARWARE PROGRAMMER when programming a board or CHIP and not using the ONBOARD USB-SERIAL CONNECTION. Normally you won't need this, but if you're burning a bootloader to a new microcontroller, you will use this. 猜想 Tools > Burn Bootloader 背後也是用這裡選定的 programmer。
  - [Arduino \- Programmer](https://www.arduino.cc/en/Hacking/Programmer) #ril
  - [Arduino \- ArduinoISP](https://www.arduino.cc/en/Tutorial/ArduinoISP) 把 Arduino 當做 ISP，搭配另一個 Arduino 做燒錄 #ril

## 參考資料

### 相關

  - [Arduino UNO](arduino-uno.md)
  - [AVR Microcontroller](avr.md) - 多數 Arduino 板子都採用 ATmega 系列 microcontroller
  - [ESP8266 Arduino Core](arduino-esp8266.md)
  - [ESP32 Arduino Core](arduino-esp32.md)
