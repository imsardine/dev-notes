# Google Stackdriver

  - [Stackdriver \- Wikipedia](https://en.wikipedia.org/wiki/Stackdriver)
      - Google Stackdriver is a FREEMIUM, credit card required, cloud computing systems management service offered by Google. It provides performance and diagnostics data (in the form of monitoring, LOGGING, tracing, ERROR REPORTING, and alerting) to public cloud users. Stackdriver is a hybrid cloud solution, providing support for both Google Cloud and AWS cloud environments. 其中 error reporting 是指 log level 為 warning/error 的嗎??
      - In May 2014, the Stackdriver company was acquired by Google. An expanded version of the product (adding support for LOGS ANALYSIS, hybrid cloud support, and deep integration with Google Cloud) was rebranded as Google Stackdriver and was launched to general availability in October, 2016.
      - Stackdriver's focus is improving the performance and availability of large, complex applications running in the public cloud. It provides metrics detailing every layer of the 'stack' in the form of charts and graphs. It supports multi-cloud environments, and provides a single pane of glass into users' cloud services. It provides VIEWS INTO THE LOGS that are generated, and allows users to generate METRICS from those logs. It allows users to receive ALERTS when metrics breach normal levels.

        原始資料還是 log，從 log 產生 metrics，再根據 metric 的變化 alert。

  - [Stackdriver \- Hybrid Monitoring  \|  Stackdriver  \|  Google Cloud](https://cloud.google.com/stackdriver/) #ril
      - Monitoring and management for services, containers, applications, and infrastructure.

    Full observability for your code and applications

      - Stackdriver AGGREGATES metrics, logs, and events from infrastructure, giving developers and operators a rich set of OBSERVABLE SIGNALS that speed ROOT-CAUSE ANALYSIS and reduce mean time to resolution (MTTR). Stackdriver doesn’t require extensive integration or multiple “panes of glass,” and it won’t lock developers into using a particular cloud provider.

    Works with multiple clouds and on-premises infrastructure

      - Stackdriver is built from the ground up for cloud-powered applications. Whether you’re running on Google Cloud Platform, Amazon Web Services, ON-PREMISES infrastructure, or with hybrid clouds, Stackdriver COMBINES metrics, logs, and metadata from all of your cloud accounts and projects into a single comprehensive view of your environment, so you can quickly understand service behavior and take action. 能合併不同地方的 log 一起看，對於 root-cause analysis 確實很有幫助!!

    Find and fix issues fast

      - Rich visualization and advanced alerting help you identify issues quickly, even hard-to-diagnose issues like host contention (爭奪??), cloud provider throttling, and degraded hardware. Integration with popular services like PagerDuty and SLACK provide for rapid incident response. Integrated logging, tracing, and error reporting enable rapid drill-down and root-cause analysis.

        能跟 Slack 整合，就不需要在自己的應用程式裡刻意安排 logger 把 warning/error 往 Slack 送了，但要怎麼做??

    Full-stack insights

      - Stackdriver gives you access to logs, metrics, traces, and other signals from your infrastructure platform(s), virtual machines, containers, middleware, and application tier, so that you can track issues ALL THE WAY FROM YOUR END USER to your backend services and infrastructure. Native support for distributed systems, auto-scaling, EPHEMERAL RESOURCES, and application performance management means that your monitoring works seamlessly with your modern architecture.

        感覺 client 也可以直接送 log 到 Stackdriver，不就可以當 GA 用??

    Native Google integration and more

      - Native integration with Google Cloud data tools BigQuery, Cloud Pub/Sub, Cloud Storage, Cloud Datalab, and out-of-the-box integration with all your other application components.

## 參考資料 {: #reference }

  - [Stackdriver |  Google Cloud](https://cloud.google.com/stackdriver/)
