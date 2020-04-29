# BeyondCorp

  - [BeyondCorp \- Enterprise Security  \|  Google Cloud](https://cloud.google.com/beyondcorp)

    A new approach to enterprise security.

    BeyondCorp at Google

      - BeyondCorp is Google's IMPLEMENTATION of the ZERO TRUST SECURITY MODEL that builds upon eight years of building zero trust networks at Google, combined with ideas and best practices from the community.

        By shifting access controls from the NETWORK PERIMETER to individual users and devices, BeyondCorp allows employees, contractors, and other users to work MORE SECURELY from virtually any location without the need for a traditional VPN.

        為什麼能比 VPN 做到更安全?? 問題是，傳統的 VPN 有什麼不好??

    BeyondCorp implementation at Google

      - BeyondCorp began as an internal Google initiative to enable every employee to work from UNTRUSTED NETWORKS without the use of a VPN. BeyondCorp is used by most Googlers every day, to provide user- and device-based authentication and authorization for Google's core infrastructure.

        Google 自己每天都在用，是所有的應用嗎??

    BeyondCorp research papers

      - These research papers describe the story of BeyondCorp at Google, from concept through implementation: #ril

    BeyondCorp for everyone

      - BeyondCorp can now be enabled at virtually any organization with Google Cloud's context-aware access solution, powered by Cloud Identity, Cloud Identity-Aware Proxy, Cloud IAM, and VPC Service Controls. Enterprise administrators can enforce granular access controls to web apps, VMs, APIs, and G Suite apps based on attributes like user identity, device security status, IP address, and more. #ril

        G Suite 或 GCP 的使用者才能用??

    About BeyondCorp > High-level components of BeyondCorp

      - Single sign-on, access proxy, access control engine, user inventory, device inventory, security policy, and trust repository.

    About BeyondCorp > BeyondCorp principles

      - Connecting from a particular network MUST NOT determine which services you can access

        這當然沒錯!! 但如果 application 本身安全性不夠高 (沒有這個條件)，就需要 VPN 來保護不是?

      - Access to services is granted based on what we know about you and your device
      - All access to services must be authenticated, authorized, and encrypted

    About BeyondCorp > Google's BeyondCorp mission (2011—present)

      - To have every Google employee work successfully from untrusted networks without the use of a VPN.

        為什麼 Google 要推這個? 因為需要以 Google 的服務為基礎 ...

  - [BeyondCorp \| Run Zero Trust Security Like Google](https://www.beyondcorp.com/) #ril

## 參考資料 {: #reference }

  - [BeyondCorp | Google Cloud](https://cloud.google.com/beyondcorp)
  - [BeyondCorp | Run Zero Trust Security Like Google](https://www.beyondcorp.com/)

相關：

  - [Zero Trust Network](zerotrust.md) -- BeyondCorp 只是 Google 的實作版本。
