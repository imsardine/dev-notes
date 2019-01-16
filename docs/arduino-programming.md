---
title: Ardunio / Programming
---
# [Arduino](arduino.md) / Programming

## 新手上路 ?? {: #getting-started }

  - [Arduino \- Foundations](https://www.arduino.cc/en/Tutorial/Foundations) #ril
  - [Arduino \- Sketch](https://www.arduino.cc/en/Tutorial/Sketch) 以內建的 Blink 範例說明
      - A sketch is the name that Arduino uses for a PROGRAM. It's the UNIT OF CODE that is uploaded to and run on an Arduino board. Sketch 只是 Ardunio 對於 program 的說法，一樣可以由多支檔案組成。
      - You can call a function that's already been defined (either in your sketch or as part of the Arduino language). There are two special functions that are a part of every Arduino sketch: `setup()` and `loop()`. The `setup()` is called once, when the sketch starts. It's a good place to do SETUP TASKS like setting pin modes or initializing libraries. The `loop()` function is called over and over and is heart of most sketches. You need to include both functions in your sketch, even if you don't need them for anything. 跟一般的 C 程式不同，一定要有 `setup()` 跟 `loop()`，其中 `setup()` 用來做一次性的 setup，接著 `loop()` 會不斷地被執行。

            void setup()
            {
              pinMode(ledPin, OUTPUT);      // sets the digital pin as output
              Serial.begin(9600);           // initializing libraries
            }

      - The `pinMode()` function configures a pin as either an input or an output. To use it, you pass it the number of the pin to configure and the constant `INPUT` or `OUTPUT`. When configured as an input, a pin can detect the state of a sensor like a pushbutton.
      - The `digitalWrite()` functions outputs a value on a pin. 例如 `digitalWrite(ledPin, HIGH);`。
      - The `delay()` causes the Arduino to wait for the specified number of milliseconds before continuing on to the next line. 例如 `delay(1000)` 會暫停 1 秒。

  - [Arduino \- BareMinimum](https://www.arduino.cc/en/Tutorial/BareMinimum)

        void setup() {
          // put your setup code here, to run once:

        }

        void loop() {
          // put your main code here, to run repeatedly:

        }

      - This example contains the BARE MINIMUM of code you need for a sketch to compile properly on Arduino Software (IDE): the `setup()` method and the `loop()` method.
      - The `setup()` function is called when a sketch starts. Use it to initialize variables, pin modes, START USING LIBRARIES, etc. The setup function will only run once, after each POWERUP or RESET OF THE BOARD.
      - After creating a `setup()` function, the `loop()` function does precisely what its name suggests, and loops consecutively, allowing your program to change and respond as it runs. Code in the `loop()` section of your sketch is used to ACTIVELY control the board.

  - [Arduino \- Blink](https://www.arduino.cc/en/Tutorial/Blink)

        // the setup function runs once when you press reset or power the board
        void setup() {
          // initialize digital pin LED_BUILTIN as an output.
          pinMode(LED_BUILTIN, OUTPUT);
        }

        // the loop function runs over and over again forever
        void loop() {
          digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
          delay(1000);                       // wait for a second
          digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
          delay(1000);                       // wait for a second
        }

      - This (built-in) LED is connected to a DIGITAL pin and its number may VARY FROM BOARD TYPE TO BOARD TYPE. To make your life easier, we have a constant that is specified in every board DESCRIPTOR FILE. This constant is `LED_BUILTIN` and allows you to control the built-in LED easily. 下面列出不同板子連接到 built-in LED 的 pin number，例如 Arduino UNO 是 D13，其中 D 指的是 digital。
      - If you want to lit an external LED with this sketch, you need to build this circuit, where you connect one end of the resistor to the digital pin correspondent to the `LED_BUILTIN` constant. Connect the long leg of the LED (the positive leg, called the anode) to the other end of the resistor. Connect the short leg of the LED (the negative leg, called the cathode) to the GND. 由於 built-in LED 有內建電阻，所以不用特別加 220 ohm (紅紅棕)；同時間內外 LED 都會閃。

        ![](https://www.arduino.cc/en/uploads/Tutorial/ExampleCircuit_bb.png){: width="30%"}
        ![Schematic](https://www.arduino.cc/en/uploads/Tutorial/ExampleCircuit_sch.png){: width="30%"}

      - The value of the resistor in series with the LED may be of a different value than 220 ohm; the LED will lit up also with values up to 1K ohm. 電阻越大，亮度越低。
      - The first thing you do is to initialize `LED_BUILTIN` pin as an output pin with the line `pinMode(LED_BUILTIN, OUTPUT);` In the MAIN LOOP, you turn the LED on with the line: `digitalWrite(LED_BUILTIN, HIGH);` This supplies 5 volts to the LED anode. That creates a VOLTAGE DIFFERENCE across the pins of the LED, and lights it up. Then you turn it off with the line: `digitalWrite(LED_BUILTIN, LOW);` That takes the `LED_BUILTIN` pin back to 0 volts, and turns the LED off. 形成電位差，就會有電流流動，方向若是從 LED 的正極流往負極，就能點亮它。
      - In between the on and the off, you want enough time FOR A PERSON TO SEE THE CHANGE, so the `delay()` commands tell the board to do nothing for 1000 milliseconds, or one second. When you use the `delay()` command, nothing else happens for that amount of time. 原本不是沒變化，而是快到肉眼看不出來。
      - Check out the `BlinkWithoutDelay` example to learn how to create a delay WHILE DOING OTHER THINGS. 手動營造出多工的效果...

  - [Arduino \- DigitalReadSerial](https://www.arduino.cc/en/Tutorial/DigitalReadSerial)
      - This example shows you how to monitor the state of a switch by establishing SERIAL COMMUNICATION between your Arduino or Genuino and your computer over USB. 當 pushbutton 被按下時，可以從 D2 得知；會用到 pull-down resistor，但不會用到 LED，所以電阻才會用 10k，跟 Blink 的 220 ohm 差很多。
      - Connect three wires to the board. The first two, red and black, connect to the two long vertical rows on the side of the breadboard to provide access to the 5 volt supply and ground. 跟 Blink 由 GPIO pin 提供電源不同 (但一樣是 5V)，這裡 "provide ground" 的說法很有趣。
      - The third wire goes from digital pin 2 to one leg of the pushbutton. That same leg (指另一邊永遠連通的接腳) of the button connects through a PULL-DOWN RESISTOR (here 10k ohm) to ground. The other leg of the button connects to the 5 volt supply. 雖然 pushbutton 外觀上有 4 支腳，但其實是兩兩相連的；按下時 "全部" 會連通。

        ![](https://www.arduino.cc/en/uploads/Tutorial/button.png){: width="60%"}
        ![](https://www.arduino.cc/en/uploads/Tutorial/button_sch.png){: width="30%"}

      - Pushbuttons or switches CONNECT TWO POINTS in a circuit when you press them. When the pushbutton is OPEN (unpressed) there is no connection between the two legs of the pushbutton, so the pin is connected to ground (through the pull-down resistor) and reads as LOW, or 0. When the button is CLOSED (pressed), it makes a connection between its two legs, connecting the pin to 5 volts, so that the pin reads as HIGH, or 1.
      - If you disconnect the digital i/o pin from everything, the LED may blink erratically. This is because the input is "FLOATING" - that is, it doesn't have a SOLID CONNECTION to voltage or ground, and it will randomly return either HIGH or LOW. That's why you need a pull-down resistor in the circuit. 平時 digital pin 沒有經由 pull-down resistor 連往 GND 的話，讀到的值會在 HIGH 與 LOW 之間跳動 (floating)；這裡沒講清楚的是，雖然 D2-switch-GND 直接連通也可以 (solid connection)，但按下按鈕時為了不讓電流往 GND 去，所以中間才要安排 pull-down resistor。
      - In the program below, the very first thing that you do will in the setup function is to begin serial communications, at 9600 bits of data per second, between your board and your computer with the line: `Serial.begin(9600);`
      - 5 volts will freely flow through your circuit, and when it is not pressed, the input pin will be connected to ground through the 10k ohm resistor. This is a DIGITAL Input, meaning that the switch can only be in either an on state (seen by your Arduino as a "1", or HIGH) or an off state (seen by your Arduino as a "0", or LOW), with NOTHING IN BETWEEN.
      - ... You can accomplish all this with just one line of code: `int sensorValue = digitalRead(2);` Once the bord has read the input, make it print this information BACK TO THE COMPUTER as a decimal value. You can do this with the command `Serial.println()` in our last line of code: `Serial.println(sensorValue);` Now, when you open your Serial Monitor in the Arduino Software (IDE), you will see a stream of "0"s if your switch is open, or "1"s if your switch is closed.

            int pushButton = 2;

            // the setup routine runs once when you press reset:
            void setup() {
              // initialize serial communication at 9600 bits per second:
              Serial.begin(9600);
              // make the pushbutton's pin an input:
              pinMode(pushButton, INPUT);
            }

            // the loop routine runs over and over again forever:
            void loop() {
              // read the input pin:
              int buttonState = digitalRead(pushButton);
              // print out the state of the button:
              Serial.println(buttonState);
              delay(1);        // delay in between reads for stability
            }

        上面提到的 "LED may blink erratically"，斷掉 D2-GND 的連線，加上下面的邏輯就可以用內建的 LED 觀察：

            digitalWrite(LED_BUILTIN, buttonState == 1 ? HIGH : LOW);
            delay(100);

  - [Arduino \- AnalogReadSerial](https://www.arduino.cc/en/Tutorial/AnalogReadSerial)
      - This example shows you how to read ANALOG INPUT from the physical world using a POTENTIOMETER. A potentiometer is a simple mechanical device that provides a varying amount of resistance when its shaft (轉軸) is turned. By passing voltage through a potentiometer and into an analog input on your board, it is possible to measure the AMOUNT OF RESISTANCE produced by a potentiometer (or POT for short) as an analog value. 確實 potentiometer 是個可變電阻，但多了第 3 根腳可以讀到電阻值；正確地來說，是讀到不同的電壓值。
      - Connect the three wires from the potentiometer to your board. The first goes from one of the OUTER pins of the potentiometerto ground. The second goes from the other outer pin of the potentiometer to 5 volts. The third goes from the MIDDLE pin of the potentiometer to the analog pin A0. 外觀有 3 支腳 (2 + 1)，單支腳接往 analog pin (A0)，另外 2 支腳則分別接正負極，本身產生的電阻可以在第 3 支腳 (middle pin) 讀到。

        ![](https://www.arduino.cc/en/uploads/Tutorial/AnalogReadSerial_BB.png)
        ![](https://www.arduino.cc/en/uploads/Tutorial/AnalogReadSerial_sch.png){: width="35%"}

      - By turning the shaft of the potentiometer, you change the amount of resistance on either side of the WIPER, which is connected to the center pin of the potentiometer. This changes the VOLTAGE AT THE CENTER PIN. When the resistance between the center and the side connected to 5 volts is close to zero (and the resistance on the other side is close to 10k ohm), the voltage at the center pin nears 5 volts. When the resistances are reversed, the voltage at the center pin nears 0 volts, or ground. This voltage is the ANALOG VOLTAGE that you're reading as an input. 可以想成 wiper 就是 5v 與 middle pin 中間的電阻；完全沒電阻時會讀到 5V，電阻全開時會讀到 0V，而 analog input 就是 0 ~ 5V 中間的變化值。
      - The Arduino and Genuino boards have a circuit inside called an analog-to-digital converter or ADC that reads this changing voltage and converts it to a number between 0 and 1023. When the shaft is turned all the way in one direction, there are 0 volts going to the pin, and the input value is 0. When the shaft is turned all the way in the opposite direction, there are 5 volts going to the pin and the input value is 1023. In between, `analogRead()` returns a number between 0 and 1023 that is proportional to the amount of voltage being applied to the pin. 由於內建 ADC，能將 0 ~ 5V 細分成 1024 階 (0 ~ 1023)，用 `analogRead()` 就能讀到這個值。
      - The only thing that you do in the `setup` function is to begin serial communications, at 9600 bits of data per second, between your board and your computer with the command: `Serial.begin(9600);` ... you need to establish a variable to store the resistance value (which will be between 0 and 1023, perfect for an `int` datatype) coming in from your potentiometer: `int sensorValue = analogRead(A0);` 傳送與接收兩端的 baud rate 要一樣；原來 `A0` 被定義在 Arduino Core 裡：

            void setup() {
              // initialize serial communication at 9600 bits per second:
              Serial.begin(9600);
            }

            // the loop routine runs over and over again forever:
            void loop() {
              // read the input on analog pin 0:
              int sensorValue = analogRead(A0);
              // print out the value you read:
              Serial.println(sensorValue);
              delay(1);        // delay in between reads for stability
            }

        不用先將 A0 設為 input mode? 猜想板子上寫著 ANALOG IN，這些 pin 固定只用在 input (ADC + `analogRead()`)，而且 Fade 的例子，analog output? 是寫往 digital pin 而非 analog pin。事實上 `pinMode()` 在 Arduino Reference 裡被歸為 Digital I/O。

      - You should see a STEADY stream of numbers ranging from 0-1023, correlating to the position of the pot. As you turn your potentiometer, these numbers will respond almost instantly. 實際上觀察，只要不轉動 potentiometer，用 `analogRead()` 讀到的值是滿固定的。

  - [Arduino \- Fade](https://www.arduino.cc/en/Tutorial/Fade)

        int led = 9;           // the PWM pin the LED is attached to
        int brightness = 0;    // how bright the LED is
        int fadeAmount = 5;    // how many points to fade the LED by

        // the setup routine runs once when you press reset:
        void setup() {
          // declare pin 9 to be an output:
          pinMode(led, OUTPUT);
        }

        // the loop routine runs over and over again forever:
        void loop() {
          // set the brightness of pin 9:
          analogWrite(led, brightness);

          // change the brightness for next time through the loop:
          brightness = brightness + fadeAmount;

          // reverse the direction of the fading at the ends of the fade:
          if (brightness <= 0 || brightness >= 255) {
            fadeAmount = -fadeAmount;
          }
          // wait for 30 milliseconds to see the dimming effect
          delay(30);
        }

      - This example demonstrates the use of the `analogWrite()` function in fading an LED off and on. AnalogWrite uses pulse width modulation (PWM), turning a digital pin ON AND OFF VERY QUICKLY with different ratio between on and off, to create a fading effect. 不是改變輸出的電壓!! 由於輸出還是 digital (0/1)，只是搭配 PWM 產生不同頻率的訊號，所以還是寫往 digital pin (標示有 PWM~ 者)，還是要先設定 output mode。
      - The `analogWrite()` function that you will be using in the main loop of your code requires two arguments: One telling the function which pin to write to, and one indicating what PWM value to write. In order to fade your LED off and on, gradually increase your PWM value from 0 (all the way off) to 255 (all the way on), and then back to 0 once again to complete the cycle. 注意 PWM 的值介於 0 ~ 255，跟上個範例 analog input 由 ADC 轉出的 0 ~ 1024 不同。
      - `analogWrite()` can change the PWM value very fast, so the delay at the end of the sketch controls the speed of the fade. Try changing the value of the delay and see how it changes the fading effect.

  - [Arduino \- PWM](https://www.arduino.cc/en/Tutorial/PWM) #ril
  - [Arduino \- ReadAnalogVoltage](https://www.arduino.cc/en/Tutorial/ReadAnalogVoltage) 將 analog input 換算回 voltage，為什麼有這個需求? #ril
  - [Built-In Examples - Arduino \- BuiltInExamples](https://www.arduino.cc/en/Tutorial/BuiltInExamples) 所有內建在 Arduino Software 的範例，值得全部做過!! #ril
  - [Examples from Libraries - Arduino \- LibraryExamples](https://www.arduino.cc/en/Tutorial/LibraryExamples) #ril

## Arduino Language, Standard Arduino Library/Core, C, C++

  - Sketch 是 Arduino Software 提出的觀念；Sketch folder = Arduino code file (`.ino`) + C/C++ files (`.c`/`.cpp`) + header files (`.h`)。
  - Ardunio code file = Arduino Core (`#include <Arduino.h>`) + `setup()` + `loop()` --> 經過 arduino-builder 轉換 --> 交給 AVR-GCC 編譯 --> 跟 AVR Libc 連結 --> 產生 binary (`.hex`)。
  - Arduino Language 實質上就是 `#include <Arduino.h>` -- 間接引入了 `<stdlib.h>`、`<stdbool.h>`、`<string.h>`、`<math.h>`、`<avr/pgmspace.h>`、`<avr/io.h>`、`<avr/interrupt.h>` 等 libraries，定義了 `HIGH`/`LOW`、`INPUT`/`OUTPUT`/`INPUT_PULLUP` 等常數，`pinMode()`、`digitalWrite()`、`digitalWrite()` 等 function，另外宣告了一些 `#define min(a,b) ((a)<(b)?(a):(b))` 這類的 macro，這些林林總總加起來，就形成 [Arduino Reference](https://www.arduino.cc/reference/en/) 所宣稱的 Arduino Programming Language；與其說是 lanugage，倒不如說是 framework。

---

參考資料：

  - [Hardware - Arduino \- Hacking](https://www.arduino.cc/en/Hacking/HomePage) Arduino sketches are C/C++ based and compiled with the open-source compiler [avr-gcc](https://www.avrfreaks.net/) and linked against the open-source [AVR Libc](http://www.nongnu.org/avr-libc/). The Arduino language comes from [Wiring](http://wiring.org.co/). The Arduino environment is based on [Processing](http://processing.org/) and includes modifications made by Wiring.

  - [Can I program the Arduino board in C? - Arduino \- FAQ](https://www.arduino.cc/en/Main/FAQ#toc13) In fact, you already are; the Arduino language is MERELY A SET OF C/C++ FUNCTIONS that can be called from your code. Your sketch undergoes minor changes (e.g. automatic generation of function prototypes) and then is passed directly to a C/C++ compiler (`avr-g++`). All standard C and C++ constructs supported by `avr-g++` should work in Arduino. 本來就是 C/C++，只要 compiler `avr-g++` 支援即可。Sketch 就是交給 `avr-g++` 編譯；就 macOS 而言，它的位置就在 `/Applications/Arduino.app/Contents/Java/hardware/tools/avr/bin/avr-g++`。

  - [Arduino \- Reference](https://www.arduino.cc/en/Reference/HomePage?from=Reference.Extended) The Arduino language is based on C/C++. It links against [AVR Libc](http://www.nongnu.org/avr-libc/user-manual/modules.html) and allows the use of any of its functions; see its [user manual](http://www.nongnu.org/avr-libc/user-manual/index.html) for details.

  - [Beginning Arduino](https://books.google.com.tw/books?id=QTbyAAAAQBAJ&pg=PA20) 中提到 Arduino IDE 中寫的語言就是 C，許多專家都用其他 IDE，例如 Eclipse、ArduIDE、GNU/Emacs、AVR-GCC、AVR Studio 甚至是 Xcode；若直接用 AVR-C 撰寫，就有機會跳脫 `setup()` 與 `loop()` 的框架??

  - [Why Arduino? - Arduino \- Introduction](https://www.arduino.cc/en/Guide/Introduction) 關於 "Open source and extensible software" 的說明中提到 Arduino programming language 可以用 C++ library 擴充，懂的人也可以直接用 AVR C programming language 來寫。而 "you can add AVR-C code directly into your Arduino programs if you want to" 這句話似乎就在講 Arduino IDE 裡寫的就是 C 語言。

  - [Overview - Build Process · arduino/Arduino Wiki](https://github.com/arduino/Arduino/wiki/Build-Process#overview)
      - Then your code gets combined with (linked against), the STANDARD ARDUINO LIBRARIES that provide basic functions like `digitalWrite()` or `Serial.print()`.
      - If not already present, `#include <Arduino.h>` is added to the sketch. This header file (found in the `core` folder for the currently selected board) includes all the definitions needed for the STANDARD ARDUINO CORE.

  - [ArduinoCore\-avr/Arduino\.h at master · arduino/ArduinoCore\-avr](https://github.com/arduino/ArduinoCore-avr/blob/master/cores/arduino/Arduino.h) 一開始引入了 `<stdlib.h>`、`<stdbool.h>`、`<string.h>`、`<math.h>`、`<avr/pgmspace.h>`、`<avr/io.h>`、`<avr/interrupt.h>` 等 libraries，定義了 `HIGH`/`LOW`、`INPUT`/`OUTPUT`/`INPUT_PULLUP` 等常數，`pinMode()`、`digitalWrite()`、`digitalWrite()` 等 function，另外宣告了一些 `#define min(a,b) ((a)<(b)?(a):(b))` 這類的 macro，這些林林總總加起來，就形成 [Arduino Reference](https://www.arduino.cc/reference/en/) 所宣稱的 Arduino Programming Language。

  - [Arduino 1\.6\.6 now requires function prototypes in sketches \(preprocessor changed?\) · Issue \#1066 · esp8266/Arduino](https://github.com/esp8266/Arduino/issues/1066)
      - ladyada: FQA 提到 Your sketch undergoes minor changes (e.g. automatic generation of function prototypes) and then is passed directly to a C/C++ compiler (avr-g++). 現在 sketch 裡沒放 `setup()` 跟 `loop()` 會出錯 -- `undefined reference to 'setup'`
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

## Digital I/O ??

  - [pinMode() - Arduino Reference](https://www.arduino.cc/reference/en/language/functions/digital-io/pinmode/) #ril
  - [digitalRead() - Arduino Reference](https://www.arduino.cc/reference/en/language/functions/digital-io/digitalread/) #ril
  - [digitalWrite() - Arduino Reference](https://www.arduino.cc/reference/en/language/functions/digital-io/digitalwrite/) #ril
  - [Defining Pin Levels: HIGH and LOW - Arduino Reference](https://www.arduino.cc/reference/en/language/variables/constants/constants/#_defining_pin_levels_high_and_low) #ril
  - [Defining Digital Pins modes: INPUT, INPUT_PULLUP, and OUTPUT - Arduino Reference](https://www.arduino.cc/reference/en/language/variables/constants/constants/#_defining_digital_pins_modes_input_input_pullup_and_output) #ril
  - [Defining built-ins: LED_BUILTIN - Arduino Reference](https://www.arduino.cc/reference/en/language/variables/constants/constants/#_defining_built_ins_led_builtin)

## Analog I/O ??

  - [analogRead() - Arduino Reference](https://www.arduino.cc/reference/en/language/functions/analog-io/analogread/) #ril
  - [analogWrite() - Arduino Reference](https://www.arduino.cc/reference/en/language/functions/analog-io/analogwrite/) #ril
  - [analogReference() - Arduino Reference](https://www.arduino.cc/reference/en/language/functions/analog-io/analogreference/) #ril

## Memory ??

  - [Arduino \- Memory](https://www.arduino.cc/en/tutorial/memory) Flash 放程式，SRAM 放執行期資料，而 EEPROM 則是放長期資料 #ril

## Library ??

  - [Arduino \- Libraries](https://www.arduino.cc/en/Reference/Libraries) Standard Libraries 列了不少 library #ril
  - [Writing a Library for Arduino - Arduino \- LibraryTutorial](https://www.arduino.cc/en/Hacking/LibraryTutorial) #ril

## Build Process ??

  - 比對 `/Applications/Arduino.app/Contents/Java/hardware/arduino/avr/cores/arduino/*.h` 與 Sketch > Include Library 下的內容，才發現多數選項來自 `/Applications/Arduino.app//Contents/Java/hardware/arduino/avr/librariesls` 與 `/Applications/Arduino.app//Contents/Java/libraries`，但不一定跟 AVR 有關?

參考資料：

  - [arduino/arduino\-builder: A command line tool for compiling Arduino sketches](https://github.com/arduino/arduino-builder) Arduino Software 背後用的工具，可以實現從 command line 建構 Arduino 專案 #ril
  - [queezythegreat/arduino\-cmake: Arduino CMake Build system](https://github.com/queezythegreat/arduino-cmake) 這才知道 CMake 可以通吃 Makefile、Eclipse project、Visual Studio 跟 Xcode 等；不過 `example/` 的程式還是用了 `setup()` 跟 `loop()` #ril
  - [Arduino \- Environment](https://www.arduino.cc/en/Guide/Environment)
      - Sketch > Verify/Compile - Checks your sketch for errors compiling it; it will report memory usage for CODE and VARIABLES in the console area.
      - Sketch > Upload - Compiles and loads the BINARY FILE onto the configured board through the configured Port.
      - Sketch > Export Compiled Binary - Saves a `.hex` file that may be kept as archive or sent to the board USING OTHER TOOLS. 顯然 compile 產生的 binary file 就是 `.hex`，是否透過 programmer 上傳有什麼差別?? 不透過 programmer 是透過 onboard USB-serial connection 把程式當資料上傳??
  - [Build Process · arduino/Arduino Wiki](https://github.com/arduino/Arduino/wiki/Build-Process) #ril

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
