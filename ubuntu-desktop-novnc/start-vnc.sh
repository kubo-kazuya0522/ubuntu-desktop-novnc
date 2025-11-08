#!/bin/bash
set -e

# ===== ロケール設定 =====
export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP:ja
export LC_ALL=ja_JP.UTF-8

# ===== VNCパスワード設定 =====
mkdir -p ~/.vnc
echo "vscode" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# ===== xstartup設定（XFCE4起動）=====
cat > ~/.vnc/xstartup <<'EOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

# ===== VNCサーバ再起動 =====
vncserver -kill :1 > /dev/null 2>&1 || true
vncserver :1 -geometry 1280x800 -depth 24

echo "✅ VNC サーバ起動完了 (:1)"

# ===== noVNC起動 =====
~/noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 6080 &
echo "✅ noVNC サーバ起動中 → http://localhost:6080/"

# ===== コンテナを維持 =====
tail -f /dev/null
