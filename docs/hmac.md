# HMAC (Hash-based Message Authentication Code)

## 新手上路 {: #getting-started }

HMAC 可以用來驗證訊息是否可靠 (authentic)，包括：

  - Authentication - 出自可靠人士。
  - Integrity - 內容沒有遭到竄改。

屬於對稱加密(symmetric-key algorithm) - 加解密都用同一把 key。原理很簡單，只要用相同的 key、相同的演算法，雙方根據同一個 message 計算出來的 HMAC (keyed) hash 就應該要一樣。

假設 X 先生跟 A、B 等不同人約定好，以後交換 message (包括 data 跟 metadata) 時，必須同時附上 message 的 HMAC。也就是雙方約定好要保密的事項有：

  - X/A 或 X/B 之間要持有同一把 key，至於 A 跟 B 的 key 是否相同，則視需求而定。
  - 採用什麼 hash function？例如 HMAC-MD5、HMAC-SHA1 等。
  - 除了 data 本身之外，還有哪些重要的 metadata 也要納入計算？以防被竄改。例如 data 本身的摘要值 (檢查資料的完整性)、傳送時間 (檢查資料的效期) 等。
  - Data 跟多個 metadata 之間要怎麼串接？串接的順序為何？
  - 至於 data 本身要不要加密則視需求而定，如果需要加密，摘要值就必須是根據加密過後的版本。

TIP: 通常不會把整個 data 丟進去計算 HMAC hash，而是取 data 的摘要值，例如 MD5 digest。

下面用一個簡單的例子做說明：

 1. A 準備要送一份資料 "Happy New Year" 給 X，雙方約定好用 "secret-a" 這把 key 計算 HMAC-SHA1，而且訊息在 2 分鐘內送達才有效。
 2. 時間是 2012-12-31 23:56:30。A 用 "secret-a" 計算出 "Happy New Year 6d713031cd29f69c679de72c234e45aa 2012-12-31 23:56:30" 的 HMAC-SHA1。

    其中 "6d713031cd29f69c679de72c234e45aa" 是資料本身（"Happy New Year"）的 MD5 digest，連同當時的時間一起加入 HMAC 的計算。其中 MD5 digest 可以確認資料的完整性，而時間的部份則可以確認紙條上寫的時間沒有問題。

 3. A 把時間跟 HMAC-SHA1 都寫在一張小紙條上，跟資料本身一起放到信封裡，並在信封外頭署名 A。
 4. 時間來到 2012-12-31 23:59:30，X 收到一份外頭署名 A 的信件。
 5. X 從保險箱裡找出之前跟 A 約定好的 "secret-a"，按照相同的方式對資料本身、MD5 digest、紙條上寫的時間計算出 HMAC-SHA1，發現結果跟 A 在紙條上寫的 HMAC hash 相符。
 6. 雖然時間已經超過 2 分鐘，但至少可以確認兩件事－訊息是 A 傳的，資料本身沒有被竄改過（MD5），而且紙條上面寫的時間點也沒問題。

各語言對 HMAC 都有不同程度的支援。

參考資料：

  - [HMAC \- Wikipedia](https://en.wikipedia.org/wiki/HMAC) #ril
      - [Message authentication code \- Wikipedia](https://en.wikipedia.org/wiki/Message_authentication_code) - a SHORT PIECE OF INFORMATION used to authenticate a message—in other words, to confirm that the message came from the stated sender (its authenticity) and has not been changed. 也就是雜湊值。
      - In cryptography, an HMAC (sometimes expanded as either keyed-hash message authentication code or hash-based message authentication code) is a specific type of message authentication code (MAC) involving a cryptographic HASH FUNCTION and a SECRET CRYPTOGRAPHIC KEY. It may be used to simultaneously verify both the data integrity and the authentication of a message, as with any MAC. Any cryptographic hash function, such as SHA256 or SHA-3, may be used in the calculation of an HMAC; the resulting MAC algorithm is termed HMAC-X, where X is the hash function used (e.g. HMAC-SHA256 or HMAC-SHA3). 若 MAC 用來算雜湊值，不需要用到 key，那 secret key 是做什麼用的? => 在 hash 過程中，混進 message 裡；這麼說來，key-hashed 會比 hash-based 更能表達它的意思!!
     - HMAC uses TWO PASSES OF HASH COMPUTATION. The secret key is first used to derive two keys – inner and outer. The first pass of the algorithm produces an internal hash derived from the message and the inner key. The second pass produces the final HMAC code derived from the inner hash result and the outer key. Thus the algorithm provides better immunity against length extension attacks. 用相同的 hash function 做 2 次 hash；從 secret key 搭配 inner/outer padding 產生 inner/output key (pad)，第一步 `internal_hash = hash(inner_key + message)`，第二步 `final_hash = hash(outer_key + internal_hash)`。雖然下面有 HMAC hash 的說法，但 HMAC 本身並不是 hash 的演算法，hash 還是由 hash function (也就是 HMAC-X 中的 X)，而 HMAC 只是定義的一套如何把 secret key 混進 message 裡的演算法而已。
     - HMAC does NOT ENCRYPT THE MESSAGE. Instead, the message (encrypted or not) must be sent alongside the HMAC hash. Parties with the secret key will hash the message again themselves, and if it is AUTHENTIC, the received and computed has hes will match. HMAC 的重點是算出來的 hash 要一樣，至於 message 是否要多一層加密，則視情況而定。
  - [Verifying requests from Slack \| Slack](https://api.slack.com/docs/verifying-requests-from-slack) ... we're sending using a standard HMAC-SHA256 keyed hash. 這裡 "keyed hash" 的說法，更能強調 hash 的計算過程中混入了 secret key。

## 參考資料 {: #reference }

工具：

  - [Free Online HMAC Generator / Checker Tool (MD5, SHA-256, SHA-512) - FreeFormatter.com](https://www.freeformatter.com/hmac-generator.html)

相關：

  - [Python](python-hmac.md)

手冊：

  - [RFC 2104 - HMAC: Keyed-Hashing for Message Authentication](https://tools.ietf.org/html/rfc2104.html)
