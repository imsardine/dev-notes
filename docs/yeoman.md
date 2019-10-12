# Yeoman

  - [Yeoman \(software\) \- Wikipedia](https://en.wikipedia.org/wiki/Yeoman_(software)) #ril

      - Yeoman is an open source client-side scaffolding tool for WEB APPLICATIONS. Yeoman runs as a command-line interface written for Node.js and combines several functions into one place, such as generating a STARTER TEMPLATE, managing dependencies, running unit tests, providing a local development server, and optimizing production code for deployment.

        除了 starter template 外，做為 scaffolding tool，管到 dependencies、unit test、development server 是太多了；按照 Getting Started 的說法 any kind of app、language agnostic，可以應用在 web application 以外的場合。

        Yeoman was released at Google I/O 2012.

      - Yeoman combines several open source tools in an attempt to streamline many aspects of the web development process.
      - Using a "generator" concept inspired by Ruby on Rails, Yeoman first creates a basic project structure with vendor libraries included. ... Yeoman is meant to be modular such that anyone can design a GENERATOR to create a template for a particular type of project.
      - Yeoman is an open source project whose code is hosted on GitHub. Some of the primary contributors are on the Google Chrome Developer Relations team, such as Addy Osmani, Paul Irish, and Eric Bidelman

  - [The web's scaffolding tool for modern webapps \| Yeoman](https://yeoman.io/)

      - Get started and then find a generator for your webapp. Generators are available for Angular, Backbone, React, Polymer and over 5600+ other projects.

        不同的 generator project 習慣命名為 `generator-xxx`，例如 `yeoman/generator-angular`。

    What's Yeoman?

      - Yeoman helps you to kickstart new projects, prescribing best practices and tools to help you stay productive.

        To do so, we provide a GENERATOR ECOSYSTEM. A generator is basically a PLUGIN that can be run with the `yo` command to scaffold complete projects or useful PARTS.

      - Through our official generators, we promote the "YEOMAN WORKFLOW". This workflow is a robust and OPINIONATED CLIENT-SIDE STACK, comprising tools and frameworks that can help developers quickly build beautiful web applications. We take care of providing everything needed to get started without any of the normal headaches associated with a manual setup.

        會不會因為 opinionated 而失去了彈性? 但若是 best practices 也沒什麼不好。

      - With a MODULAR ARCHITECTURE that can scale out of the box, we leverage the success and lessons learned from several open-source communities to ensure the stack developers use it as intelligent as possible.

      - As firm believers in good documentation and well thought out build processes, Yeoman includes support for linting, testing, minification and much more, so developers can focus on solutions rather than worrying about the little things.

        但這僅限於 web application??

    Tools

      - The Yeoman workflow comprises three types of tools for improving your productivity and satisfaction when building a web app: the SCAFFOLDING TOOL (yo), the build tool (Gulp, Grunt etc) and the package manager (like npm and Bower).

        yo scaffolds out a new application, writing your build configuration (e.g `Gulpfile`) and pulling in relevant build tasks and package manager dependencies (e.g npm) that you might need for your build.

        單用 `yo` 也可以，從 "Gulp and Grunt are two popular options." 看來，build tool 跟 package manager 似乎有其他選擇? 但為何要寫專用的 build configuration??

        不過 [Basic scaffolding - Getting started with Yeoman \| Yeoman](https://yeoman.io/learning/#basic-scaffolding) 提到 "A lot of generators rely on build systems (like Grunt or Gulp), and package managers (like npm and Bower)."，看似 Yeoman 並沒有綁定 build tool 跟 package manager，這些綁定/選擇都發生在個別的 generator。

      - All three of these tools are DEVELOPED AND MAINTAINED SEPARATELY, but work well together as part of our prescribed workflow for keeping you effective.

  - [Getting started with Yeoman \| Yeoman](https://yeoman.io/learning/)

      - Yeoman is a generic scaffolding system allowing the creation of ANY KIND OF APP. It allows for rapidly getting started on new projects and streamlines the MAINTENANCE OF EXISTING PROJECTS. 跟現有的專案什麼關係??
      - Yeoman is LANGUAGE AGNOSTIC. It can generate projects in any language (Web, Java, Python, C#, etc.)

      - Yeoman by itself doesn’t make any decisions. EVERY DECISION IS MADE BY GENERATORS which are basically plugins in the Yeoman environment. There’s a lot of publicly available generators and its easy to create a new one to match any workflow. Yeoman is always the right choice for your scaffolding needs.

        呼應上面 modular architecture 的說法，也說明了為何 Yeoman 本身是 language agnostic。

      - Here are some common use cases: 產生全新的專案，或是現有專案的局部都可以

          - Rapidly create a new project
          - Create new SECTIONS of a project, like a new controller with unit tests
          - Create modules or packages
          - Bootstrapping new services
          - Enforcing standards, best practices and style guides
          - Promote new projects by letting users get started with a sample app

  - [The Yeoman Monthly Digest \#3  \|  Web  \|  Google Developers](https://developers.google.com/web/updates/2014/02/The-Yeoman-Monthly-Digest-3) #ril
  - [AddyOsmani\.com \- Improved Developer Tooling and Yeoman](https://addyosmani.com/blog/improved-developer-tooling-and-yeoman/) (2012-06-27) #ril
  - [Google I/O 2012 \- Better Web App Development Through Tooling \- YouTube](https://www.youtube.com/watch?v=Mk-tFn2Ix6g) (2012-06-28) #ril

## 新手上路 {: #getting-started }

  - [Getting started with Yeoman \| Yeoman](https://yeoman.io/learning/#getting-started) #ril

      - `yo` is the Yeoman command line utility allowing the creation of projects utilizing scaffolding templates (referred to as generators). Yo and the generators used are installed using `npm`.

        Generator 本身也要包裝成 npm package，這一點就不太 language agnostic 了。

    Installing yo and some generators

      - First thing is to install yo using `npm`: `npm install -g yo`

      - Then install the needed generator(s). Generators are NPM PACKAGES named `generator-XYZ`. Search for them on our website or by selecting “install a generator” menu option while running yo. To install the webapp generator: `npm install -g generator-webapp`

        有沒有可能不用公開發佈到 npm??

    Basic scaffolding

      - We’ll use `generator-webapp` in our examples below. Replace `webapp` with the name of your generator for the same result.

        To scaffold a new project, run: `yo webapp`

        跟著執行一次，被問及要哪些 feature 及採用的 DSL (BDD, TDD)，CLI 選單滿酷的，可以用方向鍵選擇；產生檔案後，會自動執行 `yarn install` 與 `npm install`，不過也提示 "If this fails, try running the command yourself."，猜想在這之後，開發上就用不到 `yo` 了??

      - Most generators will ask a series of questions to customize the new project. To see which OPTIONS are available, use the `help` command: `yo webapp --help`

      - A lot of generators RELY ON BUILD SYSTEMS (like Grunt or Gulp), and package managers (like npm and Bower). Make sure to visit the generator’s site to learn about running and maintaining the new app. Easily access a generator’s home page by running: `npm home generator-webapp`

        還好 build tool 及 package manager 的綁定/選擇是發生在個別的 generator!!

      - Generators scaffolding complex frameworks are likely to provide ADDITIONAL GENERATORS to scaffold SMALLER PARTS of a project. These generators are usually referred to as SUB-GENERATORS, and are accessed as `generator:sub-generator`.

        Take `generator-angular` as an example. Once the full angular app has been generated, other features can be added. To add a new controller to the project, run the `controller` sub-generator: `yo angular:controller MyNewController`

    Other yo commands

      - Other than the basics covered in the previous section, `yo` is also a FULLY INTERACTIVE tool. Simply typing `yo` in a terminal will provide a list of options to manage everything related to the generators: run, update, install, help and other utilities.

      - Yo also provide the following commands.

          - `yo --help` Access the full help screen
          - `yo --generators` List every installed generators
          - `yo --version` Get the version

    Troubleshooting

      - Most issues can be found by running: `yo doctor`

        The `doctor` command will diagnose and provide steps to resolve the most common issues.

## 製作 Generator ?? {: #authoring }

  - [Writing Your Own Yeoman Generator \| Yeoman](https://yeoman.io/authoring/)

      - Generators are the BUILDING BLOCKS of the Yeoman ecosystem. They’re the plugins run by yo to generate files for end users. In reading this section, you’ll learn how to create and DISTRIBUTE your own.
      - Note: We built a `generator-generator` to help users get started with their own generator. Feel free to use it to bootstrap your own generator ONCE YOU UNDERSTAND THE BELOW CONCEPTS.

    Organizing your generators >  Setting up as a node module

      - A generator is, at its core, a NODE.JS MODULE.
      - First, create a folder within which you’ll write your generator. This folder must be named `generator-name` (where `name` is the name of your generator). This is important, as Yeoman relies on the file system to find available generators.

      - Once inside your generator folder, create a `package.json` file. This file is a Node.js module manifest. You can generate this file by running `npm init` from your command line or by entering the following manually:

            {
              "name": "generator-name",
              "version": "0.1.0",
              "description": "",
              "files": [
                "generators"
              ],
              "keywords": ["yeoman-generator"],
              "dependencies": {
                "yeoman-generator": "^1.0.0"
              }
            }

      - The `name` property must be prefixed by `generator-`. The `keywords` property must contain `"yeoman-generator"` and the repo must have a DESCRIPTION to be INDEXED by our generators page.
      - You should make sure you set the LATEST VERSION of `yeoman-generator` as a dependency. You can do this by running: `npm install --save yeoman-generator`.

      - The `files` property must be an array of files and directories that is used by your generator.

        Add other `package.json` properties as needed.

    Organizing your generators > Folder tree

      - Yeoman’s functionality is dependent on how you structure your directory tree. Each sub-generator is contained within ITS OWN FOLDER.
      - The DEFAULT GENERATOR used when you call `yo name` is the `app` generator. This must be contained within the `app/` directory.

      - Sub-generators, used when you call yo `name:subcommand`, are stored in folders named exactly like the sub command.

        In an example project, a directory tree could look like this:

            ├───package.json
            └───generators/
                ├───app/
                │   └───index.js
                └───router/
                    └───index.js

        This generator will expose `yo name` and `yo name:router` commands.

        注意每個 generator folder 下，都有個 `index.js`。

      - Yeoman allows two different directory structures. It’ll look in `./` and in `generators/` to REGISTER AVAILABLE GENERATORS.

        The previous example can also be written as follows:

            ├───package.json
            ├───app/
            │   └───index.js
            └───router/
                └───index.js

        If you use this second directory structure, make sure you point the `files` property in your `package.json` at all the generator folders.

            {
              "files": [
                "app",
                "router"
              ]
            }

        很明顯地，將所有 generator 集中放 `generators/` 比較方便，不用一直調 `package.json`；除非除了 default generator 外，沒有其他 sub-generator。

    Extending generator

      - Once you have this structure in place, it’s time to write the actual generator. Yeoman offers a base generator which you can extend to implement your own behavior. This base generator will add most of the functionalities you’d expect to ease your task.

      - In the generator’s `index.js` file, here’s how you extend the BASE GENERATOR:

            var Generator = require('yeoman-generator');

            module.exports = class extends Generator {};

        We assign the extended generator to `module.exports` to make it AVAILABLE TO THE ECOSYSTEM. This is how we export modules in Node.js.

    Extending generator > Overwriting the constructor

      - Some generator methods can only be called inside the `constructor` function. These special methods may do things like set up important state controls and may not function outside of the constructor.

        To override the generator constructor, add a constructor method like so: 為了增加 options ??

            module.exports = class extends Generator {
              // The name `constructor` is important here
              constructor(args, opts) {
                // Calling the super constructor is important so our generator is correctly set up
                super(args, opts);

                // Next, add your custom code
                this.option('babel'); // This method adds support for a `--babel` flag
              }
            };

    Extending generator > Adding your own functionality

      - EVERY METHOD ADDED TO THE PROTOTYPE IS RUN ONCE THE GENERATOR IS CALLED–AND USUALLY IN SEQUENCE. But, as we’ll see in the next section, some special method names will trigger a specific run order.

        把所有 method 都執行一遍，這是什麼概念??

        Let’s add some methods:

            module.exports = class extends Generator {
              method1() {
                this.log('method 1 just ran');
              }

              method2() {
                this.log('method 2 just ran');
              }
            };

        When we run the generator later, you’ll see these lines logged to the console.

    Running the generator

      - At this point, you have a working generator. The next logical step would be to run it and see if it works.
      - Since you’re developing the generator LOCALLY, it’s not yet available as a GLOBAL NPM MODULE. A global module may be created and SYMLINKED TO A LOCAL ONE, using npm. Here’s what you’ll want to do:

        On the command line, from the root of your generator project (in the `generator-name/` folder), type:

            npm link

        That will install your project dependencies and symlink a global module to your local file. After npm is done, you’ll be able to call yo name and you should see the `this.log`, defined earlier, rendered in the terminal. Congratulations, you just built your first generator!

    Running the generator > Finding the project root

      - While running a generator, Yeoman will try to figure some things out based on the CONTEXT OF THE FOLDER IT’S RUNNING FROM.
      - Most importantly, Yeoman searches the directory tree for a `.yo-rc.json` file. If found, it considers the location of the file as the ROOT OF THE PROJECT. Behind the scenes, Yeoman will change the current directory to the `.yo-rc.json` file location and run the requested generator there.

      - The STORAGE MODULE creates the `.yo-rc.json` file. Calling `this.config.save()` from a generator for the first time will create the file.

        So, if your generator is not running in your current working directory, make sure you don’t have a `.yo-rc.json` somewhere UP the directory tree.

        為了讓 sub-generator 知道 root 在哪??

  - [Working With The File System \| Yeoman](https://yeoman.io/authoring/file-system.html) 開始提到 template，採 EJS 語法 #ril

  - [Guide to create and publish a Yeoman generator – Fabian Vallejos – Medium](https://medium.com/@vallejos/yeoman-guide-adea4d6ea1e3) (2017-07-01) #ril

## Local Generator ?? {: #local-generator }

  - [How to run/register local generators? · Issue \#210 · yeoman/yo](https://github.com/yeoman/yo/issues/210) #ril
  - [Running local generators by paths · Issue \#11 · yeoman/environment](https://github.com/yeoman/environment/issues/11) #ril

## 安裝設置 {: #setup }

  - [The web's scaffolding tool for modern webapps \| Yeoman](https://yeoman.io/)

      - One-line install using npm: `npm install -g yo`

            $ npm install -g yo
            npm WARN deprecated cross-spawn-async@2.2.5: cross-spawn no longer requires a build toolchain, use it instead
            /usr/local/bin/yo -> /usr/local/lib/node_modules/yo/lib/cli.js
            /usr/local/bin/yo-complete -> /usr/local/lib/node_modules/yo/lib/completion/index.js

            > spawn-sync@1.0.15 postinstall /usr/local/lib/node_modules/yo/node_modules/spawn-sync
            > node postinstall


            > yo@2.0.5 postinstall /usr/local/lib/node_modules/yo
            > yodoctor


            Yeoman Doctor
            Running sanity checks on your system

            ✔ Global configuration file is valid
            ✔ NODE_PATH matches the npm root
            ✔ Node.js version
            ✔ No .bowerrc file in home directory
            ✔ No .yo-rc.json file in home directory
            ✔ npm version
            ✔ yo version

            Everything looks all right!
            + yo@2.0.5
            added 542 packages in 31.913s

## 參考資料 {: #reference }

  - [Yeoman](https://yeoman.io/)
  - [yeoman/yo - GitHub](https://github.com/yeoman/yo)
  - [yo - npm](https://www.npmjs.com/package/yo)

社群：

  - [Yeoman (@yeoman) | Twitter](https://twitter.com/yeoman)
  - ['yeoman' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/yeoman)
  - ['yeoman-generator' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/yeoman-generator)

手冊：

  - [Generators | Yeoman](https://yeoman.io/generators/)
