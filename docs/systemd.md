# systemd

  - [systemd \- Wikipedia](https://en.wikipedia.org/wiki/Systemd) #ril

## 新手上路 ??

  - [systemd \- ArchWiki](https://wiki.archlinux.org/index.php/systemd) #ril
  - [systemd \| Get started wtih systemd \| CoreOS](https://coreos.com/os/docs/latest/getting-started-with-systemd.html) #ril
  - [RHEL7: How to get started with Systemd\. \- CertDepot](https://www.certdepot.net/rhel7-get-started-systemd/) (2018-09-04) #ril

## Unit, Service, Drop-in, Unit File ??

  - [systemd Drop\-In Units \| CoreOS Container Linux](https://coreos.com/os/docs/latest/using-systemd-drop-in-units.html) #ril
  - [Understanding Systemd Units and Unit Files \| DigitalOcean](https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files) #ril

## Environment Variable ??

  - [systemd Environment File \| systemd with CoreOS](https://coreos.com/os/docs/latest/using-environment-variables-in-systemd-units.html)
      - `Environment` directive 可以為 executed process 提供 environment variables，例如 `Environment=ETCD_CA_FILE=/path/to/CA.pem`。
      - 一個 `Environment` directive 可以是 space-separated list of variable assignments，但實務上會用多個 `Environment=key=value`，若 key 相同，後者會覆寫前著，若 value 為 empty string，則會讓在這之前的 `Environment=` 全部失效 (reset)。
      - 另外還有個 `EnvironmentFile` directive，可以從檔案讀取 new-line-separated variable assignments。這裡示範 `EnvironmentFile=/run/metadata/coreos` 讀進設定，在 `ExecStart` 裡就可以用 `${XXX}` 引用變數。
      - Use host IP addresses and EnvironmentFile 提到一個特別的應用，利用 [kelseyhightower/setup\-network\-environment](https://github.com/kelseyhightower/setup-network-environment) 先產生一個內含網路資訊的 environment file，用 `EnvironmentFile=/etc/network-environment` 讀進來，之後就可以用 `${DEFAULT_IPV4}` 拿到自己的 IP。
  - arch linux - How to set environment variable in systemd service? - Server Fault https://serverfault.com/questions/413397/ 在 `[Service]` 由用 `Environment="KEY=VALUE"` 指定 #ril
  - systemd Environment File | systemd with CoreOS https://coreos.com/os/docs/latest/using-environment-variables-in-systemd-units.html #ril

## `ExecStart*`、`ExecReload`、`ExecStop*` ??

  - [ExecStart - systemd\.service](https://www.freedesktop.org/software/systemd/man/systemd.service.html#ExecStart=) #ril
      - Service 啟動時要執行的指令跟參數，內部會根據自己的方式切分為多個 command line。
      - For each of the specified commands, the first argument must be either an ABSOLUTE PATH to an executable or a simple file name without any slashes. 實驗發現，就算有給 `WorkingDiredctory`，指令本身要是絕對路徑這一點還是得遵守，否則會有 "Invalid argument" 的錯誤，就算有設定 `WorkingDirectory`；或許透過 `/usr/bin/env CMD ARGS` 是個不錯的轉折?
  - [Command lines - systemd\.service](https://www.freedesktop.org/software/systemd/man/systemd.service.html#Command%20lines) #ril
  - [systemd.exec(5)](https://www.freedesktop.org/software/systemd/man/systemd.exec.html) 這裡才提到 `WorkingDirectory` #ril
  - [Executing chdir before starting systemd service \- Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/200654/) Eric Renouf: system v227+ 可以用 `WorkingDirectory`；不過受到其他人質疑，可以用在 `[Service]` 嗎?
  - [\[Unit\] Section Options - systemd\.unit](https://www.freedesktop.org/software/systemd/man/systemd.unit.html#%5BUnit%5D%20Section%20Options) 確實沒有提到 `WorkingDirectory`，但 [systemd\.exec](https://www.freedesktop.org/software/systemd/man/systemd.exec.html) 一開始就提到 "The execution specific configuration options are configured in the [Service], [Socket], [Mount], or [Swap] sections, depending on the unit type."，所以 `WorkingDirectory` 是可以用在 `[Service]` 裡的。
  - [Systemd ExecStart path different for me · Issue \#396 · verdaccio/verdaccio](https://github.com/verdaccio/verdaccio/issues/396#issuecomment-341696371) We can use `/usr/bin/env` as a BRIDGE to start the executable without specify absolute path of npm global modules path 這招不錯!!

## Logs

  - [log \- Where is "journalctl" data stored? \- Ask Ubuntu](https://askubuntu.com/questions/864722/) #ril

## systemctl ??

  - `service xxx status` 與 `systemctl status xxx.service` 好像通用?? Service 都習慣稱 `xxx.service`?
  - [Useful SystemD commands \(hints for systemctl or systemctl vs chkconfig and service\)](https://www.dynacont.net/documentation/linux/Useful_SystemD_commands/) #ril

## journalctl ??

  - `journalctl -u UNIT [-b | -f]` 其中 `-b` 表示從 service boot 開始的 log，`-f` 表示要做 following。
  - [How To Use Journalctl to View and Manipulate Systemd Logs \| DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs) (2018-02-20) #ril
  - [logs \- View stdout/stderr of systemd service \- Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/20399/) #ril

## Unit Configuration ??

## Ubuntu ??

  - [SystemdForUpstartUsers \- Ubuntu Wiki](https://wiki.ubuntu.com/SystemdForUpstartUsers) #ril
      - 雖然在 Ubuntu 15.04 前可以透過 repo 安裝 systemd，但 15.04 後才有比較完整的支援，所以在 15.04 前都建議用 Upstart。
      - Ubuntu 15.04 (vivid) 雖然同時內建 systemd 與 Upstart，可以輕易切換，只是 2015-03-09 開始就改以 systemd 做為預設的 init system/daemon。
  - [systemd \- Ubuntu Wiki](https://wiki.ubuntu.com/systemd) #ril

## 參考資料 {: #reference }

  - [systemd](https://freedesktop.org/wiki/Software/systemd/)

手冊：

  - [Manual Pages](https://www.freedesktop.org/software/systemd/man/)
  - [systemd.unit(5)](https://www.freedesktop.org/software/systemd/man/systemd.unit.html#%5BUnit%5D%20Section%20Options) (`[Unit]` Section Options)
  - [systemd.service(5)](https://www.freedesktop.org/software/systemd/man/systemd.service.html#Options) (`[Service]` Section Options)
  - [systemd.exec(5)](https://www.freedesktop.org/software/systemd/man/systemd.exec.html)
