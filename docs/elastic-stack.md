---
title: Elastic / Stack (X-Pack)
---
# [Elastic](elastic.md) / Stack (X-Pack)

  - [Elastic Stack Features \(Formerly X\-Pack\): Extend Elasticsearch, Kibana, Beats & Logstash \| Elastic](https://www.elastic.co/products/stack) #ril

      - From enterprise-grade security and developer-friendly APIs to machine learning, and graph analytics, the Elastic Stack ships with features (formerly packaged as X-Pack) made and maintained by us to be enjoyed by you.

  - [Download X\-Pack: Extend Elasticsearch and Kibana \| Elastic](https://www.elastic.co/downloads/x-pack) (2018-04-18) #ril

      - The following installation instructions are only valid for versions 6.2 and older. In versions 6.3 and later, X-Pack is included with the default distributions of Elastic Stack, with all FREE FEATURES enabled by default. An OPT-IN TRIAL is available to enable subscription features.

        哪些功能是免費的??

  - [Elastic Stack \(X\-Pack\) Alternatives: Free, Open Source, Commercial & Cloud Services](https://sematext.com/blog/x-pack-alternatives/) 有替代方案? (2019-03-06) #ril

  - [Doubling Down on Open \| Elastic](https://www.elastic.co/blog/doubling-down-on-open) (2018-02-27) #ril

## Free

  - 即便 X-Pack [在 2018/04 開源](https://www.elastic.co/blog/opening-x-pack-phase-1-complete)，但程式碼授權維持 Elastic License 不變，但這跟 X-Pack 能否免費使用無關；X-Pack 在還沒開源前，有許多功能本來就是免費，但有些功能像 Security 就要收費，這部份在開源後不會改變。
  - 不過 X-Pack 收費功能通常有免費的替代方案，例如 Security 可以用 [Open Distro for Elasticsearch Security](https://github.com/opendistro-for-elasticsearch/security) 取代。

參考資料：

  - [We’re Opening X\-Pack \| Elastic](https://www.elastic.co/products/x-pack/open)

      - From open communication to open source software, openness is at the heart of Elastic. That's why we OPENED THE PRIVATE CODE of our X-Pack features: security, alerting, monitoring, reporting, graph analytics, dedicated APM UIs, and machine learning.

        開放原始碼，但並不表示它免費。

    Why Did We Do This?

      - Historically, we developed X-Pack as a set of CLOSED-SOURCE FEATURES that extend the Elastic Stack — that’s Elasticsearch, Kibana, Beats, and Logstash. Some features like monitoring were FREE, and others like SECURITY and machine learning were PAID.

        原本全都是 closed-source，增強了 Elastic Stack 的各個層面，但只有部份是免費的，即便也是採 Elastic license。

      - Our company is built on a healthy balance between open source code and commercial IP. (See Shay's blog for more details.) Opening up X-Pack speeds up development and increases engagement across the entire community: everyone can contribute to, comment on, and inspect the code.

    So, What Changed in GitHub?

      - The code sitting in the private X-Pack repositories moved to the appropriate public Elasticsearch, Kibana, Beats, and Logstash repositories.

      - We did not change the license of any of the Apache 2.0 code of Elasticsearch, Kibana, Beats, and Logstash — and we NEVER WILL. We created a new X-Pack folder in each of these repositories that is licensed under the Elastic License, which allows for some derivative works and contribution.

        Making this move eliminates the overhead and complexity of syncing separate GitHub repositories, speeds up build-test-release cycles, and it means that we have one place where everyone can create and track issues.

        ![](https://images.contentstack.io/v3/assets/bltefdd0b53724fa2ce/bltff838cc225c89712/5c2001644cca137b3874352e/diagram-open-xpack-v2.svg)

        注意 X-Pack 的程式碼全採 Elastic License，但仍有部份是可以免費使用的。

    How Does the User Experience Change?

      - Starting with VERSION 6.3, all of the FREE X-Pack features (monitoring, Search Profiler, Grok Debugger, zoom levels in Elastic Maps Service, dedicated APM UIs, and more) ship with the default distributions of Elasticsearch, Kibana, Beats, and Logstash.

        We removed all of the barriers — email registration, installation steps, full cluster restart — for users to get started with these powerful features that we believe will make you more successful with our technology.

      - And if you prefer to run a build that’s 100% Apache 2.0 code, we will have ‘-oss’ versions of our distributions available.

    OSSFL: Open Source Software for Life

      - We believe in open source, and our investment in it will continue unchanged. Many businesses BECOME MORE CLOSED AS THEY GROW, but this new approach is a clear choice to make us more open and keep our business incentives aligned with our open source community. It means that everyone will develop, contribute, and test against the same source — THERE ARE NO "COMMUNITY" OR "ENTERPRISE" EDITIONS HERE.

        We're not taking away any Apache 2.0 code — we're doubling down on open.

    We Are Powered by You, the User

      - With more than 200 million downloads, there's a lot of love out there for Elastic products. We're committed to giving the best user experience possible — whether that's in the public cloud, private cloud, bare metal, or some combination thereof.
      - And whether you know us for the ELK Stack, the Elastic Stack, or individual products like Elasticsearch, we care about engineering great technology that you can trust well into the future.

    Have Additional Questions?

      - Are Elasticsearch, Kibana, Beats, and Logstash still open source?

        Yes. We did not change the license of any existing Apache 2.0 code. We only opened the code of X-Pack under a commercial license and added it to the existing Elasticsearch, Kibana, Beats, and Logstash repositories.

      - If the code of X-Pack is open, does that mean it's all free?

        NO. Many features in X-Pack are free, such as monitoring, tile maps, Grok Debugger, and Search Profiler. Some features in X-Pack are paid, and require a license that comes with a GOLD OR PLATINUM SUBSCRIPTION.

  - [elasticsearch \- is Security free in Elastic search Stack Features? \- Stack Overflow](https://stackoverflow.com/questions/53201190/) Val:

      - [This blog post](https://www.elastic.co/blog/doubling-down-on-open) explained some of the reasons why Elastic "opened" their XPack code. "Open" here simply means that they MERGED THEIR PRIVATE XPACK REPOSITORIES INTO THE OPEN ONES. One of the reasons that the blog post above doesn't mention is that this move was mostly motivated to facilitate tedious engineering tasks of having to keep all their product versions in synch. Anyway, the XPack code is now out in the open and visible for anyone to see, but it's not free as in "free beer".

      - As shown on the Elastic subscriptions page (see the red rectangle in the image below), XPack SECURITY IS ONLY AVAILABLE STARTING WITH A GOLD LICENSE.

        ![](https://i.stack.imgur.com/grozn.png)

      - Another alternative is to use their Elastic Cloud which provides Security out of the box and allows you to pay a lower amount on a monthly basis.
      - If the price burden is too heavy for you, you might want to check out [SearchGuard](https://search-guard.com/) which is an ALTERNATIVE SECURITY PLUGIN for ES, which provides a free Community tier for basic security features.

      - UPDATE (March 11th, 2019): Since today, Amazon has released a FULLY OPEN-SOURCED VERSION OF ELASTICSEARCH WITH A SECURITY (AND ALERTING) PLUGIN. More info at: https://opendistro.github.io/for-elasticsearch/

        Security 來自 [Open Distro for Elasticsearch Security](https://github.com/opendistro-for-elasticsearch/security) 這個 plugin，似乎也可以裝到標準的 Elasticsearch ??

  - [The Opening of X\-Pack: Phase 1 Complete \| Elastic](https://www.elastic.co/blog/opening-x-pack-phase-1-complete) (2018-04-25) #ril

## 參考資料 {: #reference }

參考資料：

  - ['elastic-stack' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/elastic-stack)
  - ['elasticsearch-x-pack' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/elasticsearch-x-pack)

