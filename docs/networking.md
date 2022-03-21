# Networking

## Diagram

  - [How to Draw Network Diagrams \|Auvik Networks Inc\.](https://www.auvik.com/franklyit/blog/effective-network-diagrams/) (2021-03-08)

      - Drawing a good network diagram isn’t hard to make, but it can be distressingly rare. Even network engineers with years of experience often draw network diagrams that are jumbled and hard to understand.

        不難，但畫得好的不多。

    The importance of a network diagram

      - As a network administrator responsible for the network, it’s vitally important you have a detailed understanding of your network topology. Without this information, EVEN BASIC TROUBLESHOOTING CAN BE UNNECESSARILY DIFFICULT. You’ll find that troubleshooting is much easier if you have DETAILED and UP-TO-DATE network documentation.

    Things to keep in mind when drawing a network diagram

      - The important thing is to be clear in your own mind about WHAT INFORMATION you’re trying to CONVEY. It’s better to draw SEVERAL DIAGRAMS that show DIFFERENT ASPECTS of the same network than to try to put everything on one sheet of paper.

        跟 UML 有不同圖形一樣。

      - Start by separating network diagrams by network protocol layers (指 layer 1, 2, 3). In more complicated networks, I recommend adding diagrams showing TRAFFIC FLOWS, routing protocol distribution mechanisms??, VPNs, and other important aspects of the network design.

        It’s important to draw each of these as separate pictures because they show different things. Combining them only confuses the information and makes the drawing harder to understand.

      - Typically you’ll be deploying the network to support some sort of application. And that will involve some client and server devices. It might involve an internet connection and perhaps some firewalls.

        In a large organization, there could be a SEPARATE PERSON responsible for each of these areas, which is when a WHITEBOARD might be a useful place to start.

    Drawing Layer 3 diagrams

      - I always START WITH lAYER 3 diagrams, which show the IP SUBNETS and all Layer 3 network devices like ROUTERS, FIREWALLS, and LOAD BALANCERS. The Layer 3 diagram must show all of the important network SEGMENTS and SUBNETS and how they’re interconnected.

      - The layout is important. I like to show the layout so that it represents the FLOW OF TRAFFIC in a BROAD SENSE. For example, if I have a bunch of servers being accessed by a group of users, I’ll try to put the user network segments on one side of the picture and the servers on the other side.

        ![](https://907162.smushcdn.com/2195243/wp-content/uploads/2015/09/network-diagrams-layer-3-topology_1.jpg?lossy=1&strip=1&webp=1)

        Similarly, if I want to show how a LAN connects to external networks like the internet, I group the external networks all on one side or at the top of the picture.

        Or, if the point of the picture is to show a WAN with a large number of remote offices connecting to the same network, I’d probably show the connecting WAN in the middle of the picture and the various remote sites around the edge of the page.

      - Another layout consideration is to always draw your network segments either HORIZONTALLY OR VERTICALLY. The only time I use a combination of vertical and horizontal is when I want to show a fundamental difference between the functions of the segments.

        For example, I might draw all of my workstation and server segments horizontally but then draw a special common network management segment vertically down one side of the page. This makes it immediately obvious that the management segment is SPECIAL.

      - The Layer 3 diagram should show any HIGH AVAILABILITY mechanisms and REDUNDANT NETWORK components or REDUNDANT PATHS??. It’s customary to show router redundancy protocols as an elongated ellipse that covers the router links included in the high availability group.

      - The other important thing about Layer 3 diagrams is that they should only include Layer 3 objects. I DON’T WANT TO SEE SWITCHES in a Layer 3 diagram, for example. I don’t want to see any kind of indication of trunk links on a Layer 3 diagram either.

        You can show a switch on a Layer 3 diagram only if it’s a Layer 3 switch, and then only because it FUNCTIONS AS A ROUTER. Including Layer 2 objects like a switch in a Layer 3 diagram is confusing, particularly in more complicated pictures.

      - Another useful thing to put into a Layer 3 diagram is ORGANIZATIONAL BOXES. If there are SECURITY ZONES or interesting groupings of users by function or servers by application, put them together on the picture, put a box around them, and label the box clearly. It’s then easy to see the exact NETWORK PATH those users take to reach their servers.

    Drawing Layer 2 diagrams

      - Layer 2 diagrams show Layer 2 objects like SWITCHES and TRUNKS. They include critical information like which VLANs are included in which trunks and they show spanning-tree parameters like bridge priorities and port costs.??

        In many cases, this is too much information to show easily, so I generally use callout boxes to hold some of the information.

      - Unlike Layer 3 pictures, Layer 2 diagrams DON’T NEED TO be laid out in any special way. The most important thing is to keep the picture clear. 跟 Layer 3 的圖是同一個例子。

        ![](https://www.auvik.com/wp-content/uploads/2015/09/network-diagrams-layer-2-topology_1.jpg)

        If two devices are intended to provide redundancy for one another, then their positions on the page should be related. They should either be located beside one another or in parallel locations on opposite sides of the picture.

      - If there are different LINK SPEEDS, they should be indicated in the diagram. I usually show link speed with the THICKNESS of my diagram’s connecting lines. The faster the link, the thicker the line.

        Sometimes I also use color to indicate special properties of different physical links. For example, I might make fiber optic cables red and copper cables blue. (Technically the cable type is Layer 1 information, but because it doesn’t tend to cause confusion in the picture, it’s alright to include it in your Layer 2 diagram.)

    Drawing Layer 1 diagrams

      - I usually use Layer 1 diagrams to show PHYSICAL CONNECTIONS between devices, but they’re also useful for showing cabinet (機櫃) layouts.

      - Layer 1 diagrams should show PORT NUMBERS and indicate CABLE TYPES. In a network that includes many different types of cables, such as fiber optic cables, Category 5/6/7 copper cabling, and so forth, it’s useful to give each cable type a DIFFERENT COLOR.

        If there are PATCH PANELS (配線架/插線板), particularly if you want to document how patch panel ports map to device locations and switch port numbers, this information belongs on the Layer 1 diagram.

      - And if there are different LINK SPEEDS, you might want to give them different LINE WEIGHTS, as described previously for Layer 2 diagrams.

        ![](https://www.auvik.com/wp-content/uploads/2015/09/network-diagrams-layer-1-topology_1.jpg)

      - Another type of diagram that’s often useful in data center designs is a CABINET LAYOUT. It’s a diagram that shows exactly what you would see when looking at the FRONT (and sometimes also the BACK) of the cabinet.

        A cabinet layout is helpful when you need to tell a REMOTE TECHNICIAN how to find a certain piece of equipment.

    Drawing combined-layer diagrams

      - There’s one very special type of diagram in which it’s possible to combine Layer 2 and 3 in a single picture. Such a combined diagram is sometimes useful if you have combined Layer 2 and 3 switches and you need to show the RELATIONSHIP BETWEEN THESE LAYERS.

      - A combined diagram is sometimes useful if you have combined Layer 2 and 3 switches and you need to show the RELATIONSHIP BETWEEN THESE LAYERS.

        A combined-layer view is also useful when thinking about things like HSRP configuration. Which switch will be the default gateway for each VLAN? And, related to this, will the packets from A to B take the same path as the packets from B to A? None of these details appear in the pure Layer 2 or the pure Layer 3 picture. ??

        Instead, we show the relationship in a combined-layer diagram by drawing boxes for the Layer 2 switch with the VLANs inside it, connected to the Layer 3 router, also inside the switch. The VLANs are connected to trunk interfaces to another Layer 2/3 switch.

      - Note that while this diagram can show the interaction between the layers, it doesn’t make either the Layer 2 or Layer 3 network design terribly clear. I’d actually draw all three as separate diagrams, each showing a different important aspect of the network design.

    How to Draw Effective Network Diagram

      - Follow these guidelines and you’ll be setting yourself up for drawing network diagrams that are easy-to-read, and EASY-TO-SHARE. To help summarize, we’ve included a handy infographic below.

        把 VLAN 畫在 Layer 3? 但 VLAN 確實是 network segement

      - Follow these tips to create readable and easy-to-understand network maps that will help you and your team more effectively manage your IT infrastructure.

      - Common Network Diagram Symbols

          - Shapes, Markings
          - Hand-drawn - use on a whiteboard or in your notebook
          - Visio - when you're manually mapping
          - Auvik - when you're automated mapping

        TIP: Clarity is key. Make a separate diagram for each network protocol layer. This make the diagrams much easier to understand.

      - Start with layer 3

        Include:

          - IP subnets
          - All Layer 3 network devices (routers, firewalls, etc)
          - All the important network segments
          - How the segements are interconnected

        Sometimes there's a different sort of segment, such as device management ore backups, that's somehow RELATED TO SEVERAL OTHER AREAS. You might want to draw this in the other direction.

        Draw your network segments either horizontally or vertically. Here, subnets are drawn horizontally and organized vertically with the Internet at the top.

        TIP: Complicatedd network design? Draw a base Layer 3 diagram with VLANS, routers, and firewalls. Then layer over a separate diagram for ROUTING PROTOCOLS, another for VPNs, and another for APPLICATION DATA FLOW.

      - Next, draw layer 2

        Include:

          - All Layer 2 objects (switches, trunks, etc)
          - Which VLANs are included in which trunks ??
          - Spanning tree parameters

        If 2 devices are redundant to each other, put them side by side or in parallel locations.

      - Finish off with layer 1

        Use different line weights to indicate speed. The thicker the line, the faster the line.

        Use different colors for different cable types. For example, fiber might be red while copper is blue.

  - [How to Draw Clear L3 Logical Network Diagrams \- Packet Pushers](https://packetpushers.net/how-to-draw-clear-l3-logical-network-diagrams/) (2013-01-07)

      - The biggest single problem I’m seeing when working on ENTERPRISE networks is the lack of L3 logical network diagrams. Most of the time I’m facing situations where a customer doesn’t have any LOGICAL network diagrams to give.

        L3 diagrams are vital for TROUBLESHOOTING or for PLANNING CHANGES. Also, logical diagrams are in many cases MORE VALUABLE THAN PHYSICAL ONES.

      - Sometimes I see “LOGICAL-PHYSICAL-HYBRID” diagrams that are mostly USELESS. If you don’t know your network logical topology, you are BLIND. Generally, it seems it is an uncommon skill to be able to visualize networks logically. For this reason, I’m writing  about drawing clear logical network diagrams.

    What information should be represented in L3 diagram?

      - To be able to draw a logical network diagram, you should know exactly what information is presented in which diagram. If you don’t, you’ll start to mix information and end up with those useless hybrid diagrams.

        Good L3 diagrams consist of the following information:

          - Subnets

              - VLAN IDs
              - Names
              - Network address and subnet mask

          - L3 Devices

              - At least Routers, Firewalls, VPN devices
              - Most important servers (Such as DNS servers etc.)
              - Their IP -addresses
              - Logical interfaces

          - Routing protocol?? information

    What information should NOT be represented in L3 diagram?

      - Following information should not be presented in L3 diagrams, because it really belongs to another layer, and therefore should be presented in that level documentation:

          - Basically all L2 and L1 information
          - L2 switches (Only the MANAGEMENT INTERFACE can be presented)
          - Physical connections

    Symbols used in L3 diagrams

      - Generally, logical symbols are used in logical diagrams. Most of them are self-explanatory, but since I’ve seen mistakes, here are a couple of examples.

      - A subnet is represented as a pipe or line:

        ![](https://packetpushers.net/wp-content/uploads/2012/12/subnet.jpg)

      - A VRF?? or some area not exactly known is represented as a cloud:

        ![](https://packetpushers.net/wp-content/uploads/2012/12/cloud.jpg)

    What information do you need to be able to draw L3 diagram?

      - To be able to create a logical network diagram, you first need to have following information:

          - L2 (or L1) diagram – presenting physical connections between L3 devices and switches.
          - L3 device configurations – text files or access to GUI, etc.
          - L2 device configurations – text files or access to GUI, etc.

        這意謂著，要從 L1, L2 開始畫起?

## 參考資料 {: #reference }

更多：

  - [Switch](networking-switch.md)

