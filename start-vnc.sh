#!/bin/bash
set -e

# ロケール設定
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8

# 日本語キーボード
setxkbmap jp || true

# デフォルト VNC パスワード
VNC_PASS=${VNC_PASS:-vscode}

# .vnc ディレクトリ作成
mkdir -p /home/vscode/.vnc
chmod 700 /home/vscode/.vnc

# パスワード設定
echo "$VNC_PASS" | vncpasswd -f > /home/vscode/.vnc/passwd
chmod 600 /home/vscode/.vnc/passwd

# 既存の VNC サーバーを強制停止
vncserver -kill :1 || true

# XFCE4 デスクトップ起動
echo "Starting VNC server..."
vncserver :1 -geometry 1920x1080 -depth 24 -fg

echo "VNC server started on display :1"
echo "Connect via noVNC at http://localhost:6080"
