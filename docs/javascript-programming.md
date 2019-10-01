---
title: JavaScript / Programming
---
# [JavaScript](javascript.md) / Programming

  - [Basics - Grammar and types \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Grammar_and_Types#Basics)

      - JavaScript borrows most of its syntax from Java, C and C++, but is also influenced by Awk, Perl and Python.

        沒想過 Awk、Perl 跟 Python 都影響了 Python，是哪些部份 ??

      - JavaScript is CASE-SENSITIVE and uses the Unicode character set. For example, the word Früh (which means "early" in German) could be used as a variable name.

            var Früh = "foobar";

        But, the variable `früh` is not the same as `Früh` because JavaScript is case sensitive.

        `"foobar"` 本身也是 Unicode，應該比能否用 Unicode 做為變數名稱重要。

      - In JavaScript, instructions are called STATEMENTS and are separated by semicolons (;).

        A semicolon is NOT NECESSARY after a statement if it is written ON ITS OWN LINE. But if more than one statement on a line is desired, then they must be separated by semicolons.

        ECMAScript also has rules for AUTOMATIC INSERTION of semicolons (ASI) to end statements. (For more information, see the detailed reference about JavaScript's lexical grammar.)

        [Automatic semicolon insertion - Lexical grammar \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Lexical_grammar#Automatic_semicolon_insertion):

        > Some JavaScript statements MUST be terminated with semicolons and are therefore affected by automatic semicolon insertion (ASI):

        It is considered BEST PRACTICE, however, to ALWAYS write a semicolon after a statement, even when it is not strictly needed. This practice reduces the chances of bugs getting into the code.

        習慣性在 statement 後加上 `;` 就對了，雖然 ECMAScript 有規範什麼情況下會自動補上 `;`，但建議還是自己來。

      - The source text of JavaScript script gets scanned from left to right and is converted into a sequence of input elements which are tokens, control characters, line terminators, comments, or whitespace. Spaces, tabs, and newline characters are considered whitespace.

  - [Control flow and error handling \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Control_flow_and_error_handling)

      - Any JavaScript expression is ALSO A STATEMENT. See [Expressions and operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Expressions_and_Operators) for complete information about expressions. #ril

  - [A re\-introduction to JavaScript \(JS tutorial\) \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript) #ril

## Comment

  - [Comments - Grammar and types \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Grammar_and_Types#Comments)

      - The syntax of comments is the same as in C++ and in many other languages:

            // a one line comment

            /* this is a longer,
             * multi-line comment
             */

            /* You can't, however, /* nest comments */ SyntaxError */

      - Comments behave like whitespace and are discarded during script execution.

      - Note: You might also see a third type of comment syntax at the start of some JavaScript files, along these lines: `#!/usr/bin/env` node. This is called HASHBANG COMMENT syntax, and is a special comment used to specify the path to a particular JavaScript interpreter that you want to use to execute the script. See Hashbang comments for more details.

        跟 Unix-like 的 shebang line 很像，但稱做 hashbang comment。

  - [Hashbang comments - Lexical grammar \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Lexical_grammar#Hashbang_comments)

      - A specialized third comment syntax, the hashbang comment, is in the process of being standardized in ECMAScript (see the Hashbang Grammar proposal).

        A hashbang comment behaves exactly like a single line-only (`//`) comment, but it instead begins with `#!` and is only valid at the ABSOLUTE START OF A SCRIPT OR MODULE. Note also that no whitespace of any kind is permitted before the `#!`.

        The comment consists of all the characters after `#!` up to the end of the first line; only one such comment is permitted.

      - The hashbang comment specifies the path to a specific JavaScript interpreter that you want to use to execute the script. An example is as follows:

            #!/usr/bin/env node

            console.log("Hello world");

        Note: Hashbang comments in JavaScript mimic SHEBANGS In Unix used to run files with proper interpreter. 硬是要取另一個名字

      - Although BOM before hashbang comment will work in a browser it is not advised to use BOM in a script with hasbang. BOM will not work when you try to run the script in Unix/Linux. So use UTF-8 without BOM if you want to run scripts directly from shell.

      - You must only use the `#!` comment style to specify a JavaScript interpreter. In all other cases just use a `//` comment (or mulitiline comment).

## Variable

  - [Declarations - Grammar and types \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Grammar_and_Types#Declarations)

      - There are three kinds of variable declarations in JavaScript.

          - `var` Declares a variable, optionally initializing it to a value.
          - `let` Declares a block-scoped, local variable, optionally initializing it to a value.
          - `const` Declares a block-scoped, read-only named constant.

        那 `var` 的 scope 是? 在 ES6 引入 `let`/`const` 後還是沒變，在 function 裡宣告是 local，否則就是 global，也就是在 ES6 的 block 裡用 `var` 宣告還是 global。

    Variables

      - You use variables as symbolic names for values in your application. The names of variables, called identifiers, conform to certain rules.

      - A JavaScript identifier must start with a letter, underscore (`_`), or dollar sign (`$`); subsequent characters can also be digits (0-9). Because JavaScript is case sensitive, letters include the characters "A" through "Z" (uppercase) and the characters "a" through "z" (lowercase).

        注意 dollar sign 是合法的變數名稱，最有名的就是 jQuery 的 `$`。

      - You can use most of ISO 8859-1 or Unicode letters such as å and ü in identifiers (for more details see this blog post). You can also use the Unicode escape sequences as characters in identifiers.

        Some examples of legal names are `Number_hits`, `temp99`, `$credit`, and `_name`.

    Declaring variables

      - You can declare a variable in two ways:

          - With the keyword `var`. For example, `var x = 42`. This syntax can be used to declare BOTH local and global variables, depending on the EXECUTION CONTEXT.

          - With the keyword `const` or `let`. For example, `let y = 13`. This syntax can be used to declare a BLOCK-SCOPE LOCAL VARIABLE. See Variable scope below.

        按照下面 Variable scope 的說法 "When you declare a variable outside of any function, it is called a global variable"，`let`/`const` 也可以宣告出 global variable。

      - You can also simply assign a value to a variable For example, `x = 42`. This form creates an UNDECLARED GLOBAL VARIABLE. It also generates a STRICT JAVASCRIPT WARNING. Undeclared global variables can often lead to unexpected behavior. Thus, it is discouraged to use undeclared global variables.

    Evaluating variables

      - A variable declared using the `var` or `let` statement with no assigned value specified has the value of `undefined`.

        `const` 沒這個問題，因為一開始就要給值。

      - An attempt to access an UNDECLARED variable results in a `ReferenceError` exception being thrown:

            var a;
            console.log('The value of a is ' + a); // The value of a is undefined

            console.log('The value of b is ' + b); // The value of b is undefined
            var b;
            // This one may puzzle you until you read 'Variable hoisting' below

            console.log('The value of c is ' + c); // Uncaught ReferenceError: c is not defined

            let x;
            console.log('The value of x is ' + x); // The value of x is undefined

            console.log('The value of y is ' + y); // Uncaught ReferenceError: y is not defined
            let y;

      - You can use `undefined` to determine whether a variable HAS A VALUE. In the following code, the variable `input` is not assigned a value, and the `if` statement evaluates to `true`.

            var input;
            if (input === undefined) {
              doThis();
            } else {
              doThat();
            }

        注意這裡用 `===` (strict equal)，不同於 `==` (equal)，前者會額外比對 type。

      - The `undefined` value behaves as `false` when used in a BOOLEAN CONTEXT. For example, the following code executes the function `myFunction` because the `myArray` element is undefined:

            var myArray = [];
            if (!myArray[0]) myFunction();

      - The `undefined` value converts to `NaN` when used in NUMERIC CONTEXT.

            var a;
            a + 2;  // Evaluates to NaN

      - When you evaluate a `null` variable, the `null` value behaves as `0` in NUMERIC CONTEXTS and as `false` in boolean contexts. For example:

            var n = null;
            console.log(n * 32); // Will log 0 to the console

        注意 `null` 跟 `undefined` 不同，`null` 被視為有值 ??

    Variable scope

      - When you declare a variable OUTSIDE OF ANY FUNCTION, it is called a global variable, because it is available to any other code in the CURRENT DOCUMENT.

        When you declare a variable within a function, it is called a local variable, because it is available only within that function.

      - JavaScript before ECMAScript 2015 does not have block statement scope; rather, a variable declared within a block is LOCAL TO the function (or global scope) that the block resides within. For example the following code will log 5, because the scope of `x` is the global context (or the function if the following codes are part of the function), not the immediate `if` statement block.

            if (true) {
              var x = 5;
            }
            console.log(x);  // x is 5

      - This behavior changes, when using the `let` declaration introduced in ECMAScript 2015.

            if (true) {
              let y = 5;
            }
            console.log(y);  // ReferenceError: y is not defined

        注意 `var` 的行為在支援 ES6 的環境下並沒有改變，只有用 `let`/`const` 在 block 宣告的變數才會是 block-scoped。

    Variable hoisting

      - Another UNUSUAL thing about variables in JavaScript is that you can refer to a variable DECLARED LATER, without getting an exception. This concept is known as HOISTING; variables in JavaScript are in a sense "HOISTED" or LIFTED to the top of the function or statement.

        However, variables that are hoisted return a value of `undefined`. So even if you declare and initialize after you use or refer to this variable, it still returns `undefined`.

            /**
             * Example 1
             */
            console.log(x === undefined); // true
            var x = 3;

            /**
             * Example 2
             */
            // will return a value of undefined
            var myvar = 'my value';

            (function() {
              console.log(myvar); // undefined
              var myvar = 'local value';
            })();

        The above examples will be interpreted the same as:

            /**
             * Example 1
             */
            var x;
            console.log(x === undefined); // true
            x = 3;

            /**
             * Example 2
             */
            var myvar = 'my value';

            (function() {
              var myvar;
              console.log(myvar); // undefined
              myvar = 'local value';
            })();

        也就是宣告會被拉到最上面，但給值還是在原來的位置。

      - Because of hoisting, all `var` statements in a function should be placed as near to the top of the function as possible. This best practice increases the CLARITY of the code.

        In ECMAScript 2015, `let` and `const` are HOISTED BUT NOT INITIALIZED. Referencing the variable in the block before the variable declaration results in a `ReferenceError` because the variable is in a "temporal dead zone" from the start of the block until the declaration is processed.

            console.log(x); // ReferenceError
            let x = 3;

        既然還是會引發 `ReferenceError`，為何 ES6 的 `let`/`const` 也要淌 "hoisted but not initialized" 這個混水 ??

    Function hoisting

      - For functions, only the FUNCTION DECLARATION gets hoisted to the top and NOT THE FUNCTION EXPRESSION.

            /* Function declaration */

            foo(); // "bar"

            function foo() {
              console.log('bar');
            }


            /* Function expression */

            baz(); // TypeError: baz is not a function

            var baz = function() {
              console.log('bar2');
            };

        後者 function expression 的範例，一開始 `baz` 因為 variable hoisting 的關係，它的值是 `undefined`。

    Global variables

      - Global variables are in fact PROPERTIES of the GLOBAL OBJECT. In web pages, the global object is `window`, so you can set and access global variables using the `window.variable` syntax.

      - Consequently, you can access global variables declared in one window or frame from another window or frame by specifying the window or frame name. For example, if a variable called `phoneNumber` is declared in a document, you can refer to this variable from an iframe as `parent.phoneNumber`.

    Constants

      - You can create a read-only, named constant with the `const` keyword. The syntax of a constant identifier is the same as for a variable identifier: it must start with a letter, underscore or dollar sign (`$`) and can contain alphabetic, numeric, or underscore characters.

            const PI = 3.14;

      - A constant cannot change value through assignment or be RE-DECLARED while the script is running. It must be initialized to a value.

      - The scope rules for constants are the same as those for `let` block-scope variables. If the `const` keyword is omitted, the identifier is assumed to represent a variable.

        省略 `const` 不就是 undeclared global variable 了?

      - You cannot declare a constant with the same name as a function or variable in the same scope. For example:

            // THIS WILL CAUSE AN ERROR
            function f() {};
            const f = 5;

            // THIS WILL CAUSE AN ERROR TOO
            function f() {
              const g = 5;
              var g;

              //statements
            }

      - However, the properties of objects assigned to constants are NOT PROTECTED, so the following statement is executed without problems.

            const MY_OBJECT = {'key': 'value'};
            MY_OBJECT.key = 'otherValue';

        Also, the contents of an array are not protected, so the following statement is executed without problems.

            const MY_ARRAY = ['HTML','CSS'];
            MY_ARRAY.push('JAVASCRIPT');
            console.log(MY_ARRAY); //logs ['HTML','CSS','JAVASCRIPT'];

        換句話說，constant 並不等同於 immutable。

  - [Block statement - Control flow and error handling \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Control_flow_and_error_handling#Block_statement)

      - The most basic statement is a BLOCK STATEMENT that is used to group statements. The block is delimited by a pair of curly brackets:

            {
              statement_1;
              statement_2;
              .
              .
              .
              statement_n;
            }

      - Block statements are commonly used with control flow statements (e.g. `if`, `for`, `while`).

            while (x < 10) {
              x++;
            }

        Here, `{ x++; }` is the block statement.

      - Important: JavaScript prior to ECMAScript2015 (6th edition) does not have block scope. Variables introduced within a block are scoped to the containing function or script, and the effects of setting them persist BEYOND the block itself.

        注意 "scoped to the containing function or script" 的說法，就算 `var` 寫在 block 裡，scope 也會歸外層的 function 或 global，因為早期沒有 block scope 的概念；猜想在支援 ES6 (引入 `let` 與 `const`) 的 JavaScript engine 上也會保持相同的行為。

      - In other words, block statements DO NOT DEFINE A SCOPE. "Standalone" blocks in JavaScript can produce completely different results from what they would produce in C or Java. For example:

            var x = 1;
            {
              var x = 2;
            }
            console.log(x); // outputs 2

        實務上會單獨使用 block statement 嗎 ??

        This outputs 2 because the `var x` statement within the block is in the same scope as the `var x` statement before the block. In C or Java, the equivalent code would have outputted 1.

        Starting with ECMAScript2015, the `let` and `const` variable declarations are block scoped. See the `let` and `const` reference pages for more information.

## Global Object

  - [Global object \- MDN Web Docs Glossary: Definitions of Web\-related terms \| MDN](https://developer.mozilla.org/en-US/docs/Glossary/Global_object):

      - A global object is an object that always exists in the global scope. In JavaScript, there's always a global object defined.

      - In a web browser, when scripts create global variables, they're created as members of the global object. (In Node.js this is NOT THE CASE.) The global object's interface depends on the execution context in which the script is running.

          - In a web browser, any code which the script doesn't specifically start up as a background task has a `Window` as its global object. This is the vast majority of JavaScript code on the Web.
          - Code running in a `Worker` has a `WorkerGlobalScope` object as its global object.
          - Scripts running under Node.js have an object called `global` as their global object.

  - [Global Objects \| Node\.js v12\.9\.0 Documentation](https://nodejs.org/api/globals.html#globals_global):

     In browsers, the TOP-LEVEL SCOPE is the GLOBAL SCOPE. This means that within the browser `var something` will define a new global variable. In Node.js this is different. The top-level scope is not the global scope; `var something` inside a Node.js module will be LOCAL TO THAT MODULE.

  - [Standard built\-in objects \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects)

      - The term "global objects" (or standard built-in objects) here is not to be confused with the global object.

        單複數的差別，因為 global object 只有一個，但 "objects in the global scope" 則可以有多個。

      - Here, global objects refer to OBJECTS IN THE GLOBAL SCOPE. The global object itself can be accessed using the `this` operator in the global scope (but only if ECMAScript 5 strict mode is not used; in that case it returns `undefined`).

        In fact, the global scope consists of the properties of the global object, including inherited properties, if any.

## Control Flow

  - [Conditional statements - Control flow and error handling \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Control_flow_and_error_handling#Conditional_statements)

      - A conditional statement is a set of commands that executes if a specified condition is true. JavaScript supports two conditional statements: `if...else` and `switch`.

    `if...else` statement

      - Use the `if` statement to execute a statement if a logical condition is true. Use the optional `else` clause to execute a statement if the condition is false. An if statement looks as follows:

            if (condition) {
              statement_1;
            } else {
              statement_2;
            }

        Here the `condition` can be any expression that evaluates to `true` or `false`. See Boolean for an explanation of what evaluates to `true` and `false`. If condition evaluates to `true`, `statement_1` is executed; otherwise, `statement_2` is executed. `statement_1` and `statement_2` can be any statement, including further nested if statements.

      - You may also compound the statements using `else if` to have multiple conditions tested in sequence, as follows:

            if (condition_1) {
              statement_1;
            } else if (condition_2) {
              statement_2;
            } else if (condition_n) {
              statement_n;
            } else {
              statement_last;
            }

        In the case of multiple conditions only the first logical condition which evaluates to `true` will be executed. To execute multiple statements, group them within a block statement (`{ ... }`) . In general, it's good practice to ALWAYS USE BLOCK STATEMENTS, especially when nesting `if` statements:

            if (condition) {
              statement_1_runs_if_condition_is_true;
              statement_2_runs_if_condition_is_true;
            } else {
              statement_3_runs_if_condition_is_false;
              statement_4_runs_if_condition_is_false;
            }

      - It is advisable to not use SIMPLE ASSIGNMENTS in a conditional expression, because the assignment can be confused with equality when glancing over the code. For example, do not use the following code:

            if (x = y) {
              /* statements here */
            }

        If you need to use an assignment in a conditional expression, a common practice is to put ADDITIONAL PARENTHESES around the assignment. For example:

            if ((x = y)) {
              /* statements here */
            }

        原來 JavaScript 裡的 assignment 是有有傳值的。

      - The following values evaluate to `false` (also known as FALSY VALUES):

            false
            undefined
            null
            0
            NaN
            the empty string ("")

        All other values, including all objects, evaluate to `true` when passed to a conditional statement.

      - Do not confuse the primitive boolean values `true` and `false` with the true and false values of the `Boolean` object. For example:

            var b = new Boolean(false);
            if (b) // this condition evaluates to true
            if (b == true) // this condition evaluates to false

        這也太 tricky 了吧!! 不像 Java 會自動 boxing/unboxing。

      - In the following example, the function `checkData` returns `true` if the number of characters in a `Text` object is three; otherwise, it displays an alert and returns `false`.

            function checkData() {
              if (document.form1.threeChar.value.length == 3) {
                return true;
              } else {
                alert('Enter exactly three characters. ' +
                document.form1.threeChar.value + ' is not valid.');
                return false;
              }
            }

    `switch` statement

      - A `switch` statement allows a program to evaluate an expression and attempt to match the expression's value to a CASE LABEL. If a match is found, the program executes the associated statement. A `switch` statement looks as follows:

            switch (expression) {
              case label_1:
                statements_1
                [break;]
              case label_2:
                statements_2
                [break;]
                ...
              default:
                statements_def
                [break;]
            }

      - The program first looks for a `case` clause with a label matching the value of expression and then transfers control to that clause, executing the associated statements.

        If no matching label is found, the program looks for the optional `default` clause, and if found, transfers control to that clause, executing the associated statements. If no `default` clause is found, the program continues execution at the statement following the end of `switch`. By convention, the `default` clause is the last clause, but it does not need to be so.

      - The optional `break` statement associated with each `case` clause ensures that the program breaks out of `switch` once the matched statement is executed and continues execution at the statement following `switch`. If `break` is omitted, the program continues execution at the next statement in the `switch` statement.

      - In the following example, if `fruittype` evaluates to `"Bananas"`, the program matches the value with case "Bananas" and executes the associated statement. When `break` is encountered, the program terminates `switch` and executes the statement following `switch`. If `break` were omitted, the statement for case "Cherries" would also be executed.

            switch (fruittype) {
              case 'Oranges':
                console.log('Oranges are $0.59 a pound.');
                break;
              case 'Apples':
                console.log('Apples are $0.32 a pound.');
                break;
              case 'Bananas':
                console.log('Bananas are $0.48 a pound.');
                break;
              case 'Cherries':
                console.log('Cherries are $3.00 a pound.');
                break;
              case 'Mangoes':
                console.log('Mangoes are $0.56 a pound.');
                break;
              case 'Papayas':
                console.log('Mangoes and papayas are $2.79 a pound.');
                break;
              default:
               console.log('Sorry, we are out of ' + fruittype + '.');
            }
            console.log("Is there anything else you'd like?");

  - [Loops and iteration \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Loops_and_iteration) #ril

## 參考資料 {: #reference }

更多：

  - [Data Type](javascript-type.md)
  - [Data Structure](javascript-data.md)
  - [Object-Oriented Programming](javascript-oop.md)
  - [Error Handling](javascript-error.md)
