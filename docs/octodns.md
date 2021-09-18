# OctoDNS

  - [github/octodns: Tools for managing DNS across multiple providers](https://github.com/github/octodns) #ril

    DNS as code - Tools for managing DNS across multiple providers

      - In the vein of INFRASTRUCTURE AS CODE OctoDNS provides a set of tools & PATTERNS that make it easy to manage your DNS records across multiple providers.

        The resulting config can live in a repository and be deployed just like the rest of your code, maintaining a clear history and using your existing review & workflow.

        透過中間工具的轉接，DNS 的管理也有機會成為 infra as code 的一部份!! 這裡的 provider 是像 Route53、EasyDNS 這類提供 DNS 服務的平台，為人麼沒看到 [GoDaddy](https://github.com/github/octodns/issues/365) 的支援??

      - The architecture is PLUGGABLE and the tooling is flexible to make it applicable to a wide variety of use-cases. Effort has been made to make adding new providers as easy as possible.

        In the simple case that involves writing of a single class and a couple hundred lines of code, most of which is TRANSLATING between the provider's schema and OctoDNS's.

        按下面 `class` is a special key that tells OctoDNS what python class should be loaded. 的說法，是用 Python 來擴充。

        More on some of the ways we use it and how to go about extending it below and in the [`/docs` directory](https://github.com/github/octodns/blob/master/docs). #ril

      - It is similar to [Netflix/denominator](https://github.com/Netflix/denominator). #ril

## 參考資料 {: #reference }

  - [github/octodns - GitHub](https://github.com/github/octodns)
