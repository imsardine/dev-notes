# Test-Driven Learning (TDL)

  - [Test\-Driven Learning](http://www.simexusa.com/tdl/) #ril

      - TDL is an approach to TEACHING COMPUTER PROGRAMMING that integrates automated unit tests throughout the computer science and software engineering curriculum.

        TDL has been applied in undergraduate, graduate, and professional training courses. Educators teaching courses involving computer programming at all levels are encouraged to consider adopting TDL. Replicated empirical studies of TDL are encouraged.

        Questions may be directed to David Janzen. A few resources are listed below.

  - [Test Driven Learning \- Learning Coldbox through Testing](https://www.slideshare.net/gavinpickin9/cbdw2013-tdl) (2015-05-16)

    What is TDL - Koans

      - Test Driven Learning is commonly known as Koans.

      - Where did Koans Begin?

        Form what I can tell, it started with Ruby Koans (originally by EdgeCase now rebraned as Neo)

      - There are Koans for many languages including Ruby Python JavaScript etc - search GitHub and see them all.

        https://github.com/search?o=desc&q=koan&s=stars&type=Repositories

  - [Test\-Driven Learning: A Better Way to Learn Any Programming Language \- Simple Programmer](https://simpleprogrammer.com/test-driven-learning/) (2019-01-30) #ril

      - Learning from your mistakes isn’t a new concept. Scottish author Samuel Smiles wrote in 1862 “We learn wisdom from failure much more than from success.”

        The view has been popularized recently in software development by teams applying the DevOps and Agile methodologies of producing small improvements iteratively. If a feature doesn’t work as expected, it can be scrapped; it is a concept known as “fail fast.”

      - “Fail fast, learn fast” is the main premise of Jez Humble’s book Continuous Delivery: Reliable Software Releases through Build, Test, and Deployment Automation. In the context of this book, Jez is referring to building reliable production software by releasing as often as possible. Any failures should be small and cause little impact, with the ability to rollback to the last working version and learn what exactly went wrong.

      - We can apply the same concept to learning. Fail as often as you can, and learn as much as you can from those failures.

    Applying Test-Driven Development to Learning

      - Test-driven development (TDD) wasn’t my idea; it originated from a range of techniques called extreme programming in the 1990s to help improve software quality in development teams. The core idea of test-driven development is:

          - Create the smallest failing test possible for code you are planning to write.
          - Run the test and fail.
          - Write the code until the test passes.
          - Refactor the code bit by bit, and keep running the tests until the code is maintainable and readable.

      - The main benefits we are using from TDD is the refactor step. Once the tests have been created with well-defined inputs and outputs, the SOLUTION CAN TAKE MANY FORMS.

        This refactoring step is really useful when learning to understand how built-in language features work and how different ways of approaching the same solution lead to the same output.

        Another benefit is motivation; it’s addictive watching the tests go from red (failing) to green (pass!). It’s like a kind of game.

      - The idea of learning through TDD isn’t new either. While learning JavaScript I was introduced to this approach via freeCodeCamp, where from the first lesson you are required to pass failing tests to complete a level. I also recently started learning Ruby and was introduced to Koans via the [Edgecase Ruby Koans](http://www.rubykoans.com/) site.

        The idea behind freeCodeCamp and Ruby Koans is to present a long list of failing tests for you to fix. This approach of fixing tests one by one is ideal if you are just starting out. You don’t need to write tests yourself, which sometimes sucks the fun out of learning.

        自己寫測試來驗證自己的問題，也是很好的練習!!

    Learning Through Testing Promotes a Deeper Understanding

      - Early in my career I SURVIVED BY SEARCHING THROUGH STACK OVERFLOW, looking at the code already written in the codebase and randomly trying code snippets to see if they would work.

        That was fun but with some major drawbacks: Some of the code I was writing had unintended side effects. Fixing it involved more searching and more hacks upon hacks. My shortcuts actually caused me more work, and everything took longer and made me hate seeing a tester walk toward my desk with yet another bug.

        It wasn’t only my project that suffered. When applying for new jobs, I was able to answer superficial questions that I found on the internet, but when the interviewer probed further, I didn’t have DEEP ENOUGH KNOWLEDGE to answer any further questions. These problems could have been avoided had I been practicing test-driven learning.

      - The main benefit of approaching learning by testing is a deeper understanding of the code you are writing, how to interact with library functions, and what output can be expected in different scenarios.

        The refactoring is the fun, experimenting part of the process; the same problem can be solved in a multitude of different ways. Experimentation allows your brain to play with an idea and provides a greater understanding of the limits and cool features of the language and where to use them.

      - I have been practicing TDD for quite a few years, but when I recently needed to learn Ruby, I thought I would try out learning through testing.

        My process was:

          - Read the BARE MINIMUM about a concept.
          - Write a test for that concept.
          - Test the LIMITS OF THE CONCEPT ?? by refactoring multiple times with different solutions.

      - Each solution offers advantages and trade-offs. Writing down each solution adds a new tool to your toolbelt, so when you do come up against a situation where you need an algorithm, you have a collection of solutions that you now have a deep understanding of because you have already struggled with the concepts.

    Learning Through Testing Helps You After You’ve Learned the Basics

      - I’ve found that once you have the basics, there are other benefits of learning this way. I am much more likely to use test-driven development when writing production code; if I get in the habit while learning, I just continue on when applying it in practice. I also have a sandbox for working out difficult problems. If I have an issue with some code buried deep in a code base, isolating the problem usually speeds up the diagnosis, and if not, it’s much easier to paste that isolated code into Stack Overflow!

  - [Test Driven Learning \| SAP Blogs](https://blogs.sap.com/2020/02/24/test-driven-learning/) (2020-02-24)

      - I love test driven development (TDD) and lately I’ve had a need to re-learn groovy scripting for CI pipeline customization. I’ve also needed to learn node.js (and npm) as well as Python. Can I not apply test driven development to learn new languages and tools? Yes! Here’s how I did it.

      - Firstly, you need to learn the unit testing tool(s) available for the language/platform you’re going to learn. If you like books, this means skipping to the last chapter or worse, the appendix, to learn how to write unit tests for the language. Note to book authors: PUT THE UNIT TESTING CHAPTER NEARER THE START OF THE BOOK.

        確實，為什麼 testing 總是被忽略?

      - Once you have your IDE/editor project set up, you can begin WRITING TESTS TO LEARN (VIA VERIFICATION) the language. Putting your tests in a side project is much better than putting them into the production project where you shouldn’t be unit testing the language, platform, or libraries. Production project unit tests should only be testing your code.

      - You don’t have to exhaustively test all language aspects. Just write a test FOR THE PART YOU NEED TO LEARN RIGHT NOW. That’s how I started my [groovy-learning](https://github.com/tdrury/groovy-learning) project.

        We use Groovy to extend our build pipeline, and each time I began to struggle how to do something in groovy, I’d create a new test. Groovy regular expression functionality is a little strange. JSON and YAML handling are a little more intuitive with Groovy’s builder functionality. Loading Groovy classes via a file to be used in a Groovy script was fun to write. This was needed for some non-pipeline tasks I needed.

      - In addition to re-learning Groovy, I got to use Spock – Groovy’s excellent test framework. I also wanted to learn Gradle. So I set the project up with it instead of Maven which is my standard build tool. I’m still on the fence regarding Gradle for reasons too long for this blog post.

        I haven’t progressed very far with my [node.js/npm](https://github.com/tdrury/node_learning) learning or [Python learning](https://github.com/tdrury/python-learning) projects. Again, I only write a test when I need to learn a topic and I haven’t needed to get past the basics yet.

        作者習慣用不同語言的 testing framework 來學；例如 Node.js 用 [QUnit](https://qunitjs.com/)、Python 用 [pytest](pytest.md)。

      - My latest efforts have been focused on [Spring learning](https://github.com/tdrury/spring-learning). In this case, in addition to learning the various Spring modules, I’m also focusing on deciding things like:

          - the best way to name a test method so its purpose is clear

          - are MockMvc and TestRestTemplate tests unit tests or integration tests?

            hint: they’re integration tests by strict definition, but does it really matter if you aren’t duplicating tests?

            FYI: I duplicate tests a lot in this project because… learning.

          - how to set up Maven to segregate integration tests from unit tests?
          - how can I use [testcontainers](https://www.testcontainers.org/) (which is not Spring) to assist with automated testing? #ril

      - To summarize, I’ve adopted test driven learning to force myself to write tests thereby cementing the concepts in my head. Something which READING a book or web page doesn’t do. I save the tests in git so I can refer to them later if I forgot something.

        Will “TDL” become a thing?

  - [Test\-Driven Learning](http://bobbynorton.com/posts/test-driven-learning/) (2009-06-01) #ril
  - [TDD and Test\-Driven Learning with Functional Programming](http://bobbynorton.com/posts/tdd-fp/) (2010-04-17) #ril

  - [VueJS unit tests as a learning tool: v\-show \- Vuefinder \- Medium](https://medium.com/vuefinder/vuejs-unit-tests-as-a-learning-tool-v-show-f29d3986bced) (2017-07-28) #ril
  - [Testing The Waters \- Rabbi On Rails](https://blog.yechiel.me/testing-the-waters-79cf15e3bbe9) (2017-06-05) #ril
  - [Test Driven Development: An Emerging Solution for Software Development\. \- ppt download](https://slideplayer.com/slide/4995050/) (2016) #ril
  - [Test Driven Learning: setting learning goals for yourself, Software Engineering edition \| Mel Chua](http://melchua.com/blog/2014/02/11/test-driven-learning-setting-learning-goals-for-yourself-software-engineering-edition/) (2014-02-11) #ril

  - [TDL, a \(programming language\) learning framework \| thePHP Website](https://thephp.website/en/issue/tdl-test-driven-learning-framework/) (2020-02-01) #ril

  - [Learn/Teach LINQ using TDD/TDL \- SoftDevPractice](https://softdevpractice.com/blog/learn-teach-linq-using-tdd-tdl/) (2018-05-20) #ril

  - [Is it wise to advise learners of programming to use TDL test\-driven learning, and also to learn new commands and build new apps by testing and eventually get into the habit of test\-driven and data\-driven development? \- Quora](https://www.quora.com/Is-it-wise-to-advise-learners-of-programming-to-use-TDL-test-driven-learning-and-also-to-learn-new-commands-and-build-new-apps-by-testing-and-eventually-get-into-the-habit-of-test-driven-and-data-driven-development) #ril

## Zen Koan {: #koan }

  - [Kōan \- Wikipedia](https://en.wikipedia.org/wiki/Kōan) #ril

      - A kōan (公案) (/ˈkoʊæn/ 公案) is a story, dialogue, question, or statement which is used in Zen practice to provoke the "great doubt" and to practice or test a student's progress in Zen.

  - [Learn Ruby with the Edgecase Ruby Koans](http://rubykoans.com/)

    The Koans walk you along the path to enlightenment in order to learn Ruby. The goal is to learn the Ruby language, syntax, structure, and some common functions and libraries. We also teach you culture. Testing is not just something we pay lip service to, but something we live. It is essential in your quest to learn and do great things in the language.

    Red, Green, Refactor

      - In test-driven development (TDD) the mantra has always been red: write a failing test and run it, green: make the test pass, and refactor: look at the code and see if you can make it any better.

        With the koans, you will need to run the tests and see it fail (red), make the test pass (green), then take a moment and reflect upon the test to see what it is teaching you and improve the code to better communicate its intent (refactor).

  - [三界無法，何處求心](https://e-info.org.tw/reviewer/chia/2004/ch04031401.htm) #ril
