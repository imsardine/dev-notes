# React

  - [React – A JavaScript library for building user interfaces](https://reactjs.org/)

      - Declarative

        React makes it painless to create interactive UIs. Design simple VIEWS FOR EACH STATE in your application, and React will efficiently update and render just the right components WHEN YOUR DATA CHANGES.

        類 Reactive Programming 的概念??

        declarative views make your code more predictable and easier to debug.

      - Component-Based

        Build ENCAPSULATED components that manage THEIR OWN STATE, then compose them to make complex UIs.

        Since component logic is written in JavaScript instead of templates, you can easily pass rich data through your app and KEEP STATE OUT OF THE DOM. ??

      - Learn Once, Write Anywhere

        We don’t make assumptions about the rest of your technology stack, so you can develop new features in React without rewriting existing code.

        React can also RENDER ON THE SERVER using Node and power mobile apps using [React Native](https://reactnative.dev/). #ril

        原來 React Native 的概念同 React，只是平台不同而已。

    A Simple Component

      - React components implement a `render()` method that TAKES INPUT DATA and RETURNS WHAT TO DISPLAY. This example uses an XML-like syntax called JSX. Input data that is passed into the component can be accessed by `render()` via `this.props`.

      - JSX is optional and not required to use React. Try the Babel REPL to see the raw JavaScript code produced by the JSX COMPILATION step.

        下面示範把 `HelloMessage` 這個 component 畫在 `hello-example` 裡，有用 JSX 與單純用 JavaScrip 的寫法：

        w/ JSX:

            class HelloMessage extends React.Component {
              render() {
                return (
                  <div>
                    Hello {this.props.name}
                  </div>
                );
              }
            }

            ReactDOM.render(
              <HelloMessage name="Taylor" />,
              document.getElementById('hello-example')
            );

        w/o JSX:

            class HelloMessage extends React.Component {
              render() {
                return React.createElement(
                  "div",
                  null,
                  "Hello ",
                  this.props.name
                );
              }
            }

            ReactDOM.render(React.createElement(HelloMessage, { name: "Taylor" }), document.getElementById('hello-example'));

    A Stateful Component

      - In addition to taking input data (accessed via `this.props`), a component can maintain internal state data (accessed via `this.state`). When a component’s state data changes, the rendered markup will be updated by re-invoking `render()`.

            class Timer extends React.Component {
              constructor(props) {
                super(props);
                this.state = { seconds: 0 };
              }

              tick() {
                this.setState(state => ({
                  seconds: state.seconds + 1
                }));
              }

              componentDidMount() {
                this.interval = setInterval(() => this.tick(), 1000);
              }

              componentWillUnmount() {
                clearInterval(this.interval);
              }

              render() {
                return (
                  <div>
                    Seconds: {this.state.seconds}
                  </div>
                );
              }
            }

            ReactDOM.render(
              <Timer />,
              document.getElementById('timer-example')
            );

    An Application

      - Using `props` and `state`, we can put together a small Todo application. This example uses `state` to track the current list of items as well as the text that the user has entered. Although event handlers appear to be rendered inline, they will be collected and implemented using EVENT DELEGATION.

            class TodoApp extends React.Component { // App 只是外層的 component
              constructor(props) {
                super(props);
                this.state = { items: [], text: '' };
                this.handleChange = this.handleChange.bind(this); // ??
                this.handleSubmit = this.handleSubmit.bind(this);
              }

              render() {
                return (
                  <div>
                    <h3>TODO</h3>
                    <TodoList items={this.state.items} /> // 內含另一個 component
                    <form onSubmit={this.handleSubmit}>
                      <label htmlFor="new-todo">
                        What needs to be done?
                      </label>
                      <input
                        id="new-todo"
                        onChange={this.handleChange}
                        value={this.state.text}
                      />
                      <button>
                        Add #{this.state.items.length + 1}
                      </button>
                    </form>
                  </div>
                );
              }

              handleChange(e) {
                this.setState({ text: e.target.value });
              }

              handleSubmit(e) {
                e.preventDefault();
                if (this.state.text.length === 0) {
                  return;
                }
                const newItem = {
                  text: this.state.text,
                  id: Date.now()
                };
                this.setState(state => ({
                  items: state.items.concat(newItem),
                  text: ''
                }));
              }
            }

            class TodoList extends React.Component {
              render() {
                return (
                  <ul>
                    {this.props.items.map(item => (
                      <li key={item.id}>{item.text}</li>
                    ))}
                  </ul>
                );
              }
            }

            ReactDOM.render(
              <TodoApp />,
              document.getElementById('todos-example')
            );

    A Component Using External Plugins

      - React allows you to interface with other libraries and frameworks. This example uses [remarkable](https://github.com/jonschlinkert/remarkable), an external Markdown library, to convert the `<textarea>`’s value in real time.

            class MarkdownEditor extends React.Component {
              constructor(props) {
                super(props);
                this.md = new Remarkable();
                this.handleChange = this.handleChange.bind(this);
                this.state = { value: 'Hello, **world**!' };
              }

              handleChange(e) {
                this.setState({ value: e.target.value });
              }

              getRawMarkup() {
                return { __html: this.md.render(this.state.value) };
              }

              render() {
                return (
                  <div className="MarkdownEditor">
                    <h3>Input</h3>
                    <label htmlFor="markdown-content">
                      Enter some markdown
                    </label>
                    <textarea
                      id="markdown-content"
                      onChange={this.handleChange}
                      defaultValue={this.state.value}
                    />
                    <h3>Output</h3>
                    <div
                      className="content"
                      dangerouslySetInnerHTML={this.getRawMarkup()}
                    />
                  </div>
                );
              }
            }

            ReactDOM.render(
              <MarkdownEditor />,
              document.getElementById('markdown-example')
            );

## 新手上路 {: #getting-started }

  - [Getting Started – React](https://reactjs.org/docs/getting-started.html)

      - This page is an overview of the React documentation and related resources.

    Try React

      - React has been designed from the start for GRADUAL ADOPTION, and you can use as little or as much React as you need. Whether you want to get a taste of React, add some interactivity to a simple HTML page, or start a complex React-powered app, the links in this section will help you get started.

      - Online Playgrounds

        If you’re interested in playing around with React, you can use an online code playground. Try a Hello World template on [CodePen](https://reactjs.org/redirect-to-codepen/hello-world), CodeSandbox, Glitch, or Stackblitz.

        If you prefer to use your own text editor, you can also [download this HTML file](https://raw.githubusercontent.com/reactjs/reactjs.org/master/static/html/single-file-example.html), edit it, and open it from the local filesystem in your browser. It does a SLOW runtime code transformation, so we’d only recommend using this for simple demos.

        之所以 "runtime code transformation" 會慢，是因為 JSX 的轉換發生在 client 端 (透過 Babel)，實務上 JSX 在 build time 就要透過 toolchain 轉換成 JavaScript。

        > Note: this page is a great way to try React but it's not suitable for production. It slowly compiles JSX with Babel in the browser ...

      - Add React to a Website

        You can [add React to an HTML page in one minute](https://reactjs.org/docs/add-react-to-a-website.html). You can then either gradually expand its presence, or keep it contained to a few dynamic widgets.

      - Create a New React App

        When starting a React project, a [simple HTML page with script tags](https://reactjs.org/docs/add-react-to-a-website.html) might still be the best option. It only takes a minute to set up!

        As your application grows, you might want to consider a more integrated setup. There are several JavaScript toolchains we recommend for larger applications. Each of them can work with little to no configuration and lets you take full advantage of the rich React ecosystem. [Learn how](https://reactjs.org/docs/create-a-new-react-app.html). #ril

    Learn React

      - People come to React from different backgrounds and with different learning styles. Whether you prefer a more theoretical or a practical approach, we hope you’ll find this section helpful.

          - If you prefer to learn by doing, start with our [practical tutorial](https://reactjs.org/tutorial/tutorial.html).
          - If you prefer to learn concepts step by step, start with our [guide to main concepts](https://reactjs.org/docs/hello-world.html).

        Like any unfamiliar technology, React does have a learning curve. With practice and some patience, you will get the hang of it.

      - First Examples

        The React homepage contains a few small React examples with a live editor. Even if you don’t know anything about React yet, try changing their code and see how it affects the result.

      - React for Beginners

        If you feel that the React documentation goes at a faster pace than you’re comfortable with, check out [this overview of React by Tania Rascia](https://www.taniarascia.com/getting-started-with-react/). It introduces the most important React concepts in a detailed, beginner-friendly way. Once you’re done, give the documentation another try! #ril

      - React for Designers

        If you’re coming from a design background, [these resources](https://reactfordesigners.com/) are a great place to get started. #ril

      - JavaScript Resources

        The React documentation assumes some familiarity with programming in the JavaScript language. You don’t have to be an expert, but it’s harder to learn both React and JavaScript at the same time.

        We recommend going through this JavaScript overview to check your knowledge level. It will take you between 30 minutes and an hour but you will feel more confident learning React.

        Tip: Whenever you get confused by something in JavaScript, MDN and [javascript.info](https://javascript.info/) are great websites to check. There are also community support forums where you can ask for help. #ril

      - Practical Tutorial

        If you prefer to learn by doing, check out our practical tutorial. In this tutorial, we build a tic-tac-toe game in React. You might be tempted to skip it because you’re not into building games — but give it a chance. The techniques you’ll learn in the tutorial are fundamental to building any React apps, and mastering it will give you a much deeper understanding.

      - Step-by-Step Guide

        If you prefer to learn concepts step by step, our guide to main concepts is the best place to start. Every next chapter in it builds on the knowledge introduced in the previous chapters so you won’t miss anything as you go along.

      - Thinking in React

        Many React users credit reading [Thinking in React](https://reactjs.org/docs/thinking-in-react.html) as the moment React finally “clicked” for them. It’s probably the oldest React walkthrough but it’s still just as relevant. #ril

      - Recommended Courses

        Sometimes people find third-party books and video courses more helpful than the official documentation. We maintain [a list of commonly recommended resources](https://reactjs.org/community/courses.html), some of which are free.

      - Advanced Concepts

        Once you’re comfortable with the main concepts and played with React a little bit, you might be interested in more advanced topics. This section will introduce you to the powerful, but less commonly used React features like [context](https://reactjs.org/docs/context.html) and [refs](https://reactjs.org/docs/refs-and-the-dom.html). #ril

      - API Reference

        This documentation section is useful when you want to learn more details about a particular React API. For example, [`React.Component` API reference](https://reactjs.org/docs/react-component.html) can provide you with details on how `setState()` works, and what different LIFECYCLE METHODS are useful for.

      - Glossary and FAQ

        The [glossary](https://reactjs.org/docs/glossary.html) contains an overview of the most common terms you’ll see in the React documentation. There is also a FAQ section dedicated to short questions and answers about common topics, including [making AJAX requests](https://reactjs.org/docs/faq-ajax.html), [component state](https://reactjs.org/docs/faq-state.html), and [file structure](https://reactjs.org/docs/faq-structure.html). #ril

    Staying Informed

      - The React blog is the official source for the updates from the React team. Anything important, including release notes or deprecation notices, will be posted there first.
      - You can also follow the @reactjs account on Twitter, but you won’t miss anything essential if you only read the blog.
      - Not every React release deserves its own blog post, but you can find a detailed changelog for every release in the [`CHANGELOG.md` file in the React repository](https://github.com/facebook/react/blob/master/CHANGELOG.md), as well as on the Releases page.

    Versioned Documentation

      - This documentation always reflects the latest stable version of React. Since React 16, you can find older versions of the documentation on a [separate page](https://reactjs.org/versions/). Note that documentation for past versions is snapshotted at the time of the release, and isn’t being continuously updated.

  - [Add React to a Website – React](https://reactjs.org/docs/add-react-to-a-website.html)

    Use as little or as much React as you need.

      - React has been designed from the start for gradual adoption, and you can use as little or as much React as you need. Perhaps you only want to add some “sprinkles of interactivity” to an existing page. React components are a great way to do that.

      - The majority of websites aren’t, and don’t need to be, SINGLE-PAGE APPS. With a few lines of code and no build tooling, try React in a small part of your website. You can then either gradually expand its presence, or keep it contained to a few dynamic widgets.

        是否在暗示全新的 React 應用，通常會做成 SPA?

    Add React in One Minute

      - In this section, we will show how to add a React component to an existing HTML page. You can follow along with your own website, or create an empty HTML file to practice.

        There will be no complicated tools or install requirements — to complete this section, you only need an internet connection, and a minute of your time.

        Optional: [Download the full example (2KB zipped)](https://gist.github.com/gaearon/6668a1f6986742109c00a581ce704605/archive/f6c882b6ae18bde42dcf6fdb751aae93495a2275.zip)

      - Step 1: Add a DOM Container to the HTML

        First, open the HTML page you want to edit. Add an empty `<div>` tag to mark the spot where you want to display something with React. For example:

            <!-- ... existing HTML ... -->

            <div id="like_button_container"></div>

            <!-- ... existing HTML ... -->

        We gave this `<div>` a unique `id` HTML attribute. This will allow us to find it from the JavaScript code later and display a React component inside of it.

        Tip: You can place a “container” `<div>` like this anywhere inside the `<body>` tag. You may have as many independent DOM containers on one page as you need. They are usually empty — React will replace any existing content inside DOM containers.

      - Step 2: Add the Script Tags

        Next, add three `<script>` tags to the HTML page RIGHT BEFORE THE CLOSING `</body>` TAG:

              <!-- ... other HTML ... -->

              <!-- Load React. -->
              <!-- Note: when deploying, replace "development.js" with "production.min.js". -->
              <script src="https://unpkg.com/react@16/umd/react.development.js" crossorigin></script>
              <script src="https://unpkg.com/react-dom@16/umd/react-dom.development.js" crossorigin></script>

              <!-- Load our React component. -->
              <script src="like_button.js"></script>

            </body>

        The first two tags load React. The third one will load your component code.

      - Step 3: Create a React Component

        Create a file called `like_button.js` next to your HTML page.

        Open [this starter code](https://gist.github.com/gaearon/0b180827c190fe4fd98b4c7f570ea4a8/raw/b9157ce933c79a4559d2aa9ff3372668cce48de7/LikeButton.js) and paste it into the file you created.

        Tip: This code defines a React component called `LikeButton`. Don’t worry if you don’t understand it yet — we’ll cover the building blocks of React later in our hands-on tutorial and main concepts guide. For now, let’s just get it showing on the screen!

        After the starter code, add two lines to the bottom of `like_button.js`:

            // ... the starter code you pasted ...

            const domContainer = document.querySelector('#like_button_container');
            ReactDOM.render(e(LikeButton), domContainer);

        These two lines of code find the `<div>` we added to our HTML in the first step, and then display our “Like” button React component inside of it.

      - That’s It!

        There is no step four. You have just added the first React component to your website.

        Check out the next sections for more tips on integrating React.

          - [View the full example source code](https://gist.github.com/gaearon/6668a1f6986742109c00a581ce704605)
          - [Download the full example (2KB zipped)](https://gist.github.com/gaearon/6668a1f6986742109c00a581ce704605/archive/f6c882b6ae18bde42dcf6fdb751aae93495a2275.zip)

    Tip: Reuse a Component

      - Commonly, you might want to display React components in multiple places on the HTML page. Here is an example that displays the “Like” button three times and passes some data to it:

          - [View the full example source code](https://gist.github.com/gaearon/faa67b76a6c47adbab04f739cba7ceda)
          - [Download the full example (2KB zipped)](https://gist.github.com/gaearon/faa67b76a6c47adbab04f739cba7ceda/archive/9d0dd0ee941fea05fd1357502e5aa348abb84c12.zip)

        Note: This strategy is mostly useful while React-powered parts of the page are isolated from each other. Inside React code, it’s easier to use [component composition](https://reactjs.org/docs/components-and-props.html#composing-components) instead. #ril

    Tip: Minify JavaScript for Production

      - Before deploying your website to production, be mindful that unminified JavaScript can significantly slow down the page for your users.

      - If you already minify the application scripts, your site will be production-ready if you ensure that the deployed HTML loads the versions of React ending in `production.min.js`:

            <script src="https://unpkg.com/react@16/umd/react.production.min.js" crossorigin></script>
            <script src="https://unpkg.com/react-dom@16/umd/react-dom.production.min.js" crossorigin></script>

        If you don’t have a minification step for your scripts, [here’s one way to set it up](https://gist.github.com/gaearon/42a2ffa41b8319948f9be4076286e1f3). #ril

    Optional: Try React with JSX

      - In the examples above, we only relied on features that are NATIVELY SUPPORTED by the browsers. This is why we used a JavaScript function call to tell React what to display:

            const e = React.createElement;

            // Display a "Like" <button>
            return e(
              'button',
              { onClick: () => this.setState({ liked: true }) },
              'Like'
            );

      - However, React also offers an option to use JSX instead:

            // Display a "Like" <button>
            return (
              <button onClick={() => this.setState({ liked: true })}>
                Like
              </button>
            );

        These two code snippets are equivalent. While JSX is completely optional, many people find it helpful for writing UI code — both with React and with other libraries.

        You can play with JSX using [this online converter](https://babeljs.io/en/repl#?babili=false&browsers=&build=&builtIns=false&spec=false&loose=false&code_lz=DwIwrgLhD2B2AEcDCAbAlgYwNYF4DeAFAJTw4B88EAFmgM4B0tAphAMoQCGETBe86WJgBMAXJQBOYJvAC-RGWQBQ8FfAAyaQYuAB6cFDhkgA&debug=false&forceAllTransforms=false&shippedProposals=false&circleciRepo=&evaluate=false&fileSize=false&timeTravel=false&sourceType=module&lineWrap=true&presets=es2015%2Creact%2Cstage-2&prettier=false&targets=&version=7.4.3).

    Quickly Try JSX #ril

  - [Tutorial: Intro to React – React](https://reactjs.org/tutorial/tutorial.html) #ril

  - [Hello World – React](https://reactjs.org/docs/hello-world.html) #ril

      - The smallest React example looks like this:

            ReactDOM.render(
              <h1>Hello, world!</h1>,
              document.getElementById('root')
            );

        It displays a heading saying “Hello, world!” on the page. [Try it on CodePen](https://reactjs.org/redirect-to-codepen/hello-world).

        會自動引入 `react.development.js` 與 `react-dom.development.js`。

## 參考資料 {: #reference }

  - [React](https://reactjs.org/)
  - [React Blog](https://reactjs.org/blog/)

社群：

  - ['reactjs' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/reactjs)
  - [React (@reactjs) | Twitter](https://twitter.com/reactjs)

更多：

  - [JSX](react-jsx.md)

相關：

  - [JavaScript Framework](html-javascript.md#framework)

手冊：

  - [Glossary of React Terms](https://reactjs.org/docs/glossary.html)
  - [Changlog](https://github.com/facebook/react/blob/master/CHANGELOG.md)
