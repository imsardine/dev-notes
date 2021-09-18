---
title: Docker / Storage
---
# [Docker](docker.md) / Storage

  - [Manage data in Docker \| Docker Documentation](https://docs.docker.com/storage/) #ril

## Volume, Bind Mount, tmpfs Mount ??

  - Volume 跟 bind mount 都用 `--volume`?? 差別在於用路徑表示時視為 bind mount，否則視為 volume?? 這或許也是為什麼 bind mout 要搭配 absolute path 的關係??
  - [Use volumes \| Docker Documentation](https://docs.docker.com/storage/volumes/)
      - 這裡有張圖，bind mount 指向 file system，但 volume 則是指向 file system 裡特別劃分出來的 Docker area。另外提到 tmpfs mount 指向 memory，主要用來處理 non-persistent state data，避免寫入 container 的 writable layer 而影響到效能。
      - Use a read-only volume 提到 "For some DEVELOPMENT applications, the container needs to write into the bind mount so that changes are propagated back to the Docker host. At other times, the container only needs read access to the data."，顯然 bind mount 跟 volume 各有適用的場合，並非絕對地誰比誰好。
  - [Manage data in Docker \| Docker Documentation](https://docs.docker.com/storage/) #ril
      - Good use cases for bind mounts 一開始就提到 "you should use volumes where possible" !? 以為 volume 是最推的
  - [docker/README\.md at master · jenkinsci/docker](https://github.com/jenkinsci/docker/blob/master/README.md) Usage 提到儘量不要用 bind mount，因為可能會遇到 container 裡的 user (uid 1000) 無法寫入該 folder 的問題，可以用 `-u some_other_user` 來避開這個問題??

## Volume ??

  - `docker run --rm -it --volume VOLUME_NAME:/tmp/volume busybox ls /tmp/volume` 可以查看 `VOLUME_NAME` 的內容；這裡選用 BusyBox 做為輕量的 container。

參考資料：

  - [Use volumes \| Docker Documentation](https://docs.docker.com/storage/volumes/)
      - 就讓 container 儲放資料而言，volume 是比較好的機制，因為 bind mount 相依於 host machine 的 directory structure，而 volume 則完全由 Docker 管理。
      - Volume 之於 bind mount 的優點有 1) Volume 容易備份或遷移 (migrate) 2) 可以透過 Docker CLI/API 管理 3) 可以在多個 container 間共享 4) 透過 volume driver 可以將資料放 remote host 或 cloud privider，甚至是對內容加密等 5) 新的 volume 可以預先配置 (pre-populate) 一些內容。
      - 資料放 volume 也比放 container 的 writable layer 好，因為 volume 不會讓 container 變大，保存的內容也可以跳脫 container 的 lifecycle。
      - `docker volume create my-vol`、`docker volume ls`、`docker volume inspect my-vol`、`docker volume rm my-vol` 這些 `docker volume` 的用法都滿直覺的；`docker volume inspect` 看到的 `Mountpoint` 指的是什麼??
      - `docker run -d --name devtest --mount source=myvol2,target=/app nginx:latest`，這裡的 `--mount source=myvol2,target=/app` 是將 `myvol2` volume 掛到 `/app` 下，如果 volume 不存在則會自動建立，寫法也可以改成 `-v myvol2:/app`。用 `docker inspect devtest` 從 `Mounts:` section 可以確認 type (volume)、source、destination、RW (true)。
      - 接續上面 `--mount source=myvol2,target=/app` (或 `-v myvol2:/app`) 的例子，若 `myvol2` 是新建立的，它會將 destination 的內容先拷貝進 volume，然後開始使用該 volume；也就是說 image 可以提供 volume 的初始內容，這點還滿酷的!!
      - 若 volume 要以 read-only mode 掛載，`--mount` 後面可以再加 `readonly` (用逗號隔開 options)，例如 `--mount source=nginx-vol,destination=/usr/share/nginx/html,readonly`。
  - [Choose the -v or --mount flag - Use volumes \| Docker Documentation](https://docs.docker.com/storage/volumes/#choose-the--v-or---mount-flag)
      - 最早 `-v, --volume` 用在 standalone container，而 `--mount` 用在 swarm service，但 Docker 17.06 之後，`--mount` 也可以用在 standalone container。
      - `--mount` 的寫法是比較明確 (explicit and verbose)，而 `-v, --volume` 只是把多個 options 寫在一起而已。但為什麼又說 "New users should try --mount syntax which is SIMPLER than --volume syntax."
      - `-v, --volume` 由 3 個由 `:` 分隔的 field 組成 (問題就在 "the meaning of each field is not immediately obvious") -- volume name, mount point, comma-separated list of options (optional)，第 1 個欄位若沒有給，就是 anonymous volume (相對於 named volume 的說法)，例如 `-v /dbdata`。
      - `--mount` 則是 key-value pairs (用逗號分開) -- "but the order of the keys is not significant, and the value of the flag is easier to understand" 大概就是比較推 `--mount` 的原因。
      - `--mount` 的 key 有 `type=bind|volume|tmpfs`、`source=...` (或 `src`)、`destination=...` (或 `dst`、`target`)、`readonly` (flag 不用等號)、`volume-opt` (可以指定多次)，若 `source` 沒有提供，就是 anonymouse volume。
      - Remove volumes 提到 Anonymous volumes have no specific source so when the container is deleted, instruct the Docker Engine daemon to remove them. 也就是說 container 結束 anonymous volume 就不見了。
  - [VOLUME - Dockerfile reference \| Docker Documentation](https://docs.docker.com/v17.09/engine/reference/builder/#volume) #ril
      - `VOLUME ["/data"]` - The `VOLUME` instruction CREATES A MOUNT POINT with the specified name and MARKS it as holding externally mounted volumes from native host or other containers.
      - The `docker run` command initializes the newly created volume (跟路徑同名??) with any data that exists at the specified location within the base image.

            FROM ubuntu
            RUN mkdir /myvol
            RUN echo "hello world" > /myvol/greeting
            VOLUME /myvol

  - [Removal of implicit volumes - Installing using Docker \| Grafana Documentation](http://docs.grafana.org/installation/docker/#removal-of-implicit-volumes) Previously `/var/lib/grafana`, `/etc/grafana` and `/var/log/grafana` were defined as volumes in the `Dockerfile`. This led to the CREATION OF THREE VOLUMES each time a new instance of the Grafana container started, whether you wanted it or not. 自動會建立 volume，感覺有點惱人??

  - [docker volume create \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/volume_create/) #ril
  - [docker volume ls \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/volume_ls/#create-a-volume) #ril
  - [docker volume inspect \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/volume_inspect/) #ril
  - [docker volume prune \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/volume_prune/) #ril
  - [docker volume rm \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/volume_rm/) #ril
  - [Use a volume driver - Use volumes \| Docker Documentation](https://docs.docker.com/storage/volumes/#use-a-volume-driver) #ril
  - [Understanding Volumes in Docker \- Container Solutions](http://container-solutions.com/understanding-volumes-docker/) (2014-12-09) #ril
  - [How to list the content of a named volume in docker 1\.9\+? \- Stack Overflow](https://stackoverflow.com/questions/34803466/) 如何查看 volume 的內容?
      - Vaidas Lungis: 用 `docker volume inspect`，看 `Mountpoint` 的內容；但 `/var/lib/docker/volumes/[volume_name]/_data` 沒這個資料夾，被 container 使用中也沒有...
      - Manuel J. Garrido: 用一個輕量的 container (例如 busybox) 把 volume 掛上去，就能查看 volume 的內容。
  - [list contents of all docker volumes \| ForDoDone](https://fordodone.com/2017/12/15/list-contents-of-all-docker-volumes/) 也是用掛載到 container 的方式看 volume 的內容。

## Volume > Backup, Restore, Migration ??

  - [Backup, restore, or migrate data volumes - Use volumes \| Docker Documentation](https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes) #ril
      - Backup、restore 跟 migrate，都是 "新建 container"，搭配 `--volumes-from` 將另一個 container 的 volume 掛到自己身上 (create a new container that mounts that volume) -- volume 可以在多個 container 間共享的特性，接著對 volume 裡的資料處理...
      - `docker run --rm --volumes-from dbstore -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /dbdata` 為例：
     * 把 `dbstore` 這個 container 的 volume 掛到新的 container，同時用 bind mount 將 host PWD 掛到 `/backup`，在 container 裡就可以將 `/dbdata` (volume) 的資料打包起來放進 `/backup` (bind mount)；原來 volume 跟 bind mount 是可以這樣搭配使用的。
  - [Mount volumes from container (--volumes-from) - docker run \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/run/#mount-volumes-from-container---volumes-from)
      - `docker run --volumes-from 777f7dc92da7 --volumes-from ba8c0c54f0f2:ro -i -t ubuntu pwd`
      - `--volumes-from CONTAINER_ID[:MODE]` 可以把另一個 container 掛載的 volume 也都掛到自己身上 (mounts all the defined volumes from the referenced containers)，但掛到哪裡??
      - 在 `CONTAINER_ID` 後可以加上 `:ro`/`:rw` 指定掛載的方式 read-only 或 read-write mode，預設會採用 referenced container 相同的 mode。

## 透過 Volume 共用 Environment Variable ??

  - [Legacy container links \| Docker Documentation](https://docs.docker.com/network/links/) 提到 "you can use other mechanisms such as volumes to share environment variables between containers in a more controlled way."

## 參考資料 {: #reference }

