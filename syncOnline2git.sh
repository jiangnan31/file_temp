#!/usr/bin/env bash

APP_HOME=$(cd "$(dirname "$0")"; pwd)
SOURCE_HOME=/Users/jiangnan/Work/github_mogu/taichi

cd $SOURCE_HOME
mvn clean compile package  -Dmaven.test.skip=true -Ponline

cd $APP_HOME
cp $SOURCE_HOME/target/taichi-server.tar.gz ./
tar -zxvf taichi-server.tar.gz
rm -rf taichi-server/lib/libtensorflow_jni-1.15.0.jar
rm -rf taichi-server/lib/stanford-corenlp-3.6.0-models.jar
rm -rf taichi-server.tar.gz

