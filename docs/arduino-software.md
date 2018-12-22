---
title: Arduino / Software (IDE)
---
# [Arduino](arduino.md) / Software (IDE)

  - 官方將 IDE 稱做 "Arduino Software" (相對於 hardware)，所以 IDE 有 Arduino IDE 與 Arduino Software 兩種說法。但 [Arduino Software](https://www.arduino.cc/en/Main/Software) 頁面又有 Access the Online IDE 與 Download the Arduino IDE 兩個選項，廣義地來說這些都是 Arduino Software (IDE)，若要區分的話可以說 Arduino Web Editor 與 Arduino Desktop IDE，前者是 Arduino Create 的一員。

參考資料：

  - [Arduino \- Getting Started](https://www.arduino.cc/en/Guide/HomePage) 明確指出 Arduino Software (IDE) 有兩種選項 If you have a reliable Internet connection, you should use the online IDE (Arduino Web Editor). It will allow you to save your sketches in the cloud, having them available from any device and backed up. If you would rather work offline, you should use the latest version of the desktop IDE. 推薦用 Arduino Web Editor (要裝 plugin)，體驗不輸 Desktop IDE

## Arduino Web Editor, Desktop IDE ??

參考資料：

  - [Arduino \- Environment](https://www.arduino.cc/en/Guide/Environment) #ril
  - [Getting Started with Arduino Web Editor on Various Platforms \- Arduino Project Hub](https://create.arduino.cc/projecthub/Arduino_Genuino/getting-started-with-arduino-web-editor-on-various-platforms-4b3e4a) #ril
  - [Arduino Playground \- DevelopmentTools](http://playground.arduino.cc/Main/DevelopmentTools) 除了 Arduino IDE 還有許多選擇 #ril

## Sketch, Shetchbook

  - Sketch 是 Arduino Software 提出的觀念，若直接用 AVR-C 撰寫，就有機會跳脫 `setup()` 與 `loop()` 的框架??

參考資料：

  - [Arduino \- Environment](https://www.arduino.cc/en/Guide/Environment)
      - PROGRAMS written using Arduino Software (IDE) are called SKETCHES. These sketches are written in the text editor and are saved with the file extension `.ino`. ... The toolbar buttons allow you to verify and upload programs, create, open, and save sketches 許多操作的對象都是 sketch。
      - File > Sketchbook - Shows the current sketches within the sketchbook FOLDER STRUCTURE
      - Sketch > Show Sketch Folder - Opens the current sketch folder. 一個 sketch 也是個資料夾
      - Sketch > Add File... - Adds a source file to the sketch (it will be copied from its current location). The new file appears in a new tab in the sketch window. 實驗發現所有檔案都會被複製進 sketch folder 沒錯，但只有 `.c`、`.cpp`、`.h` 才會直接擺在 sketch folder 下，否則會進到 `sketch_folder/data/` 下，也不會開啟 tab 編輯。
      - Tools > Archive Sketch - Archives a copy of the current sketch in `.zip` format. The archive is placed in the same directory as the sketch. 跟 skectch folder 同一層，不是在 sketch folder 裡面。
      - Sketchbook - The Arduino Software (IDE) uses the concept of a sketchbook: a standard place to store your programs (or sketches). You can view or change the location of the sketchbook location from with the Preferences dialog. 以 macOS 而言，預設是在 `~/Documents/Arduino`；注意 sketchbook 只是存放 sketch 慣用的位置，而每個 sketch 都是獨立的 folder，不一定要在 sketchbook folder 下。
      - Tabs, Multiple Files, and Compilation - Allows you to manage sketches with more than one file (each of which appears in its own tab). These can be normal Arduino code files (no visible extension), C files (`.c` extension), C++ files (`.cpp`), or header files (`.h`). 也就是說 sketch 是個 program/project；猜想 Arduino code file 就是 `.ino`，只是在 IDE 裡不會顯示副檔名而已。
  - [Arduino \- Sketch](https://www.arduino.cc/en/Tutorial/Sketch)
      - A sketch is the name that Arduino uses for a PROGRAM. It's the UNIT OF CODE that is uploaded to and run on an Arduino board.
      - There are two special functions that are a part of every Arduino sketch: `setup()` and `loop()`. The `setup()` is called once, when the sketch starts. It's a good place to do SETUP TASKS like setting pin modes or initializing libraries. The `loop()` function is called over and over and is heart of most sketches. You need to include both functions in your sketch, even if you don't need them for anything. 跟一般的 C 程式不同，一定要有 `setup()` 跟 `loop()`，其中 `setup()` 用來做一次性的 setup，接著 `loop()` 會不斷地被執行。
  - [Arduino 1\.6\.6 now requires function prototypes in sketches \(preprocessor changed?\) · Issue \#1066 · esp8266/Arduino](https://github.com/esp8266/Arduino/issues/1066)
      - ladyada: FQA 提到 Your sketch undergoes minor changes (e.g. automatic generation of function prototypes) and then is passed directly to a C/C++ compiler (avr-g++). 現在 sketch 裡沒放 `setup()` 跟 `loop()` 會出錯。
      - ladyada: ok yeah its a thing thats now done with arduino-builder https://github.com/arduino/arduino-builder 專案 README 提到：

        An Arduino sketch differs from a standard C program in that it misses a `main` (provided by the Arduino core), function prototypes are not mandatory, and libraries inclusion is automagic (you just have to `#include` them). This tool generates function prototypes and gathers library paths, providing `gcc` with all the needed `-I` params. 這解釋了為何 Sketch > Include Library 只是加了 `#include`，之後 comipler 就知道要 include 哪些 library。

  - 就 macOS 而言，core 位在 `/Applications/Arduino.app/Contents/Java/hardware/arduino/avr/cores/arduino/` 底下，進而發現 `/Applications/Arduino.app//Contents/Java/hardware/arduino/avr/cores/arduino/main.cpp` 主程式定義了 `setup()` 與 `loop()`：

        #include <Arduino.h>

        // Declared weak in Arduino.h to allow user redefinitions.
        int atexit(void (* /*func*/ )()) { return 0; }

        // Weak empty variant initialization function.
        // May be redefined by variant files.
        void initVariant() __attribute__((weak));
        void initVariant() { }

        void setupUSB() __attribute__((weak));
        void setupUSB() { }

        int main(void)
        {
            init();

            initVariant();

        #if defined(USBCON)
            USBDevice.attach();
        #endif

            setup();

            for (;;) {
                loop();
                if (serialEventRun) serialEventRun();
            }

            return 0;
        }

## Build Process ??

  - 比對 `/Applications/Arduino.app/Contents/Java/hardware/arduino/avr/cores/arduino/*.h` 與 Sketch > Include Library 下的內容，才發現多數選項來自 `/Applications/Arduino.app//Contents/Java/hardware/arduino/avr/librariesls` 與 `/Applications/Arduino.app//Contents/Java/libraries`，但不一定跟 AVR 有關?

參考資料：

  - [Arduino \- Environment](https://www.arduino.cc/en/Guide/Environment)
      - Sketch > Verify/Compile - Checks your sketch for errors compiling it; it will report memory usage for CODE and VARIABLES in the console area.
      - Sketch > Upload - Compiles and loads the BINARY FILE onto the configured board through the configured Port.
      - Sketch > Export Compiled Binary - Saves a `.hex` file that may be kept as archive or sent to the board USING OTHER TOOLS. 顯然 compile 產生的 binary file 就是 `.hex`，是否透過 programmer 上傳有什麼差別?? 不透過 programmer 是透過 onboard USB-serial connection 把程式當資料上傳??
  - [Can I program the Arduino board in C? - Arduino \- FAQ](https://www.arduino.cc/en/Main/FAQ#toc13) Sketch 就是交給 `avr-g++` 編譯；就 macOS 而言，它的位置就在 `/Applications/Arduino.app/Contents/Java/hardware/tools/avr/bin/avr-g++`。
  - [Build Process · arduino/Arduino Wiki](https://github.com/arduino/Arduino/wiki/Build-Process) #ril
  - [Libraries - Arduino \- Environment](https://www.arduino.cc/en/Guide/Environment#libraries)
      - To use a library in a sketch, select it from the Sketch > Import Library menu (現在是 Include Library). This will insert one or more `#include` statements at the top of the sketch and compile the library with your sketch. 只是幫忙加 `#include` 宣告而已；為什麼光是 `#include` 就會增加 program 的大小? 編譯時要 include 哪些 library 是記錄在哪裡? => 中間有 [arduino-builder](https://github.com/arduino/arduino-builder) 在幫忙處理。
      - There is a [list of libraries](https://www.arduino.cc/en/Reference/Libraries) in the reference. Some libraries are included with the Arduino software. Others can be downloaded from a variety of sources or through the Library Manager. 可以下載更多，這些 library 都在哪裡??
      - Starting with version 1.0.5 of the IDE, you do can import a library from a zip file and use it in an open sketch. 以前只能用官方提供的??
  - [Installing Additional Arduino Libraries - Arduino \- Libraries](https://www.arduino.cc/en/Guide/Libraries) #ril
  - [Arduino \- Libraries](https://www.arduino.cc/en/Reference/Libraries) 好多 library 可以用!! #ril
  - [Writing a Library for Arduino - Arduino \- LibraryTutorial](https://www.arduino.cc/en/Hacking/LibraryTutorial) #ril

## Serial Monitor ??

  - [Serial Monitor - Arduino \- Environment](https://www.arduino.cc/en/Guide/Environment#serialmonitor) #ril
      - This displays SERIAL sent from the Arduino or Genuino board over USB or serial connector. To send data to the board, enter text and click on the "send" button or press enter. 既可以讀取 board 送出來的資料，也可以送資料進去。
      - Choose the baud rate from the drop-down menu that matches the rate passed to `Serial.begin` in your sketch. 板子內外的 baud rate 要一致，聽起來其他程式也可以透過 serial 跟板子溝通。
      - The Serial Monitor does not process control characters; if your sketch needs a complete management of the serial communication with control characters, you can use an EXTERNAL TERMINAL PROGRAM and connect it to the COM port assigned to your Arduino board. 怎麼做??

## 安裝設定 {: #installation }

### Arduino Web Editor (Plugin)

  - 進到 web editor 時提示 "No Plugin Connection. Uploading is disabled until you reconnect."，按 HELP 會提示 Do you see the Plugin Icon  on your system tray? NO: Launch the Plugin as you would do for any program on your OS, searching for 'Arduino Create Agent'. 但下面又說 You can also INSTALL THE PLUGIN again, and replace the old one. 什麼是 agent? 跟 plugin 不同? => 一樣的東西
  - [Welcome to the Arduino Web Editor Plugin! - Arduino Create](https://create.arduino.cc/getting-started/plugin) 除了把程式上傳到板子，還提到 "use other Arduino Cloud services"，指的是什麼?
  - [Download the Arduino Plugin for Macos - Arduino Create](https://create.arduino.cc/getting-started/plugin)
      - Source code for the Arduino Plugin is available on GitHub 的連結是指向 [Arduino Create Agent](https://github.com/arduino/arduino-create-agent)，按 Download Plugin 下載 `ArduinoCreateAgent-1.1-osx-installer-chrome.dmg`，安裝到 `~/Applications/ArduinoCreateAgent-1.1`。
      - 最後一步問 Broser Support - Do you intend to use Arduino Agent with a brower other than Google Chrome or Mozill Firefox? 預設是 No，選 Yes 會怎樣? 跟 browser 是什麼關係?
      - 安裝完成會出現 system tray icon (不單單是 Chrome plugin?)，系統會多了個名叫 ArduinoCreateAgent 的 app；黑色 icon 別於 Arduino Desktop IDE 的水藍色。

### Arduino Desktop IDE

  - [Arduino \- MacOSX](https://www.arduino.cc/en/Guide/MacOSX) 從 [Arduino \- Software](https://www.arduino.cc/en/Main/Software) 下載 `arduino-1.8.8-macosx.zip` (約 190 MB)，解開後將 `Arduino.app` 拖進 `/Applications` 即可。

## 參考資料 {: #reference }

  - [arduino/Arduino - GitHub](https://github.com/arduino/Arduino/)
  - [arduino/arduino-builder - GitHub](https://github.com/arduino/arduino-builder)
  - [Arduino Web Editor](https://create.arduino.cc/editor/)

相關：

  - [Arduino Hardware](arduino-hardware.md) - 上傳的程式會由 bootloader 執行，而 bootloader 可以用 programmer 覆寫
  - [Arduino Programming](arduino-programming.md) - Arduino Software 是官方相對於 hardware 所提供的 toolset (主要是編譯、上傳)，除了 sketch 要求的 `setup()` 跟 `loop()`，只是多了 Arduino 相關的 API 可以調用而已

