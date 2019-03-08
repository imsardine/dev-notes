---
title: UML / State Diagram
---
# [UML](uml.md) / State Diagram

 * state diagram 也被稱做 statechart 或 state machine diagram (stm)。
 * 透過 staet diagram 的分析，可以思考有哪些 state 會停留，每個 state 又會受到什麼 event 影響而產生變化...
   ** 把 event (包括時間流逝) 跟 state 全部列出來，然後對每一個 state 評估不同 event 會發生什麼影響。
   ** test case 可以用來確認是否能成功轉換到另一個 state，而且表現出預期的行為；一種 event 寫一個 test case，但可以用不同方式觸發 (好像能有效減少 test case 的數量??)
 * A state machine diagram models the behaviour of a single object, specifying the sequence of events that an object goes through during its lifetime in response to events. 這包話把所有的動點都提到了
 * 生命週期（lifetime）中，狀態會經歷不同的變化 - 受到內／外部刺激而產生狀態上的變化
 * 啟始／最終狀態；一個 "區域" 最多只能有一個啟始狀態，但可以有多個最終狀態。
 * 合成狀態（composite state）表示某個狀態 "含有其他狀態" 的情形 （細分??）
   ** 上層為超狀態（super state），細分出次狀態（sub state），階層關係。但就算有分支，同時間也只能處於一個 state。
   ** 汽車引擎的例子很好!! 這是 composite 還是 orthogonal??
 * Orthogonal regions
   ** 似乎也是 composite state 的一種?? 但要怎麼套 shallow/deep history??
   ** Astah 從 6.1 開始支援 http://astah.net/release-notes/community/com-6.1
   ** 有多個次狀態在同一時間發生的話，稱為平行次狀態，之間的交互關係怎麼描述?? 利用 action，而這個 action 剛好是另一個 region 的 trigger，例如 http://dirkraffel.com/blog/wp-content/uploads/2009/12/switch.png
 * 狀態符號切成上下兩塊，上面寫狀態名稱，下面則做為 "內部轉移區塊"，可以用來標示 "物件在狀態之中所執行的活動 activity" (注意這裡 "狀態之中" 的說法，就算是 entry / action 也是已經確定進入該狀態了)
   ** 可以有多個 entry/, do/ ??
   ** entry / action = 進入時要執行的動作；通用的進場動作 (如果是 transition 特有的，要寫在 transition 上)
   ** do / activity = 定期要執行的 "活動" -> 可能會造成狀態轉移；注意這裡用 "activity" 而非 "action"，表示持續在進行著...
   ** exit / action = 離開時要執行的動作；退場動作
 * 自我轉移（self-transition） = 重新回到本身
   ** 從購物車取出商品，直到最後一個商品拿出來時才會造成 "單純轉移"（往空的狀態移動），否則只是減去購物車裡商品的數量而已。
 * 流沙的例子很棒，可以同時說明內部事件造成的轉移
   ** 沙漏被 "上下倒放" 的事件觸發，狀態從停止轉至 "沙從上到下在移動著"，當最後一粒沙往下流時，狀態就會回到 "停止"
   ** 結束轉移 = 因為內部動作 "do / 讓沙往下流" 的內部動作全部完成後（結束事件），而造成的自行轉移。雖然箭頭上不會標示觸發的事件，但真正的觸發器是 "最後一粒沙往下流"。(沒標示 = 結束轉移??)
 * 轉移（transition）用箭頭表示，上面 transition label 的表示法為 event[guard]/action。
   ** 或許 trigger[guard]/effect 的說法更正確??
   ** event/trigger = 狀態轉移的觸發器（trigger），通常是方法的呼叫，可以帶有引數，例如 `addItem(item)`；時間的流逝也是一種 trigger
   ** guard = 條件式，在轉移前被評估，如果是 false 則維持原來的狀態
   ** effect/action = 這項轉移被觸發時所要執行的動作，例如 "更新庫存數"，不同於 event
   ** trigger, guard, effect 不一定要用駱駝文（例如 pressButton()）書寫，可以寫成 press button，也就是說跟 code 不一定要有對應關係
 * 怎麼表現 "某個 checking 的結果符合某條件才轉移"，其中 checking rule 還可以畫成 activity diagram.
   ** http://www.altova.com/images/screenshots/uml-state-machine-diagram.png 用 decision 來做；但我覺得應該寫成 action 而非 event/trigger??
 * State diagram 也可以有菱形的分支結構，而且可以連續使用；用示法跟 activity diagrams 的 control flow 很像。

參考資料：

  - [State diagram \- Wikipedia](https://en.wikipedia.org/wiki/State_diagram)
      - A state diagram is a type of diagram used in computer science and related fields to describe the BEHAVIOR OF SYSTEMS. State diagrams require that the system described is composed of a FINITE NUMBER OF STATES; sometimes, this is indeed the case, while at other times this is a REASONABLE ABSTRACTION. Many forms of state diagrams exist, which differ slightly and have different SEMANTICS. 所謂 abstraction 就是只把系統關心的部份納進來，所以 state 的數量有限並不是什麼問題。
      - State diagrams are used to give an abstract description of the behavior of a system. This behavior is analyzed and represented as A SERIES OF EVENTS that can occur in one or more possible STATES. Hereby "each diagram usually represents objects of a single class and track the different states of its objects through the system".
      - State diagrams can be used to graphically represent finite state machines.

    Harel statechart

      - Harel statecharts, invented by computer scientist David Harel, are gaining widespread usage since a VARIANT has become part of the Unified Modeling Language (UML). The diagram type allows the modeling of superstates, orthogonal regions??, and activities as part of a state.
      - Classic state diagrams require the creation of distinct nodes for every valid combination of parameters that define the state. This can lead to a very large number of nodes and transitions between nodes for all but the simplest of systems (state and transition EXPLOSION). This complexity reduces the readability of the state diagram.
      - With Harel statecharts it is possible to model multiple cross-functional?? state diagrams within the statechart. Each of these cross-functional state machines can transition internally without affecting the other state machines in the statechart. The current state of each cross-functional state machine in the statechart defines the state of the system. The Harel statechart is equivalent to a state diagram but it improves the readability of the resulting diagram. 指一個 statechart 可以同時表現多個 state machine??

    State diagrams versus flowcharts #ril

      - Newcomers to the state machine formalism often confuse state diagrams with flowcharts. The figure below shows a comparison of a state diagram with a flowchart. A state machine (panel (a)) performs actions IN RESPONSE TO EXPLICIT EVENTS. In contrast, the flowchart (panel (b)) does not need explicit events but rather transitions from node to node in its graph AUTOMATICALLY UPON COMPLETION OF ACTIVITIES.

        ![](https://en.wikipedia.org/wiki/File:Statechart_vs_flowchart.png)

  - [UML state machine \- Wikipedia](https://en.wikipedia.org/wiki/UML_state_machine)
      - UML state machine, also known as UML statechart, is a significantly enhanced realization of the mathematical concept of a finite automaton in computer science applications as expressed in the Unified Modeling Language (UML) notation
      - The concepts behind it are about organizing the way a device, computer program, or other (often technical) process works such that an entity or each of its sub-entities is always in EXACTLY ONE of a number of possible states and where there are well-defined CONDITIONAL TRANSITIONS between these states.
      - UML state machine is an OBJECT-BASED variant of Harel statechart, adapted and extended by UML. The goal of UML state machines is to overcome the main limitations of traditional finite-state machines while retaining their main benefits. UML statecharts introduce the new concepts of hierarchically nested states?? and orthogonal regions??, while extending the notion of actions.

    Basic state machine concepts

      - Many software systems are event-driven, which means that they continuously wait for the occurrence of some external or internal event such as a mouse click, a button press, a time tick, or an arrival of a data packet. ... The response to an event generally depends on both the type of the event and on the internal state of the system and can include a change of state leading to a STATE TRANSITION. The pattern of events, states, and state transitions among those states can be abstracted and represented as a finite-state machine (FSM).
      - The concept of a FSM is important in event-driven programming because it makes the event handling explicitly dependent on BOTH the event-type and on the state of the system. When used correctly, a state machine can drastically cut down the number of execution paths through the code, simplify the conditions tested at each branching point, and simplify the switching between different modes of execution. Conversely, using event-driven programming without an underlying FSM model can lead programmers to produce error prone, difficult to extend and excessively complex application code.

        搭配 domain model 更有感!! [States - UML state machine \- Wikipedia](https://en.wikipedia.org/wiki/UML_state_machine#States) 明確提到實作面的優勢 -- 檢查單一個 state variable 即可。

## 新手上路 ?? {: #getting-started }

  - [Basic state machine concepts - UML state machine \- Wikipedia](https://en.wikipedia.org/wiki/UML_state_machine#Basic_state_machine_concepts)

    Basic UML state diagrams

      - UML preserves the general form of the traditional state diagrams. The UML state diagrams are DIRECTED GRAPHS in which nodes denote states and connectors denote state transitions.

        For example, Figure 1 shows a UML state diagram corresponding to the computer keyboard state machine. In UML, states are represented as rounded rectangles labeled with state names. The transitions, represented as arrows, are labeled with the TRIGGERING EVENTS followed optionally by the list of EXECUTED ACTIONS. The initial transition originates from the SOLID CIRCLE and specifies the DEFAULT STATE when the system first begins. Every state diagram should have such a transition, which should NOT BE LABELED, since it is not triggered by an event. The initial transition can have associated actions. 一定要有 initial transition，而且沒有 label (一個黑點也沒地方標示)

        ![](https://en.wikipedia.org/wiki/File:UML_state_machine_Fig1.png)

    Events

      - An event is something that happens that affects the system. Strictly speaking, in the UML specification, the term event refers to the TYPE OF OCCURRENCE rather than to any concrete instance of that occurrence. For example, Keystroke is an event for the keyboard, but each press of a key is not an event but a concrete instance of the Keystroke event. Another event of interest for the keyboard might be Power-on, but turning the power on tomorrow at 10:05:36 will be just an instance of the Power-on event.
      - An event can have associated PARAMETERS, allowing the event instance to convey not only the occurrence of some interesting incident but also quantitative information regarding that occurrence. For example, the Keystroke event generated by pressing a key on a computer keyboard has associated parameters that convey the character scan code as well as the status of the Shift, Ctrl, and Alt keys.
      - An event instance OUTLIVES the instantaneous occurrence that generated it and might convey this occurrence to ONE OR MORE state machines. Once generated, the event instance goes through a processing life cycle that can consist of up to three stages. First, the event instance is received when it is accepted and waiting for processing (e.g., it is placed on the EVENT QUEUE 呼應下面 RTC 的說法). Later, the event instance is dispatched to the state machine, at which point it becomes the current event. Finally, it is consumed when the state machine finishes processing the event instance. A consumed event instance is no longer available for processing.

    States

      - Each state machine has a state, which governs reaction of the state machine to events. For example, when you strike a key on a keyboard, the character code generated will be either an uppercase or a lowercase character, depending on whether the Caps Lock is active. Therefore, the keyboard's behavior can be DIVIDED into two states: the "default" state and the "caps_locked" state. (Most keyboards include an LED that indicates that the keyboard is in the "caps_locked" state.) The behavior of a keyboard depends only on certain aspects of its history, namely whether the Caps Lock key has been pressed, but not, for example, on how many and exactly which other keys have been pressed previously. A state can ABSTRACT AWAY all possible (but irrelevant) event sequences and capture only the relevant ones. <-- 這正式 abstraction 的本質!!
      - In the context of software state machines (and especially classical FSMs), the term state is often understood as a SINGLE STATE VARIABLE that can assume only a limited number of a priori determined values (e.g., two values in case of the keyboard, or more generally - some kind of variable with an enum type in many programming languages). The idea of state variable (and classical FSM model) is that the value of the state variable fully defines the CURRENT STATE of the system at any given time. The concept of the state reduces the problem of identifying the execution context in the code to testing just the state variable instead of many variables, thus eliminating a lot of conditional logic.

    Extended states

      - In practice, however, interpreting the whole state of the state machine as a SINGLE STATE VARIABLE quickly becomes impractical for all state machines beyond very simple ones. Indeed, even if we have a single 32-bit integer in our machine state, it could contribute to over 4 billion different states - and will lead to a PREMATURE STATE EXPLOSION??. This interpretation is not practical, so in UML state machines the whole state of the state machine is commonly split into (a) ENUMERATABLE state variable and (b) all the other variables which are named EXTENDED STATE. Another way to see it is to interpret enumeratable state variable as a QUALITATIVE aspect and extended state as QUANTITATIVE aspects of the whole state. In this interpretation, a change of variable does not always imply a change of the qualitative aspects of the system behavior and therefore does not lead to a change of state. 這一段解釋得真好!!
      - State machines supplemented with extended state variables are called EXTENDED STATE MACHINES and UML state machines belong to this category. Extended state machines can apply the underlying formalism to much more complex problems than is practical WITHOUT INCLUDING extended state variables. For example, if we have to implement some kind of limit in our FSM (say, limiting number of keystrokes on keyboard to 1000), without extended state we'd need to create and process 1000 states - which is not practical; however, with an extended state machine we can introduce a `key_count` variable, which is initialized to 1000 and decremented by every keystroke WITHOUT CHANGING STATE VARIABLE.

        在 action 的地方改用對 extended state variable 的操作即可，竟然還可以加上分支符號 -- 可能只有 quantitative aspects 改變，但 qualitative aspect 不變。

        ![](https://en.wikipedia.org/wiki/File:UML_state_machine_Fig2.png)

      - The state diagram from Figure 2 is an example of an extended state machine, in which the complete condition of the system (called the extended state) is the combination of a qualitative aspect—the state variable—and the quantitative aspects—the extended state variables.
      - The obvious advantage of extended state machines is flexibility. For example, changing the limit governed by `key_count` from 1000 to 10000 keystrokes, would not complicate the extended state machine at all. The only modification required would be changing the initialization value of the `key_count` extended state variable during initialization.
      - This flexibility of extended state machines comes with a price, however, because of the COMPLEX COUPLING between the "qualitative" and the "quantitative" aspects of the extended state. The coupling occurs through the GUARD CONDITIONS attached to transitions, as shown in Figure 2.

    Guard conditions

      - Guard conditions (or simply guards) are Boolean expressions evaluated dynamically based on the value of extended state variables and EVENT PARAMETERS. Guard conditions affect the behavior of a state machine by enabling actions or transitions only when they evaluate to TRUE and disabling them when they evaluate to FALSE. In the UML notation, guard conditions are shown in square brackets (e.g., `[key_count == 0]` in Figure 2).
      - The need for guards is the immediate consequence of adding memory?? extended state variables to the state machine formalism. Used sparingly, extended state variables and guards make up a powerful mechanism that can simplify designs. On the other hand, it is possible to abuse extended states and guards quite easily. 不過話說回來，guard 也可以判斷 event parameter，跟 extended state variable 的出現不一定有關就是了。

    Actions and transitions

      - When an event instance is dispatched, the state machine RESPONDS BY PERFORMING ACTIONS, such as changing a variable, performing I/O, invoking a function, generating another event instance??, or changing to another state. Any parameter values associated with the current event are available to all actions directly caused by that event.
      - Switching from one state to another is called state transition, and the event that causes it is called the TRIGGERING EVENT, or simply the trigger. In the keyboard example, if the keyboard is in the "default" state when the CapsLock key is pressed, the keyboard will enter the "caps_locked" state. However, if the keyboard is already in the "caps_locked" state, pressing CapsLock will cause a different transition—from the "caps_locked" to the "default" state. In both cases, pressing CapsLock is the triggering event.
      - In extended state machines, a transition can have a guard (因為主要在判斷 extended state variable), which means that the transition can "fire" only if the guard evaluates to TRUE. A state can have many transitions in response to the same trigger, as long as they have NONOVERLAPPING guards (重疊才有機會同時觸發多個吧??); however, this situation could create problems in the sequence of evaluation of the guards when the common trigger occurs. The UML specification intentionally does not stipulate any particular order; rather, UML puts the burden on the designer to devise guards in such a way that the order of their evaluation does not matter. Practically, this means that guard expressions should have NO SIDE EFFECTS, at least none that would alter evaluation of other guards having the same trigger.

    Run-to-completion execution model

      - All state machine formalisms, including UML state machines, universally assume that a state machine completes processing of each event before it can start processing the next event. This model of execution is called RUN TO COMPLETION, or RTC. 穩定地切換到另一個 state 後 (idle)，才會處理下一個 event
      - In the RTC model, the system processes events in discrete, INDIVISIBLE RTC steps. New incoming events cannot interrupt the processing of the current event and must be stored (typically in an event queue) until the state machine becomes IDLE again. These semantics completely avoid any internal concurrency issues within a single state machine. The RTC model also gets around the conceptual problem of processing actions associated with transitions, where the state machine is not in a well-defined state (is between two states) for the duration of the action. During event processing, the system is unresponsive (unobservable), so the ill-defined state during that time has no practical significance. 會引發什麼問題??
      - Note, however, that RTC does not mean that a state machine has to monopolize the CPU until the RTC step is complete. The preemption restriction only applies to the TASK CONTEXT of the state machine that is already busy processing events. In a multitasking environment, other tasks (not related to the task context of the busy state machine) can be running, possibly preempting the currently executing state machine. As long as other state machines do NOT SHARE variables or other resources with each other, there are no concurrency hazards.
      - The key advantage of RTC processing is SIMPLICITY. Its biggest disadvantage is that the responsiveness of a state machine is determined by its longest RTC step. Achieving short RTC steps can often significantly complicate real-time designs.

  - [UML extensions to the traditional FSM formalism - UML state machine \- Wikipedia](https://en.wikipedia.org/wiki/UML_state_machine#UML_extensions_to_the_traditional_FSM_formalism) #ril

** The most important innovation of UML state machines over the traditional FSMs is the introduction of hierarchically nested states (that is why statecharts are also called hierarchical state machines, or HSMs). The semantics associated with state nesting are as follows (see Figure 3): If a system is in the nested state, for example "result" (called the substate), it also (implicitly) is in the surrounding state "on" (called the superstate). 這就是書本上所說的 "composite state"
** Hierarchical state decomposition can be viewed as exclusive-OR operation applied to states. 跟 XOR 有什麼關係?? 跟下面 AND-decomposition 有何不同??
** UML statecharts also introduce the complementary AND-decomposition. Such decomposition means that a composite state can contain two or more ORTHOGONAL REGIONS (orthogonal means independent in this context) and that being in such a composite state entails being in all its orthogonal regions simultaneously. Orthogonal regions address the frequent problem of a combinatorial increase in the number of states when the behavior of a system is fragmented into independent, concurrently active parts. 關鍵就在 "正交" (互相獨立) 這件事。
** For example, apart from the main keypad, a computer keyboard has an independent numeric keypad. From the previous discussion, recall the two states of the main keypad already identified: "default" and "caps_locked" (see Figure 1). The numeric keypad also can be in two states—"numbers" and "arrows"—depending on whether Num Lock is active. 意指如果兩個 state 有相關性，就要用 M x N 的組合來表示??
** The complete state space of the keyboard in the standard decomposition is the Cartesian product of the two components (main keypad and numeric keypad) and consists of four states: "default–numbers," "default–arrows," "caps_locked–numbers," and "caps_locked–arrows." However, this is unnatural because the behavior of the numeric keypad does not depend on the state of the main keypad and vice versa.
** Orthogonal regions allow you to avoid mixing the independent behaviors as a Cartesian product and, instead, to keep them separate, as shown in Figure 4.
** The general case of MUTUAL DEPENDENCY, on the other hand, results in multiplicative(倍增的) complexity, so in general, the number of states needed is the product k × l × m × ....
** In most real-life situations, however, orthogonal regions are only APPROXIMATELY ORTHOGONAL (i.e., they are not independent). Therefore, UML statecharts provide a number of ways for orthogonal regions to communicate and synchronize their behaviors. From these rich sets of (sometimes complex) mechanisms, perhaps the most important is that orthogonal regions can coordinate their behaviors by sending event instances to each other. 要怎麼維持 orthogonal regions 的表示法，但又可以描述其間的交互作用??
** When dealing with hierarchically nested states and orthogonal regions, the simple term current state can be quite confusing. In an HSM, more than one state can be active at once. If the state machine is in a leaf state that is contained in a composite state (which is possibly contained in a higher-level composite state, and so on), all the composite states that either directly or transitively contain the leaf state are also active. Furthermore, because some of the composite states in this hierarchy might have orthogonal regions, the current active state is actually represented by a tree of states starting with the single top state at the root down to individual simple states at the leaves. The UML specification refers to such a state tree as STATE CONFIGURATION. 一串粽子一樣，這就是所謂的 composite state!!

  - [Unified Modeling Language (UML) \| State Diagrams \- GeeksforGeeks](https://www.geeksforgeeks.org/unified-modeling-language-uml-state-diagrams/) #ril

## 工具 {: #tools }

  - [UML state diagrams with draw\.io – draw\.io](https://about.draw.io/uml-state-diagrams-with-draw-io/) #ril
  - [State Machine Diagram Tutorial \| Lucidchart](https://www.lucidchart.com/pages/uml-state-machine-diagram) #ril

## 參考資料 {: #reference }

相關：

  - [Finite State Machine (FSM)](finite-state-machine.md)

