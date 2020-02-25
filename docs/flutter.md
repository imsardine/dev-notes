# Flutter

  - [Flutter \- Beautiful native apps in record time](https://flutter.io/) #ril

      - Flutter allows you to build beautiful NATIVE apps on iOS and Android from a SINGLE CODEBASE.
      - Coming from another platform? Docs: iOS, Android, Web, React Native, Xamarin. 想吸收不同平台的開發者，野心不小!!
      - Fast Development - Paint your app to life in milliseconds with stateful Hot Reload. Use a rich set of fully-customizable widgets to build NATIVE INTERFACES in minutes.

        Flutter's hot reload helps you quickly and easily experiment, build UIs, add features, and fix bugs faster. Experience sub-second reload times, without losing state, on emulators, simulators, and hardware for iOS and Android. 跟 Android Studio 的 Instant Run 有點像。

      - Expressive and Flexible UI - Quickly ship features with a focus on native end-user experiences. Layered architecture allows for full customization, which results in incredibly FAST RENDERING and expressive and flexible designs.

        Delight your users with Flutter's built-in beautiful Material Design and Cupertino (iOS-flavor) widgets, rich motion APIs, smooth natural scrolling, and PLATFORM AWARENESS.

      - Native Performance - Flutter’s widgets incorporate all critical platform differences such as scrolling, navigation, icons and fonts to provide full NATIVE PERFORMANCE on both iOS and Android. 這正是其他跨平台方案最為人垢病的點!!

        Flutter’s widgets incorporate all critical platform differences such as scrolling, navigation, icons and fonts to provide full native performance on both iOS and Android.

  - [Google is one step closer to replacing Android with something even more exciting – BGR](https://bgr.com/2018/12/04/fuchsia-vs-android-flutter-1-0-coding-toolkit-released/) (2018-12-04)
      - But Google isn’t just developing a new OS for the future of computing. It’s also working on a new coding engine that would let developers easily deploy apps on ALL PLATFORMS, including Apple’s iOS. If all this sounds familiar, that’s because Google released a Flutter beta in late February at MWC 2018, which developers can use to code apps for Android and iOS. On Tuesday, Google announced that the FIRST STABLE VERSION of Flutter is available for everyone to try, complete with many improvements as well as new features.
      - Flutter’s main advantage over other coding alternatives, at least as far as Google is concerned, is that it allows developers to create apps for both Android and iPhone platforms a lot faster than before. Even though we’re not in the early days of app development for iPhone and Android, developers still favor iOS over Android in many cases, and some TITLES hit iPhones and iPads before they’re available in the Play store. With Flutter, companies won’t have to invest in two development teams, one for each major mobile OS. 不用投資兩個開發團隊，確實是個很大的誘因；下面提到 "iOS or Android-first" 的問題。
      - A comment from Capital One’s senior director of engineering featured in Google’s press release perfectly explains why Flutter is great for the future of Android, emphasis ours:
          - We are excited by Flutter’s unique take on HIGH-PERFORMING cross-platform development. Our engineers have appreciated the rapid development promise, and HOT RELOAD capabilities, and over the past year we have seen tremendous progress in the framework and especially the NATIVE INTEGRATION story.
          - Flutter can allow Capital One to think of features not in an ‘iOS or Android-first’ fashion, but rather in a true MOBILE-FIRST model. We are excited to see Flutter 1.0 and continue to be impressed with the pace of advancement and the excitement in the engineering community.
      - With Flutter, Google hopes that companies will code all their new apps at the same time and then deploy them simultaneously on iPhone and Android. When the time comes, Flutter will LIKELY also allow developers to create iOS and Fuchsia apps simultaneously. Flutter should make porting Android apps to Fuchsia much easier.

        注意 "iOS and Fuchsia apps" 的說法，已經不提 Android 了；若 Fuchsia 本身就可以執行 Android app，那 Flutter 為什麼有助於 Android 的遷移??

        It’s an open source project too, which means that it’ll support other coding tools out there like Kotlin and Java for Android, and Swift and Objective-C for iOS. 還是需要寫 Android 或 iOS 專用的程式??

      - Announced at Flutter Live, Flutter 1.0 doesn’t just allow cross-platform app development on a SINGLE CODEBASE. It also brings over several features that should make it appealing to use. Flutter should allow developers to build beautiful apps that will adhere to both Google’s Material Design guidelines and Apple’s design guidelines. In fact, the iOS Settings screenshot below was created in Flutter. 就像原生的一樣!!
      - Flutter should also be faster to use, supporting “glitch-free, jank-free graphics” at the NATIVE SPEEDS. Flutter supports a “STATEFUL HOT RELOAD” feature, which lets developers make changes to their apps while they’re testing them without restarting or losing the state of the app. 若 Flutter 能兼顧速度，表現出來又像是原生 app，就真的無敵了!!
      - Flutter 1.0 brings a couple of notable new features, including “Add to App,” which will let developers UPDATE EXISTING APPS with the help of Flutter, or CONVERT EXISTING APPS in stages. “Platform Views” is a new Flutter trick that will let users add UI features to existing apps with the help of Flutter, like the transparent “Go to London” button in the following screenshots: 動態為別人開發的 app 加點東西??
      - Flutter is already in use internally at Google on apps including Google Maps and Google Ads. But various other developers have already created apps in Flutter, including Capital One, Alibaba, Groupon, Hamilton, JD.com, Philips Hue, Reflectly, and Tencent. Square also announced two Flutter SDKs to bring payment support to apps via Flutter. 起飛了 ~

  - [Google Developers Blog: Flutter 1\.0: Google’s Portable UI Toolkit](https://developers.googleblog.com/2018/12/flutter-10-googles-portable-ui-toolkit.html) (2018-12-04) #ril

  - [Announcing Flutter beta 1: Build beautiful native apps](https://medium.com/flutter-io/announcing-flutter-beta-1-build-beautiful-native-apps-dc142aea74c0) (2018-02-27) #ril
      - Google 在 Mobile World Congress 2018 公布 Flutter 第一個 beta 版。

## 應用實例 {: #powered-by }

  - [Showcase \- Flutter](https://flutter.io/showcase)
  - [Flutter \- Beautiful native apps in record time](https://flutter.io/) Expressive, beautiful UIs 提到 [Reflectly](https://reflect.ly/) -- An award winning mindfulness app built with Flutter.

## 跟 Fuchsia 的關係 ?? {: #fuchsia }

  - [Features - Google Fuchsia \- Wikipedia](https://en.wikipedia.org/wiki/Google_Fuchsia#Features)
      - Fuchsia 的 UI 跟 app 用 Flutter 開發 -- 一個橫跨 Fuchsia、iOS 及 Android 的 SDK。
      - Flutter 會產生基於 Dart 的 app，所以 frame rate 可以達到 120 FPS。

## 新手上路 ?? {: #getting-started }

  - [Codelabs \- Flutter](https://flutter.io/docs/codelabs) #ril

## Hot Reload ??

  - [Hot reload \- Flutter](https://flutter.io/docs/development/tools/hot-reload) #ril

## 安裝設置 {: #setup }

  - [Install \- Flutter](https://flutter.io/docs/get-started/install)

    分 Windows、macOS 跟 Linux，只有 macOS 可以同時開發 iOS 跟 Android。

### macOS

  - [macOS install \- Flutter](https://flutter.dev/docs/get-started/install/macos)

    System requirements

      - To install and run Flutter, your development environment must meet these minimum requirements:

          - Operating Systems: macOS (64-bit)
          - Disk Space: 2.8 GB (does not include disk space for IDE/tools).

          - Tools: Flutter depends on these command-line tools being available in your environment.

            `bash`, `curl`, `git` 2.x, `mkdir`, `rm`, `unzip`, `which`

    Get the Flutter SDK

     1. Download the following installation bundle to get the latest stable release of the Flutter SDK:

        For other release channels, and older builds, see the [SDK archive](https://flutter.dev/docs/development/tools/sdk/archive) page.

     2. Extract the file in the desired location, for example:

            $ cd ~/development
            $ unzip ~/Downloads/flutter_macos_v1.12.13+hotfix.8-stable.zip

        If you don’t want to install a fixed version of the installation bundle, you can skip steps 1 and 2. Instead, get the source code from the Flutter repo on GitHub, and change branches or tags as needed. For example:

            $ git clone https://github.com/flutter/flutter.git -b stable

     3. Add the `flutter` tool to your path:

            export PATH="$PATH:`pwd`/flutter/bin"

        This command sets your `PATH` variable for the current terminal window only. To permanently add Flutter to your path, see Update your path.

     4. Optionally, PRE-DOWNLOAD development binaries:

        The `flutter` tool downloads PLATFORM-SPECIFIC development binaries as needed. For scenarios where pre-downloading these artifacts is preferable (for example, in HERMETIC build environments, or with intermittent network availability), iOS and Android binaries can be downloaded ahead of time by running:

            flutter precache

        For additional download options, see `flutter help precache`.

            $ flutter precache
            Downloading Android Maven dependencies...
            (This is taking an unexpectedly long time.)

        就放著給它跑，否則之後練習過程中還要等待。

      - You are now ready to run Flutter commands!

        Note: To update an existing version of Flutter, see [Upgrading Flutter](https://flutter.dev/docs/development/tools/sdk/upgrading). #ril

    Run `flutter doctor`:

      - Run the following command to see if there are any dependencies you need to install to complete the setup (for verbose output, add the `-v` flag): `flutter doctor`

            $ flutter doctor

              ╔════════════════════════════════════════════════════════════════════════════╗
              ║                 Welcome to Flutter! - https://flutter.dev                  ║
              ║                                                                            ║
              ║ The Flutter tool uses Google Analytics to anonymously report feature usage ║
              ║ statistics and basic crash reports. This data is used to help improve      ║
              ║ Flutter tools over time.                                                   ║
              ║                                                                            ║
              ║ Flutter tool analytics are not sent on the very first run. To disable      ║
              ║ reporting, type 'flutter config --no-analytics'. To display the current    ║
              ║ setting, type 'flutter config'. If you opt out of analytics, an opt-out    ║
              ║ event will be sent, and then no further information will be sent by the    ║
              ║ Flutter tool.                                                              ║
              ║                                                                            ║
              ║ By downloading the Flutter SDK, you agree to the Google Terms of Service.  ║
              ║ Note: The Google Privacy Policy describes how data is handled in this      ║
              ║ service.                                                                   ║
              ║                                                                            ║
              ║ Moreover, Flutter includes the Dart SDK, which may send usage metrics and  ║
              ║ crash reports to Google.                                                   ║
              ║                                                                            ║
              ║ Read about data we send with crash reports:                                ║
              ║ https://github.com/flutter/flutter/wiki/Flutter-CLI-crash-reporting        ║
              ║                                                                            ║
              ║ See Google's privacy policy:                                               ║
              ║ https://www.google.com/intl/en/policies/privacy/                           ║
              ╚════════════════════════════════════════════════════════════════════════════╝


            Doctor summary (to see all details, run flutter doctor -v):
            [✓] Flutter (Channel stable, v1.12.13+hotfix.8, on Mac OS X 10.15.3 19D76, locale en-TW)

            [✓] Android toolchain - develop for Android devices (Android SDK version 28.0.3)
            [!] Xcode - develop for iOS and macOS (Xcode 10.2.1)
                ✗ Flutter requires a minimum Xcode version of 11.0.0.
                  Download the latest version or update via the Mac App Store.
                ✗ Xcode requires additional components to be installed in order to run.
                  Launch Xcode and install additional required components when prompted or run:
                    sudo xcodebuild -runFirstLaunch
                ✗ CocoaPods not installed.
                    CocoaPods is used to retrieve the iOS and macOS platform side's plugin code that responds to your plugin
                    usage on the Dart side.
                    Without CocoaPods, plugins will not work on iOS or macOS.
                    For more info, see https://flutter.dev/platform-plugins
                  To install:
                    sudo gem install cocoapods
            [!] Android Studio (version 3.2)
                ✗ Flutter plugin not installed; this adds Flutter specific functionality.
                ✗ Dart plugin not installed; this adds Dart specific functionality.
            [!] IntelliJ IDEA Community Edition (version 2016.3.4)
                ✗ Flutter plugin not installed; this adds Flutter specific functionality.
                ✗ Dart plugin not installed; this adds Dart specific functionality.
                ✗ This install is older than the minimum recommended version of 2017.1.0.
            [!] VS Code (version 1.33.1)
                ✗ Flutter extension not installed; install from
                  https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
            [!] Connected device
                ! No devices available

            ! Doctor found issues in 5 categories.

      - This command checks your environment and displays a report to the terminal window. The Dart SDK is bundled with Flutter; it is not necessary to install Dart separately. Check the output carefully for other software you might need to install or further tasks to perform (shown in bold text). 也就是 error 的部份。

        Once you have installed any missing dependencies, run the `flutter doctor` command again to verify that you’ve set everything up correctly.

      - Warning: The `flutter` tool uses Google Analytics to anonymously report feature usage statistics and basic crash reports. This data is used to help improve Flutter tools over time.

        Flutter tool analytics are not sent on the very first run. To disable reporting, type `flutter config --no-analytics`. To display the current setting, type `flutter config`. If you opt out of analytics, an opt-out event will be sent, and then no further information will be sent by the Flutter tool.

        Moreover, Flutter includes the Dart SDK, which may send usage metrics and crash reports to Google.

### Android

  - [Android setup - macOS install \- Flutter](https://flutter.dev/docs/get-started/install/macos#android-setup) #ril

### iOS

  - [iOS setup - MacOS install \- Flutter](https://flutter.io/docs/get-started/install/macos#ios-setup)
      - To develop Flutter apps for iOS, you need a Mac with Xcode 9.0 or newer: ... With Xcode, you’ll be able to run Flutter apps on an iOS device or on the simulator.

        不過要執行在 iOS device，除了 Xcode 之外還要裝 iOS toolchain，執行在 simulator 相對單純許多。

      - Configure the Xcode command-line tools to use the newly-installed version of Xcode by running the following from the command line: `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer`
      - Make sure the Xcode license agreement is signed by either opening Xcode once and confirming or running `sudo xcodebuild -license` from the command line. 原來還有這一招!

    Set up the iOS simulator

      - On your Mac, find the Simulator via Spotlight or by using the following command: `open -a Simulator`
      - Make sure your simulator is using a 64-bit device (iPhone 5s or later) by checking the settings in the simulator’s Hardware > Device menu.
      - Depending on your development machine’s screen size, simulated high-screen-density iOS devices may overflow your screen. Set the device scale under the Window > Scale menu in the simulator.

    Create and run a simple Flutter app

      - Create a new Flutter app by running the following from the command line: `flutter create my_app`
      - To launch the app in the Simulator, ensure that the Simulator is running and enter: `flutter run`

    過程像是：

        $ flutter create my_app
          my_app/ios/Runner.xcworkspace/contents.xcworkspacedata (created)
          my_app/ios/Runner/Info.plist (created)
          my_app/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png (created)
          my_app/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png (created)
          my_app/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md (created)
          my_app/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json (created)
          my_app/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png (created)
          my_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png (created)
          my_app/ios/Runner/Base.lproj/LaunchScreen.storyboard (created)
          my_app/ios/Runner/Base.lproj/Main.storyboard (created)
          my_app/ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata (created)
          my_app/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme (created)
          my_app/ios/Flutter/Debug.xcconfig (created)
          my_app/ios/Flutter/Release.xcconfig (created)
          my_app/ios/Flutter/AppFrameworkInfo.plist (created)
          my_app/test/widget_test.dart (created)
          my_app/my_app.iml (created)
          my_app/.gitignore (created)
          my_app/.metadata (created)
          my_app/ios/Runner/AppDelegate.h (created)
          my_app/ios/Runner/main.m (created)
          my_app/ios/Runner/AppDelegate.m (created)
          my_app/ios/Runner.xcodeproj/project.pbxproj (created)
          my_app/android/app/src/main/res/mipmap-mdpi/ic_launcher.png (created)
          my_app/android/app/src/main/res/mipmap-hdpi/ic_launcher.png (created)
          my_app/android/app/src/main/res/drawable/launch_background.xml (created)
          my_app/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png (created)
          my_app/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png (created)
          my_app/android/app/src/main/res/values/styles.xml (created)
          my_app/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png (created)
          my_app/android/app/src/main/AndroidManifest.xml (created)
          my_app/android/gradle/wrapper/gradle-wrapper.properties (created)
          my_app/android/gradle.properties (created)
          my_app/android/settings.gradle (created)
          my_app/pubspec.yaml (created)
          my_app/README.md (created)
          my_app/lib/main.dart (created)
          my_app/android/app/build.gradle (created)
          my_app/android/app/src/main/java/com/example/myapp/MainActivity.java (created)
          my_app/android/build.gradle (created)
          my_app/android/my_app_android.iml (created)
          my_app/.idea/runConfigurations/main_dart.xml (created)
          my_app/.idea/libraries/Flutter_for_Android.xml (created)
          my_app/.idea/libraries/Dart_SDK.xml (created)
          my_app/.idea/libraries/KotlinJavaRuntime.xml (created)
          my_app/.idea/modules.xml (created)
          my_app/.idea/workspace.xml (created)
        Running "flutter packages get" in my_app...                 20.0s
        Wrote 64 files.

        All done!
        [✓] Flutter is fully installed. (Channel stable, v1.0.0, on Mac OS X 10.13.6 17G65, locale en-TW)
        [✓] Android toolchain - develop for Android devices is fully installed. (Android SDK 28.0.3)
        [!] iOS toolchain - develop for iOS devices is partially installed; more components are available. (Xcode 10.0)
        [✓] Android Studio is fully installed. (version 3.2)
        [!] IntelliJ IDEA Community Edition is partially installed; more components are available. (version 2016.3.4)
        [!] VS Code is partially installed; more components are available. (version 1.27.2)
        [✓] Connected device is fully installed. (1 available)

        Run "flutter doctor" for information about installing additional components.

        In order to run your application, type:

          $ cd my_app
          $ flutter run

        Your application code is in my_app/lib/main.dart.

        $ cd my_app

        $ flutter run
        Launching lib/main.dart on iPhone XS Max in debug mode...
        Starting Xcode build...
         ├─Assembling Flutter resources...                    2.7s
         └─Compiling, linking and signing...                 18.2s

        Xcode build done.                                           25.4s
        20.8s
        Syncing files to device iPhone XS Max...                     3.5s

        🔥  To hot reload changes while running, press "r". To hot restart (and rebuild state), press "R".
        An Observatory debugger and profiler on iPhone XS Max is available at: http://127.0.0.1:63141/
        For a more detailed help message, press "h". To detach, press "d"; to quit, press "q".

        Initializing hot reload...
        Reloaded 1 of 419 libraries in 1,212ms.

    注意 `r` (hot reload) 與 `R` (hot restart) 不同，前者會保留 state，按 `h` 可以有更多功能，體驗真的很不錯!!

        🔥  To hot reload changes while running, press "r". To hot restart (and rebuild state), press "R".
        An Observatory debugger and profiler on iPhone XS Max is available at: http://127.0.0.1:63141/
        You can dump the widget hierarchy of the app (debugDumpApp) by pressing "w".
        To dump the rendering tree of the app (debugDumpRenderTree), press "t".
        For layers (debugDumpLayerTree), use "L"; for accessibility (debugDumpSemantics), use "S" (for traversal order) or
        "U" (for inverse hit test order).
        To toggle the widget inspector (WidgetsApp.showWidgetInspectorOverride), press "i".
        To toggle the display of construction lines (debugPaintSizeEnabled), press "p".
        To simulate different operating systems, (defaultTargetPlatform), press "o".
        To display the performance overlay (WidgetsApp.showPerformanceOverlay), press "P".
        To save a screenshot to flutter.png, press "s".
        To repeat this help message, press "h". To detach, press "d"; to quit, press "q".

    其中 Observatory debugger and profiler 其實就是 Dart VM Observatory。

  - [Deploy to iOS devices - MacOS install \- Flutter](https://flutter.io/docs/get-started/install/macos#deploy-to-ios-devices) #ril

## 參考資料 {: #reference }

  - [Flutter](https://flutter.io/)
  - [Flutter - GitHub](https://github.com/flutter)

社群：

  - [Flutter (@flutterio) | Twitter](https://twitter.com/flutterio)

文件：

  - [Flutter Documentation](https://flutter.io/docs)

學習資源：

  - [Cookbook - Flutter](https://flutter.io/docs/cookbook)
  - [Google Developers Blog: flutter](https://developers.googleblog.com/search/label/flutter)
  - [Flutter by Google - YouTube](https://www.youtube.com/playlist?list=PLOU2XLYxmsIJ7dsVN4iRuA7BT8XHzGtCr) #ril
  - [Flutter – Medium](https://medium.com/flutter)
  - [FlutterDevs – Medium](https://medium.com/flutterdevs)
  - [Flutter Live](https://developers.google.com/events/flutter-live/)

更多：

  - [Testing](flutter-testing.md)
  - [UI](flutter-ui.md)

相關：

  - [Dart](dart.md)
  - [Fuchsia](fuchsia.md) app 也是用 Flutter 開發。

手冊：

  - [Flutter - Dart API Docs](https://docs.flutter.io/)
