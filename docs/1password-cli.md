---
title: 1Password / CLI
---
# [1Password](1password.md) / CLI

## CLI

  - [Command Line Password Manager Tool \| 1Password](https://1password.com/downloads/command-line/)

      - Use it your way - You can use the command-line tool as a standalone 1Password client or you can integrate 1Password with your own scripts and workflows.
      - Manage information - Use the command-line tool to manage objects in your account. Add or remove users, vaults, and items with a single command.
      - Easily navigate sessions - Use commands to save SESSION TOKENS to an environment variable and sign in to different accounts. Move between accounts to execute commands.

## 新手上路 {: #getting-started }

  - [1Password CLI: Getting started](https://support.1password.com/command-line-getting-started/#get-started-with-1password-cli)

      - You can use 1Password CLI to work with users, vaults, and items. For example, here’s how to upload a document to your Private vault:

            op create document readme.txt --vault Private

        To see a list of all the items in your Shared vault:

            op list items --vault Shared

      - The output will show the UUIDs of the items. To get the details of an item:

            op get item WestJet

        You can use names or UUIDs in commands that take any user, vault, or item as an argument. Use UUIDs because they’ll NEVER CHANGE, so you can be sure you’re always referring to the same object. It’s also faster and more efficient.

            op get item nqikpd2bdjae3lmizdajy2rf6e

      - You can get details of just the fields you want. For one field, 1Password CLI returns a simple string:

            op get item nqikpd2bdjae3lmizdajy2rf6e --fields password
            5ra3jOwnUsXVjx5GL@FX2d7iZClrrQDc

        For multiple fields, specify them in a comma-separated list. 1Password CLI returns a JSON object:

            op get item nqikpd2bdjae3lmizdajy2rf6e --fields username,password
            {"username": "wendy_appleseed", "password": "5ra3jOwnUsXVjx5GL@FX2d7iZClrrQDc"}

## 安裝設置 {: #setup }

  - [1Password CLI: Getting started > Set up 1Password CLI > Mac](https://support.1password.com/command-line-getting-started/#set-up-1password-cli)

     1. To install the 1Password command-line tool:

        Download 1Password CLI for your platform and architecture.

     2. Move `op` to `/usr/local/bin`, or another directory in your `$PATH`.

     3. To verify the installation, check the version number:

            op --version

    Get started with 1Password CLI

      - The first time you use 1Password CLI, you’ll need to enter your sign-in address and email address:

            op signin example.1password.com wendy_appleseed@example.com

        Then enter your Secret Key and 1Password account password.

      - After you sign in the first time, you can sign in again using your ACCOUNT SHORTHAND, which is your SIGN-IN ADDRESS SUBDOMAIN. `op signin` will prompt you for your account password and output a command that can save your SESSION TOKEN to an environment variable:

            op signin example

            Enter the password for user wendy_appleseed@example.com at example.1password.com:
            export OP_SESSION_example="XLC6cHkeSHByBqrikXt36fdMVLLdHuoACNFUrNMuRXQ"

        Hyphens (`-`) in a subdomain will be changed to an underscore (`_`).

      - To set the environment variable, run the `export` command manually, or use `eval` (Mac, Linux) or `Invoke-Expression` (Windows) to set it automatically.

        On Mac and Linux:

            eval $(op signin example)

        On Windows:

            Invoke-Expression $(op signin example)

        Now that you have a session token, you can start using 1Password CLI. For example, to show all the items in your account:

            op list items

        Session tokens EXPIRE AFTER 30 MINUTES of INACTIVITY, after which you’ll need to sign in again.

## 參考資料 {: #reference }

  - [Command Line Password Manager Tool \| 1Password](https://1password.com/downloads/command-line/)

手冊：

  - [1Password CLI: Reference](https://support.1password.com/command-line-reference/)
