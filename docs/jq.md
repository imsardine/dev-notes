# jq

  - [bash \- Parsing JSON with Unix tools \- Stack Overflow](https://stackoverflow.com/questions/1955505/) 感覺很適合搭配 shell scripting #ril

## Hello, World! ??

```
$ curl https://httpbin.org/get?greeting=Hello%2C+World%21 | jq . > output.json
$ cat output.json
{
  "args": {
    "greeting": "Hello, World!"
  },
  "headers": {
    "Accept": "*/*",
    "Connection": "close",
    "Host": "httpbin.org",
    "User-Agent": "curl/7.54.0"
  },
  "origin": "192.168.1.1",
  "url": "https://httpbin.org/get?greeting=Hello%2C+World!"
}
```

參考資料

  - `... | jq > output.json` 會失敗，至少要加上 `-r .` 才行。

## CLI ??

```
jq [OPTION]... FILTER [FILE]...
```

參考資料：

  - [Ubuntu Manpage: jq](http://manpages.ubuntu.com/manpages/bionic/man1/jq.1.html) #ril
      - 基本用法是 `jq [OPTION]... FILTER [FILE]...`，注意 `FILTER` 是必要的。
      - `--raw-output / -r` -- 如果 filter 的 output 是個 string，就直接寫到 STDOUT，不太懂 "making jq filters talk to non-JSON-based systems." 的意思。

## Filter ??

  - [Basic filters - jq Manual \(development version\)](https://stedolan.github.io/jq/manual/#Basicfilters) 可以用來取出 JSON 欄位資料，超級複雜!! #ril

## 安裝設置 {: #setup }

### macOS

```
brew install jq
```

參考資料：

  - [Download jq](https://stedolan.github.io/jq/download/) 用 `brew install jq`

## 參考資料 {: #reference }

  - [jq](https://stedolan.github.io/jq/)
  - [stedolan/jq - GitHub](https://github.com/stedolan/jq)

手冊：

  - [Ubuntu Manpage: jq](http://manpages.ubuntu.com/manpages/bionic/man1/jq.1.html)
  - [Basic filters - jq Manual](https://stedolan.github.io/jq/manual/#Basicfilters)
