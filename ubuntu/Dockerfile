FROM ubuntu:latest

ARG USER=ubuntu_test
ARG UID=1001
ARG GID=1001

ENV TZ=Asia/Shanghai

RUN groupadd -g $GID $USER && useradd -m -u $UID -g $GID -s /bin/bash $USER && \
    apt update && \
    apt install -y sudo && \
    echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    apt install -y tzdata && \
    ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

USER $USER
WORKDIR /home/$USER

