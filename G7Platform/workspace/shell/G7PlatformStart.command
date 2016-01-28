#!/bin/sh

# 进行tornado配置初始化后 根据tornado配置初始化django配置，最后获得2者配置后开启nginx

dirPath=$(cd `dirname $0`; pwd);
# tornado
cd $dirPath/../..;
echo "\033[36m \n [ 服务启动中 ] \n \033[0m";
python3 $dirPath/../../G7Platform/G7Platforms.py 2>/dev/null;
if [ $? -ne 0 ]
then
	echo "\033[31m  \n [ 服务关闭失败 ] \n  \033[0m";
else
	echo "\033[36m  \n [ 服务关闭成功 ] \n  \033[0m";
  echo "请打开浏览器输入
  \033[33m  http://localhost/admin \033[0m
    或者
  \033[33m  http://127.0.0.1/admin \033[0m
    进入后台


    "
fi
