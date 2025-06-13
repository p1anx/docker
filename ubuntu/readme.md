# 在 Dockerfile 中设置时区
```Dockerfile
FROM ubuntu:latest

ENV TZ=Asia/Shanghai

RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# 设置用户并配置无需密码的 sudo 权限
```Dockerfile
FROM ubuntu:latest

ARG USER=developer
ARG UID=1001
ARG GID=1001

RUN groupadd -g $GID $USER && useradd -m -u $UID -g $GID -s /bin/bash $USER && \
    apt update && \
    apt install -y sudo && \
    echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
```
```
