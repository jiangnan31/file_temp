#!/usr/bin/env bash
APP_HOME=$(cd "$(dirname "$0")"; cd ..; pwd)
echo "APP_HOME: $APP_HOME"
echo '等待2s启动服务...'
sleep 2s
JAVA_PROPERTIES=" -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true "
JAVA_OPTS="-server"

JAVA_OPTS="${JAVA_OPTS} -Xms2g -Xmx2g"
JAVA_OPTS="${JAVA_OPTS} -Xmn2g"

JAVA_OPTS="${JAVA_OPTS} -XX:PermSize=96m -XX:MaxPermSize=256m"
JAVA_OPTS="${JAVA_OPTS} -XX:SurvivorRatio=10"
JAVA_OPTS="${JAVA_OPTS} -XX:+UseConcMarkSweepGC -XX:+UseCMSCompactAtFullCollection -XX:CMSMaxAbortablePrecleanTime=5000 -XX:+CMSClassUnloadingEnabled -XX:CMSInitiatingOccupancyFraction=80"
JAVA_OPTS="${JAVA_OPTS} -XX:+DisableExplicitGC"
JAVA_OPTS="${JAVA_OPTS} -verbose:gc -Xloggc:logs/gc.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps"
JAVA_OPTS="${JAVA_OPTS} -XX:+UseCompressedOops"
JAVA_OPTS="${JAVA_OPTS} -Djava.awt.headless=true"
JAVA_OPTS="${JAVA_OPTS} -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=logs/java.hprof"
JAVA_OPTS="${JAVA_OPTS} -XX:MaxDirectMemorySize=1g"
JAVA_OPTS="${JAVA_OPTS} -XX:+UseCMSInitiatingOccupancyOnly"
JAVA_OPTS="${JAVA_OPTS} -XX:+ExplicitGCInvokesConcurrent -Dsun.rmi.dgc.server.gcInterval=2592000000 -Dsun.rmi.dgc.client.gcInterval=2592000000"
JAVA_OPTS="${JAVA_OPTS} -Dsun.net.client.defaultConnectTimeout=10000"
JAVA_OPTS="${JAVA_OPTS} -Dsun.net.client.defaultReadTimeout=30000"

# ClusterMessageManager MAX_WORKER_SIZE异常问题
#JAVA_OPTS="${JAVA_OPTS} -XX:ActiveProcessorCount=4"
#JAVA_OPTS="${JAVA_OPTS} -agentlib:jdwp=transport=dt_socket,address=9993,suspend=n,server=y"

CLASSPATH=algo_taichi_server.jar
# 追加plugins到CLASSPATH
for jar in `ls plugins/.`; do
  if [ "${jar##*.}"x = "jar"x ]; then
    CLASSPATH="${CLASSPATH}:./plugins/$jar"
  fi
done
# 遍历应用程序依赖的jar包，并加入CLASSPATH
for jar in `ls lib/.`; do
  if [ "${jar##*.}"x = "jar"x ]; then
    CLASSPATH="${CLASSPATH}:./lib/$jar"
  fi
done


cd ${APP_HOME}
echo "启动命令: java $JAVA_PROPERTIES $JAVA_OPTS -cp $CLASSPATH com.mogujie.algo.taichi.server.TaichiServerApplication" > taichi_server.start.log
nohup java $JAVA_PROPERTIES $JAVA_OPTS -cp $CLASSPATH com.mogujie.algo.taichi.server.TaichiServerApplication >> taichi_server.start.log &
echo '正在启动...'
sleep 2s

SERVER_NAME='TaichiServerApplication'
ProcessFlag=false
PROCESS_NUMS=`ps -ef | grep ${SERVER_NAME} | grep -v grep | grep -v $0 | wc -l`
if [ ${PROCESS_NUMS} -gt 0 ]; then
    ProcessFlag=true
    CHECK_INTRER=5
    b=''
    for index in `seq 1 60`; do
        b="=$b"
        printf "loading:[%-60s]\r" "$b>"
        NUM=`ps -ef | grep ${SERVER_NAME} | grep -v grep | grep -v $0 | wc -l`
        if [ $NUM == 0 ]; then
            ProcessFlag=false
            continue
        elif [ $NUM == 1 ]; then
            ProcessFlag=true
            break
        fi
        sleep ${CHECK_INTRER}
    done
fi
printf "loading:[%-60s]\n" "$b>"
echo '等待结束！'

if [ $ProcessFlag == true ]; then
    echo '启动成功.'
else
    echo '启动失败.'
fi
