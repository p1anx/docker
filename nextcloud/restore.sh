#!/bin/bash

# Nextcloud 恢复脚本 - 基于本地目录挂载
# 使用方法: ./restore.sh /path/to/backup/folder

BACKUP_DIR="$1"
CURRENT_DIR=$(pwd)

NEXTCLOUD_CONTAINER="nextcloud_app"
DB_CONTAINER="nextcloud_db"

if [ -z "$BACKUP_DIR" ] || [ ! -d "$BACKUP_DIR" ]; then
  echo "用法: $0 <备份目录路径>"
  echo "例如: $0 ./backups/20231201_143000"
  exit 1
fi

echo "从 $BACKUP_DIR 恢复 Nextcloud..."
echo "目标目录: $CURRENT_DIR"

# 1. 停止现有服务（如果存在）
echo "停止现有服务..."
#docker compose down 2>/dev/null || true
docker rm -f $NEXTCLOUD_CONTAINER
docker rm -f $DB_CONTAINER

# 2. 备份现有数据（如果存在）
if [ -d "./nextcloud_data" ] || [ -d "./config" ] || [ -d "./db_data" ]; then
  echo "检测到现有数据，创建安全备份..."
  SAFETY_BACKUP="./safety_backup_$(date +%Y%m%d_%H%M%S)"
  mkdir -p "$SAFETY_BACKUP"

  [ -d "./nextcloud_data" ] && mv ./nextcloud_data "$SAFETY_BACKUP/"
  [ -d "./config" ] && mv ./config "$SAFETY_BACKUP/"
  [ -d "./db_data" ] && mv ./db_data "$SAFETY_BACKUP/"

  echo "现有数据已备份到: $SAFETY_BACKUP"
fi

# 3. 恢复配置文件
echo "恢复配置文件..."
[ -f "$BACKUP_DIR/docker-compose.yml" ] && cp "$BACKUP_DIR/docker-compose.yml" ./
[ -f "$BACKUP_DIR/.env" ] && cp "$BACKUP_DIR/.env" ./

# 4. 恢复数据目录
echo "恢复数据目录..."

if [ -f "$BACKUP_DIR/nextcloud_data.tar.gz" ]; then
  echo "恢复 nextcloud_data..."
  tar xzf "$BACKUP_DIR/nextcloud_data.tar.gz" -C .
fi

if [ -f "$BACKUP_DIR/config.tar.gz" ]; then
  echo "恢复 config..."
  tar xzf "$BACKUP_DIR/config.tar.gz" -C .
fi

if [ -f "$BACKUP_DIR/db_data.tar.gz" ]; then
  echo "恢复 db_data..."
  tar xzf "$BACKUP_DIR/db_data.tar.gz" -C .
fi

# 5. 设置正确的文件权限
echo "设置文件权限..."
[ -d "./nextcloud_data" ] && sudo chown -R www-data:www-data ./nextcloud_data
[ -d "./config" ] && sudo chown -R www-data:www-data ./config

# 6. 启动数据库服务
echo "启动数据库服务..."
docker compose up -d db

# 等待数据库启动
echo "等待数据库启动..."
sleep 15

# 7. 恢复数据库（如果有 SQL 备份）
if [ -f "$BACKUP_DIR/database.sql" ]; then
  echo "恢复数据库..."
  # 等待数据库完全启动
  until docker exec nextcloud_db mysqladmin ping -h localhost --silent; do
    echo "等待数据库准备就绪..."
    sleep 2
  done

  # 导入数据库
  docker exec -i nextcloud_db mysql -u nextcloud -pnextcloud nextcloud <"$BACKUP_DIR/database.sql"
  echo "数据库恢复完成"
fi

# 8. 启动 Nextcloud 服务
echo "启动 Nextcloud 服务..."
docker compose up -d

# 9. 等待服务启动
echo "等待服务启动..."
sleep 30

# 10. 运行数据库修复和优化
echo "运行数据库检查和修复..."
docker exec -u www-data nextcloud_app php occ maintenance:mode --on
docker exec -u www-data nextcloud_app php occ db:add-missing-indices
docker exec -u www-data nextcloud_app php occ db:add-missing-columns
docker exec -u www-data nextcloud_app php occ files:scan --all
docker exec -u www-data nextcloud_app php occ maintenance:mode --off

echo ""
echo "========================================="
echo "恢复完成！"
echo "========================================="
echo "请访问 http://localhost:8888 检查 Nextcloud"
echo ""
echo "如果遇到问题，可以查看日志："
echo "docker-compose logs -f nextcloud"
echo "docker-compose logs -f db"
