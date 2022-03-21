# traceroute

  - [traceroute \- Wikipedia](https://en.wikipedia.org/wiki/Traceroute)

      - In computing, `traceroute` and `tracert` are computer network diagnostic commands for displaying possible routes (paths) and measuring transit delays of packets across an Internet Protocol (IP) network.

      - The history of the route is recorded as the round-trip times of the packets received from each successive host (remote node) in the route (path); the sum of the mean times in each hop is a measure of the total time spent to establish the connection.

      - Traceroute proceeds unless all (usually three) sent packets are lost more than twice; then the connection is lost and the route cannot be evaluated.

        Ping, on the other hand, only computes the final round-trip times from the destination point.

  - [How to Use Traceroute to Identify Network Problems](https://www.howtogeek.com/134132/how-to-use-traceroute-to-identify-network-problems/) (2017-07-05)

      - Traceroute is a command-line tool included with Windows and other operating systems. Along with the `ping` command, it’s an important tool for understanding Internet connection problems, including packet loss and high latency.

        If you’re having trouble connecting to a website, `traceroute` can tell you where the problem is. It can also help VISUALIZE the PATH traffic takes between your computer and a web server.

    How Traceroute Works

      - When you connect to a website – say, howtogeek.com – the traffic has to go through several intermediaries before reaching the website. The traffic goes through your local router, your Internet service provider’s routers, onto larger networks, and so on.

        Traceroute shows us the path traffic takes to reach the website. It also displays the DELAYS that occur at each stop. If you’re having issues reaching a website and that website is working properly, it’s possible there’s a problem SOMEWHERE ON THE PATH between your computer and the website’s servers. Traceroute would show you where that problem is.
