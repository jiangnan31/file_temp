#!/usr/bin/env bash

source /etc/profile
cd `dirname $0`
echo "开始重启..."
# 终止进程
sh script/stop.sh
# 备份日志
sh script/backup.sh
# 启动服务
sh script/start.sh
echo "重启结束, 准备上线..."

