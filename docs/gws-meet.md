---
title: Google Workspace / Meet
---
# [Google Workspace](gws.md) / Meet

## Quality Tool

  - [Track meeting quality and statistics \- Google Workspace Admin Help](https://support.google.com/a/answer/9204857?hl=en)

      - This feature requires having the Admin quality dashboard access privilege.

        這裡的 quality dashboard 專指 quality dashboard for Google Meet。

      - Use the Meet quality tool to troubleshoot your organization’s Google Meet video meetings and identify the root cause of issues. For example, you can see an overview of meeting metrics, find and debug meetings, view network statistics (jitter, packet loss, and congestion), network connection delay (RTT??), microphone level and received audio level, or view system (CPU) statistics.

      - Note: The Meet quality tool saves data for 30 days. For more information, see Data retention and lag times.

    Open the Meet quality tool

      - IT administrators -- You must be signed in to an admin account with the appropriate privileges to access the Meet quality tool.

      - To access the tool from the Google Admin console, go to Apps > Google Workspace > Google Meet and click Meet quality tool.

        If you are already logged in, you can also search for a meeting code, organizer or participant in the search bar on any admin page.

    See information and filter data - Views

      - Meetings view: Shows the meetings organized or joined by users in your organization.
      - Participants view: Shows the users in your organization that joined meetings.
      - Google meeting room hardware: Shows the Google meeting room hardware in your organization that joined a meeting.

    Filter information & grant access to the tool - Filter and sort

      - You can filter and sort the data to:

          - Find a meeting.
          - See data for one room over a period of time.
          - See data for a specific location.
          - Find problematic meetings or devices.
          - Find meetings on a specific day.
          - Find meetings where more than 50 participants joined.

        不同 view 提供的 filter 不太一樣，Meeting size 只在 Meetings view 下才有。怎麼按 meeting room 過濾??

      - To filter data:

          - Click Add a filter.
          - From the list, select a filter.
          - Set the filter values and click Apply.
          - (Optional) To sort the filtered data, click a column header.

    Filter information & grant access to the tool - Summary bar

      - Depending on which view you select, the summary bar shows statistics for meetings, participants, or devices.

    Filter information & grant access to the tool - Meeting, participant, and device statistics

      - Duration: Average meeting time.
      - Meetings: Total number of meetings.
      - Participant connections: Total number of connection endpoints.
      - Device connections: Total number of Google meeting room hardware devices that joined meetings.

      - Network congestion:

        Percentage of time that network constraints prevented a device from sending higher-quality video.

        只跟 video 有關??

      - Packet loss:

        Percentage of packets lost on the network. This includes packets sent from a client to Google and received by the client from Google.

      - Jitter: VARIATION?? in latency on packets flowing between a client and Google.

        會蒐集到 average/max jitter，單位是 ms。

        > Jitter is the variation in the time it takes for packets of information to travel across a network. Jitter is caused by any deviation or displacement in the packet’s path, causing a delay in the packet delivery, or causing the packets to ARRIVE IN A DIFFERENT ORDER. For a caller, jitter is experienced as CHOPPY, poor quality audio.
        >
        > -- [What is Jitter? \| GoTo](https://www.goto.com/resources/glossary/jitter)

        從 Zoom 的說明來看，jitter 在 40ms 下還可以接受：

        > Jitter: The variation in the time between packets arriving, caused by network congestion, timing drift, or route changes. Typically, a jitter of 40ms or less is recommended.
        >
        > -- [Meeting and phone statistics – Zoom Help Center](https://support.zoom.us/hc/en-us/articles/202920719-Meeting-and-phone-statistics)

      - Feedback score: User rating submitted at the end of a meeting.

## 參考資料 {: #reference }

  - [Meet Quality Tool](https://meet.google.com/tools/quality/admin)
