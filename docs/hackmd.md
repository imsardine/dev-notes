# HackMD

優缺點：

  - 多人即時編輯。
  - 支援 MathJax 與各式圖表，包括 Sequence Diagram、Flowchart、Graphviz 等。
  - 只支援 title 的搜尋?
  - 頁面間的連結要靠 URL? 但畢章 HackMD 不把自己定位在 Wiki

---

參考資料：

  - [HackMD \- Collaborative markdown notes](https://hackmd.io/) #ril

      - Build a community with open collaboration.

  - [Features \- HackMD](https://hackmd.io/features) #ril

  - [HackMD \- Markdown 協作筆記 \- g0v Civic Tech Grant](https://grants.g0v.tw/projects/5870cf275b69a6001ef69bd1) #ril

## 新手上路 {: #getting-started }

  - [Getting Started \- HackMD](https://hackmd.io/getting-started) #ril

    Share Notes

      - If you want to share an EDITABLE note, just copy the URL.

        預設拿到 URL 的人就 editable (甚至不用登入)，聽起來有點危險？不過反正都可以看到內容，好像也沒什麼差別。從另一個角度來想，有 URL 就可以請別人一起共編，其實也滿方便的，少了註冊登入的門檻。

      - If you want to share a read-only note, simply press publish button and copy the URL.

## 是否適用於企業內部？ {: #enterprise }

  - [Permissions - Features \- HackMD](https://hackmd.io/features#Permissions) #ril

      - 圖片自動上傳到 imgur 好嗎?
      - 沒有資料夾/群組的概念，每份文件的存取限制都要個別設定。
      - 分享 editable 與 read-only 的差別在 URL，若 editable link 流出去就無法限制?

## Slide Mode {: #slide-mode }

  - [Make Presentation Slides with HackMD \- HackMD](https://hackmd.io/s/how-to-create-slide-deck)

      - HackMD integrates reveal.js so we can easily make a deck of presentation slides within a markdown note.

    Separating Slides

      - It takes THREE LINES to separate slides: an empty line, three dashes, and another empty line.

            
            ---
            

        :bulb: Hint: The most common mistake in making a slide deck is overlooking the empty lines either before the dashes or after the dashes. We need both empty lines to separate the slides!

    Slide Modes

      - We can choose Slide Mode from the “Mode” dropdown (by default showing View Mode) in the sharing menu at top right corner, and hit “Preview” to see your slide.

      - Overview Mode

        When we are in the slide mode, we can press the <Esc> key on the keyboard and we will see the overview of all slides.

        We can then use the keyboard :arrow_left: :arrow_up: :arrow_down: :arrow_right: to select which slide we want to jump to before hitting <Enter> or <Return>.

      - Speaker Mode

        When we are in the slide mode, we can press the <s> key on the keyboard and we will see a pop-up speaker window, which shows the next slide and time we’ve spent.

    Sectioning

      - SECTIONING allows us to skip or dive into some slides without breaking the flow.

        For example, if you are presenting with the slide-example, you can skip (or dive into) the section of the first slide, depending on your time remaining and your audience (see below image).

        原來切 section 有這個用意，視情況 (時間、聽眾) 決定要不要展開細節。

      - So how do we make a section? With an empty line, FOUR dashes, and another empty line.

            # Title Slide

            ---

            # The second slide

            ----

            ## The second slide (also technically the third slide) now belongs to the section of the first slide.

      - Recap: REGULAR SLIDES are separated by a leading `<empty line> --- <empty line>` and SECTION SLIDES by a leading `<empty line> ---- <empty line>`.

        :bulb: Hint: If we want to use a regular slide after a SUB SLIDE in a section, use the three dashes separator.

    Export slides to PDF format

      - Scroll the page to the bottom in slide mode, you can find the print icon like this :

        Click on it to enter Printing mode, and use browser built-in Print to PDF feature to export your slides.

        要刻意往下捲才看得到印表機的圖示。

    Advanced Usage: Customizing the Entire Deck -- Basic YAML header

      - We can customize the slide options using the YAML header in the slide markdown. For example:

            ---
            title: Example Slide
            tags: presentation
            slideOptions:
              theme: solarized
              transition: 'fade'
              # parallaxBackgroundImage: 'https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg'
            ---

      - make sure to have TWO SPACES only at the start of the listed slide options.

        As in all yaml header, we can comment out options with a `#`.

    Advanced Usage: Customizing individual slides

      - custom background image:

            ---

            <!-- .slide: data-background="https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg" -->
            #### testslide

            ---

    Advanced Usage: Spotlight mode

      - Forgot your laser pointer at home, or cannot use a pointer in an online meeting? Enable the SPOTLIGHT MODE in YAML frontmatter like below:

        確實，雷射筆在 online meeting 派不上用場。

            ---
            slideOptions:
              spotlight:
                enabled: true
            ---

      - When the spotlight is enabled, HOLD YOUR MOUSE LEFT KEY will keep the spotlight on.

        透過觸控板操作時也一樣，按下觸控板時 spotlight 才會出現。

        :bulb: Hint: When spotlight is on, you need to use arrow keys :arrow_left::arrow_up::arrow_down::arrow_right: to navigate slides.

    Advanced Usage: Slide Timer

      - Want to keep track of the time without constantly checking your watch?

        Enable the slide timer in YAML frontmatter:

            ---
            slideOptions:
              allottedMinutes: 5  # Minutes alloted for a slide.
            ---

        A red progress bar will be shown above the blue progress bar, which indicates the ELAPSED TIME. You can track progress by it in your presentation. :running:

## 參考資料 {: #reference }

  - [HackMD](https://hackmd.io/)

更多：

  - [CodiMD](codimd.md)

手冊：

  - [YAML Customization Options](https://hackmd.io/s/how-to-create-slide-deck#Other-YAML-Customization-Options)
