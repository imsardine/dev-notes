# CDN (Content Delivery Network)

  - [How content delivery networks \(CDNs\) work \- Human Who Codes](https://humanwhocodes.com/blog/2011/11/29/how-content-delivery-networks-cdns-work/)

      - DNS resolution

        When the browser makes a DNS request for a domain name that is handled by a CDN, there is a slightly different process than with small, ONE-IP SITES.

        The server handling DNS requests for the domain name looks at the incoming request to determine the best set of servers to handle it. At it’s simplest, the DNS server does a geographic lookup based on the DNS resolver’s IP address and then returns an IP address for an edge server that is physically closest to that area. So if I’m making a request and the DNS resolver I’m routed to is Virginia, I’ll be given an IP address for a server on the East coast; if I make the same request through a DNS resolver in California, I’ll be given an IP address for a server on the West coast. You may not end up with a DNS resolver in the same geographic location from where you’re making the request.
