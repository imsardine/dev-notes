---
title: Flutter / Testing
---
# [Flutter](flutter.md) / Testing

  - [Flutter's build modes \- Flutter](https://flutter.io/docs/testing/build-modes) The Flutter tooling supports three modes when compiling your app, and a HEADLESS MODE for testing. ... For more information on headless testing, see Unit testing.

  - [Testing Flutter apps \- Flutter](https://flutter.io/docs/testing) #ril

    Automated testing falls into a few categories:

      - A unit test tests a single function, method, or class. External dependencies of the unit under test are generally mocked out. Unit tests generally don’t read from or write to disk, render to screen, or receive user actions from outside the process running the test. The goal of a unit test is to verify the correctness of a unit of logic under a variety of conditions.
      - A WIDGET TEST (in other UI frameworks referred to as component test) tests a single widget. Testing a widget involves MULTIPLE CLASSES and requires a TEST ENVIRONMENT that provides the appropriate WIDGET LIFECYCLE CONTEXT.

        For example, it should be able to receive and respond to user actions and events, perform layout, and instantiate child widgets. A widget test is therefore more comprehensive than a unit test. However, like a unit test, a widget test’s environment is REPLACED WITH AN IMPLEMENTATION much simpler than a full-blown UI system. The goal of a widget test is to verify that the widget’s UI looks and interacts as expected. 相對於 integration test 的說法，widget test 似乎不用在 device/simulator 上執行??

      - An integration test tests a COMPLETE APP or a large part of an app. Generally, an integration test runs on a real device or an OS emulator, such as iOS Simulator or Android Emulator. The app under test is typically ISOLATED FROM THE TEST DRIVER CODE TO AVOID SKEWING THE RESULTS. The goal of an integration test is to verify that the app functions correctly AS A WHOLE, that all the widgets it is composed of integrate with each other as expected. You can also use your integration tests to verify your app’s PERFORMANCE.

      Here is a table summarizing the tradeoffs concerning the choice between different kinds of tests:


      |                  | Unit   | Widget   | Integration |
      |------------------|--------|----------|-------------|
      | Confidence       | Low    | Higher   | Highest     |
      | Maintenance cost | Low    | Higher   | Highest     |
      | Dependencies     | Few    | More     | Most        |
      | Execution Speed  | Quick  | Slower   | Slowest     |

      Tip: A well-tested app has MANY unit and widget tests, tracked by CODE COVERAGE, plus ENOUGH integration tests to cover all the important USE CASES. 也就是 unit/widget test 看的是 code coverage，而 integration test 看的則是 use case 的 coverage。

## Unit Testing ??

  - [Unit testing - Testing Flutter apps \- Flutter](https://flutter.io/docs/testing#unit-testing) #ril
  - [Mock dependencies using Mockito \- Flutter](https://flutter.io/docs/cookbook/testing/unit/mocking) #ril
