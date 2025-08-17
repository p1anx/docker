#!/bin/bash

# Nextcloud 备份脚本 - 基于本地目录挂载
# 使用方法: ./backup.sh

BACKUP_DIR="./backups/$(date +%Y%m%d_%H%M%S)"
CURRENT_DIR=$(pwd)

echo "开始备份 Nextcloud..."
echo "当前目录: $CURRENT_DIR"
echo "备份目录: $BACKUP_DIR"

# 创建备份目录
mkdir -p "$BACKUP_DIR"

# 1. 启用维护模式
echo "启用维护模式..."
docker exec -u www-data nextcloud_app php occ maintenance:mode --on

# 2. 停止 Nextcloud 服务（保持数据库运行）
echo "停止 Nextcloud 服务..."
docker stop nextcloud_app

# 3. 备份数据库
echo "备份数据库..."
docker exec nextcloud_db mysqldump \
  -u nextcloud \
  -pnextcloud \
  nextcloud >"$BACKUP_DIR/database.sql"

# 4. 备份本地数据目录
echo "备份 Nextcloud 数据目录..."
if [ -d "./nextcloud_data" ]; then
  tar czf "$BACKUP_DIR/nextcloud_data.tar.gz" -C . nextcloud_data
  echo "nextcloud_data 目录已备份"
else
  echo "警告: nextcloud_data 目录不存在"
fi

if [ -d "./config" ]; then
  tar czf "$BACKUP_DIR/config.tar.gz" -C . config
  echo "config 目录已备份"
else
  echo "警告: config 目录不存在"
fi

if [ -d "./db_data" ]; then
  tar czf "$BACKUP_DIR/db_data.tar.gz" -C . db_data
  echo "db_data 目录已备份"
else
  echo "警告: db_data 目录不存在"
fi

# 5. 备份配置文件
echo "备份配置文件..."
cp docker-compose.yml "$BACKUP_DIR/"
[ -f ".env" ] && cp .env "$BACKUP_DIR/"

# 6. 重新启动服务
echo "重新启动服务..."
docker start nextcloud_app

# 等待服务启动
sleep 10

# 7. 关闭维护模式
echo "关闭维护模式..."
docker exec -u www-data nextcloud_app php occ maintenance:mode --off

echo ""
echo "========================================="
echo "备份完成！"
echo "========================================="
echo "备份位置: $BACKUP_DIR"
echo "备份内容:"
ls -lah "$BACKUP_DIR"
echo ""
echo "迁移时请将整个备份目录传输到目标服务器"
