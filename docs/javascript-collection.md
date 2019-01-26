---
title: JavaScript / Collection
---
# [JavaScript](javascript.md) / Collection

## Array ??

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

## Map ??

  - [Map \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map) #ril
  - [WeakMap \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakMap) #ril

## Set ??

  - [Set \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Set) #ril
  - [WeakSet \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakSet) #ril

