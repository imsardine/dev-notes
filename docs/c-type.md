---
title: C / Data Type
---
# [C](c.md) / Data Type

## Boolean

  - [C, C++, Objective-C, AWK - Boolean data type \- Wikipedia](https://en.wikipedia.org/wiki/Boolean_data_type#C,_C++,_Objective-C,_AWK)

      - C 最早在 1972 年的實作並未提供 boolean type，當時普遍的做法是用 `int` 來表示 -- comparison operator (`>`、`==` 等) 會傳回 `0` (false) 或 `1` (true)，還有 logical operator (`&&`、`||`、`!` 等)、condition-testing statement (`if`、`while` 等) 會將 0 視為 false，其餘 non-zero 都視為 true。
      - ANSI C (1989) 推出後，開始有人用 `enum` 來定義自己的 boolean type 以提昇程式碼的可讀性，但 enum 實質上等同於 integer。
      - 直到 C99 提供標準的 boolean type -- `_Bool`，只要引用 `stdbool.h` 就可以用 `bool`、`true`、`false`，它保證任何兩個 true value 等同?? (這在過去是辦不到的)。不過 boolean 還是可以當 integer 用，也就是 "boolean values are just integers" 的概念在不同版本的 C 都通用。

  - [Using boolean values in C \- Stack Overflow](https://stackoverflow.com/questions/1921539/) #ril

      - neuromancer: C 沒有 built-in boolean type，要怎麼在 C 裡實現? AraK: 至少在最新的標準裡有。
      - Andreas Bonini: 有 4 種選擇，基本上 Option 1 ~ 3 等效，但作者偏好 Option 2 & 3，因為沒用到 `#define`。

          - Option 1 - `typedef int bool;` 搭配 `#define true 1` 與 `#define false 0`。
          - Option 2 - `typedef int bool;` 搭配 `enum { false, true };` (內部數值由 0 起算?)
          - Option 3 - `typedef enum { false, true } bool;` 不知道怎麼選就用這個
          - Option 4 - `#include <stdbool.h>` C99 才標準化，如果條件允許就用這個。

      - Dale Hagglund: `!0` 的結果並不是 1，不過重點是 `0` 是唯一的 false，其他 non-zero 都是 true，所以直接比較 true/false 有點危險。

  - [Boolean type - C data types \- Wikipedia](https://en.wikipedia.org/wiki/C_data_types#stdbool.h) #ril

## 參考資料 {: #reference }

