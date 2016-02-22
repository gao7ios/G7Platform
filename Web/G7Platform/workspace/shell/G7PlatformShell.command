#!/bin/bash


# 系统名称
sysOS=`uname -s`;

# 当前路径
dirPath=$(cd `dirname $0`; pwd);

$dirPath/platforms/$sysOS/G7PlatformShell.command $1 $2;
