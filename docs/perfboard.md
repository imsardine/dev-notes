# Perfboard 洞洞板

  - 洞洞板正式的名稱為 [Perfboard](https://www.google.com/search?q=perfboard&tbm=isch)，由於它配置的自由度很高 (所有孔洞都是獨立的) 適合做原型，所以也稱做 [Protoboard](https://www.google.com/search?q=protoboard&tbm=isch) 或 [Universal Board](https://www.google.com/search?q=universal+board&tbm=isch)；常用在 PCB 原型的試驗，所以常跟 "PCB Prototyping" 的說法一起出現。
  - 洞洞板還有其他名稱，所以網路賣家會把全部的說法都用上，例如 "電木板 / 洞洞板 / 萬用板 / 電路板 / PCB 板 / 實驗板"，其中 "電木" 只是一種材質，另外還有合成樹脂、玻璃纖維等。
  - 洞洞板跟 PCB 印刷電路板的差別在於，PCB 的電路是印上去的 (可以多層)，而洞洞板的電路是手動配置的；兩者的電子元件都要另外焊接，但因為 PCB 因為沒有孔洞 (要另外鑽)，線路較精細，通常會搭配 黏著元件 (service mount device)，而洞洞板因為有孔洞，通常會搭配直插式元件。

---

參考資料：

  - [Perfboard \- Wikipedia](https://en.wikipedia.org/wiki/Perfboard)
      - Perfboard is a material for PROTOTYPING electronic circuits (also called DOT PCB). It is a thin, rigid sheet with holes pre-drilled at standard intervals across a grid, usually a square grid of 0.1 INCHES (2.54 mm) spacing. "DOT PCB" 這說法有 "洞洞板" 的影子，間隔 0.1 inch (2.54 mm)。
      - These holes are ringed by round or square COPPER PADs, though BARE BOARDs are also available. Inexpensive perfboard may have pads on only one side of the board, while better quality perfboard can have pads on both sides (plate-through holes). 為什麼雙面都有 (copper) pad 的比較好?? 確實有些洞洞板完全沒有焊點，要自己用金屬線接起來。
      - Since each pad is ELECTRICALLY ISOLATED, the builder makes all connections with either [wire wrap](https://www.google.com/search?q=wire+wrap+circuit&tbm=isch) (繞接) or miniature [point to point wiring](https://www.google.com/search?q=point-to-point+wiring&tbm=isch) (點對點接線) techniques.
      - The substrate is typically made of paper laminated with phenolic resin (such as FR-2) or a fiberglass-reinforced epoxy laminate (FR-4). 合成樹脂、玻璃纖維
      - The 0.1 inches (2.54 mm) grid system accommodates integrated circuits in DIP packages (積體電路的雙列直插封裝) and many other types of through-hole components. Perfboard is not designed for prototyping SURFACE MOUNT devices (黏著元件).
      - Circuits assembled on perfboard are not necessarily fragile but may be less impact-resistant than printed circuit boards. 許多電器還是走 perfboard，不一定會用 PCB 印刷電路板吧?
      - Perfboard differs from stripboard in that each pad on perfboard is isolated. Stripboard is made with rows of copper conductors that form DEFAULT CONNECTIONS, which are broken into isolated segments as required by SCRAPING THROUGH THE COPPER. This is similar to the pattern of default connections on a solderless breadboard. However, the absence of default connectivity on perfboard gives the designer more FREEDOM in positioning components and lends itself more readily to software-aided design than stripboard or breadboard. 清楚解釋了 perfboard 跟 stripboard/breadboard 的差異，perfboard 最大的優點在於沒有對線路的安排做任何假設 -- 所有的孔洞都是獨立的 (雖然 stripboard 也可以把銅質刮除)，容易實現 EDA 設計出來的電路。

  - [如何使用洞洞板 \- Make 國際中文版 > DIY Projects, Inspiration, How\-tos, Hacks, Mods & More @ Makezine\.com\.tw \- Tweak Technology to Your Will](http://www.makezine.com.tw/476-2/) (2016-11-18) #ril

  - [Perfboard – A Darker View](http://darkerview.com/wordpress/?p=21795) (2017-06-30) #ril

  - [best practice \- How to make traces on an universal PCB? \- Electrical Engineering Stack Exchange](https://electronics.stackexchange.com/questions/55236/) 出現 universal PCB、protoboard 等不同的說法；有些 protoboard 已安排好 bus lines，會省下不少工 #ril

  - [Practical Electronics/perfboard \- Wikibooks, open books for an open world](https://en.wikibooks.org/wiki/Practical_Electronics/perfboard) #ril
      - There are many types of "PERFORATED prototyping board". 原來 perfboard 的 perf 是 perforated (有排孔的) 的縮寫。
      - The vast majority of such boards are perforated at 10 holes per inch both horizontally and vertically (also called "tenth inch spacing"), made out of either "synthetic resin bonded paper" or fiberglass, and have some kind of copper pattern on one or both sides of the board. 在 1 inch 裡鑽 10 個孔，也就是間距 2.54 mm，板上會有銅質的圖樣。
      - Perhaps the most popular pattern is "STRIPBOARD" -- which has wide strips of copper running one way all the way along one side of the board, but no copper on the other side.

## 新手上路 ?? {: #getting-started }

  - [How to Prototype Without Using Printed Circuit Boards: 8 Steps](https://www.instructables.com/id/How-to-Prototype-Without-Using-Printed-Circuit-Boa/) #ril
  - [Breadboard to Perfboard: 4 Steps \(with Pictures\)](https://www.instructables.com/id/Breadboard-to-Perfboard/) #ril

## Planning ??

  - [Perfboard \- Wikipedia](https://en.wikipedia.org/wiki/Perfboard)
      - Before building a circuit on perfboard, the locations of the components and connections are typically planned in detail on paper or with software tools (electronic design automation, EDA). Small scale prototypes, however, are often built ad hoc, using an OVERSIZED perfboard. 沒有設計過，空間運用的效率會較差。
      - Software for PCB LAYOUT can often be used to generate PERFBOARD LAYOUTs as well. In this case, the designer positions the components so all leads fall on intersections of a 0.1 inches (2.54 mm) grid. When routing the connections more than 2 copper layers can be used, as multiple overlaps are not a problem for insulated wires. 顯然 PCB layout 與 perboard layout 不同，後者要考量洞洞板 2.54 mm 的間距，其中 "more than 2 copper layers" 應該是印刷電路才有的東西，但洞洞板上用絕緣的電線交錯還是可以達成。

## Wiring 接線 ??

  - [Perfboard \- Wikipedia](https://en.wikipedia.org/wiki/Perfboard) #ril
      - One school of thought is to make as many connections as possible WITHOUT ADDING EXTRA WIRE. This is done by bending the existing leads on resistors, capacitors, etc. into position, trimming off extra length, and soldering the lead to make the required electrical connection. Another school of thought refuses to bend the excessive leads of components and use them for wiring, on the ground that this makes REMOVING A COMPONENT LATER HARD or impossible, e.g. when a repair is needed. 有些人主張少用導線，所以會折彎電子元線的接腳當做導線使用，但有些人反對這麼做，因為會增加之後移除元件的困難度。
      - If extra wires need to be used, or are used for principal reasons, they are typically ROUTED ENTIRELY ON THE COPPER SIDE of perfboards, because, as opposed to stripboards, nearby holes aren't connected, and the only hole in a pad is already occupied by a component's lead. Wires used range from isolated wires, including [VEROWIRE](https://www.google.com/search?q=verowire&tbm=isch) (enameled copper wire with a polyurethane insulation supposed to melt when soldered 焊點的絕緣會自動熔掉?), to bare copper wire, depending on individual preference, and often also on what is currently at hand in the workshop. 線路只會在印有焊盤的那邊走，主要分絕緣與不絕緣兩種；verowire 在台灣好像買不到?? 裸銅線沒有絕緣感覺不實用，但其實不然...
      - For insulated wires thin SOLID CORE wire with temperature-resistant insulation such as [KYNAR](https://www.google.com/search?q=kynar+wire&tbm=isch) or [TEFZEL](https://www.google.com/search?q=tefzel+wire&tbm=isch) is preferred. The wire gauge is typically 24 - 30 AWG. A special stripping tool (剝線器) can be used, incorporating a thin steel blade with a slit that the wire is simply inserted into and then pulled loose, leaving a clean stripped end. This wire was developed initially for circuit assembly by the WIRE WRAP technique but also serves well for miniature POINT-TO-POINT WIRING on perfboard. 原設計用在 wire wrap 的 Kynar/Tefzel Wire 可以拿來做 point-to-point wiring，線徑介於 24 ~ 30 AWG，搭配剝線器去掉外皮。
      - Bare copper wire is useful when merging a number of connections to form an ELECTRICAL BUS such as the circuit's ground, and when there is enough space to properly route connections, instead of wiring them [rats-nest style](https://www.google.com/search?q=rats-nest+wiring&tbm=isch). 裸銅線可以用來架匯流排 (electrical bus)，例如共接地線。
      - Intentional SOLDER BRIDGEs (錫橋) can be used to connect adjacent pads when necessary. Careful hand–eye coordination is needed to avoid causing inadvertent short circuits. 有時 solder bridge 是必要的，畢竟不像 stripboard 已經幫忙連通。

  - [How to Prototype Without Using Printed Circuit Boards: 8 Steps](https://www.instructables.com/id/How-to-Prototype-Without-Using-Printed-Circuit-Boa/) Step 1: What You'll Need 邊邊的金手指用金屬線連接起來，電路上的藍線會走過來 (GND)，應該是共同接地 #ril
  - [PCB Prototyping With Verowire: 6 Steps](https://www.instructables.com/id/PCB-Prototyping-With-Verowire/) #ril
  - [BugWorkShop \- 甲蟲工作室: 萬用板繞線專用線（Wire\-wrapping Wire）選擇](http://bugworkshop.blogspot.com/2018/06/wire-wrapping-wire.html) (2018-06-14) 用繞線專用線焊接? #ril
  - [技术资料：Wire\-wapping 线的使用方法介绍 \(amoBBS 阿莫电子论坛\)](https://www.amobbs.com/thread-681125-1-1.html) (2006-10-22)
      - Wire-wrapping 線也叫 OK 線；Wire Wrapping Hand Tools 具有剝線、繞線、拆線三種功能。
      - 繞接也是一種 "無錫焊接法"。與錫焊相比，繞線具有方便、可靠和經濟等優點 ... 用電動繞接器對單股實心裸導線施加一定的拉力，並按規定的圈數緊密地繞在帶有棱邊的接線柱上，使導線與接線柱形成緊密連接，以達到可靠的電氣連接目的。

## 參考資料 {: #reference }

相關：

  - [Soldering 焊接](soldering.md)
