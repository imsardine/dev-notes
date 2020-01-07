---
title: Programming / Function
---
# [Programming](prog.md) / Function

## 不要回傳特殊值 (-1, null) ??

  - 如果沒有結果是合理的，可以用 null object 取代 `null` 讓 client code 不用做 `null` 的判斷；但如果是異常，就該丟出 exception，而不是傳回 `null` 做為特殊值，要 client code 去判斷。

參考資料：

  - [Application Facades - Martin Fowler](https://www.martinfowler.com/apsupp/appfacades.pdf) 回傳 `null` 時，可以用 null object 取代

      - HANDING BACK NULL IS ACTUALLY RATHER AWKWARD. ... And I have to do this everywhere I use `Patient.phenomenonOf()` ... but also because it tends to be very error prone. Fortunately there is a savior — the Null Object pattern 這樣 `gender()` 就可以直接寫成 `return _subject.phenomenonOf("gender").name();`，即便 `phenomenonOf()` 得到 `null` (其實是 `NullPhenomenon`)，結果也是 `""`。
      - The nice thing about this is that no client of `Patient.phenomenonOf()` is even aware that a null phenomenon class exists. THE CLASS IS NOT DECLARED PUBLIC AND IS INVISIBLE TO THE CLIENT PROGRAMS. There are cases when we might need to see if we have a null phenomenon, we can do this by adding a `isNull()` method to phenomenon. 有需要時再增加 `isNull()` 的判斷；關鍵在 client code 不知道 null object 的存在!!
      - Using null objects can do a lot to SIMPLIFY CODE, use it whenever you are [standing on your head (輕而易舉)](https://kknews.cc/education/b435n3j.html) with your arms crossed trying to deal with null responses to questions.

  - [Replace Error Code with Exception](https://refactoring.guru/replace-error-code-with-exception)

    Why Refactor

      - Returning error codes is an OBSOLETE HOLDOVER from PROCEDURAL PROGRAMMING. In modern programming, error handling is performed by special classes, which are named exceptions. If a problem occurs, you “throw” an error, which is then “caught” by one of the exception handlers. Special error-handling code, which is ignored in normal conditions, is activated to respond.

    Benefits

      - Frees code from a large number of CONDITIONALS for checking various error codes. Exception handlers are a much more SUCCINCT way to differentiate normal execution paths from abnormal ones.
      - Exception classes can implement their own methods, thus containing part of the error handling functionality (such as for sending error messages).
      - Unlike exceptions, error codes can’t be used in a constructor, since a constructor must return only a new object. ??

    Drawbacks

      - An exception handler can turn into a goto-like crutch. Avoid this! Don’t use exceptions to manage code execution. Exceptions should be thrown only to inform of an error or critical situation.

        這是誤用，也不是 exception 的缺點。

  - [Exceptions for special results - Reading 6, Part 2: Exceptions](https://web.mit.edu/6.005/www/fa15/classes/06-specifications/exceptions/)

      - Exceptions are not just for signaling bugs. They can be used to improve the structure of code that involves PROCEDURES WITH SPECIAL RESULTS.

        An UNFORTUNATELY COMMON way to handle special results is to return special values. Lookup operations in the Java library are often designed like this: you get an index of `-1` when expecting a positive integer, or a `null` reference when expecting an object. This approach is OK if used SPARINGLY, but it has two problems. First, it’s TEDIOUS TO CHECK the return value. Second, it’s EASY TO FORGET to do it. (We’ll see that by using exceptions you can get help from the compiler in this.)

      - Also, it’s not always easy to find a ‘special value’. Suppose we have a `BirthdayBook` class with a lookup method. Here’s one possible method signature:

            class BirthdayBook {
                LocalDate lookup(String name) { ... }
            }

        (`LocalDate` is part of the Java API.)

        What should the method do if the birthday book doesn’t have an entry for the person whose name is given? Well, we could return some special date that is not going to be used as a real date. BAD PROGRAMMERS have been doing this for decades; they would return `9/9/99`, for example, since it was obvious that no program written in 1960 would still be running at the end of the century. (They were wrong, by the way.)

      - Here’s a better approach. The method throws an exception:

            LocalDate lookup(String name) throws NotFoundException {
                ...
                if ( ...not found... )
                    throw new NotFoundException();
                ...

        and the caller handles the exception with a `catch` clause. For example:

            BirthdayBook birthdays = ...
            try {
                LocalDate birthdate = birthdays.lookup("Alyssa");
                // we know Alyssa's birthday
            } catch (NotFoundException nfe) {
                // her birthday was not in the birthday book
            }

        Now there’s no need for any special value, nor the checking associated with it.

## Argument Checking, Guard, Design by Contract ??

  - [When Do You Check For Bad Arguments](http://wiki.c2.com/?WhenDoYouCheckForBadArguments) #ril
  - [Java Practices\->Validate method arguments](http://www.javapractices.com/topic/TopicAction.do?Id=5)
      - The first lines of a method are usually devoted to checking the validity of method arguments. The idea is to FAIL AS QUICKLY AS POSSIBLE in the event of an error. This is particularly important for constructors. 第 1 行通常是在檢查 arguments 是否合法，背後的考量正是 fail fast；這對 constructor 尤其重要，因為成為 object 的 state 後，之後出錯就很難追到根源。
      - 只要 javadoc 有要求到的部份就要做檢查, 不論內部是用 exception 還是 assertion. (用 assertion 來做 argument checking 時, context 的部份不用刻意輸出 argument name, 內部開發人員只要透過 statck trace 就可以找到問題點, 多輸出那個 argument name 只是增加 class 檔的大小, 後續維護起來也麻煩...) 基本上 `assert` 的使用是 "有會更好", 而 `IllegalArgumentException` 的使用則是 "非要不可". 上述 "The idea is to fail as quickly as possible in the event of an error" 的說法, 其中的 "as possible" 意謂著 "先檢查再做" 是比較好的 (至少它可以將檢查參數的程式碼與真正的運算拆成前後兩段, 提高了程式碼的可讀性), 但絕非必要. 因為有些時候, 若檢查的成本很高 (通常是取得受測資料的動作), 就應該退而採用 "邊做邊檢查" 的策略, 尤其是在沒有發生錯誤的狀況下, 將付出兩倍的運算成本...
      - It's a reasonable policy for a class to skip validating arguments of private methods. The reason is that private methods can only be called from the class itself. Thus, a class AUTHOR SHOULD BE ABLE TO CONFIRM THAT ALL CALLS OF A PRIVATE METHOD ARE VALID. If desired, the assert keyword can be used to verify private method arguments, to check the internal consistency of the class. 只有內部才會用到的 method 可以不做 checking，但如果要做可以用 assertion。反之，public method 的 checking 不建議用 assert，因為 assertion 可能被停用；期間也提到 design by contract。
      - 檢查到不合法的 argument 時，通常會丟出 unchecked exception -- `IllegalArgumentException`、`NullPointerException` 或 `IllegalStateException`。
      - Checked exceptions can also be thrown, as shown in the Model Object validation topic. ... 不太懂，說是 "//www.refactoring.com/catalog/replaceNestedConditionalWithGuardClauses.html"，但呼叫的人自然會避開這個問題不是?
      - Providing a class for such validations can often be useful. 這裡提出 `Args`，提供 `checkForContent()`、`checkForRange()`、`checkForPositive()`、`checkForMatch()` 等。
  - [Application Facades - Martin Fowler](https://www.martinfowler.com/apsupp/appfacades.pdf) Updating through the facade 提到 We throw a runtime exception here, rather than a matched exception, because we DON’T REALLY EXPECT AN ILLEGAL UPDATE VALUE. Any window using this interface should really restrict the choices to the four legal values we give. In Design By Contract [Meyer] terms the fact that `newValue` is one of the four is really part of the PRE-CONDITION of `levelOfConsciousness(String)`, and thus it is NOT THE RESPONSIBILITY OF `levelOfConsciousness` TO DO ANY CHECKING. Thus callers of `levelOfConsciousness` should not expect any checking. 本來就應該傳對，不過這個例子還是檢查並丟出 `IllegalArgumentException`，可能跟 The reality is that I’m still undecided about how to handle pre-conditions in Java. 有關，但當時的 Java 沒有 assertion 可以做這件事嗎?
  - [Java Practices\->Assert is for private arguments only](http://www.javapractices.com/topic/TopicAction.do?Id=100) #ril
  - [Validate \(Apache Commons Lang 3\.8 API\)](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/Validate.html) #ril
  - [1\.18\. Validation of Method Parameters \- Jakarta Commons Cookbook \[Book\]](https://www.safaribooksonline.com/library/view/jakarta-commons-cookbook/059600706X/ch01s19.html) #ril
  - [Fail\-Fast with Argument Checks \- Blog \- Wiki](https://www.smartics.eu/confluence/display/BLOG/2013/03/03/Fail-Fast+with+Argument+Checks) (2013-03-03) #ril
  - [PreconditionsExplained · google/guava Wiki](https://github.com/google/guava/wiki/PreconditionsExplained) #ril
  - [java \- What's the point of Guava checkNotNull \- Stack Overflow](https://stackoverflow.com/questions/26184322/) 有人提到 fail fast #ril

## 只應有一個 return ??

  - [Multiple Return Statements \- blog@CodeFX](https://blog.codefx.org/techniques/multiple-return-statements/) (2014-12-03) #ril
  - [language agnostic \- Should a function have only one return statement? \- Stack Overflow](https://stackoverflow.com/questions/36707/) guard clauses 是個例外? #ril
  - [Replace Nested Conditional with Guard Clauses](https://www.refactoring.com/catalog/replaceNestedConditionalWithGuardClauses.html) (1999-10-09) #ril

## 內部不該修改傳入的 Argument ??

  - Output paramter 本身沒有問題，問題在於若是從外面傳進來，可不可以改？如果改了，就是有 side effect (不是絕對的不好)。
  - 通常是這樣的沒錯，但如果 naming 有指出會變動 arguments，情況會好一點。

參考資料：

  - [java \- Is modifying an incoming parameter an antipattern? \- Software Engineering Stack Exchange](https://softwareengineering.stackexchange.com/questions/245767/) CsBalazsHungary: 修改 incoming parameter -- `MyObject2OtherObject(MyObject mo, OtherObject oo)` 是個 anti-pattern 嗎?
      - Blrfl: 這跟語言有關，若是 pass-by-value，改了也沒用。
      - Keen: 看似是過早的優化 (premature optimization)，大部份時候都建議第一種方式，除非是為了解 performance bottleneck (加註解說明)。
      - Tulains Córdova：這不是 anti-pattern，而是 bad practice -- vestigial or pre-OOP times。引用了 Uncle Bob's Clean Code 的說法 "In the days before object oriented programming it was sometimes necessary to have output arguments. However, much of the need for output arguments disappears in OO languages"。 => 話說回來，好像不是 output argument 的問題，因為 C# 支持 `ref`/`out` parameters，問題還是別人傳進來的可不可以改。
      - user470365: 第 2 種做法比較快，在 game programming 可能會用到。不過 CsBalazsHungary 認為 bottleneck 通常是演算法沒有效率，跟 object 的 clone/creation 無關。
      - claasz: 引用 Clean Code 的說法 "Output arguments should be avoided Functions should have a small numbers of arguments"。不過 CsBalazsHungary 懷疑這只是 strong suggestion 而非 strict law。Daenyth 更直接說不管 Clean Code 的說法多正確，這裡都應該要說明為什麼要避免 (reasoning)。
      - Euphoric: 兩種寫法各有其用途 Code smell would be preferring one over another 這說法很有意思。
  - [code smell \- Passing an object into a method which changes the object, is it a common \(anti\-\) pattern? \- Software Engineering Stack Exchange](https://softwareengineering.stackexchange.com/questions/208828/) #ril
      - Michiel van Oosterhout: 如果 method naming 沒取好，必須要看實作細節才知道 object state 會不會被變更 -- It makes code comprehension more complex, since I need to track multiple levels of the call-stack.
      - Dave Hillier: 這是一種 side effect。
      - Telastyn: it makes it hard to reason about what is going on, the object is not responsible for its own state/implementation (breaking encapsulation). I would also add that all of those state changes are implicit contracts of the method, making that method fragile in the face of changing requirements.
  - [Side effect \(computer science\) \- Wikipedia](https://en.wikipedia.org/wiki/Side_effect_(computer_science)) 有 side effect 是指 function/expression 會變更 local environment 以外的 state，這也包括 "modifying an argument passed by reference"，它的問題在於 "a program's behaviour may depend on history; that is, the order of evaluation matters."

## 參數太多 ??

  - [python \- Class with too many parameters: better design strategy? \- Stack Overflow](https://stackoverflow.com/questions/5899185/) 好像都推薦用 dict + `**kwargs` #ril
  - [language agnostic \- When a method has too many parameters? \- Stack Overflow](https://stackoverflow.com/questions/2244860/) #ril
  - [What is the best practice for \_\_init\_\_ with many arguments? : learnpython](https://www.reddit.com/r/learnpython/comments/1oknkx/what_is_the_best_practice_for_init_with_many/) #ril
  - [Are there guidelines on how many parameters a function should accept? \- Software Engineering Stack Exchange](https://softwareengineering.stackexchange.com/questions/145055/) #ril

