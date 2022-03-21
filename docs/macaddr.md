# MAC Address

## MAC Spoofing {: #spoofing }

  - [MAC spoofing \- Wikipedia](https://en.wikipedia.org/wiki/MAC_spoofing)

      - MAC spoofing is a technique for changing a factory-assigned Media Access Control (MAC) address of a network interface on a networked device.

        The MAC address that is hard-coded on a network interface controller (NIC) CANNOT be changed. However, many DRIVERS allow the MAC address to be changed.

        Additionally, there are tools which can make an operating system BELIEVE that the NIC has the MAC address of a user's choosing. The process of masking a MAC address is known as MAC spoofing. Essentially, MAC spoofing entails changing a computer's identity, for any reason.

    Motivation

      - Changing the assigned MAC address may allow the user to bypass access control lists on servers or routers, either hiding a computer on a network or allowing it to IMPERSONATE another network device. MAC spoofing is done for legitimate and illicit purposes alike.

    Controversy

      - Although MAC address spoofing is not illegal, its practice has caused controversy in some cases. In the 2012 indictment against Aaron Swartz, an Internet hacktivist who was accused of illegally accessing files from the JSTOR digital library, prosecutors claimed that because he had spoofed his MAC address, this showed PURPOSEFUL INTENT to commit criminal acts.

      - In June 2014, Apple announced that future versions of their iOS platform would RANDOMIZE MAC addresses for all WiFi connections, making it more difficult for internet service providers to track user activities and identities, which resurrected moral and legal arguments surrounding the practice of MAC spoofing among several blogs and newspapers.

        這將使得控管 MAC 白名單的做法無法落地。

    Limitations

      - MAC address spoofing is limited to the LOCAL BROADCAST DOMAIN. Unlike IP address spoofing, where senders spoof their IP address in order to cause the receiver to send the response elsewhere, in MAC address spoofing the response is usually received by the spoofing party if the switch is not configured to prevent MAC spoofing.

        如何防止??

  - [networking \- How to prevent MAC spoofing? \- Server Fault](https://serverfault.com/questions/547829/how-to-prevent-mac-spoofing)

      - MDMarra: You don't prevent MAC spoofing, since it's ENTIRELY CLIENT-SIDE. This is the reason that no one that really cares about security is using MAC whitelisting or blacklisting.

        If you care about controlling what devices connect to your network, you should be using 802.1x WITH DEVICE CERTIFICATES issued by your own internal CA that you control, or with some form on NAC like Cisco ISE or Microsoft NAP.

      - Marco: You cannot prevent MAC spoofing. The problem you're trying to solve is AUTHENTICATION. And the MAC address is simply not the right way to provide authentication since it can be spoofed very easily. There are even legit reasons to spoof a MAC address.

        If you want to restrict which computers can connect, you have to use better methods than relying on the MAC address, preferably methods that levereage some sort of encryption.

  - [MAC Spoofing Attack: All You Need to Know in 6 Important points](https://www.jigsawacademy.com/blogs/cyber-security/mac-spoofing-attack/) (2020-10-20)

      - MAC Address, abbreviated as Media Access Control address, is the distinct serial number given for each interface from the factory by its vendor. In simpler words, it is the exclusive, worldwide physical identification number given to every device that is connected to a network interface, be it wired or wireless.

        This address is used to recognize the communications of the network interface on every LOCAL NETWORK. MAC address includes 48 bits, or 6 bytes, and takes the subsequent format: ‘XX:XX:XX:YY:YY: YY’. Let us learn more about mac spoofing attack.

      - An IP address is used to recognize where you are on the Internet and the MAC address is used to recognize what device is on the local network.

        This MAC address is virtually burned to the hardware by the vendor and hence the end-user cannot alter or rewrite this burned–in address (BIA). However, masking the MAC address on the SOFTWARE SIDE is possible and this is how MAC spoofing works.

    HOW TO PREVENT MAC SPOOFING

      - Spoofing a MAC address doesn’t go around the network and hence a network manager will still be able to scrutinize the traffic from the spoofed MAC address. An address that has been spoofed will end up showing TRAFFIC FROM TWO DIFFERENT SOURCES CONCURRENTLY.

        Another method would be a company device ostensibly connected to the network from another physical location on the network. It is also imperative to harden the system, access points, or individual machines to prevent MAC spoofing attacks.

      - One can also firewall or can run a service built especially for MAC SPOOFING, for raising protection against MAC spoofing. There are many MAC spoofing tools that would facilitate the detection of MAC spoofing examples such as Reverse ARP, traffic analyzers, and bandwidth monitors.

## 參考資料 {: #reference }
