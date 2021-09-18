# Zero Trust

  - [Zero trust security model \- Wikipedia](https://en.wikipedia.org/wiki/Zero_trust_security_model) #ril

      - The zero trust security model (also, zero trust architecture, zero trust network architecture, ZTA, ZTNA), sometimes known as PERIMETERLESS security, describes an approach to the design and implementation of IT systems.

      - The main concept behind zero trust is that DEVICES SHOULD NOT BE TRUSTED BY DEFAULT, even if they are connected to a managed corporate network such as the corporate LAN and even if they were previously verified.

        In most modern enterprise environments, corporate networks consist of many INTERCONNECTED SEGMENTS, cloud-based services and infrastructure, connections to remote and mobile environments, and increasingly connections to non-conventional IT, such as IoT devices.

      - The once traditional approach of trusting devices within a NOTIONAL CORPORATE PERIMETER, or devices connected to it via a VPN, makes LESS SENSE in such highly diverse and distributed environments.

        Instead, the zero trust approach advocates MUTUAL AUTHENTICATION, including checking the identity and integrity of devices IRRESPECTIVE OF LOCATION, and providing access to applications and services based on the confidence of DEVICE IDENTITY AND DEVICE HEALTH IN COMBINATION WITH USER AUTHENTICATION.

        > Mutual authentication or two-way authentication (not to be confused with two-factor authentication) refers to two parties authenticating each other at the same time in an authentication protocol.
        >
        > -- [Mutual authentication \- Wikipedia](https://en.wikipedia.org/wiki/Mutual_authentication)

    Background

      - The challenges of defining the perimeter to an organisation's IT systems was highlighted by the Jericho Forum in 2003, discussing the trend of what was then coined de-perimiterisation.

        In 2009, Google implemented a zero trust architecture referred to as BeyondCorp. Kindervag's reporting and analysis helped crystallize zero trust concepts across IT communities. However, it would take almost a decade for zero trust architectures to become prevalent, DRIVEN IN PART BY INCREASED ADOPTION OF MOBILE AND CLOUD SERVICES.

      - By middle of 2014, Gianclaudio Moresi, a Swiss security engineer, designed the first system using the principle of a series circuit of firewalls in order to protect any client from new dangerous viruses (Zero Day Protection with Zero Trust Network). The new architecture based on UNTRUST-UNTRUST NETWORK was published at the Swiss Federal Institute of Intellectual Property on 20 February 2015.
      - By 2019, the UK National Technical Authority, the National Cyber Security Centre were recommending that network architects consider a zero trust approach for new IT deployments, particularly WHERE SIGNIFICANT USE OF CLOUD SERVICES IS PLANNED.
      - By 2020 the majority of leading IT platform vendors, as well as cyber security providers, have well-documented examples of zero trust architectures or solutions. This increased popularization has in-turn created a range of definitions of zero trust, requiring a level of standardization by recognized authorities such as NCSC and NIST.

    Principles definitions

      - From late 2018, work undertaken in the U.S. by the National Institute of Standards and Technology (NIST) and National Cyber Security Center of Excellence (NCCoE) cyber security researchers led to A NIST Special Publication (SP) 800-207, Zero Trust Architecture.

        The publication defines zero trust (ZT) as a collection of concepts and ideas designed to reduce the uncertainty in enforcing accurate, per-request access decisions in information systems and services in the face of a network viewed as COMPROMISED.

        A zero trust architecture (ZTA) is an ENTERPRISE’S CYBER SECURITY PLAN that utilizes zero trust concepts and encompasses component relationships, workflow planning, and access policies. Therefore, a zero trust enterprise is the NETWORK INFRASTRUCTURE (physical and virtual) and OPERATIONAL POLICIES that are in place for an enterprise as a product of a zero trust architecture plan.

        Zero Trust (ZT) 是一些概念的組合，而 Zero Trust Architecture (ZTA) 則是企業的資安計劃?

      - An alternative but consistent approach is taken by NCSC, in identifying the key principles behind zero trust architectures:

          - SINGLE strong source of user identity
          - User authentication
          - Machine authentication
          - Additional context, such as policy compliance and device health
          - Authorization policies to access an application
          - Access control policies within an application

## VPN

  - [Zero Trust Network Access: The Evolution of VPN \| Network World](https://www.networkworld.com/article/3611530/zero-trust-network-access-the-evolution-of-vpn.html) (2020-03-11) #ril

      - The recent rise in REMOTE WORKING has put a spotlight on the limitations of virtual private networks (VPNs). For years, VPNs have been the de facto method of accessing corporate networks, but they have some drawbacks in light of today’s more complex ecosystems.
      - The biggest issue for complex network deployments is that a VPN takes a PERIMETER-BASED approach to security. Users connect through the VPN client, but once they're inside the perimeter, and in the absence of other security solutions in place, they could potentially have BROAD ACCESS to the network, which exposes it to threats. Every time a device or user is AUTOMATICALLY TRUSTED in this way, it places an organization's data, applications, and intellectual property at risk.

      - VPNs have no insight into the content they are delivering. Because most home offices are connected to largely unsecured home networks, they have become a primary target for cybercriminals who are looking for an easily exploited point of access into the network. Part of the challenge is that these remote users often are not subject to the same application access controls that would be in place if they were connecting from the corporate network. In addition, because they are no longer sequestered behind enterprise-grade security solutions, they also become easier targets for social engineering tactics and malware. They are increasingly subject to older exploits that target unpatched devices, which are commonly attached to home networks, such as gaming, entertainment, or home security systems.

## 802.1X

  - [Zero\-Trust Security for a Cloud\-First, Mobile Enterprise \| Okta](https://www.okta.com/video/oktane18-protect-against-breaches-zero-trust-security/) #ril

      - On that global distributed, secure cloud platform, we've now built a second service offering which is Zscaler Private Access, and to be honest, this is why I came to Zscaler. I've been doing remote access VPN and NAC with both as an end user, then as an IT administrator, and then as a technology vendor, and both of them are really hard. We need a better approach.

        802.1X, has anyone in here tried to deploy 802.1X across your entire organization? Okay, couple hands. Would you say it was successful? No. This was my last 10 years frankly.

  - [Cybersecurity in a Zero Trust Architecture \| Aruba Blogs](https://blogs.arubanetworks.com/solutions/cybersecurity-in-a-zero-trust-architecture/) (2019-12-16) #ril

    Implement 802.1X and Segmentation

      - Do not trust devices just because they can access your facility and connect to a switch port in a staff member’s office. Even further, you should not give a device unconditional access just because it connects to a switch port in the office of the CEO.

        Using 802.1X in both your wired and wireless deployments allows you to apply policies that limit a device or user to only the resources they should access.

        所以 802.1x 在 Zero Trust 環境下還是有效用的?

      - You can even take this a step further and implement Dynamic Segmentation to apply centralized policies from Aruba ClearPass. You have the flexibility to have wired traffic use to the local switch or tunnel it back through a controller for firewalling and deep packet inspection. This is particularly useful for unknown and IoT devices.

## Non-HTTP Services

  - [BeyondCorp \| Run Zero Trust Security Like Google](https://www.beyondcorp.com/) #ril

      - Gateways: SSH servers, web proxies, and 802.1x-enabled wireless networks that perform authorization actions.

  - [Applying the Principles of Zero Trust to SSH \| Teleport](https://goteleport.com/blog/applying-principles-of-zero-trust-to-ssh/) (2020-03-17) #ril

  - [A Zero Trust terminal in your web browser](https://blog.cloudflare.com/browser-ssh-terminal-with-auditing/) (2021-04-15) #ril

  - [Introducing SSH zero trust, Identity aware TCP sockets \| by Andree Toonk \| Level Up Coding](https://levelup.gitconnected.com/introducing-ssh-zero-trust-identity-aware-tcp-sockets-c73cf65e57c) (2021-02-17) #ril

  - [Pritunl Zero \- Open Source Zero Trust BeyondCorp Server](https://zero.pritunl.com/) #ril

    Free and open source BeyondCorp server providing zero trust security for privileged access to ssh and web applications.

  - [零信任網路存取 \| Cloudflare for Teams \| Cloudflare](https://www.cloudflare.com/zh-tw/teams/zero-trust-network-access/) 提到 "對難以保護的資源（例如 Web 應用程式、SSH、RDP 和其他基礎結構）實施最低許可權。"，表示 ZTNA 可以套用在 SSH。

  - [What is Zero Trust? \- Palo Alto Networks](https://www.paloaltonetworks.com/cyberpedia/what-is-a-zero-trust-architecture) #ril

## 參考資料 {: #reference }

更多：

  - [BeyondCorp](beyondcorp.md) -- Google 的實作
  - [Azure > Zero Trust Network](azure-zerotrust.md) -- Azure 的實作
