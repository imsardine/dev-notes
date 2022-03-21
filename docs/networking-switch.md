---
title: Networking / Switch
---
# [Networking](networking.md) / Switch

## Layer 1, 2, 3 {: #layer-123 }

  - [Layer 2 vs Layer 3 Network Switches: What’s the Difference? \| Auvik](https://www.auvik.com/franklyit/blog/layer-3-switches-layer-2/) (2021-02-16)

      - A network switch is a fundamental piece of any network, so it’s critical that you as an IT professional understand the role of a switch in a properly functioning network. And to best understand the difference between Layer 2 switches and Layer 3 switches, you also need to know the difference between Layer 2 and Layer 3 in the OSI networking model.

    Layer 2 vs Layer 3 switches

      - The OSI networking model defines a number of network “layers.” (Getting into each layer is beyond the scope of this article but our Network Management in a Nutshell blog post has a good recap if you want to brush up.)

        Layer 2 of the OSI model is known as the data link layer. The Layer 2 protocol you’re likely most familiar with is Ethernet. Devices in an Ethernet network are identified by a MAC (media access control) address, which is generally hardcoded to a particular device and doesn’t normally change.

      - Layer 3 is the network layer and its protocol is the Internet Protocol or IP. Devices in an IP network are identified by an IP address, which can be dynamically assigned and may change over time. Traditionally, the network device most associated with Layer 3 has been the ROUTER, which allows you to CONNECT DEVICES IN DIFFERENT IP NETWORKS.

    Network switches defined

      - Switches are one of the traffic directors on the network, and traditionally operate at Layer 2. They allow for the connection of multiple devices in a LAN while decreasing the COLLISION DOMAIN by employing PACKET SWITCHING.

        By inspecting the contents of packet headers, a switch builds up a table of MAC ADDRESSES AND THEIR CORRESPONDING PHYSICAL PORTS on the switch to intelligently make decisions on directing future packets.

      - Then, when a packet arrives at the switch, the switch inspects the header of the packet to determine the destination, consults the table of MAC addresses with their corresponding physical ports, and makes a decision on which physical port to send the packet out to.

        ![](https://www.auvik.com/wp-content/uploads/2021/02/layer-3switches-diagram4.jpg)

      - Switches can get a bit more complicated when you introduce VLANs (virtual LANs). VLANs allow you to carve off components of one physical device into different networks, essentially separating one network of physically connected devices into multiple LOGICAL NETWORKS that can’t directly communicate with one another.

        VLANs support one of the tenets of good network design: NETWORK SEGMENTATION.

    Bringing it all together

      - For two devices to communicate across a typical business or home network, they need to have both an IP address, associated with Layer 3 (the IP layer), and a MAC address, associated with Layer 2 (the Ethernet layer).

      - In legacy networks, built before there were smart switches capable of supporting VLANs, the only way for two devices on separate Layer 2 Ethernet networks was to be ROUTED between those two networks. The routing was done by a Layer 3 device called… a ROUTER.

        ![](https://www.auvik.com/wp-content/uploads/2021/02/layer-3-switches-diagram1.jpeg)

        As network technologies progressed and VLANs were introduced, MANAGED switches gained the ability to connect two devices on separate Ethernet networks.

        While this reduced the need to have different physical switches for each Ethernet network, devices connected into two SEPARATE VLANs still needed to communicate through a Layer 3 device, which in most networks was a router.

        問題從 separate L2 network 變成 separate VLAN，還是要有 router；不過這裡講的是有 VLAN 能力的 L2 switch。

        ![](https://907162.smushcdn.com/2195243/wp-content/uploads/2021/02/SwitchDiagram2-update-v02.jpg?lossy=0&strip=1&webp=1)

      - Then came the Layer 3 switch. This device operates at BOTH Layer 2 and Layer 3, allowing devices connected to different VLANs to communicate with one another without going through a DEDICATED router.

        It’s important to note the traffic is still being routed, as this is the TERMINOLOGY we use to describe information TRANSFERRED BETWEEN NETWORKS AT LAYER 3. The routing is simply being done by the switch instead of a dedicated router.

      - So does this mean that all Layer 3 switches do routing? Not exactly.

        Just because a device is Layer 3-capable, doesn’t necessarily mean the device is performing routing. As a network administrator, you need to configure the device to route traffic between VLANs if that’s what you want. You can have a Layer 3-capable switch operating in Layer 2-only MODE.

        With the functionality of most managed switches today, having your switch act as a Layer 3 device is an option on all but the most entry-level switches.

      - So what happens when a Layer 3 switch receives a packet from an end device? When inspecting the packet header, if that packet is destined for another VLAN, the Layer 3 switch “ELEVATES” the packet to the ROUTING LAYER.

        A decision is then made at the Layer 3 routing layer on where to send the packet—the switch consults the MAC address forwarding table to decide which port to send the outgoing packet on.

        ![](https://www.auvik.com/wp-content/uploads/2021/02/layer-3-switches-diagram3.jpg)

        And there you have it: a switch that makes routing decisions on traffic and therefore operates at Layer 3.

    When should you use Layer 3 switches?

      - The recommendation on whether to use a switch at Layer 2 or a Layer 3 depends in part on the size and complexity, and the security requirements, of the network you’re managing.

      - When designing your network topology, consider some of the following points:

          - Is more than one VLAN required for the network? Layer 3 switches are useful when you have more than one VLAN needing to communicate with one another.

          - Does your network consist of dozens, hundreds, or thousands of users? As the size of your network grows, you’ll need more than one switch to physically connect all of the users.

            In this case, you may find you need a MIX Of Layer 2 switches and a Layer 3 device (switch, dedicated router, or firewall) to perform the Layer 3 functions.

          - Does your security policy require putting ACCESS CONTROL RULES between devices on different networks, or doing deep packet inspection on traffic between networks?

            If so, having a FIREWALL PERFORM THE LAYER 3 function may be better suited.

          - How do you plan on managing your network infrastructure? With the introduction of Layer 3 switches, it may be possible to reduce the number of network devices on your network, which may simplify some of the device management, including things like patching and policy updates.

    Pros and cons of Layer 3 switches

      - Why would you choose to use a Layer 3 switch? What are the pros and cons?

        Pros:

          - In most cases, introducing a Layer 3 switch reduces the number of network devices you need to monitor, manage, and maintain.
          - You reduce or eliminate the need for dedicated routers in your network by pushing the Layer 3 function to EITHER THE FIREWALL OR THE LAYER 3 SWITCH.

        Cons:

          - While Layer 3 switches are typically competitively priced, if your budget is limited you may not have a lot of choice when looking for Layer 3-capable switches.
          - If the size of your network is relatively small, adding a Layer 3 switch may increase complexity without providing much in the way of additional benefits.

    What about routers?

      - With all this talk about Layer 3 switches, are dedicated routers a thing of the past? In most small to midsize networks, a dedicated router for intra-office communication is no longer required.

        For example, if you put your users on a separate VLAN from your network infrastructure like servers, then the routing of traffic between the users and the server can be done on either a Layer 3 switch or a firewall. No need for a dedicated router.

      - But routers do still have an important role to play in many business networks, especially for communication outside of the local network.

        Connecting to remote offices or the internet requires connecting to a non-Ethernet network, like that provided by your ISP, and this is where routers shine. Routers can also be found in larger enterprise networks where routers are often still a dedicated device.

## Core vs. Edge Switch {: #core-vs-edge }

  - [Core Switch & Edge Switch: How to Make a Decision? \| by Miko Wong \| Medium](https://medium.com/@mikowong405/core-switch-edge-switch-how-to-make-a-decision-be4319e90216) (2017-10-27) #ril

      - When considering buying a new switch for your small business, you need to ask yourself a few questions: How many devices will the switch need to support? What kinds of devices will I be connecting? Has our network grown to the point where we need a switch with more advanced MANAGEMENT CAPABILITIES? And here is an important decision you are going to make: whether CORE or EDGE for your network.

    What Is A Core Switch?

      - A core switch, is also known as a BACKBONE switch. It is a HIGH-CAPACITY switch generally positioned within the backbone or physical core of a network.

        Core switches serve as the gateway to a wide area network (WAN) or the Internet — they provide the FINAL AGGREGATION POINT for the network and allow multiple aggregation modules to work together.

      - You use it to connect to servers, your Internet service provider (ISP) via a router, and to aggregate all switches that your company uses to connect crucial pieces of equipment that your company can’t afford to lose to downtime. As a result, your core switch should always be a FAST, FULL-FEATURED MANAGED switch.

    What Is An Edge Switch?

      - An edge switch also is called an ACCESS NODE or a SERVICE NODE. It is a switch located at the MEETING POINT OF TWO NETWORKS.

        These switches connect end-user local area networks (LANs) to Internet service provider (ISP) networks. Edge switches can be routers, routing switches, integrated access devices (IADs), multiplexers and a variety of MAN and WAN devices that provide ENTRY POINTS INTO ENTERPRISE OR SERVICE PROVIDER CORE NETWORKS.

      - Edge switches can directly connect client devices, such as laptops, desktops, security cameras, and wireless access points, to your network.

    Core Switch vs. Edge Switch

      - Generally speaking, a core switch would have more up-market features such as higher backplane speed, LAYER 3 including routing protocols such as OSPF, and physical redundancy features such as removable PSUs. They might not have any COPPER PRESENTATION?? at all.

        A core switch will typically have deeper buffers, such that multiple connections can be experiencing congestion. ??

      - Edge switches are what your desktops and phones plug directly into (at the “EDGE OF THE NETWORK”). Typically they are lighter on features and more about COPPER PORT count and some form of fibre interface into the backbone / core.

  - [Core Switch vs Normal Switch: What Is the Difference?](http://www.fiber-optic-cable-sale.com/core-switch-edge-switch-difference.html) (2018-07-25) #ril
  - [架設大型網路一定要使用Core Switch 嗎? \| johngb RC](https://johngb63.wordpress.com/2008/03/01/架設大型網路一定要使用core-switch-嗎/) (2008-03-01)


