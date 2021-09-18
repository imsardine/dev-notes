# Site Reliability Engineering (SRE Book)

## Chapter 14 - Managing Incidents

  - Effective incident management is key to limiting the disruption caused by an incident and restoring normal business operations as quickly as possible. If you haven’t gamed out your response to potential incidents in advance, principled incident management can go out the window in real-life situations.
  - This chapter walks through a portrait of an incident that spirals out of control due to ad hoc incident management practices, outlines a well-managed approach to the incident, and reviews how the same incident might have played out if handled with well-functioning incident management.

### Unmanaged Incidents

  - Put yourself in the shoes of Mary, the on-call engineer for The Firm. It’s 2 p.m. on a Thursday afternoon and your pager has just exploded. Black-box monitoring tells you that your service has stopped serving any traffic in an entire datacenter. With a sigh, you put down your coffee and set about the job of fixing it. A few minutes into the task, another alert tells you that a second datacenter has stopped serving. Then the third out of your five datacenters fails. To exacerbate the situation, there is more traffic than the remaining datacenters can handle, so they start to overload. Before you know it, the service is overloaded and unable to serve any requests.

## 參考資料 {: #reference }

  - [Google - Site Reliability Engineering](https://landing.google.com/sre/books/)
