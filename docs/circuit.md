# Circuit 電路

  - [Electrical network \- Wikipedia](https://en.wikipedia.org/wiki/Electrical_network) #ril
  - [Electronic circuit \- Wikipedia](https://en.wikipedia.org/wiki/Electronic_circuit) #ril

## 新手上路 ?? {: #getting-started }

  - [零基礎電路學 - YouTube](https://www.youtube.com/watch?v=mH-XUGkNohM&list=PLpsrnaNcZIbk0I2XP3Tme7_9eH70qnf79) #ril

## Passive Sign Convention (PSC) ??

  - [電路學1：Passive sign convention (被動符號通則)講解 (ZC001) \- YouTube](https://www.youtube.com/watch?v=mH-XUGkNohM&list=PLpsrnaNcZIbk0I2XP3Tme7_9eH70qnf79) 電流從正極流出為 "供電"，從正極流入為 "用電" #ril
  - [電路學3：Passive sign convention (被動符號通則)講解 2 (ZC003) \- YouTube](https://www.youtube.com/watch?v=ISjQ3_-UouY&index=3&list=PLpsrnaNcZIbk0I2XP3Tme7_9eH70qnf79) 用手機簡化的電路說明，為何有越充電量越少的狀況 #ril
  - [Passive sign convention \- Wikipedia](https://en.wikipedia.org/wiki/Passive_sign_convention) #ril

## Kirchhoff's Circuit Law (KCL) ??

  - [電路學2：KCL克希荷夫電流定律講解(ZC002) \- YouTube](https://www.youtube.com/watch?v=5nwpL-qBXXc&index=2&list=PLpsrnaNcZIbk0I2XP3Tme7_9eH70qnf79) 某一節點，流入的總和，等於流出的總和；一個都不能少 #ril
  - [Kirchhoff's current law (KCL) - Kirchhoff's circuit laws \- Wikipedia](https://en.wikipedia.org/wiki/Kirchhoff%27s_circuit_laws#Kirchhoff's_current_law_(KCL)) #ril

## Kirchhoff's Voltage Law (KVL) ??

  - [電路學4：KVL克希荷夫電壓定律1 (ZC004) \- YouTube](https://www.youtube.com/watch?v=ZftUPsEx-dw&list=PLpsrnaNcZIbk0I2XP3Tme7_9eH70qnf79&index=4) #ril
      - 多次提到 "電壓極性"，每個元件不一定方向相同，這時候 passive sign convention 就能派上用場；當電流由負走到正 (由正極出為供電) 電壓會上昇，反之當電流由正走到負 (由正極入為用電) 電壓會下降；但為什麼電阻會增壓/供電??
      - KVL 從某一節點遶一個迴路 (順時針或逆時針都沒差)，V 昇 == V 降 的關係成立。
      - 12：50 算出元件 -9V，為何可以改變 "電壓極性"，說等同於 +9V ??
  - [電路學5：KVL克希荷夫電壓定律2 (ZC005) \- YouTube](https://www.youtube.com/watch?v=4OjKrM8FxFE&index=5&list=PLpsrnaNcZIbk0I2XP3Tme7_9eH70qnf79) #ril
  - [Kirchhoff's voltage law (KVL) - Kirchhoff's circuit laws \- Wikipedia](https://en.wikipedia.org/wiki/Kirchhoff%27s_circuit_laws#Kirchhoff's_voltage_law_(KVL)) #ril

## 串聯、並聯 ??

  - [Series and Parallel Circuits - YouTube](https://www.youtube.com/watch?v=x2EuYqj_0Uk&list=PL253772980E9A0F88) 用 PhET 的 Circuit Construction Kit (DC Only) 比較串聯 (serial circuit) 與並聯 (parallel circuit)，串聯的特性每一個點的電流都跟電池輸出的電流一樣，但電壓是每經過一些電組就會掉一些。並聯的特性是，每個分支的電流加總起來等於分支前的電流，而平行的 branch/loop 間，兩側的電壓是相同的，一樣走過所有電阻後降到 0V。

## Short Circuit 短路 ??

  - [日常生活中的物理現象:電池短路時的電流？](http://www.phy.ntnu.edu.tw/demolab/phpBB/viewtopic.php?topic=18284) 原來電池有內電阻 #ril
  - [Voltage, Current and Resistance - YouTube](https://www.youtube.com/watch?v=J4Vq-xHqUo8&list=PL253772980E9A0F88) 02:52 把電池短路，提到在 lab 裡會有火花，也可能讓電池爆炸。

## Simulation 模擬電路 ??

  - [Voltage, Current and Resistance - YouTube](https://www.youtube.com/watch?v=J4Vq-xHqUo8&list=PL253772980E9A0F88) 提到 PhET: Free online physics, chemistry, biology, earth science and math simulations https://phet.colorado.edu/ 搜尋 circuit 可以找到 Circuit Construction Kit (DC Only)；雖已被列為 legacy simulation，下載 `circuit-construction-kit-dc_en.jnlp`，用 `javaws` 還是可以執行的，善用 voltmeter 與 (non-contact) ammeter 來量測不同位置的電壓或電流。
  - [Lushprojects.com - www.lushprojects.com - Circuit Simulator](http://lushprojects.com/circuitjs/) 馬上看得到電流在動
  - [Online circuit simulator & schematic editor - CircuitLab](https://www.circuitlab.com/) 有點太專業，不知道怎麼開始... #ril
  - [List of free electronics circuit simulators \- Wikipedia](https://en.wikipedia.org/wiki/List_of_free_electronics_circuit_simulators) #ril

## Source Current 源流, Sink Current 潛流 ??

  - [學著愛人、學著愛己: Arduino 第二課 \- 跑馬燈](http://linchinghui.blogspot.com/2014/08/arduino.html) (2014-08-12) #ril
  - [第36回 「SINK、SOURCE是什麼呢？」](https://www.orientalmotor.com.tw/teruyo_det/teruyo_36/) #ril
  - [半工室 Arduino Python NodeMCU: 《進階※電子電路篇》寫程式Arduino教學 \- 03：MCU I/O Sink current & Source current 是什麼? Arduino 總電流最大?](http://wyj-learning.blogspot.com/2017/11/arduino-05mcu-io-sink-current-source.html) (2017-11-01) #ril

## Common Ground 共同接地 ??

  - [The Importance of Sharing Grounds \| Majenko's Hardware Hacking Blog](https://hackingmajenkoblog.wordpress.com/2016/12/06/the-importance-of-sharing-grounds/) (2016-12-06) 有多個電源供應時，就要注意有共同接地，因為電壓是相對的 #ril
  - Arduino Project Book #9 Motorized Pinwheel 馬達由外部 9V 電池提供動力，跟 Arduino 自己的電源之間用一條導線，將兩邊的 GND 連接起來 #ril

## 參考資料 {: #reference }

更多：

  - [Circuit Diagram 電路圖](circuit-diagram.md)

相關：

  - [Current 電流](current.md)
  - [Resistor 電阻](resistor.md)
  - [Multimeter 三用電錶](multimeter.md)
