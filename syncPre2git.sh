#!/usr/bin/env bash

APP_HOME=$(cd "$(dirname "$0")"; pwd)
SOURCE_HOME=/Users/jiangnan/Work/github_mogu/taichi

#cd $SOURCE_HOME
#mvn clean compile package  -Dmaven.test.skip=true -Ppre

cd $APP_HOME
cp -rf $SOURCE_HOME/target/taichi-server.tar.gz ./
mkdir ./taichi-server-pre-temp
tar -zxvf taichi-server.tar.gz -C ./taichi-server-pre-temp
cp -rf taichi-server-pre-temp/taichi-server/lib/taichi-* ./taichi-server-pre/lib/
cp -rf taichi-server-pre-temp/taichi-server/algo_taichi_server.jar ./taichi-server-pre/algo_taichi_server.jar
cp -f taichi-server-pre-temp/taichi-server/script/start.sh taichi-server-pre/script/
rm -rf taichi-server-pre-temp
rm -rf taichi-server.tar.gz

