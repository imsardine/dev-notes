# Vault

  - [Vault by HashiCorp](https://www.vaultproject.io/) #ril

      - Manage Secrets and Protect Sensitive Data

        Secure, store and tightly control access to tokens, passwords, certificates, encryption keys for protecting secrets and other sensitive data using a UI, CLI, or HTTP API.

## 新手上路 {: #getting-started }

  - [Getting Started - Vault Curriculum \- HashiCorp Learn](https://learn.hashicorp.com/vault/#getting-started) #ril

## 安裝設置 {: #setup }

  - [Download Vault \- Vault by HashiCorp](https://www.vaultproject.io/downloads.html)

    These are the available downloads for the latest version of Vault (1.1.3). Please download the proper package for your operating system and architecture.

    分 Mac OS X、Windows、Linux 等不同平台的下載，但檔案都是 `vault_*.zip`。

  - [Install Vault \| Vault \- HashiCorp Learn](https://learn.hashicorp.com/vault/getting-started/install)

      - Vault must first be installed on your machine. Vault is distributed as a binary package for all supported platforms and architectures.

    Installing Vault

      - To install Vault, find the appropriate package for your system and download it. Vault is packaged as a zip archive.

        After downloading Vault, unzip the package. Vault runs as a SINGLE BINARY named `vault`. Any other files in the package can be safely removed and Vault will still function.

      - The final step is to make sure that the `vault` binary is available on the `PATH`.

     Verifying the Installation

      - After installing Vault, verify the installation worked by opening a new terminal session and checking that the `vault` binary is available. By executing `vault`, you should see help output similar to the following:

    Command Completion

      - Vault also includes command-line completion for subcommands, flags, and path arguments where supported. To install command-line completion, you must be using Bash, ZSH or Fish. Unfortunately other shells are not supported at this time.

      - To install completions, run:

            $ vault -autocomplete-install

        This will automatically install the helpers in your `~/.bashrc` or `~/.zshrc`, or to `~/.config/fish/completions/vault.fish` for Fish users. Then restart your terminal or reload your shell:

            $ exec $SHELL

        Now when you type `vault <tab>`, Vault will suggest options. This is very helpful for beginners and advanced Vault users.

  - [Starting the Server \| Vault \- HashiCorp Learn](https://learn.hashicorp.com/vault/getting-started/dev-server) #ril

      - With Vault installed, the next step is to start a Vault server.

        Vault operates as a client/server application. The Vault server is the only piece of the Vault architecture that interacts with the data storage and backends. All operations done via the Vault CLI interact with the server over a TLS connection.

        In this page, we'll start and interact with the Vault server to understand how the server is started.

    Starting the Dev Server

      - First, we're going to start a Vault DEV SERVER. The dev server is a built-in, pre-configured server that is NOT VERY SECURE but useful for playing with Vault locally. Later in this guide we'll configure and start a REAL SERVER.

        To start the Vault dev server, run:

            $ vault server -dev

            ==> Vault server configuration:

                         Api Address: http://127.0.0.1:8200
                                 Cgo: disabled
                     Cluster Address: https://127.0.0.1:8201
                          Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
                           Log Level: (not set)
                               Mlock: supported: false, enabled: false
                             Storage: inmem
                             Version: Vault v1.0.2
                         Version Sha: 37a1dc9c477c1c68c022d2084550f25bf20cac33

            WARNING! dev mode is enabled! In this mode, Vault runs entirely in-memory
            and starts unsealed with a single unseal key. The root token is already
            authenticated to the CLI, so you can immediately begin using Vault.

            You may need to set the following environment variable:

                $ export VAULT_ADDR='http://127.0.0.1:8200'

            The unseal key and root token are displayed below in case you want to
            seal/unseal the Vault or re-authenticate.

            Unseal Key: 1+yv+v5mz+aSCK67X6slL3ECxb4UDL8ujWZU/ONBpn0=
            Root Token: s.XmpNPoi9sRhYtdKHaQhkHP6x

            Development mode should NOT be used in production installations!

            ==> Vault server started! Log data will stream in below:

            # ...

        You should see output similar to that above. Vault does not fork, so it will continue to run in the foreground. Open another shell or terminal tab to run the remaining commands.

      - The dev server stores all its data IN-MEMORY (but still encrypted), listens on localhost without TLS, and automatically UNSEALS ?? and shows you the UNSEAL KEY and ROOT ACCESS KEY.

        Warning: Do not run a dev server in production!

      - With the dev server running, do the following three things before anything else:

          - Launch a new terminal session.
          - Copy and run the export `VAULT_ADDR ...` command from the terminal output. This will configure the Vault client to talk to our dev server.
          - Save the unseal key somewhere. Don't worry about how to save this securely. For now, just save it anywhere.
          - Copy the generated Root Token value and set is as `VAULT_DEV_ROOT_TOKEN_ID` environment variable:

               $ export VAULT_DEV_ROOT_TOKEN_ID="s.XmpNPoi9sRhYtdKHaQhkHP6x"

    Verify the Server is Running

      - As instructed, copy and execute export `VAULT_ADDR='http://127.0.0.1:8200'`.

      - Verify the server is running by running the `vault status` command. This should succeed and exit with exit code 0.

        If it ran successfully, the output should look like the following:

            $ vault status

            Key             Value
            ---             -----
            Seal Type       shamir
            Initialized     true
            Sealed          false
            Total Shares    1
            Threshold       1
            Version         1.0.2
            Cluster Name    vault-cluster-3cdf26fe
            Cluster ID      08082f3a-b58d-1abf-a770-fbb8d87359ee
            HA Enabled      false

        If the output looks different, especially if the numbers are different or the Vault is sealed, then restart the dev server and try again. The only reason these would ever be different is if you're running a dev server from going through this guide previously.

## 參考資料 {: #reference }

  - [Vault by HashiCorp](https://www.vaultproject.io/)
  - [hashicorp/vault - GitHub](https://github.com/hashicorp/vault)
