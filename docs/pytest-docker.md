---
title: pytest / Docker
---
# [pytest](pytest.md) / Docker

## 測試過程中自動啟動/刪除 Container??

  - CI 的 build script 在測試前後自動啟動/刪除 container 是可行，但測試本身就不會 self-contained，

參考資料：

  - [AndreLouisCaron/pytest\-docker: Docker\-based integration tests](https://github.com/AndreLouisCaron/pytest-docker) 方便寫涉及 Docker containers 的 integration test -- 利用 Docker Compose 在測試期間啟動/停止 containers #ril
  - [Testing Python in Docker containers with Jenkins \- stdout \- Roman Tsukanov](https://stdout.roman.zone/jenkins-docker-python) #ril
  - [Testing Python in Docker containers with Jenkins \- stdout \- Roman Tsukanov](https://stdout.roman.zone/jenkins-docker-python) (2016-10-24) 讓測試 (pytest) 執行在 container 裡，但整個測試前後利用 script 啟動/停止 container，測試完再從 container 裡取出 test result #ril

## 檢驗包裝出來的 Docker Image??

  - [nvbn/pytest\-docker\-pexpect: pytest plugin for writing functional tests with pexpect and docker](https://github.com/nvbn/pytest-docker-pexpect) 提供 `spawnu` fixture，用以執行 `spawnu(tag, dockerfile, command)` 並拿到 child application，感覺測試對象是 image 而非 application? #ril
  - [py\.test plugin for functional testing with Docker \| nvbn blog](https://nvbn.github.io/2015/09/09/pytest-docker/) (2015-09-09) 作者說明 `pytest-docker-pexpect` plugin 的用法 #ril
  - [Test Docker images - Examples — testinfra 1\.10\.0 documentation](http://testinfra.readthedocs.io/en/latest/examples.html#test-docker-images) `testinfra.get_host("docker://" + docker_id)` 可以直接連到 container，`host.check_output('myapp -v')` 就能檢查執行 command 的結果 #ril

