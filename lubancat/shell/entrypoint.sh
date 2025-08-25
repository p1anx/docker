#!/bin/bash
USER_NAME=rk
LUBANCAT_DATA_DIR=/home/$USER_NAME/data
LUBANCAT_SDK_DIR=/home/$USER_NAME/lubancat_sdk
ROOTFS=debian11
# ENTRYPOINT_DIR=/
# 创建初始化脚本
# touch /entrypoint.sh
set -e
# 检查工作目录是否为空
if [ -z "$(ls -A ${LUBANCAT_SDK_DIR} 2>/dev/null)" ]; then
  echo "Initializing application data..."
  sudo cp -r ${LUBANCAT_DATA_DIR}/* ${LUBANCAT_SDK_DIR}
  echo "Application data initialized."
fi

# 确保权限正确
sudo chown -R 1000:1000 ${LUBANCAT_SDK_DIR}

sudo apt-get install binfmt-support qemu-user-static
cd $LUBANCAT_SDK_DIR
sudo dpkg -i $ROOTFS/ubuntu-build-service/packages/*
sudo update-binfmts --enable
# 执行传入的命令
exec "$@"
