# LDAP

  - LDAP = Lightweight Directory Access Protocol

參考資料：

  - [What's LDAP ?](http://en.tldp.org/HOWTO/LDAP-HOWTO/whatisldap.html) LDAP 全名是 Lightweight Directory Access Protocol，規範在 RFC2251 裡，是一種存取 directory service (尤其是 X.500-based??) 的 client-server protocol
  - [Lightweight Directory Access Protocol \- Wikipedia](https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol) #ril

## 新手上路 ?? {: #getting-started }

  - [LDAP Linux HOWTO](http://en.tldp.org/HOWTO/LDAP-HOWTO/) #ril
  - [Getting Started with LDAP](https://www.ldap.com/getting-started-with-ldap) #ril

## 運作方式 ??

  - [How does LDAP work ?](http://en.tldp.org/HOWTO/LDAP-HOWTO/howitworks.html) #ril
      - 基於 client-server model，由一或多個 LDAP server 構成 directory tree。由 client 連線到 server 然後詢問問題，server 可能會直接提供答案，也可能回一個 pointer 指出應該去哪裡找資料 (通常是另一個 LDAP server)。
      - 不論 client 連到哪個 server，都有一樣的 view (of the directory)；參照到同一個 entry 的表示法，不會因連接的 LDAP server 不同而異。

## Directory, Tree, Entry, Attribute??

  - [What's LDAP ?](http://en.tldp.org/HOWTO/LDAP-HOWTO/whatisldap.html) Directory 跟 database 有點像，只是資訊更為 descriptive & attribute-based，讀取的頻率比寫入高，具有 quick-response、支援 high-volume lookup/search、可複寫資訊以提升 availability/reliability 等特性。在複寫的過程中複本 (replica) 間可能會有不一致，但最終一定會同步。
  - [The Directory Information Tree and the LDAP Root DSE](https://www.ldap.com/the-directory-information-tree) 以 tree-like hierarchy 方式安排資料 #ril

## Attribute, Type, Value, Option ??

  - [Basic LDAP Concepts](https://www.ldap.com/basic-ldap-concepts) Entries 及 Attributes #ril
  - [Commonly Used Attributes - Appendix E: LDAP \- Object Classes and Attributes](http://www.zytrax.com/books/ldap/ape/#attributes) 例出常用的 attribute，例如 `cn` (commonName)、`dc` (domainComponent)、`uid`、`ou` (`organisationalUnitName`) 等 #ril
  - `uid=john.doe,ou=People,dc=example,dc=com` 感覺 `dc`、`ou` 有些 attribute 是通用的??
  - [RFC 2789 - Definition of the inetOrgPerson LDAP Object Class](https://www.ietf.org/rfc/rfc2798.txt) 定義了 user 該有的 attributes #ril

## DN、RDN??

參考資料：

  - [LDAP DNs and RDNs](https://www.ldap.com/ldap-dns-and-rdns) #ril
      - DN (distinguished name) 除了可以識別 DIT (Directory Information Tree) 中特定的 entry，也指出該 entry 在 DIT 中的位置。
      - DN 在概念上類似 filesystem 的 absolute path，只是表示法不同；filesystem path 的左側由 root 開始，往右發展下一層結構，但 DN 的 root 會放在右側，往左發展下一層結構。例如 `uid=john.doe,ou=People,dc=example,dc=com` 這個 DN，以樹狀結構來看，上一層 entry 的 DN 是 `ou=People,dc=example,dc=com`，往上則是 `dc=example,dc=com`。
      - DN 由 "零" 或多個由逗號隔開的 RDN (relative distinguished name) 組成，例如 `uid=john.doe,ou=People,dc=example,dc=com` 就由 4 個 RDN 組成 -- `uid=john.doe`、`ou=People`、`dc=example`、`dc=com`
      - 每個 RDN 又由一或多個 attribute (name-value pair) 組成 (attribute name + '=' + attribute value)，例如 `cn=John Doe`。一個 RDN 有多個 name-value pair 時，其間用 `+` 串起來，例如 RDN `cn=John Doe+telephoneNumber=+1 123-456-7890`，可以解讀為這個 multivalued RDN 有兩個 attribute，分別是 `cn` (`John Doe`) 與 `telephoneNumber` (`+1 123-456-7890`)
      - Multivalued RDN 主要用於無法用一個 attribute 在同一個階層識別出特定 entry 的狀況，例如有兩個人的名字都叫 John Doe，但他們有不同的電話。
      - 雖然某個 entry 的 DN 由多個 RDN 組成，但 "某個 entry 的 RDN" 通常是指 DN 最左邊的那個 RDN；同樣的，某個 entry 的 attribute，說的也是最左邊那個 RDN 的 attributes。例如 `uid=john.doe,ou=People,dc=example,dc=com` 這個 entry 的 RDN 是 `uid=john.doe`，它具有 `uid` attribute，值是 `john.doe`。
      - 當 DN 由 "零" 個 RDN 組成 -- 稱做 zero-length DN 或 null DN (用空字串表示)，可以用來參照 root DSE (DSA-specific entry) -- 提供許多關於該 directory server 的資訊。
      - 但 LDAP tree 最頂層的 entry 不一定是由單一個 RDN 構成，以 `dc=example,dc=com` 做為 topmost entry 的 DN (沒有上層 `dc=com`) 也是可以的。而 topmost entry 的 DN 稱做 naming context (或 suffix)。
      - 上面用逗號隔開多個 RDN 的表示法，就是 DN 的 string representation，嚴格來說是 attribute type name (不含 attribute option) + '=' + attribute value 的 "string representation"，如果是 multivalued RDN，則用 `+` 把多個 attribute 隔開來。有些字元則要用 `\` 做 escape，例如 `\` 可以用 `\\` 或 `\5c` (ASCII) 表示。
      - 一個 DN 不只一個 string representation，因為分隔字元 (`,=+`) 兩側都可以有多個空白字元、multivalued RDN 裡多個 attribute 間沒有順序、attribute name 不區分大小寫、attribute name 可以用 OID 替代、有些 attribute 甚至有多個 name。所以在比對 DN 時不能直接做字串比對，而應透過 LDAP client API 比較，或是透過 API 轉出 normalized represenation。
  - [Ldapwiki: DN Escape Values](http://ldapwiki.com/wiki/DN%20Escape%20Values) `,\#+<>;"=` 要加 `\` 做 escape (例如 `,` 要用 `\,` 表示，才不會被視為 attribute 的分隔字元)，至於空白則只有 leading/trailing space 才需要 escape。

  - 一個 entry 可以有多個 attribute，哪些 attribute 才能成為 RDN 的一份子??
  - Appendix A: LDAP: DN and RDN http://www.zytrax.com/books/ldap/apa/dn-rdn.html #ril
  - Distinguished Names (Windows) https://msdn.microsoft.com/en-us/library/aa366101(v=vs.85).aspx #ril

## LDAP URL ??

  - [LDAP URLs](https://www.ldap.com/ldap-urls) `ldap://...` 不同的用法 #ril

## Operation ??

  - [LDAP Operation Types](https://www.ldap.com/ldap-operation-types) #ril

## Search Filter, Base DN, Scope ??

  - [Search Filters - Basic LDAP Concepts](https://www.ldap.com/basic-ldap-concepts) Search Filters 與 Search Base DNs and Scopes #ril
  - [How to write LDAP search filters \- Atlassian Documentation](https://confluence.atlassian.com/kb/how-to-write-ldap-search-filters-792496933.html) #ril
  - [RFC 1558 - A String Representation of LDAP Search Filters](https://www.ietf.org/rfc/rfc1558.txt) #ril

## Schema, Object Class, OID??

  - [LDAP DNs and RDNs](https://www.ldap.com/ldap-dns-and-rdns) 最後提到，可以從 server 取得 schema information，就可以知道 attribute type 的 name 跟 OID，以及 attribute value 的語法。
  - [Understanding LDAP Schema](https://www.ldap.com/understanding-ldap-schema) #ril

## Bind, Authentication ??

  - [The ldapsearch, ldapdelete and ldapmodify utilities](http://en.tldp.org/HOWTO/LDAP-HOWTO/utilities.html) `-x` 的作用是 simple authentication，而 man page 的說明是 "Use simple authentication instead of SASL"。
  - [The LDAP Bind Operation](https://www.ldap.com/the-ldap-bind-operation) #ril
      - Bind operation 用來驗證 client (及背後的 user)，以建立後續操作參考的 authorization identity；藉由 bind operation 也提供了 client 希望採用的 LDAP protocol version。
      - Authentication 至少涉及 "宣稱是誰" (identifying who or what is authenticating) 及 "證明是誰" (supplying some kind of proof of that identity)，某些 server 可能還會檢查其他條件來決定 bind 是否成功。
      - LDAP bind request 的做法有兩種 -- simple authentication 或 SASL authentication，所謂 simple authencation 是指用 account + password 驗證。
      - 就 simple authentication/bind 而言，account 以 account entry 的 DN 來表示，而 password 則是明碼傳送；當 account 跟 password 都是空白時，就是所謂的 anonymous simple authentication/bind。(雖然 LDAPv3 只要求密碼要空白，但許多 server 要求 password 空白時，account 也必須要空白)
  - [Authentication using LDAP](https://www.tldp.org/HOWTO/LDAP-HOWTO/authentication.html) LDAPv3 支援 3 種 authentication -- anonymous、simple 及 SASL #ril

## 管理工具 ??

  - [10 Linux GUI tools for sysadmins \- TechRepublic](https://www.techrepublic.com/blog/10-things/10-linux-gui-tools-for-sysadmins/) (2015-10-23) 唯一穩固的 LDAP GUI 管理工具 -- Apache Directory，雖然專為 ApacheDS 設計，但可以做為 LDAP browser、schema editor、LDIF editor 等。
  - [Welcome to Apache Directory Studio — Apache Directory](http://directory.apache.org/studio/) 試用過很不錯!!
  - [List of LDAP software \- Wikipedia](https://en.wikipedia.org/wiki/List_of_LDAP_software) #ril
  - [The ldapsearch, ldapdelete and ldapmodify utilities](http://en.tldp.org/HOWTO/LDAP-HOWTO/utilities.html) #ril
  - [Graphical LDAP tools](http://en.tldp.org/HOWTO/LDAP-HOWTO/graphicaltools.html) #ril
  - [JXplorer \- an open source LDAP browser](http://jxplorer.org/) #ril

## LDIF ??

  - [More on the LDIF Format](http://en.tldp.org/HOWTO/LDAP-HOWTO/moreonldif.html) #ril

## 參考資料 {: #reference }

  - [LDAP.com](https://www.ldap.com/)

相關：

  - [OpenLDAP](openldap.md)

手冊：

  - [Glossary of LDAP Terms](https://www.ldap.com/glossary-of-ldap-terms)
  - [RFC 1558 - A String Representation of LDAP Search Filters](https://www.ietf.org/rfc/rfc1558.txt)
  - [RFC 2251 - Lightweight Directory Access Protocol (v3)](https://www.ietf.org/rfc/rfc2251.txt)
  - [RFC 2789 - Definition of the inetOrgPerson LDAP Object Class](https://www.ietf.org/rfc/rfc2798.txt)
  - [RFC 4514 - Lightweight Directory Access Protocol (LDAP): String Representation of Distinguished Names](https://www.ietf.org/rfc/rfc4514.txt)
  - [RFC 4516 - Lightweight Directory Access Protocol (LDAP): Uniform Resource Locator](https://www.ietf.org/rfc/rfc4516.txt)

