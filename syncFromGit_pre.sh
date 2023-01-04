#!/usr/bin/env bash

APP_HOME=$(cd "$(dirname "$0")"; pwd)
GIT_SOURCE_HOME=/home/mapp/github_file_temp

TARGET_HOME=/home/mapp/taichi-server

git pull
rm -rf $TARGET_HOME/lib/*
cp -rf ./taichi-server/lib/* $TARGET_HOME/lib/
cp -rf ./taichi-server-pre/* $TARGET_HOME
cp -rf $TARGET_HOME/lib_extend/* $TARGET_HOME/lib/