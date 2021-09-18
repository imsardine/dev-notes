# fsck

  - [fsck \- Wikipedia](https://en.wikipedia.org/wiki/Fsck) #ril

      - The system utility fsck (file system consistency check) is a tool for checking the consistency of a file system in Unix and Unix-like operating systems, such as Linux, macOS, and FreeBSD.

        A similar command, CHKDSK, exists in Microsoft Windows and its ancestor, MS-DOS.

      - There is no agreed pronunciation. It can be pronounced "F-S-C-K", "F-S-check", "fizz-check", "F-sack", "fisk", "fishcake", "fizik", "F-sick", "F-sock", "F-sek", "feshk", the sibilant "fsk", "fix", "farsk" or "fusk".

  - [How to use fsck to Find and Repair Disk Errors and Bad Sectors \| Linode](https://www.linode.com/docs/guides/how-to-use-fsck-to-fix-disk-problems/) (2020-10-07) #ril

    What is fsck?

      - fsck, short for file system consistency check, is a utility that examines the file system for errors and attempts to repair them if possible. It uses a combination of built-in tools to check the disk and generates a report of its findings.
      - On some systems, fsck runs automatically after an unclean shutdown or after a certain number of reboots.

    When to Use fsck

      - Use fsck to check your file system if your system fails to boot, if files on a specific disk become corrupt, or if an attached drive does not act as expected. Unmount the disks you intend to work on before attempting to check or repair them.

        Caution: Unmount the target disk first. You risk corrupting your file system and losing data if you run fsck on an active disk.

    Unmount the Disk > Boot into Rescue Mode

      - If you are using fsck on a Linode, the easiest and safest way to unmount your disk is to use RESCUE MODE.

        Visit our [Rescue and Rebuild](https://www.linode.com/docs/guides/rescue-and-rebuild/#booting-into-rescue-mode) guide for instructions on how to boot your Linode into Rescue Mode. If you’re working on a local machine, consider using the distribution’s recovery mode or a live distribution to avoid working on a mounted disk.

        fsck should be run only as a user with root permissions.

    Unmount the Disk > View Mounted Disks and Verify Disk Location

      - Run `df` to view a list of currently mounted disks. If you are using Rescue Mode, the disk you want to check should not be listed:

            df -h

      - Use `fdisk` to view disk locations:

            fdisk -l

        Copy the location of the target disk to use with the fsck command.

    Unmount the Disk > Manual Unmount

      - If you are working on a local machine, unmount the disk manually.

        Use `umount` to unmount the disk location copied in the previous step:

            umount /dev/sdb

      - If the disk is declared in `/etc/fstab`, change the mount point to `none` there as well.

    How to Check for Errors on a Disk

      - Run fsck on the target disk, using the desired options. This example checks all file systems (`-A`) on `/dev/sdb`:

            fsck -A /dev/sdb

  - [Fsck Command in Linux \(Repair File System\) \| Linuxize](https://linuxize.com/post/fsck-command-in-linux/) (2019-11-12) #ril
