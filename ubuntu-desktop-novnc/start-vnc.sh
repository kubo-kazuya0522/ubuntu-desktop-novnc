#!/usr/bin/env bash
set -e

export DISPLAY=:1
export LANG=ja_JP.UTF-8

# VNC パスワード設定
mkdir -p ~/.vnc
echo "vncpass" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# 古い VNC セッションを終了
vncserver -kill :1 || true

# xstartup を作成
cat > ~/.vnc/xstartup <<'EOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
[ -x /usr/bin/startxfce4 ] && startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

# VNC サーバ起動
vncserver :1 -geometry 1280x800 -depth 24

# noVNC サーバ起動（バックグラウンド）
websockify --web=/usr/share/novnc/ 6080 localhost:5901 &
echo "✅ VNC & noVNC サーバ起動完了 → http://localhost:6080/"
# プロセスを終了させないように無限ループで待機
tail -f /dev/null
