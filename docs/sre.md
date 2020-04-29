# SRE (Site Reliability Engineering)

  - [Site Reliability Engineering \- Wikipedia](https://en.wikipedia.org/wiki/Site_Reliability_Engineering) #ril

  - [Do you have an SRE team yet? How to start and assess your journey \| Google Cloud Blog](https://cloud.google.com/blog/products/devops-sre/how-to-start-and-assess-your-sre-journey) (2019-01-26) #ril

  - [How SRE teams are organized, and how to get started \| Google Cloud Blog](https://cloud.google.com/blog/products/devops-sre/how-sre-teams-are-organized-and-how-to-get-started) (2019-06-27) #ril

      - At Google, Site Reliability Engineering (SRE) is our practice of continually defining RELIABILITY GOALS, measuring those goals, and working to improve our services as needed. We recently walked you through a guided tour of the SRE workbook.

        You can think of that guidance as what SRE teams generally do, paired with when the teams tend to perform these tasks given their MATURITY LEVEL. We believe that many companies can start and grow a new SRE team by following that guidance.

      - Since then, we have heard that folks understand what SREs generally do at Google and understand which best practices should be implemented at various levels of SRE MATURITY. We have also heard from many of you how you’re defining your own levels of team maturity. But the next step—how the SRE teams are actually organized—has been largely undocumented, until now!

      - In this post, we’ll cover how different IMPLEMENTATIONS of SRE teams establish BOUNDARIES ?? to achieve their goals. We describe six different implementations that we’ve experienced, and what we have observed to be their most important pros and cons.

        Keep in mind that your implementations of SRE can be different—this is not an exhaustive list. In recent years, we’ve seen all of these types of teams here in the Google SRE organization (i.e., a set of SRE teams) except for the “kitchen sink.” The order of implementations here is a fairly common path of evolution as SRE teams gain experience.

        雖然是按 SRE 在 Google 內部發展的軌跡，但不同類型的 SRE team 同時存在，最新的型式不一定最好、最適合。

    Before you begin implementing SRE

      - Before choosing any of the implementations discussed here, do a little prep work with your team. We recommend allocating some engineering time of multiple folks and finding at least one part-time advocate for SRE-related practices within your company. This type of initial, less formal setup has some pros and cons:

        Pros

          - Easy to get started on an SRE journey without organizational change.
          - Lets you test and adapt SRE practices to your environment at low cost.

        Cons

          - Time management between day-to-day job demands vs. adoption of SRE practices.

        Recommended for: Organizations without the scale to justify dedicated SRE team staffing, and/or organizations experimenting with SRE practices before broader adoption.

## 參考資料 {: #reference }

書籍：

  - [SRE Books](https://landing.google.com/sre/books/)

      - [Google - Site Reliability Engineering (SRE Book)](https://landing.google.com/sre/sre-book/toc/)
      - [Google - Site Reliability Engineering (Work Book)](https://landing.google.com/sre/workbook/toc/)
