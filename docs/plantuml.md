# PlantUML

  - [Open\-source tool that uses simple textual descriptions to draw UML diagrams\.](http://plantuml.com/index)
      - PlantUML is a component that allows to quickly write : Sequence diagram, Usecase diagram, Class diagram, Activity diagram, Component diagram, State diagram, Object diagram, Deployment diagram, Timing diagram (不同於一般的 timeline，但也是 UML 標準圖形之一)
      - The following non-UML diagrams are also supported: Wireframe graphical interface, Archimate?? diagram, Specification and Description Language (SDL), Ditaa diagram, Gantt diagram, Mathematic with [AsciiMath](http://asciimath.org/) or [JLaTeXMath](https://github.com/opencollab/jlatexmath) notation 沒想過有支持這些!! 2019-03-01 也開始支援 MindMap 了
      - Diagrams are defined using a simple and intuitive language. (see PlantUML Language Reference Guide). Images can be generated in PNG, in SVG or in LaTeX format. It is also possible to generate ASCII art diagrams (only for sequence diagrams). 轉成 LaTeX 是什麼概念?? 為什麼 [PlantText UML Editor](https://www.planttext.com/) 不是 sequence diagram 也可以轉 TXT??

## 應用實例 {: #powered-by }

  - [Tools using the PlantUML language](http://plantuml.com/running)

## 新手上路 ?? {: #reference }

  - [General and common command to handle graphic layout in diagrams\.](http://plantuml.com/commons) #ril
      - Comments -- Everything that starts with simple quote `'` is a comment. You can also put comments on several lines using `/'` to start and `'/` to end. 好奇特的語法!! 想到 `~/.vimrc` 是用 `"` 來當註解。

  - [Quick Start Guide](http://plantuml.com/starting) #ril
  - [Frequently Asked Questions](http://plantuml.com/faq) #ril

## Note, Title / Caption, Header / Footer ??

  - [Footer and header - General and common command to handle graphic layout in diagrams\.](http://plantuml.com/commons) #ril
      - You can use the commands `header` or `footer` to add a footer or a header on any generated diagram.
      - You can optionally specify if you want a `center`, `left` or `right` footer/header, by adding a keyword.
      - As for title, it is possible to define a header or a footer on several lines. 跟 `header`/`footer` command 相連的幾行，都會被視為內容；但 title 有另一個 command 不是??
      - It is also possible to put some HTML into the header or footer. (通常是為了控制顏色)

            @startuml
            Alice -> Bob: Authentication Request

            header
            <font color=red>Warning:</font>
            Do not use in production.
            endheader

            center footer Generated for demonstration

            @enduml

        ![](http://s.plantuml.com/imgw/commons-nfzmdfkb.webp)

## Line, Arrow ??

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

## Rendering ??

常用的指令：

  - 灰階輸出 -- `skinparam monochrome true`
  - 線條走直線且轉直角 -- `skinparam linetype ortho`

參考資料：

  - [Changing colors and fonts](http://plantuml.com/skinparam) #ril

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

            @startuml

            [*] --> State1
            State1 --> [*]
            State1 : this is a string <-- 冒號前後不一定要有空白，但這樣比較好讀
            State1 : this is another string

            State1 -> State2
            State2 --> [*]

            @enduml

        ![](http://s.plantuml.com/imgw/state-diagram-8fezmvpq.webp)

    Change state rendering

      - You can use hide empty description to render state as simple box. 不過慣例上好像還是會畫出來??

            @startuml
            hide empty description
            [*] --> State1
            State1 --> [*]
            State1 : this is a string
            State1 : this is another string

            State1 -> State2
            State2 --> [*]
            @enduml

        ![](http://s.plantuml.com/imgw/state-diagram-sfo60qtl.webp)

    Composite state

      - A state can also be composite. You have to define it using the `state` keywords and brackets (`{ ... }`).

        這裡剛好示範了 initial transition 直接進入 superstate 的狀況，習慣上確實會在 superstate 裡再畫上一個小黑點。

            @startuml
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
            @enduml

        ![](http://s.plantuml.com/imgw/state-diagram-xtzglfer.webp)

## MindMap Diagram ??

  - [What's new ?](http://plantuml.com/news) 2019-03-01 開始支援 MindMap diagram
  - [MindMap syntax and features](http://plantuml.com/mindmap-diagram) #ril

## PlantUML Server ??

  - [The servlet for server side](http://plantuml.com/server) #ril
  - [PlantUML & GitLab \| GitLab](https://docs.gitlab.com/ee/administration/integration/plantuml.html)
      - Before you can enable PlantUML in GitLab; you need to set up your own PlantUML server that will generate the diagrams. 動態透過 PlantUML server 轉成圖形，是由 GitLab server 或 browser 對 PlantUML server 發出請求??
      - With Docker, you can just run a container like this: `docker run -d --name plantuml -p 8080:8080 plantuml/plantuml-server:tomcat`

        The PlantUML URL will be the hostname of the server running the container.

  - [Online Demo Server](http://www.plantuml.com/plantuml/uml/) 跑的正是 PlantUML Server

  - [How long do the images generated by PlantUML Server live for? - Frequently Asked Questions](http://plantuml.com/faq#3)
      - Links to png or svg generated by PlantUML Server are valid forever (that is as long as the server is up). However, we do not store any diagrams on our servers.
      - This may sound contradictory. It is not: the whole diagram is COMPRESSED INTO THE URL ITSELF. When the server receives the URL, it decompresses the URL to retrieve the diagram text and generates the image. There is no need to store anything. Even if the server is down, you can retrieve the diagram using the flag `-decodeurl` with the command line. Furthermore, the diagram data is stored in PNG metadata, so you can fetch it even from a downloaded image.

        原來像 http://www.plantuml.com/plantuml/uml/SoWkIImgAStDuNBAJrBGjLDmpCbCJbMmKl18pSd9rr48po_AIL7aSaZDIm4g0W00 這樣的 URL，其產生的圖形為 http://www.plantuml.com/plantuml/png/SoWkIImgAStDuNBAJrBGjLDmpCbCJbMmKl18pSd9rr48po_AIL7aSaZDIm4g0W00，後面 `SoWkI...g0W00` 這一整串應該就是 `@startuml ... @enduml` 編碼的結果。

      - Occasionally we may activate HTTP traces on our server. This is mainly for performance issues (when we have some) to understand the traffic we get. Once the issue solved, we turn back off HTTP traces and we remove the logs.
      - Note that we are also counting the number of diagrams generated (printed at the home page) to measure general server load.
      - Concerning sensitive content: even if we do not store the generated diagrams, please be aware that all traffic goes through HTTP, so it's easy to catch. So you should probably install a LOCAL SERVER on your own network if you plan to generate diagrams with sensitive information.

  - [plantuml/plantuml\-server \- Docker Hub](https://hub.docker.com/r/plantuml/plantuml-server/) #ril

## PNG Metadata ??

  - [How long do the images generated by PlantUML Server live for? - Frequently Asked Questions](http://plantuml.com/faq#3) 提到 "Furthermore, the diagram data is stored in PNG metadata, so you can fetch it even from a downloaded image."
  - [PlantUML Pleasantness: Get PlantUML Definition From PNG \- Messages from mrhaki](http://mrhaki.blogspot.com/2016/12/plantuml-pleasantness-get-plantuml.html) (2016-12-16) #ril

## 安裝設定 {: #installation }

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

社群：

  - [PlantUML Forum](http://forum.plantuml.net/)
  - ['plantuml' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/plantuml)

文件：

  - [Drawing UML with PlantUML](http://plantuml.com/guide) (PDF)

工具：

  - [Online Demo Server](http://www.plantuml.com/plantuml/uml/)
  - [PlantText UML Editor](https://www.planttext.com/)

相關：

  - [UML](uml.md)

手冊：

  - [Language Specification](http://plantuml.com/sitemap-language-specification)
  - [Help - Command Line](http://plantuml.com/command-line#8)
  - [PlantUML Cheat Sheet - DrawUML](http://ogom.github.io/draw_uml/plantuml/)
