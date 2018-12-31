---
title: MicroPython / GPIO
---
# [MicroPython](micropython.md) / GPIO

## 新手上路 ?? {: #getting-started }

  - [1\. Getting started with MicroPython on the ESP8266 — MicroPython 1\.9\.4 documentation](http://docs.micropython.org/en/latest/esp8266/tutorial/intro.html) Names of pins will be given in this tutorial using the CHIP NAMEs (eg GPIO0) and it should be straightforward to find which pin this corresponds to on your particular board. 為什麼說 GPIO0 是 chip name?? 看來 GPIO pin 要對應到實體開發版的哪個 pin 會因開發版而異? 即便都是用 ESP8266。
  - [MicroPython: GPIO Pins · lvidarte/esp8266 Wiki](https://github.com/lvidarte/esp8266/wiki/MicroPython:-GPIO-Pins) #ril

  - [MicroPython with ESP32 and ESP8266: Interacting with GPIOs \| Random Nerd Tutorials](https://randomnerdtutorials.com/micropython-gpios-esp32-esp8266/) #ril
  - [class Pin – control I/O pins — MicroPython 1\.9\.4 documentation](http://docs.micropython.org/en/latest/library/machine.Pin.html) #ril
  - [class Signal – control and sense external I/O devices — MicroPython 1\.9\.4 documentation](http://docs.micropython.org/en/latest/library/machine.Signal.html) #ril
  - [Release v1\.9\.1: Fixes for stmhal USB mass storage, lwIP bindings and VFS regressions · micropython/micropython](https://github.com/micropython/micropython/releases/tag/v1.9.1) - esp8266: consistently replace `Pin.high/low` methods with `.on/off` 因為其他 port 都用 `.on()/off()`? 倒覺得對於潛流 (sink current) 接法的元件來說 `Pin.value(0)/value(1)` 會比 `Pin.on()/off()` 來得直覺，除非改用 `Signal.on()/off()` 就沒這個問題。
  - [9\. GPIO \- Programming with MicroPython \[Book\]](https://www.oreilly.com/library/view/programming-with-micropython/9781491972724/ch09.html) #ril


