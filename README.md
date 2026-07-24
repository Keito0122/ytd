# ytd
yt-dlpのコマンドを短縮するサービス。フォーマットを変更する場合には、ffmpegが必要です。
---
### 注意このリポジトリはtermux用ytdです。その他のOSは下記のリポジトリから取得してください。
* [ytd-linux](https://github.com/Keito0122/ytd-linux/)
* [ytd-windows](https://github.com/Keito0122/ytd-windows)

ytd 仕様書

1. 概要

"ytd" は、"yt-dlp" を使った動画・音声ダウンロードを、短く分かりやすいコマンドで実行するための Termux 向けラッパーCLIである。
長い "yt-dlp" コマンドを毎回入力しなくても、統一されたオプションで素早く利用できることを目的とする。

---

2. リポジトリ構成

- リポジトリ名: "ytd"
- 論理パッケージ名: "com.keitodev.ytd"
- 実体構成: パッケージ名に対応するフォルダー階層を採用する

例:

com/
  keitodev/
    ytd/

---

3. 対象環境

- Termux
- Android
- "yt-dlp" が利用可能であること
- "ffmpeg" が利用可能であること
- Cookieファイルを使う場合は、事前に保存済みの ".txt" ファイルがあること

---

4. 目的

本ツールは次を簡単にする。

- 動画URLを入れるだけでダウンロード
- 出力形式を分かりやすく指定
- 品質を "1080p" のような表記で指定
- Cookieの有無を簡単に切り替え
- 保存先フォルダーを指定
- プレイリストをまとめて取得
- 長すぎるファイル名を自動で短縮
- ダウンロード済み動画の重複取得を防止し、再取得時は確認する

---

5. コマンド形式

基本形:

ytd "VIDEO_URL"

オプション付き:

ytd "VIDEO_URL" --option value

URLは必須。オプションはすべて "--" 形式で統一する。

---

6. 動作方針

- ユーザーは "yt-dlp" の細かい内部オプションを意識しなくてよい
- 入力された分かりやすいオプションを内部で "yt-dlp" に変換する
- 省略された項目は Config の既定値を使用する
- Config が無い場合は安全なデフォルト値を使用する

---

7. 主要機能

7.1 出力フォーマット指定

指定例:

ytd "VIDEO_URL" --format mp4
ytd "VIDEO_URL" --format mp3
ytd "VIDEO_URL" --format flac

対応フォーマット例:

- "mp4"
- "webm"
- "mkv"
- "mp3"
- "m4a"
- "aac"
- "wav"
- "flac"
- "opus"
- "ogg"

動作:

- "mp4" などの動画形式は、映像＋音声を取得して結合する
- "mp3" などの音声形式は、音声抽出として扱う

---

7.2 品質指定

指定例:

ytd "VIDEO_URL" --quality best
ytd "VIDEO_URL" --quality 1080p
ytd "VIDEO_URL" --quality 720p

動画品質の表記は、必ず "1080p" のように "p" 付きで分かりやすくする。
音声品質は別途ビットレート指定も許可する。

対応例:

- "best"
- "2160p"
- "1440p"
- "1080p"
- "720p"
- "480p"
- "360p"
- "240p"
- "144p"

音声品質例:

- "320k"
- "256k"
- "192k"
- "128k"

---

7.3 Cookie指定

指定例:

ytd "VIDEO_URL" --cookie
ytd "VIDEO_URL" --cookie /storage/emulated/0/Download/cookies.txt

動作:

- "--cookie" のみ指定された場合は Config に設定された既定Cookieを使用する
- パスが指定されている場合は、そのCookieファイルを使用する
- Config にもCookieがない場合は Cookie なしで実行する

---

7.4 保存先指定

指定例:

ytd "VIDEO_URL" --output /storage/emulated/0/Movies

動作:

- 指定フォルダーへ保存する
- 未指定時は Config の保存先を使用する

---

7.5 プレイリスト対応

指定例:

ytd "PLAYLIST_URL" --playlist

動作:

- 通常は単体動画を対象とする
- "--playlist" 指定時はプレイリスト全体を取得する

---

7.6 ファイル名の自動短縮

通常は動画タイトルをファイル名に使う。
ただし長すぎる場合は自動で短縮する。

短縮ルール:

- "Webサイト名 + ID"
- もしくは "Webサイト名 + URL由来ID"

例:

- "YouTube_dQw4w9WgXcQ.mp4"
- "Niconico_sm12345678.mp4"

目的:

- 長いタイトルによる扱いづらさを防ぐ
- Android上での表示・保存の不便さを減らす
- 重複ファイル名を避けやすくする

---

7.7 ダウンロード済み管理

既に取得済みの動画を再度指定した場合、いきなり上書きせず警告を出す。

表示例:

⚠ この動画は既にダウンロードされています。

もう一度ダウンロードしますか？
[Y] Yes
[N] No

動作:

- "Y" を選ぶと再ダウンロード
- "N" を選ぶと中止
- デフォルトは "No"

---

7.8 ヘルプ表示

"--help" で以下を表示する。

- コマンド一覧
- 各コマンドの用途
- 最高品質でのコマンド例
- 代表的な使い方の例

ヘルプは、初見でも迷わない内容にする。

---

8. コマンド一覧

オプション| 用途
"--format"| 出力形式を指定する
"--quality"| 品質を指定する
"--cookie"| Cookieを使う、またはCookieのパスを指定する
"--output"| 保存先フォルダーを指定する
"--playlist"| プレイリスト全体を取得する
"--audio"| 音声のみ取得する
"--video-only"| 映像のみ取得する
"--subtitle"| 字幕を保存する
"--embed-subtitle"| 字幕を埋め込む
"--thumbnail"| サムネイルを保存する
"--embed-thumbnail"| サムネイルを埋め込む
"--metadata"| メタデータを埋め込む
"--archive"| ダウンロード済み管理を行う
"--info"| 動画情報のみ表示する
"--list-format"| 利用可能フォーマット一覧を表示する
"--list-subtitle"| 利用可能字幕一覧を表示する
"--update"| "yt-dlp" を更新する
"--help"| ヘルプを表示する

---

9. 代表的な使用例

9.1 最高品質で保存

ytd "VIDEO_URL"

9.2 1080p指定

ytd "VIDEO_URL" --quality 1080p

9.3 MP3で保存

ytd "VIDEO_URL" --format mp3

9.4 Cookieを使って保存

ytd "VIDEO_URL" --cookie

9.5 Cookieファイルを指定

ytd "VIDEO_URL" --cookie /storage/emulated/0/Download/cookies.txt

9.6 保存先を指定

ytd "VIDEO_URL" --output /storage/emulated/0/Movies

9.7 プレイリストを取得

ytd "PLAYLIST_URL" --playlist

9.8 最高品質のコマンド例

ytd "VIDEO_URL"

このコマンドはデフォルトで最高品質の動画取得を行う。

---

10. Config

10.1 目的

Config は、毎回入力したくない定番設定を保存するために使う。

10.2 想定保存場所

~/.config/ytd/config.yml

10.3 設定例

cookie: /storage/emulated/0/Download/cookies.txt
output: /storage/emulated/0/Download
format: mp4
quality: best
playlist: false
embed_thumbnail: true
embed_metadata: true
filename_max_length: 120
archive: true

---

11. 優先順位

設定の優先順位は以下とする。

1. コマンドライン引数
2. Config
3. デフォルト値

---

12. デフォルト値

- 形式: "mp4"
- 品質: "best"
- プレイリスト: "false"
- Cookie: なし
- 保存先: Configの値、なければ既定フォルダー
- ダウンロード済み管理: 有効
- ファイル名短縮: 有効

---

13. ヘルプに含める例

ヘルプ表示では必ず以下を含める。

- "ytd "VIDEO_URL""
- "ytd "VIDEO_URL" --quality 1080p"
- "ytd "VIDEO_URL" --format mp3"
- "ytd "VIDEO_URL" --cookie"
- "ytd "VIDEO_URL" --output /storage/emulated/0/Movies"
- "ytd "PLAYLIST_URL" --playlist"

---

14. 今後の拡張候補

- "--proxy"
- "--rate-limit"
- "--retry"
- "--verbose"
- "--json"
- "--batch"

---

15. 受け入れ条件

以下を満たせば、仕様として完成とする。

- "ytd "VIDEO_URL"" で実行できる
- "--quality 1080p" のような表記で品質指定できる
- "--cookie" で Config のCookieを使える
- "--cookie PATH" で任意Cookieを使える
- "--output" で保存先を変えられる
- "--playlist" でプレイリスト対応できる
- ファイル名が長すぎると自動短縮される
- 再取得時は警告を出して Yes/No を聞く
- "--help" で一覧・用途・最高品質の例を表示できる
