#!/bin/bash
set -e

setxkbmap jp

# デフォルト VNC パスワード
VNC_PASS=${VNC_PASS:-vscode}

# .vnc ディレクトリ作成
mkdir -p /home/vscode/.vnc
chmod 700 /home/vscode/.vnc

# パスワードを設定
echo "$VNC_PASS" | vncpasswd -f > /home/vscode/.vnc/passwd
chmod 600 /home/vscode/.vnc/passwd

# 既存の VNC サーバーがあれば停止
if pgrep Xtightvnc > /dev/null; then
    echo "Stopping existing VNC server..."
    vncserver -kill :1 || true
fi

# XFCE4 デスクトップ起動
echo "Starting VNC server..."
vncserver :1 -geometry 1920x1080 -depth 24 -fg

# 何かトラブル時にログ確認
echo "VNC server started on display :1"
echo "Connect via noVNC at http://localhost:6080"
