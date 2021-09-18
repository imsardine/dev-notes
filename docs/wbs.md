# 工作分解結構 (Work Breakdown Structure, WBS)

  - 最難的是估算時間，可以增加一個自訂欄位 "Estimation" 記錄估算的基礎，之後做調整才有依據。

  - [WBS: The Base for All Plans | SOMOS](http://www.somos.com/resources/know/articles/08090501)

      - Many projects have been successful without any sort of written plan or schedule at all, so obviously we can do without a WBS. But usually someone wants better PREDICTABILITY, better insight into performance, better communications, better use of resources, better results, better return on investment, or just better control. A good WBS can help achieve these.

        執行專案不一定要有 WBS，但有了 WBS 比較容易控管。

      - The Work Breakdown Structure is the basis of the contract between the project manager and the sponsoring organization. It is the tool that defines the scope or contents or deliverables of the project, and SCOPE DRIVES EVERYTHING.

      - While problems with schedule, cost, or resources may be self-contained, scope problems usually lead to new problems with cost, schedule, resources, client relationships, TEAM MORALE (士氣), contracts, and profitability. So it makes sense to create the STRONGEST WBS possible, right from the beginning.

        沒錯，scope 如果沒有確定下來所引發的問題很複雜...

      - to make the WBS COMPREHENSIVE. Aim to make the WBS exhaustive in its coverage: including everything that will be delivered and nothing that will not be delivered. In this way, no work will be done "off the page" or "UNDER THE TABLE" and nothing on the table will be missed. This is a great way to build everyone's CONFIDENCE that the project is thoroughly understood.

        很多時候會聽到某些工作沒被排進 WBS，但最後還是得做...

      - The next recommendation is to make the WBS PRODUCT-ORIENTED. Yes, many standards allow for a process-oriented WBS. And many methodologies instruct the PM to "list the tasks to be performed in a hierarchical work breakdown structure, showing phases..." but this approach is weaker.

          - THE PROJECT SHOULD BE ABOUT RESULTS - the customer wants results from the contractor; the manager wants results from the team; the delivery organization needs successful business results. A product-oriented WBS supports the focus on results and deliverables. Every WBS element becomes a target to be completed and every scope discussion will be about results.
          - "Service contract" means a contract that directly engages the time and effort of a contractor whose primary purpose is to PERFORM AN IDENTIFIABLE TASK RATHER THAN TO FURNISH AN END ITEM OF SUPPLY.' For time and effort elements within the WBS, activity- or process-orientation is appropriate.
          - 就軟體開發而言，第一階段會是產品的開發，所以適用 product-oriented 的做法，但後期多屬 beta activilities，則於 process/phase-oriented。

      - A good hierarchy will allow planning to proceed in stages, with high level place-holders where only preliminary planning has been completed, and detailed WBS elements at a low level where more thorough planning has been performed.

## Phase/process-oriented or deliverable-oriented?

  - 似乎很多人在講 deliverable-oriented 才是對的，該做的事情比較不會漏，但好像沒那麼絕對？
  - 或許 Y 軸切階段也沒錯，雖然時間軸本來就在 Gantt 的 X 軸，隨著時間推移，目光會越往 Gantt 的右下角移動...
  - 或許混用 phase/deliverable-oriented 才是對的；第一層 phase-oriented，第二層開始才是 deliverable-oriented

  - "初期" 在開發產品屬於 product-oriented，"後期" 則在 Beta、TOI 等，比較偏 process/phase-oriented

    注意這裡 "初期"/"後期" 的說法，這或許說明了第一層應該是 process/phase-oriented

  - 階段之間會用 FS 關係連起來?? 如果上個階段有個工作比較晚結束，下個階段會受到影響

    任務的時間似乎不能早於階段本身，所以把所有階段都撐得一樣長就沒意義了??
