# NTP (Network Time Protocol)

  - [Network Time Protocol \- Wikipedia](https://en.wikipedia.org/wiki/Network_Time_Protocol)

      - The Network Time Protocol (NTP) is a networking protocol for clock synchronization between computer systems over packet-switched??, variable-latency data networks.

        In operation since before 1985, NTP is one of the oldest Internet protocols in current use. NTP was designed by David L. Mills of the University of Delaware.

      - NTP is intended to synchronize all PARTICIPATING computers to WITHIN A FEW MILLISECONDS of Coordinated Universal Time (UTC).

        It uses the intersection algorithm, a modified version of Marzullo's algorithm, to SELECT accurate TIME SERVERS and is designed to mitigate the effects of variable NETWORK LATENCY.

        代表實務上要提供多組 time server??

      - NTP can usually maintain time to within TENS OF MILLISECONDS over the PUBLIC iNTERNET, and can achieve better than one millisecond accuracy in LOCAL AREA NETWORKS under ideal conditions. Asymmetric routes and network congestion can cause errors of 100 ms or more.
