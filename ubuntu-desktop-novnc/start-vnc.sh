#!/usr/bin/env bash
set -e

# 環境設定
export DISPLAY=:1
export LANG=ja_JP.UTF-8

# VNCパスワード設定
mkdir -p ~/.vnc
echo "vncpass" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# xstartupファイル作成（XFCE4を使用）
cat > ~/.vnc/xstartup <<'EOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

# 古いVNCセッションを終了（再起動対策）
vncserver -kill :1 || true

# VNCサーバ起動
vncserver :1 -geometry 1280x800 -depth 24

# noVNC起動（ポート6080で待ち受け）
echo "✅ noVNCサーバ起動中 → http://localhost:6080/"
pkill -f "websockify .* localhost:5901" > /dev/null 2>&1 || true
websockify --web=/usr/share/novnc/ 6080 localhost:5901 &
