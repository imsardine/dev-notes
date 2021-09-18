# dig

  - [dig \(command\) \- Wikipedia](https://en.wikipedia.org/wiki/Dig_(command))

      - dig is a network administration command-line tool for querying the Domain Name System (DNS).

      - dig is useful for network troubleshooting and for EDUCATIONAL PURPOSES. It can operate based on command line option and flag arguments, or in batch mode?? by reading requests from an operating system file.
      - When a specific name server is not specified in the command invocation, it uses the operating system's DEFAULT RESOLVER, usually configured in the file `resolv.conf`. Without any arguments it queries the [DNS root zone](https://en.wikipedia.org/wiki/DNS_root_zone). ??
      - dig supports [Internationalized domain name (IDN)](https://en.wikipedia.org/wiki/Internationalized_domain_name) queries. ??
      - dig is a component of the domain name server software suite [BIND](https://en.wikipedia.org/wiki/BIND). dig supersedes in functionality older tools, such as nslookup and the program host; however, the older tools are still used in complementary fashion. #ril

    Example usage

      - In this example, dig is used to query for any-type of record information in the domain `example.com`:

            $ dig example.com any
            ; <<>> DiG 9.6.1 <<>> example.com any
            ;; global options: +cmd
            ;; Got answer:
            ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 4016
            ;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 0

            ;; QUESTION SECTION:
            ;example.com.                   IN      ANY

            ;; ANSWER SECTION:
            example.com.            172719  IN      NS      a.iana-servers.net.
            example.com.            172719  IN      NS      b.iana-servers.net.
            example.com.            172719  IN      A       208.77.188.166
            example.com.            172719  IN      SOA     dns1.icann.org. hostmaster.icann.org. 2007051703 7200 3600 1209600 86400

            ;; Query time: 1 msec
            ;; SERVER: ::1#53(::1)
            ;; WHEN: Wed Aug 12 11:40:43 2009
            ;; MSG SIZE  rcvd: 154

        實際測試的結果： (跟上面很不一樣)

            $ dig example.com any

            ; <<>> DiG 9.10.6 <<>> example.com any
            ;; global options: +cmd
            ;; Got answer:
            ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 6640
            ;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 1

            ;; OPT PSEUDOSECTION:
            ; EDNS: version: 0, flags:; udp: 4096
            ;; QUESTION SECTION:
            ;example.com.                   IN      ANY

            ;; ANSWER SECTION:
            example.com.            75322   IN      A       93.184.216.34
            example.com.            75322   IN      RRSIG   A 8 2 86400 20200908194905 20200819003700 41461 example.com. DxNm/HP4I0iKsPwWgFXovAS6edw2WyN/fC/l3/PTxiw87fqfjCo7cHX5 t1ONkQtMNdHOCj/ZR8VkauyTSDrqVOfHkX2gwyOP/C4HI+aFtXcBQ8aS i80x1mSNsz+i2qI92Bf3LVGJronmQzoSQiypHylE2F/LzRlCsXq+5aq5 M74=
            example.com.            20012   IN      AAAA    2606:2800:220:1:248:1893:25c8:1946
            example.com.            20012   IN      RRSIG   AAAA 8 2 86400 20200908114918 20200818123700 41461 example.com. r6iTAMhquUDOZAgtrreuCBpFr+weNXoeymqvVRugxgYswRshzexGoP55 +B8z8EVUpM6vusOZk2q76XegQwIbz0ukA7MeF4h7bKqDN8eKwbl/6JbP tyL8zq4M3nj4a9eQX8VJXNtD/5b36Pvnqfn6FAYNZ8TxJ/Ep+NihtYG8 mIc=

            ;; Query time: 12 msec
            ;; SERVER: 192.168.1.254#53(192.168.1.254)
            ;; WHEN: Sun Aug 30 18:17:03 CST 2020
            ;; MSG SIZE  rcvd: 426

        時不時會遇到這種狀況： (但也只有 query type 為 `ANY` 時才會這樣；為什麼??)

            ;; Truncated, retrying in TCP mode.
            ;; Connection to 192.168.1.254#53(192.168.1.254) for example.com failed: connection refused.

      - The number 172719 in the above example is the TIME TO LIVE value, which indicates the time of validity of the data.

      - Queries may be DIRECTED to designated DNS servers for specific records; in this example, [MX records](https://en.wikipedia.org/wiki/MX_record): #ril

            $ dig wikimedia.org MX @ns0.wikimedia.org
            ; <<>> DiG 9.6.1 <<>> wikimedia.org MX @ns0.wikimedia.org
            ;; global options: +cmd
            ;; Got answer:
            ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 61144
            ;; flags: qr aa rd; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 2
            ;; WARNING: recursion requested but not available

            ;; QUESTION SECTION:
            ;wikimedia.org.                 IN      MX

            ;; ANSWER SECTION:
            wikimedia.org.          3600    IN      MX      10 mchenry.wikimedia.org.
            wikimedia.org.          3600    IN      MX      50 lists.wikimedia.org.

            ;; ADDITIONAL SECTION:
            mchenry.wikimedia.org.  3600    IN      A       208.80.152.186
            lists.wikimedia.org.    3600    IN      A       91.198.174.5

            ;; Query time: 73 msec
            ;; SERVER: 208.80.152.130#53(208.80.152.130)
            ;; WHEN: Wed Aug 12 11:51:03 2009
            ;; MSG SIZE  rcvd: 109

        為什麼 dig any 的結果沒有 MX record??

    History

      - dig was originally written by Steve Hotz and incorporated into BIND 4; later it was rewritten by Michael Sawyer, and is maintained by the Internet Systems Consortium as part of BIND 9.
      - When originally written, the manual page for dig indicated that its name was an acronym for "Domain Information Groper". This expansion was removed in 2017; the tool's name is now simply "dig".

## 參考資料 {: #reference }

相關：

  - [DNS](dns.md)
  - [BIND](bind.md)
