# Switch 開關

  - [Electronic switch \- Wikipedia](https://en.wikipedia.org/wiki/Electronic_switch) In electronics, an electronic switch is an electronic component or device that can switch an electrical circuit, interrupting the current or DIVERTing it from one conductor to another. 開合電路，或是讓電流改道。

## 新手上路 ?? {: #getting-started }

  - [Switch Basics \- learn\.sparkfun\.com](https://learn.sparkfun.com/tutorials/switch-basics/all) #ril

## Tact Switch 輕觸開關 ??

  - [tack\-sw \- Google Search](https://www.google.com/search?q=tack-sw) 用 TACK-SW 搜尋，主要都是中文資料，有微動開關、壓動開關、輕觸開關、按鍵開關、貼片式按鈕等不同的說法；[加上 `switch` 關鍵字](https://www.google.com/search?q=tack-sw+switch&tbm=isch) 則開始出現 Tact Switch 或 Tactile Switch 的說法，很明顯 TACK-SW 的說法幾乎只在國內出現。
  - [The Four\-Pin Switch: Hooking it up](http://tymkrs.tumblr.com/post/19734219441/the-four-pin-switch-hooking-it-up) (2012-03-22) #ril
      - But how do you know which pins go where? So usually, you have to monitor a specific pin on your microcontroller which lets your program know when the button’s been pressed, or not. Or if it’s all analog, when you click down the button, you’re completing a circuit. 前者想知道有沒有被按下，屬於數位的用法，後者單純只是連通電路，屬於類比的用去。
      - But this still doesn’t answer WHICH pin. So what happens is you’ll need your multimeter. When the button is not pressed, the following are electrically connected (zero resistance):

        ![](https://66.media.tumblr.com/tumblr_m0v9x5FpWt1qf00w4.png)

        But when the button is pressed, the following are electrically connected:

        ![](https://66.media.tumblr.com/tumblr_m0va55YNKv1qf00w4.png)

        三用電表確實可以用來檢查按下前後哪些接腳是連通的 (短路)，不過觀察手邊的 pushbutton 行為，按下後的狀況不太一樣；還沒按下前 1-2、3-4 是連通 (但對角的 1-4、2-3 不通)，但按下後 1-2、3-4 也不會斷掉，而是 "多了" 1-3 與 2-4 連通，結果就是所有的接腳都連在一起了。

      - Button Pressed: 3.3V power goes to Pin 7 (MCU Pin) - bypassing the resistor.  The electrons will take the path of least resistance and as long as the resistor is of greater resistance than the pin, power will go from 3.3V to the pin. 一開始 3.3v 沒有連通，而 P7 透過 resistor 連接到 GND (Example 1、2 接法稍有不同)，按下按鈕後，電流全往 P7 去；雖然此時 P7-GND 還是通的，但電流只會往阻力小的地方去。

        Example 1:

        ![](https://66.media.tumblr.com/tumblr_m0vayccEDv1qf00w4.png){: width="50%"}

        Example 2:

        ![](https://66.media.tumblr.com/tumblr_m0vb7lw4X61qf00w4.png){: width="50%"}

        若按下時所有接腳都是通的，其實 Example 1、2 並沒有什麼差別? P7-GND 一直都是通的，只是路上電阻比較大，電流不會往那裡走而已。

      - Note - take care to note if you put the switch on one side of a breadboard with no electrically isolated space between the pins, that you may end up getting pins electrically connected even when you don’t want them to! 什麼情況下一定要跨麵包板中間的溝槽??

  - [The push button switch you never knew you needed \- YouTube](https://www.youtube.com/watch?v=vBFXuifgRkM) (2016-01-20) 4-pin 放麵包板的一側會佔用掉 4 格，只剩一格可以用，所以通常會跨在中間的溝槽，但不是很好固定，所以作者找到 2-pin 的版本。

## Rocker Switch 洛克開關 ??

  - [rocker switch \- Google Search](https://www.google.com/search?q=rocker+switch&tbm=isch) Rocker Switch 即常見的電源開關，可以在 On/Off 間切換，為何有些不只 2 支接腳??

