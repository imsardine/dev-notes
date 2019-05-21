# HAProxy

  - [HAProxy \- The Reliable, High Performance TCP/HTTP Load Balancer](http://www.haproxy.org/)
      - The Reliable, High Performance TCP/HTTP Load Balancer
      - HAProxy is a free, very fast and reliable solution offering high availability, load balancing, and proxying for TCP and HTTP-based applications. It is particularly suited for VERY HIGH TRAFFIC web sites and powers quite a number of the world's most visited ones. Over the years it has become the de-facto standard opensource LOAD BALANCER, is now shipped with most mainstream Linux distributions, and is often deployed by default in cloud platforms. Since it does not advertise itself, we only know it's used when the admins report it :-)
      - Its MODE OF OPERATION (主要是 TCP mode 跟 HTTP mode) makes its integration into existing architectures very easy and riskless, while still offering the possibility not to expose FRAGILE web servers to the net, such as below :

        ![](http://www.haproxy.org/img/haproxy-pmode.png)

      - We always support at least two active versions in parallel and an extra old one in critical fixes mode only.
      - Each version brought its set of features on top of the previous one. UPWARDS COMPATIBILITY (指 configuration) is a very important aspect of HAProxy, and even version 1.5 is able to run with configurations made for version 1.0 13 years before. Version 1.6 dropped a few long-deprecated keywords and suggests alternatives.

  - [HAProxy \- Wikipedia](https://en.wikipedia.org/wiki/HAProxy) #ril

## 新手上路 {: #getting-started }

  - [HAProxy version 1\.8\.19 \- Starter Guide](http://cbonte.github.io/haproxy-dconv/1.8/intro.html) #ril
  - [Quick introduction to load balancing and load balancers - HAProxy version 1\.8\.19 \- Starter Guide](http://cbonte.github.io/haproxy-dconv/1.8/intro.html#chapter-2) #ril

## Configuration ??

  - [Configuration file format - HAProxy version 1\.7\.11 \- Configuration Manual](https://cbonte.github.io/haproxy-dconv/1.7/configuration.html#chapter-2.1)
      - HAProxy's configuration process involves 3 major sources of parameters :
          - the arguments from the command-line, which always take precedence
          - the "global" section, which sets PROCESS-WIDE parameters
          - the proxies sections which can take form of "defaults", "listen", "frontend" and "backend".
      - The configuration file syntax consists in lines beginning with a KEYWORD referenced in this manual, optionally followed by one or several parameters delimited by SPACES.

  - [Proxies - HAProxy version 1\.7\.11 \- Configuration Manual](https://cbonte.github.io/haproxy-dconv/1.7/configuration.html#chapter-4) #ril
      - Proxy configuration can be located in a set of sections : `defaults [<name>]`, `frontend <name>`, `backend  <name>`, `listen   <name>` 其中 `<name>` 只是為了提高可讀性。
      - A "defaults" section sets default parameters for all other sections following its declaration. Those default parameters are reset by the next "defaults" section. See below for the list of parameters which can be set in a "defaults" section. The name is OPTIONAL but its use is encouraged for better READABILITY.

        作用在宣告處以下，直到另一個 defaults section 出現。

      - A "frontend" section describes a set of LISTENING SOCKETS accepting CLIENT CONNECTIONS.
      - A "backend" section describes a set of SERVERS to which the proxy will connect to forward incoming connections.


                       FRONTEND | <--- connection ---> | BACKEND
            client -->  request |        proxy         | request --> server
                   <-- response |                      |         <-- response

      - A "listen" section defines a COMPLETE PROXY with its frontend and backend parts combined in one section. It is generally useful for TCP-ONLY traffic. 為什麼 HTTP traffic 要分開來看? 因為多了 alalyze 的步驟??
      - All proxy names must be formed from upper and lower case letters, digits, '-' (dash), '_' (underscore) , '.' (dot) and ':' (colon). ACL names are case-sensitive, which means that "www" and "WWW" are two different proxies. 所以 ACL name 跟 proxy name 一樣??
      - Historically, all proxy names could overlap, it just caused troubles in the logs. Since the introduction of CONTENT SWITCHING??, it is mandatory that two proxies with OVERLAPPING CAPABILITIES?? (frontend/backend) have different names. However, it is still permitted that a frontend and a backend share the same name, as this configuration seems to be commonly encountered.
      - Right now, two major PROXY MODES are supported : "tcp", also known as layer 4, and "http", also known as layer 7. In layer 4 mode, HAProxy SIMPLY FORWARDS bidirectional traffic between two sides. In layer 7 mode, HAProxy ANALYZES the protocol, and can interact with it by allowing, blocking, SWITCHING??, adding, modifying, or removing arbitrary contents in requests or responses, based on arbitrary criteria.

  - [HAProxy version 1\.8\.19 \- Configuration Manual](http://cbonte.github.io/haproxy-dconv/1.8/configuration.html) #ril

## HTTP Mode ??

  - [Quick reminder about HTTP - HAProxy version 1\.7\.11 \- Configuration Manual](https://cbonte.github.io/haproxy-dconv/1.7/configuration.html#1) #ril

  - [Proxies - HAProxy version 1\.7\.11 \- Configuration Manual](https://cbonte.github.io/haproxy-dconv/1.7/configuration.html#chapter-4)
      - In HTTP mode, the processing applied to REQUESTS and RESPONSES flowing over a CONNECTION depends in the COMBINATION of the frontend's HTTP options and the backend's. HAProxy supports 5 CONNECTION MODES :

        別將 connection mode 與 proxy mode 搞混，這是 HTTP 這個 proxy mode 下細分的 connection mode。

          - KAL : keep alive ("option `http-keep-alive`") which is the DEFAULT mode : all requests and responses are processed, and CONNECTIONS REMAIN OPEN but IDLE between responses and new requests.
          - TUN: tunnel ("option `http-tunnel`") : this was the default mode for versions 1.0 to 1.5-dev21 : only the first request and response are processed, and everything else is forwarded WITH NO ANALYSIS at all. This mode should not be used as it creates lots of trouble with logging and HTTP processing. 好奇怪的需求?
          - PCL: passive close ("option `httpclose`") : exactly the same as tunnel mode, but with "Connection: close" appended in BOTH DIRECTIONS to try to make both ends close after the first request/response exchange.
          - SCL: server close ("option http-server-close") : the SERVER-FACING CONNECTION is closed after the end of the response is received, but the CLIENT-FACING CONNECTION remains open. 對 client 而言，connection 不曾中斷。
          - FCL: forced close ("option forceclose") : the connection is actively closed after the end of the response.

                                         Backend mode

                               | KAL | TUN | PCL | SCL | FCL
                           ----+-----+-----+-----+-----+----
                           KAL | KAL | TUN | PCL | SCL | FCL
                           ----+-----+-----+-----+-----+----
                           TUN | TUN | TUN | PCL | SCL | FCL
                Frontend   ----+-----+-----+-----+-----+----
                  mode     PCL | PCL | PCL | PCL | FCL | FCL
                           ----+-----+-----+-----+-----+----
                           SCL | SCL | SCL | FCL | SCL | FCL
                           ----+-----+-----+-----+-----+----
                           FCL | FCL | FCL | FCL | FCL | FCL

## Timeout ??

  - [The Response line - HAProxy version 1\.7\.11 \- Configuration Manual](https://cbonte.github.io/haproxy-dconv/1.7/configuration.html#chapter-1.3.1)
      - 408  when the REQUEST TIMEOUT strikes before the request is COMPLETE
      - 504  when the RESPONSE TIMEOUT strikes before the server RESPONDS

    注意 "request is complete" 與 "the server responds" 的差別，408 是指 "request 超過時限內沒傳完" (complete)，而 504 是指 "response 超過時限內沒有出現" (responds)。

                       FRONTEND | <--- connection ---> | BACKEND
            client -->  request |        proxy         | request --> server
                  *<-- response |                      |        *<-- response

    就 response timeout 而言，除了 proxy --> server 這一段，要注意 client --> proxy 這段也會有；以 Python requests 而言，[預設是不會 timeout](http://docs.python-requests.org/en/master/user/quickstart/#timeouts)，看似沒什麼問題？但其實可能會卡住。

    > Nearly all production code SHOULD USE this parameter in nearly all requests. Failure to do so can cause your program to HANG INDEFINITELY:

  - [`timeout client` - HAProxy version 1\.7\.11 \- Configuration Manual](https://cbonte.github.io/haproxy-dconv/1.7/configuration.html#4-timeout%20client) #ril
      - Set the maximum INACTIVITY time on the CLIENT SIDE. 不能用在 backend!!
      - The inactivity timeout applies when the CLIENT is expected to acknowledge or send data.
          - In HTTP mode, this timeout is particularly important to consider during the FIRST PHASE??, when the client sends the request, and during the response while it is reading data sent by the server. That said, for the first phase, it is preferable to set the "`timeout http-request`" to better protect HAProxy from Slowloris like attacks. The value is specified in milliseconds by default, but can be in any other unit if the number is suffixed by the unit, as specified at the top of this document.

            [Slowloris \(computer security\) \- Wikipedia](https://en.wikipedia.org/wiki/Slowloris_(computer_security)) 說明了這種攻擊是因為 "request 慢慢送，使得有限的 connection 被覇佔住"，也因此 request timeout 指的是 request 在多久內要送完，呼應上面 "request is complete" 的說法。

          - In TCP mode (and to a lesser extent, in HTTP mode), it is highly recommended that the client timeout remains equal to the server timeout in order to avoid complex situations to debug. It is a good practice to cover one or several TCP packet losses by specifying timeouts that are slightly above multiples of 3 seconds (eg: 4 or 5 seconds). If some long-lived sessions are mixed with short-lived sessions (eg: WebSocket and HTTP), it's worth considering "`timeout tunnel`", which overrides "`timeout client`" and "`timeout server`" for tunnels, as well as "`timeout client-fin`" for HALF-CLOSED connections.

  - [`timeout connect` - HAProxy version 1\.8\.19 \- Configuration Manual](https://cbonte.github.io/haproxy-dconv/1.8/configuration.html#4-timeout%20client) #ril
      - Set the maximum time to wait for a CONNECTION ATTEMPT TO A SERVER to succeed.
      - If the server is located on the same LAN as haproxy, the connection should be IMMEDIATE (less than a few milliseconds). Anyway, it is a good practice to cover one or several TCP PACKET LOSSES by specifying timeouts that are slightly above multiples of 3 seconds (e.g. 4 or 5 seconds). By default, the connect timeout also presets both queue and tarpit?? timeouts to the same value if these have not been specified.

  - [`timeout server` - HAProxy version 1\.8\.19 \- Configuration Manual](https://cbonte.github.io/haproxy-dconv/1.8/configuration.html#4.2-timeout%20server) #ril
      - Set the maximum INACTIVITY time on the SERVER SIDE. 指遲遲沒有回應? 沒有持續寫出東西??
      - The inactivity timeout applies when the SERVER is expected to acknowledge or send data.

        跟 `timeout client` 的方向相反，從 proxy 自己的觀點來看，`timeout client` 是在等 client 的 request "送完"，而 `timeout server` 則是在等 server 的 response "開始"。

      - In HTTP mode, this timeout is particularly important to consider during the first phase of the server's response, when it has to send the HEADERS, as it directly represents the server's processing time for the request. To find out what value to put there, it's often good to start with what would be considered as UNACCEPTABLE response times, then check the logs to observe the RESPONSE TIME DISTRIBUTION, and adjust the value accordingly.

        "represents the server's processing time for the request" 是指收到 header 後就開始起算??

  - [`timeout http-keep-live` - HAProxy version 1\.7\.11 \- Configuration Manual](https://cbonte.github.io/haproxy-dconv/1.7/configuration.html#4-timeout%20http-keep-alive) #ril
  - [`timeout http-request` - HAProxy version 1\.7\.11 \- Configuration Manual](https://cbonte.github.io/haproxy-dconv/1.7/configuration.html#4-timeout%20http-request) #ril

## Healthy Check ??

  - [Performing Health Checks \- HAProxy Technologies](https://www.haproxy.com/documentation/aloha/7-0/traffic-management/lb-layer7/health-checks/) #ril
  - [How to Configure HAProxy Health Checks \- Serverlab](https://www.serverlab.ca/tutorials/linux/network-services/how-to-configure-haproxy-health-checks/) (2015-07-02) #ril

## 參考資料 {: #reference }

  - [HAProxy.org](http://www.haproxy.org/)
  - [HAProxy.com](https://www.haproxy.com/)
  - [haproxy/haproxy - GitHub](https://github.com/haproxy/haproxy)

手冊：

  - [Configuration Manual (1.8)](http://cbonte.github.io/haproxy-dconv/1.8/configuration.html)
