---
title: C / Library
---
# [C](c.md) / Library

  - [Static and Dynamic Libraries \| Set 1 \- GeeksforGeeks](https://www.geeksforgeeks.org/static-vs-dynamic-libraries/)
      - Compiler 產出 object code 後會調用 linker，而 linker 的工作之一是 make code of library functions (eg `printf()`, `scanf()`, `sqrt()`, ..etc) available to your PROGRAM (可能是 executable 或 library)。
      - A linker can accomplish this task in two ways, by COPYING the code of library function to your object code, or by making some arrangements so that the complete code of library functions is NOT COPIED, but made AVAILABLE AT RUN-TIME
      - 前面的做法稱做 static linking，所用的 library 稱做 static library (Linux 上的 `.a` 或 Windows 上的 `.lib`)，因為 "libraries which are statically linked"，但因為複製 code 的關係所以產出的 binary 會佔比較大的空間，在 disk 或 memory 都一樣。
      - 後者的做法稱做 dynamic linking，所用的 library 稱做 dynamic library (Linux 上的 `.so` 或 Windows 上的 `.dll`)，不用複製 code，只是把 library 的名稱寫在 binary 裡而已，因為 "libraries which are linked at run-time"，真正的 linking 會發生在 runtime -- 當 binary 跟 library 都在 memory 時。
  - [Library \(computing\) \- Wikipedia](https://en.wikipedia.org/wiki/Library_(computing)) #ril
  - [Static and Dynamic Libraries \- Nick Desaulniers](http://nickdesaulniers.github.io/blog/2016/11/20/static-and-dynamic-libraries/) (2016-11-20) #ril

## 基礎

### Hello, World! ??

### 新手上路 ??

### Static Library ??

  - [Static and Dynamic Libraries \| Set 1 \- GeeksforGeeks](https://www.geeksforgeeks.org/static-vs-dynamic-libraries/) 後面都在講 static library 的建置、使用 #ril

### Shared Library ??

  - [Working with Shared Libraries \| Set 1 \- GeeksforGeeks](https://www.geeksforgeeks.org/working-with-shared-libraries-set-1/) #ril
  - [Working with Shared Libraries \| Set 2 \- GeeksforGeeks](https://www.geeksforgeeks.org/working-with-shared-libraries-set-2/) #ril
  - [Dynamic libraries in C: creating something on what the others will rely\.](https://medium.com/@Cu7ious/how-to-use-dynamic-libraries-in-c-46a0f9b98270) (2018-04-17) #ril
  - [Static Libraries vs\. Dynamic Libraries – Stuart Kuredjian – Medium](https://medium.com/@StueyGK/static-libraries-vs-dynamic-libraries-af78f0b5f1e4) (2017-05-15) #ril
