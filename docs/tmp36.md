# TMP36 Analog Temperature Sensor

  - [TMP36 \- Analog Temperature sensor \[TMP36\] ID: 165 \- $1\.50 : Adafruit Industries, Unique & fun DIY electronics and kits](https://www.adafruit.com/product/165)

      - Wide range, low power temperature sensor outputs an ANALOG VOLTAGe that is PROPORTIONAL TO THE AMBIENT TEMPERATURE. To use, connect pin 1 (left) to power (between 2.7 and 5.5V), pin 3 (right) to ground, and pin 2 to analog in on your microcontroller.

        The voltage out is 0V at -50°C and 1.75V at 125°C. You can easily calculate the temperature from the voltage in millivolts: Temp °C = 100*(reading in V) - 50

        溫度範圍跟 [DS1B20](ds1b20.md) 的 -55°C ~ 125°C 很接近，但它不是走 1-Wire protocol，直接接類比輸入即可，也不用上拉電阻。

      - 下面 Figure 6. Output Voltages vs. Temperature 說明了兩者的線性關係，雖然 +Vs (voltage source) = 3V，但最高溫還是以 1.75V 來表現，也就是 0 ~ 1.75V 等比例表現 -50°C ~ 125°C (區間 175 °C)：

            temp = -50 + (voltage / 1.75) * 175 = -50 + ((100 * voltage) / 175) * 175 = 100 * voltage - 50

        跟 Arduino Projects Book #03 Love-o-Meter 的公式 `(voltage - .5) * 100` 是一樣的，單位應該不是 millivolts。

        TMP36 最高溫固定輸出 1.75V 的設計 (跟輸入電壓無關) 跟溫度區間 175°C 剛好差 100 倍，是溫度計算公式如此簡單的關鍵。

  - [Overview \| TMP36 Temperature Sensor \| Adafruit Learning System](https://learn.adafruit.com/tmp36-temperature-sensor) #ril

## Arduino

```
int SENSOR_PIN = A0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  int reading = analogRead(SENSOR_PIN);
  Serial.print("Reading: ");
  Serial.print(reading);
  Serial.print("; ");

  float voltage = reading / 1024.0 * 5; // ADC
  float temp = 100 * voltage - 50;
  Serial.print("Temperature: ");
  Serial.println(temp);
  delay(500);
}
```

因為 ADC 固定把 0 ~ 5V 劃分成 1024 個值 (跟當時的 +Vs 無關)，所以用 `reading / 1024.0 * 5` 求取 TMP36 輸出的電壓，其中的 5 跟 +Vs 無關。

從 Serial Monitor 可以看到：

```
Reading: 148; Temperature: 22.27
Reading: 147; Temperature: 21.78
Reading: 147; Temperature: 21.78
...
```

## 參考資料 {: #reference }

  - [TMP36 - Analog Temperature sensor - Adafruit](https://www.adafruit.com/product/165)
  - [TMP36 - Analog Devices](https://www.analog.com/en/products/tmp36.html#product-overview)

相關：

  - [DS18B20](ds18b20.md) 也是另一個溫度傳感器，但走的是 1-Wire 協定，需要上拉電阻，使用上較為複雜。

手冊：

  - [TMP35/TMP36/TMP37 Datasheet (Rev. H) - Analog Devices](https://www.analog.com/media/en/technical-documentation/data-sheets/TMP35_36_37.pdf) (PDF)
