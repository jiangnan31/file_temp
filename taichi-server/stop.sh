#!/usr/bin/env bash

source /etc/profile
cd `dirname $0`
echo "开始停服, 准备下线..."
# 停止服务
sh script/stop.sh
echo "停服结束"