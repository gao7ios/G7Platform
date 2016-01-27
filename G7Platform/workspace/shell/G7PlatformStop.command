#!/bin/sh

dirPath=$(cd `dirname $0`; pwd);

mysql.server stop 2>/dev/null;
if [ $? -ne 0 ]
then

	echo "mysql暂未安装或者mysql关闭失败";

fi
# 杀死存在的进程
sudo python3 $dirPath/tools/kill_process.py 2>/dev/null;
if [ $? -ne 0 ]
then
	echo "python3暂未安装或者kill_process.py脚本出错";
fi
