---
title: JavaScript / Data Structure
---
# [JavaScript](javascript.md) / Data Structure

## Array

  - [Array literals - Grammar and types \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Grammar_and_Types#Array_literals)

      - An array literal is a list of zero or more expressions, each of which represents an array element, enclosed in square brackets (`[]`). When you create an array using an array literal, it is initialized with the specified values as its elements, and its length is set to the number of arguments specified.

      - The following example creates the `coffees` array with three elements and a length of three:

            var coffees = ['French Roast', 'Colombian', 'Kona'];

        Note : An array literal is a type of OBJECT INITIALIZER. See Using Object Initializers.

      - If an array is created using a literal in a TOP-LEVEL SCRIPT, JavaScript interprets the array each time it evaluates the expression containing the array literal. In addition, a literal used in a function is CREATED EACH TIME the function is called.

        什麼時候不會遇到一次就 evaluate 一次 ??

      - Array literals are also `Array` objects. See Array and Indexed collections for details on Array objects.

        另外還有 array-like objects。

    Extra commas in array literals

      - You do not have to specify all elements in an array literal. If you put two commas in a row, the array is created with `undefined` for the unspecified elements. The following example creates the `fish` array:

            var fish = ['Lion', , 'Angel'];

        This array has two elements with values and one EMPTY ELEMENT (`fish[0]` is `"Lion"`, `fish[1]` is `undefined`, and `fish[2]` is `"Angel"`).

      - If you include a trailing comma at the end of the list of elements, the comma is IGNORED. In the following example, the length of the array is three. There is no `myList[3]`. All other commas in the list indicate a new element.

        Note : Trailing commas can create errors in older browser versions and it is a BEST PRACTICE TO REMOVE THEM.

            var myList = ['home', , 'school', ];

      - In the following example, the length of the array is four, and `myList[0]` and `myList[2]` are missing.

            var myList = [ ,'home', , 'school'];

      - In the following example, the length of the array is four, and `myList[1]` and `myList[3]` are missing. Only the last comma is ignored.

            var myList = ['home', , 'school', , ];

      - Understanding the behavior of extra commas is important to understanding JavaScript as a language. However, when writing your own code, explicitly declare the missing elements as `undefined`, as doing this increases your code's CLARITY and MAINTAINABILITY.

  - [Indexed collections \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Indexed_collections) #ril

  - [Array \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array) #ril

      - The JavaScript `Array` object is a global object?? that is used in the construction of arrays; which are high-level, LIST-LIKE objects.
      - Create an Array

            var fruits = ['Apple', 'Banana']; // 字面表示跟 Python 一樣

            console.log(fruits.length); // 長度透過 .length 取出，跟 Java array 一樣
            // 2

      - Access (index into) an Array item

            var first = fruits[0];
            // Apple

            var last = fruits[fruits.length - 1];
            // Banana

      - Loop over an Array

            fruits.forEach(function(item, index, array) {
              console.log(item, index);
            });
            // Apple 0
            // Banana 1

      - Add to the end of an Array

            var newLength = fruits.push('Orange'); // 類 stack 的操作
            // ["Apple", "Banana", "Orange"]

      - Remove from the end of an Array

            var last = fruits.pop(); // remove Orange (from the end)
            // ["Apple", "Banana"];

  - [Indexed collections \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Indexed_collections) #ril

## Map

  - [Map \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map) #ril
  - [WeakMap \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakMap) #ril

## Set

  - [Set \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Set) #ril
  - [WeakSet \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakSet) #ril

## 參考資料 {: #reference }

手冊：

  - [Array | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)
