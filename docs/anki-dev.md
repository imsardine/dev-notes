# Anki (Development)

## 基礎

### Hello, World! ??

### 概況 ??

  - [dae/anki: Anki for desktop computers](https://github.com/dae/anki) #ril
      - 沒有任何 release 及 tag，`requirements.txt` 也沒指定版號，不知道是如何做版本控制的?
      - 沒有 issues!? 但 PR 倒是滿活躍的。

## 安裝設定

  - [anki/README\.development at master · dae/anki](https://github.com/dae/anki/blob/master/README.development) #ril

### 安裝開發環境 (macOS)

  - [Windows & Mac users - anki/README\.development at master · dae/anki](https://github.com/dae/anki/blob/master/README.development) #ril
      - 需要 Python 3.6+、PyQT (Qt 5.9+)、mpv、lame
      - 需要 Xcode、Homebrew；其中 Homebrew 要安裝 mplayer、lame、portaudio 等套件。

    ```
$ brew install mplayer lame portaudio
$ pip install sqlalchemy pyqt5==5.9.2
    ```

      - 接著才回到一般的設定流程 `$ pip3 install -r requirements.txt`，可以用 `python3 -m venv venv-anki` 建立 virtual environment；為什麼 `requirements.txt` 裡都沒有指定版號?
      - 用 `./tools/build_ui.sh` 編譯，過程中沒有錯誤，就可以用 `./runanki` 執行。

## 參考資料

  - [dae/anki - GitHub](https://github.com/dae/anki)
