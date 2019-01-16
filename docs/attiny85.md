# ATtiny85

  - [ATtiny85 \- 8\-bit AVR Microcontrollers \- Microcontrollers and Processors \- Microcontrollers and Processors](https://www.microchip.com/wwwproducts/en/ATtiny85)
      - The high-performance, low-power Microchip 8-bit AVR RISC-based microcontroller combines
          - 8KB ISP flash memory, 512B EEPROM, 512-Byte SRAM, 其中 Flash 放程式，SRAM 放執行期變數，EEPROM 則用來存資料。
          - 6 general purpose I/O lines, 總共 8 個腳位，扣除 VCC 與 GND，剩下的腳位都可以用。
          - 32 general purpose working registers,
          - one 8-bit timer/counter with compare modes, one 8-bit high speed timer/counter, 跟 PWM 有關?
          - USI, 是 Universal Serial Interface 的縮寫，用途??
          - internal and external Interrupts,
          - 4-channel 10-bit A/D converter,
          - programmable watchdog timer with internal oscillator,
          - three software selectable POWER SAVING MODEs,
          - and [debugWIRE](https://en.wikipedia.org/wiki/DebugWIRE) for on-chip debugging.
      - The device achieves a throughput of 20 MIPS at 20 MHz and operates between 2.7-5.5 volts. 其中 MIPS 是 Million Instructions Per Second 的意思，運算能力還是很強!
      - By executing powerful instructions in a single clock cycle, the device achieves throughputs approaching 1 MIPS per MHz, BALANCING power consumption and processing speed. 速度夠快又省電，再加上 power saving modes 就更不得了了。

## 應用實例 {: #powered-by }

  - [【Arduino教學】實作15\- arduino最小化\(燒錄至attiny85\) \- YouTube](https://www.youtube.com/watch?v=2nKEA6AUCZM) (2018-07-18) 三色蛋用 ATtiny85 實作，因為它夠小。

## 參考資料 {: #reference }

  - [ATtiny85](https://www.microchip.com/wwwproducts/en/ATtiny85)

手冊：

  - [Data Sheet](https://www.microchip.com/wwwproducts/en/ATtiny85#datasheet-toggle)
