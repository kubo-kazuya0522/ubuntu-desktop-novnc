#!/usr/bin/env bash
set -e

export DISPLAY=:1
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# VNCパスワード設定
mkdir -p ~/.vnc
echo "vncpass" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# 古いVNCセッションを終了
vncserver -kill :1 || true

# XFCE4デスクトップをVNC経由で起動
echo "#!/bin/sh" > ~/.vnc/xstartup
echo "unset SESSION_MANAGER" >> ~/.vnc/xstartup
echo "unset DBUS_SESSION_BUS_ADDRESS" >> ~/.vnc/xstartup
echo "startxfce4 &" >> ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# VNCサーバ起動
vncserver :1 -geometry 1280x800 -depth 24

# noVNCサーバ起動
echo "✅ noVNCサーバ起動中 → http://localhost:6080/"
websockify --web=/usr/share/novnc/ 6080 localhost:5901
