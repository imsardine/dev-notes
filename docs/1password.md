# 1Password

  - [Password Manager for Families, Businesses, Teams \| 1Password](https://1password.com/)

      - The world’s most-loved password manager

        1Password is the easiest way to store and use strong passwords. Log in to sites and fill forms securely with a single click.

      - The secure ENTERPRISE password manager

        More than 100,000 businesses trust 1Password to secure their business and protect their data.

        主頁包括 IBM、Slack、PagerDuty、GitLab

      - Keep your FAMILY safe online

        The easiest and safest way to SHARE logins, passwords, credit cards and more, with the people that matter most. Go ahead, forget your passwords – 1Password remembers them all for you.

  - [Pricing & free trial \| 1Password](https://1password.com/sign-up/)

    Personal $2.99/month (billed annually)

      - Apps for Mac, iOS, Windows, Android, Linux, and Chrome OS
      - Unlimited passwords, items, and 1 GB document storage
      - Friendly 24/7 email support
      - 365 day item history to restore deleted passwords
      - Travel Mode to safely cross borders
      - Two-factor authentication for an extra layer of protection
      - Share your sensitive information securely, with anyone

    All 1Password accounts include

      - 1Password Watchtower

        Receive alerts for compromised websites and vulnerable passwords so you can take action to stay secure.

      - Digital Wallet

        Securely store credit and debit cards, online banking information, and PayPal logins so you can fill them from any device.

      - Unrivaled support

        Whenever you need it, our global team is here to help. Get free, one-on-one support from the 1Password team.

      - Travel Mode

        Remove sensitive data from your devices when you cross borders, and restore access with a click when you arrive. 為什麼要這麼做??

      - Advanced Encryption

        Our security recipe starts with AES-256 bit encryption and uses multiple techniques to protect your data at rest and in transit.

      - Total privacy

        Only you can access your data. We don’t use it, we don’t share it, and we don’t sell it. You’re our customer, not our product.

## 新手上路 {: #getting-started }

  - Try 1Password FREE > Personal & Family > Personal ($2.99/month) > Try FREE for 14 days

    填入 Name、Email address 後按 [Create Account]，輸入 1Password 寄送的 verification code，自訂 master password 後 (至少 10 個字元)，就可以下載一個 Emergency Kit (內含 Secret Key)，忘記密碼時可以用上。

## SSH Keys

雖然 1Password 不直接支援 SSH Key，但可行的做法為：

  - 利用 Login item 帶出 private/public key files。
  - 若 key file 只用在單一個 Login item，直接在 item 裡 Add New File，若 key file 有 passphrase 可以記在 password field 裡。
  - 若 key file 被用在多個 Login item，則應上傳成 Document item，再從 Login item 引用 (Link Existing)。

---

參考資料：

  - [How to Store SSH Keys on Password Managers \- Personal Blog \| Omegion](https://omegion.dev/how-to-store-ssh-keys-on-bw-op) (2021-06-24)

    從測試 [`op_test.go`](https://github.com/omegion/ssh-manager/blob/d246661d9398d2f9a1270713122c71938cd43199/internal/provider/op_test.go#L27) `"op create item login notesPlain=%s --title %s%s --tags %s"` 看來，它是透過 `op create item login` 搭配 category login (而非 `create document`)。

  - [PGP/SSH Keys in 1password — 1Password Support Community](https://1password.community/discussion/119225/pgp-ssh-keys-in-1password) (2021-02-23)

      - shaumux: I tried to save PGP keys in 1password but the text field seems to strip it of all new lines as such the keys become useless, is this in a possible feature?

      - Ben: There are a couple of options here. You could utilize the 'NOTES' FIELD, which is MULTI-LINE, to store the key in text form, or you could create a DOCUMENT ITEM containing the key file itself. Others have suggested/requested in the past that we offer a MULTI-LINE PASSWORD-TYPE field (such that the contents would be concealed), and we have recorded that request for future consideration.

      - kpitt: For PGP keys, the public key block is, by definition, non-sensitive data that wouldn't need to be hidden. The secret key block is already encrypted, assuming you care enough about security to have a decent PASSPHRASE on your key, so it doesn't really need to be hidden either. I think all that is really needed, at least for my use case, would be the ability to have MORE THAN ONE MULTI-LINE TEXT FIELD IN A SINGLE ITEM to store these various blocks separately.

        I understand all of the issues from previous discussion threads regarding multiple vault formats and separate applications built for multiple platforms, but the "Software License" category already has a MULTI-LINE "LICENSE KEY" FIELD that would provide exactly the behavior we would need to store key blocks. That seems to me like an indication that you already have all of the necessary support for storing this type of data and the UI for managing it. Would it be possible just to make the "license key" field type available for use in other item categories?

  - [Storing SSH keys in 1Password \- really doesn't work at all well — 1Password Support Community](https://1password.community/discussion/106263/storing-ssh-keys-in-1password-really-doesnt-work-at-all-well) (2019-08-14)

      - ChrisJenkins: I'd like to store SSH keys (private and public) in 1Password (Mac and iOS). However the standard 'text' field type in 1Password is no good for this as when I copy and paste the key text (from a terminal session) into one of those files it loses the line breaks and the resulting private key is then (very) hard to easily re-constitiute.

        The 'notes' field does not have this issue but you can ONLY HAVE ONE NOTES FIELD PER ITEM and so it isn't really very useful (a person may have several SSH keys). Can you please improve the 'text' field type so that it retains line breaks when pasting (and copying). or provide an additional field type that behaves the same way as the notes field but where MULTIPLE FIELDS are allowed per item. This is really very important to me. Thanks.

        Ben: We've had similar requests (particularly re: SSH keys) before and I've filed an issue with our development team to consider how to best address this. I can't make any promises at this stage, but my suggestion was to implement a MULTI-LINE PASSWORD FIELD. That way the key could be concealed, but would retain line breaks, and could be easily copied to the clipboard. Also, it would be possible to have MULTIPLE OF THEM on an item.

        > a person may have several SSH keys

        For now... I'd recommend a unique item for each of them.

      - Lars: it does if you want platform-specific advice and suggestions. But for something like this, it matters less. The reality of the situation is that we do not currently have a dedicated SSH key category and if we were to implement one, it would need to be CROSS-PLATFORM. It's something we get regular but infrequent requests for, but as we're currently in the process of working to develop CUSTOM CATEGORIES which would let the user define their own TEMPLATES, we probably aren't going to be developing any new static categories just now. Nothing about this is fixed in stone, however, so thank you for registering your thoughts and wishes for this category with us, as well as for being a 1Password user.

      - mgenereu: I just stored the two files as LINKED DOCUMENTS. Why is this undesirable? I would think these are documents because the binary precision (or multiline formatting) would be important.

        Ben: I actually do the same, personally

      - jarom: The best implementation I have come across of integrating SSH keys with a password manager is from the KeePassXC program. There I can add ATTACHMENTS to a password entry and the entry can be configured to load the key into the SSH agent when the key vault is unlocked and remove the keys from the agent when the vault is locked. It is by far the easiest solution I have come across, other than simply having Apple store the password in the Keychain.

        idanielwagn3r: I've long used KeeAgent (https://lechnology.com/software/keeagent/) plugin for KeePass 2. It integrates very well in Windows (native and PuTTY) and Linux. Under Windows it also works like a charm together with WSL, when using wsl-ssh-pagent (https://github.com/benpye/wsl-ssh-pageant). When not looking at enterprise grade PAM solutions I think this is pretty much the usability standard to measure against.

      - thawkins: This should work as a somewhat awkward workaround for Linux/Mac users. You can encode an arbitrary file to a single string using the 'base64' command

      - Lars: we hear you. I can't say what the future might hold, but I can definitely say that for now, you can place copies of your keys LINKED TO A SECURE NOTE that includes any other information you want about them. Thanks for weighing in on the subject.

## 參考資料 {: #reference}

  - [1Password](https://1password.com/)
  - [Blog | 1Password](https://blog.1password.com/)

社群：

  - [1Password | reddit](https://www.reddit.com/r/1Password/)

更多：

  - [CLI](1password-cli.md)
