---
title: Docker / Networking
---
# [Docker](docker.md) / Networking

  - [Networking overview \| Docker Documentation](https://docs.docker.com/network/)

      - One of the reasons Docker containers and services are so powerful is that you can connect them together, or connect them to NON-DOCKER WORKLOADS. Docker containers and services do not even need to be aware that they are deployed on Docker, or whether their peers are also Docker workloads or not. Whether your Docker hosts run Linux, Windows, or a mix of the two, you can use Docker to manage them in a PLATFORM-AGNOSTIC WAY.

      - This topic does not go into OS-specific details about how Docker networks work, so you will not find information about how Docker manipulates `iptables` rules on Linux or how it manipulates routing rules on Windows servers, and you will not find detailed information about how Docker forms and encapsulates packets or handles encryption. See [Docker and iptables](https://docs.docker.com/network/iptables/). #ril

  - [Container networking \| Docker Documentation](https://docs.docker.com/config/containers/container-networking/) #ril
  - [Docker container networking \| Docker Documentation](https://docs.docker.com/v17.09/engine/userguide/networking/) #ril

## Network Driver

  - [Network drivers - Networking overview \| Docker Documentation](https://docs.docker.com/network/#network-drivers)

      - Docker’s networking subsystem is PLUGGABLE, using DRIVERS. Several drivers exist by default, and provide core networking functionality:

      - `bridge`: The DEFAULT network driver. If you don’t specify a driver, this is the TYPE OF NETWORK you are creating.

        Bridge networks are usually used when your applications run in STANDALONE containers that need to COMMUNICATE. See [bridge networks](https://docs.docker.com/network/bridge/). #ril

        這裡的 standalone 是什麼意思?? 既是 standalone 又要 communicate?

        USER-DEFINED bridge networks are best when you need multiple containers to communicate ON THE SAME DOCKER HOST.

      - `host`: For standalone containers, remove NETWORK ISOLATION between the container and the Docker host, and use the host’s networking directly.

        `host` is only available for swarm services on Docker 17.06 and higher. See [use the host network](https://docs.docker.com/network/host/). #ril

        Host networks are best when the NETWORK STACK should not be isolated from the Docker host, but you want other aspects of the container to be isolated.

      - `overlay`: Overlay networks connect multiple DOCKER DAEMONS together and enable swarm services to communicate with each other.

        You can also use overlay networks to facilitate communication between a swarm service and a standalone container, or between two standalone containers on different Docker daemons. This strategy removes the need to do OS-LEVEL ROUTING between these containers. See [overlay networks](https://docs.docker.com/network/overlay/). #ril

        Overlay networks are best when you need containers running ON DIFFERENT DOCKER HOSTS to communicate, or when multiple applications work together using swarm services.

      - `macvlan`: Macvlan networks allow you to assign a MAC address to a container, making it appear as a PHYSICAL DEVICE on your network.

        The Docker daemon routes traffic to containers by their MAC addresses. Using the `macvlan` driver is sometimes the best choice when dealing with legacy applications that expect to be directly connected to the physical network, rather than routed through the Docker host’s network stack. See [Macvlan networks](https://docs.docker.com/network/macvlan/). #ril

        Macvlan networks are best when you are MIGRATING FROM A VM SETUP or need your containers to look like physical hosts on your network, each with a unique MAC address.

      - `none`: For this container, disable all networking. Usually used in conjunction with a custom network driver.

        `none` is not available for swarm services. See [disable container networking](https://docs.docker.com/network/none/). #ril

      - [Network plugins](https://docs.docker.com/engine/extend/plugins_services/): You can install and use third-party network plugins with Docker. #ril

        These plugins are available from [Docker Hub](https://hub.docker.com/search?category=network&q=&type=plugin) or from third-party vendors. See the vendor’s documentation for installing and using a given network plugin.

        Third-party network plugins allow you to integrate Docker with specialized network stacks.

        原來 Docker Hub 上除了 container/image，還有 plugin；而且 plugin 有 authorization、logging、network、volume 四種。

  - [EXPOSE - Dockerfile reference | Docker Documentation](https://docs.docker.com/engine/reference/builder/#expose) 最後提到 `docker network` 可以建立一個讓 container 相互溝通的 network (透過任何 port)，不需要 expose/publish 任何 port。
  - [Disable networking for a container \| Docker Documentation](https://docs.docker.com/network/none/) #ril

## Bridge Network

  - Bridge network 完整的說法是 user-defined bridge network，因此 user-defined network 跟 bridge network 指的是相同的東西，但 user-defined network 更強調不是 default `bridge` network。

參考資料：

  - [Use the default bridge network - Networking with standalone containers \| Docker Documentation](https://docs.docker.com/network/network-tutorial-standalone/#use-the-default-bridge-network)

      - In this example, you start two different `alpine` containers on the same Docker host and do some tests to understand how they communicate with each other. You need to have Docker installed and running.

      - Open a terminal window. List current networks before you do anything else. Here’s what you should see if you’ve never added a network or initialized a swarm on this Docker daemon. You may see different networks, but you should at least see these (the network IDs will be different):

            $ docker network ls

            NETWORK ID          NAME                DRIVER              SCOPE
            17e324f45964        bridge              bridge              local
            6ed54d316334        host                host                local
            7092879f2cc8        none                null                local

        注意 `bridge` 跟 `host` 同時做為 network name 跟 driver name，而 `none` 並不是 driver name ??

        別把 "`bridge`: The DEFAULT network driver." 跟 "default `bridge` network" 的 `bridge` 搞混了，前者對應 `docker network create ... --driver="bridge"` 的用法 (這裡的 `bridge` 是 driver name)，後者對應 `docker run ... --network="bridge" 的用法 (這裡的 `bridge` 是 network name)。

      - The default `bridge` network is listed, along with `host` and `none`. The latter two are NOT FULLY-FLEDGED networks, but are used to start a container connected directly to the Docker daemon host’s networking stack, or to start a container with no network devices. This tutorial will connect two containers to the `bridge` network.

      - Start two `alpine` containers running `ash`, which is Alpine’s default shell rather than `bash`. The `-dit` flags mean to start the container detached (in the background), interactive (with the ability to type into it), and with a TTY (so you can see the input and output).

        Since you are starting it detached, you won’t be connected to the container right away. Instead, the container’s ID will be printed. Because you have not specified any `--network` flags, the containers connect to the default `bridge` network.

            $ docker run -dit --name alpine1 alpine ash
            $ docker run -dit --name alpine2 alpine ash

        Check that both containers are actually started:

            $ docker container ls

            CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
            602dbf1edc81        alpine              "ash"               4 seconds ago       Up 3 seconds                            alpine2
            da33b7aa74b0        alpine              "ash"

      - Inspect the `bridge` network to see what containers are connected to it.

            $ docker network inspect bridge

            [
                {
                    "Name": "bridge",
                    "Id": "17e324f459648a9baaea32b248d3884da102dde19396c25b30ec800068ce6b10",
                    "Created": "2017-06-22T20:27:43.826654485Z",
                    "Scope": "local",
                    "Driver": "bridge",
                    "EnableIPv6": false,
                    "IPAM": {
                        "Driver": "default",
                        "Options": null,
                        "Config": [
                            {
                                "Subnet": "172.17.0.0/16",
                                "Gateway": "172.17.0.1"
                            }
                        ]
                    },
                    "Internal": false,
                    "Attachable": false,
                    "Containers": { <-- apline1 跟 alpine2 都連接到 bridge network
                        "602dbf1edc81813304b6cf0a647e65333dc6fe6ee6ed572dc0f686a3307c6a2c": {
                            "Name": "alpine2",
                            "EndpointID": "03b6aafb7ca4d7e531e292901b43719c0e34cc7eef565b38a6bf84acf50f38cd",
                            "MacAddress": "02:42:ac:11:00:03",
                            "IPv4Address": "172.17.0.3/16",
                            "IPv6Address": ""
                        },
                        "da33b7aa74b0bf3bda3ebd502d404320ca112a268aafe05b4851d1e3312ed168": {
                            "Name": "alpine1",
                            "EndpointID": "46c044a645d6afc42ddd7857d19e9dcfb89ad790afb5c239a35ac0af5e8a5bc5",
                            "MacAddress": "02:42:ac:11:00:02",
                            "IPv4Address": "172.17.0.2/16",
                            "IPv6Address": ""
                        }
                    },
                    "Options": {
                        "com.docker.network.bridge.default_bridge": "true",
                        "com.docker.network.bridge.enable_icc": "true",
                        "com.docker.network.bridge.enable_ip_masquerade": "true",
                        "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
                        "com.docker.network.bridge.name": "docker0",
                        "com.docker.network.driver.mtu": "1500"
                    },
                    "Labels": {}
                }
            ]

        Near the top, information about the `bridge` network is listed, including the IP address of the gateway between the Docker host and the `bridge` network (`172.17.0.1`). Under the Containers key, each connected container is listed, along with information about its IP address (`172.17.0.2` for `alpine1` and `172.17.0.3` for `alpine2`).

      - The containers are running in the background. Use the `docker attach` command to connect to `alpine1`.

            $ docker attach alpine1

            / #

        The prompt changes to `#` to indicate that you are the root user within the container. Use the `ip addr show` command to show the network interfaces for `alpine1` as they look from WITHIN THE CONTAINER:

            # ip addr show

            1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
                link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
                inet 127.0.0.1/8 scope host lo
                   valid_lft forever preferred_lft forever
                inet6 ::1/128 scope host
                   valid_lft forever preferred_lft forever
            27: eth0@if28: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP
                link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff
                inet 172.17.0.2/16 scope global eth0
                   valid_lft forever preferred_lft forever
                inet6 fe80::42:acff:fe11:2/64 scope link
                   valid_lft forever preferred_lft forever

        The first interface is the loopback device. Ignore it for now. Notice that the second interface has the IP address 172.17.0.2, which is the same address shown for `alpine1` in the previous step.

      - From within `alpine1`, make sure you can connect to the internet by `pinging google.com`. The `-c 2` flag limits the command to two `ping` attempts.

            # ping -c 2 google.com

            PING google.com (172.217.3.174): 56 data bytes
            64 bytes from 172.217.3.174: seq=0 ttl=41 time=9.841 ms
            64 bytes from 172.217.3.174: seq=1 ttl=41 time=9.897 ms

            --- google.com ping statistics ---
            2 packets transmitted, 2 packets received, 0% packet loss
            round-trip min/avg/max = 9.841/9.869/9.897 ms

      - Now try to ping the second container. First, ping it by its IP address, `172.17.0.3`:

            # ping -c 2 172.17.0.3

            PING 172.17.0.3 (172.17.0.3): 56 data bytes
            64 bytes from 172.17.0.3: seq=0 ttl=64 time=0.086 ms
            64 bytes from 172.17.0.3: seq=1 ttl=64 time=0.094 ms

            --- 172.17.0.3 ping statistics ---
            2 packets transmitted, 2 packets received, 0% packet loss
            round-trip min/avg/max = 0.086/0.090/0.094 ms

        This succeeds. Next, try pinging the `alpine2` container by container name. This will fail.

            # ping -c 2 alpine2

            ping: bad address 'alpine2'

        由於 `alpine1` 與 `alpine2` 處在同一個 network，所以可以 ping 得到，只是下面提到的 automatic service discovery (可以將 container name 解析為 IP) 不會在 default `bridge` network 裡作用。

      - Detach from `alpine1` without stopping it by using the detach sequence, `CTRL + p CTRL + q`. If you wish, attach to `alpine2` and repeat steps 4, 5, and 6 there, substituting `alpine1` for `alpine2`.

        Stop and remove both containers.

            $ docker container stop alpine1 alpine2
            $ docker container rm alpine1 alpine2

        Remember, the default `bridge` network is NOT recommended for production.

  - [Use user-defined bridge networks - Networking with standalone containers \| Docker Documentation](https://docs.docker.com/network/network-tutorial-standalone/#use-user-defined-bridge-networks)

      - In this example, we again start two `alpine` containers, but attach them to a user-defined network called `alpine-net` which we have already created. These containers are not connected to the default `bridge` network at all. We then start a third `alpine` container which is connected to the `bridge` network but not connected to `alpine-net`, and a fourth `alpine` container which is connected to BOTH networks.

      - Create the `alpine-net` network. You do not need the `--driver bridge` flag since it’s the default, but this example shows how to specify it.

            $ docker network create --driver bridge alpine-net

      - List Docker’s networks:

            $ docker network ls

            NETWORK ID          NAME                DRIVER              SCOPE
            e9261a8c9a19        alpine-net          bridge              local
            17e324f45964        bridge              bridge              local
            6ed54d316334        host                host                local
            7092879f2cc8        none                null                local

        Inspect the `alpine-net` network. This shows you its IP address and the fact that no containers are connected to it:

            $ docker network inspect alpine-net

            [
                {
                    "Name": "alpine-net",
                    "Id": "e9261a8c9a19eabf2bf1488bf5f208b99b1608f330cff585c273d39481c9b0ec",
                    "Created": "2017-09-25T21:38:12.620046142Z",
                    "Scope": "local",
                    "Driver": "bridge",
                    "EnableIPv6": false,
                    "IPAM": {
                        "Driver": "default",
                        "Options": {},
                        "Config": [
                            {
                                "Subnet": "172.18.0.0/16",
                                "Gateway": "172.18.0.1"
                            }
                        ]
                    },
                    "Internal": false,
                    "Attachable": false,
                    "Containers": {},
                    "Options": {},
                    "Labels": {}
                }
            ]

        Notice that this network’s gateway is `172.18.0.1`, as opposed to the default `bridge` network, whose gateway is `172.17.0.1`. The exact IP address may be different on your system.

        如果要說明 `bridge` 與 `alpine-net` 是不同的 network，應該要看兩者的 network 不同分別為 `172.17.0.0/16` 與 `172.18.0.0/16`。

      - Create your four containers. Notice the `--network` flags. You can only connect to one network during the `docker run` command, so you need to use `docker network connect` afterward to connect `alpine4` to the `bridge` network as well.

            $ docker run -dit --name alpine1 --network alpine-net alpine ash
            $ docker run -dit --name alpine2 --network alpine-net alpine ash
            $ docker run -dit --name alpine3 alpine ash
            $ docker run -dit --name alpine4 --network alpine-net alpine ash
            $ docker network connect bridge alpine4

        Verify that all containers are running:

            $ docker container ls

            CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
            156849ccd902        alpine              "ash"               41 seconds ago       Up 41 seconds                           alpine4
            fa1340b8d83e        alpine              "ash"               51 seconds ago       Up 51 seconds                           alpine3
            a535d969081e        alpine              "ash"               About a minute ago   Up About a minute                       alpine2
            0a02c449a6e9        alpine              "ash"               About a minute ago   Up About a minute                       alpine1

      - Inspect the `bridge` network and the `alpine-net` network again:

            $ docker network inspect bridge

            [
                {
                    "Name": "bridge",
                    "Id": "17e324f459648a9baaea32b248d3884da102dde19396c25b30ec800068ce6b10",
                    "Created": "2017-06-22T20:27:43.826654485Z",
                    "Scope": "local",
                    "Driver": "bridge",
                    "EnableIPv6": false,
                    "IPAM": {
                        "Driver": "default",
                        "Options": null,
                        "Config": [
                            {
                                "Subnet": "172.17.0.0/16",
                                "Gateway": "172.17.0.1"
                            }
                        ]
                    },
                    "Internal": false,
                    "Attachable": false,
                    "Containers": {
                        "156849ccd902b812b7d17f05d2d81532ccebe5bf788c9a79de63e12bb92fc621": {
                            "Name": "alpine4",
                            "EndpointID": "7277c5183f0da5148b33d05f329371fce7befc5282d2619cfb23690b2adf467d",
                            "MacAddress": "02:42:ac:11:00:03",
                            "IPv4Address": "172.17.0.3/16",
                            "IPv6Address": ""
                        },
                        "fa1340b8d83eef5497166951184ad3691eb48678a3664608ec448a687b047c53": {
                            "Name": "alpine3",
                            "EndpointID": "5ae767367dcbebc712c02d49556285e888819d4da6b69d88cd1b0d52a83af95f",
                            "MacAddress": "02:42:ac:11:00:02",
                            "IPv4Address": "172.17.0.2/16",
                            "IPv6Address": ""
                        }
                    },
                    "Options": {
                        "com.docker.network.bridge.default_bridge": "true",
                        "com.docker.network.bridge.enable_icc": "true",
                        "com.docker.network.bridge.enable_ip_masquerade": "true",
                        "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
                        "com.docker.network.bridge.name": "docker0",
                        "com.docker.network.driver.mtu": "1500"
                    },
                    "Labels": {}
                }
            ]

        Containers `alpine3` and `alpine4` are connected to the `bridge` network.

            $ docker network inspect alpine-net

            [
                {
                    "Name": "alpine-net",
                    "Id": "e9261a8c9a19eabf2bf1488bf5f208b99b1608f330cff585c273d39481c9b0ec",
                    "Created": "2017-09-25T21:38:12.620046142Z",
                    "Scope": "local",
                    "Driver": "bridge",
                    "EnableIPv6": false,
                    "IPAM": {
                        "Driver": "default",
                        "Options": {},
                        "Config": [
                            {
                                "Subnet": "172.18.0.0/16",
                                "Gateway": "172.18.0.1"
                            }
                        ]
                    },
                    "Internal": false,
                    "Attachable": false,
                    "Containers": {
                        "0a02c449a6e9a15113c51ab2681d72749548fb9f78fae4493e3b2e4e74199c4a": {
                            "Name": "alpine1",
                            "EndpointID": "c83621678eff9628f4e2d52baf82c49f974c36c05cba152db4c131e8e7a64673",
                            "MacAddress": "02:42:ac:12:00:02",
                            "IPv4Address": "172.18.0.2/16",
                            "IPv6Address": ""
                        },
                        "156849ccd902b812b7d17f05d2d81532ccebe5bf788c9a79de63e12bb92fc621": {
                            "Name": "alpine4",
                            "EndpointID": "058bc6a5e9272b532ef9a6ea6d7f3db4c37527ae2625d1cd1421580fd0731954",
                            "MacAddress": "02:42:ac:12:00:04",
                            "IPv4Address": "172.18.0.4/16",
                            "IPv6Address": ""
                        },
                        "a535d969081e003a149be8917631215616d9401edcb4d35d53f00e75ea1db653": {
                            "Name": "alpine2",
                            "EndpointID": "198f3141ccf2e7dba67bce358d7b71a07c5488e3867d8b7ad55a4c695ebb8740",
                            "MacAddress": "02:42:ac:12:00:03",
                            "IPv4Address": "172.18.0.3/16",
                            "IPv6Address": ""
                        }
                    },
                    "Options": {},
                    "Labels": {}
                }
            ]

        Containers `alpine1`, `alpine2`, and `alpine4` are connected to the `alpine-net` network.

      - On user-defined networks like `alpine-net`, containers can not only communicate by IP address, but can also resolve a container name to an IP address. This capability is called AUTOMATIC SERVICE DISCOVERY.

        Let’s connect to `alpine1` and test this out. `alpine1` should be able to resolve `alpine2` and `alpine4` (and `alpine1`, itself) to IP addresses.

            $ docker container attach alpine1

            # ping -c 2 alpine2

            PING alpine2 (172.18.0.3): 56 data bytes
            64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.085 ms
            64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.090 ms

            --- alpine2 ping statistics ---
            2 packets transmitted, 2 packets received, 0% packet loss
            round-trip min/avg/max = 0.085/0.087/0.090 ms

            # ping -c 2 alpine4

            PING alpine4 (172.18.0.4): 56 data bytes
            64 bytes from 172.18.0.4: seq=0 ttl=64 time=0.076 ms
            64 bytes from 172.18.0.4: seq=1 ttl=64 time=0.091 ms

            --- alpine4 ping statistics ---
            2 packets transmitted, 2 packets received, 0% packet loss
            round-trip min/avg/max = 0.076/0.083/0.091 ms

            # ping -c 2 alpine1

            PING alpine1 (172.18.0.2): 56 data bytes
            64 bytes from 172.18.0.2: seq=0 ttl=64 time=0.026 ms
            64 bytes from 172.18.0.2: seq=1 ttl=64 time=0.054 ms

            --- alpine1 ping statistics ---
            2 packets transmitted, 2 packets received, 0% packet loss
            round-trip min/avg/max = 0.026/0.040/0.054 ms

      - From `alpine1`, you should not be able to connect to `alpine3` at all, since it is not on the `alpine-net` network.

            # ping -c 2 alpine3

            ping: bad address 'alpine3'

        Not only that, but you can’t connect to `alpine3` from `alpine1` by its IP address either. Look back at the `docker network inspect` output for the `bridge` network and find `alpine3`’s IP address: `172.17.0.2` Try to ping it.

            # ping -c 2 172.17.0.2

            PING 172.17.0.2 (172.17.0.2): 56 data bytes

            --- 172.17.0.2 ping statistics ---
            2 packets transmitted, 0 packets received, 100% packet loss

        合理，因為不在同一個 network 裡。而 automatic service discovery 也只會作用在同一個 user-defined (bridge) network 裡。

        Detach from `alpine1` using detach sequence.

      - Remember that `alpine4` is connected to both the default `bridge` network and `alpine-net`. It should be able to REACH all of the other containers. However, you will need to address `alpine3` by its IP address. Attach to it and run the tests.

            $ docker container attach alpine4

            # ping -c 2 alpine1

            PING alpine1 (172.18.0.2): 56 data bytes
            64 bytes from 172.18.0.2: seq=0 ttl=64 time=0.074 ms
            64 bytes from 172.18.0.2: seq=1 ttl=64 time=0.082 ms

            --- alpine1 ping statistics ---
            2 packets transmitted, 2 packets received, 0% packet loss
            round-trip min/avg/max = 0.074/0.078/0.082 ms

            # ping -c 2 alpine2

            PING alpine2 (172.18.0.3): 56 data bytes
            64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.075 ms
            64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.080 ms

            --- alpine2 ping statistics ---
            2 packets transmitted, 2 packets received, 0% packet loss
            round-trip min/avg/max = 0.075/0.077/0.080 ms

            # ping -c 2 alpine3
            ping: bad address 'alpine3'

            # ping -c 2 172.17.0.2

            PING 172.17.0.2 (172.17.0.2): 56 data bytes
            64 bytes from 172.17.0.2: seq=0 ttl=64 time=0.089 ms
            64 bytes from 172.17.0.2: seq=1 ttl=64 time=0.075 ms

            --- 172.17.0.2 ping statistics ---
            2 packets transmitted, 2 packets received, 0% packet loss
            round-trip min/avg/max = 0.075/0.082/0.089 ms

            # ping -c 2 alpine4

            PING alpine4 (172.18.0.4): 56 data bytes
            64 bytes from 172.18.0.4: seq=0 ttl=64 time=0.033 ms
            64 bytes from 172.18.0.4: seq=1 ttl=64 time=0.064 ms

            --- alpine4 ping statistics ---
            2 packets transmitted, 2 packets received, 0% packet loss
            round-trip min/avg/max = 0.033/0.048/0.064 ms

      - As a final test, make sure your containers can all connect to the internet by pinging `google.com`. You are already attached to `alpine4` so start by trying from there. Next, detach from `alpine4` and connect to `alpine3` (which is only attached to the `bridge` network) and try again. Finally, connect to `alpine1` (which is only connected to the `alpine-net` network) and try again.

            # ping -c 2 google.com

            PING google.com (172.217.3.174): 56 data bytes
            64 bytes from 172.217.3.174: seq=0 ttl=41 time=9.778 ms
            64 bytes from 172.217.3.174: seq=1 ttl=41 time=9.634 ms

            --- google.com ping statistics ---
            2 packets transmitted, 2 packets received, 0% packet loss
            round-trip min/avg/max = 9.634/9.706/9.778 ms

            CTRL+p CTRL+q

            $ docker container attach alpine3

            # ping -c 2 google.com

            PING google.com (172.217.3.174): 56 data bytes
            64 bytes from 172.217.3.174: seq=0 ttl=41 time=9.706 ms
            64 bytes from 172.217.3.174: seq=1 ttl=41 time=9.851 ms

            --- google.com ping statistics ---
            2 packets transmitted, 2 packets received, 0% packet loss
            round-trip min/avg/max = 9.706/9.778/9.851 ms

            CTRL+p CTRL+q

            $ docker container attach alpine1

            # ping -c 2 google.com

            PING google.com (172.217.3.174): 56 data bytes
            64 bytes from 172.217.3.174: seq=0 ttl=41 time=9.606 ms
            64 bytes from 172.217.3.174: seq=1 ttl=41 time=9.603 ms

            --- google.com ping statistics ---
            2 packets transmitted, 2 packets received, 0% packet loss
            round-trip min/avg/max = 9.603/9.604/9.606 ms

            CTRL+p CTRL+q

      - Stop and remove all containers and the `alpine-net` network.

            $ docker container stop alpine1 alpine2 alpine3 alpine4
            $ docker container rm alpine1 alpine2 alpine3 alpine4
            $ docker network rm alpine-net

  - [Use bridge networks \| Docker Documentation](https://docs.docker.com/network/bridge/) #ril

## Port Mapping

  - `docker port CONTAINER` 可以列出 _CONTAINER_ 的 port mappings (running 時才有意義)，也可以搭配 `[PRIVATE_PORT[/PROTOCOL]]` 查詢 container 內的 private port (或稱 container port) 被 map/publish 到 host 的 public port (或稱 host port)。
  - `Dockerfile` 裡的 `EXPOSE` 只是用來說明哪些 container port 可以被 publish，但真正的 publish 發生在 `docker runer` 搭面 `--publish, -p` 或 `--publish-all, -P` 時。
  - 以 `docker run -p 8080:80 -name my-container ...` 為例，用 `docker port my-container 80` (或 `docker port my-container 80/tcp`) 會得到 `0.0.0.0:8080`，而 `docker port my-container 80/udp` 則會丟出 "Error: No public port '80/udp' published for my-container" 的錯誤，注意 public/private port 與 publish 的說法。

參考資料：

  - How to run NGINX as a Docker container - TechRepublic https://www.techrepublic.com/article/how-to-run-nginx-as-a-docker-container/ 提到 `docker run` 時要加 `-p PUBLIC_PORT:PRIVATE_PORT` 做 mapping。
  - docker port | Docker Documentation https://docs.docker.com/engine/reference/commandline/port/ `docker port` 可以列出所有的 port mapping，也可以查詢特定 private port (+ protocol) 是否被 publish 出去，例如 `docker run -p 8080:80 -name my-container...`，用 `docker port my-container 80` (或 `docker port my-container 80/tcp`) 會得到 `0.0.0.0:8080`，而 `docker port my-container 80/udp` 則會丟出 "Error: No public port '80/udp' published for my-container" 的錯誤 (注意 public/private port 與 publish 的說法)
  - docker run | Docker Documentation https://docs.docker.com/engine/reference/commandline/run/ `docker run` 跟 port 相關的參數有 `--publish, -p` - Publish a container’s port(s) to the host，`--publish-all, -P` - Publish all exposed ports to random ports 以及 `--expose` - Expose a port or a range of ports；要 publish 一定要先 expose??
  - EXPOSE - Dockerfile reference | Docker Documentation https://docs.docker.com/engine/reference/builder/#expose `EXPOSE` 只是在說明 container 在 runtime 時有哪些 listen 的 port (TCP/UDP) 可以被 publish，但真正的 publish 發生在 `docker run` 搭配 `--publish, -p` 或 `--publish-all, -P` 時。
  - EXPOSE (incoming ports) - Docker run reference | Docker Documentation https://docs.docker.com/engine/reference/run/#expose-incoming-ports `--link` 可以建立 container 間的連結? 這裡出現 host port 與 container port 的說法 #ril
  - [Exposing a port on a live Docker container \- Stack Overflow](https://stackoverflow.com/questions/19897743/) 從回應整體看起來，事後要做 port mapping 並不容易。
      - reberhardt: 一旦 container 執行起來，可以再做 port mapping 嗎?
      - SvenDowideit: 你不能這麼做，但事實上從 host 可以存取到 un-exposed port? 試不出來 XD
  - [Connect using network port mapping - Legacy container links \| Docker Documentation](https://docs.docker.com/network/links/#connect-using-network-port-mapping) 不知為何要在 link 裡講這麼多 porting mapping? #ril

## Container Link (LEGACY)

  - [Legacy container links \| Docker Documentation](https://docs.docker.com/network/links/)
      - 從 [Use bridge networks](https://docs.docker.com/network/bridge/) 大概可以理解，"link" 專指 `--link`；links between the containers 或 linked container 都跟 `--link` 有關，不同於透過 network 連結的機制。
      - The `--link` flag is a LEGACY feature of Docker. It may eventually be removed. Unless you absolutely need to continue using it, we recommend that you use user-defined networks to facilitate communication between two containers instead of using `--link`. 一開始就說，應該用 user-defined network 來取代 `--link`；不過現在還滿多人在用的...
      - One feature that user-defined networks do not support that you can do with `--link` is sharing environmental variables between containers. However, you can use other mechanisms such as VOLUMES to share environment variables between containers in a more controlled way. 透過 volume 也可以共用環境變數??
      - "legacy container links within the Docker DEFAULT bridge network"、"you can still create links but they behave differently between DEFAULT bridge network and user defined networks" 及 "container linking in DEFAULT bridge network" 等說法，看似 container link 跟 bridge network 有關，只是搭配 default `bridge` network 跟 user-defined network 有不同的效果；事實上這份文件也只講 "legacy link feature in the default bridge network"，也就是 `--network bridge` (或省略)。
      - 前面 Connect using network port mapping 講了一堆，只是為了帶出 Network port mappings are not the only way Docker containers can connect to one another。這裡的 linking system 也可以將多個 container 串接在一起，還有 "send connection information from one to another" -- information about a SOURCE container can be sent to a RECIPIENT container，包括 connectivity information 跟 environment variables。
      - 不過 link 是透過 container name，所以 `docker run` 時用 `--name` 取個易懂的名稱很重要 -- a reference point that allows it to refer to other containers
  - [Communication across links - Legacy container links \| Docker Documentation](https://docs.docker.com/network/links/#communication-across-links)
      - 建立 container 間的 link，就像在 source container 與 recipient container 間拉一條導管 (conduit) 一樣，recipient 可以存取 source 的一些資料。
      - 用 `--link` 建立連結，例如 `docker run -d -P --name web --link db:db training/webapp python app.py`，其中 `--link db:db` 的用法是 `--link CONTAINER[:LINK_ALIAS]`，也就由 `web` 往 `db` 建立一個名稱為 `db` 的 link，但因為是 `web` 收到 `db` 的資訊 -- 在 `web` 裡可以 `ping db`，但 `db` 裡認不得 `ping web`，所以 `web` 是 recipient，而 `db` 才是 source，這跟連線的方向剛好相反。
      - Docker creates a SECURE TUNNEL between the containers that doesn’t need to expose any ports externally on the container. That’s a big benefit of linking: we don’t need to expose the source container.
      - 其實這背後的 magic 是 Docker 會自動調整 recipient container 的 `/etc/hosts`:

            $ docker run -it --rm --name web --link db:mydb alpine cat /etc/hosts
            ...
            172.17.0.2  mydb 09bc088666d2 db <-- container name 跟 link alias 都可以用
            172.17.0.4  83a22c0ed4fc <-- 這是 container 自己

  - [Environment variables - Legacy container links \| Docker Documentation](https://docs.docker.com/network/links/#environment-variables) #ril
  - [Differences between user-defined bridges and the default bridge - Use bridge networks \| Docker Documentation](https://docs.docker.com/network/bridge/#differences-between-user-defined-bridges-and-the-default-bridge) User-defined bridges provide automatic DNS resolution between containers. 也提到 `--link` #ril

## `docker network`, `docker run` ??

  - [Work with network commands \| Docker Documentation](https://docs.docker.com/v17.09/engine/userguide/networking/work-with-networks/) #ril
  - [Network settings - `docker run` | Docker Documentation](https://docs.docker.com/engine/reference/run/#network-settings) #ril
  - [EXPOSE (incoming ports) - `docker run` | Docker Documentation](https://docs.docker.com/engine/reference/run/#expose-incoming-ports) #ril

## Host Network

  - [Use host networking \| Docker Documentation](https://docs.docker.com/network/host/) 只支援 Linux host #ril
      - If you use the `host` network driver for a container, that container’s network stack is not isolated from the Docker host. For instance, if you run a container which binds to port 80 and you use `host` networking, the container’s application will be available on port 80 on the host’s IP address.

        其中 bind 指的是 container 裡的 application 直接在某個 port listen??

      - The host networking driver only works on Linux hosts, and is NOT supported on Docker Desktop for Mac, Docker Desktop for Windows, or Docker EE for Windows Server.

  - [Networking using the host network \| Docker Documentation](https://docs.docker.com/network/network-tutorial-host/) #ril

  - [nginx \- From inside of a Docker container, how do I connect to the localhost of the machine? \- Stack Overflow](https://stackoverflow.com/questions/24319662/) #ril
      - Phil: So I have a Nginx running inside a docker container, I have a mysql running on localhost, I want to connect to the MySql from within my Nginx.
      - Thomasleveil: If you are using Docker-for-mac or Docker-for-Windows 18.03+, just connect to your mysql service using the host `host.docker.internal`.

        As of Docker 18.09.3, this does not work on Docker-for-Linux. A [fix](https://github.com/docker/libnetwork/pull/2348) has been submitted on March the 8th, 2019 and will hopefully be merged to the code base. Until then, a workaround is to use a container as described in qoomon's answer. 看起來，正解就是 `host.docker.internal`

      - Janne Annala: Docker v 18.03 and above (since March 21st 2018) -- Use your internal IP address or connect to the special DNS name `host.docker.internal` which will resolve to the internal IP address used by the host. 所謂 "internal IP" 是 host 在 container 裡的 IP，跟 host 上看到的 IP 不同。

  - [Networking features in Docker Desktop for Mac \| Docker Documentation](https://docs.docker.com/docker-for-mac/networking/) #ril

    I WANT TO CONNECT FROM A CONTAINER TO A SERVICE ON THE HOST

      - The host has a CHANGING IP address (or none if you have NO NETWORK ACCESS). From 18.03 onwards our recommendation is to connect to the special DNS name `host.docker.internal`, which resolves to the internal IP address used by the host. This is for development purpose and will not work in a production environment outside of Docker Desktop for Mac.

        由於 IP 會變動，也可能沒有網路，用虛擬的 `host.docker.internal` 確實是比較好的選擇。

      - The gateway is also reachable as `gateway.docker.internal`. 什麼情況下會用到 gateway??

  - [Docker Tip \#65: Get Your Docker Host's IP Address from in a Container — Nick Janetakis](https://nickjanetakis.com/blog/docker-tip-65-get-your-docker-hosts-ip-address-from-in-a-container) (2018-07-27) #ril

## Overlay Network

  - [Use overlay networks \| Docker Documentation](https://docs.docker.com/network/overlay/) #ril
  - [Networking with overlay networks \| Docker Documentation](https://docs.docker.com/network/network-tutorial-overlay/) #ril

## Macvlan Network

  - [Use Macvlan networks \| Docker Documentation](https://docs.docker.com/network/macvlan/) #ril
  - [Networking using a macvlan network \| Docker Documentation](https://docs.docker.com/network/network-tutorial-macvlan/) #ril

## 參考資料 {: #reference }

  - [docker/libnetwork - GitHub](https://github.com/docker/libnetwork)

手冊：

  - [`docker network` | Docker Documentation](https://docs.docker.com/engine/reference/commandline/network/)
