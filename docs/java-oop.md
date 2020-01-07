---
title: Java Programming / OOP (Object-oriented Programming)
---
# [Java Programming](java-prog.md) / OOP (Object-oriented Programming)

## `this` {: #this }

  - [Using the this Keyword \(The Java™ Tutorials > Learning the Java Language > Classes and Objects\)](https://docs.oracle.com/javase/tutorial/java/javaOO/thiskey.html)

      - Within an instance method or a constructor, `this` is a reference to the CURRENT OBJECT — the object whose method or constructor is being called. You can refer to any member of the current object from within an instance method or a constructor by using `this`.

    Using this with a Field

      - The most common reason for using the `this` keyword is because a field is SHADOWED by a method or constructor parameter.

        For example, the Point class was written like this

            public class Point {
                public int x = 0;
                public int y = 0;

                //constructor
                public Point(int a, int b) {
                    x = a;
                    y = b;
                }
            }

        but it could have been written like this:

            public class Point {
                public int x = 0;
                public int y = 0;

                //constructor
                public Point(int x, int y) {
                    this.x = x;
                    this.y = y;
                }
            }

        Each argument to the constructor shadows one of the object's fields — inside the constructor `x` is a local copy of the constructor's first argument. To refer to the `Point` field `x`, the constructor must use `this.x`.

    Using this with a Constructor

      - From within a constructor, you can also use the `this` keyword to call another constructor in the same class. Doing so is called an EXPLICIT CONSTRUCTOR INVOCATION. Here's another `Rectangle` class, with a different implementation from the one in the Objects section.

            public class Rectangle {
                private int x, y;
                private int width, height;

                public Rectangle() {
                    this(0, 0, 1, 1);
                }
                public Rectangle(int width, int height) {
                    this(0, 0, width, height);
                }
                public Rectangle(int x, int y, int width, int height) {
                    this.x = x;
                    this.y = y;
                    this.width = width;
                    this.height = height;
                }
                ...
            }

        This class contains a set of constructors. Each constructor initializes some or all of the rectangle's member variables. The constructors provide a default value for any member variable whose initial value is not provided by an argument.

        For example, the no-argument constructor creates a 1x1 `Rectangle` at coordinates 0,0. The two-argument constructor calls the four-argument constructor, passing in the width and height but always using the 0,0 coordinates. As before, the COMPILER determines which constructor to call, based on the number and the type of arguments.

      - If present, the invocation of another constructor must be the first line in the constructor.

  - [What is the accepted style for using the \`this\` keyword in Java? \- Software Engineering Stack Exchange](https://softwareengineering.stackexchange.com/questions/113430/)

      - Andrea: Is it considered a bad practice to always prepend `this` to the current instance attributes? It feels more natural to me to write ... as it helps me to distinguish instance attributes from local variables.

        Of course in a language like Javascript it makes more sense to always use `this`, since one can have more function nesting, hence local variables coming from larger scopes. In Java, as far as I understand, no nesting like this is possible (except for inner classes), so probably it is not a big issue.

        In any case, I would prefer to use `this`. Would it feel weird and not idiomatic?

      - DeadMG: In most IDEs, you can simply mouseover the variable if you want to know. In addition, really, if you're working in an instance method, you should really know all the variables involved. If you have TOO MANY, or their names clash, then you NEED TO REFACTOR.

        It's really quite redundant.

        好像有道理，但如果不用 IDE 呢?

        Brad Christie: Though I agree, when coming across other developers' code (and while being unfamiliar at first glance) I find this. a lot more helpful. This is also probably because I don't have an IDE that color-codes local/object variables differently.

      - Thomas Owens: I prefer to use `this`. It makes it easier to read code in various editors that color local and instance variables in the same way. It also makes it easier to read the code on a PRINTED PAGE during something like a code review. It's also a fairly strong reminder as to the scope of the variable to other developers.

        However, there are arguments against this. In modern IDEs, you can find out the scope of a variable by hovering over it or viewing it in a tree-like structure. You can also change the color and/or font face of variables depending on their scope (even in such a way that, when printed, it's evident what the scope of the variable is).

        I believe that ChrisF's last sentence is dead on: BE CONSISTENT in your usage.

      - ptyx: One place I consistently use 'this' is setters and or constructors:

            public void setFoo(String foo) {
                this.foo = foo;
            }

        Other than that, I don't feel it is necessary to add it. When reading the body of a method, parameters and locals are right there - and fairly easy to keep track of (even without the IDE help). Also locals and fields tend to be of different nature (object state vs transient storage or parameter).

        If there is any confusion about what's a variable and what's a field, it probably means a method has too many variables/parameters, is too long and too complex, and should be simplified.

        If you choose to use 'this' to TAG fields, I would recommend to make sure the convention is ALWAYS STRICTLY FOLLOWED - it would be really easy to start assuming no 'this' means it's a local and break stuff based on the assumption.

        一致性確實很重要!!

        edit: I also end up using this in equals, clone or anything which has a 'that' parameter of the same object type:

            public boolean isSame(MyClass that) {
                return this.uuid().equals(that.uuid());
            }

        這想法還滿直觀的。

