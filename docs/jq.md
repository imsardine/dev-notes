# jq

  - [bash \- Parsing JSON with Unix tools \- Stack Overflow](https://stackoverflow.com/questions/1955505/) 感覺很適合搭配 shell scripting #ril

## Hello, World!

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

## 新手上路 {: #getting-started }

  - [Tutorial](https://stedolan.github.io/jq/tutorial/) #ril

      - GitHub has a JSON API, so let's play with that. This URL gets us the last 5 commits from the jq repo.

            curl 'https://api.github.com/repos/stedolan/jq/commits?per_page=5'

        結果是 `[{commit1}, {commit2}, ...]`，其中 `{commit}` 的結構為 `{commit: {mesage, committer: {name}}}`

      - GitHub returns nicely formatted JSON. For servers that don't, it can be helpful to pipe the response through jq to pretty-print it. The simplest jq program is the expression `.`, which takes the input and produces it UNCHANGED as output.

            curl 'https://api.github.com/repos/stedolan/jq/commits?per_page=5' | jq '.'

        至少有 pretty-print 的效果。

      - We can use jq to extract just the first commit.

            curl 'https://api.github.com/repos/stedolan/jq/commits?per_page=5' | jq '.[0]'

        For the rest of the examples, I'll leave out the `curl` command - it's not going to change.

      - There's a lot of info we don't care about there, so we'll restrict it down to the most interesting fields.

            jq '.[0] | {message: .commit.message, name: .commit.committer.name}'

        `.[0]` 中的 `.` 可以解讀為 root element，其他的 `.` 可以往下展開其他 element。

        The `|` operator in jq feeds the output of one filter (`.[0]` which gets the first element of the array in the response) into the input of another (`{...}` which BUILDS an object out of those fields). You can access nested attributes, such as `.commit.message`.

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
