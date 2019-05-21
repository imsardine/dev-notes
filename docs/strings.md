# strings

```
strings FILE...
```

---

參考資料：

  - [Binutils \- GNU Project \- Free Software Foundation](https://www.gnu.org/software/binutils/) 也是 GNUA Binutils 的一員。

  - [strings\(1\) — binutils — Debian stretch — Debian Manpages](https://manpages.debian.org/stretch/binutils/strings.1.en.html) #ril

      - Prints the printable character sequences that are at least 4 characters long (可調整) and are followed by an unprintable character. 就一般的字串而言，那個 unprintable character 就是 `\0`。
      - Default to either displaying all the printable sequences that it can find in each file, or only those sequences that are in loadable, initialized data sections (若這是個 object file 的話). If the file type in unrecognizable, or if strings is reading from stdin then it will always display all of the printable sequences that it can find. 這表示可以用在所有的 binary!! 呼應了 `strings` is mainly useful for determining the contents of non-text files 的說法 (用在 text file 沒有什麼意義)

## 參考資料 {: #reference }

手冊：

  - [`strings`(1) - Debian Manpages](https://manpages.debian.org/stretch/binutils/strings.1.en.html)
  - [`strings` - FreeBSD Manual Pages](https://www.freebsd.org/cgi/man.cgi?query=strings)
  - [`strings`(1) - Mac OS X 10.12.6](http://www.manpagez.com/man/1/strings/osx-10.12.6.php)
  - [`strings` - GNU Binary Utilities](https://sourceware.org/binutils/docs-2.31/binutils/strings.html)
