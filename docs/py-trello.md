# py-trello

  - [sarumont/py\-trello: Python API wrapper around Trello's API](https://github.com/sarumont/py-trello) #ril

      - A wrapper around the Trello API written in Python. Each Trello object is represented by a corresponding Python object.

        The attributes of these objects are CACHED, but the CHILD OBJECTS ARE NOT. This can possibly be improved when the API allows for notification subscriptions; this would allow caching (assuming a connection was available to invalidate the cache as appropriate).

## 新手上路 {: #getting-started }

  - [Usage - sarumont/py\-trello: Python API wrapper around Trello's API](https://github.com/sarumont/py-trello#usage) #ril

        from trello import TrelloClient

        client = TrelloClient(
            api_key='your-key',
            api_secret='your-secret',
            token='your-oauth-token-key',
            token_secret='your-oauth-token-secret'
        )

      - Where `token` and `token_secret` come from the 3-legged OAuth process and `api_key` and `api_secret` are your Trello API credentials that are (generated here).

        To use without 3-legged OAuth, use only `api_key` and `api_secret` on client.

        好奇就一個 library 而言，是如何做到 3-legged OAuth 的 ?? 上面 generate here 的 URL https://trello.com/1/appKey/generate 目前會轉向到 https://trello.com/app-key

      - Working with boards

            all_boards = client.list_boards()
            last_board = all_boards[-1]
            print(last_board.name)

      - working with board lists and cards

            all_boards = client.list_boards()
            last_board = all_boards[-1]
            last_board.list_lists()
            my_list = last_board.get_list(list_id)

            for card in my_list.list_cards():
                print(card.name)

        看起來滿直覺的，相較於手動打 API 是有一點優勢的。

## Authentication ??

  - [Getting your Trello OAuth Token - sarumont/py\-trello: Python API wrapper around Trello's API](https://github.com/sarumont/py-trello#getting-your-trello-oauth-token) #ril

      - Make sure the following environment variables are set:

            TRELLO_API_KEY
            TRELLO_API_SECRET

        These are obtained from the link mentioned above. Default permissions are read/write.

      - `TRELLO_EXPIRATION` is optional. Set it to a string such as `never` or `1day`. Trello's default OAuth Token expiration is 30 days.

        More info on setting the expiration here: https://trello.com/docs/gettingstarted/#getting-a-token-from-a-user

        不過 https://trello.com/app-key 完全沒有提到 expiration ??

      - Run `python ./trello/util.py

## `TrelloClient.get_card()` 很沒效率 ??

  - [py\-trello/trelloclient\.py at 0\.15\.0 · sarumont/py\-trello](https://github.com/sarumont/py-trello/blob/0.15.0/trello/trelloclient.py#L154)

        def get_card(self, card_id):
            """Get card
            :rtype: Card
            """
            card_json = self.fetch_json('/cards/' + card_id)
            list_json = self.fetch_json('/lists/' + card_json['idList'])
            board = self.get_board(card_json['idBoard'])
            return Card.from_json(List.from_json(board, list_json), card_json)

    拿 card 時，會一併拿所屬的 list，以及該 list 所屬的 board，所以會多出 2 個 request。

## 安裝設定 {: #installation }

  - [Install - sarumont/py\-trello: Python API wrapper around Trello's API](https://github.com/sarumont/py-trello#install) 安裝 `py-trello` 套件即可。

## 參考資料 {: #reference }

  - [sarumont/py-trello - GitHub](https://github.com/sarumont/py-trello)
  - [py-trello - PyPI](https://pypi.org/project/py-trello/)

社群：

  - [py-trello | Trello](https://trello.com/b/FcTw02R1/py-trello)

手冊：

  - [`trello.TrelloClient`](https://github.com/sarumont/py-trello/blob/0.15.0/trello/trelloclient.py#L28)
  - [`trello.Board`](https://github.com/sarumont/py-trello/blob/0.15.0/trello/board.py#L15)
  - [`trello.List`](https://github.com/sarumont/py-trello/blob/0.15.0/trello/trellolist.py#L8)
  - [`trello.Card`](https://github.com/sarumont/py-trello/blob/0.15.0/trello/card.py#L19)
  - [`trello.Checklist`](https://github.com/sarumont/py-trello/blob/0.15.0/trello/checklist.py#L8)

