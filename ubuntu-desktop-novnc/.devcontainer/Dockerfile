# ベースイメージ
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

# 基本ツール・ロケール・Xfce4・VNC・noVNC のインストール
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y sudo vim curl git locales \
    xfce4 xfce4-goodies xterm dbus-x11 \
    tigervnc-standalone-server novnc websockify && \
    locale-gen ja_JP.UTF-8 && \
    update-locale LANG=ja_JP.UTF-8

# vscode ユーザー作成
RUN useradd -m -s /bin/bash vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER vscode
WORKDIR /home/vscode

# 環境変数
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8

# noVNC 用ポート
EXPOSE 6080

# コンテナ起動時に VNC を起動
CMD ["bash", "start-vnc.sh"]
