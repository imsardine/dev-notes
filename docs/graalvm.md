# GraalVM

  - [GraalVM](https://www.graalvm.org/) #ril

    High-performance polyglot VM

      - GraalVM is a universal virtual machine for running applications written in JavaScript, Python, Ruby, R, JVM-based languages like Java, Scala, Groovy, Kotlin, Clojure, and LLVM-based languages such as C and C++.

        GraalVM removes the isolation between programming languages and enables interoperability in a SHARED RUNTIME.

        不只是 JVM-based language，而且不同語言間可以在同一個 runtime 裡交互作用!! 這裡對 Python 的支援並不是 Jython，而是 [graalvm/graalpython](https://github.com/graalvm/graalpython)。

      - It can run either standalone or in the context of OpenJDK, Node.js or Oracle Database.

        "in the context" 是指內嵌在其他環境下 (embeddable)；已經有人寫好一些環境的介接 ...

    What does GraalVM do?

      - Polyglot

        ZERO OVERHEAD interoperability between programming languages allows you to write polyglot applications and select the best language for your task.

            const express = require('express');
            const app = express();
            app.listen(3000);
            app.get('/', function(req, res) {
              var text = 'Hello World!';
              const BigInteger = Java.type(
                'java.math.BigInteger');
              text += BigInteger.valueOf(2)
                .pow(100).toString(16);
              text += Polyglot.eval(
                'R', 'runif(100)')[0];
              res.send(text);
            })

      - Native

        NATIVE IMAGES compiled with GraalVM ahead-of-time improve the startup time and reduce the memory footprint of JVM-based applications.

            $ javac HelloWorld.java
            $ time java HelloWorld
            user 0.070s
            $ native-image HelloWorld
            $ time ./helloworld
            user 0.005s

      - Embeddable

        GraalVM can be embedded in both MANAGED and native applications. There are existing INTEGRATIONS into OpenJDK, Node.js and Oracle Database.

            import org.graalvm.polyglot.*;
            public class HelloPolyglot {
              public static void main(String[] args) {
                System.out.println("Hello Java!");
                Context context = Context.create();
                context.eval("js",
                  "print('Hello JavaScript!');");
              }
            }

  - [GraalVM \- Wikipedia](https://en.wikipedia.org/wiki/GraalVM) #ril

## 參考資料 {: #reference }

  - [GraalVM](https://www.graalvm.org/)
  - [oracle/graal - GitHub](https://github.com/oracle/graal)
