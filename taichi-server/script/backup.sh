#!/usr/bin/env bash
echo '备份nohup及gc日志文件...'
datetimes=$(date +%Y%m%d%H%M%S)
cp taichi_server.start.log logs/taichi_server.start_$datetimes.log
cp logs/gc.log logs/putty.gc_$datetimes.log
echo '删除nohup及gc日志文件...'
rm -rf nohup.out logs/gc.log
echo '备份完成.'