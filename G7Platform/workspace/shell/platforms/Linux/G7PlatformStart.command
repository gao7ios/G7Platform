#!/bin/bash

# 进行tornado配置初始化后 根据tornado配置初始化django配置，最后获得2者配置后开启nginx

dirPath=$(cd `dirname $0`; pwd);
echo "  [ 服务启动中 ]  ";

. $dirPath/G7PlatformProfile.command
$mysqlCommand start;
/usr/local/bin/python3 $dirPath/../../../../G7Platform/G7Platforms.py;
if [ $? -ne 0 ]
then
  echo "   [ 服务启动失败 ]   ";
else
  echo "   [ 服务启动成功 ]   ";
  echo "请打开浏览器输入
    http://localhost/admin
    或者
    http://127.0.0.1/admin
    进入后台
    "
fi
