#!/bin/bash

# **************jenkins 备份脚本
# 用法：脚本中修改JENKINS_HOME和BACKUP_DIR为指定的地址，然后执行脚本即可了
# *************

JENKINS_HOME="xxx"
# 备份存储目录
BACKUP_DIR="/data/backup/jenkins"
# 当前日期
DATE=$(date +'%Y%m%d_%H%M%S')
# 备份文件名
BACKUP_FILE="jenkins_full_backup_$DATE.tar.gz"

# 检查 Jenkins 是否存在
if [ ! -d "$JENKINS_HOME" ]; then
  echo "Jenkins home directory does not exist at $JENKINS_HOME"
  exit 1
fi

# 创建备份目录（如果不存在）
mkdir -p "$BACKUP_DIR"

# 执行备份，排除日志、构建历史、工作区
echo "Starting full backup of Jenkins at $JENKINS_HOME..."
tar --exclude="jobs/*/builds" \
    --exclude="jobs/*/workspace" \
    --exclude="logs" \
    --exclude="tmp" \
    -czf "$BACKUP_DIR/$BACKUP_FILE" -C "$JENKINS_HOME" .

# 检查备份是否成功
if [ $? -eq 0 ]; then
  echo "Backup completed successfully: $BACKUP_DIR/$BACKUP_FILE"
else
  echo "Backup failed"
  exit 2
fi