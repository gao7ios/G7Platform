#!/bin/sh

dirPath=$(cd `dirname $0`; pwd);

echo "\033[31m \n [ 正在关闭服务 ] \n \033[0m"
mysql.server stop 2>/dev/null;
if [ $? -ne 0 ]
then
	echo "\033[31 mmysql暂未安装或者mysql关闭失败 \033[0m";
	sudo python3 $dirPath/tools/kill_process.py 2>/dev/null;
	echo "\033[31m \n [ 服务关闭失败 ] \n \033[0m";
else
	sudo python3 $dirPath/tools/kill_process.py 2>/dev/null;
	if [ $? -ne 0 ]
	then
		echo "\033[31m python3暂未安装或者kill_process.py脚本出错 \033[0m";
		echo "\033[31m  \n [ 服务关闭失败 ] \n  \033[0m";
	else
		echo "\033[36m  \n [ 服务关闭成功 ] \n  \033[0m";
	fi
fi
