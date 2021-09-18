# Slack

## Mouseless, Navigation ??

  - [Slack keyboard shortcuts – Slack Help Center](https://get.slack.help/hc/en-us/articles/201374536-Slack-keyboard-shortcuts) #ril
      - `Cmd-[/]` - 按 history 切換。
      - `Cmd-K` - 跳到輸入的 channel
  - How do I jump to a specific date in history or the oldest message in a Slack channel in the desktop app? - Stack Overflow https://stackoverflow.com/questions/35122312/ 用 Channel Settings > Jump to date ... 可以緩解這個問題，但要記住剛剛在哪個日期就是了。

## Mention ??

@here、@channel 跟 @everyone 有什麼不同?

  - [Make an announcement – Slack Help Center](https://get.slack.help/hc/en-us/articles/202009646-Make-an-announcement) `@here` 會通知到 active (相對於 away) 的人，適合用在 "currently working or available" 的人；而 `@channel`/`@everyone` 則不管是不是 active 都通知 (所以會提示多少人會被通知到、落在幾個時區)。另外 `@everyone` 是針對整個 workspace，通常只會用在 `#general`。

## 如何將未讀的訊息一次全部標示為已讀?

  - Slack keyboard shortcuts – Slack Help Center https://get.slack.help/hc/en-us/articles/201374536-Slack-keyboard-shortcuts Shift + Esc = Mark all messages as read

## Call, Screen Sharing ??

  - [Slack Calls: the basics – Slack Help Center](https://get.slack.help/hc/en-us/articles/115003498363) #ril

  - [Make calls in Slack – Slack Help Center](https://get.slack.help/hc/en-us/articles/216771908-Make-calls-in-Slack)

      - SOMETIMES IT HELPS TO TALK THINGS OUT. With Slack Calls, you can make a voice or video call with any member of your workspace.

        用講的比較快! 可以只開聲音? 不知道多人的效果如何? ==> 預設只會啟用聲音，多人效果還可以，通常是使用者端收音的問題 (不夠靠近 Mic)。

      - Need a shortcut for making calls? We've got a slash command for that! Use `/call` in a DM or channel to start a call.

    Start a call

      - On any plan, a member can start a call with one other member via a direct message (DM). To start a call from a group DM or a channel, a workspace must be on one of our paid plans. For calls with more than two people, there can be a total of 15 participants.

        一對一是免費的，多人則要付費，最多同時 15 人。在 channel 裡 Start a call 有辦法選人嗎? ==> Start a call 只是丟出一個 link，自由 join，後面建議自己用 mention 找人，在 Start a call 的前後都可以。

    Start a call > From a direct message

      - Open a direct message. Click the phone icon at the top right. Your call will start right away, and the member you're calling will receive a pop-up notification.
      - You can also click the camera icon to start a video call and even share your screen if your workspace is on a paid plan.

    Start a call > From a channel

      - Open a channel and click the phone icon at the top right. Confirm you'd like to start a call. Give the call a NAME if you'd like, then click Start new call. 其中 NAME 比較像是個 "討論的主題"，例如 "Let's finalize our Q3 goals!"
      - Your call will post to the channel and any member (up to 15 total) can join by clicking Join this call.
      - You can also click the camera icon to start a video call and even share your screen if your workspace is on a paid plan. 多人的畫筆、滑鼠控制會變怎樣?? ==> 可以同時畫，但畫筆顏色不同
      - Use an `@here` or `@channel` mention to notify channel members BEFORE OR AFTER you start the call.

    Share and invite others to a call

      - Invite other members to a call -- To invite a specific member to join your current call, follow these steps: Click the plus icon in the upper-right corner of the call window. Start typing a member's name to filter the list. Select a member to invite.
      - Share a call in a channel -- If you'd like to share a call in other channels, here's how: Click the  plus icon in the upper-right corner of the call window. Click Share this call. Join a call > Answer a direct message call

    Join a call > Join a channel call

      - Click Join this call from the in-channel invitation. A call window will open where you can see who else is on the call, and WHO IS SPEAKING.

        可以控制誰能發言??

  - [Share your screen with Slack Calls – Slack Help Center](https://get.slack.help/hc/en-us/articles/115003501303) #ril

  - [Call actions - Slack keyboard shortcuts – Slack Help Center](https://get.slack.help/hc/en-us/articles/201374536-Slack-keyboard-shortcuts#-call-actions) #ril

## 安裝設置 {: #setup }

  - Slack 官方除提供 `.deb` 與 `.rpm` 外，也提供了 [Snap](https://snapcraft.io/slack)，因此其他 Linux distro 可以透過 [Snapcrapt](snapcraft.md) 安裝 Slack。

參考資料：

  - [Linux \| Downloads \| Slack](https://slack.com/downloads/linux)

      - 除 `.deb` (64-bit) 跟 `.rpm` (64-bit) 外，還有 Download from the Snap store?
      - [Install Slack for Linux using the Snap Store \| Snapcraft](https://snapcraft.io/slack) Users by distribution (log) 可以看出 Linux distro. + Snap + Slack 的排名，前面幾名都是 Ubuntu，接著才是 Linux Mint、Fedora 等。

  - [In a Snap, Slack Comes to Linux\. Here's How To Install It](https://www.bleepingcomputer.com/news/security/in-a-snap-slack-comes-to-linux-heres-how-to-install-it/) (2018-01-19)
      - While binaries for Slack have been available for Ubuntu and Fedora, other Linux operating systems are not so lucky. To overcome this, Canonical has RELEASED SLACK AS A SNAP, which allows Slack to be installed and used on a greater variety of Linux distributions.

      - Snapcraft is a command line tool that allows you to install CONTAINERISED APPLICATIONS called SNAPS on many different Linux distribution. As these Snap containers contain all the required dependencies that a program needs to run, it makes it very easy to create and distribute a single container that works on a variety of Linux versions.

        雖然是 container，發現它跟其他應用程式融合得滿好的，剪貼簿換資料、拖放檔案等都沒有問題。

      - The creation of a Slack Snap is smart move by both the Slack team and Canonical. For Canonical, it provides a greater user base for their Snapcraft service and for Slack, it allows a larger audience to use their service and make upgrading to new Slack versions much easier. According to Jamie Bennett, VP of Engineering, Devices & IoT at Canonical:

        > Slack is helping to transform the modern workplace, and we’re thrilled to welcome them to the snaps ecosystem Today’s announcement is yet another example of PUTTING THE LINUX USER FIRST – Slack’s developers will now be able to push out the latest features straight to the user. By prioritising usability, and with the popularity of open source continuing to grow, the number of snaps is only set to rise in 2018.

    How to install Slack as a Snap

      - Now that we know that Slack is available as a Snap, the next thing we need to do is install it. Installing SNAPCRAFT, the program required to install and run Snaps, is really easy and supported on the Arch Linux, Debian, Fedora, Gentoo, Linux Mint, Manjaro, OpenEmbedded/Yocto, openSUSE, OpenWrt, Solus, & Ubuntu distributions.

      - Simply go to this page and follow the instructions on how to install the Snapcraft snapd service for your Linux distribution.  For example, on Ubuntu you can install Snapcraft simply by using these commands from a terminal: 為什麼 Ubuntu 上也要裝 Snap，Slack 官方不是已經提供有 Ubuntu 與 Fedora 的版本

            sudo apt update
            sudo apt install snapd

      - Once snapd is installed, you can then install Slack using these commands: (注意 `--classic` 的用法)

            sudo snap find slack
            sudo snap install slack --classic

      - Once slack is installed, you can launch your desktop and execute the `slack` command from a terminal. Slack will then start and you can use it as normal.

        美中不足的是要下指令，如何讓它出現在選單裡??

## 參考資料 {: #reference }

  - [Slack Help Center](https://slack.com/help)

社群：

  - [Slack API (@SlackAPI\) | Twitter](https://twitter.com/SlackAPI)
  - ['slack' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/slack)
  - ['slack-api' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/slack-api)

更多：

  - [Incoming Webhook](slack-incoming-webhook.md)
