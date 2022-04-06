#!/usr/bin/env bash
PuttyID=`jps | grep 'TaichiServerApplication' | awk -F ' ' '{print $1}'`
echo "终止TaichiServerApplication进程: $PuttyID ..."
jps | grep 'TaichiServerApplication'| awk -F ' ' '{print $1}' | xargs kill -9
echo '等待2s...'
sleep 2s
echo '执行完成.'