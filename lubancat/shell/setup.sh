#!/bin/bash
# 安装SDK构建所需要的软件包
# 整体复制下面内容到终端中安装
apt-get update -y && apt-get -y install git ssh make gcc libssl-dev \
  liblz4-tool expect expect-dev g++ patchelf chrpath gawk texinfo chrpath \
  diffstat binfmt-support qemu-user-static live-build bison flex fakeroot \
  cmake gcc-multilib g++-multilib unzip device-tree-compiler ncurses-dev \
  libgucharmap-2-90-dev bzip2 expat gpgv2 cpp-aarch64-linux-gnu libgmp-dev \
  libmpc-dev bc python-is-python3 python3-pip python2 u-boot-tools curl \
  python3-pyelftools dpkg-dev

curl https://storage.googleapis.com/git-repo-downloads/repo >/bin/repo
# 如果上面的地址无法访问，可以用下面的：
# curl -sSL  'https://gerrit-googlesource.proxy.ustclug.org/git-repo/+/master/repo?format=TEXT' |base64 -d > ~/bin/repo
apt install -y fish rsync
chmod a+x /bin/repo
git config --global user.name 'rk'
git config --global user.email 'rk@rk.com'
