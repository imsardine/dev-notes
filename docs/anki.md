# Anki

  - 智能 flash cards 使輕鬆記住東西 -- 只練習快忘記的部份；縮短學習時間，可以學更多。
  - 支援圖片、音訊、視訊、科學符號 (LaTeX) 等，可以用於語言學習、準備考試、記住人名&臉、記住琴譜等。
  - 透過 AnkiWeb 可以在多個裝置上同步 flash cards。
  - 支援 Windows、Mac、Linux、iOS、Android 等不同平台，有許多 add-on 可以用。

參考資料：

  - [Anki \- powerful, intelligent flashcards](https://apps.ankiweb.net/) #ril

      - Powerful, intelligent FLASH CARDS. Remembering things just became much easier.
      - Remember Anything - From images to scientific markup, Anki has got you covered.
      - Remember Anywhere - Review on Windows, Mac, Linux, iOS, Android, and any device with a web browser.
      - Remember EFFICIENTLY - Only practice the material that you're about to forget.

    About Anki

      - Anki is a program which makes remembering things easy. Because it's a lot more efficient than traditional study methods, you can either greatly decrease your time spent studying, or greatly increase the amount you learn.
      - Anyone who needs to remember things in their daily life can benefit from Anki. Since it is CONTENT-AGNOSTIC and supports images, audio, videos and scientific markup (via LaTeX), the possibilities are endless.

        For example: 單看卡片/問句怎麼設計

          - Learning a language
          - Studying for medical and law exams
          - Memorizing people's names and faces <-- 有趣的應用
          - Brushing up on geography
          - Mastering long poems
          - Even practicing guitar chords!

    Features

      - Synchronization -- Use the free AnkiWeb synchronization service to keep your cards in sync across multiple devices.
      - Flexibility -- From card layout to review timing, Anki has a wealth of options for you to customize.
      - Media-Rich -- Embed audio clips, images, videos and scientific markup on your cards, with precise control over how it's shown. 媒體可以放網路上嗎??
      - Optimized -- Anki will handle decks of 100,000+ cards with no problems.
      - Fully Extensible -- There are a large number of ADD-ONS available.
      - Open Source -- Because the code and storage format is open, your important data is safe.

  - [Introduction - Anki Manual](https://apps.ankiweb.net/docs/manual.html#introduction) #ril

## Media ??

  - [Media - Anki Manual](https://apps.ankiweb.net/docs/manual.html#media)

      - Anki stores the sounds and images used in your notes in a folder NEXT TO THE COLLECTION. For more on the folder location, please see the file locations section. When you add media within Anki, either by using the paperclip icon in the editor or by pasting it into a field, Anki will COPY it from its original location into the MEDIA FOLDER. This makes it easy to back up your collection’s media or move it to another computer.

      - You can use the Tools > Check Media menu option to scan your notes and media folder. It will generate a report of files in the media folder that are NOT USED BY ANY NOTES, and media referenced in notes but missing from your media folder.

        It does not scan question or answer templates, which is why you CAN’T place media references to fields in the template. If you need a STATIC image or sound on every card, name it with a leading `_` (e.g., `_dog.jpg`) to tell Anki to ignore it when checking for media. If you delete media using the unused media check, Anki will move it into your operating system’s trash folder, so you can recover if you accidentally delete media that shouldn’t have been deleted. 避免在 template 用到的圖檔被 Check Media 誤報為 unused 而被刪除。

      - Anki uses a program called `mplayer` in order to support sounds and videos. A wide variety of file formats are supported, but not all of these formats will work on AnkiWeb and the mobile clients. MP3 audio and MP4 video seems to be the most universally supported.

  - [File Locations - Anki Manual](https://apps.ankiweb.net/docs/manual.html#file-locations)

      - On Mac computers, recent Anki versions store all their files in the `~/Library/Application Support/Anki2` folder. The `Library` folder is hidden by default, but can be revealed in Finder by holding down the option key while clicking on the Go menu. If you’re on an older Anki version, your Anki files will be in your `Documents/Anki` folder.
      - On Linux, recent Anki versions store your data in `~/.local/share/Anki2`, or `$XDG_DATA_HOME/Anki2` if you have set a custom data path. Older versions of Anki stored your files in `~/Documents/Anki` or `~/Anki`.

      - Within the ANKI FOLDER, the PROGRAM-LEVEL and PROFILE-LEVEL preferences are stored in a file called `prefs.db`. There is also A SEPARATE FOLDER FOR EACH PROFILE. The folder contains:

          - Your notes, decks, cards and so on in a file called `collection.anki2`
          - Your audio and images in a `collection.media/` folder
          - A `backups/` folder
          - Some system files


## Card、Deck、Note、Field、Card/Note Type?

  - Note - 具有 note type，決定有哪些 fields 記錄一組相關的資訊 (事實)；Tools > Manage Node Types ...
  - Card - 具有 card type，決定正反面 (問題 + 答案) 的 template；一個 note type 有多個 card type，新增 note 時，會自動為每個 card types 產生一張 card。
  - Deck - 由多張 card 組成 (可能來自不同的 note type)，但一張 card 只能歸入一個 deck。
  - 以學習不同語言為例，French 跟 English 會是不同的 deck，但背後可以有相同的 note type -- Language。

參考資料：

  - [The Basics - Anki Manual](https://apps.ankiweb.net/docs/manual.html#the-basics) 集中說明了 card (type)、deck、note (type)、field、collection 間的關係 #ril

      - A QUESTION AND ANSWER PAIR is called a CARD. This is based on a paper flashcard with a question on one side and the answer on the back. In Anki a card doesn’t actually look like a physical card, and when you show the answer the question remains visible by default. For example, if you’re studying basic chemistry, you might see a question like:

            Q: Chemical symbol for oxygen?

        After thinking about it, and deciding the answer is O, you click the show answer button, and Anki shows you:

            Q: Chemical symbol for oxygen?
            A: O

        After confirming that you are correct, you can tell Anki HOW WELL you remembered, and Anki will choose a next time to show you again.

        關鍵在於，必須誠實地告訴 Anki 你自己對這個問題的掌握度，否則 Anki 的演算法將無法發揮功效，學習效果會不理想。

    Decks

      - A DECK is a GROUP OF CARDS. You can place cards in different decks to study parts of your CARD COLLECTION instead of studying everything at once. Each deck can have different settings, such as how many new cards to show each day, or how long to wait until cards are shown again.

        實務上，通常會把不同性質的卡片放在不同 deck；一張 card (有兩面) 同時間只能屬於一個 deck，跟實體卡片一樣。

        事實上，card 背後是由 note 產生的，而 note 又由 fields 組成；note 套用一或多個 card type (有 front/recognition template 跟 back/production template 組成) 後產生多個 card。至於 card 要放到哪個 deck 跟它源自哪個 note type 是無關的，當我們在看 card 跟 deck 時，已經不用管 note type 了，跟實體的卡片一樣。

      - DECKS CAN CONTAIN OTHER DECKS, which allows you to organize decks into a TREE. Anki uses “::” to show different levels. A deck called “Chinese::Hanzi” refers to a “Hanzi” deck, which is part of a “Chinese” deck. If you select “Hanzi” then only the Hanzi cards will be shown; if you select “Chinese” then all Chinese cards, including Hanzi cards, will be shown.

      - To place decks into a tree, you can either name them with “::” between each level, or DRAG AND DROP them from the deck list.

        Decks that have been nested under another deck (that is, that have at least one “::” in their names) are often called SUBDECKS, and top-level decks are sometimes called SUPERDECKS or PARENT DECKS.

      - Anki starts with a deck called “default”; any cards which have somehow become separated from other decks will go here. Anki will HIDE the default deck if it contains no cards and you have added other decks. Alternatively, you may rename this deck and use it for other cards.

      - Decks are best used to hold BROAD CATEGORIES of cards, rather than specific topics such as “food verbs” or “lesson 1”. For more info on this, please see the using decks appropriately section.

        這跟下面 "a separate note type for each broad topic" 的說法是否有衝突?? 又或者 topic 比 category 更為廣泛?

    Notes & Fields

      - When making flashcards, it’s often desirable to make more than one card that relates to some information. For example, if you’re learning French, and you learn that the word “bonjour” means “hello”, you may wish to create one card that shows you “bonjour” and asks you to remember “hello”, and another card that shows you “hello” and asks you to remember “bonjour”.

        One card is testing your ability to RECOGNIZE the foreign word, and the other card is testing your ability to PRODUCE IT.

        確實 card 的兩面所訓練的能力不同，而且要分開追蹤。

      - When using paper flashcards, your only option in this case is to write out the information twice, once for each card. Some computer flashcard programs make life easier by providing a feature to flip the front and back sides. This is an improvement over the paper situation, but there are two major downsides:

          - Because such programs don’t TRACK YOUR PERFORMANCE OF RECOGNITION AND PRODUCTION SEPARATELY, cards will tend not to be shown to you at the optimum time, meaning you forget more than you’d like, or you study more than is necessary.
          - Reversing the question and answer only works when you want exactly the same content on each side. This means it’s not possible to display extra info on the back of each card for example.

      - Anki solves these problems by allowing you to split the CONTENT of your cards up into separate PIECES OF INFORMATION. You can then tell Anki which pieces of information you want on each card, and Anki will take care of creating the cards for you and updating them if you make any edits in the future.

      - Imagine we want to study French vocabulary, and we want to include the PAGE NUMBER on the back of each card. We want our cards to look like this:

            Q: Bonjour
            A: Hello
               Page #12

        And:

            Q: Hello
            A: Bonjour
               Page #12

      - In this example, we have three pieces of related information: a French word, an English meaning, and a page number. If we put them together, they’d look like this:

            French: Bonjour
            English: Hello
            Page: 12

      - In Anki, this related information is called a NOTE, and each piece of information is called a FIELD. So we can say that this type of note has three fields: French, English, and Page.
      - To add and edit fields, click the “Fields…” button while adding or editing notes. For more information on fields, please see the Customizing Fields section.

    Card Types

      - In order for Anki to create cards based on our notes, we need to give it a BLUEPRINT that says which fields should be displayed on the front or back of each card. This blueprint is called a CARD TYPE. Each type of note can have ONE OR MORE card types; when you add a note, Anki will create one card for each card type.

      - Each card type has TWO TEMPLATES, one for the QUESTION and one for the ANSWER. In the above French example, we wanted the RECOGNITION CARD to look like this:

            Q: Bonjour
            A: Hello
               Page #12

        To do this, we can set the question and answer templates to:

            Q: {{French}}
            A: {{English}}<br>
               Page #{{Page}}

        By surrounding a field name in DOUBLE CURLY BRACKETS, we tell Anki to replace that section with the actual information in the field. Anything not surrounded by curly brackets remains the same on each card. (For instance, we don’t have to type “Page #” into the Page field when adding material – it’s added automatically to every card.)

        `<br>` is a special code that tells Anki to move to the next line; more details are available in the templates section.

        The PRODUCTION CARD templates work in a similar way:

            Q: {{English}}
            A: {{French}}<br>
               Page #{{Page}}

      - Once a card type has been created, every time you add a new note, a card will be created based on that card type. Card types make it easy to keep the formatting of your cards consistent and can greatly reduce the amount of effort involved in adding information.

        They also mean Anki can ensure RELATED CARDS DON’T APPEAR TOO CLOSE TO EACH OTHER, and they allow you to fix a typing mistake or factual error once and have all the related cards updated at once.

      - To add and edit card types, click the “Cards…” button while adding or editing notes. For more information on card types, please see the Cards and Templates section.

    Note Types

      - Anki allows you to create different types of notes for different material. Each type of note has ITS OWN set of fields and card types. It’s a good idea to create a separate note type for each BROAD TOPIC you’re studying. In the above French example, we might create a note type called “French” for that. If we wanted to learn capital cities, we could create a separate note type for that as well, with fields such as “Country” and “Capital City”.
      - When Anki checks for duplicates, it only compares other notes of the same type. Thus if you add a capital city called “Orange” using the capital city note type, you won’t see a duplicate message when it comes time to learn how to say “orange” in French.

      - When you create a new COLLECTION??, Anki automatically adds some standard note types to it. These note types are provided to make Anki easier FOR NEW USERS, but in the long run it’s recommended you define your own note types for the content you are learning. The standard note types are as follows:

          - Basic -- Has Front and Back fields, and will create ONE card. Text you enter in Front will appear on the front of the card, and text you enter in Back will appear on the back of the card.
          - Basic (and reversed card) -- Like Basic, but creates TWO cards for the text you enter: one from front→back and one from back→front.
          - Basic (OPTIONAL reversed card) -- This is a front→back card, and optionally a back→front card. To do this, it has a third field called “Add Reverse.” If you enter ANY TEXT into that field, a reverse card will be created. More information about this is available in the Cards and Templates section.
          - Cloze -- A note type which makes it easy to select text and turn it into a CLOZE DELETION (e.g., “Man landed on the moon in […]” → “Man landed on the moon in 1969”). More information is available in the cloze deletion section.

        To add your own note types and modify existing ones, you can use Tools → Manage Note Types from the main Anki window.

      - Note: Notes and note types are common to your WHOLE COLLECTION rather than limited to an individual deck. This means you can use many different types of notes in a particular deck, or have different cards generated from a particular note in different decks.

        When you add notes using the Add window, you can select what note type to use and what deck to use, and these choices are COMPLETELY INDEPENDENT OF EACH OTHER. You can also change the note type of some notes after you’ve already created them.

        也難怪 UI 最外層只看得到 Deck 與 Note Type (選單 Tools > Manage Note Types)，其他 card、field 都是由 note type 展開的。

  - [Using Decks Appropriately - Anki Manual](https://apps.ankiweb.net/docs/manual.html#manydecks) #ril

## Template ??

  - [Cards and Templates - Anki Manual](https://apps.ankiweb.net/docs/manual.html#templates) #ril

### 如何做出克漏字 (Cloze) 的效果?

  - 利用 Cloze 這個內建的 note type，在 Text 欄位裡可以用 `{{c1::ANSWER}}` 或 `{{c1::ANSWER::HINT}}` 把某些字挖空。
  - Text 裡可以挖空多處，預設會以 `{{cN::...}}` 表示 (N 會以 2, 3, 4 累加上去)，會產生多張卡片，但相同的 N 只會產生一張卡片。

參考資料：

  - [Note Types - Anki Manual](https://apps.ankiweb.net/docs/manual.html#_note_types) 可以把句子中的某些字挖空 (cloze deletion)
  - [Cloze Deletion - Anki Manual](https://apps.ankiweb.net/docs/manual.html#cloze) Anki 內建 Cloze note type，它的 Text 欄位接受類似 `{{c1::ANSWER}}` 或 `{{c1::ANSWER::HINT}}` 的表示法，另外在 Extra 欄位可以提供額外的資訊；可自訂，但一定要源自於 Cloze 這個 note type。挖空第一個會出現 `{{c2::...}}`，表示會產生第二張卡片。
  - [Cloze Templates - Anki Manual](https://apps.ankiweb.net/docs/manual.html#clozetemplates) 用 {{cloze::FIELD_NAME}} 引用有 `{{cN::...}}` 的欄位。
  - [Checking Your Answer - Anki Manual](https://apps.ankiweb.net/docs/manual.html#typinganswers) 用 `{{type:cloze:FILED_NAME}}` 表示需要輸入的地方，多個挖空處在輸入答案時用逗號分開。

## 如何多人使用?

  - 利用 File > Switch Profile... 建立不同的 profile，卡片跟設定都是分開的。

參考資料：

  - [Profiles - Anki Manual](https://apps.ankiweb.net/docs/manual.html#profiles) 假如同一台電腦有多個人要用 Anki 的話，可以為每個使用者分開建 profile (獨立的 collection、各項設定)，從 File > Switch Profile... 進去；AnkiWeb 也只能跟一個 profile 同步。

## 如何事先準備好很多卡片，但按照學習進度練習?

  - 利用被 suspend 的卡片不會被 review 的特性 (直到被 unsuspend)，可以事先把卡片準備好並標示為 suspend，按照學習進度 unsuspend。
  - 為了找出不同學習進度的卡片，必須安排額外的欄位記錄進度，例如 `lesson` 或 `page`，之後就可以利用像是 `deck:English lesson:3` 很快找出 Lesson 3 的卡片並將它 unsuspend。

參考資料：

  - 卡片若全部事先建好，但剛學完第 3 課，如果限定只會出現第 1 - 3 課的卡片?
  - [Searching & Limiting to a field - Anki Manual](https://apps.ankiweb.net/docs/manual.html#_limiting_to_a_field) 用 `deck:DECK FIELD:KEYWORD` 的表示法可以找出 `DECK` 裡 `FIELD` 欄位是 `KEYWORD` 的卡片，例如 `deck:English front:dog` 會找出 English 這個 deck 裡 Front 欄位是 "dog" 的卡片。
  - [Editing and More - Anki Manual](https://apps.ankiweb.net/docs/manual.html#editmore) 被 suspend 的卡片不會被 review，直到被 unsuspend。

## 如何匯入文字檔??

  - Anki 不是很好輸入 (尤其中文輸入很卡)，如何匯入外部檔案?
  - [Importing - Anki Manual](https://apps.ankiweb.net/docs/manual.html#importing) 文字檔可以接受 UTF-8 編碼的 CSV (用逗號、分號或 tab 隔開)，第一行決定欄位名稱與分隔字元，匯入時可以選定與 note field 的對應關係。

## 安裝設置 {: #setup }

### macOS

  - [下載 `.dmg`](https://apps.ankiweb.net/#mac)，打開後將 Anki 拖到 `/Applications` 即可；之後昇級也是一樣的動作，只是要先把 Anki 關閉。

參考資料：

  - [Mac - Anki \- powerful, intelligent flashcards](https://apps.ankiweb.net/#mac)

      - Choose the standard version if your macOS version is up to date, as the alternate version uses an older toolkit which lacks some improvements.
      - Save the file to your desktop or downloads folder. Open it, and drag Anki to your Applications folder or desktop.
      - Upgrading is as simple as installing the new version over the old version, and your data will be preserved. Simply close Anki if it's currently running, then follow the steps in the Installation section above.

## 參考資料 {: #reference }

  - [Anki](https://apps.ankiweb.net/)
  - [dae/anki - GitHub](https://github.com/dae/anki)
  - [AnkiWeb](https://ankiweb.net/about)
  - [Add-ons for Anki 2.0](https://ankiweb.net/shared/addons/)

社群：

  - [Anki Support](https://anki.tenderapp.com/)

文件：

  - [Anki User Manual](https://apps.ankiweb.net/docs/manual.html)

更多：

  - [Development](anki-dev.md)
  - [Add-on](anki-addon.md)
