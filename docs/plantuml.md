# PlantUML

  - [Open\-source tool that uses simple textual descriptions to draw UML diagrams\.](http://plantuml.com/index)

      - PlantUML is a component that allows to quickly write : Sequence diagram, Usecase diagram, Class diagram, Activity diagram, Component diagram, State diagram, Object diagram, Deployment diagram, Timing diagram (不同於一般的 timeline，但也是 UML 標準圖形之一)
      - The following non-UML diagrams are also supported: Wireframe graphical interface, Archimate?? diagram, Specification and Description Language (SDL), Ditaa diagram, Gantt diagram, Mathematic with [AsciiMath](http://asciimath.org/) or [JLaTeXMath](https://github.com/opencollab/jlatexmath) notation 沒想過有支持這些!! 2019-03-01 也開始支援 MindMap 了
      - Diagrams are defined using a simple and intuitive language. (see PlantUML Language Reference Guide). Images can be generated in PNG, in SVG or in LaTeX format. It is also possible to generate ASCII art diagrams (only for sequence diagrams). 轉成 LaTeX 是什麼概念?? 為什麼 [PlantText UML Editor](https://www.planttext.com/) 不是 sequence diagram 也可以轉 TXT??

## 應用實例 {: #powered-by }

  - [Tools using the PlantUML language](http://plantuml.com/running)

## 新手上路 ?? {: #reference }

  - 所有的 diagram 都用 `@startuml` 與 `@enduml` 括起來，並不會特別宣告是哪種 diagram。所以 PlantUML 要學習通則、各項元素要怎麼表示，所請不同的 diagram，就是用上不同的元素而已，元素的用法在不同 diagram 裡都是一樣的，例如 note、actor、line、arrow ...

---

參考資料：

  - [General and common command to handle graphic layout in diagrams\.](http://plantuml.com/commons) #ril

  - [Quick Start Guide](http://plantuml.com/starting) #ril
  - [Frequently Asked Questions](http://plantuml.com/faq) #ril

## Comment

```
' 這裡是註解

/' 這裡是整塊註解
   另一行註解 '/

/'
這裡是整塊註解
另一行註解
'/
```

---

參考資料：

  - [Comments - General and common command to handle graphic layout in diagrams\.](http://plantuml.com/commons)

      - Everything that starts with simple quote `'` is a comment.

        實驗確認，`'` 一定要出現在行首，不支援 inline comment 的用法。例如 `c1 -> c2 ' relationship` 會丟出 Syntax Error。

        另外 `'` 與註解文字間的空白只是提高可讀性，可有可無。

      - You can also put comments on several lines using `/'` to start and `'/` to end.

        一樣 `/'` 只能出現在行首 (但 `'/` 可以出現在行尾)，實務上比較常用來暫時將整塊宣告拿掉。

  - [Common - PlantUML \| DrawUML](http://ogom.github.io/draw_uml/plantuml/#common) 這裡將 `'` 與 `/' '/` 分別稱做 single-line comment 與 block comment。

## Title / Caption, Header / Footer

  - [Footer and header - General and common command to handle graphic layout in diagrams\.](http://plantuml.com/commons) #ril

      - You can use the commands `header` or `footer` to add a footer or a header on any generated diagram.
      - You can optionally specify if you want a `center`, `left` or `right` footer/header, by adding a keyword.
      - As for title, it is possible to define a header or a footer on several lines. 跟 `header`/`footer` command 相連的幾行，都會被視為內容；但 title 有另一個 command 不是??
      - It is also possible to put some HTML into the header or footer. (通常是為了控制顏色)

            Alice -> Bob: Authentication Request

            header
            <font color=red>Warning:</font>
            Do not use in production.
            endheader

            center footer Generated for demonstration

        ![](http://s.plantuml.com/imgw/commons-nfzmdfkb.webp)

## Note

參考資料：

  - [Common - PlantUML \| DrawUML](http://ogom.github.io/draw_uml/plantuml/#common)

    提到 Notes left (`note left :`) 與 Notes right (`note right :`) 的用法。

        ( )
        note left : Note

        [  ]
        note right : Note

  - [Note on messages - Sequence Diagram syntax and features](http://plantuml.com/sequence-diagram)

      - It is possible to put notes on message using the `note left` or `note right` keywords just after the message.

            Alice->Bob : hello
            note left: this is a first note

            Bob->Alice : ok
            note right: this is another note

        跟 note 一般的用法一致，緊接在要加 note 的對象之後，用 `note left: ...` 或 `note right: ` 帶出 notes；試過 `note top:` 跟 `note bottom:` 也可以。

      - You can have a multi-line note using the `end note` keywords.

            Bob->Bob : I am thinking
            note left
                a note
                can also be defined
                on several lines
            end note

        注意 `note left` 右側沒有 `:`，內文左側的內縮只是提高可讀性。

  - [Using notes - Use case Diagram syntax and features](http://plantuml.com/use-case-diagram)

      - You can use the `note left of` , `note right of` , `note top of` , `note bottom of` keywords to define notes related to a single OBJECT.

            :Main Admin: as Admin
            (Use the application) as (Use)

            User -> (Start)
            User --> (Use)

            Admin ---> (Use)

            note right of Admin : This is an example.

            note right of (Use)
              A note can also
              be on several lines
            end note

        相對於之前 `note left/right/top/bottom` 一定要宣告在 object 之後的用法，加上 `of` 就可以把 note 寫在其他地方，當然也支援多行的 note。

      - A note can be also DEFINE ALONE with the `note` keywords, then LINKED to other objects using the `..` symbol.

            note "This note is connected\nto several objects." as N2
            (Start) .. N2
            N2 .. (Use)

        會把 note 的宣告額外接出來 (並給予別名)，通常是該 note 要同時說明多個物件。

        其實 `..` 跟線條樣式有關係，不過這剛好跟 note 慣用的虛線 (dashed) 一致。

  - [Notes and stereotypes - Class Diagram syntax and features](http://plantuml.com/class-diagram)

      - You can also define notes using `note left of`, `note right of`, `note top of`, `note bottom of` keywords.

      - You can also define a note on the LAST DEFINED class using `note left`, `note right`, `note top`, `note bottom`.

      - A note can be also define alone with the `note` keywords, then linked to other objects using the `..` symbol.

            class Object << general >>
            Object <|--- ArrayList

            note top of Object : In java, every class\nextends this one.

            note "This is a floating note" as N1
            note "This note is connected\nto several objects." as N2
            Object .. N2
            N2 .. ArrayList

            class Foo
            note left: On last defined class

  - [Notes - Activity Diagram syntax and features](http://plantuml.com/activity-diagram-legacy)

      - You can add notes on a activity using the commands `note left`, `note right`, `note top` or `note bottom`, just after the description of the activity you want to note.

      - If you want to put a note on the starting point, define the note AT THE VERY BEGINNING OF THE DIAGRAM DESCRIPTION.

      - You can also have a note on several lines, using the `endnote` keywords.

            (*) --> "Some Activity"
            note right: This activity has to be defined
            "Some Activity" --> (*)
            note left
             This note is on
             several lines
            end note

        原來 `endnote` 跟 `end note` 兩種寫法都可以。

  - [Notes - New Activity Diagram Beta syntax and features](http://plantuml.com/activity-diagram-beta)

      - Text formatting can be done using CREOLE WIKI SYNTAX.

            start
            :foo1;
            floating note left: This is a note
            :foo2;
            note right
              This note is on several
              //lines// and can
              contain <b>HTML</b>
              ====
              * Calling the method ""foo()"" is prohibited
            end note
            stop

      - A note can be floating, using `floating` keyword.

        實驗發現 `floating` 只能用在 activity 後，否則會丟出 Syntax Error。

## Stereotype

  - [Using Sprite in Stereotype - Component Diagram syntax and features](http://plantuml.com/component-diagram#11) Stereotype 可以自訂圖示! #ril

## Wiki Syntax

  - [Notes - New Activity Diagram Beta syntax and features](http://plantuml.com/activity-diagram-beta) 第一次提到 note 的內容可以用 creole 語法。
  - [Use creole syntax to style your texts](http://plantuml.com/creole) #ril

## Link, Arrow

  - [Basic example - Component Diagram syntax and features](http://plantuml.com/component-diagram#4)

    Links between elements are made using combinations of dotted line (`..`), straight line (`--`), and arrows (`-->`) symbols.

        DataAccess - [First Component]
        [First Component] ..> HTTP : use

    注意有 `-`、`.` 的用法，但就是沒有 `>` 的用法；因為 `>` 只是加上 arrow，不影響 ranking。

    這裡 dot (`..`)、dash (`--`) 的說法有點微妙，因為 `..` 畫出的是虛線 (dashed)，而 `--` 畫出的是實線 (solid)。

  - [Changing arrows direction - Component Diagram syntax and features](http://plantuml.com/component-diagram#7)

      - By default, links between classes have TWO dashes `--` and are vertically oriented. It is possible to use horizontal link by putting a SINGLE dash (or dot) like this:

            [Component] --> Interface1
            [Component] -> Interface2

        這裡隱約帶出 rank 的概念，只是沒有明講。

      - You can also change directions by REVERSING the link:

            Interface1 <-- [Component]
            Interface2 <- [Component]

      - It is also possible to change arrow direction by adding `left`, `right`, `up` or `down` keywords inside the arrow:

            [Component] -left-> left
            [Component] -right-> right
            [Component] -up-> up
            [Component] -down-> down

        You can shorten the arrow by using only the first character of the direction (for example, `-d-` instead of `-down-`) or the two first characters (`-do-`).

        感覺要控制 direction 就要跨 rank? 因為 `-left>` 這種寫法行不通 ... 實則不然，如果是順著 layout direction 的方向，只要調換位置即可 (例如 `A -> B` ￫ `B <- A`)，若方向與 layout direction 橫切，自然會跨 rank，這時候自然會有 `-->` 或 `..>` 的用法出現。

      - Please note that you should not ABUSE this functionality : Graphviz gives usually good results without tweaking.

        想調整方向，通常是沒有搞懂 `->` 與`-->` 的差別 (ranking)，以及 `->` 與 `<-` 的差別 (order of definition)。

  - [Linking - Deployment Diagram syntax and features](http://plantuml.com/deployment-diagram#3)

      - You can create simple links between elements with or without labels:

            node node1
            node node2
            node node3
            node node4
            node node5
            node1 -- node2 : label1
            node1 .. node3 : label2
            node1 ~~ node4 : label3
            node1 == node5

        用 `:` 帶出 label。這裡提到 `~~` (dotted) 與 `==` (粗線) 兩種新的線條樣式，注意 `..` (dashed) 與 `~~` (dotted) 的用法有點違反直覺。

      - It is possible to use several types of links:

            artifact artifact1
            artifact artifact2
            artifact artifact3
            artifact artifact4
            artifact artifact5
            artifact artifact6
            artifact artifact7
            artifact artifact8
            artifact artifact9
            artifact artifact10
            artifact1 --> artifact2
            artifact1 --* artifact3
            artifact1 --o artifact4
            artifact1 --+ artifact5
            artifact1 --# artifact6
            artifact1 -->> artifact7
            artifact1 --0 artifact8
            artifact1 --^ artifact9
            artifact1 --(0 artifact10

        這裡講的是箭頭的樣式，多了 `*` (實心菱形)、`o` (空心菱形)、`+` (圓形十字)、`#` (空心方塊)、`>>` (箭頭)、`0` (像 interface 的圓)、`^` (空心箭頭)、`(0` (類 required & provided interface 的效果)

      - You can also have the following types:

            cloud cloud1
            cloud cloud2
            cloud cloud3
            cloud cloud4
            cloud cloud5
            cloud1 -0- cloud2
            cloud1 -0)- cloud3
            cloud1 -(0- cloud4
            cloud1 -(0)- cloud5

  - [Note on links - Class Diagram syntax and features](http://plantuml.com/class-diagram#10)

      - It is possible to add a note ON A LINK, just after the link definition, using `note on link`.

            class Dummy
            Dummy --> Foo : A link
            note on link #red: note that is red

      - You can also use `note left on link`, `note right on link`, `note top on link`, `note bottom on link` if you want to change the relative position of the note WITH THE LABEL.

            Dummy --> Foo2 : Another link
            note right on link #blue
              this is my note on right link
              and in blue
            end note

        注意方位是相對於 label，而非 link 本身。

  - [uml \- How to correct PlantUML Line Path \- Stack Overflow](https://stackoverflow.com/questions/48712801/)

      - Peter Uhnak: There are some tricks that you can try, listed below. The layouting itself is performed by GraphViz (dot layouting iirc), and GraphViz simply does this sometimes. Graph layouting is a NP-complete problem, so algorithms usually take HARSH SHORTCUTS. 許多問答都提到線條怎麼走，都是背後 Graphviz 在決定。

        Typical workarounds that I've seen or used include:

          - adding hidden lines `a -[hidden]- b`
          - extending the length of a line `a --- b` (more dashes, longer line)
          - specifying PREFERRED DIRECTION of lines (`a -left- b`)
          - swapping association ends (`a -- b` → `b -- a`)
          - changing the order of definitions (THE ORDER DOES MATTER... sometimes)
          - adding empty nodes with background/border colors set to Transparent (這太 tricky!!)

        So if you really want to have a nice layout, you'll need to put some elbow grease in, but keep in mind that the layout will be still BRITTLE -- if you add/remove items, you might need to redo it again. 因為組成不同，可能又要再調一次。

      - Nikhil: Try the options suggested by @Peter Uhnak along with linetype :

            skinparam linetype polyline (折線)
            skinparam linetype ortho    (轉直角)

        Give better options for lines. Using ortho

        aSamWow: Good idea, it does fix the problem, but Ortho lines MESS UP LABELS in plant UML so I try to avoid them for more complex diagrams. 可惜，真的 label 都會跑掉

  - [PlantUML Pleasantness: Setting Arrow Directions \- Messages from mrhaki](http://mrhaki.blogspot.com/2018/06/plantuml-pleasantness-setting-arrow.html) (2018-06-05) #ril
  - [PlantUML Pleasantness: Change Line Style And Color \- Messages from mrhaki](http://mrhaki.blogspot.com/2016/12/plantuml-pleasantness-change-line-style.html) (2016-12-14) #ril
  - [PlantUML Pleasantness: Layout Elements With Hidden Lines \- Messages from mrhaki](http://mrhaki.blogspot.com/2017/10/plantuml-pleasantness-layout-elements.html) (2017-10-18) #ril

## Grouping

  - [Grouping Components - Component Diagram syntax and features](http://plantuml.com/component-diagram#6)

    You can use several keywords to group components and interfaces together: `package`, `node`, `folder`, `frame`、`cloud`、`database`

        package "Some Group" {
          HTTP - [First Component]
          [Another Component]
        }

        node "Other Groups" {
          FTP - [Second Component]
          [First Component] --> FTP
        }

        cloud {
          [Example 1]
        }


        database "MySql" {
          folder "This is my folder" {
            [Folder 3]
          }
          frame "Foo" {
            [Frame 4]
          }
        }

        [Another Component] --> [Example 1]
        [Example 1] --> [Folder 3]
        [Folder 3] --> [Frame 4]

    事實上 grouping 可以用在 component diagram 以外的地方，外框以 `frame` 最為通用。

  - [Declaring element - Deployment Diagram syntax and features](http://plantuml.com/deployment-diagram)

    其中 `artifact`、`card`、`cloud`、`component`、`database`、`file`、`folder`、`frame`、`node`、`package`、`queue`、`stack`、`rectangle`、`storage` 都可以用 `xxx { ... }` 的語法達到 grouping 的效果。

  - [Packages - Deployment Diagram syntax and features](http://plantuml.com/deployment-diagram#4)

    There is a limit of THREE levels.

## Layout, Direction, Rank {: #layout }

  - Rank 是 "由上而下" 或 "由左而右" 逐行/逐列的排列方式
  - 線條的長度表示兩個元素間 N -1 個 rank，所以 `->` 同 rank、`-->` 差 1 個 rank ...

---

參考資料：

  - [rank in component models \- PlantUML Q&A](https://forum.plantuml.net/5313/)

      - Anthony-Gaudino: Rank is set automatically based on LINE LENGTH.

          - `->`  is SAME rank
          - `-->` is one rank LOWER
          - `--->` is 2 rank lowers

      - You can use `-[norank]>` to create arrows between nodes that will be always on SAME RANK INDEPENDENT OF LENGTH.

  - [Using notes - Use case Diagram syntax and features](http://plantuml.com/use-case-diagram#7)

        User -> (Start)
        User --> (Use)
        Admin ---> (Use)

    很明顯可以看出 `->`、`-->` 與 `--->` 造成了不同的 rank。

  - [need help in layout among and inside packages \- PlantUML Q&A](https://forum.plantuml.net/8365/)

    manual positioning is a PAIN in the ... as graphviz does it automatically.

    I've changed your graph and added "d" for down. Other directions would be up, left, right. However, in general this is NOT the preferred way to do. What you need to keep in mind is that THE LONGER THE ARROW, THE LESS IMPORTANT IT IS (RANKING). If you have connections that should NOT BE CONSIDERED IN THE AUTOMATIC POSITIONING add a `norank`, which is the oposite of `hidden`. Just in case this is new to you, the attribute `hidden`, means DO NOT SHOW BUT RANK IT, `norank` means show it but do not rank it for the graphics (`a --> b` bs `a-[norank]-> b`).

    By adding more and more components it gets more challenging to layout. However, JUST PLAY A BIT AROUND WITH THE LENGTH AND THEREFORE THE RANKING BEFORE YOU ADD THE DIRECTION.

    先調 ranking 再考慮控制 direction。

    Remember that you can also use HIDDEN ARROWS to set your layout.

  - [Controlling Class Layout](https://isgb.otago.ac.nz/infosci/mark.george/templates/blob/8e98805c117c7b2e9b9f545c47b50366bb644e5e/plantuml/class-diagram-tips.md)

      - Layout is determined dymanically, so can be tricky if you are trying to get a specific layout, but you can usually BEAT it into submission with a combination of the following:

            ' force class diagram mode # (1)
            class c1

            ' horizontal placement     # (2)
            c1 -> c2

            ' vertical placement       # (2)
            c2 --> c3

            ' left placement
            c4 -left-> c4

         1. 為什麼 `class c1` 宣告了 diagram mode ?? 不加這行，`c1 -> c2` 會變成 state diagram。
         2. 由 `c1 -> c2` (horizontal) 與 `c2 --> c3` (vertical) 的差別看來，layout direction 預設是由上而下 (rank 高低的差別)、由左而右。

        You can use `left`, `right`, `up`, and `down` to control placement direction.

      - If adding a link screws up the class placement you can use `[norank]` to EXCLUDE THE LINK FROM THE LAYOUT PROCESS:

            ' link will not affect class placement
            c4 -[norank]-> c2

        嚴格來說 `[norank]` 只是讓 link 長度不影響 rank 而已，但 link 長度還是跟畫出來的線條長度有關。

      - You can also use `[hidden]` to create invisible links solely for the purpose of influencing the layout. Repeating them will increase the likelihood that the classes will be placed closer and even be aligned with each other:

            ' place c2 and c4 closer together
            c2 -[hidden]-> c4

            ' repeated again to place c2 and c4 even closer
            c2 -[hidden]-> c4

        Note that although the links are hidden they still affecting the drawing of links on the same path. If you temporarily remove the `[hidden]` option you can see what is going on.

        確實看不到線條，但重複 2 次並沒有更靠近的效果? (有可能是圖形還不夠複雜的關係) 實務上可以讓這種專用於 layout 的 link 一開始先顯示出來，最後再加上 `[hidden]`。

      - You can FIDDLE WITH THE ORDERING AND DIRECTION to ensure the one that is being drawn is in the place that you want it (usually in the middle). The trick is to use IDENTICAL links with the same class ordering and direction.

        If you want the link drawn in the opposite direction you CAN'T FLIP THE ORDER OF THE CLASSES - YOU NEED TO SWAP THE PLACEMENT OF THE ARROW:

            ' place c2 and c4 closer
            c2 -[hidden]- c4

            ' draw the actual link between the hidden links
            c2 <-[norank]- c4

            ' place c2 and c4 even closer
            c2 -[hidden]- c4

    General Layout Tips

      - Understanding how the layout engine works (GraphVis) makes it easier to get what you want. The previous example with the `[hidden]` and `[norank]` links got weird because we were giving the layout engine conflicting information.

      - The layout is determined by THE ORDER THAT CLASSES OCCUR. Classes are drawn at the TOP of the document have HIGHER RANKING than those below. The rank is determined by:

          - The order in which classes are added to the diagram 這一點比較感受不到 ??

          - The layout hints (horizontal, vertical, left, right, up, down)

            其中 `vertical` 是預設的 layout direction，而 `horizontal` 則是 `left to right direction` 的用法。

          - The direction in which the links are defined. The class on the LEFT has HIGHER RANK than the one on the right: higher -> lower

      - Link direction can have a dramatic impact. If we add a `c4 --> c2` link we confuse the engine by having `c4` on the left which gives it a higher ranking than `c2` and causes the diagram to flip upside down:

            class c1
            c1 -> c2
            c2 --> c3
            c3 -left-> c4

            ' whoops, this flips the diagram on its head
            c4 --> c2

      - Drawing links from the top down prevents this RE-RANKING PROBLEM ??, and means you don't have to use `[norank]` as often. Since the arrow direction has no effect on the layout we can just flip the end that the arrow is drawn at to account for the link being in a different order:

            ' ranking maintained, so layout isn't dramatically affected
            ' arrow drawn at opposite end to account for reverse order
            c2 <-- c4

      - We could have also used the `up` layout hint to prevent the re-ranking:

            c4 -up-> c2

    Layout Direction

      - You can change the ranking direction from VERTICAL to HORIZONTAL using `left to right direction`:

            left to right direction
            class c1
            c1 -> c2
            c2 --> c3
            c3 -left-> c4
            c2 <-- c4

        This also changes the meaning of the layout hints. Horizontal hints become vertical, etc.

    Spacing

      - You can control the spacing between class using the `NodeSep` and `RankSep` skinparams.

            SkinParam {
                NodeSep 45 ' horizontal spacing
                RankSep 45 ' vertical spacing
            }

## Rendering ??

常用的指令：

  - 灰階輸出 -- `skinparam monochrome true`
  - 線條走直線且轉直角 -- `skinparam linetype ortho`

---

參考資料：

  - [Round corner - Deployment Diagram syntax and features](http://plantuml.com/deployment-diagram#5)

        skinparam rectangle {
          roundCorner<<Concept>> 25
        }

        rectangle "Concept Model" <<Concept>> {
          rectangle "Example 1" <<Concept>> as ex1
          rectangle "Another rectangle"
        }

    注意只有帶 `<<Concept>>` stereotype 的 rectangle 才有圓角!!

  - [Changing colors and fonts](http://plantuml.com/skinparam) #ril
  - [Skinparam - Component Diagram syntax and features](http://plantuml.com/component-diagram#12) 可以控制 interface、component、node 等的字體、顏色 #ril

## CLI ??

  - [call it from your script using command line](http://plantuml.com/command-line) 主要在講 `skinparam` 的用法 #ril

## Class Diagram

  - Class Diagram syntax and features http://plantuml.com/class-diagram #ril
  - Stereotype 的用途?? 感覺像是個 tag? https://en.wikipedia.org/wiki/Stereotype_(UML) #ril
  - 說 type name 有 non-letter 可以用雙引號括起來，但 `class "RecyclerView.Adapter"` 還是會被解讀為 package/namespace?? => 暫時改用 `class "RecyclerView$Adapter"` 可以，但這只適用 Java。
  - 要如何在 relationship 的 label 用 stereotype? => 直接用 `<<{stereotype}>>` 即可，例如 `Calculator --> Adder : <<use>>`。
  - Class 若不需要 attribute、operation，可以不要畫線條嗎? => `hide empty members`，不過如果有任何 member (attribute/operation) 就會有框線，若要分開控制，可以同時設定 `hide empty attributes` 及 `hide empty methods`
  - 怎麼給定參數及它的型態? => http://www.uml-diagrams.org/operation.html 寫成 `+executeQuery(sql: String) : ResultSet`。
  - 預設會用 icon 來表示 member visibility，其實不那麼直覺? => 可以用 `skinparam classAttributeIconSize 0` 改用文字符號。
  - 採用 `{ ... }` 表示法時，習慣內容 2 格。
  - Method parameter 比較多時寫成一行，會讓 box 變得很長? => 可以用 `\n` 後面將上內縮，例如 `+do(String arg1,\n    String arg2,\n   String arg3)`
  - 有時候排版結果不是想要的，要如何調整?? => http://plantuml.com/class-diagram#layout 用 `together { ... }` 讓幾個 class 排在一起，線條的方向也可以 `A -down-> B` 的方式指定 (建議少用)
  - 如何調整特定 class box 的顏色? => http://plantuml.com/class-diagram#gradient 在 class name 後面用 `#` 帶出色碼，可以是 [standard color name](http://plantuml.com/color)、HEX (`#AABBCC`) 或 short HEX (`ABC`)，例如 `class FooBar <<mocked>> #dcdcdc`
  - 怎麼畫跟 factory 相依，又從 factory 拿到真正的 dependency??
      - 目前確認 client 分別往 factory 與 product 有 dependency，前者標 `<<use>>`，後者寫 "ask ..." (有點多餘)，而 factory 往 product 也有個 dependency，標上 `<<create>>`
      - http://www.uml-diagrams.org/design-pattern-abstract-factory-uml-class-diagram-example.html client use factory, factory create product, client use product
      - http://www.oodesign.com/factory-pattern.html client -> factory (ask for a new object), factory -> product (create), client -> product (use) 為什麼線條都跟標準不太一樣??

參考資料：

  - [Class Diagram syntax and features](http://plantuml.com/class-diagram) #ril
      - 有些表示法似乎不是 UML 標準，例如箭頭的樣式，這邊就先略過。
      - 文字描述用 `@startuml` ... `@enduml` 包起來。
      - 線條用 `--` (實線) 或 `..` (虛線) 表示，兩側可以分別加上箭頭；表示法有 `>` (開放箭頭)、`|>` (空心三角形)、`*` (實心菱形)、`o` (空心菱形)，例如 `ServiceImpl ..|> Service`，表示一個 relationship
      - 線條兩側的 cardinality (個數)，可以在線條的兩側用雙引號表示，例如 `Pond "0..1" o-- "0..*" Duck`，而線條本身的 label 則是在 relationship 後面用 `:` 帶出 label，例如 `ServiceImpl ..|> Service : implements`
      - 若想控制 relationship 線條的方向，可以在線條符號間加上 `left/right/up/down`，例如 `ServiceImpl .down.|> Service` 就能影響 PlantUML 的 layout；背後其實用 Graphviz 在畫，所以這功能少用，預設都能得到不錯的結果。
      - 要宣告 field 或 method，可以在 class name 後面加 field/method name，例如 `Object : equals()`、`ArrayList : Object[] elementData`
          - 後面有 `()` 視為 method，否則視為 field。
          - `:` 後面有一個元素時，視為 member，有兩個元素時視為 type 跟 member，例如 `User : name` 或 `User : String name`，要指定 visibility 時，符號要加在第一個元素前，例如 `User : -String name` 而非 `User : String -name`。
      - 上面的方法每一個 field/method 都要條列一次，用另一種 `{ ... }` 把所有 field/method 框起來的寫法會比較簡潔，例如：(習慣內縮 2 個字元)

            class Dummy {
              String data
              void methods()
            }
            class Flight {
              flightNumber : Integer
              departureTime : Date
            }

      - Abstract class 可以用 `abstract (class)` 表示，例如 `abstract class AbstractDummy` 或 `abstract AbstractDummy`。
      - 其中 `class` 也可以改用 `interface`、`annotation`、`enum` 等；專用於 Java??
      - Type 有兩種寫法，寫在前面用空白分開，寫在後面用 `:` 分開，後者似乎比較方便，因為有些時候並不想寫明 type，更何況 [UML Operation](http://www.uml-diagrams.org/operation.html) 的表示法也都是 `member : type`。
      - Member 可以用標準的符號 (`-`、`#`、`~`、`+`) 指定 visibility，例如 `+getName() : String`
      - Static 或 abstract member 可以分別用 `{static}` (或 `{classifier}`) 及 `{abstract}` modifier 來表示，例如 `{static} currentTimeMillis() : long`。
      - 預設會將 member 依 fields 或 methods 分群，但可以用分隔字元 (separator) 手動分群，分隔字元可以是 `--` 或 `__` (實線)、`..` (虛線)、`==` (雙實線)。線條上可以標上 label，例如 `-- Batch Operations --`
      - Stereotype 只能搭配 `class` 使用，例如 `class Object << {stereotype} >>`，不知道 stereotype 用在哪?? 擠在最上面那個區塊不是很好看... 雖然 `<<` 的右側跟 `>>` 的左側都有空白，但那不是必須的。
      - Note 宣告的方式有很多種：
          - `note left/right/top/bottom of {type} : {text}`，例如 `note top of Object : In java, every class\nextends this one.` (換行用 `\n` 表示)
          - `note left/right/top/bottom : {text}` - 跟最後一個定義的 type 關聯，效果同上面的寫法，例如 `class Foo (換行) note left: On last defined class`。
          - `note "{text}" as {name}`，例如 `note "This is a floating note" as N1`，之後可以用 `{type} .. {note}` 或 `{note} .. {type}` 將 type 與 note 連起來。

                note "This note is connected\nto several objects." as N2
                Object .. N2
                N2 .. ArrayList

          - 文字有多行可以用 `note left/right/top/bottom of {type} ... end note` 或 `note as {name} ... end note` 表示 (第一行 `note ...` 結尾沒有冒號)

                note top of Object
                  In java, <size:18>every</size> <u>class</u>
                  <b>extends</b>
                  <i>this</i> one.
                end note
                note as N1
                  This note is <u>also</u>
                  <b><color:royalBlue>on several</color>
                  <s>words</s> lines
                  And this is hosted by <img:sourceforge.jpg>
                end note

      - Note 也可以加在 relationship 的線條上，在 relationship 後加上 `note (left/right/top/bottom) on link ({color}) : {text}` 或 `note (left/right/top/bottom) on link ({color}) ... {text} ... end note`，例如：

            class Dummy
            Dummy --> Foo : A link
            note on link #red: note that is red
            Dummy --> Foo2 : Another link
            note right on link #blue
                this is my note on right link
                and in blue
            end note

      - Package 可以用 `package {name} ({color}) { ... }` 定義，例如

            package net.sourceforge.plantuml {
              Object <|-- Demo1
              Demo1 *- Demo2
            }

      - 使用 package 時，相同名稱的 type 最多只能出現在一個 package 裡，但 namespace 沒有這個限制。
          - 要引用不同 namespace 的 type，必須使用 fully qualified name，如果是 default namespace，則用 `.` 來表示。
          - 在同一個 namespace 裡相互引用，不需要加 namespace。例如：

                class BaseClass

                namespace net.dummy #DDDDDD {
                    .BaseClass <|-- Person
                    Meeting o-- Person

                    .BaseClass <|- Meeting
                }

                namespace net.foo {
                  net.dummy.Person  <|- Person
                  .BaseClass <|-- Person

                  net.dummy.Meeting o-- Person
                }

                BaseClass <|-- net.unused.Person

      - 表現 class 實作某個 interface 時，標準的寫法是 `{class} ..|> {interface}`，但如果 interface 一多時，可以改用 lollipop 的寫法 - `{class} --() {interface}`，比較簡潔；不過這種寫法，interface 就不能再被別人參照。

## State Diagram ??

  - [State Diagram syntax and features](http://plantuml.com/state-diagram) #ril

    Simple State

      - You can use `[*]` for the starting point (也就是 initial transition 的起點) and ending point of the state diagram. Use `-->` for arrows. 其中 `[*]` 會因為在箭頭的起點或結尾而有不同的表現方式：

        涉及 `[*]` 的箭頭用 `-->`，其餘用 `->`? 似乎是慣例，兩者的差別只有箭頭的長度 -- `-->` 是 `->` 的 2 倍長。

            [*] --> State1
            State1 --> [*]
            State1 : this is a string <-- 冒號前後不一定要有空白，但這樣比較好讀
            State1 : this is another string

            State1 -> State2
            State2 --> [*]

        ![](http://s.plantuml.com/imgw/state-diagram-8fezmvpq.webp)

    Change state rendering

      - You can use hide empty description to render state as simple box. 不過慣例上好像還是會畫出來??

            hide empty description
            [*] --> State1
            State1 --> [*]
            State1 : this is a string
            State1 : this is another string

            State1 -> State2
            State2 --> [*]

        ![](http://s.plantuml.com/imgw/state-diagram-sfo60qtl.webp)

    Composite state

      - A state can also be composite. You have to define it using the `state` keywords and brackets (`{ ... }`).

        這裡剛好示範了 initial transition 直接進入 superstate 的狀況，習慣上確實會在 superstate 裡再畫上一個小黑點。

            scale 350 width
            [*] --> NotShooting

            state NotShooting {
              [*] --> Idle
              Idle --> Configuring : EvConfig <-- event 跟 transition 用 : 分開
              Configuring --> Idle : EvConfig
            }

            state Configuring {
              [*] --> NewValueSelection
              NewValueSelection --> NewValuePreview : EvNewValue
              NewValuePreview --> NewValueSelection : EvNewValueRejected
              NewValuePreview --> NewValueSelection : EvNewValueSaved

              state NewValuePreview {
                 State1 -> State2
              }

            }

        ![](http://s.plantuml.com/imgw/state-diagram-xtzglfer.webp)

## Sequence Diagram

  - [Sequence Diagram syntax and features](http://plantuml.com/sequence-diagram) #ril

## Component Diagram

  - [Component Diagram syntax and features](http://plantuml.com/component-diagram)

    Components

      - Components must be BRACKETED.

            [First component]

      - You can also use the `component` keyword to define a component.

            component Comp3

      - And you can define an ALIAS, using the `as` keyword. This alias will be used latter, when defining relations.

            [Another component] as Comp2
            component [Last\ncomponent] as Comp4

        實務上第二種寫法應該會是 `component "Last\ncomponent" as Comp4`。

        實驗發現，一旦給了 alias，就不能再用原來的名稱 (變成只是 label) 引用了，會被視為不同的 component，以上面 `[Another component] as Comp2` 為例，寫成 `Comp2 --> Interface` 或 `[Comp2] --> Interface` 都沒問題，但 `[Another component] --> Interface` 就會產生另一個 component。

    Interfaces

      - Interface can be defined using the `()` symbol (because this looks like a circle).

            () "First Interface"
            () "Another interface" as Interf2

        若 `(` 與 `)` 中間有其他文字 (或空白字元)，則會被視為 use case。

      - You can also use the `interface` keyword to define an interface.

            interface Interf3

      - And you can define an alias, using the `as` keyword. This alias will be used latter, when defining relations.

            interface "Last\ninterface" as Interf4

      - We will see latter that interface definition is OPTIONAL.

        所謂 optional 是指類似下面 Basic example 中 `[First Component] ..> HTTP : use` 的用法，其中 `HTTP` 會被視為 interface，猜想是與 component 有關聯的物件才會預設被視為 interface，所以 `:actor: --> HTTP` 中的 `HTTP` 才會被視為 actor 而非 interface。

    Long description

      - It is possible to put description on several lines using square brackets.

            component comp1 [
            This component
            has a long comment
            on several lines
            ]

    Individual colors

      - You can specify a color after component definition.

            component  [Web Server] #Yellow

  - [Linking - Deployment Diagram syntax and features](http://plantuml.com/deployment-diagram#3)

      - It is possible to use several types of links:

            artifact1 --0 artifact8
            artifact1 --(0 artifact10

        `--(0` 與 `--0` 剛好可以營造出 required & provided interface 的效果。

  - [Are partial lollipop for component diagrams supported? \- PlantUML Q&A](https://forum.plantuml.net/1736/are-partial-lollipop-for-component-diagrams-supported) (2014-03-20)

      - I'm wondering interface dependencies should be expressed with PlantUML. The PARTIAL LOLLIPOP along with ports sweem to be the current answer, but I don't know how to do it with PlantUML. Any advice?

      - The support of lollipop and port is (still) really limited within PlantUML. Here is an UNDOCUMENTED example that is working right now:

            component comp1
            component comp2
            comp1 *-0)-+ comp2
            [comp3] <-->> [comp4]

        這只是用 `0` 模擬出 interface 的效果，不過 `--(` 的用法倒是給了一點啟發：

            [Component] -right-( Interface
            [AnotherComponent] -left- Interface

        確實能營造出 `Component --( O-- Another Component` 的效果!! 左邊是 required interface，右邊是 provided interface。

## Deployment Diagram

  - [Deployment Diagram syntax and features](http://plantuml.com/deployment-diagram)

    Declaring element

        actor actor
        agent agent
        artifact artifact
        boundary boundary
        card card
        cloud cloud
        component component
        control control
        database database
        entity entity
        file file
        folder folder
        frame frame
        interface  interface
        node node
        package package
        queue queue
        stack stack
        rectangle rectangle
        storage storage
        usecase usecase

      - You can optionaly put text using bracket `[]` for a long description.

            folder folder [
            This is a <b>folder
            ----
            You can use separator
            ====
            of different kind
            ....
            and style
            ]

            node node [
            This is a <b>node
            ----
            You can use separator
            ====
            of different kind
            ....
            and style
            ]

            database database [
            This is a <b>database
            ----
            You can use separator
            ====
            of different kind
            ....
            and style
            ]

            usecase usecase [
            This is a <b>usecase
            ----
            You can use separator
            ====
            of different kind
            ....
            and style
            ]

        其中 `--` 跟 `==` 可以畫出分隔線 (至少 2 個字元)。

## Wireframe (Salt) ??

  - [Draw GUI mockup with Salt](http://plantuml.com/salt) #ril

## MindMap Diagram ??

  - [What's new ?](http://plantuml.com/news) 2019-03-01 開始支援 MindMap diagram

  - [MindMap syntax and features](http://plantuml.com/mindmap-diagram) #ril

      - MindMap diagram are still in beta: the syntax MAY CHANGE without notice.

        可以用，但最好是拿產生的圖來用就好。

    OrgMode syntax

      - This syntax is compatible with OrgMode

            @startmindmap
            * Debian
            ** Ubuntu
            *** Linux Mint
            *** Kubuntu
            *** Lubuntu
            *** KDE Neon
            ** LMDE
            ** SolydXK
            ** SteamOS
            ** Raspbian with a very long name
            *** <s>Raspmbc</s> => OSMC
            *** <s>Raspyfi</s> => Volumio
            @endmindmap

    Removing box

      - You can remove the box drawing using an underscore.

            @startmindmap
            * root node
            ** some first level node
            ***_ second level node
            ***_ another second level node
            ***_ foo
            ***_ bar
            ***_ foobar
            ** another first level node
            @endmindmap

        這還滿實用的! 加 node 可以用來表現 content? 例如：

            @startmindmap
            * Topic
            **_ Section 1
            **_ Section 2
            ** Other Node 1
            ** Other Node 2
            @endmindmap

    Arithmetic notation

      - You can use the following notation to choose DIAGRAM SIDE.

## PNG Metadata ??

  - [How long do the images generated by PlantUML Server live for? - Frequently Asked Questions](http://plantuml.com/faq#3) 提到 "Furthermore, the diagram data is stored in PNG metadata, so you can fetch it even from a downloaded image."
  - [PlantUML Pleasantness: Get PlantUML Definition From PNG \- Messages from mrhaki](http://mrhaki.blogspot.com/2016/12/plantuml-pleasantness-get-plantuml.html) (2016-12-16) #ril

## 安裝設置 {: #setup }

PlantUML 本身不用安裝，就一個 JAR 檔而已；除了 Java 外，可能也需要 Graphviz。

```
$ printf "@startuml\nAlice -> Bob: test\n@enduml" | java -jar plantuml.jar -pipe > sequence.png
$ open sequence.png
```

參考資料：

  - [Local installation - Quick Start Guide](http://plantuml.com/starting)
      - You need these things to run PlantUML: Java, Graphviz (optional if you only need sequence diagrams and activity (beta) diagrams)
      - Installed the above? Then simply download `plantuml.jar` and run it to open PlantUML's graphical user interface. There is no need to unpack or install anything. 原來也有 GUI
  - [Frequently Asked Questions about installation](http://plantuml.com/faq-install) #ril

### Docker ??

  - [plantuml's Profile \- Docker Hub](https://hub.docker.com/u/plantuml) 官方沒有提供 PlantUML Server 以外的 image，但似乎也可以只用裡面的 CLI?

## 參考資料 {: #reference }

  - [PlantUML](http://plantuml.com/)
  - [What's new?](http://plantuml.com/news)
  - [Real World PlantUML](https://real-world-plantuml.com/)

社群：

  - [PlantUML Forum](http://forum.plantuml.net/)
  - ['plantuml' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/plantuml)

學習資源：

  - [Drawing UML with PlantUML](http://plantuml.com/guide) (PDF)
  - [PlantUML Pleasantness - Mr. Haki](https://mrhaki.blogspot.com/search/label/PlantUML)

工具：

  - [Online Demo Server](http://www.plantuml.com/plantuml/uml/)
  - [PlantText UML Editor](https://www.planttext.com/)
  - [Drawing UML with Plant UML (plant-uml-4.me)](https://plant-uml-4.firebaseapp.com/)

更多：

  - [PlantUML Server](plantuml-server.md)

相關：

  - [UML](uml.md)

手冊：

  - [Release Notes](http://plantuml.com/changes)
  - [Language Specification](http://plantuml.com/sitemap-language-specification)
  - [Help - Command Line](http://plantuml.com/command-line#8)
  - [PlantUML Cheat Sheet - DrawUML](http://ogom.github.io/draw_uml/plantuml/)
