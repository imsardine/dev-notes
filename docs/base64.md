# Base64

  - [Base64 \- Wikipedia](https://en.wikipedia.org/wiki/Base64) #ril

      - In computer science Base64 is a group of BINARY-TO-TEXT ENCODING schemes that represent binary data in an ASCII string format by translating it into a radix-64 representation. The term Base64 originates from a specific MIME content transfer encoding.

      - Each BASE64 DIGIT represents exactly 6 bits of data. THREE 8-bit bytes (i.e., a total of 24 bits) can therefore be represented by FOUR 6-bit Base64 digits.

        編碼後每個 ASCII 字元 (base64 digit) 都代表 6 bits 的資料，所以 3 bytes 可以用 4 個 base64 digit 來表現 -- 8-bits x 3 / 6 = 4。

      - Common to all binary-to-text encoding schemes, Base64 is designed to carry data stored in binary formats across channels that only RELIABLY support text content.

        Base64 is particularly prevalent on the World Wide Web where its uses include the ability to embed image files or other binary assets inside textual assets such as HTML and CSS files.

    Design

      - The particular set of 64 characters chosen to represent the 64 place-values for the base VARIES BETWEEN IMPLEMENTATIONS. The general strategy is to choose 64 characters that are COMMON TO MOST ENCODINGS and that are also PRINTABLE.

        This combination leaves the data unlikely to be modified in transit through information systems, such as email, that were traditionally not 8-bit clean. For example, MIME's Base64 implementation uses A–Z, a–z, and 0–9 for the first 62 values. Other variations share this property but differ in the symbols chosen for the LAST TWO VALUES; an example is UTF-7.

        但下面 Base64 table 整理出的最後 2 個字元，似乎固定是 `+` 與 `/`? Variable summary table 進一步整理了不同實作的差異，62nd 與 63nd 多數跟 MIME 一樣採 `+` 與 `/`。

      - The earliest instances of this type of encoding were created for dialup communication between systems running the same OS — e.g., uuencode for UNIX, BinHex for the TRS-80 (later adapted for the Macintosh) — and could therefore make more ASSUMPTIONS about what characters were safe to use. For instance, uuencode uses uppercase letters, digits, and many punctuation characters, but no lowercase. ??

    Examples

      - In theory, the padding character is NOT NEEDED FOR DECODING, since the number of missing bytes can be calculated from the number of Base64 digits.

        In some implementations, the padding character is mandatory, while for others it is not used. One case in which padding characters are required is concatenating multiple Base64 encoded files.

        試過 macOS 的 `base64` 與 Python 的 `base64` 還到 padding 被去掉時都會出狀況：

            $ echo 'Hello, World!' | base64
            SGVsbG8sIFdvcmxkIQo=
            $ python -c 'import base64; print base64.b64decode("SGVsbG8sIFdvcmxkIQo=")'
            Hello, World!

            $ python -c 'import base64; print base64.b64decode("SGVsbG8sIFdvcmxkIQo")'
            Traceback (most recent call last):
              File "<string>", line 1, in <module>
              File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/base64.py", line 76, in b64decode
                raise TypeError(msg)
            TypeError: Incorrect padding

            $ echo -n SGVsbG8sIFdvcmxkIQo= | base64 --decode
            Hello, World!
            $ echo -n SGVsbG8sIFdvcmxkIQo | base64 --decode
            Hello, World$ <-- 結尾的驚嘆號跟換行字元都不見了!!

        在 `docker/compose:1.24.0` 下，更會出現 `truncated base64 input` 的錯誤。

            / # echo -n SGVsbG8sIFdvcmxkIQo= | base64 -d
            Hello, World!
            / # echo -n SGVsbG8sIFdvcmxkIQo | base64 -d
            Hello, Worldbase64: truncated base64 input
            / #

## 演算法 ?? {: #algorithm }

Base64 encoding 主要應用在以純文字的型式保存或傳送 binary data 時，編/解碼的原則被規範 [RFC 3548](http://tools.ietf.org/html/rfc3548) 裡 (之後被 [RFC 4648](http://tools.ietf.org/html/rfc4648) 取代)。

簡單地來說，Base64 就是將 3 個 8-bit 為一組的資料，拆成 4 個 6-bit 重新做編碼。以 `abc` 三個字元為例：

 1. `abc` 三個字元的 ASCII 編碼分別是 `01100001`、`01100010` 跟 `01100011`。 ([對照表](http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters))
 2. 將 3 個 8-bit 的資料串接起來，再依 6-bit 為單位由左至右做切割的結果會是 `011000`(24)、`010110`(22)、`001001`(9) 跟 `100011`(35)。
 3. 對照 [Base64 Index Table](http://en.wikipedia.org/wiki/Base64#Examples) 的結果就是 "YWJj"。

TIP: 以前很直覺地會認為 Base64 的編碼結果，結尾一定會有等號，但事實並非如此。

上面的例子其實刻意選了 3 個字元來做編碼，因為 3 個 8-bit 剛好可以被 6-bit 完整地劃分 (8 跟 6 的最小公倍數是 24)。但如果情況不這樣，會先在資料右側補上幾個 bit 的 0 之後才做編碼，這個動作就叫做 padding。可以肯定的是，無論資料內容為何，編碼後的字元數一定是 4 的倍數。

> Base64 最後是以 64 個[可列印的字元](http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters)來表示編碼後的結果，而 64 這個數字就是從上面 6-bit 分割單位而來（2^6 = 64）。
>
> 前 62 個字元中大小寫字母跟數字組成，對大部份的應用都不會是問題，但第 62 跟 63 個字元分別是 `+` 跟 `/`，可能不適合某些應用。因此後面這兩個字元，就會衍生出不同實作間的差異。
>
> 關於編／解碼的細節，[Wikipedia](http://en.wikipedia.org/wiki/Base64) 有很詳細的說明。

下面先以少 8-bit 的 `ab` 為例：

 1. 將 `ab` 二個字元 ASCII 編碼串接 `0110000101100010`，再依 6-bit 切割後的結果是 `011000`、`010110`、`0010`。
 2. 很顯然，最後一個 6-bit 少了 2 bits，會在右邊補上 0 之後再做編碼。結果就是 `011000`(24)、`010110`(22)、`001000`(8) -> "YWI"。
 3. 由於 Base64 編碼結果的字元數一定是 4 的倍數，所以在後面補上一個 `=`，成為 `YWI=`。

最後再看多 8-bit 的 `abca`：

 1. 將 `abca` 二個字元 ASCII 編碼串接 `01100001011000100110001101100001`，再依 6-bit 切割後的結果是 `011000`、`010110`、`001001`、`100011`、`011000`、`01`。
 2. 很顯然，最後一個 6-bit 少了 4 bits，會在右邊補上 0 之後再做編碼。結果就是 `011000`(24)、`010110`(22)、`001001`(9)、`100011`(35)、`011000`(24)、`010000`(16) -> "YWJjYQ"。
 3. 由於 Base64 編碼結果的字元數一定是 4 的倍數，所以在後面補上兩個 `=`，成為 `YWJjYQ==`。

## 透過環境變數傳遞檔案 ?? { #env }

  - [How to insert files as environment variables with Base64 – CircleCI Support Center](https://support.circleci.com/hc/en-us/articles/360003540393-How-to-insert-files-as-environment-variables-with-Base64) (2018-04-26)

      - If you need to insert SENSITIVE TEXT-BASED DOCUMENTS or even SMALL BINARY FILES into your project in secret it is possible to insert them as an environment variable by leveraging base64 encoding.

      - Base64 is an encoding scheme to translate binary data into text strings. These values can be inserted as an environment variable and decoded at runtime.

        You can encode a file via your command line terminal by feeding it directly to base64.

            base64 [option] [file]

        To then decode the base64 file from within your container you can run the decode option.

            base64 --decode [file]

      - This article is derived from this documents page: https://circleci.com/docs/1.0/google-auth/

        > Remember to download the JSON-formatted key file. ... Add the key file to CircleCI as a project environment variable. In this example, the variable is named `GCLOUD_SERVICE_KEY`.
        >
        > echo $GCLOUD_SERVICE_KEY | gcloud auth activate-service-account --key-file=-

        概念上是把 JSON key file 塞進環境變數，但從用法上看不出需要做 Base64 編解碼? 後來 [update gcloud commands to \-\-decode base64 · Issue \#2862 · circleci/circleci\-docs](https://github.com/circleci/circleci-docs/issues/2862) 提到中間要加個 `base64 --decode`：

            echo $GCLOUD_SERVICE_KEY | base64 --decode | sudo gcloud auth activate-service-account --key-file=-

  - [Secrets \- Kubernetes](https://kubernetes.io/docs/concepts/configuration/secret/)

      - Encoding Note: The serialized JSON and YAML values of secret data are encoded as base64 strings.

        Newlines are not valid within these strings and must be omitted. When using the `base64` utility on Darwin/macOS users should avoid using the `-b` option to split long lines. Conversely Linux users should add the option `-w 0` to `base64` commands or the pipeline `base64 | tr -d '\n'` if `-w` option is not available.

        會有這樣的差異是因為，在 macOS 上分行用 `-b` (預設 0)，但在 Linux 上則用 `-b` (預設 76)。上面示範的 `tr -d '\n'` 可以所有的換行字元移除。

  - [Allow more special characters in masked variables \(\#60790\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/60790)

      - Masked variables in their current state do not allow for the masking of many DIFFERENT TYPES OF CREDENTIALS due to restrictions on the types of special characters that can be masked.

        If more characters are allowed it will be easier to mask pre-generated credentials without having to regenerate access keys, passwords, etc multiple times. It looks like BitBucket currently supports the masking of many different types of characters as I had no problems masking a number of different AWS access keys without running into an error.

        這問題早該被揭露，否則連傳個 `AWS_SECRET_ACCESS_KEY` 都不能藏起來。

        這確實是個問題，但或許 credentials 明碼寫在環境變數裡也不太好。

      - Kamil Trzciński: I think that AT LEAST we could extend to support for everything that is BASE64 to be masked. It should be always safe to allow them. So:

            [A–Za–z0–9+/=]

## Incorrect Padding

以 [GitLab CI 環境變數的值含有 `=` 時不能被 mask](https://gitlab.com/gitlab-org/gitlab-ce/issues/60790) 的問題為例，在 GitLab CI 上把結尾的 `=` 去掉，要能夠在 CI runtime 順利解碼：

```
$ export DATA=SGVsbG8sIFdvcmxkIQ       # 完整資料 SGVsbG8sIFdvcmxkIQ==
$ echo "${DATA}===" | base64 --decode  # 固定加上 ===
Hello, World!
```

參考資料：

  - [Python: Ignore 'Incorrect padding' error when base64 decoding \- Stack Overflow](https://stackoverflow.com/questions/2941995/)

      - Henry Woody: I don't have the rep to comment, but a nice thing to note is that (at least in Python 3.x) `base64.b64decode` will TRUNCATE ANY EXTRA PADDING provided there is enough in the first place.

        So, something like: `b'abc='` works just as well as `b'abc=='`.

        What this means is that you can just add the MAXIMUM NUMBER OF PADDING CHARACTERS that you would ever need—which is three (`b'==='`)—and `base64` will truncate any unnecessary ones.

        Basically:

            base64.b64decode(s + b'===')

        is cleaner than

            base64.b64decode(s + b'=' * (-len(s) % 4))

        發現這個解法在 Python 2 跟 macOS `base64` 上都有效：

            $ python -c 'import base64; print base64.b64decode("SGVsbG8sIFdvcmxkIQo====")'
            Hello, World!

            $ python3 -c 'import base64; print(base64.b64decode("SGVsbG8sIFdvcmxkIQo===="))'
            b'Hello, World!\n'
            $ echo -n SGVsbG8sIFdvcmxkIQo==== | base64 --decode
            Hello, World!
            $

