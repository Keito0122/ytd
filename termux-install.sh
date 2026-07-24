#!/data/data/com.termux/files/usr/bin/bash
# ytd インストールスクリプト (Termux用)
set -e

INSTALL_DIR="$HOME/.local/share/ytd"
BIN_DIR="$PREFIX/bin"

echo "▶ 依存パッケージを確認しています..."
pip install --upgrade yt-dlp pyyaml

echo "▶ ffmpeg を確認しています..."
if ! command -v ffmpeg >/dev/null 2>&1; then
    echo "  ffmpeg が見つかりません。pkg install ffmpeg を実行します。"
    pkg install -y ffmpeg
fi

echo "▶ ytd を $INSTALL_DIR に配置しています..."
mkdir -p "$INSTALL_DIR"
cp -r "$(dirname "$0")/com" "$INSTALL_DIR/"
cp -r "$(dirname "$0")/bin" "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/bin/ytd"

echo "▶ シンボリックリンクを作成しています..."
ln -sf "$INSTALL_DIR/bin/ytd" "$BIN_DIR/ytd"

echo "▶ Config ディレクトリを準備しています..."
mkdir -p "$HOME/.config/ytd"
if [ ! -f "$HOME/.config/ytd/config.yml" ]; then
    cp "$(dirname "$0")/config.yml.example" "$HOME/.config/ytd/config.yml"
    echo "  ~/.config/ytd/config.yml を作成しました。中身を編集して使ってください。"
fi

echo ""
echo "✔ インストール完了。以下のコマンドで使えます:"
echo "    ytd \"VIDEO_URL\""
echo "    ytd --help"
