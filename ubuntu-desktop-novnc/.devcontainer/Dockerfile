FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

# 基本ツール・Xfce4・VNC・noVNCのインストール
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y sudo vim curl git locales \
    xfce4 xfce4-goodies dbus-x11 xterm \
    tigervnc-standalone-server novnc websockify && \
    locale-gen ja_JP.UTF-8 && \
    update-locale LANG=ja_JP.UTF-8 && \
    useradd -m -s /bin/bash vscode && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER vscode
WORKDIR /home/vscode

ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8

EXPOSE 5901 6080

# コンテナ起動時に VNC と noVNC を起動
CMD ["bash", "start-vnc.sh"]
