#!/bin/bash
set -e

# locale 設定
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8

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

# 日本語キーボード設定
DISPLAY=:1 setxkbmap jp || true

echo "VNC server started on display :1"
echo "Connect via noVNC at http://localhost:6080"
