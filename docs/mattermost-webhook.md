---
title: Mattermost / Integration / Webhook
---
# [Mattermost / Inttegration](mattermost-integration.md) / Webhook

## Migration from Slack {: #migration-slack }

  - [100% Slack Compatible Webhooks – Mattermost Feature Proposal Forum](https://mattermost.uservoice.com/forums/306457-general/suggestions/18885019-100-slack-compatible-webhooks) (2017-04-09)

      - Travis Rowland: I would like Mattermost to be able to consume any Slack-compatible webhook. It is very frustrating that I have to build a tool to PROXY webhooks from GitHub for example.

        解法是自架一個 proxy，顯然無法換個 URL 就把 Slack 的 incoming webhook 就轉到 Mattermost。

      - Andrew Walker: I think this would potentially help many slack integrations to be converted from Slack to Mattermost: https://mattermost.uservoice.com/forums/306457-general/suggestions/19509919-support-for-the-slack-real-time-messaging-rtm-we #ril

      - Oliver Rivett-Carnac: I agree. I mean Mattermost team are using JIRA and Gitlab yet there are no first class Integrations. Webhooks are great but seem like a poor mans solution to the rich Integrations in Slack

## 參考資料 {: #reference }

文件：

  - [Incoming Webhooks](https://docs.mattermost.com/developer/webhooks-incoming.html)
  - [Outgoing Webhooks](https://docs.mattermost.com/developer/webhooks-outgoing.html)
