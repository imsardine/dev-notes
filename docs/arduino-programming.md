---
title: Ardunio / Programming
---
# [Arduino](arduino.md) / Programming

## 新手上路 ?? {: #getting-started }

  - [Arduino \- Foundations](https://www.arduino.cc/en/Tutorial/Foundations) #ril
  - [Built-In Examples - Arduino \- BuiltInExamples](https://www.arduino.cc/en/Tutorial/BuiltInExamples) 所有內建在 Arduino Software 的範例，值得全部做過!! #ril
  - [Examples from Libraries - Arduino \- LibraryExamples](https://www.arduino.cc/en/Tutorial/LibraryExamples) #ril

## Arduino Language, Standard Arduino Library/Core, C, C++ ??

  - [Hardware - Arduino \- Hacking](https://www.arduino.cc/en/Hacking/HomePage) Arduino sketches are C/C++ based and compiled with the open-source compiler [avr-gcc](https://www.avrfreaks.net/) and linked against the open-source [AVR Libc](http://www.nongnu.org/avr-libc/). The Arduino language comes from [Wiring](http://wiring.org.co/). The Arduino environment is based on [Processing](http://processing.org/) and includes modifications made by Wiring.
  - [Can I program the Arduino board in C? - Arduino \- FAQ](https://www.arduino.cc/en/Main/FAQ#toc13) In fact, you already are; the Arduino language is merely a set of C/C++ functions that can be called from your code. Your sketch undergoes minor changes (e.g. automatic generation of function prototypes) and then is passed directly to a C/C++ compiler (`avr-g++`). All standard C and C++ constructs supported by `avr-g++` should work in Arduino. 本來就是 C/C++，只要 compiler `avr-g++` 支援即可；其中 "generation of function prototypes" 指的是什麼??
  - [Arduino \- Reference](https://www.arduino.cc/en/Reference/HomePage?from=Reference.Extended) The Arduino language is based on C/C++. It links against [AVR Libc](http://www.nongnu.org/avr-libc/user-manual/modules.html) and allows the use of any of its functions; see its [user manual](http://www.nongnu.org/avr-libc/user-manual/index.html) for details.
  - [Beginning Arduino](https://books.google.com.tw/books?id=QTbyAAAAQBAJ&pg=PA20) 中提到 Arduino IDE 中寫的語言就是 C，許多專家都用其他 IDE，例如 Eclipse、ArduIDE、GNU/Emacs、AVR-GCC、AVR Studio 甚至是 Xcode。
  - [Why Arduino? - Arduino \- Introduction](https://www.arduino.cc/en/Guide/Introduction) 關於 "Open source and extensible software" 的說明中提到 Arduino programming language 可以用 C++ library 擴充，懂的人也可以直接用 AVR C programming language 來寫。而 "you can add AVR-C code directly into your Arduino programs if you want to" 這句話似乎就在講 Arduino IDE 裡寫的就是 C 語言。
  - [Overview - Build Process · arduino/Arduino Wiki](https://github.com/arduino/Arduino/wiki/Build-Process#overview)
      - Then your code gets combined with (linked against), the STANDARD ARDUINO LIBRARIES that provide basic functions like `digitalWrite()` or `Serial.print()`.
      - If not already present, `#include <Arduino.h>` is added to the sketch. This header file (found in the `core` folder for the currently selected board) includes all the definitions needed for the STANDARD ARDUINO CORE.
  - [ArduinoCore\-avr/Arduino\.h at master · arduino/ArduinoCore\-avr](https://github.com/arduino/ArduinoCore-avr/blob/master/cores/arduino/Arduino.h) 一開始引入了 `<stdlib.h>`、`<stdbool.h>`、`<string.h>`、`<math.h>`、`<avr/pgmspace.h>`、`<avr/io.h>`、`<avr/interrupt.h>` 等 libraries，定義了 `HIGH`/`LOW`、`INPUT`/`OUTPUT`/`INPUT_PULLUP` 等常數，`pinMode()`、`digitalWrite()`、`digitalWrite()` 等 function，另外宣告了一些 `#define min(a,b) ((a)<(b)?(a):(b))` 這類的 macro，這些林林總總加起來，就形成 [Arduino Reference](https://www.arduino.cc/reference/en/) 所宣稱的 Arduino Programming Language。
  - [Arduino \- Libraries](https://www.arduino.cc/en/Reference/Libraries) Standard Libraries 列了不少 library #ril

## Build Process

參考資料：

  - [arduino/arduino\-builder: A command line tool for compiling Arduino sketches](https://github.com/arduino/arduino-builder) Arduino Software 背後用的工具，可以實現從 command line 建構 Arduino 專案 #ril
  - [queezythegreat/arduino\-cmake: Arduino CMake Build system](https://github.com/queezythegreat/arduino-cmake) 這才知道 CMake 可以通吃 Makefile、Eclipse project、Visual Studio 跟 Xcode 等；不過 `example/` 的程式還是用了 `setup()` 跟 `loop()` #ril

## Interfacing ??

  - [Serial Monitor - Arduino \- Environment](https://www.arduino.cc/en/Guide/Environment#serialmonitor) 提到 You can also talk to the board from Processing, Flash, MaxMSP, etc (see the interfacing page for details). 原來要從外面跟板子溝通有很多方式，都是走 serial ??
  - [Arduino Playground \- Interfacing](http://playground.arduino.cc/Main/Interfacing) 許多語言、平台，都可以跟 Arduino 溝通 #ril

## 參考資料 {: #reference }

更多：

  - [Audio](arduino-audio.md)
  - [Display](arduino-display.md)

相關：

  - [AVR Libc](avr-libc.md)
  - [Fritzing](fritzing.md) - 程式通常必須搭配特定的線路配置

手冊：

  - [Arduino Language Reference](https://www.arduino.cc/reference/en/)
  - [ArduinoCore-avr/Arduino.h](https://github.com/arduino/ArduinoCore-avr/blob/master/cores/arduino/Arduino.h)
  - [Arduino Libraries](https://www.arduino.cc/en/Reference/Libraries)
