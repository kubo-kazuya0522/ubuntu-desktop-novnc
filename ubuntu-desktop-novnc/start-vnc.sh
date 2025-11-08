#!/usr/bin/env bash
set -e

export DISPLAY=:1
export LANG=ja_JP.UTF-8

# VNCパスワード設定
mkdir -p ~/.vnc
echo "vncpass" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# 古いVNCセッションを終了（再起動対策）
vncserver -kill :1 || true

# Xfce4デスクトップをVNC経由で起動
vncserver :1 -geometry 1280x800 -depth 24

# noVNC起動（6080ポートで待ち受け）
echo "✅ noVNCサーバ起動中 → http://localhost:6080/"
websockify --web=/usr/share/novnc/ 6080 localhost:5901
