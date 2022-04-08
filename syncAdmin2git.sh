#!/usr/bin/env bash

APP_HOME=$(cd "$(dirname "$0")"; pwd)
SOURCE_HOME=/Users/jiangnan/Work/github_mogu/taichi

cd $SOURCE_HOME
mvn clean compile package  -Dmaven.test.skip=true -Ponline -pl taichi-admin/

cd $APP_HOME
cp -f $SOURCE_HOME/taichi-admin/target/taichi-admin-1.0.0-SNAPSHOT.jar ./taichi-admin/