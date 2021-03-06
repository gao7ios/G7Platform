#!/bin/bash
set -e;
dirPath=$(cd `dirname $0`; pwd);

echo "[ 正在关闭服务 ]"
mysql.server stop 2>/dev/null;
if [ $? -ne 0 ]
then
	echo " mysql暂未安装或者mysql关闭失败 ";
	sudo /usr/local/bin/python3 $dirPath/tools/kill_process.py 2>/dev/null;
	echo "[ 服务关闭失败 ]";
else
	sudo /usr/local/bin/python3 $dirPath/tools/kill_process.py 2>/dev/null;
	if [ $? -ne 0 ]
	then
		echo " python3暂未安装或者kill_process.py脚本出错 ";
		echo "   [ 服务关闭失败 ]  ";
	else
		echo "   [ 服务关闭成功 ]   ";
	fi
fi
