---
title: Software Development / Org (組織架構)
---
# [Software Development](dev.md) / Org (組織架構)

## Engineering Productivity (EP, EngProd) {: #engprod }

  - 隨著產品線增加，參與 development process 的 SWE 進一步發展出 TE (Test Engineer)、RE (Release Engineer) 及 SRE (Site Reliability Engineer)。

  - 早期 development process 裡最耗時的在手動整合測試的環節 (testing cycle)，因此將重點擺在發展 test automation，這過程中又從 TE 進一步發展出 SET (Software Engineer in Test)。

    TE 是產品專家，知道要測試什麼，而 SET 則是 infrastructure & tooling 的專家，負責建造 framework/package/tool、發展最佳實務以幫助 TE 及 SWE 實現 automation，像 [Espresso](https://developer.android.com/training/testing/espresso)、[EarlGrey](https://github.com/google/EarlGrey) 等都是 SET 的產出的成果。

    他們相信 metrics/data-driven engineering -- can’t improve what you can’t measure，例如量測 code/feature coverage。

  - 當 testing cycle 因為 test automation 明顯縮短後，整體的 development cycle 並沒有縮短，因此 SET 這群人又投入加速那些新的瓶頸 -- 開發 IDE 套件、自動化 release verification、monitorying、anomaly detection 等，工作範圍擴及 Engineering Productivity (EP)，這樣的轉變也讓 Google [重新思考 GTAC 的定位](https://events.withgoogle.com/gtac-2017/)。

    為了反應 SET 的工作內容，大家同意將職稱正名為 SETI (Software Engineer, Tools & Infrastructure)；唸做 [`sɛtɪ`](https://youtu.be/-yxoYb9qbiI?t=10)。

  - EP 透過開發/導入各類工具、推廣最佳實務、指供正確的指引 (guideline)、優化流程、文化的建立、教育訓練、引導 (guidance/coaching) 等不同方法，提昇工程師整體的生產力，建立對 code health、testability、maintainability 共同的價值關。

      - Be passionate about changing the way engineering is done
      - Prevention over detection
      - Quantitative mindset. Can’t improve what you can’t measure

---

參考資料：

  - [Google Testing Blog: From QA to Engineering Productivity](https://testing.googleblog.com/2016/03/from-qa-to-engineering-productivity.html) (2016-03-22)

      - In Google’s early days, a small handful of software engineers built, tested, and released software. But as the user-base grew and products proliferated, engineers started SPECIALIZING IN ROLES, creating more scale in the DEVELOPMENT PROCESS:

          - Test Engineers (TEs) -- tested new products and systems integration
          - Release Engineers (REs) -- pushed bits into production
          - Site Reliability Engineers (SREs) -- managed systems and data centers 24x7.

        This story focuses on the evolution of quality assurance and the roles of the engineers behind it at Google. The REs and SREs also evolved, but we’ll leave that for another day.

        看來 SRE 不在 Engineering Productivity 的範圍內?

      - Initially, teams relied heavily on MANUAL OPERATIONS. When we attempted to automate testing, we largely focused on the frontends, which worked, because Google was small and our products had fewer INTEGRATIONS.

        However, as Google grew, longer and longer manual test cycles bogged down iterations and delayed feature launches. Also, since we identified bugs later in the development cycle, it took us longer and longer to fix them. We determined that PUSHING TESTING UPSTREAM VIA AUTOMATION would help address these issues and accelerate velocity.

      - As manual testing transitioned to automated processes, two separate testing roles began to emerge at Google:

          - Test Engineers (TEs) -- With their deep PRODUCT KNOWLEDGE and test/quality domain expertise, TEs focused on WHAT SHOULD BE TESTED.
          - Software Engineers in Test (SETs) -- Originally software engineers with deep INFRASTRUCTURE AND TOOLING EXPERTISE, SETs built the frameworks and packages required to implement automation.

      - The impact was significant:

          - Automated tests became more efficient and deterministic (e.g. by improving runtimes, eliminating sources of flakiness, etc.)
          - METRICS DRIVEN engineering proliferated (e.g. improving code and feature coverage led to higher quality products).

      - Manual operations were reduced to manual verification on new features, and typically only in END-TO-END, CROSS PRODUCT INTEGRATION BOUNDARIES.

        呼應前面 "our products had fewer integrations"，這裡講的 test automation 指的是以往手動測試的部份，跟 unit testing 無關。

        TEs developed extreme depth of knowledge for the products they supported. They became GO-TO engineers for product teams that needed expertise in test automation and integration. Their role evolved into a broad spectrum of responsibilities: writing SCRIPTS to automate testing, creating tools so developers could test their own code, and constantly designing better and more creative ways to identify weak spots and break software.

        SETs (in collaboration with TEs and other engineers) built a wide array of test automation tools and developed BEST PRACTICES that were applicable across many products. Release velocity accelerated for products. All was good, and there was much rejoicing!

      - SETs INITIALLY FOCUSED ON building tools for reducing the testing cycle time, since that WAS THE MOST manually intensive and time consuming phase of getting product code into production. We made some of these tools available to the software development community: webdriver improvements, protractor, espresso, EarlGrey, martian proxy, karma, and GoogleTest.

        SETs were interested in sharing and collaborating with others in the industry and established conferences. The industry has also embraced the Test Engineering discipline, as other companies hired software engineers into similar roles, published articles, and drove Test-Driven Development into mainstream practices.

      - Through these efforts, the testing cycle time decreased dramatically, but interestingly the overall velocity did NOT increase proportionately, since other phases in the development cycle became the bottleneck. SETs started building tools to accelerate all other aspects of product development, including:

          - Extending IDEs to make writing and reviewing code easier, shortening the “write code” cycle
          - Automating release verification, shortening the “release code” cycle.
          - Automating real time production system log verification and ANOMALY DETECTION, helping automate production monitoring.
          - Automating measurement of DEVELOPER PRODUCTIVITY, helping understand what’s working and what isn’t.

        In summary, the work done by the SETs naturally progressed from supporting only product TESTING efforts to include supporting product DEVELOPMENT efforts as well. Their role now encompassed a much broader Engineering Productivity agenda.

        SET 的初衷是加速開發流程，早期針對 testing cycle，後來焦點擴展到 write code & release code cycle，所以後來改稱 SETI。

      - Given the expanded SET charter, we wanted the title of the role to reflect the work. But what should the new title be? We empowered the SETs to choose a new title, and they overwhelmingly (91%) selected Software Engineer, Tools & Infrastructure (abbreviated to SETI).

        Today, SETIs and TEs still collaborate very closely on optimizing the ENTIRE DEVELOPMENT LIFE CYCLE with a goal of eliminating all FRICTION from getting features into production. Interested in building next generation tools and infrastructure?  Join us (SETI, TE)!

  - [What's the Engineering Productivity group at Google? \- Quora](https://www.quora.com/Whats-the-Engineering-Productivity-group-at-Google) #ril

  - [Director of Engineering Productivity (NY, NY, East Coast USA or Argentina) - SRE Jobs board](https://srejobs.com/2019-11-28-director-of-engineering-productivity-ny-ny-east-coast-usa-or-argentina-ar-us.html)

    As the Director of Engineering Productivity you will focus on improving engineering productivity by improving our processes, tools, and technologies.

    You will grow an existing SRE team and create a Build team. You will lead your teams to deliver highly scalable and resilient cloud deployment and provisioning solutions. You will need to have experience in delivering and maintaining large-scale high-availability systems.

    看來 SRE 也是 Engineering Productivity 的一環。

  - [Site Reliability Engineer \- Jobs at Apple \(IE\)](https://jobs.apple.com/en-ie/details/200107585/site-reliability-engineer)

    The Engineering Productivity and Quality team is looking for Site Reliability Engineers to build and run the services that enable thousands of Apple engineers to develop the software products that delight millions of Apple customers.

    也是 EP 在找 SRE 的例子。

  - [Evolution of GTAC and Engineering Productivity - GTAC 2017 \- Home](https://events.withgoogle.com/gtac-2017/)

      - When Google first hosted GTAC in 2006, we didn’t know what to expect. We kicked off this conference with the intention to share our innovation in TEST AUTOMATION, learn from others in the industry and connect with academia. Over the last decade we’ve had great participation and had the privilege to host GTAC in North America, Europe and Asia -- largely thanks to the many of you who spoke, participated and connected!

      - In the recent months, we’ve been taking a hard look at the discipline of Engineering Productivity as a logical NEXT STEP in the evolution OF TEST AUTOMATION.

        In that same vein, we’re going to rethink what an Engineering Productivity focused conference should look like today. As we pivot, we will be extending these changes to GTAC and because we expect changes in theme, content and format, we are canceling the upcoming event scheduled in London this November. We’ll be bringing the event back in 2018 with a fresh outlook and strategy.

        原來 Engineering Productivity 是 Test Automation 的下一步!!?

      - While we know this may be disappointing for many of the folks who were looking forward to GTAC, we’re excited to come back with a new format which will serve this conference well in today’s environment.

  - [Google Testing Blog: Code Health: Google's Internal Code Quality Efforts](https://testing.googleblog.com/2017/04/code-health-googles-internal-code.html) (2017-04-03) #ril

      - There are many aspects of GOOD CODING PRACTICES that don't fall under the normal areas of testing and tooling that most Engineering Productivity groups focus on in the software industry.

        For example, having readable and maintainable code is about more than just writing good tests or having the right tools—it's about having code that can be easily understood and modified IN THE FIRST PLACE. But how do you make sure that engineers follow these practices while still allowing them the independence that they need to make sound engineering decisions?

        顯然 good coding practices 也是 EP 要關心的。

      - Many years ago, a group of Googlers came together to work on this problem, and they called themselves the "Code Health" group. Why "Code Health"? Well, many of the other terms used for this in the industry—engineering productivity, best practices, coding standards, code quality—have CONNOTATIONS that could lead somebody to think we were working on something other than what we wanted to focus on.

        What we cared about was the PROCESSES AND PRACTICES of software engineering IN FULL—any aspect of how software was written that could influence the readability, maintainability, stability, or simplicity of code. We liked the analogy of having "healthy" code as covering all of these areas.

      - This is a field that many authors, theorists, and conference speakers touch on, but not an area that usually has dedicated resources within engineering organizations. Instead, in most software companies, these efforts are pushed by a few dedicated engineers in their EXTRA TIME or led by the senior tech leads.

        However, every software engineer is actually involved in code health in some way. After all, we all write software, and most of us care deeply about doing it the "right way." So why not start a GROUP that helps engineers with that "right way" of doing things?

        有點悲傷，大家都覺得重要，但沒有投入資源在做這件事。

      - This isn't to say that we are PRESCRIPTIVE (規定) about engineering practices at Google. We still let engineers make the decisions that are most sensible for their projects.

        What the Code Health group does is work on efforts that universally improve the lives of engineers and their ability to write products with shorter iteration time, decreased development effort, greater stability, and improved performance.

        Everybody appreciates their code getting easier to understand, their libraries getting simpler, etc. because we all know those things let us MOVE FASTER and make better products.

        寫好 code 可以加速開發，也可以是 Engineering Productivity 關心的領域。

  - [Google Testing Blog: Android Platform Testing Made Easy](https://testing.googleblog.com/2019/01/android-platform-testing-made-easy.html) (2019-01-15)

    Android Engineering Productivity (Android EngProd) seeks to ease development of the Android operating system for the entire ecosystem. Android EngProd creates TOOLS, PROCESSES, and DOCUMENTATION aimed at Android platform development.

    We are now starting to push the best previously internal development infrastructure into the open for all to benefit.

  - [Google Testing Blog: How Google Tests Software \- Part One](https://testing.googleblog.com/2011/01/how-google-tests-software.html) (2011-01-25) #ril

      - The one question I get more than any other is "How does Google test?" It's been explained in bits and pieces on this blog but the explanation is due an update. The Google testing strategy has never changed but the tactical ways we execute it has evolved as the company has evolved.

        We're now a search, apps, ads, mobile, operating system, and so on and so forth company. Each of these FOCUS AREAS (as we call them) have to do things that make sense for their PROBLEM DOMAIN. As we add new FAs and grow the existing ones, our testing has to expand and improve. What I am documenting in this series of posts is a combination of what we are doing today and the direction we are trending toward in the foreseeable future.

      - Let's begin with organizational structure and it's one that might surprise you. There ISN'T an actual testing organization at Google. Test exists within a Focus Area called Engineering Productivity. Eng Prod owns any number of horizontal and vertical ENGINEERING DISCIPLINES, TEST IS THE BIGGEST. In a nutshell, Eng Prod is made of:

          - A PRODUCT TEAM that produces internal and open source PRODUCTIVITY TOOLS that are consumed by all walks of engineers across the company. We build and maintain code analyzers, IDEs, TEST CASE MANAGEMENT SYSTEMS, automated testing tools, build systems, source control systems, code review schedulers, bug databases... The idea is to make the tools that MAKE ENGINEERS MORE PRODUCTIVE. Tools are a very large part of the strategic goal of PREVENTION OVER DETECTION.

          - A SERVICES TEAM that provides expertise to Google product teams on a wide array of topics including tools, DOCUMENTATION, testing, release management, TRAINING and so forth. Our expertise covers reliability, SECURITY, INTERNATIONALIZATION, etc., as well as product-specific functional issues that Google product teams might face. Every other FA has access to Eng Prod expertise.

          - EMBEDDED ENGINEERS that are effectively LOANED OUT to Google product teams on an AS-NEEDED BASIS. Some of these engineers might sit with the same product teams FOR YEARS, others cycle through teams wherever they are needed most. Google encourages all its engineers to change product teams often to STAY FRESH, engaged and objective. Testers are no different but the cadence of changing teams is left to the individual. I have testers on Chrome that have been there for several years and others who join for 18 months and cycle off. Keeping a healthy balance between product knowledge and fresh eyes is something a test manager has to pay close attention to.

      - So this means that testers REPORT TO Eng Prod managers but identify themselves with a product team, like Search, Gmail or Chrome. Organizationally they are PART OF BOTH TEAMS.

        They sit with the product teams, participate in their planning, go to lunch with them, share in ship bonuses and get treated like full members of the team. The benefit of the SEPARATE REPORTING STRUCTURE is that it provides a forum for testers to share information.

        Good testing ideas migrate easily within Eng Prod giving all testers, no matter their product ties, access to the best technology within the company.

  - [Google Testing Blog: How Google Tests Software \- Part Two](https://testing.googleblog.com/2011/02/how-google-tests-software-part-two.html) (2011-02-09) #ril

  - [How EngProd fixes product-wide problems - Google Testing Blog: Discomfort as a Tool for Change](https://testing.googleblog.com/2017/02/discomfort-as-tool-for-change.html) (2017-02-13) #ril

  - [Google Engineering Productivity: SWE and Test Engineer \(TE\)](https://landing.google.com/engprod/)

      - Engineering Productivity : Delivering FRICTIONLESS engineering and excellent products

        What is Engineering Productivity?

        We are a DATA-DRIVEN engineering discipline focused on optimizing the ENGINEERING PROCESS so that Google can deliver amazing experiences to our users, faster.

      - Core Principles - Our approach to building at scale

          - System analysis - With a system-level view and a user-centric view, we work hard to identify GAPS and INEFFICIENCIES in our engineering process so that we can build solutions to improve engineering excellence and velocity.

          - Instrumentation - We believe that you CAN’T IMPROVE WHAT YOU CAN’T MEASURE. Google is a data-driven company and we are a data-driven discipline. We obsess over metrics and work hard to move them in the right direction.

          - Tools and infrastructure - We build critical tools and infrastructure to help Google engineers work more effectively and efficiently. This enables Google to ship excellent products, faster.

          - Focus on the user - We EMBED in PRODUCT ENGINEERING teams where we champion polished products for Google’s users and fast, scalable engineering for our users, GOOGLE’S ENGINEERS.

            服務內部工程師。

      - Interested in joining Engineering Productivity?

        We’re looking for world-class engineers that bring a QUANTITATIVE MINDSET, execution velocity, LEADERSHIP skills, and a PASSION TO CHANGE THE WAY ENGINEERING IS DONE at Google and beyond.

        Google strives to cultivate an [INCLUSIVE](https://www.collinsdictionary.com/dictionary/english/inclusive) WORKPLACE (多樣且共榮). We believe diversity of perspectives and ideas leads to better discussions, decisions, and outcomes for everyone.

  - [Careers - Google Engineering Productivity: SWE and Test Engineer \(TE\)](https://landing.google.com/engprod/careers/)

      - Change the way software is developed, not just at Google, but for all developers

      - Roles in Engineering Productivity - Engineering Productivity (EngProd) is a vibrant community of teams and roles at Google.

    Software Engineer (SWE)

      - Software Engineers solve a broad range of computer science problems at Google. In EngProd, they build INFRASTRUCTURE, HARNESSES, and TOOLING to help improve engineering velocity and product excellence.

      - You might love this role if:

          - You love developing tools that make the engineering process better — be it command line tools, web services, debugging tools, test data factories, etc.
          - You’re passionate about high-quality software, but not so happy about shortcuts and hacks in the code.
          - You’ve worked to automate and remove repetitive and manual tasks because inefficiency is one of your least favorite things.
          - You believe that unless you can QUANTIFY or measure something, you probably can’t improve it.

        旁邊的影片帶出了 EngProd 下的 SWE，也就是 SETI。

    Test Engineer (TE)

      - TE at Google is a technical role in Engineering that focuses on advancing product excellence and engineering productivity.

      - You might love this role if:

          - You have an unwavering passion for, and focus on, polished products, engineering excellence, and productivity.
          - You enjoy thinking through complex product and system interactions to find gaps, failure modes, and edge cases.
          - You've worked to automate and remove repetitive and manual tasks because inefficiency is one of your least favorite things.
          - You love to design, implement, and improve tools, frameworks, metrics, and processes.
          - You love to work, collaborate, and lead cross-functionally.

        完全沒提到 test，跟上面的 SWE 差別不大? 不過旁邊的影片帶出 SET (Software Engineer in Test) 的工作，雖然影片裡都稱 Test Engineer。

  - [Meet Software Engineers Who Build Google's Tools and Infrastructure \- YouTube](https://www.youtube.com/watch?v=-yxoYb9qbiI) (2018-03-01) #ril

  - [Meet Software Engineers Who Build Google's Tools and Infrastructure \- YouTube](https://www.youtube.com/watch?v=-yxoYb9qbiI) #ril

  - [Software testing Blog – Awesome Testing: TestOps \#5 \- Engineering Productivity](https://www.awesome-testing.com/2017/07/testops-5-engineering-productivity.html) (2017-07-30) SRE 是 EP 下的角色之一 #ril

    Introduction

      - Google has recently surprised everyone by renaming their famous GTAC into Engineering Productivity conference. It means that already complicated and confusing testing dictionary received one more entry (ISTQB dictionary for instance, fails to explain the meaning of this term).

        The meaning of Engineering Productivity is very broad and it's not easy define it in one blog post. With help of various resources I'll try.

    What is Engineering Productivity?

      - As described in How Google Tests Software Engineering Productivity in testing context was first introduced by Patrick Copeland:

        > So I decided to make it official and I changed the name of the team to Engineering Productivity. With the name change also came a CULTURAL ADJUSTMENT. People began talking about productivity instead of testing and quality. Productivity is our job; testing and quality are the job of everyone involved in development. This means that developers own testing and developers own quality. The productivity team is responsible for ENABLING development to nail those two things.

      - As noted by Patrick (later confirmed by Ashley Hunsberger on Souce Lab Blog) QA people may not be enough to guarantee demanded quality. Engineering Productivity team is kind of EXTENSION which allow companies to focus on quality FROM START of Software Engineering process (often called 'left') to the product release and live maintenance/monitoring ('right' - Testing in Production).

        從左到右，Engineering Productivity 含括了開發到上線後的事情。

        I'm sure that most of my readers employed as QA/testers observe that their responsibilities often go beyond simple testing role. At least that's what I encouraged you to do in my posts, for example Testing Learning Checklist. It's worth to remain once again that TRADITIONAL (mostly manual) QA is getting OBSOLETE. It was confirmed by Yahoo decision to disband their team.

    Engineering Productivity goals & responsibilities

      - In summary Engineering Productivity team wants to make sure that:

          - a) software is released as fast as possible
          - b) software has the highest quality possible
          - c) software works correctly on production

        In the past QA team was focused mostly on point b leaving a to developers and c to OPERATION TEAM.

      - New goals have impact on tasks performed by EP (Engineering Productivity) team. Testers responsibilities change in the following way:

        a) More focus on test frameworks, internal CONSULTING and COACHING

          - Demanding business realities usually mean that developers have to write tests. To be fully effective They need GUIDANCE & tools provided by experienced testing specialists.
          - EP team should also provide CORRECT GUIDELINES. For example 100% unit tests coverage probably won't detect performance problems. Limited testing effort should be used in correct place.

        b) SHIFT LEFT in software engineering process

          - Obviously testing at the beginning is the cheapest. Spending time on things like IDE plugins, unit tests, code coverage tools, effective code review, OWASP secure coding practices usually have high ROI (Return of Investment).
          - EP team should also make sure that NO FAILURES are allowed to move downstream on Continuous Integration process.

        c) SHIFT RIGHT in software engineering process

          - Successful release doesn't end EP team duties. They need to constantly MONITOR how their application perform on production. See my Testing in Production post for detailed techniques how it's done.
          - I have also covered SHIFT LEFT & RIGHT in software engineering process in my [Continuous Testing](https://www.awesome-testing.com/2016/10/testops-3-continuous-testing.html) post. #ril

        d) Need for speed

          - EP team should make sure that testing doesn't become a bottleneck and it doesn't slow down developers. For example if Selenium E2E run too long at some point they will stop giving any feedback at all, because people won't run them.

            See my [Continuous Improvement](http://www.awesome-testing.com/2017/01/testops-4-continuous-improvement.html) post for details. #ril

    Roles in Engineering Productivity team

      - Looks like there are no correct EP team structure and it's implementation varies in various companies, but we can distinguish:

        a) Test Engineers (TE)

          - Testers with broad product & business domain knowledge who focus on what should be tested. They drive test strategy and help to identify product risks. Usually aligned in Scrum Team.

        b) Software Engineers in Tests (SETs)

          - Software Engineers (developers) interested in testing domain who build frameworks and tools aiming to speed up software engineering process.

        c) Software Engineers, Tools & Infrastructure (SETI)

          - Google name for SETs. 正確地說，SETI 早期確實叫 SET，但 SETI 的工作也變廣了。

        d) Release Engineers, CI Engineers, DevOps Engineers, TestOps Engineers

          - Highly technical role which focuses on Continuous Integration, Continuous Delivery and whole RELEASE PROCESS AUTOMATION.

        e) Site Reliability Engineers, Software Reliability Engineers (SRE)

          - Another highly technical role which focus on production platform maintenance, performance, monitoring and scalability. Google described this role in detail in their [opensourced book](https://landing.google.com/sre/book/index.html). #ril

        f) Product Owner, Product Manager

          - According to already mentioned Ashley Hunsberger if we invest in such a big team it should be led by someone who not only plan work, but also STAYS IN CONTACT WITH BUSINESS.

          - Generally speaking he should make sure that EP team goals are ALIGNED WITH BUSINESS GOALS. I highly recommend Ashley's talk from Selenium Conf 2017 called [Transformative Culture](https://www.youtube.com/watch?v=GYXm8gpE5_c&index=2&list=PLRdSclUtJDYXFVU37NEqh4KkT78BLqjcG) about this role in EP team. #ril

  - [Transformative Culture \- Ashley Hunsberger – Test Automation Architect, Blackboard \- YouTube](https://www.youtube.com/watch?v=GYXm8gpE5_c&index=2&list=PLRdSclUtJDYXFVU37NEqh4KkT78BLqjcG) 講到她在 EP team 的第一個專案 #ril

  - [QA is Not Enough: You Need to Engineer Productivity \| Sauce Labs](https://saucelabs.com/blog/qa-is-not-enough-you-need-to-engineer-productivity) (2017-03-07) #ril

  - [97 Things Every Engineering Manager Should Know: Collective Wisdom from the \.\.\. \- Camille Fournier \- Google Books](https://books.google.com.tw/books?id=oNa_DwAAQBAJ&pg=PT247) -- Chapter 23. Engineering Productivity

  - [Engineering Productivity: How Two Sigma Keeps Developers Engaged \| Coding Sans](https://codingsans.com/blog/engineering-productivity) (2020-01-20)

  - [Issues · GitLab\.org / quality / team\-tasks · GitLab](https://gitlab.com/gitlab-org/quality/team-tasks/issues?label_name=Engineering+Productivity) Engineering Productivity 是 GitLab issue 的一個 label? #ril

  - [SE\-Radio Episode 317: Travis Kimmel on Measuring Software Engineering Productivity : Software Engineering Radio](https://www.se-radio.net/2018/02/se-radio-episode-317-travis-kimmel-on-measuring-software-engineering-productivity/) (2018-02-06) #ril

  - [Productivity Engineering \- Productivity Engineering SV \- Medium](https://medium.com/@ProdEngSV/productivity-engineering-4aff8b560d0b) (2017-10-25) #ril

      - The response from the companies at the forefront of the DevOps movement is the emerging practice of Productivity Engineering.

        > Productivity Engineering aims to reduce COGNITIVE LOAD ?? so that engineers can devote the majority of their attention to delivering BUSINESS VALUE.

  - [Why Developers Should Embrace Productivity Engineering](https://otter.ly/productivity-engineering/) (2018-11-02) #ril

  - [Engineering Productivity Manager, Google Nest \- Google \- Bengaluru, Karnataka, India \- Google Careers](https://careers.google.com/jobs/results/112763425769038534)

      - A line of code can be many things - an amazing feature, a beautiful UI, a transformative algorithm. The faster this line of code reaches millions of users, the sooner it impacts their lives. As a Software Engineer, Tools and Infrastructure, you will be at the HEART of Google’s ENGINEERING PROCESS building software that empowers ENGINEERING TEAMS to develop and deliver high quality products quickly. We are focused on solving the hardest, most interesting challenges of developing software at scale without sacrificing stability, quality, velocity or CODE HEALTH.

      - We ensure Google's success by PARTNERING with engineering teams and developing scalable tools and infrastructure that help engineers develop, test, debug and release software quickly. We impact thousands of Googlers and billions of users by increasing the pace of product development and ensuring our products are thoroughly tested. We are advocates for code health, testability, maintainability and best practices for development and testing.

    Responsibilities

      - Lead a team of software and test engineers and collaborating closely with all APAC and North America sites where Google Nest products are developed
      - Provide HANDS ON technical leadership for all team projects
      - Define team strategy and roadmap and DRIVE ADOPTION of infrastructure across teams
      - Develop the careers and professional growth of engineers on the team through project and task assignment, individual coaching, and identifying relevant training opportunities.

  - [Director of Engineering Productivity, Storage/Databases \- Google \- Sunnyvale, CA, USA \- New York, NY, USA \- Google Careers](https://careers.google.com/jobs/results/116103765087396550)

      - As the Director of Engineering Productivity, you will drive the Engineering Productivity strategy for Google Cloud Storage and Databases and head a team that focuses on the BUILD, TEST, RELEASE, and MONITORING of the infrastructure for Google’s products. This is one of the largest areas of Google Cloud. You will work closely with VPs, Senior Directors and leaders across the Engineering Productivity function at Google.

        The team's scope ranges from developer infrastructure challenges of storage systems to low-level hardware and performance validation. Within this domain, you will manage the developer and release tools, efficiency, and test coverage story.

    Responsibilities

      - Manage a diverse team to navigate deep technical problem spaces.
      - Lead the Infrastructure and Tooling strategy while BALANCING a wide variety of projects and engagements.
      - Build, grow and RETAIN top talent and continually find ways to inspire and challenge the engineering organization.
      - Build CROSS-FUNCTIONAL PARTNERSHIPS, and work closely with developers and product managers to identify productivity, production quality and coverage issues, and provide INSIGHT on improving both through scale and tooling.

  - [Engineering Productivity Manager, Ads \- Google \- Bengaluru, Karnataka, India \- Google Careers](https://careers.google.com/jobs/results/72884162022777542)

      - Build an understanding of the Next Billion Users space, business growth opportunities, as well as the product area and infrastructure.
      - Deliver meaningful contributions towards product and feature testing and automation, and guide the team towards successful production launches.
      - Provide initiative and leadership on Code Health and ENGINEERING EXCELLENCE ??.
      - Build and lead a robust Engineering Productivity Team FROM THE GROUND UP, and collaborate effectively with senior engineering partners across functions and time-zones.

  - [Senior Software Engineer, Engineering Productivity \- Google \- Stockholm, Sweden \- Google Careers](https://careers.google.com/jobs/results/131053504404824774)

      - Lead/contribute to engineering efforts from DESIGN to implementation, solving complex technical challenges around developer and engineering productivity and velocity.
      - Design and build advanced automated build, test, and release infrastructure.
      - Drive adoption of best practices in code health, testing, and maintainability.
      - Analyse and decompose complex software systems and collaborate with cross-functional teams to INFLUENCE DESIGN FOR TESTABILITY.

  - [Manager \- Developer Productivity Engineering at DISNEY](https://jobs.disneycareers.com/job/new-york/manager-developer-productivity-engineering/391/14528182)

    Job Summary:

      - Developer Productivity Engineering is a DISTRIBUTED group that owns INTERNAL TOOLS used to build, deploy, and operate the services that make up Disney Streaming’s products. Built for AWS with a variety of open source software, our services are USED BY DOZENS OF ENGINEERING TEAMS across the company. We strive to act as a PRODUCTIVITY MULTIPLIER by offering our customers rich primitives for delivering their services, allowing them to focus more on product.

      - As a manager in Developer Productivity Engineering, you will help CULTIVATE AN ENVIRONMENT where people can do their best work through strategic thinking, coaching, and career advocacy. You will own the delivery and quality of your team’s COMMITMENTS to its customers and collaborate across the organization to ensure appropriate PRIORITIZATION.

        You should have a passion for SERVANT LEADERSHIP, team building, and EMPATHY-DRIVEN ?? development.

      - Requirements:

          - You care deeply about COACHING, MENTORING, and growing the careers of your team
          - 5 to 7 years or technical experience, including 2+ years in an engineering leadership role
          - You have a technical track record that speaks to your team’s problem space, and allows you to offer them guidance ??
          - You’re a SELF-LEARNER, independent, and have excellent PROBLEM-SOLVING skills
          - You have exemplary written and verbal communication skills

      - Nice to Have but not required:

          - Experience with software containers (e.g. Docker, rkt, runC) and schedulers (e.g. ECS, Kubernetes, Nomad)
          - You have led a distributed engineering team
          - You have deployed and operated geographically distributed, redundant services
          - Engagement with OPEN SOURCE COMMUNITY

      - Technologies we love:

          - Languages: Go, Ruby, Bash
          - Tools: Ansible, Docker, Git, Graphite, GraphQL, Jenkins, Logstash, Packer, Sensu
          - Data stores: DynamoDB, Elasticsearch, PostgreSQL, Redis

    Responsibilities:

      - Support the team in continuously improving the ORGANIZATION’S TOOLS and BEST PRACTICES for owning and operating software
      - Hire and nurture distributed engineers through mentorship and career advocacy
      - Enable DATA-DRIVEN PRIORITIZATION and decision-making for your team through cross-organizational communication
      - Encourage individual decision-making amongst your team to support growth opportunities for your directs
      - Foster an OPEN ENVIRONMENT of MUTUAL SUPPORT and ENGINEERING EFFECTIVENESS

  - [科技的阻力 -- 科學人雜誌](https://sa.ylib.com/MagArticle.aspx?Unit=columns&id=1971) -- 阻力指的是麻煩事，像是步驟或過程。

## SWE (Software Engineer)

## SETI (Software Engineer, Tools and Infrastructure) {: #seti }

  - SETI 中的 E 為何不是 Engineering? 因為 SETI 是個職缺 (Software Engineer) 而非部門名稱，與 SWE 不同的是更專注在 "Tools and Infrastructure"。

---

參考資料：

  - ["Software Engineer, Tools And Infrastructure" role at Google : cscareerquestions](https://www.reddit.com/r/cscareerquestions/comments/3nrtf1)

      - CrazedLumberjack: I've been a SETI at Google for just under 2 years now. Let me try to answer your questions.

          - What do we do? In the two years I've been at Google I've worked on a large TESTING FRAMEWORK. The stuff I focused on involved some devops work as well as some fun engineering work in rewriting core scheduling algorithms to get better resource efficiency and performance.

            Now I'm working on setting up testing infrastructure for a new team - they're the ones writing the tests but I'm setting up the plumbing and infrastructure so it's easy for them to use.

            There are also teams that work on making the RELEASE PROCESS EASIER by writing automated tools and validation.

          - Compensation - we're on the same pay scale as SWEs for salary, bonuses and stock. I've had this confirmed by multiple managers who have both SETIs and SWEs reporting to them.

          - SETIs aren't looked down upon at Google in my experience. Teams understand that having SETI support can make their lives much easier and better.

          - I don't know first-hand how easy it is to transfer from SETI -> SWE. Because there are similar expectations in terms of technical knowledge between the two roles I do think it's fairly doable. Typically when I've seen it happens the person starts to do SWE-type work for a team for a quarter or two and then hopefully is able to convert to a SWE on that team.

            這問法有點怪，SWE -> SETI 的轉變應該是更困難的，因為對 Software Engineering 要更有想法。

          - Other companies don't look down on the role, especially now that TESTING ISN'T MENTIONED IN THE NAME. I have my job title on LinkedIn listed as "Software Engineer, Tools and Infrastructure" and people there seem to assume that it means that I'm a backend dev and plenty contact me with opportunities.

            職稱中有 "測試" 會被看低? 可能會跟 TE (Test Engineer) 混淆。

      - knabo5: Thanks for the thorough response - this is really helpful information! I have a few followup questions if you don't mind:

          - When you started as a SETI, did you have a mentor and what was their role? My recruiter told me that SETIs sit with SWE teams, so is the mentor another SETI (I expect this would mean the mentor is not around much) or a SWE?

            既然 SETI 的工作是幫助 SWE，跟 SWE 一起工作也是很自然的事。

          - It seems to me that once the infrastructure is set up for a team and they've been using it for a while, there's little use for SETI to continue being around. Am I right? Do you frequently jump around to different teams?

            可以預見，這個 team 導入之後，又要換下個 team；持續影響所有開發團隊。

          - Who decides what team you join next? Is this team in the same product area or could it be completely different?

      - CrazedLumberjack:

          - Within my organization (ads), we try to avoid having any singleton SETIs so there will generally be AT LEAST TWO SETIs working on any given project.

            This means that your SETI mentor would hopefully be someone who's working with you on your project and sitting next to you. This is what happened when I started and it's what has happened for all Nooglers that have joined my team since. I think it works really well at getting new people up to speed.

          - In my experience people seem to change which SWE teams they support every year or two. However you should bear in mind that the code that SWE teams work on is constantly evolving so there is almost always SETI work that can be done to support new components and infrastructure being used by SWE teams.

          - Answering the second part first: It's within the same PA typically. All of my team supports SWE teams within the ads PA at Google. If I wanted to work for another PA it would be a lot more effort as it'd involve me changing managers (and most likely relocating since I'm not in Mountain View).

            I recently (~4 months ago) switched projects. It started by me talking to my boss and telling him that I didn't feel like there was enough CHALLENGING work on my old project and asked him to let me know if there were any other SWE teams that WANTED OUR HELP.

            In our case there had been one team that had been asking for SETI ENGAGEMENT for a while but we just didn't have the manpower for it. I ended up talking to them about their product and what they thought they wanted from SETIs and I decided that it'd be a good fit for me. If I had decided that I didn't want to work with them for good reasons (didn't think they would be supportive, they didn't have much need for it) then I could've gone back to my boss and continued looking for other SWE teams to engage with.

  - [Software Engineer, Tools and Infrastructure \(SETI\) \| Featurespace](https://www.featurespace.com/careers-2/software-engineer-tools-infrastructure-seti/) #ril
  - [科普一下 SWE 和 SETI 和 TE @ Google \- 求职 / CS资讯 \- 1024 BBS](https://1o24bbs.com/t/topic/3298) #ril


