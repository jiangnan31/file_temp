#!/usr/bin/env bash

APP_HOME=$(cd "$(dirname "$0")"; pwd)
GIT_SOURCE_HOME=/home/mapp/github_file_temp

TARGET_HOME=/home/mapp/taichi-server

git pull
cp -rf ./taichi-server/* $TARGET_HOME