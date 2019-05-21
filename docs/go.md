# Go

  - [The Go Programming Language](https://golang.org/)

      - Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.

  - [Go (programming language) \- Wikipedia](https://en.wikipedia.org/wiki/Go_(programming_language)) #ril

      - Go (also referred to as Golang) is a statically typed, compiled programming language designed at Google by Robert Griesemer, Rob Pike, and Ken Thompson. Go is SYNTACTICALLY SIMILAR TO C, but with MEMORY SAFETY, garbage collection, structural typing, and CSP-style concurrency.

        看來會 C 對於學習 Go 有些幫助。

      - There are two major implementations:

          - Google's self-hosting compiler toolchain targeting multiple operating systems, mobile devices, and WebAssembly.
          - `gccgo`, a GCC frontend.

        A third compiler, [GopherJS](https://github.com/gopherjs/gopherjs), compiles Go to JavaScript for front-end web development.

        怎麼跟 Dart 這麼像，產出這麼多樣 -- mobile、WebAssembly、JavaScript 等 #ril

  - [從商業利益看 Go 程式語言 \| 小惡魔 \- 電腦技術 \- 工作筆記 \- AppleBOY](https://blog.wu-boy.com/2017/01/business-benefits-of-go/) (2017-01-14) #ril
  - [Frequently Asked Questions (FAQ) \| Dart](https://www.dartlang.org/faq#q-how-does-dart-relate-to-go) 雖然都是 Google 開創的語言，但兩者是完全獨立且有著不同的目標，這是一種選擇...

## Hello, World!

`hello-world/hello.go`:

```
package main

import "fmt"

func main() {
    fmt.Printf("Hello, World!\n")
}
```

執行 `go build` 會產生 `hello-world` 執行檔 (根據目錄名稱)。

## 新手上路 {: #getting-started }

  - [Test your installation - Getting Started \- The Go Programming Language](https://golang.org/doc/install#testing)

      - Check that Go is installed correctly by setting up a WORKSPACE and building a simple program, as follows.

      - Create your WORKSPACE DIRECTORY, `$HOME/go`. (If you'd like to use a different directory, you will need to set the `GOPATH` environment variable.)

        為什麼 workspace dir 不在 `~/go` 就要調整 `GOPATH`? --> 預設為 `~/go`。

      - Next, make the directory `src/hello` inside your workspace, and in that directory create a file named `hello.go` that looks like:

            package main

            import "fmt"

            func main() {
                fmt.Printf("hello, world\n")
            }

      - Then build it with the `go` tool:

            $ cd $HOME/go/src/hello
            $ go build

        The command above will build an executable named `hello` in the directory ALONGSIDE YOUR SOURCE CODE. Execute it to see the greeting:

            $ ./hello
            hello, world

        If you see the "hello, world" message then your Go installation is working.

        沒有先將 CWD 切到 `src/hello` 的話，`go build` 會丟出 `can't load package: package .: no Go files in /tmp/go` 的錯誤；看來 `go build` 預設會在 CWD 找 `.go`，下面的 `go install` 跟 `go clean -i` 也是這樣，有點怪 ??

      - You can run `go install` to install the binary into your workspace's `bin` directory or `go clean -i` to remove it.

        實驗發現，若 workspace dir 在 `~/go`，在 `~/go/src/hello` 下執行 `go install` 確實會產生 `~/go/bin/hello`，但如果是在其他地方 (例如 `/tmp/go`)，執行 `go install` 會丟出下面的錯誤：

            go install
            go install: no install location for directory /tmp/go/src/hello outside GOPATH
                For more details see: 'go help gopath'

        `go help gopath` 提到 "If the environment variable is unset, `GOPATH` defaults to a subdirectory named "`go`" in the user's home directory"

      - Before rushing off to write Go code please read the How to Write Go Code document, which describes some essential concepts about using the Go tools.

  - [Hello, World! - A Tour of Go](https://tour.golang.org/welcome/1)

      - The tour is interactive. Click the Run button now (or press Shift + Enter) to compile and run the program on a remote server. The result is displayed below the code.
      - When you click on Format (shortcut: Ctrl + Enter), the text in the editor is formatted using the `gofmt` tool. You can switch syntax highlighting on and off by clicking on the syntax button.

    Go offline

      - This tour is also available as a stand-alone program that you can use without access to the internet.

        The stand-alone tour is faster, as it builds and runs the code samples on your own machine.

      - To run the tour locally install and run the tour binary:

            go get golang.org/x/tour
            tour

        The tour program will open a web browser displaying your local version of the tour.

        執行完 `go get golang.org/x/tour` 後，`~/go/bin` 會多了個 `tour` 執行檔，相應的原始碼則在 `~/go/src/golang.org/x/tour/` 下。而 `tour` 在本地啟動了一個 web server：

            $ bin/tour
            2019/05/03 10:56:06 Serving content from .../go/src/golang.org/x/tour
            2019/05/03 10:56:06 A browser window should open. If not, please visit http://127.0.0.1:3999
            2019/05/03 10:56:07 accepting connection from: 127.0.0.1:61737

            ...
            2019/05/03 10:57:31 running snippet from: 127.0.0.1:61737

    The Go Playground

      - This tour is built atop the Go Playground, a web service that runs on golang.org's servers.

        The service receives a Go program, compiles, links, and runs the program inside a SANDBOX, then returns the output.

      - There are limitations to the programs that can be run in the playground:

          - In the playground the time begins at 2009-11-10 23:00:00 UTC (determining the significance of this date is an EXERCISE FOR THE READER). This makes it easier to cache programs by giving them deterministic output.

            此時右側的程式碼正是印出當下的時間 `fmt.Println("The time is", time.Now())`，固定會看到 `The time is 2009-11-10 23:00:00 +0000 UTC m=+0.000000001`。 

          - There are also limits on execution time and on CPU and memory usage, and the program cannot access external network hosts.

      - The playground uses the latest stable release of Go.

        Read "[Inside the Go Playground](https://blog.golang.org/playground)" to learn more.

  - [Welcome to a tour of Go - A Tour of Go](https://tour.golang.org/list)

    Basics

      - The starting point, learn all the basics of the language. Declaring variables, calling functions, and all the things you need to know before moving to the next lessons.
      - Packages, variables, and functions. -- Learn the basic components of any Go program.
      - Flow control statements: `for`, `if`, `else`, `switch` and `defer` -- Learn how to control the flow of your code with conditionals, loops, switches and defers.
      - More types: structs, slices, and maps. --  Learn how to define types based on existing ones: this lesson covers structs, arrays, slices, and maps.

    Methods and interfaces

      - Learn how to define methods on types, how to declare interfaces, and how to put everything together.
      - Methods and interfaces -- This lesson covers methods and interfaces, the constructs that define objects and their behavior.

    Concurrency

      - Go provides concurrency features AS PART OF THE CORE LANGUAGE.

        This module goes over GOROUTINES and CHANNELS, and how they are used to implement different CONCURRENCY PATTERNS.

      - Concurrency -- Go provides concurrency constructions as part of the core language. This lesson presents them and gives some examples on how they can be used.

  - [Packages - A Tour of Go](https://tour.golang.org/basics/1) #ril

## GOPATH ??

  - [Test your installation - Getting Started \- The Go Programming Language](https://golang.org/doc/install#testing) 要求把 code 放在 workspace 裡 (`$HOME/go/`)，否則要設定 `GOPATH` 環境變數? 執行 `go install` 或 `go clean` 可以把編出來的執行檔 `hello` 安裝到 workspace 下的 `bin/` 子目錄，或是從裡面移除? (安裝可以，但 `clean` 試不出來?)
  - 在 workspace 外執行 `go install` 時，會出現 `go install: no install location for directory /path/to/... outside GOPATH` 及 `For more details see: 'go help gopath'` 的錯誤。

## Coding Style ??

  - [A Tour of Go](https://tour.golang.org/welcome/1) 提到 Tour 介面上的 Format 背後是執行 `gofmt`。
  - [gofmt \- The Go Programming Language](https://golang.org/cmd/gofmt/) #ril

## 安裝設定 {: installation }

  - [Getting Started \- The Go Programming Language](https://golang.org/doc/install)

      - Official binary distributions are available for the FreeBSD (release 10-STABLE and above), Linux, macOS (10.10 and above), and Windows operating systems and the 32-bit (386) and 64-bit (amd64) x86 processor architectures.
      - If you are upgrading from an older version of Go you must FIRST REMOVE THE EXISTING VERSION.

    Uninstalling Go

      - To remove an existing Go installation from your system delete the `go` directory. This is usually `/usr/local/go` under Linux, macOS, and FreeBSD or `c:\Go` under Windows.

      - You should also remove the Go `bin` directory from your `PATH` environment variable. Under Linux and FreeBSD you should edit `/etc/profile` or `$HOME/.profile`. If you installed Go with the macOS package then you should remove the `/etc/paths.d/go` file. Windows users should read the section about setting environment variables under Windows.

        在 macOS 上，要刪掉的有 `/usr/local/go` 跟 `/etc/paths.d/go`，`PATH` 裡的 `/usr/local/go/bin` 就是來自這裡。

### macOS

  - [Downloads \- The Go Programming Language](https://golang.org/dl/) 下載 binary distribution - `go<VERSION>.darwin-amd64.pkg`，需要 macOS 10.8+ 及 amd64 架構。

  - [macOS package installer - Getting Started \- The Go Programming Language](https://golang.org/doc/install#macos)

      - Download the package file, open it, and follow the prompts to install the Go tools. The package installs the Go distribution to `/usr/local/go`.
      - The package should put the `/usr/local/go/bin` directory in your `PATH` environment variable. You may need to restart any open Terminal sessions for the change to take effect.

        安裝在 `/usr/local/go`，也會把 `/usr/local/go/bin` 加到 `PATH` 環境變數裡。移除時必須手動把 `/usr/local/go` 及 `/etc/paths.d/go` 移除。

### Docker ??

  - [library/golang \- Docker Hub](https://hub.docker.com/_/golang/) #ril

## 參考資料 {: #reference }

  - [The Go Programming Language](https://golang.org/)
  - [The Go Blog](https://blog.golang.org/)

社群：

  - ['go' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/go)

工具：

  - [The Go Playground](https://play.golang.org/)

文件：

  - [Documentation - The Go Programming Language](https://golang.org/doc/)

相關：

  - Go 的語法跟 [C](c.md) 很像。
