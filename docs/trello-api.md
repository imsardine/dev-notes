---
title: Trello / API
---
# [Trello](trello.md) / API

## 新手上路 {: #getting-started }

  - [API Introduction](https://developers.trello.com/docs/api-introduction) #ril
      - The Trello API is extremely powerful. We use the SAME API in the Trello web and mobile clients! Building a full application with Trello means getting to know the various concepts and MODELS in Trello.

## Authentication ??

  - API authentication 需要 API Key + Token，其中 API key 可以從 https://trello.com/app-key 取得，而 token 則要透過 authorize 取得 -- 授權特定 application 的存取。

---

參考資料：

  - [Authentication - API Introduction](https://developers.trello.com/docs/api-introduction#section--a-name-auth-authentication-and-authorization-a-) #ril

      - You'll need TWO things before you and your application can make a call ON BEHALF OF A USER to the Trello API. The first thing you'll need is your API KEY. Every Trello user gets a single API key; it is used to identify YOU AND YOUR APPLICATIONS to Trello.

        注意 API key = user + application，另一項資訊則是 Token。

      - You can get your API key by logging into Trello and visiting https://trello.com/app-key. Your API key should be 32 character string comprised of random alphanumeric characters.

        存取上面的網頁會看到 "We're glad you're here! Trello has a rich API that you can use to build awesome Power-Ups and Integrations. To get started, you’ll first need to access your API key and grab a TOKEN! 🚀"，按 Show API Keys 可以看到 API key 及一些說明 ...

  - [Developer API Keys](https://trello.com/app-key)

      - Token: Most developers will need to ask each user to authorize YOUR APPLICATION. If you are looking to build an application for yourself, or are doing LOCAL TESTING, you can manually generate a Token.

        按下 Token 的連結，會開始 Authorize 程序並提示 "Let Server Token use your account?" ... Server Token is not affiliated with Trello in any way, and by permitting access to your content you assume all related risks and liabilities. The app will be able to:

          - Read your name and username
          - Read all of your boards and teams
          - Create and update cards, lists, boards and teams
          - Make comments for you
          - Read your email address

        很適合 server-to-server 的應用? 最後強調 It won’t be able to: See your Trello password。按下 Allow 後提示：

            You have granted access to your Trello information.

            To complete the process, please give this token:

            abcdef...xyz

        試過重新 connect 產生的 token 也不會變。如果要為不同的 application 提供不同的 token 要怎麼做 ??

      - You can learn more about the Trello API at http://developers.trello.com This developer site has examples, information on getting started with the API, a SANDBOX to try out API calls, and the full reference documentation.

        按 Try our Developer Sandbox 會開窗導到 [Sandbox](https://developers.trello.com/page/sandbox/)，提供自己的 API key 後，按 Connect 會在網頁加上 [client.js](https://developers.trello.com/docs/clientjs)，按 Authenticate 拿到 token 後，就可以直接在 browser 以自己的身份測試 RESTful API。

        注意這時候 Authorize 的程式提示的是 "Let Trello Sandbox use your account?"，跟上面 local testing 用的 "Server Token" 不同。

      - Trello supports OAuth 1 authorization, if you would like to use this, you will need your Secret.

        Please keep your API Secret safe. Because your API Key is public for any client-side applications, we do not currently offer a way to reset it. 不過重開這個 URL 時還可以看到；為什麼不是 OAuth 2 ??

  - [Authorization](https://developers.trello.com/page/authorization) #ril

## Concept & Model ??

  - [Boards](https://developers.trello.com/reference#boards-2) #ril
  - [Lists](https://developers.trello.com/reference#lists) #ril
  - [Cards - API Introduction](https://developers.trello.com/docs/api-introduction#section--a-name-cards-cards-a-) #ril
      - A Card is the most basic unit of information in Trello. Cards have a name, description, labels, members, and a set of HISTORICAL ACTIONS that have been taken on the card, including any comments.
  - [Checklists](https://developers.trello.com/reference#checklist) #ril

## Card ??

  - [Cards - API Introduction](https://developers.trello.com/docs/api-introduction#section--a-name-cards-cards-a-)
      - A Card is the most basic unit of information in Trello. Cards have a name, description, labels, members, and a set of HISTORICAL ACTIONS that have been taken on the card, including any comments.

    Important Methods

      - `POST /1/cards` - Create a new card on a List
      - `PUT /1/cards/[card id or shortlink]` - Update the contents of a Card

        `/cards/{id}/...` 中 `id` 可以用 short link 取代的說法在 full reference 中並沒有看到，但試過確實是可行的。

      - `POST /1/cards/[card id or shortlink]/actions/comments` - Add a comment to a Card
      - `POST /1/cards/[card id or shortlink]/idMembers` - Add a member to a Card

    Child Methods

      - Actions - Actions are the AUDIT LOG / record of everything that has been done to a card throughout its history, including any comments that have been made.
      - Labels - Labels can be as simple as colors attached to a Card, or Labels can have names.

  - [Cards](https://developers.trello.com/reference#cards-1) #ril
      - 雖然文件上沒提到 `/cards/{id}/...` 可以用 `shortLink` 替代，但實驗過是可以的。

## Python ??

  - [Getting Things Done in Trello with Python, Flask and Twilio SMS \- Twilio](https://www.twilio.com/blog/getting-things-done-with-trello-python-flask-twilio-sms) (2018-09-17) 用 py-trello 0.12.0 #ril
  - [Downloading all attachments from trello using python](https://medium.com/@vishnuashok123/downloading-all-attachments-from-trello-using-python-ca1901cc701e) (2018-09-20) 用 py-trello #ril
  - [sarumont/py\-trello: Python API wrapper around Trello's API](https://github.com/sarumont/py-trello) #ril
  - [py\-trello · PyPI](https://pypi.org/project/py-trello/) #ril
  - [trello · PyPI](https://pypi.org/project/trello/) 2012-04-05 後沒再更新
  - [Trello Python API Docs — Trello Python API 0\.9 documentation](https://pythonhosted.org/trello/index.html) #ril

## 參考資料 {: #reference }

  - [Trello Developers](https://developers.trello.com/)

相關：

  - [py-trello](py-trello.md)

手冊：

  - [API Docs (v1.0)](https://developers.trello.com/v1.0/reference)
