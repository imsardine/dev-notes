---
title: C / Random
---
# [C](c.md) / Random

## Seed ??

  - [c \- srand\(\) — why call it only once? \- Stack Overflow](https://stackoverflow.com/questions/7343833/) #ril

      - Lipika Deka: This question is about a comment in this question [Recommended way to initialize srand?](https://stackoverflow.com/questions/322938) The first comment says that `srand()` should be called only ONCE in an application. Why is it so?

      - Kornelije Petak: That depends on what you are trying to achieve.

        Randomization is performed as a function that has a STARTING VALUE, namely the SEED. So, for the SAME SEED, you will always get the SAME SEQUENCE OF VALUES. If you try to set the seed every time you need a random value, and the seed is the same number, you will always get the same "random" value.

        Seed is usually taken from the CURRENT TIME, which are the SECONDS, as in `time(NULL)`, so if you always set the seed before taking the random number, you will get the same number as long as you call the `srand`/`rand` combo multiple times IN THE SAME SECOND.

        To avoid this problem, `srand` is set only ONCE PER APPLICATION, because it is doubtful that two of the application instances will be initialized in the same second, so each instance will then have a different sequence of random numbers.

        However, there is a slight possibility that you will run your app (especially if it's a short one, or a command line tool or something like that) many times in a second, then you will have to resort to some other way of choosing a seed (unless the same sequence in different application instances is ok by you). But like I said, that depends on your application context of usage.

        Also, you may want to try to increase the precision to MICROSECONDS (minimizing the chance of the same seed), requires (`sys/time.h`):

            struct timeval t1;
            gettimeofday(&t1, NULL);
            srand(t1.tv_usec * t1.tv_sec);

      - achoora: A simpler solution for using `srand()` for generating different seeds for application instances run at the same second is as seen.

            srand(time(NULL)-getpid());

        This method makes your seed very close to random as there is no way to guess at what time your thread started and the pid will be different also.

        利用瞬間兩個 process 的 ID 不會重複的特性。

      - Steve Summit: Short answer: calling `srand()` is not like "rolling the dice" for the random number generator. Nor is it like shuffling a deck of cards. If anything, it's more like just CUTTING A DECK OF CARDS.

        Think of it like this. `rand()` deals from a big deck of cards, and every time you call it, all it does is pick the next card OFF THE TOP OF THE DECK, give you the value, and RETURN THAT CARD TO THE BOTTOM OF THE DECK. (Yes, that means the "random" sequence will REPEAT AFTER A WHILE. It's a very big deck, though: typically 4,294,967,296 cards.)

        很特別的觀點 -- 是拿全新的牌來切。

        Furthermore, every time your program runs, a BRAND-NEW PACK OF CARDS is bought from the game shop, and every brand-new pack of cards always has the same sequence. So unless you do something special, every time your program runs, it will get exactly the same "random" numbers back from `rand()`.

        Now, you might say, "Okay, so how do I shuffle the deck?" And the answer is (at least as far as `rand` and `srand` are concerned), THERE ISN'T A WAY OF SHUFFLING THE DECK.

        So what does `srand` do? Based on the analogy I've been building here, calling `srand(n)` is basically like saying, "CUT THE DECK N CARDS FROM THE TOP". But wait, one more thing: it's actually take another BRAND-NEW DECK and cut it n cards from the top.

        So if you call `srand(n)`, `rand()`, `srand(n)`, `rand()`, ..., with the same `n` every time, you won't just get a not-very-random sequence, you'll actually get the same number back from `rand()` every time. (Not necessarily the same number you handed to srand, but the same number back from rand over and over.)

        So the best you can do is to CUT THE DECK ONCE, that is, call `srand()` once, at the beginning of your program, with an `n` that's REASONABLY RANDOM, so that you'll start at a different random place in the big deck each time your program runs.

  - [c \- How to use function srand\(\) with time\.h? \- Stack Overflow](https://stackoverflow.com/questions/16569239/) #ril

  - [c\+\+ \- Recommended way to initialize srand? \- Stack Overflow](https://stackoverflow.com/questions/322938/) #ril

## 為什麼第一次 `rand()` 的結果總能被 7 整除 ??

  - [objective c \- Why does rand\(\) % 7 always return 0? \- Stack Overflow](https://stackoverflow.com/questions/7866754/)

      - 0xdead10cc: This seems to be a really strange issue: This is my code:

            #import <Foundation/Foundation.h>

            int main (int argc, const char * argv[])
            {
                @autoreleasepool {
                    srand((unsigned int)time(NULL));
                    int newRandomNumber = 0;
                    newRandomNumber = rand() % 7;
                    NSLog(@"%d", rand() % 7); //This prints out what I expected
                    NSLog(@"newRandomNumber = %d", newRandomNumber); // This always prints out 0!
                }
                return 0;
            }

        If I replace that one line that says `newRandomNumber = rand() % 7` with `newRandomNumber = rand() % 8` everything works perfectly. Why is that the case?

      - Grady Player: It seems unlikely but running some tests, after an `srand` the first `rand` seems always to be divisible by 7, at least in an `int` sized variable.

        On several runs I got 1303562743, 2119476443, and 2120232758, all of which mod 7 to 0.

        The second `rand()` works, because it is the second `rand()`. THROW a `rand()` before your first `rand()`... or better yet, use a better random number generator `random` or `arc4rand` if available.

        Also see Stack Overflow question [Why is (rand() % anything) always 0 in C++?](https://stackoverflow.com/questions/2129705).

      - georg: Well, this

            int seed;
            for(seed = 1; seed < 10; seed++) {
                srand(seed);
                printf("%4d %16d\n", seed, rand());
            }

        prints

               1            16807
               2            33614
               3            50421
               4            67228
               5            84035
               6           100842
               7           117649
               8           134456
               9           151263

        which makes me think that `rand()` = seed * 16807

        Wikipedia article [Linear congruential generator](https://en.wikipedia.org/wiki/Linear_congruential_generator) confirms that CarbonLib indeed uses Xn+1 = Xn * 16807 to generate random numbers.

        Apple CarbonLib, C++11's minstd_rand0 的 multiplier a 是 16807，所以這個問題只有 macOS 上有 ??

        在 macOS 上試過，確實是如此：

            $ cat rand.c
            #include <stdlib.h>
            #include <stdio.h>

            int main() {
              int seed;
              for(seed = 1; seed < 10; seed++) {
                  srand(seed);
                  printf("%4d %16d\n", seed, rand());
              }

              return 0;
            }

            $ make rand && ./rand
            cc     rand.c   -o rand
               1            16807
               2            33614
               3            50421
               4            67228
               5            84035
               6           100842
               7           117649
               8           134456
               9           151263

            $ ls -l `which cc`
            lrwxr-xr-x  1 root  wheel  5 Mar 30 15:28 /usr/bin/cc -> clang

        在 Ubuntu 上也有類似的情況 -- 第一次 `rand()` 的結果固定，只是數字不同而已：

            $ make rand && ./rand
            cc     rand.c   -o rand
               1       1804289383
               2       1505335290
               3       1205554746
               4       1968078301
               5        590011675
               6        290852541
               7       1045618677
               8        757547896
               9        444454915

  - [random \- Why is \(rand\(\) % anything\) always 0 in C\+\+? \- Stack Overflow](https://stackoverflow.com/questions/2129705/) #ril
