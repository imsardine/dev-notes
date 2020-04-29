# Mattermost

  - [Mattermost: Open Source, Self\-hosted Slack Alternative](https://mattermost.com/) #ril

    High Trust Messaging for the Enterprise

      - Mattermost is a flexible, open source messaging platform that enables secure team collaboration

  - [Remote work when SaaS is not an option \- Mattermost \- Open Source, On\-Prem or Private Cloud Messaging](https://mattermost.com/blog/remote-work-when-saas-is-not-an-option/?utm_campaign=remote-work) (2020-03-18) #ril

  - [Pricing Feature Comparison \- Mattermost \- Open Source, On\-Prem or Private Cloud Messaging](https://mattermost.com/pricing-feature-comparison/)

    Mattermost Enterprise Edition

      - Secure, self-hosted, and scalable messaging that bring together people, files and systems into a single view so teams can operate more effectively.

        即便是 Enterprise Edition，也是 self-hosted。

    Self-hosted Team Communication

      - Self-hosted one-to-one and group messaging, file sharing and search
      - Native apps for iOS, Android, Windows, Mac and Linux
      - UNLIMITED search history
      - UNLIMITED integrations
      - Tools for custom branding
      - New monthly improvements to Team Edition
      - Multi-factor authentication

    Multi-language Translations

      - English, Chinese (Simplified & Traditional), Dutch, French, German, Italian, Japanese, Korean, Polish, Brazilian Portuguese, Romanian, Russian, Turkish, Spanish, and Ukrainian.

    Enterprise Essentials

      - Active Directory / LDAP single sign-on
      - Encrypted push notifications via HPNS
      - Advanced access control policies
      - Next business day support
      - New monthly improvements to Enterprise E10

  - [DevOps \- Mattermost \- Open Source, On\-Prem or Private Cloud Messaging](https://mattermost.com/devops/) #ril
  - [ChatOps \- Mattermost \- Open Source, On\-Prem or Private Cloud Messaging](https://mattermost.com/chatops/) #ril
  - [Collaboration Platform for Remote Work \- Mattermost \- Open Source, On\-Prem or Private Cloud Messaging](https://mattermost.com/remote-work/) #ril

  - [Licensing \| Mattermost](https://mattermost.org/licensing/) #ril

## 替代方案 {: #alternatives }

  - [Mattermost vs\. Slack: Total Cost of Ownership \- Mattermost \- Open Source, On\-Prem or Private Cloud Messaging](https://mattermost.com/mattermost-vs-slack-total-cost-of-ownership/) #ril

      - Mattermost customers enjoy huge savings of over 60% vs. Slack Enterprise Grid users. Those savings are further amplified with more users thanks to economies of scale.

        Mattermost offers a cost-effective, enterprise-grade, private cloud alternative to Slack’s SaaS-only WORKPLACE MESSAGING service.

      - THIS IS USEFUL FOR:

          - Decision makers interested in a cost-effective Slack alternative
          - Privacy-conscious organizations that want the benefits of workplace messaging without compromising on security

    ---

    [PDF](https://mattermost.com/wp-content/uploads/2019/06/Mattermost-vs-Slack-TCO.pdf)

      - Mattermost offers a cost-effective, enterprise-grade, private cloud alternative to Slack’s SaaS-only workplace messaging service.

        While both products offer agility, efficiency and innovation benefits, Mattermost’s private cloud approach uniquely provides the control, privacy, legal compliance, extensibility and scalability required by top enterprises.

      - Mattermost and Slack both increase productivity via modern workplace messaging

        Both solutions bring all your team’s communications to one place, providing modern workplace messaging across web, mobile and PC with continuous archiving, instant search and a wide array of options to INTEGRATE your existing TOOLS AND WORKFLOWS. These tools enable all your teams to:

          - Do more in less time, with LESS EMAIL using searchable, topic-based messaging
          - Solve problems faster with “war rooms” that assemble the right people and information
          - Collaborate anywhere with cross-device access to vital communications
          - Accelerate new hire onboarding with easy SHARING OF PAST TEAM DISCUSSIONS

      - Enterprises need more

          - For technologists, modern messaging enables additional high-performance workflows: DevOps, ChatOps, Conversational Development and Social Coding, among other USE CASES, that improve software quality while reducing delivery time.

          - These innovative approaches have exploded across startups and small and medium businesses. But today’s leading enterprises have a different set of needs that Mattermost was designed to meet.

      - Only Mattermost offers the control, privacy, legal compliance, extensibility and scalability top enterprises need.

        In contrast to Slack and other proprietary SaaS services, Mattermost offers an open source, private cloud platform where enterprises have complete control of their vital communications:

  - [Mattermost vs Slack \- Mattermost \- Open Source, On\-Prem or Private Cloud Messaging](https://mattermost.com/mattermost-vs-slack/) #ril

  - [Mattermost vs\. Microsoft Teams \- Mattermost \- Open Source, On\-Prem or Private Cloud Messaging](https://mattermost.com/mattermost-vs-microsoft-teams/) #ril

## 新手上路 {: #getting-started }

  - [Creating Teams — Mattermost 5\.22 documentation](https://docs.mattermost.com/help/getting-started/creating-teams.html) #ril

      - A team is a digital WORKSPACE where you and your teammates can collaborate in Mattermost. Depending on how Mattermost is set up in your organization, you can belong to ONE team OR MULTIPLE teams.

        同 Slack workspace 的概念。

      - New teams can be created if the System Admin has Enable Team Creation set to true in the System Console.

        若將 team 視為公司別，實務上不太可能開放一般使用者可以自己建立 team/workspace。

## AD/LDAP Authentication {: #ldap }

  - [Corporate Directory Integration — Mattermost 5\.21 documentation](https://docs.mattermost.com/overview/auth.html) #ril
  - [Crivaledaz/Mattermost\-LDAP: This module provides an external LDAP authentication in Mattermost for the Team Edition \(free\)\.](https://github.com/Crivaledaz/Mattermost-LDAP) #ril

  - [LDAP in the open source version \- Mattermost, Inc\.](https://forum.mattermost.org/t/ldap-in-the-open-source-version/2420)

      - Is there anything that can prevent me from implementing [`LdapInterface`](https://github.com/mattermost/mattermost-server/blob/dd1965ca3461dbf965a68015e063667d56970adb/einterfaces/ldap.go#L10) myself? I was wondering if the license has something.

      - it33: Mattermost is an open source alternative to proprietary SaaS messaging and you’re welcome to modify it as you wish under its open source licenses.

        If you’re offering a modified version to others, you need to remove the Mattermost brand, since the brand is trademarked.

        口氣聽起來是官方的人?

      - Crivaledaz: I have initiated a project to allow LDAP authentication on Mattermost Team Edition, WITHOUT USING GITLAB. This module uses a Oauth PHP server to link LDAP to Mattermost.

        If you are interested by the project you can download it from my Github repo : https://github.com/Crivaledaz/Mattermost-LDAP 2.1k

        I have implemented this module for my company to use LDAP with Mattermost and we have been using it for a few weeks. I will be happy to answer your questions about this module. Please do not hesitate to give me your feedbacks.

## Scale

  - [Scaling for Enterprise — Mattermost 5\.21 documentation](https://docs.mattermost.com/deployment/scaling.html#single-machine-deployment) #ril

      - Single Machine Deployment

        Organizations can typically run Mattermost on a single server with up to 2,000 users, though more users have been observed based on different usage and server configurations.

## 疑難排解 {: #troubleshooting }

### Team 只能加入同 Email Domain 的人？ {: #join-team-domain-restriction }

透請同一 server 其他使用者加入 team 時，可能會遇到下面的錯誤：

```
Email must be from a specific domain (e.g. @example.com). Please ask your team or system administrator for details.
```

注意 "ask your team ..." 這段，顯然能不能加入某個 team 除了跟 system 層級的設定有關，跟 team 層級的設定也可能有關。

> TIP:
>
> "無法建立 team" 跟 "無法加入 team" 的錯誤很像，後者多了 "ask your team" 這段。
>
>     {
>       "id": "api.team.is_team_creation_allowed.domain.app_error",
>       "translation": "Email must be from a specific domain (e.g. @example.com). Please ask your System Administrator for details."
>     },
>     ...
>     {
>       "id": "api.team.join_user_to_team.allowed_domains.app_error",
>       "translation": "Email must be from a specific domain (e.g. @example.com). Please ask your team or system administrator for details."
>     },
>
> -- https://github.com/mattermost/mattermost-server/blob/03a55367d9815131c9c57adb398fcb79479336d9/i18n/en.json#L2062

在 System Console > Authentication > Signup 下有個設定：

  - Restrict account creation to specified email domains

    User accounts can only be created from a specific domain (e.g. "mattermost.org") or list of comma-separated domains (e.g. "corp.mattermost.com, mattermost.org"). THIS SETTING ONLY AFFECTS EMAIL LOGIN.

在 Team Settings > General 下也有兩個設定：

  - Allow only users with a specific email domain to join this team

    Users can only join the team if their email matches a specific domain (e.g. "mattermost.org") or list of comma-separated domains (e.g. "corp.mattermost.com, mattermost.org").

  - Allow any user with an account on this server to join this team

    When allowed, a link to this team will be included on the landing page allowing anyone with an account to join this team.

試過將 "Allow any user ..." 改成 Yes (雖然有點極端)，但對問題並沒有幫助。剩下：

  - System Console > Authentication > Signup > Restrict account creation to specified email domains
  - Team Settings > General > Allow only users with a specific email domain to join this team

後者預設是空白的，意謂著 Team Settings 預設採用 SYstem Console 的設定，也就是 Team Settings 可以 "進一步限縮" 哪些 email domain 才能加入該 team。

NOTE: 注意 email domain(s) 設定值的兩側不含雙引號。

## 參考資料 {: #reference }

  - [Mattermost](https://mattermost.com/)
  - [Mattermost Blog](https://mattermost.com/blog/)
  - [Mattermost – Medium](https://medium.com/@mattermost)
  - [mattermost/mattermost-server](https://github.com/mattermost/mattermost-server)

文件：

  - [Mattermost Documentation](https://docs.mattermost.com/)

社群：

  - [Mattermost Forum](https://forum.mattermost.org/)
  - [Mattermost - YouTube](https://www.youtube.com/channel/UCNR05H72hi692y01bWaFXNA)

更多：

  - [Setup](mattermost-setup.md)
  - [Integration](mattermost-intgration.md)
  - [API](mattermost-api.md)
  - [Migration from Slack](mattermost-migration.md)

手冊：

  - [User’s Guide](https://docs.mattermost.com/guides/user.html#)
