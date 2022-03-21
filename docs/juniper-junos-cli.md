---
title: Juniper / Junos OS / CLI
---
# [Juniper / Junos OS](juniper-junos.md) / CLI

  - [CLI User Guide for Junos OS \| Juniper Networks TechLibrary](https://www.juniper.net/documentation/us/en/software/junos/cli/)

    The Junos OS command-line interface (CLI) is a command shell specific to Juniper Networks. This command shell runs on top of the FreeBSD UNIX-based operating system kernel for Junos OS. Using industry-standard tools and utilities, the CLI provides a powerful set of commands that you can use to monitor and configure Juniper Networks devices running Junos OS. This guide contains information about the CLI for Junos OS.

  - [About the CLI Guide \| CLI User Guide for Junos OS \| Juniper Networks TechLibrary](https://www.juniper.net/documentation/us/en/software/junos/cli/topics/concept/junos-cli-guide-doc-overview.html)

      - The Junos OS CLI Guide explains how to use the command-line interface (CLI). This guide also describes advanced concepts and device configuration when working with Juniper Networks devices running Junos OS.

        In this guide, you will learn about:

          - Using configuration statements to configure network devices
          - Managing device configurations
          - Using operational commands to MONITOR devices
          - Syntax for configuration statements, operational commands, and environmental?? commands

      - For a basic introduction to Junos OS, see the Getting Started Guide for Junos OS. It provides a high-level description of Junos OS, describes how to access devices, and provides simple step-by-step instructions for INITIAL device configuration.
      - For a technical and detailed exploration of Junos OS, see the Overview for Junos OS. It further explains how Junos OS works and describes the security, configuration, monitoring, and management of network devices.

  - [CLI Overview \| CLI User Guide for Junos OS \| Juniper Networks TechLibrary](https://www.juniper.net/documentation/us/en/software/junos/cli/topics/topic-map/cli-overview.html)

      - The CLI is the software interface used to access your device. You use the CLI to configure the device, monitor its operations, and adjust the configuration as needed. You access the CLI through a console connection interface or through a network connection.

    Introducing the Command-Line Interface

      - The Junos OS CLI is a command shell specific to Juniper Networks that runs on top of the operating system kernel. Through industry-standard tools and utilities, the CLI provides a powerful set of commands that you can use to monitor and to configure devices running Junos OS.

      - The CLI has two modes:

          - Operational mode

            Use this mode to DISPLAY the CURRENT STATUS of the device. In operational mode, you enter commands to monitor and to TROUBLESHOOT the network operating system, devices, and network connectivity.

          - Configuration mode

            Use this mode to configure the device. In this mode, you enter statements to configure all properties of the device, including interfaces, general routing information, routing protocols, USER ACCESS, and several system and hardware properties.

      - Junos OS stores a configuration as a HIERARCHY of configuration statements.

        When you enter configuration mode, you are viewing and changing a file called the CANDIDATE CONFIGURATION. You use the candidate configuration file, you make configuration changes without causing operational changes to the current operating configuration, called the ACTIVE CONFIGURATION.

        The device does not implement the changes you added to the candidate configuration file until you COMMIT the changes. Committing the configuration changes activates the revised configuration on the device. Candidate configurations enable you to alter your configuration without damaging your current network operations.

    Key Features of the CLI

      - The CLI commands and statements follow a hierarchical organization and have a regular syntax. The CLI provides the following features to simplify CLI use:

      - Consistent command names

        Commands that provide the same type of function have the same name, regardless of the specific device type on which you are operating. For example, all `show` commands display software information and statistics, and all `clear` commands erase various types of system information.

      - Lists and short descriptions of available commands

        The CLI provides information about available commands at each level of the command hierarchy. If you type a question mark (`?`) AT ANY LEVEL, you see a list of the available commands along with a short description of each.

        This means that if you are already familiar with Junos OS or with other routing software, you can use many of the CLI commands without referring to the documentation.

      - Command completion

        Command completion for command names (keywords) and for command options is available at each level of the hierarchy. To complete a command or option that you have partially typed, press the Tab key or the Spacebar.

        If the partially typed letters begin a string that uniquely identifies a command, the complete command name appears. Otherwise, a beep indicates that you have entered an ambiguous command, and the CLI displays possible completions. Completion also applies to other strings, such as filenames, interface names, usernames, and configuration statements.

        If you have typed the mandatory arguments for executing a command in operational mode or configuration mode, the CLI displays `<[Enter]>` as one of the choices when you type a question mark (`?`). This output indicates that you have entered the mandatory arguments and can execute the command at that level without specifying any further options.

        Likewise, the CLI also displays `<[Enter]>` when you reach a specific hierarchy level in the configuration mode and do not need to enter any more mandatory arguments or statements.

      - Industry-standard technology

        With FreeBSD UNIX as the kernel, a variety of UNIX utilities are available on the CLI. For example, you can:

          - Use regular expression matching to locate and to replace values and identifiers in a configuration, to filter command output, and to examine log file entries.
          - Use EMACS-BASED key sequences to move around on a command line and scroll through the recently executed commands and command output.
          - Store and archive Junos OS device files on a UNIX-based file system.
          - Use standard UNIX conventions to specify filenames and paths.
          - Exit the CLI environment and create a UNIX C shell or Bourne shell to navigate the file system, manage router processes, and so on.

## 參考資料 {: #reference }

  - [CLI User Guide for Junos OS](https://www.juniper.net/documentation/us/en/software/junos/cli/)
