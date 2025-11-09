#!/bin/bash
set -e

# デフォルト VNC パスワード
VNC_PASS=${VNC_PASS:-vscode}

# .vnc ディレクトリ作成
mkdir -p /home/vscode/.vnc
chmod 700 /home/vscode/.vnc
echo "$VNC_PASS" | vncpasswd -f > /home/vscode/.vnc/passwd
chmod 600 /home/vscode/.vnc/passwd

# 既存 VNC サーバーを停止
if pgrep Xtigervnc > /dev/null; then
    vncserver -kill :1 || true
fi

# VNC サーバー起動
vncserver :1 -geometry 1920x1080 -depth 24 -fg

# noVNC 起動
/home/vscode/noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 6080 &
echo "VNC server started on display :1 (port 5901)"
echo "noVNC available at http://localhost:6080"
