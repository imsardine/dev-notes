# MicroPython

  - [MicroPython \- Python for microcontrollers](https://micropython.org/)
      - MicroPython is a lean and efficient implementation of the Python 3 programming language
      - Yet it is compact enough to fit and run within just 256k of code space and 16k of RAM. 呼應 [MCU - Glossary — MicroPython 1\.9\.4 documentation](https://docs.micropython.org/en/latest/reference/glossary.html#term-mcu) ... but smaller, cheaper and require much less power. MicroPython is designed to be small and optimized enough to run on an average modern microcontroller. 的說法。
      - TEST DRIVE A PYBOARD - [MicroPython Live](http://micropython.org/live/) 遠端 pyboard 直播，可以線上寫程式排程執行。
      - USE MICROPYTHON ONLINE - [MicroPython on Unicorn](https://micropython.org/unicorn/) 利用 [Unicorn.js](https://github.com/micropython/micropython-unicorn) 模擬出 pyboard 及 MicroPython 執行環境，不過 `led = machine.Pin(2, machine.Pin.OUT)` 都會丟 `TypeError: can't convert 'int' object to str implicitly` 的錯誤，可用性不高?
      - MicroPython is written in C99 and the entire MicroPython core is available for general use under the very liberal MIT license. ... You can freely use and adapt MicroPython for personal use, in education, and in COMMERCIAL products. 對商業應用很友善!
      - 官網最下面寫著 A project by Damien George © 2014-2018 George Robotics Limited 其中，呼應 [Damien P\. George](http://dpgeorge.net/) 所說的 At the end of 2013 I ran a Kickstarter campaign for the MicroPython project, which is a lean and fast implementation of the Python programming language that is optimised to run on microcontrollers. 這個專案由 Damien George 發起，背後的公司是 George Robotics Limited。
  - [Code: state-of-the-art and highly robust - MicroPython \- Python for microcontrollers](https://micropython.org/)
      - Support for many architectures (x86, x86-64, ARM, ARM Thumb, Xtensa) 竟然也支援 x86，而 ESP8266 就是基於 Tensilica Xtensa。
      - Extensive test suite with over 590 tests, and more than 18,500 individual testcases. code coverage at 98.4% for the core and at 96.3% for the core plus extended modules 驚人的 coverage，更提高了商用的可能性。
      - Fast start-up time from boot to loading of first script (150 microseconds to get to `boot.py`, on PYBv1.1 running at 168MHz) 在實務應用上啟動速度很關鍵，使用者無法忍受小小的東西要有開機時間。
      - A cross-compiler and frozen bytecode, to have pre-compiled scripts that don't take any RAM (except for any dynamic objects they create) 上傳的程式要先 pre-compile?? 跟 [cross compiler](https://github.com/micropython/micropython/blob/master/mpy-cross/) 有關??
      - Multithreading via the "_thread" module, with an optional global-interpreter-lock (still work in progress, only available on selected ports) 支援 asyncio 嗎? => `micropython-lib` 下有 `asyncio`、`asyncio_slow`、`uasyncio` 及 `cpython-uasyncio` #ril
      - Inline assembler (currently Thumb and Xtensa instruction sets only) 在 Python 裡直接寫組語，不是寫成 C libary 來解效能的問題? => 還是有 [`uctypes`](http://docs.micropython.org/en/latest/library/uctypes.html) 套件；這讓 MicroPython 通吃 Python/C/ASM 高中低三個層級。
  - [MicroPython and the European Space Agency \- MicroPython Forum](https://forum.micropython.org/viewtopic.php?t=744) (2015-06-10) Viktoriya Skoryk (Director, George Robotics Limited.) 公佈 European Space Agency (ESA 歐洲太空總署) 將評估 MicroPython 在 space-based application 的適用性，投入資源讓 MicroPython 在 critical embedded system 上更穩定，之後也會回饋到 MicroPython。
  - [FAQ · micropython/micropython Wiki](https://github.com/micropython/micropython/wiki/FAQ) #ril
  - [Performance · micropython/micropython Wiki](https://github.com/micropython/micropython/wiki/Performance) #ril
  - [MicroPython \- Wikipedia](https://en.wikipedia.org/wiki/MicroPython) #ril
  - [Using Scripting Languages in IoT: Challenges and Approaches \| Linux\.com \| The source for Linux information](https://www.linux.com/news/event/elcna/2017/2/using-scripting-languages-iot-challenges-and-approaches) (2017-02-15) #ril

  - [准备挖C/C\+\+墙角的MicroPython到底值不值得学？——pyboard评测 \| 爱板网 \- Part 4](http://www.eeboard.com/evaluation/pyboard/4/) (2017-05-08) 对于微控制器的开发来说，一般很少涉及到上层开发，诸多都如采集数据，做控制等底层开发，虽然 C/C++ 也足矣了，但是多一种选择未尝不可 ... 总之，如果你是个嵌入式行业的从业者，先把 C/C++ 学好，有余力，再学 MicroPython。
  - [简单、方便、快速开发嵌入式实时系统——用MicroPython就对了 \| 爱板网](http://www.eeboard.com/evaluation/micropythonboard/) (2018-02-23) #ril

## 新手上路 ?? {: #getting-started }

  - 很多元件都只提供 C library，若是用 MicroPython，可能得自己用 ctypes 包裝過??
  - [Writing fast and efficient MicroPython \- YouTube](https://www.youtube.com/watch?time_continue=5&v=hHec4qL00x0) (2018-08-24) MicroPython 的開發者 Damien George 現身說法 #ril

## Port

  - [Overview — MicroPython 1\.9\.4 documentation](http://docs.micropython.org/en/latest/) MicroPython runs on a variety of systems and hardware platforms. ... as well as specific information about the various PLATFORMs - also known as ports - that MicroPython runs on. 不同的執行平台稱做 port。
  - [MicroPython port - Glossary — MicroPython 1\.9\.4 documentation](https://docs.micropython.org/en/latest/reference/glossary.html#term-micropython-port) #ril
      - MicroPython supports different boards, RTOSes, and OSes, and can be relatively easily adapted to new systems. MicroPython with support for a particular system is called a “port” to that system.
      - 綜合 "“boardless” ports like Unix port)" 與 "upip runs both on Unix port and on baremetal ports " 的說法，感覺 port 可以粗分為 boardless/baremetal ports 兩種，而 boardless port 指的就是 unix 這種有完整 OS 的執行環境。
  - [MicroPython libraries — MicroPython 1\.9\.4 documentation](https://docs.micropython.org/en/latest/library/index.html) #ril
      - Any particular MicroPython VARIANT or PORT may miss any feature/function described in this general documentation (due to resource constraints or other limitations).
      - Modules specific to a particular MicroPython port and thus not portable.
      - MicroPython is highly configurable, and each port TO A PARTICULAR BOARD/EMBEDDED SYSTEM makes available only a subset of MicroPython libraries. For officially supported ports, there is an effort to either FILTER OUT non-applicable items, or mark individual descriptions with “Availability:” clauses describing which ports provide a given feature. 原來 port 指的就是針對特定 board/embedded system 所安排的 MicroPython configuration。不適合某個 port 的功能就拔除 (或是用文件說明 availability)，就算 MicroPython libraries 也一樣。
  - [micropython/ports at master · micropython/micropython](https://github.com/micropython/micropython/tree/master/ports) 可以看到 `esp8266`、`esp32`、`unix` 等，甚至還有 `windows`。
  - [Boards Summary · micropython/micropython Wiki](https://github.com/micropython/micropython/wiki/Boards-Summary) #ril

## Unix Port, Workflow ??

  - [MicroPython Unix port - Glossary — MicroPython 1\.9\.4 documentation](https://docs.micropython.org/en/latest/reference/glossary.html#term-micropython-unix-port) #ril
      - Unix port is one of the major MicroPython ports. It is intended to run on POSIX-compatible operating systems, like Linux, MacOS, FreeBSD, Solaris, etc. It also serves as the basis of [Windows port](https://github.com/micropython/micropython/tree/master/ports/windows).
      - The importance of Unix port lies in the fact that while there are many different boards, so two random users unlikely have the same board, almost all modern OSes have some level of POSIX compatibility, so Unix port serves as a kind of “COMMON GROUND” to which any user can have access. So, Unix port is used for initial prototyping, different kinds of TESTING, development of MACHINE-INDEPENDENT features, etc. 跟 board/machine 無關的開發、測試工作都可以在 Unix port 上進行；這一點跟 Android 將 unit testing [拆分為跑在本機的 local unit test 與跑在設備上的 instrumented test](https://imsardine.github.io/2017/06/04/io17-tdd-android-with-atsl/) 一樣??
      - All users of MicroPython, even those which are interested only in running MicroPython on MCU systems, are recommended to be familiar with Unix (or Windows) port, as it is important productivity helper and a part of normal MicroPython WORKFLOW. 最佳開發實務是??
  - [Learn Micropython · micropython/micropython Wiki](https://github.com/micropython/micropython/wiki/Learn-Micropython) 最後提到 "If you don't have the pyboard, it is easy to get started on linux machines." 沒有 board 是可以!!
  - [MicroPython \- Python for microcontrollers](https://micropython.org/download) 沒有提供 unix port，要自行編譯? 應該會有 Docker image ... 把開發工具集合起來?
  - [Debian, Ubuntu, Mint, and variants - Getting Started · micropython/micropython Wiki](https://github.com/micropython/micropython/wiki/Getting-Started#debian-ubuntu-mint-and-variants) #ril

        $ sudo apt-get install build-essential libreadline-dev libffi-dev git pkg-config
        $ git clone --recurse-submodules https://github.com/micropython/micropython.git
        $ cd ./micropython/ports/unix
        $ make axtls
        $ make
        $ ./micropython

  - [Developing on a microcontroller · micropython/micropython Wiki](https://github.com/micropython/micropython/wiki/Developing-on-a-microcontroller) #ril
  - [Micro Python on Mac OSX · micropython/micropython Wiki](https://github.com/micropython/micropython/wiki/Micro-Python-on-Mac-OSX) #ril

## Python Language, Standard Library ??

  - [Syntax — MicroPython 1\.9\.4 documentation](http://docs.micropython.org/en/latest/genrst/syntax.html) 在比較 MicroPython 與 CPython 時，出現 uPy 與 CPy 的說法，其中 `uPy` 的 `u` 源自單位符號 [μ (micro)]([Micro\- \- Wikipedia](https://en.wikipedia.org/wiki/Micro-) -- In circumstances in which only the Latin alphabet is available ... allow the prefix `μ` to be substituted by the letter `u`。
  - [Glossary — MicroPython 1\.9\.4 documentation](https://docs.micropython.org/en/latest/reference/glossary.html)
      - CPython is the REFERENCE IMPLEMENTATION of Python programming language ... As there is NO FORMAL SPECIFICATION of the Python language, only CPython documentation, it is not always easy to draw a line between Python the language and CPython its particular implementation. This however leaves more freedom for other implementations. For example, MicroPython DOES A LOT OF THINGS DIFFERENTLY than CPython, while still aspiring to be a Python language implementation. 沒有 spec 可以參考嗎? 宣稱許多地方跟 CPython 不同，感覺有點糟?
      - This documentation is intended to be a reference of the generic APIs available across different ports (“MicroPython core”). Note that some ports may still omit some APIs described here (e.g. due to resource constraints). 所有 port 通用的 API 稱 MicroPython Core，但有些 core API 在某些 port 也可能不能用；因為資源受限。
  - [Learn Micropython · micropython/micropython Wiki](https://github.com/micropython/micropython/wiki/Learn-Micropython)
      - This means that micropython is VERY CLOSE TO python, but is missing a few of the features.
      - Micropython supports SURPRISINGLY LARGE PART OF THE PYTHON LANGUAGE including numeric types, strings, tuples, lists, dictionaries, classes (with inheritance) and many more. However, it's "BATTERIES INCLUDED" philosophy is reduced in order to keep everything small, with the standard library modules being supported in micropython-lib 要把 Python language 與 Python standard library (batteries-included) 分開來看。
  - [MicroPython \- Python for microcontrollers](https://micropython.org/) #ril
      - MicroPython is a lean and efficient implementation of the Python 3 programming language that includes a SMALL SUBSET of the Python standard library and is optimised to run on microcontrollers and in constrained environments. ... 注意完整實作的是 Python 3 LANGUAGE 本身，但 standard library 只是 subset (這一點跟 Java ME 之於 Java SE 的關係很像)；其中 code space 是指 flash??
      - MicroPython aims to be as COMPATIBLE with normal Python as possible to allow you to transfer code with ease from the desktop to a microcontroller or embedded system. ... MicroPython strives to be as compatible as possible with normal Python (known as CPython) so that if you know Python you already know MicroPython. 如果讓 library 的 unit test 也跑過 MicroPython 的環境?? Pyenv 或 Docker 是否支援?
      - MicroPython is a full Python compiler and runtime that runs on the [bare-metal](https://docs.micropython.org/en/latest/reference/glossary.html#term-baremetal). (沒有完整 OS 的系統，而 MicroPython 本身就是帶有 REPL 的 user-facing OS)
      - In addition to implementing a selection of core Python libraries, MicroPython includes modules such as "`machine`" for accessing low-level hardware.
  - [The MicroPython language — MicroPython 1\.9\.4 documentation](http://docs.micropython.org/en/latest/reference/index.html) MicroPython aims to implement the Python 3.4 standard (with SELECTED features from later versions) with respect to language syntax, and most of the features of MicroPython are identical to those described by the “Language Reference” documentation at docs.python.org. 語言的分歧比較小，但 standard library 又是另一回事了；為什麼停在 Python 3.4 ??
  - [What is MicroPython - Home · micropython/micropython Wiki](https://github.com/micropython/micropython/wiki#what-is-micropython) MicroPython is a Python interpreter (with partial native code compilation feature). It provides a subset of Python 3.5 features, implemented for embedded processors and constrained systems. 原來已經支援一些 Python 3.5
  - [MicroPython libraries — MicroPython 1\.9\.4 documentation](https://docs.micropython.org/en/latest/library/index.html)
      - MicroPython implements a SUBSET of Python functionality for each module. Any particular MicroPython variant or PORT may miss any feature/function described in this general documentation (due to resource constraints or other limitations). 如果 standard library 的 module 有提供的話，通常也只是 subset，主要是因為執行環境資源有限。
      - To ease extensibility, MicroPython versions of standard Python modules USUALLY have `u` (“micro”) prefix. 為什麼這跟容易擴充有關? 感覺會不會加 `u` prefix 沒什麼規則?? 例如 `urllib.urequest` 之於 standard library 的 `urllib.request`，跟是否為 C extension 無關，因為 `urllib.urequest` 就是純 Python。
      - There are a few categories of such modules: Modules which implement a subset of standard Python functionality and are NOT INTENDED TO BE EXTENDED BY THE USER. Modules which implement a subset of Python functionality, with a PROVISION FOR EXTENSION BY THE USER (via Python code). Modules which implement MicroPython EXTENSIONS to the Python standard libraries. Modules specific to a particular MicroPython PORT and thus not portable. 為何要區分能否 "extended by the user"?? 這裡的 extension 好像不是專指可以調用 Python API 的 extension module??
      - On some ports you are able to discover the available, built-in libraries that can be imported by entering the following at the REPL: `help('modules')` 例如在 ESP8266 上：

            >>> help('modules')
            __main__          http_client_ssl   sys               urandom
            _boot             http_server       time              ure
            _onewire          http_server_ssl   uasyncio/__init__ urequests
            _webrepl          inisetup          uasyncio/core     urllib/urequest
            apa102            json              ubinascii         uselect
            array             lwip              ucollections      usocket
            btree             machine           uctypes           ussl
            builtins          math              uerrno            ustruct
            dht               micropython       uhashlib          utime
            ds18x20           neopixel          uheapq            utimeq
            errno             network           uio               uzlib
            esp               ntptime           ujson             webrepl
            example_pub_button                  onewire           umqtt/robust      webrepl_setup
            example_sub_led   os                umqtt/simple      websocket
            flashbdev         port_diag         uos               websocket_helper
            framebuf          select            upip
            gc                socket            upip_utarfile
            http_client       ssd1306           upysh
            Plus any modules on the filesystem

      - Beyond the BUILT-IN LIBRARIES described in this documentation, many more modules from the Python standard library, as well as further MicroPython extensions to it, can be found in micropython-lib. 這裡 built-in 是指 MicroPython Core??
      - The following standard Python libraries have been “MICRO-IFIED” to fit in with the philosophy of MicroPython. They provide the core functionality of that module and are intended to be a DROP-IN REPLACEMENT for the standard Python library.
      - Some modules below use a standard Python name, but prefixed with “u”, e.g. `ujson` instead of `json`. This is to signify that such a module is MICRO-LIBRARY, i.e. implements ONLY A SUBSET of CPython module functionality. 原來加 `u` prefix (micro) 是因為只實作 standard library 對應 module 的 subset，稱之為 micro-library。
      - By naming them differently, a user has a choice to write a Python-level module to extend functionality for better compatibility with CPython (indeed, this is what done by the `micropython-lib` project mentioned above). 但為什麼 `micropython-lib` 下還有會 `u` 開頭的 module?? 例如 [`micropython-lib/urllib.urequest`](https://github.com/micropython/micropython-lib/tree/master/urllib.urequest)，而且 `from urllib import request` 會直接丟 `ImportError: no module named 'urllib.request'` 的錯誤，不會 fallback 成 `urllib.urequest`。
      - 以為 `json` ([`micropython-lib/json/json`](https://github.com/micropython/micropython-lib/tree/master/json/json)) 會以 `ujson` ([`micropython/extmod/modujson.c`](https://github.com/micropython/micropython/blob/master/extmod/modujson.c)) 為基礎，但 `json` 的實作卻完全沒用到 `ujson`，感覺 `json` 的原始碼完全抄 CPython，或許實務上應優先用 `ujson`，若真的不夠用才改用 `json`，但 `ujson`/`json` module naming 不同的差異怎麼處理? => `import json` 會自動 fallback 為 `ujson`
      - `time` ([`micropython-lib/time/time`](https://github.com/micropython/micropython-lib/blob/master/time/time.py)) 跟 `utime` ([`micropython/ports/esp8266/modutime.c`](https://github.com/micropython/micropython/blob/master/ports/esp8266/modutime.c)) 就是一個比較好的例子 -- `time` 基於 `utime` 實作完整的 Python standard library `time`；發現 [`utime`](https://docs.micropython.org/en/latest/library/utime.html) 提供了一些 CPython 沒有的 function，例如 `utime.sleep_ms(ms)`、`utime.ticks_ms()` 等，不建議使用嗎? => 用 `import time` 會自動 fallback 回 `utime`。
      - On some embedded platforms, where it may be cumbersome to add Python-level wrapper modules to achieve naming compatibility with CPython, micro-modules are available both by their U-NAME, and also by their NON-U-NAME. The non-u-name can be OVERRIDDEN by a file of that name in your library path (`sys.path`). For example, `import json` will first search for a file `json.py` (or package directory `json`) and load that module if it is found. If nothing is found, it will FALLBACK to loading the built-in `ujson` module. 如果有 fallback 機制，就直接 import 標準的 module name 即可，但

  - [micropython/micropython\-lib: Core Python libraries ported to MicroPython](https://github.com/micropython/micropython-lib) #ril
      - 發現 `ctypes` 不在 `micropython-lib` 裡，而在 [`micropython/extmod/moductypes.c`](https://github.com/micropython/micropython/blob/master/extmod/moductypes.c)；感覺 `micropython-lib` 是純 Python，而 `micropython/extmod` 則是 C extension。
  - [Related Projects - Home · micropython/micropython Wiki](https://github.com/micropython/micropython/wiki#related-projects) - project to develop/port Python standard library for MicroPython 很明顯 micropython/micropython 專注在實作 Python 語言、平台，而 micropython/micropython-lib 則專注在儘可能提供 Python standard library 有的東西。
  - [Differences · micropython/micropython Wiki](https://github.com/micropython/micropython/wiki/Differences) 提到 Differences By Design 的概念 #ril
  - [micropython\-lib · PyPI](https://pypi.org/user/micropython-lib/) 所有套件都會發佈到 PyPI，以 `micropython-*` 為名 #ril
  - [Discussion of Python 3\.6 support · Issue \#2415 · micropython/micropython](https://github.com/micropython/micropython/issues/2415) 對 Python 3.6 的支援討論中 #ril

## Hardware API ??

  - [Hardware API · micropython/micropython Wiki](https://github.com/micropython/micropython/wiki/Hardware-API) #ril
  - [machine — functions related to the hardware — MicroPython 1\.9\.4 documentation](https://docs.micropython.org/en/latest/library/machine.html) #ril

## REPL ??

  - [The MicroPython Interactive Interpreter Mode \(aka REPL\) — MicroPython 1\.9\.4 documentation](http://docs.micropython.org/en/latest/reference/repl.html) #ril

## Filesystem ??

  - [MicroPython \- Python for microcontrollers](https://micropython.org/) Proper Python with hardware-specific modules 提到 "run and import scripts from the built-in FILESYSTEM" 而 Example 6/7 示範了路徑、讀取檔案：

        import os

        # list root directory
        print(os.listdir('/'))

        # print current directory
        print(os.getcwd())

        # open and read a file from the SD card
        with open('/sd/readme.txt') as f:
            print(f.read())

## Packaging ??

  - [Distribution packages, package management, and deploying applications — MicroPython 1\.9\.4 documentation](http://docs.micropython.org/en/latest/reference/packages.html) #ril

## CircuitPython ??

  - [CircuitPython \- Wikipedia](https://en.wikipedia.org/wiki/CircuitPython) MicroPython 的分支，主要開發者是 Adafruit #ril
  - [MicroPython \| CircuitPython Hardware: SSD1306 OLED Display \| Adafruit Learning System](https://learn.adafruit.com/micropython-hardware-ssd1306-oled-display/micropython) #ril
      - In addition to CircuitPython there's an OLDER MicroPython version of the SSD1306 library that you can use with some MicroPython boards. 意思 MicroPython 與 CircuitPython 的 library 不相容? 而且 MicroPython 的版本不再更新??

## Docker / Vagrant (Unix Port) ??

  - Docker 在 container 無法存取 USB device，但 Vagrant 是有機會的；單純要打包 unix port 用 Docker 應該沒問題，但要打包 MicroPython 開發工具 (最後要存取 board)，目前就只能選 Vagrant。

參考資料：

  - [Can I pass through a USB device to a container? - Frequently asked questions \(FAQ\) \| Docker Documentation](https://docs.docker.com/docker-for-mac/faqs/#can-i-pass-through-a-usb-device-to-a-container) Unfortunately it is not possible to pass through a USB device (or a serial port) to a container.
  - [Docker image \- MicroPython Forum](https://forum.micropython.org/viewtopic.php?f=16&t=1880) (2016-05-08) #ril
  - [Code chronicle: Connect a Usb device through Vagrant](http://code-chronicle.blogspot.com/2014/08/connect-usb-device-through-vagrant.html) #ril
  - [Connect USB from Virtual Machine using Vagrant and Virtual Box \- Nguyen Sy Thanh Son](https://sonnguyen.ws/connect-usb-from-virtual-machine-using-vagrant-and-virtualbox/) #ril
  - [Getting a USB device to show up in a Docker container on OS X](https://gist.github.com/stonehippo/e33750f185806924f1254349ea1a4e68) #ril

## 參考資料 {: #reference }

  - [MicroPython](https://micropython.org/)
  - [micropython/micropython - GitHub](https://github.com/micropython/micropython)
  - [micropython/micropython-lib](https://github.com/micropython/micropython-lib) ([PyPI](https://pypi.org/user/micropython-lib/))

社群：

  - [MicroPython Forum](https://forum.micropython.org/)

文件：

  - [MicroPython Documentation](http://docs.micropython.org/)
  - [Wiki - micropython/micropython - GitHub](https://github.com/micropython/micropython/wiki)
  - [MicroPython Wiki](http://wiki.micropython.org/)

書籍：

  - [Programming with MicroPython - O'Reilly](http://shop.oreilly.com/product/0636920056515.do) (2017-04)
  - [超圖解 Python 物聯網實作入門 - 使用 ESP8266 與 MicroPython - 旗標](http://www.flag.com.tw/books/product/FT797) (2018-05)
  - [MicroPython 入門指南 - 電子工業出版社](https://www.tenlong.com.tw/products/9787121328466)

更多：

  - [Networking](micropython-networking.md)
  - [OTA Update](micropython-ota.md)

相關：

  - [ESP8266](micropython-esp8266.md) - MicroPython 官方直接提供 ESP8266 的韌體
  - [Python](python.md)

手冊：

  - [Python Module Index](http://docs.micropython.org/en/latest/py-modindex.html)
  - [Glossary](https://docs.micropython.org/en/latest/reference/glossary.html)
