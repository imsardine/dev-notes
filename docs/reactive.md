# Reactive Programming

## 參考資料 {: #reference }

  - [Reactive programming \- Wikipedia](https://en.wikipedia.org/wiki/Reactive_programming) #ril

      - In computing, reactive programming is a DECLARATIVE programming paradigm concerned with DATA STREAMS and the PROPAGATION OF CHANGE.

        With this paradigm it is possible to express static (e.g., arrays) or dynamic (e.g., event emitters) data streams with ease, and also communicate that an INFERRED DEPENDENCY ?? within the associated EXECUTION MODEL ?? exists, which facilitates the AUTOMATIC PROPAGATION of the changed data flow.

      - For example, in an imperative programming setting, `a:=b+c` would mean that `a` is being assigned the result of `b+c` in the instant the expression is evaluated, and later, the values of `b` and `c` can be changed with no effect on the value of `a`.

        On the other hand, in reactive programming, the value of `a` is automatically updated whenever the values of `b` or `c` change, without the program having to re-execute the statement `a:=b+c` to determine the presently assigned value of `a`.

        宣告關係式，`a` 就會自動維持 `b+c` 的結果。

      - Reactive programming has been proposed as a way to simplify the creation of INTERACTIVE USER INTERFACES and near-real-time system animation.

        For example, in a model–view–controller (MVC) architecture, reactive programming can facilitate changes in an underlying model that are reflected automatically in an associated view.

  - [5 Things to Know About Reactive Programming \- Red Hat Developer](https://developers.redhat.com/blog/2017/06/30/5-things-to-know-about-reactive-programming/) (2017-06-30) #ril

      - Reactive, what an overloaded word. Many things turn out to become magically Reactive these days. In this post, we are going to talk about Reactive Programming, i.e. a development model structured around ASYNCHRONOUS DATA STREAMS.

      - I know you are impatient to write your first reactive application, but before doing it, there are a couple of things to know. Using reactive programming changes how you design and write your code. Before jumping on the train, it’s good to know where you are heading.

        In this post, we are going to explain 5 things about reactive programming to see what it changes for you.

    1. Reactive Programming is programming with asynchronous data streams.

      - When using reactive programming, data streams are going to be the SPINE of your application. Events, messages, calls, and even failures are going to be conveyed by a data stream. With reactive programming, you OBSERVE these streams and REACT when a value is emitted.

      - So, in your code, you are going to create data streams of anything and from anything: click events, HTTP requests, ingested messages, availability notifications, changes on a variable, cache events, measures from a sensor, literally ANYTHING THAT MAY CHANGE OR HAPPEN. This has an interesting side-effect on your application: it’s becoming INHERENTLY ASYNCHRONOUS.

        ![](https://developers.redhat.com/blog/wp-content/uploads/2017/06/reactive-programming.png)

        圖中 "Retrieve something from server" 指的是什麼??

      - Reactive eXtension (http://reactivex.io, a.ka. RX) is an IMPLEMENTATION of the reactive programming principles to “compose asynchronous and event-based programs by using observable sequence”.

        With RX, your code creates and subscribes to data streams named OBSERVABLES. While Reactive Programming is about the CONCEPTS, RX provides you an amazing toolbox.

        By combining the OBSERVER and ITERATOR PATTERNS and FUNCTIONAL IDIOMS, RX gives you superpowers. You have an arsenal of functions to combine, merge, filter, transform and create the data streams. The next picture illustrates the usage of RX in Java (using https://github.com/ReactiveX/RxJava).

        ![](https://developers.redhat.com/blog/wp-content/uploads/2017/06/rx.png)

        While RX is not the only implementation of the reactive programming principles (for instance we can cite BaconJS – http://baconjs.github.io), it’s the most commonly used Today. In the rest of this post, we are going to use Rx Java.

  - [Reactive programming, DAMN\. It is not about ReactJS](https://samueleresca.net/reactive-programming-damn-it-is-not-about-reactjs/) (2017-06-17) #ril

      - This article is about Reactive programming, a lot of topics inside the article are language independent and pattern oriented. The article is NOT about ReactJS.

        事實上，ReactJS 跟 reactive programming 一點關係都沒有??

## 跟 React 的關係 {: #and-react }

  - [Reactive Programming for React Developers \- the Absolute Beginner Guide \- DEV Community](https://dev.to/petyosi/reactive-programming-for-react-developers-the-absolute-beginner-guide-5eeg) (2019-05-31) #ril
  - [Reactive Programming for React Developers Part 2 \- Integrate with React \- DEV Community](https://dev.to/petyosi/reactive-programming-for-react-developers-part-2-integrate-with-react-5883) (2019-06-03) #ril
  - [React \+ RxJs = Reactive programming in React \- Vytautas Pranskunas \- Medium](https://medium.com/@vpranskunas/react-rxjs-reactive-programming-in-react-f122dfb3ca47) (2019-04-15) #ril
  - [How to make your React app fully functional, fully reactive, and able to handle all those crazy…](https://www.freecodecamp.org/news/e5da8e7dac10) (2017-03-02) #ril

## 參考資料 {: #reference }

  - [ReactiveX](reactivex.md)
