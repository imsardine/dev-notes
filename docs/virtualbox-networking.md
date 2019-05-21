---
title: VirtualBox / Networking
---
# [VirtualBox](virtualbox.md) / Networking

  - [3.9. Network Settings - User Manual](https://www.virtualbox.org/manual/UserManual.html#settings-network)

      - The Network section in a virtual machine's Settings window enables you to configure how Oracle VM VirtualBox PRESENTS VIRTUAL NETWORK CARDS TO YOUR VM, and how they operate.

      - When you first create a virtual machine, Oracle VM VirtualBox by default enables one virtual network card and selects the Network Address Translation (NAT) MODE for it. This way the guest can connect to the outside world using the HOST'S NETWORKING and the outside world CAN connect to services on the guest which you choose to MAKE VISIBLE OUTSIDE of the virtual machine.

        NAT mode 的進階設定裡有 Port Forwarding，可以把 guest OS 的 port 導出。

      - This default setup is good for the majority of Oracle VM VirtualBox users. However, Oracle VM VirtualBox is extremely flexible in how it can virtualize networking. It supports many virtual network cards per virtual machine. The first FOUR virtual network cards can be configured in detail in the VirtualBox Manager window. Additional network cards can be configured using the `VBoxManage` command.
      - Many networking options are available. See Chapter 6, Virtual Networking for more information.

  - [Chapter 6. Virtual Networking - User Manual](https://www.virtualbox.org/manual/UserManual.html#networkingdetails)

      - As mentioned in Section 3.9, “Network Settings”, Oracle VM VirtualBox provides UP TO EIGHT virtual PCI Ethernet cards for each virtual machine. For each such card, you can individually select the following:

          - The HARDWARE that will be virtualized. 要讓 guest OS 看到什麼硬體
          - The VIRTUALIZATION MODE that the virtual card operates in, with respect to your physical networking hardware on the host. 網卡對外的線路要怎麼接，沒有接網路線也是一種選擇。

      - FOUR of the network cards can be configured in the Network section of the Settings dialog in the graphical user interface of Oracle VM VirtualBox. You can configure all EIGHT network cards on the command line using `VBoxManage modifyvm`. See Section 8.8, “VBoxManage modifyvm”.

        不知為何 GUI 跟 CLI 會有 4 張 network interface 的差距？

## 從 Guest 存取 Host 的服務 ?? {: #access-host-from-guest }

  - [Addressing localhost from a VirtualBox virtual machine \- Stack Overflow](https://stackoverflow.com/questions/1261975/) 用 `10.0.2.2` 還真的可以! #ril

