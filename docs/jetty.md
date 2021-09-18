# Jetty

  - [Jetty \(web server\) \- Wikipedia](https://en.wikipedia.org/wiki/Jetty_(web_server)) #ril

      - Eclipse Jetty is a Java WEB SERVER and Java SERVLET CONTAINER. While web servers are usually associated with serving documents to people, Jetty is now often used for MACHINE TO MACHINE COMMUNICATIONS, usually within larger software frameworks.

      - Jetty is developed as a free and open source project as part of the Eclipse Foundation. The web server is used in products such as Apache ActiveMQ, Alfresco, Scalatra, Apache Geronimo, Apache Maven, Apache Spark, Google App Engine, Eclipse, FUSE, iDempiere, Twitter's Streaming API and Zimbra.

        Jetty is also the server in open source projects such as Lift, Eucalyptus, OpenNMS, Red5, Hadoop and I2P. Jetty supports the latest Java Servlet API (with JSP support) as well as protocols HTTP/2 and WebSocket.

        這代表實務上不用在 Jetty 前面再擋一層 web server。

    Overview

      - Jetty started as an independent open source project in 1995. In 2009 Jetty moved to Eclipse. Jetty provides Web services in an EMBEDDED Java application and it is already a component of the Eclipse IDE. It supports AJP, JASPI, JMX, JNDI, OSGi, WebSocket and other Java technologies.

    History

      - Originally developed by software engineer Greg Wilkins, Jetty was originally an HTTP server component of Mort Bay Server. It was originally called IssueTracker (its original application) and then MBServler (Mort Bay Servlet server). Neither of these were much liked, so Jetty was finally picked.

      - Jetty was started in 1995 and was hosted by MortBay, creating version 1.x and 2.x, until 2000. From 2000 to 2005, Jetty was hosted by sourceforge.net where version 3.x, 4.x, and 5.x were produced. In 2005, the entire Jetty project moved to codehaus.org.

        As of 2009, the core components of Jetty have been moved to Eclipse.org, and Codehaus.org continued to provide integrations, extensions, and packaging of Jetty versions 7.x and 8.x (not 9.x) In 2016, the main repository of Jetty moved to GitHub, but it is still developed under the Eclipse IP Process.

        有點複雜的關係，不過側欄資訊寫著 Developer(s): Eclipse Foundation，且 Eclipse IDE 也是整合它。

## Deployment

  - [Deploying Web Applications - Jetty : The Definitive Reference](https://www.eclipse.org/jetty/documentation/jetty-9/index.html#quickstart-deploying-webapps) #ril

      - Jetty server instances that configure the deploy module will have a web application deployer that HOT DEPLOYS files found in the `webapps` directory.

        Standard WAR files and Jetty configuration files that are placed in the `webapps` directory are hot deployed to the server with the following conventions:

          - A directory called `example/` is deployed as a STANDARD WEB APPLICATION if it contains a `WEB-INF/` subdirectory, otherwise it is deployed as CONTEXT OF STATIC CONTENT.

            The CONTEXT PATH is `/example` (that is, http://localhost:8080/example/) unless the base name (主檔名) is `ROOT` (case INSENSITIVE), in which case the context path is `/`.

            If the directory name ends with "`.d`" it is ignored (but may be used by explicit configuration??).

          - A file called `example.war` is deployed as a standard web application with the context path `/example` (that is, http://localhost:8080/example/).

            If the base name is `ROOT` (case insensitive), the context path is `/`.

            If `example.war` and `example/` exist, only the WAR is deployed (which may use the directory as an UNPACK LOCATION).

          - An XML file like `example.xml` is deployed as a CONTEXT whose configuration is defined by the XML. The configuration itself must set the context path.

            If `example.xml` and `example.war` exists, only the XML is deployed (which may USE THE WAR in its configuration).

            用 `example.xml` 帶出 `example.war` 的安排滿好的！

      - If you have a standard web application, you can hot deploy it into Jetty by copying it into the `webapps` directory.

## Virtual Host

  - [Configuring Virtual Hosts - Jetty : The Definitive Reference](https://www.eclipse.org/jetty/documentation/jetty-9/index.html#configuring-virtual-hosts) #ril

      - A virtual host is an alternative name, registered in DNS, for an IP address such that multiple domain names will resolve to the same IP of a shared server instance. If the content to be served to the aliases names is different, then a virtual host needs to be configured for each DEPLOYED CONTEXT to indicate which names a context will respond to.

      - Virtual hosts are set on a context by calling the `setVirtualHosts` or `addVirtualHost` method which can be done in several ways:

          - Using a context XML file in the `webapps` directory (see the example in `test.xml` in the Jetty distribution).

            這個方式最好，就在 WAR 旁邊，也不用動到 WAR；這也是設定 virtual host 的方式之一。

          - Creating a custom deployer with a binding to configure virtual hosts for all contexts found in the same webapps directory.
          - Calling the API directly on an embedded usage.
          - Using a `WEB-INF/jetty-web.xml` file (now deprecated).

    Example Virtual Host Configuration

      - Virtual hosts can be used with any context that is a subclass of `ContextHandler`. Lets look at an example where we configure a web application - represented by the `WebAppContext` class - with virtual hosts. You supply a list of IP addresses and names at which the web application is reachable, such as the following:

          - 333.444.555.666
          - 127.0.0.1
          - www.blah.com
          - www.blah.net
          - www.blah.org

      - Suppose you have a webapp called `blah.war`, that you want all of the above names and addresses to be served at path “`/blah`”. Here’s how you would configure the virtual hosts with a CONTEXT XML file:

            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE Configure PUBLIC "-//Jetty//Configure//EN" "http://www.eclipse.org/jetty/configure_9_3.dtd">

            <Configure class="org.eclipse.jetty.webapp.WebAppContext">
              <Set name="contextPath">/blah</Set>
              <Set name="war"><Property name="jetty.webapps"/>blah.war</Set>
              <Set name="virtualHosts">
                <Array type="java.lang.String">
                  <Item>333.444.555.666</Item>
                  <Item>127.0.0.1</Item>
                  <Item>www.blah.com</Item>
                  <Item>www.blah.net</Item>
                  <Item>www.blah.org</Item>
                </Array>
              </Set>
            </Configure>

        都走 virtual host 了，其 context path 比較可能是 `/`：

            <Set name="contextPath">/</Set>
            <Set name="war"><Property name="jetty.webapps"/>/blah.war</Set>

        注意 `blah.war` 前的 `/`；實驗發現，加了會視為相對於 `$JETTY_HOME/webapps`，不加則會視為相對於 `$JETTY_HOME/`。

## 安裝設置 {: #setup }

### Ubuntu

```
$ sudo apt-get install jetty9
...
Setting up jetty9 (9.4.26-1) ...
Adding system user `jetty' (UID 114) ...
Adding new group `jetty' (GID 120) ...
Adding new user `jetty' (UID 114) with group `jetty' ...
Not creating home directory `/usr/share/jetty9'.
Created symlink /etc/systemd/system/multi-user.target.wants/jetty9.service → /lib/systemd/system/jetty9.service.
Setting up ca-certificates-java (20190405ubuntu1) ...
head: cannot open '/etc/ssl/certs/java/cacerts' for reading: No such file or directory
Adding debian:DST_Root_CA_X3.pem
Adding debian:ACCVRAIZ1.pem
...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
Processing triggers for rsyslog (8.2001.0-1ubuntu1.1) ...
Processing triggers for systemd (245.4-4ubuntu3.6) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for ca-certificates (20210119~20.04.1) ...
Updating certificates in /etc/ssl/certs...
0 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...

done.
done.

$ systemctl status jetty9 | head -10
● jetty9.service - Jetty 9 Web Application Server
     Loaded: loaded (/lib/systemd/system/jetty9.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2021-05-27 09:22:34 CST; 33min ago
       Docs: https://www.eclipse.org/jetty/documentation/current/
   Main PID: 2825 (java)
      Tasks: 24 (limit: 1160)
     Memory: 65.9M
     CGroup: /system.slice/jetty9.service
             └─2825 /usr/bin/java -Djetty.home=/usr/share/jetty9 -Djetty.base=/usr/share/jetty9 -Djava.io.tmpdir=/tmp -jar /usr/share/jetty9/start.jar jetty.state=/var/lib/jetty9/jetty.state jetty-started.xml
```

家目錄在 `/usr/share/jetty9`，主要的設定檔是 `/etc/jetty9/jetty-started.xml`。

```
$ ls -l /usr/share/jetty9/
total 16
drwxr-xr-x  2 root root 4096 May 27 09:22 bin
drwxr-xr-x  2 root root 4096 May 27 09:22 default-root
lrwxrwxrwx  1 root root   11 Jan 28  2020 etc -> /etc/jetty9
drwxr-xr-x 12 root root 4096 May 27 09:22 lib
lrwxrwxrwx  1 root root   15 Jan 28  2020 logs -> /var/log/jetty9
drwxr-xr-x 21 root root 4096 May 27 09:22 modules
lrwxrwxrwx  1 root root   19 Jan 28  2020 start.d -> /etc/jetty9/start.d
lrwxrwxrwx  1 root root   21 Jan 28  2020 start.ini -> /etc/jetty9/start.ini
lrwxrwxrwx  1 root root   24 Jan 28  2020 start.jar -> ../java/jetty9-start.jar
lrwxrwxrwx  1 root root   23 Jan 28  2020 webapps -> /var/lib/jetty9/webapps

$ tree /var/lib/jetty9/webapps/
/var/lib/jetty9/webapps/
├── README.TXT
└── root
    ├── index.html
    └── jetty_banner.gif

1 directory, 3 files
```

原在 8080 port 服務，改 80 port 要修改 `/etc/jetty/start.ini`：

```
$ grep -B2 jetty.port /etc/jetty9/start.ini
# HTTP port to listen on
# Enable authbind in /etc/default/jetty9 to use a port lower than 1024
jetty.port=8080

$ sudo vi /etc/jetty9/start.ini # 改成 jetty.port=80
$ sudo systemctl restart jetty9
```

---

參考資料：

  - [How to Install Jetty on Ubuntu 18\.04 \- RoseHosting](https://www.rosehosting.com/blog/how-to-install-jetty-on-ubuntu-18-04/) (2019-09-23) #ril

    Step 4: Managing the Jetty 9 Service

      - Enable the Jetty 9 at boot time using the following command:

            $ sudo systemctl enable jetty9

      - Start Jetty 9 service using this command:

            $ sudo systemctl start jetty9

        We can restart Jetty 9 using:

            $ sudo systemctl restart jetty9

      - In order to stop Jetty 9, we can use this command:

            $ sudo systemctl stop jetty9

      - We can check the service status using:

            $ systemctl status jetty9

        The output of this command should be similar to this:

            ● jetty9.service - Jetty 9 Web Application Server
               Loaded: loaded (/lib/systemd/system/jetty9.service; enabled; vendor preset: enabled)
               Active: active (running) 
                 Docs: https://www.eclipse.org/jetty/documentation/current/
             Main PID: 19382 (java)
                Tasks: 24 (limit: 2321)
               CGroup: /system.slice/jetty9.service
                       └─19382 /usr/bin/java -Djetty.home=/usr/share/jetty9 -Djetty.base=/usr/share/jetty9 -Djava.io.tmpdir=/tmp -jar /usr/share/jetty9/start.jar jetty.state=/var/lib/jetty9/jetty.state jetty-started.xml

        完整的 log 可以透過 `journalctl -u jetty9` 查看。

  - [How to make Jetty webserver listen on port 80? \- Ask Ubuntu](https://askubuntu.com/questions/30917/how-to-make-jetty-webserver-listen-on-port-80) #ril
  - [Jetty does not want to listen on port 80 \- Stack Overflow](https://stackoverflow.com/questions/16669100/jetty-does-not-want-to-listen-on-port-80) #ril

## 參考資料 {: #reference }

  - [Eclipse Jetty](https://www.eclipse.org/jetty/)
