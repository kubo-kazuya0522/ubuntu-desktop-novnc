# ベースイメージ
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8

# 基本ツール・Xfce4・VNC・noVNC のインストール
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y sudo vim curl git locales xfce4 xfce4-goodies xterm dbus-x11 \
    tigervnc-standalone-server python3 python3-pip wget && \
    locale-gen ja_JP.UTF-8 && update-locale LANG=ja_JP.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

# vscode ユーザー作成
RUN useradd -m -s /bin/bash vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER vscode
WORKDIR /home/vscode

# noVNC の最新版を GitHub から取得
RUN git clone https://github.com/novnc/noVNC.git ~/noVNC && \
    git clone https://github.com/novnc/websockify.git ~/noVNC/utils/websockify

# noVNC 用ポート
EXPOSE 6080

# コンテナ起動時に VNC + noVNC を起動
CMD ["bash", "start-vnc.sh"]
