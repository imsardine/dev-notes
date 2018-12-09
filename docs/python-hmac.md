# Python HMAC

## 基礎

### 新手上路

對照 [Wikipedia](https://en.wikipedia.org/wiki/HMAC) 上的範例，我們試著用 Python 算出相同的 HMAC。

```
HMAC_MD5("key", "The quick brown fox jumps over the lazy dog") = 0x80070713463e7749b90c2dc24911e275
HMAC_SHA1("key", "The quick brown fox jumps over the lazy dog") = 0xde7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9
HMAC_SHA256("key", "The quick brown fox jumps over the lazy dog") = 0xf7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8
```

Python 跟 HMAC 相關的 modules 有 `hmac` 跟 `hashlib`。下面用 HMAC-MD5 簡單說明這兩個 modules 的用法：

```
>>> import hmac, hashlib
>>> secret_key = 'key'
>>> message = 'The quick brown fox jumps over the lazy dog'
>>> digester = hmac.new(secret_key, message, hashlib.md5) # <1>
>>> digester.digest().encode('hex') # <2>
'80070713463e7749b90c2dc24911e275'
```

 1. `hmac.new()` 接受 3 個參數，第一個是 client/server 共同保管的 secret key，第二個是雙方要交換的 message，第三個則是 HMAC 要採用的 hash fuction。

    這裡的 `hashlib.md5` 可以算出 HMAC-MD5；要算出 HMAC-SHA1 或 HMAC-SHA256 只要改用 `hashlib.sha1` 或 `hashlib.sha256` 即可。

 2. `digest()` 可以算出 HMAC。

事實上，`hmac.new()` 的第二個參數是 'initial message'（通常是空字串），因為 message 可以是一個大檔案的內容。`hmac` 比較正式的用法應該是事先準備好一個可重複利用的 hmac object － 帶有 secret key、hash function，然後再透過 `update()` 分批餵進完整的 message。

```
>>> _SECRET_KEY = 'key'
>>> _HMAC_MD5 = hmac.new(_SECRET_KEY, '', hashlib.md5)
>>>
>>> digester = _HMAC_MD5.copy()
>>> blocks = ['The quick brown fox jumps', ' over the lazy dog']
>>> for block in blocks:
...     digester.update(block) # <1>
...
>>> digester.hexdigest() # <2>
'80070713463e7749b90c2dc24911e275'
```

 1. 連續呼叫 `update(a)` 跟 `update(b)` 的效果等同於 `update(a + b)`。
 2. `hexdigest()` 的效果等同於 `encode('hex')`。

瞭解了 `hmac` 基本的用法，要計算 HMAC-SHA1 或 HMAC-SHA256 就只是換掉 hash function 而已：

```
>>> import hmac, hashlib
>>> secret_key = 'key'
>>> message = 'The quick brown fox jumps over the lazy dog'
>>> hmac.new(secret_key, message, hashlib.sha1).hexdigest()
'de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9'
>>> hmac.new(secret_key, message, hashlib.sha256).hexdigest()
'f7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8'
```

參考資料：

  - [hmac – Cryptographic signature and verification of messages\. \- Python Module of the Week](https://pymotw.com/) #ril
  - [hmac — Keyed\-Hashing for Message Authentication — Python 3\.7\.1 documentation](https://docs.python.org/3/library/hmac.html) #ril
  - [hashlib — Secure hashes and message digests — Python 3\.7\.1 documentation](https://docs.python.org/3/library/hashlib.html) #ril

