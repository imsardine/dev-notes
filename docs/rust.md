# Rust

  - [Rust Programming Language](https://www.rust-lang.org/)

      - A language empowering everyone to build reliable and efficient software.

    Why Rust?

      - Performance

        Rust is blazingly fast and memory-efficient: with NO RUNTIME OR GARBAGE COLLECTOR, it can power performance-critical services, run on EMBEDDED DEVICES, and easily integrate with other languages.

      - Reliability

        Rust’s RICH TYPE SYSTEM and OWNERSHIP MODEL?? guarantee memory-safety and thread-safety — enabling you to eliminate many classes of bugs at compile-time.

      - Productivity

        Rust has great documentation, a friendly compiler with useful error messages, and top-notch tooling — an integrated package manager and build tool, smart multi-editor support with auto-completion and type inspections, an auto-formatter, and more.

    Build it in Rust

      - In 2018, the Rust community decided to improve programming experience for a few DISTINCT DOMAINS (see [the 2018 roadmap](https://blog.rust-lang.org/2018/03/12/roadmap.html)). For these, you can find many high-quality crates and some awesome guides on how to get started. #ril

      - Command Line

        Whip up a CLI tool quickly with Rust’s robust ecosystem. Rust helps you maintain your app with confidence and distribute it with ease.

      - WebAssembly

        Use Rust to supercharge your JavaScript, one module at a time. Publish to npm, bundle with webpack, and you’re off to the races. #ril

      - Networking

        Predictable performance. Tiny resource footprint. Rock-solid reliability. Rust is great for network services.

      - Embedded

        Targeting low-resource devices? Need low-level control without giving up high-level conveniences? Rust has you covered.

    Rust in production

      - Hundreds of companies around the world are using Rust in production today for fast, low-resource, CROSS-PLATFORM SOLUTIONS. Software you know and love, like Firefox, Dropbox, and Cloudflare, uses Rust. From startups to large corporations, from embedded devices to scalable web services, Rust is a great fit.

## 新手上路 {: #getting-started }

  - [Getting started \- Rust Programming Language](https://www.rust-lang.org/learn/get-started)

    Cargo: the Rust build tool and package manager

      - When you install Rustup you’ll also get the latest stable version of the Rust build tool and package manager, also known as Cargo. Cargo does lots of things:

          - build your project with `cargo build`
          - run your project with `cargo run`
          - test your project with `cargo test`
          - build documentation for your project with `cargo doc`
          - publish a library to crates.io with `cargo publish`

      - To test that you have Rust and Cargo installed, you can run this in your terminal of choice:

            cargo --version

    Other tools

      - Rust support is available in many editors: [rust\-lang/rust\.vim: Vim configuration for Rust\.](https://github.com/rust-lang/rust.vim) #ril

    Generating a new project

      - Let’s write a small application with our new Rust development environment. To start, we’ll use Cargo to make a new project for us. In your terminal of choice run:

            cargo new hello-rust

        This will generate a new directory called `hello-rust` with the following files:

            hello-rust
            |- Cargo.toml
            |- src
              |- main.rs

      - `Cargo.toml` is the manifest file for Rust. It’s where you keep metadata for your project, as well as DEPENDENCIES.

        `src/main.rs` is where we’ll write our application code.

      - `cargo new` generates a "Hello, world!" project for us! We can run this program by moving into the new directory that we made and running this in our terminal:

            cargo run

        You should see this in your terminal:

            $ cargo run
               Compiling hello-rust v0.1.0 (/Users/ag_dubs/rust/hello-rust)
                Finished dev [unoptimized + debuginfo] target(s) in 1.34s
                 Running `target/debug/hello-rust`
            Hello, world!

    Adding dependencies

      - Let’s add a dependency to our application. You can find all sorts of libraries on crates.io, the package registry for Rust. In Rust, we often refer to packages as “crates.”

        In this project, we’ll use a crate called [`ferris-says`](https://crates.io/crates/ferris-says).

        In our `Cargo.toml` file we’ll add this information (that we got from the crate page):

            [dependencies]
            ferris-says = "0.1"

      - Now we can run:

            cargo build

        ...and Cargo will install our dependency for us.

        You’ll see that running this command created a new file for us, `Cargo.lock`. This file is a LOG of the exact versions of the dependencies we are using locally.

      - To use this dependency, we can open `main.rs`, remove everything that’s in there (it’s just another example), and add this line to it:

            use ferris_says::say;

        This line means that we can now use the `say` function that the `ferris-says` crate EXPORTS for us.

    A small Rust application

      - Now let’s write a small application with our new dependency. In our `main.rs`, add the following code:

            use ferris_says::say; // from the previous step
            use std::io::{stdout, BufWriter};

            fn main() {
                let stdout = stdout();
                let message = String::from("Hello fellow Rustaceans!");
                let width = message.chars().count();

                let mut writer = BufWriter::new(stdout.lock());
                say(message.as_bytes(), width, &mut writer).unwrap();
            }

        Once we save that, we can run our application by typing:

            cargo run

        Assuming everything went well, you should see your application print this to the screen:

            ----------------------------
            | Hello fellow Rustaceans! |
            ----------------------------
                          \
                           \
                             _~^~^~_
                         \) /  o o  \ (/
                           '_   -   _'
                           / '-----' \
    Learn more!

      - You’re a Rustacean now! Welcome! We’re so glad to have you. When you’re ready, hop over to our Learn page, where you can find lots of books that will help you to continue on your Rust adventure.

    Who’s this crab, Ferris?

      - Ferris is the UNOFFICIAL mascot of the RUST COMMUNITY. Many Rust programmers call themselves “Rustaceans,” a play on the word “crustacean.” We refer to Ferris with the pronouns “they,” “them,” etc., rather than with gendered pronouns.

      - Ferris is a name playing off of the adjective, “ferrous,” meaning of or pertaining to iron. Since Rust often forms on iron, it seemed like a fun origin for our mascot’s name!

        You can find more images of Ferris on http://rustacean.net/.

## 安裝設置 {: #setup }

  - [Installing Rust - Getting started \- Rust Programming Language](https://www.rust-lang.org/learn/get-started#installing-rust)

    Rustup: the Rust installer and version management tool

      - The primary way that folks install Rust is through a tool called Rustup, which is a Rust installer and version management tool.

      - It looks like you’re running macOS, Linux, or another Unix-like OS. To download Rustup and install Rust, run the following in your terminal, then follow the on-screen instructions. See "Other Installation Methods" if you are on Windows.

            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

        在 macOS 上的執行過程：

            $ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
            info: downloading installer

            Welcome to Rust!

            This will download and install the official compiler for the Rust
            programming language, and its package manager, Cargo.

            Rustup metadata and toolchains will be installed into the Rustup
            home directory, located at:

              /Users/jeremykao/.rustup

            This can be modified with the RUSTUP_HOME environment variable.

            The Cargo home directory located at:

              /Users/jeremykao/.cargo

            This can be modified with the CARGO_HOME environment variable.

            The cargo, rustc, rustup and other commands will be added to
            Cargo's bin directory, located at:

              /Users/jeremykao/.cargo/bin

            This path will then be added to your PATH environment variable by
            modifying the profile files located at:

              /Users/jeremykao/.profile
              /Users/jeremykao/.zprofile
              /Users/jeremykao/.bash_profile

            You can uninstall at any time with rustup self uninstall and
            these changes will be reverted.

            Current installation options:


               default host triple: x86_64-apple-darwin
                 default toolchain: stable (default)
                           profile: default
              modify PATH variable: yes

            1) Proceed with installation (default)
            2) Customize installation
            3) Cancel installation
            >1

            info: profile set to 'default'
            info: default host triple is x86_64-apple-darwin
            info: syncing channel updates for 'stable-x86_64-apple-darwin'
            info: latest update on 2020-08-27, rust version 1.46.0 (04488afe3 2020-08-24)
            info: downloading component 'cargo'
              3.9 MiB /   3.9 MiB (100 %)   3.2 MiB/s in  1s ETA:  0s
            info: downloading component 'clippy' --> 跟 lints 有關
            info: downloading component 'rust-docs'
             12.6 MiB /  12.6 MiB (100 %)   3.0 MiB/s in  4s ETA:  0s
            info: downloading component 'rust-std'
             14.7 MiB /  14.7 MiB (100 %)   2.1 MiB/s in  6s ETA:  0s
            info: downloading component 'rustc'
             47.0 MiB /  47.0 MiB (100 %)   3.4 MiB/s in 15s ETA:  0s
            info: downloading component 'rustfmt'
            info: installing component 'cargo'
            info: Defaulting to 500.0 MiB unpack ram
            info: installing component 'clippy'
            info: installing component 'rust-docs'
             12.6 MiB /  12.6 MiB (100 %)   5.1 MiB/s in  2s ETA:  0s
            info: installing component 'rust-std'
             14.7 MiB /  14.7 MiB (100 %)  10.4 MiB/s in  1s ETA:  0s
            info: installing component 'rustc'
             47.0 MiB /  47.0 MiB (100 %)  11.1 MiB/s in  4s ETA:  0s
            info: installing component 'rustfmt'
            info: default toolchain set to 'stable'

              stable installed - rustc 1.46.0 (04488afe3 2020-08-24)


            Rust is installed now. Great!

            To get started you need Cargo's bin directory ($HOME/.cargo/bin) in your PATH
            environment variable. Next time you log in this will be done
            automatically.

            To configure your current shell run source $HOME/.cargo/env

    Is Rust up to date?

      - Rust updates very frequently. If you have installed Rustup some time ago, chances are your Rust version is out of date. Get the latest version of Rust by running rustup update.

  - [Install Rust \- Rust Programming Language](https://www.rust-lang.org/tools/install) #ril

## 參考資料 {: #reference }

  - [Rust Programming Language](https://www.rust-lang.org/)
  - [The Rust Programming Language - GitHub](https://github.com/rust-lang)
  - [Rust Playground](https://play.rust-lang.org/)

社群：

  - [Forum](https://users.rust-lang.org/)
  - [Rust Language (@rustlang) | Twitter](https://twitter.com/rustlang)
  - [Rust - YouTube](https://www.youtube.com/channel/UCaYhcUwRBNscFNUKTjgPFiA)

文件：

  - [Learn Rust](https://www.rust-lang.org/learn)

更多：

  - [Packaging](rust-packaging.md)
