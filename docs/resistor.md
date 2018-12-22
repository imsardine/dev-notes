# Resistor 電阻

## 電阻的種類?

  - Resistors - learn.sparkfun.com https://learn.sparkfun.com/tutorials/resistors/types-of-resistors 各式各樣的電阻 #ril
  - BugWorkShop - 甲蟲工作室: 電阻封裝規格（Resistor Packing Specification） (2014-03-31) http://bugworkshop.blogspot.tw/2014/03/resistor-packing-specification.html 直插式 (through-hole) 與貼片式 (surface) 電阻 #ril

## 色環電阻的色碼 (Color Code) ??

  - 幫助記憶色碼的方式是去掉前面的 Black (0)、Brown (1) 及後面的 Gray (8)、White (9)，中間剛好是彩虹的 6 個顏色 (少了靛色)，分別表示 2 ~ 7 與 10^2 ~ 10^7。

參考資料：

  - [【LazyTomato】Arduino \#6 \- LED 與電阻的必學之術！ \- YouTube](https://www.youtube.com/watch?v=cWEJMusT-hI) (2016-12-04) 02:00 說明色環電阻的讀法
      - 常見的色環電阻有 4 個色環，把金色放右邊，由左而右分別是 第一位數、第二位數、倍率、容許誤差。
      - 顏色的口訣為 "黑棕 紅橙黃綠藍紫 灰白"，分別對應 0 ~ 9 的數字，另容許誤差有 2 個專用的顏色 -- 金 (±5%)、銀 (±10%)
  - Arduino Projects Book p41 HOW TO READ RESISTOR COLOR CODES - Resistor values are marked using colored bands, according to a code developed in the 1920s, when it was too difficult to write numbers on such tiny objects. Each color corresponds to a number, like you see in the table below. Each resistor has either 4 or 5 bands. In the 4-band type, the first two bands indicate the first two digits of the value while the third one indicates the number of zeros that follow (technically it represents the power of ten). The last band specifies the tolerance: in the example below, gold indicates that the resistor value can be 10k ohm plus or minus 5%.

    因為元件太小無法直接標示，色環可能有 4 到 5 個，扣除倒數第一個色環表示誤差值 (通常是金色或銀色)，倒數第 2 個色環表示 10 的 N 次方，其餘的 2 ~ 3 個色環就是基底。

    例如 "棕黑橘金" (4 個色環) 表示 1 (棕) 0 (黑) x 10 ^ 3 (橘) ±5% (金)，也就是 10000Ω ±5%。而 "棕黑黑紅金" 表示 1 (棕) 0 (黑) 0 (黑) x 10 ^ 2 (紅) ±5%，也就是 10000Ω ±5%，兩者的電阻值是一樣的。

  - [Resistor Color Codes \| learn\.parallax\.com](https://learn.parallax.com/support/reference/resistor-color-codes) #ril
  - [Resistors \- learn\.sparkfun\.com](https://learn.sparkfun.com/tutorials/resistors/decoding-resistor-markings) 清楚說明了色碼的判讀、從哪邊開始讀起、記憶方式等 #ril

## Equivalent Resistance 等效電阻 ??

  - [物理教學影片]範例:等效電阻 - YouTube https://www.youtube.com/watch?v=Zga1YVbU3Gg 將電路重新畫過，比較容易看出哪些是串聯、並聯，接下來串聯、並聯套用不同的算法，一一解開。
  - 第一次在 https://zh.wikipedia.org/wiki/%E4%B8%A6%E8%81%AF%E9%9B%BB%E8%B7%AF 在電阻器提到 "等效電阻"，公式為 1/Req = 1/R1 + 1/R2 + 1/R3 ... #ril
  - Resistors in Series and Parallel Resistor Combinations http://www.electronics-tutorials.ws/resistor/res_5.html #ril
  - Equivalent Resistance Theory http://www.calvin.edu/~svleest/circuitExamples/equRes/theory.htm 正確地判斷串聯電阻、並聯電阻 #ril
  - Equivalent Resistance Circuit Examples http://www.calvin.edu/~svleest/circuitExamples/equRes/ 練習題 #ril

## Floating, Pull-up Resistor 上拉電阻

  - Hardware 101 | Android Things https://developer.android.com/things/hardware/hardware-101.html 在 VCC/GND 與 input pin 間擺一個 resistor，可以 stable default state (沒有接其他裝置，只接 VCC/GND 時)，什麼都沒接會處於 floating，易受到電磁干擾 (EMI)，若裝置內有機構 (mechanical component)，在機械動作 (mechanical motion) 停下來之前，signal value 可能會來回游移不定 (oscillate) 或彈回 (bounce)，從 app 的角度來看，會在短時間內產生多個 input event。從軟體可以給一個 time delay，預期幾百 ms 內 value 可以穩定下來；從硬體則可以在 input pin 與 device/peripheral 間加一個 RC circuit (resistor + capacitor)，延遲讓 input pin 看到 value 轉變的時間。
  - Pull Up Resistors and Buttons | AddOhms #15 - YouTube https://www.youtube.com/watch?v=wxjerCHCEMg 用儀器觀察 input pin 的讀值會跳動 (floating pin) 是因為電磁干擾 (EMI)，在 VCC 與 input pin 間加個 resistor 就不會有這個問題，在 button 沒按下前，input pin 會讀到 high (接近 VCC)，按下 button 後，電會流往 GND，此時 input pin 會讀到 low (接近 GND)；許多 MCU 包括 Arduion 內建 pull-up resistor，只要將程式碼從 `pinMode(pin, INPUT)` 改成 `pinMode(pin, INPUT_PULLUP)` 即可。
  - Electronics 201: Pull-Up and Pull-Down Resistors - YouTube https://www.youtube.com/watch?v=BxA7qwmY9mg 3 state gate/buffer，除了 logic ON/OFF，還有 disconnected，也就是 floating (BAD)，加上 pull-up/pull-down resistor 即可 (同樣的 resistor，只是接法不同) 即可。提到 MCU 有 pin's impedance (不會太低，以確保不會耗電)；許多 MCU 都內建 pull-up resistor 沒得選擇?
  - Pull-up Resistors - learn.sparkfun.com https://learn.sparkfun.com/tutorials/pull-up-resistors 也有提到 impedance，選擇 pull-up resistor 的電阻值時，要兼顧 switch ON/OFF 兩種狀態，大概是 pin impedance (100k-1MΩ) 的 1/10，也就是 10kΩ 以下，但也不要太小，否則 button 按下去時會流失太多電流。

  - Pull-up Resistor and Pull-down Resistor Explained http://www.electronics-tutorials.ws/logic/pull-up-resistor.html #ril
  - Pull up resistor / Pull down resistor » Resistor Guide http://www.resistorguide.com/pull-up-resistor_pull-down-resistor/ #ril
  - Pull-up resistor - Wikipedia https://en.wikipedia.org/wiki/Pull-up_resistor #ril
  - 上拉電阻 - 維基百科，自由的百科全書 https://zh.wikipedia.org/wiki/%E4%B8%8A%E6%8B%89%E7%94%B5%E9%98%BB #ril

## 為什麼 pull-up resistor 電阻值小就是 strong? 電阻值大就是 weak?

  - Hardware 101 | Android Things https://developer.android.com/things/hardware/hardware-101.html 提到 pull-up resistor 的電阻值小就是 strong pull-up，電阻值小是 weak pull-up，說跟 current 的大小有關? 但 pull-up resistor 跟 pull-down resistor 不是在拉升 (或下拉) 電壓的嗎? https://learn.sparkfun.com/tutorials/pull-up-resistors 也出現這種說法。
  - Strong pull-up 從字面上來看，感覺比較像是可以把 voltage 拉升到更為貼近 VCC；由於 pull-up resistor 跟 input pin 背後的 impedance 成串聯，所以 pull-up resistor 的電阻越小，pin impedance 分配到的電位差就越多，越能接近 VCC 而被視為 HIGH，這樣的解釋還滿直覺的。
  - 就 strong pull-down 而言，上面的說法就不太適用，因為 pull-down resistor 與 pin impedance 成並聯，兩邊的電阻值不會影響電位差。看來從 current 來判斷 strong/weak 的適用性比較高。

## 為什麼 pull-up resistor 在 button 按下去時，input pin 會讀到 low?

  - 這時候不是並聯，電壓都一樣嗎? 莫非電壓是 0?
  - 可能跟等效電阻的計算有關
      - 因為 1/Req = 1/R1 + 1/R2 = (R2 + R1) / (R1 x R2)，假設 input pin 裡的 R2 是 10 ohm (R1 只有導線，理想上是 0 ohm)，所以等效電阻是 (10 + 0) / (10 x 0) = 1 / 0 ... 所以 Req 是 0
      - 若等效電阻是 0，自然就不會走有電阻的那邊... V = I x R (0)，所以這一段兩端不會有電位差。按照電壓分配的原則，過了 pull-up resistor 後，電位已經降到 0。
      - 為什麼電流只往導線走? I = V / R，就 R2 而言，I = 0 / 10 = 0，但就導線而言，I = 0 / 0 = 無限大?

## Resister Pack 排阻 ??

  - [Resistor Networks \| RS Components](https://uk.rs-online.com/web/c/passive-components/fixed-resistors/resistor-networks/) 有 resistor network 跟 resistor array 兩種說法。
  - [Array Resistors \| RS Components](https://uk.rs-online.com/web/c/passive-components/fixed-resistors/array-resistors/) Array resistor 的說法也有。
  - [Resistor Networks, Arrays \| Resistors \| DigiKey](https://www.digikey.com/products/en/resistors/resistor-networks-arrays/50) 分類叫 "Resistor Networks, Arrays"。
  - [Special resistor packages - Resistors \- learn\.sparkfun\.com](https://learn.sparkfun.com/tutorials/resistors/all#pot) 提到 resistor array #ril
  - [排阻結構最全總結，拿走不謝 \- 每日頭條](https://kknews.cc/zh-tw/news/y8nnrma.html) (2017-02-26) #ril
  - [Inline Resistor Network \- Pimoroni Yarr\-niversity](https://learn.pimoroni.com/tutorial/hacks/inline-resistor-network) 自製排阻 #ril
  - [Blog: Should You Use a Resistor Network? \| TT Electronics](http://www.ttelectronics.com/index.php/en/news-and-media/press-releases/should-you-use-a-resistor-network) (2017-06-08) #ril

## 參考資料 {: #reference }

  - [The Resistor Guide](http://www.resistorguide.com/)
