# DNS (Domain Name Service)

  - [Domain Name System \- Wikipedia](https://en.wikipedia.org/wiki/Domain_Name_System) #ril

      - The Domain Name System (DNS) is a hierarchical and decentralized naming system for computers, services, or other RESOURCES connected to the Internet or a PRIVATE NETWORK.

        It associates various information with domain names assigned to each of the participating entities. Most prominently, it translates more readily memorized domain names to the numerical IP addresses needed for locating and identifying computer services and devices with the underlying network protocols.

      - By providing a worldwide, distributed DIRECTORY SERVICE, the Domain Name System has been an essential component of the functionality of the Internet since 1985.

      - The Domain Name System DELEGATES the responsibility of assigning domain names and mapping those names to Internet resources by designating AUTHORITATIVE NAME SERVERS?? for each domain.

        Network administrators may delegate authority over sub-domains of their ALLOCATED NAME SPACE to other name servers. This mechanism provides distributed and fault-tolerant service and was designed to avoid a single large central database.

      - The Domain Name System also specifies the technical functionality of the database service that is at its core. It defines the DNS protocol, a detailed specification of the data structures and data communication exchanges used in the DNS, as part of the Internet Protocol Suite.

      - The Internet maintains TWO PRINCIPAL NAMESPACES, the domain name hierarchy and the Internet Protocol (IP) address spaces. The Domain Name System maintains the domain name hierarchy and provides translation services between it and the address spaces.

        Internet name servers and a communication protocol implement the Domain Name System.[3] A DNS name server is a server that stores the DNS records for a domain; a DNS name server responds with answers to queries against its database.

      - The most common types of records stored in the DNS database are for Start of Authority (SOA)??, IP addresses (A and AAAA), SMTP mail exchangers (MX), name servers (NS), pointers for reverse DNS lookups (PTR), and domain name ALIASES (CNAME).

        Although not intended to be a GENERAL PURPOSE DATABASE, DNS has been expanded over time to store records for other types of data for either AUTOMATIC LOOKUPS, such as DNSSEC records, or for human queries such as responsible person (RP) records.

        As a general purpose database, the DNS has also been used in combating unsolicited email (spam) by storing a real-time blackhole list (RBL). The DNS database is traditionally stored in a structured text file, the [ZONE FILE](https://en.wikipedia.org/wiki/Zone_file), but other database systems are common. #ril

    Function

      - An often-used analogy to explain the Domain Name System is that it serves as the phone book for the Internet by translating human-friendly computer hostnames into IP addresses. For example, the domain name www.example.com translates to the addresses 93.184.216.34 (IPv4) and 2606:2800:220:1:248:1893:25c8:1946 (IPv6).

        The DNS can be quickly and TRANSPARENTLY updated, allowing a service's location on the network to change without affecting the end users, who continue to use the same hostname. Users take advantage of this when they use meaningful Uniform Resource Locators (URLs) and e-mail addresses without having to know how the computer actually locates the services.

      - An important and ubiquitous function of DNS is its central role in DISTRIBUTED INTERNET SERVICES such as cloud services and content delivery networks. When a user accesses a distributed Internet service using a URL, the domain name of the URL is translated to the IP address of a server that is PROXIMAL TO THE USER.

        The key functionality of DNS exploited here is that different users can simultaneously receive different translations for the same domain name, a key point of divergence from a traditional phone-book view of the DNS. This process of using the DNS to assign proximal servers to users is key to providing faster and more reliable responses on the Internet and is widely used by most major Internet services.

        現在應該都由 CDN 做掉了?? 除非自己要做 multiple CDN?

      - The DNS reflects the structure of administrative responsibility in the Internet. Each subdomain is a ZONE of administrative autonomy delegated to a manager.

        For zones operated by a REGISTRY, administrative information is often complemented by the registry's RDAP and WHOIS services. That data can be used to gain insight on, and track responsibility for, a given host on the Internet.

  - [Domain name registry \- Wikipedia](https://en.wikipedia.org/wiki/Domain_name_registry) #ril

## Internal/Intranet Domain {: #internal-domain }

  - [Choosing an Internal Top Level Domain Name \| Pluralsight](https://www.pluralsight.com/blog/software-development/choose-internal-top-level-domain-name) (2012-08-22) #ril

  - [Best Practices for Naming an Active Directory Domain](https://www.varonis.com/blog/active-directory-domain-naming-best-practices/) (2020-03-29)

    When you’re naming domains, it should be planned as carefully as you would in naming your first child – of course I’m exaggerating – but it’s worth planning carefully.  For those of you who fail to heed this advice, we’ve written a tutorial on how to rename a domain. 🙂

    Popular Domain Naming Mistakes

      - Before we discuss current best practices, there are a couple of popular practices that are no longer recommended.

      - The first is using a generic top-level domain. Generic TLDs like `.local`, `.lan`, `.corp`, etc, are now being sold by ICANN, so the domain you’re using internally today – `company.local` could potentially become another company’s property tomorrow. If you’re still not convinced, here are some more [reasons](http://www.mdmarra.com/2012/11/why-you-shouldnt-use-local-in-your.html) why you shouldn’t use `.local` in your Active Directory domain name #ril

      - Secondly, if you use an external public domain name like `company.com`, you should avoid using the same domain as your internal Active Directory name because you’ll end up with a split DNS. Split DNS is when you have two separate DNS servers managing the exact same DNS Forward Lookup Zone, increasing the administrative burden. ??

    Better Naming Options

      - For the time being, until things change, as they inevitably do, here are two domain naming options for you.

      - The first one is to use an inactive SUB-DOMAIN OF A DOMAIN THAT YOU USE PUBLICLY. For instance: `ad.company.com` or `internal.company.com`. Advantages to this most-preferred approach includes:

          - Only one domain name needs to be registered – even if you later decide to make part of your internal name publicly accessible
          - Enables you to simply and separately manage internal and external domains
          - All internal domain names will be globally unique

        The only microscopic drawback is that you’ll have more to type when entering FQDNs on your internal network, so make your subdomain name as short as possible!

      - However, if it is not feasible for you to configure your internal domain as a subdomain, you can use another domain that you own, which isn’t used elsewhere. For instance, if your PUBLIC WEB PRESENCE is `company.com`, your internal domain can be named `company.net`, only if it’s registered and if it’s not used anywhere else. The main advantage is that you’ve secured a unique internal domain name. However, the disadvantage is that this approach requires you to manage two separate names.

    And, once you’ve mulled over names, you’ll want to visit [this site](http://support.microsoft.com/kb/909264) to ensure you don’t let a tiny colon : or tilde ~ ruin your day.

  - [Name computers, domains, sites, and OUs \- Windows Server \| Microsoft Docs](https://docs.microsoft.com/en-US/troubleshoot/windows-server/identity/naming-conventions-for-computer-domain-site-ou) (2020-09-08)

    DNS domain names

      - Generally, we recommend that you register DNS names for INTERNAL AND EXTERNAL NAMESPACES with an Internet registrar. This includes the DNS names of Active Directory domains, unless such names are SUBDOMAINS of DNS names that are registered by your organization name. For example, `corp.example.com` is a subdomain of `example.com`. Registering your DNS name with an Internet registrar may help prevent a name collision. A name collision may occur if another organization tries to register the same DNS name, or if your organization merges with another organization that uses the same DNS name.

        看來 internal domain 做為 external/public domain 的 subdomain 是很常見的實務。

    Other factors

      - The DNS names of all the nodes that require name resolution include the Internet DNS domain name for the organization. So, choose an Internet DNS domain name that is short and easy to remember. Because DNS is hierarchical, DNS domain names grow when you add subdomains to your organization. Short domain names make the computer names easy to remember.

        因為 subdomain 是很常見的用法，所以做為基底的 organization domain name 不要太長。

      - If the organization has an INTERNET PRESENCE, use names that are RELATIVE to the registered Internet DNS domain name. For example, if you have registered the Internet DNS domain name `contoso.com`, use a DNS domain name such as `corp.contoso.com` for the INTRANET DOMAIN NAME.

      - Avoid a generic name like maybe `domain.localhost`. Another company you MERGE with in a few years might follow the same thinking.
      - Don't use an acronym or an abbreviation as a domain name. Users may have difficulty recognizing the business unit that an acronym represents.
      - Don't use the name of a business unit or of a division as a domain name. Business units and other divisions will change, and these domain names can be misleading or become obsolete.
      - Avoid extending the DNS domain name hierarchy more than five levels from the root domain. You can reduce administrative costs by limiting the extent of the domain name hierarchy.
      - If you are deploying DNS in a private network, and you don't plan to create an external namespace, register the DNS domain name that you create for the internal domain. Otherwise, you may find that the name is unavailable if you try to use it on the Internet, or if you connect to a network that is connected to the Internet. ??

  - [Active Directory: Best Practices for Internal Domain and Network Names \- TechNet Articles \- United States \(English\) \- TechNet Wiki](https://social.technet.microsoft.com/wiki/contents/articles/34981.active-directory-best-practices-for-internal-domain-and-network-names.aspx) (2018-10-30) #ril

      - So the question is: what's the best practice for DNS naming for internal domains and networks?

        The short answer, as best practice:

          - Microsoft strongly recommends that you register a public domain and USE SUBDOMAINS FOR THE INTERNAL DNS.
          - So, register a public DNS name, so you own it. Then create subdomains for internal use (like `corp.example.org`, `dmz.example.org`, `extranet.example.org`) and make sure you've got your DNS configuration setup correctly.

    DNS sub-domains of master

      - This is a frequently used technique to use the same TLD (top level domain) and SEPARATE THE ZONES BY SUBDOMAIN. E.g. "intranet", "extranet", "DMZ" for ‘INTERNAL’ ZONES and just plain `<domain>.<tld>` for public DNS. For example:

          - `intranet.example.org` or `corp.example.org` (if your AD is named ‘CORP’)
          - `extranet.example.org` for applications or PARTNER FACING WEBSITES
          - `DMZ.example.org` for applications that need DMZ for data protection or publication,
          - and master suffix `.example.org` for public websites (managed by your Internet Provider)

      - The forum post just mentioned earlier discusses a technique called "DNS split brain":

          - http://msdn.microsoft.com/en-us/library/ms954396.aspx
          - http://www.techrepublic.com/blog/networking/set-up-split-brain-dns-with-active-directory-integrated-zones/1362

      - In fact, you have one DNS name space, but with forwarding spaces per zone. This is a bit more complicated setup as you need to make sure the DNS servers forward the requests to the applicable zones correctly. And it does require some planning and cooperation with your internet provider.

    Recommendation

      - Microsoft strongly suggests to work with subdomains, within a publicly registered TLD domain. Check: Creating Internal and External Domains op https://technet.microsoft.com/en-us/library/cc755946(WS.10).aspx

      - Design Option #1: The internal domain is a subdomain of the external domain.

        Microsoft strongly recommends this option. For more information, see [Using an Internal Subdomain](https://technet.microsoft.com/en-us/library/cc772970(v=ws.10).aspx) #ril

        Management Complexity: Easy to deploy and administer.

        An organization with an external namespace `contoso.com` uses the internal namespace `corp.contoso.com`.

      - Design Option #2:

        The internal and external domain names are different from each other.

        For more information, see [Using Different Internal and External Domain Names](https://technet.microsoft.com/en-us/library/cc739077(v=ws.10).aspx)

        Management Complexity: More complicated than previous option.

        An organization uses `contoso.com` for its external namespace, and `corp.internal` for its internal namespace.

        這例子舉得不太好? 不是說 `.local` 這類 generic TLD 不要用嗎?

  - [Top level domain/domain suffix for private network? \- Server Fault](https://serverfault.com/questions/17255/top-level-domain-domain-suffix-for-private-network) (2009-06-01) #ril

## 參考資料 {: #reference }

相關：

  - [dig](dig.md)

手冊：

  - [List of DNS record types - Wikipedia](https://en.wikipedia.org/wiki/List_of_DNS_record_types)
