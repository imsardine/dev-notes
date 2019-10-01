---
title: JavaScript / Object-Oriented Programming
---
# [JavaScript](javascript.md) / Object-Oriented Programming

  - [Object literals - Grammar and types \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Grammar_and_Types#Object_literals)

      - An object literal is a list of ZERO or more pairs of property names and associated values of an object, enclosed in curly braces (`{}`).

        不過這只會形成一個資料包，沒有行為 ??

        Do not use an object literal at the beginning of a statement. This will lead to an error or not behave as you expect, because the `{` will be interpreted as the beginning of a block.

      - The following is an example of an object literal. The first element of the `car` object defines a property, `myCar`, and assigns to it a new string, `"Saturn"`; the second element, the `getCar` property, is immediately assigned the result of invoking the function (`carTypes("Honda")`); the third element, the special property, uses an existing variable (`sales`).

            var sales = 'Toyota';

            function carTypes(name) {
              if (name === 'Honda') {
                return name;
              } else {
                return "Sorry, we don't sell " + name + ".";
              }
            }

            var car = { myCar: 'Saturn', getCar: carTypes('Honda'), special: sales };

            console.log(car.myCar);   // Saturn
            console.log(car.getCar);  // Honda
            console.log(car.special); // Toyota

      - Additionally, you can use a NUMERIC or string literal for the name of a property or nest an object inside another. The following example uses these options.

            var car = { manyCars: {a: 'Saab', b: 'Jeep'}, 7: 'Mazda' };

            console.log(car.manyCars.b); // Jeep
            console.log(car[7]); // Mazda

        最後 `car[7]` 的用法看似 array，但其實是取 object 下名為 `7` 的 property。

      - Object property names can be ANY STRING, including the EMPTY STRING. If the property name would not be a valid JavaScript identifier or number, it must be enclosed in quotes.

        Property name 可以是任何字串，但又可以是數字，這是什麼概念 ??

        Property names that are not valid identifiers also cannot be accessed as a dot (`.`) property, but can be accessed and set with the array-like notation("`[]`").

            var unusualPropertyNames = {
              '': 'An empty string',
              '!': 'Bang!'
            }
            console.log(unusualPropertyNames.'');   // SyntaxError: Unexpected string
            console.log(unusualPropertyNames['']);  // An empty string
            console.log(unusualPropertyNames.!);    // SyntaxError: Unexpected token !
            console.log(unusualPropertyNames['!']); // Bang!

    Enhanced Object literals

      - In ES2015, object literals are extended to support setting the PROTOTYPE at construction, shorthand for `foo: foo` assignments, defining methods, making super calls, and computing property names with expressions.

        Together, these also BRING OBJECT LITERALS AND CLASS DECLARATIONS CLOSER TOGETHER, and allow OBJECT-BASED DESIGN to benefit from some of the same conveniences.

            var obj = {
                // __proto__
                __proto__: theProtoObj,
                // Shorthand for ‘handler: handler’
                handler,
                // Methods
                toString() {
                 // Super calls
                 return 'd ' + super.toString();
                },
                // Computed (dynamic) property names
                [ 'prop_' + (() => 42)() ]: 42
            };

        這裡 object-based 是相對於 proto-based ??

  - [Working with objects \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Working_with_Objects) #ril
  - [Details of the object model \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Details_of_the_Object_Model) #ril
