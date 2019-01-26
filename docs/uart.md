# UART (Universal Asynchronous Receiver/Transmitter)

  - UART 唸做 [u-art]，全名是 The Universal Asynchronous Receiver/Transmitter。
  - 是個抽象介面，而 RS-232 是其中一種實現 -- 只允許兩個裝置對接。
  - 線路簡單，只有 TX 與 RX 兩條。

參考資料：

  - [Universal asynchronous receiver\-transmitter \- Wikipedia](https://en.wikipedia.org/wiki/Universal_asynchronous_receiver-transmitter) #ril
  - [UART \- 維基百科，自由的百科全書](https://zh.wikipedia.org/wiki/UART) #ril
  - [\[通訊技術\]RS232與UART的差別\-最原始的通訊介面原來長這樣 – 實作派電子實驗室](https://www.strongpilab.com/?p=1328) (2017-09-07) 單晶片這邊只有 UART? UART 只有 TX/RX 兩條線，RS-232 其他訊號線都是用來做 handshake 之用，不在晶片的 UART 模組中。
  - [1. UART - 【Maker進階】認識UART、I2C、SPI三介面特性 \| Building Maker Economy：自造達人社群/媒體/平台](https://makerpro.cc/2016/07/learning-interfaces-about-uart-i2c-spi/) (2016-07-12) UART 只是個抽象介面，RS-232 是其中一個具體實現 - 只允許兩個裝置對接，好處是線路簡單 (圖1 把 Tx 與 Rx 兩條線路框起來標示為 UART)，通常最高速為 115.2 kbps。
  - [Back to Basics: The Universal Asynchronous Receiver/Transmitter (UART)](https://www.allaboutcircuits.com/technical-articles/back-to-basics-the-universal-asynchronous-receiver-transmitter-uart/) (2016-12-20) #ril

## USB-to-UART ??

  - 單晶片通常提供 UART 介面 (TX/RX)，可以用 RS-232 連接。
  - 若電腦沒有 RS-232，就需要 USB-to-UART 晶片轉接。

參考資料：

  - [【說文解字】認識UART通用非同步收發器 \| Building Maker Economy：自造達人社群/媒體/平台](https://makerpro.cc/2016/04/understand-what-is-uart/) (2016-04-15) Arduino 上的 UART 規劃成 RS-232 的一對一連接，若電腦沒有 COM/RS-232，就要透過 USB-to-UART 晶片介接，所以原先支援 COM 的軟體 (例如 PuTTY) 可以繼續作用。
  - [1. UART - 【Maker進階】認識UART、I2C、SPI三介面特性 \| Building Maker Economy：自造達人社群/媒體/平台](https://makerpro.cc/2016/07/learning-interfaces-about-uart-i2c-spi/) (2016-07-12) 現在的電腦沒有 RS-232，要透過 UART 轉 USB 的電路，才能讓 Arduio 與電腦連接。
  - [Introduction - I am getting “espcomm\_sync failed” error when trying to upload my ESP\. How to resolve this issue? — ESP8266 Arduino Core 2\.4\.0 documentation](https://arduino-esp8266.readthedocs.io/en/latest/faq/a01-espcomm_sync-failed.html#id1) 看起來 NodeMCU V1 用 CP2102 晶片，而 NodeMCU V2 跟 WeMOS D1 都用 CH340G 晶片。
  - [Getting Started with ESP8266 Development on the Mac \| lost\+found](http://blog.dushin.net/2016/07/getting-started-with-esp8266-development-on-the-mac/) 作者採用 [USB to UART Bridge VCP Drivers \| Silicon Labs](https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers)，尤其 driver 是 sign 過的，值得信任。接上電腦後就能看到 `/dev/tty.SLAB_USBtoUART/`。
  - [adrianmihalko/ch340g\-ch34g\-ch34x\-mac\-os\-x\-driver: CH340G CH34G CH34X Mac OS X driver](https://github.com/adrianmihalko/ch340g-ch34g-ch34x-mac-os-x-driver) OEM driver 連結指向 [江苏沁恒股份有限公司](http://www.wch.cn/)，不過裝置出現在 `/dev/tty.wchusbserial1420` 而非文件上所說的 `/dev/cu.wchusbserial1410` 或 `/dev/cu.wchusbserial1420` #ril
  - [How to use cheap Chinese Arduinos that come with with CH340G / CH341G Serial/USB chip (Windows & Mac OS\-X) · by Konstantin Gredeskoul (@kig)](https://kig.re/2014/12/31/how-to-use-arduino-nano-mini-pro-with-CH340G-on-mac-osx-yosemite.html) (2014-12-31) #ril
  - [CH340 Drivers for Windows, Mac and Linux](https://sparks.gogo.co.nz/ch340.html) #ril

## Adafruit USB to TTL Serial Cable ??

  - [USB to TTL Serial Cable \- Debug / Console Cable for Raspberry Pi ID: 954 \- $9\.95 : Adafruit Industries, Unique & fun DIY electronics and kits](https://www.adafruit.com/product/954) Power pin 提供 5V，而 RX/TX pin 則提供 3.3V #ril

