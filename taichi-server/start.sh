#!/usr/bin/env bash

source /etc/profile
cd `dirname $0`
echo "开始启动..."
# 启动服务
sh script/start.sh
echo "启动结束, 准备上线..."