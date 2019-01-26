# OpenLDAP

  - [OpenLDAP \- Wikipedia](https://en.wikipedia.org/wiki/OpenLDAP) #ril

### ldapsearch ??

```
$ ldapsearch -x -h $LDAP_SERVER -b dc=example,dc=com uid=$USERNAME
```

參考資料：

  - [The ldapsearch, ldapdelete and ldapmodify utilities](http://en.tldp.org/HOWTO/LDAP-HOWTO/utilities.html) #ril
      - `ldapsearch` 在 `ldap_search(3)` library call 上包裝一層 shell accessible interface，可以用在搜尋 LDAP 裡的 entries。
      - `ldapsearch` 會連線到 LDAP server、bind (驗證)，然後根據 filter (要符合 RFC 1558) 搜尋，若找到多個 entry 會全部列出來。預設會印出所有 attribute，除非有指定 `attrs`，例如 `ldasearch -u -b 'o=TUDelft,c=NL' 'cn=Luiz Malere' sn mail`。
  - [ldapsearch(1)](https://www.openldap.org/software/man.cgi?query=ldapsearch) #ril
      - `ldapsearch [OPTION]... [FILTER]`，其中 `FILTER` 預設是 `(objectClass=*)`

### ldapwhoami ??

`ldapwhoami` 可以用來驗證 credential，例如：

```
$ ldapwhoami -x -h $LDAP_SERVER -D cn=$USERNAME,ou=people,dc=example,dc=com -W
Enter LDAP Password:
dn:xxx,ou=people,dc=example,dc=com
```

參考資料：

  - [ldapwhoami](https://www.openldap.org/software/man.cgi?query=ldapwhoami) #ril
      - 連線到 LDAP server、通過 bind operation，再執行 whoami operation -- 應該就是印出自己的 DN?
      - 範例提到 `ldapwhoami -x -D "cn=Manager,dc=example,dc=com" -W`，可以用來確認 LDAP 密碼是否正確。
  - [RFC 4532 \- Lightweight Directory Access Protocol (LDAP) "Who am I?" Operation](https://tools.ietf.org/html/rfc4532) #ril

## 安裝設定 {: #installation }

### Debian/Ubuntu ??

  - [Install OpenLDAP In Ubuntu 15\.10 And Debian 8 \| Unixmen](https://www.unixmen.com/install-openldap-in-ubuntu-15-10-and-debian-8/) (2015-11-27) #ril
  - [Step\-by\-step OpenLDAP Installation and Configuration](https://www.howtoforge.com/linux_openldap_setup_server_client) #ril
  - [24\.6\. OpenLDAP Setup Overview](https://www.centos.org/docs/5/html/Deployment_Guide-en-US/s1-ldap-quickstart.html) #ril

### Docker ??

  - [osixia/docker\-openldap: A docker image to run OpenLDAP 🐳](https://github.com/osixia/docker-openldap) #ril
  - [osixia/openldap \- Docker Hub](https://hub.docker.com/r/osixia/openldap/) #ril

## 參考資料 {: #reference }

  - [OpenLDAP](https://www.openldap.org/)

社群：

  - ['openldap' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/openldap) #ril

手冊：

  - [OpenLDAP Man Pages: Index Page](https://www.openldap.org/software/man.cgi)
  - [ldapsearch(1)](https://www.openldap.org/software/man.cgi?query=ldapsearch) #ril
