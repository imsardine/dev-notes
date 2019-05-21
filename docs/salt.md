# Salt

  - [Salt \(cryptography\) \- Wikipedia](https://en.wikipedia.org/wiki/Salt_(cryptography)) #ril

      - In cryptography, a salt is RANDOM DATA that is used as an ADDITIONAL INPUT to a ONE-WAY function that "hashes" data, a password or passphrase.

        Salts are used to SAFEGUARD PASSWORDS IN STORAGE. Historically a password was stored in plaintext on a system, but over time additional safeguards developed to protect a user's password against being read from the system. A salt is one of those methods.

      - A new salt is RANDOMLY GENERATED FOR EACH PASSWORD. In a typical setting, the salt and the password (or its version after Key stretching ??) are concatenated and processed with a cryptographic hash function, and the resulting output (but not the original password) is stored WITH THE SALT in a database.

        只是 salt 也要跟著 hash 一起存下來，還是一樣的問題? 不過字典檔要根據不同的 salt 重建，確實會提高難度。

        Hashing allows for later authentication without keeping and therefore risking the plaintext password in the event that the authentication data store is compromised.

      - Salts defend against DICTIONARY ATTACKS or against their hashed equivalent, a pre-computed rainbow table attack.

        Since salts do not have to be memorized by humans they can make the size of the rainbow table required for a successful attack prohibitively large without placing a burden on the users.

      - Since salts are DIFFERENT IN EACH CASE, they also protect COMMONLY USED PASSWORDS, or those users who use the same password on several sites, by making all salted hash instances for the same password different from each other.

      - Cryptographic salts are broadly used in many modern computer systems, from UNIX SYSTEM CREDENTIALS to Internet security.
      - Salts are closely related to the concept of a cryptographic nonce. ??

  - [Unix salt - How Unix Implements Passwords \- Practical UNIX and Internet Security, 3rd Edition \[Book\]](https://www.oreilly.com/library/view/practical-unix-and/0596003234/ch04s03.html#puis3-CHP-4-SECT-3.2.2) #ril

