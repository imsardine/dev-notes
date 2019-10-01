---
title: C / Pointer
---
# [C](c.md) / Pointer

## 新手上路 {: #getting-started }

  - [C Pointers: A Complete Beginner's Guide \- Programiz](https://www.programiz.com/c-programming/c-pointers)

      - Pointers are powerful features of C and (C++) programming that differentiates it from other popular programming languages like Java and Python.

        Pointers are used in C program to access the memory and MANIPULATE THE ADDRESS.

    Address in C

      - Before you get into the concept of pointers, let's first get familiar with address in C.

        If you have a variable `var` in your program, `&var` will give you its ADDRESS in the memory, where `&` is commonly called the REFERENCE OPERATOR.

        可以將 `&` 取得的 address 視為 reference；反過來要取得 referece 背後的值則稱做 dereference。

      - You must have seen this notation while using `scanf()` function.

            scanf("%d", &var);

        It was used in the function to store the user inputted value in the address of `var`.

            #include <stdio.h>
            int main()
            {
              int var = 5;
              printf("Value: %d\n", var);
              printf("Address: %u", &var);  //Notice, the ampersand(&) before var.
              return 0;
            }

        Output

            Value: 5
            Address: 2686778

        Note: You may obtain different value of address while using this code.

        In above source code, value 5 is stored in the memory location 2686778. `var` is JUST THE NAME GIVEN TO THAT LOCATION.

    Pointer variables

      - In C, you can create a special variable that STORES THE ADDRESS (rather than the value). This variable is called POINTER VARIABLE or simply a pointer.

      - How to create a pointer variable?

            data_type* pointer_variable_name;
            int* p;

        Above statement defines, `p` as pointer variable of type `int`.

        注意 "pointer variable of type XXX" 的說法；雖然 pointer variable 裡面存的都是 address，但該 address 可以指向不同的型態。

    Reference operator (&) and Dereference operator (*)

      - As discussed, `&` is called reference operator. It gives you the address of a variable.

        Likewise, there is another operator that gets you the value from the address, it is called a DEREFERENCE OPERATOR `*`.

        面對一般的 variable 時，透過 variable name 讀寫的是它的 value，要搭配 `&` 才能拿到 address；面對 pointer variable 時，透過 varialbe name 讀寫也是它的 value，不過此時 value 是指向它處的 address (因 pointer variable 自己的 address 不同)，要搭配 `*` 才能取到存放在它處 address 的值。

            #include <stdio.h>

            int main() {
              int val;
              int *addr;
              int **addr2;

              val = 2;
              addr = &val;
              addr2 = &addr;

              printf("&val = %u\n", &val);
              printf("val = %u\n", val);
              printf("&addr = %u\n", &addr);
              printf("addr = %u\n", addr);
              printf("*addr = %u\n", *addr);
              printf("addr2 = %u\n", addr2);
              printf("**addr2 = %u\n", **addr2);
            }

        輸出：

            &val = 3806188364  # 在 3806188364 有個放得進 int 的空間
            val = 2            # 取出 3806188364 這空間裡的值
            &addr = 3806188352 # 在 3806188352 有個放得進 adderess 的空間，裡面放著 3806188364
            addr = 3806188364  # 取出 3806188352 這空間裡的值 (一個 address)
            *addr = 2          # 取出 3806188352 --> 3806188364 這空間裡的值
            addr2 = 3806188352
            **addr2 = 2        # 取出 &addr2 --> 3806188352 --> 3806188364 這空間裡的值

      - Below example clearly demonstrates the use of pointers, reference operator and dereference operator.

        Note: The `*` sign when declaring a pointer is not a dereference operator. It is just a similar notation that creates a pointer.

            #include <stdio.h>
            int main()
            {
               int* pc, c;

               c = 22;
               printf("Address of c: %u\n", &c);
               printf("Value of c: %d\n\n", c);

               pc = &c;
               printf("Address of pointer pc: %u\n", pc);
               printf("Content of pointer pc: %d\n\n", *pc);

               c = 11;
               printf("Address of pointer pc: %u\n", pc);
               printf("Content of pointer pc: %d\n\n", *pc);

               *pc = 2;
               printf("Address of c: %u\n", &c);
               printf("Value of c: %d\n\n", c);
               return 0;
            }

        Output

            Address of c: 2686784
            Value of c: 22

            Address of pointer pc: 2686784
            Content of pointer pc: 22

            Address of pointer pc: 2686784
            Content of pointer pc: 11

            Address of c: 2686784
            Value of c: 2

        Explanation of the program

         1. `int* pc, c;`

            ![A pointer variable and a normal variable is created.](https://cdn.programiz.com/sites/tutorial2program/files/pointer-1.jpg)

            Here, a pointer `pc` and a NORMAL VARIABLE `c`, both of type `int`, is created.

            Since `pc` and `c` are not initialized at first, pointer `pc` points to either no address or a RANDOM ADDRESS. And, variable `c` HAS AN ADDRESS BUT CONTAINS A RANDOM GARBAGE VALUE.

         2. `c = 22;`

            ![22 is assigned to variable c.](https://cdn.programiz.com/sites/tutorial2program/files/pointer-2.jpg)

            This assigns 22 to the variable `c`, i.e., 22 is stored in the memory location of variable `c`.

            Note that, when printing `&c` (address of `c`), we use `%u` rather than `%d` since address is usually expressed as an unsigned integer (always positive).

         3. `pc = &c;`

            ![Address of variable c is assigned to pointer pc.](https://cdn.programiz.com/sites/tutorial2program/files/pointer-3.jpg)

            This assigns the address of variable `c` to the pointer `pc`.

            You see the value of `pc` is same as the address of `c` and the content of `pc` is 22 as well.

         4. `c = 11;`

            ![11 is assigned to variable c.](https://cdn.programiz.com/sites/tutorial2program/files/pointer-4.jpg)

            This assigns 11 to variable `c`.

            Since, pointer `pc` points to the same address as `c`, value pointed by pointer `pc` is 11 as well.

         5. `*pc = 2;`

            ![5 is assigned to pointer variable's address.](https://cdn.programiz.com/sites/tutorial2program/files/pointer-5.jpg)

            This change the value at the memory location pointed by pointer `pc` to 2.

            Since the address of the pointer `pc` is same as the address of `c`, value of `c` is also changed to 2.

    Common mistakes when working with pointers

      - Suppose, you want pointer `pc` to point to the address of `c`. Then,

            int c, *pc; // 等同於 int* pc, c 的寫法 (1)

            // Wrong! pc is address whereas,
            // c is not an address.
            pc = c;

            // Wrong! *pc is the value pointed by address whereas,
            // &c is an address.
            *pc = &c;                          // (2)

            // Correct! pc is an address and,
            // &c is also an address.
            pc = &c;                          // (2)

            // Correct! *pc is the value pointed by address and,
            // c is also a value (not address).
            *pc = c;                         // (2)

         1. 雖然上面語法的定義是 `data_type* pointer_variable_name;`，但從 `int c, *pc` 的用法看來，星號往 variable name 靠 (`data_type *pointer_variable_name`) 的寫法比較對，否則 `int* pc, c` 很容易被解讀成 `pc` 跟 `c` 都是 pointer variable，但事實上是 `int *pc, c`，只有 `pc` 才是 pointer。

         2. 也就是 assignment 的兩側要一致 -- value 或 address，其中 value 可以是 normal variable 或是 pointer variable + dereference (`*`)，而 address 可以是 pointer variable 或 normal variable + reference (`&`)

  - [Pointers in C and C\+\+ \| Set 1 \(Introduction, Arithmetic and Array\) \- GeeksforGeeks](https://www.geeksforgeeks.org/pointers-in-c-and-c-set-1-introduction-arithmetic-and-array/) #ril

  - [Pointers in C](https://www.tutorialspoint.com/cprogramming/c_pointers.htm) #ril

### NULL ??

  - [NULL pointer in C \- GeeksforGeeks](https://www.geeksforgeeks.org/few-bytes-on-null-pointer-in-c/) #ril
  - [c \- What is the difference between NULL, '\\0' and 0 \- Stack Overflow](https://stackoverflow.com/questions/1296843/) #ril
  - [NULL \- cppreference\.com](https://en.cppreference.com/w/cpp/types/NULL) 其實是個 macro? #ril
  - [C - Null pointer \- Wikipedia](https://en.wikipedia.org/wiki/Null_pointer#C) #ril
  - [The Difference Between NULL and Zero \| C For Dummies Blog](https://c-for-dummies.com/blog/?p=177) (2013-07-27) #ril
  - [In C, why is NULL and 0 triggering an if statement \- Software Engineering Stack Exchange](https://softwareengineering.stackexchange.com/questions/321798/) #ril
