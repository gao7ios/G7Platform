#!/bin/sh

# 数据调试命令行

dirPath=$(cd `dirname $0`; pwd);

cd $dirPath/../..;

sudo chown -R $USER $dirPath/../..;

export PYTHONPATH=$PYTHONPATH:$(cd $dirPath/../../..; pwd)/G7Platform;python3 $dirPath/tools/g7platformshell.py $1;
