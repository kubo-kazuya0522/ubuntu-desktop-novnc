#!/usr/bin/env bash
set -e

# ロケールを強制
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export LANGUAGE=ja_JP:ja
export DISPLAY=:1

# VNC パスワード設定
mkdir -p ~/.vnc
echo "vncpass" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# 古い VNC セッションを終了（再起動対策）
vncserver -kill :1 || true

# Xfce4 デスクトップを VNC 経由で起動
echo "#!/bin/bash" > ~/.vnc/xstartup
echo "startxfce4 &" >> ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

vncserver :1 -geometry 1280x800 -depth 24

# noVNC 起動
echo "✅ noVNC サーバ起動中 → http://localhost:6080/"
websockify --web=/usr/share/novnc/ 6080 localhost:5901
