# LED (Light-Emitting Diode) 發光二極體

## 新手上路?? {: #getting-started }

  - [【LazyTomato】Arduino \#6 \- LED 與電阻的必學之術！ \- YouTube](https://www.youtube.com/watch?v=cWEJMusT-hI) (2016-12-04)
      - 00:30 用 LED + 220 ohm 電阻示範；長腳為陽極 (anode)，是電流流入的地方，短腳為陰極 (cathode)，接往低電位的方向，只要提供 "適當的電壓" 及 "足夠的電流" 就能被點亮。
      - 00:50 千萬不能將 LED 直接接上 5V 電源，否則會產生 "過大的電流" 導致 LED 燒毀；保險的做法是在 "陰極" 的線路上加一個 220 ohm 電阻以限制流經 LED 的電流。
      - 01:25 之前用第 13 腳控制 Arduino 板子上的 LED 並沒有加電阻? 事實上限流電阻已經內建在電路板上；電路圖看來，電阻是放在陽極的線路上??

## 慣用 220Ω 電阻 ??

  - [葉難: Arduino小知識：為什麼LED需要串聯的電阻值是220 ohm？](http://yehnan.blogspot.com/2012/03/arduinoled220-ohm.html) (2012-03-05) #ril
      - 一般 LED 的 forward voltage 是 2V ~ 2.5V，而 forward current 約 20mA ~ 30mAi (0.02A)；不同 LED 的規格不同，要查閱資料表 (datasheet)。
      - 以 Arduino 的 5V 腳位為例，而 LED 的 voltage drop 為 2V，所以電阻兩端的電壓是 3V，利用 "電路上各處的電流皆相同" 的原理，我們希望流經 LED 的電流控制在 0.02A，所以電阻 R = V / I = 3 / 0.02 = 150Ω，為了保險起見，會選擇大一點的 220Ω。 => 這時候流經 LED 的電流為 I = V / R = 3 / 200 = 0.015A = 15mA。

## 參考資料 {: #reference }

  - [Resistor 電阻](resistor.md)
