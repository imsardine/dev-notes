# Palo Alto (PA)

## PA-800 Series {: #pa800 }

  - [PA\-800 Firewall Overview](https://docs.paloaltonetworks.com/hardware/pa-800-hardware-reference/pa-800-firewall-overview.html)

      - The Palo Alto Networks® PA-800 Series next-generation firewalls are designed for DATA CENTER and INTERNET GATEWAY deployments. This series is comprised of PA-820 and PA-850 firewalls.

        These models provide flexibility in performance and REDUNDANCY to help you meet your deployment requirements. All models in this series provide next-generation security features to help you secure your organization through advanced visibility and control of applications, users, and content.

      - First Supported Software Release: PAN-OS® 8.0 -- 也就是 Web 管理介面的版本

  - [PA\-800 Front Panel](https://docs.paloaltonetworks.com/hardware/pa-800-hardware-reference/pa-800-firewall-overview/pa-800-front-panel.html) #ril

    The following image shows the front panel of the PA-800 Series firewall and the table describes each front panel component. The only differences between the PA-820 (shown) and PA-850 front panel is the model name and the Ethernet port speeds as described in the table.

    ![](https://docs.paloaltonetworks.com/content/dam/techdocs/en_US/dita/_graphics/uv/hardware/pa-800/front-panel-820.png/_jcr_content/renditions/original)

     1. Ethernet ports 1 through 4

        Four RJ-45 10/100/1000Mbps ports for network traffic. You can set the link speed and duplex or choose auto-negotiate.

     2. SFP ports 5 through 8

        Four small form-factor pluggable (SFP) ports for network traffic. ??

     3. SFP/SFP+ ports 9 through 12

        These ports are for network traffic and their speed varies depending on your firewall and configuration. #ril

     4. HA1 and HA2 ports

        Two RJ-45 10/100/1000Mbps ports for high-availability control (HA1) and synchronization (HA2).

     5. MGT port

        Use this Ethernet 10/100/1000Mbps port to access the management web interface and perform administrative tasks. The firewall also uses this port for management services, such as retrieving licenses and updating the threat and application signatures.

        Web UI 從這個 port 對外提供。

     6. CONSOLE port (RJ-45)

        Use this port to connect a management computer to the firewall using a 9-pin serial to RJ-45 cable and terminal emulation software.

        The console connection provides access to firewall boot messages, the Maintenance Recovery Tool (MRT), and the command line interface (CLI).

        用 CLI 的好處是容易跟他人分享 session。

        If your management computer does not have a serial port, use a USB-to-serial converter. 也就是 USB -> serial -> RJ-45，不過下面還有個 Micro USB 的 console port。

        Use the following settings to configure your terminal emulation software to connect to the console port:

          - Data rate: 9600
          - Data bits: 8
          - Parity: none
          - Stop bits: 1
          - Flow control: None

     7. USB port

        Use the USB port to bootstrap the firewall. 什麼時候要做 bootstrap??

        Bootstrapping enables you to provision the firewall with a specific PAN-OS configuration and then license it and make it operational on your network.

     8. CONSOLE port (Micro USB)

        Use this port to connect a management computer to the firewall using a standard Type-A USB-to-micro USB cable.

        The console connection provides access to firewall boot messages, the Maintenance Recovery Tool (MRT), and the command line interface (CLI).

        Refer to [Micro USB Console Port](https://docs.paloaltonetworks.com/resources/micro-usb-console-port) #ril for more information and to download the Windows driver or to learn how to connect from a Mac or Linux computer.

     9. LED status indicators

        Six LEDs that indicate the status of the firewall hardware components (see [Interpret the LEDs on a PA-800 Series Firewall](https://docs.paloaltonetworks.com/hardware/pa-800-hardware-reference/service-the-pa-800-series-firewall-hardware/interpret-the-leds-on-a-pa-800-series-firewall.html)). #ril

  - [PA\-800 Back\-Panel](https://docs.paloaltonetworks.com/hardware/pa-800-hardware-reference/pa-800-firewall-overview/pa-800-back-panel.html) #ril

## PAN-OS

  - [PAN\-OS](https://docs.paloaltonetworks.com/pan-os.html)

      - PAN‑OS® is the software that runs all Palo Alto Networks® next-generation firewalls.

        By leveraging the key technologies that are built into PAN‑OS natively—App‑ID, Content‑ID, Device-ID, and User‑ID—you can have complete visibility and control of the applications in use across all users and devices in all locations all the time.

        可以針對 application、content、device、user 做不同維度的管控。

      - And, because inline ML and the application and threat signatures automatically reprogram your firewall with the latest intelligence, you can be assured that all traffic you allow is free of known and UNKNOWN threats.

  - [Getting Started](https://docs.paloaltonetworks.com/pan-os/8-1/pan-os-admin/getting-started.html) #ril

## 參考手冊 {: #reference }

  - [PA-800 Series Next-Gen Firewall Hardware Reference](https://docs.paloaltonetworks.com/hardware/pa-800-hardware-reference.html)
  - [PAN-OS](https://docs.paloaltonetworks.com/pan-os.html)
