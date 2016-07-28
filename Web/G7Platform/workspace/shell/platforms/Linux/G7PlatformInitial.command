#!/bin/bash
# debug模式
debug=1;

# 当前路径
dirPath=$(cd `dirname $0`; pwd);

. $dirPath/G7PlatformProfile.command

$osinstaller -h 2>/dev/null 1>/dev/null;
if [ $? -ne 0 ]
then
  echo "
  如果你在Ubuntu系统下请输入sudo apt-get install
  如果你在Centos系统下请输入sudo yum install
  或者 你可以在 $dirPath/G7PlatformProfile.command 文件中修改配置
  请输入安装命令："
  read osinstaller;
fi
echo $osinstaller;
$mysqlCommand status 2>/dev/null 1>/dev/null;
if [ $? -ne 0 ]
then
  echo "
  如果你安装了mariadb请输入sudo service mariadb
  如果你安装了mysqldb系统下请输入sudo service mysql
  如果你的数据库启动指令是mysql.server start.
  那么你要输入mysql.server
  或者 你可以在 $dirPath/G7PlatformProfile.command 文件中修改配置
  请输入数据库命令："
  read mysqlCommand;
fi
echo $mysqlCommand;
echo "
#! /bin/bash
osinstaller=\"$osinstaller\"
mysqlCommand=\"$mysqlCommand\"
" > $dirPath/G7PlatformProfile.command;

# 系统名称
sysOS=`uname -s`;

##### 工具  #####

# $1 软件名
# $2 安装函数
# $3 检测软件的shell语句

function g7Install() {
  echo "检测 [ $1 ]...";
  eval $3 1>/dev/null 2>/dev/null;
  if [ $? -ne 0 ]
  then
    echo "[ $1 ]不存在, 开始安装...";
    $2;
    echo "[ $1 ] 安装成功";
  else
    echo "[ $1 ] 检测完成";
  fi
};


sh $dirPath/G7PlatformStop.command;

# gcc 安装函数
function gccIns() {
  $osinstaller gcc;
}
# 安装gcc
g7Install gcc gccIns "gcc -v";

# wget安装函数
function wgetIns() {
  $osinstaller wget;
}
# 安装wget
g7Install wget wgetIns "wget --help";

# unzip安装函数
function wgetIns() {
  $osinstaller unzip;
}
# 安装wget
g7Install unzip wgetIns "unzip --help";

# python2安装函数
function pythonIns() {
  $osinstaller python;
	$osinstaller python2-pip;
	$osinstaller python2-easyinstall;
}
# 安装Python3.5.2
g7Install Python2 pythonIns "python2 -V";

# python3安装函数
function pythonIns() {
 #  $osinstaller python3;
	# $osinstaller python3-pip;
	# $osinstaller python3-easyinstall;
 #  $osinstaller zlib-devel bzip2-devel openssl-devel ncurses-devel;

  if [ ! -f $dirPath/packages/Python-3.5.2.tgz ]
  then
    wget https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz -P $dirPath/packages;
  fi
  tar xvf $dirPath/packages/Python-3.5.2.tgz -C $dirPath/packages;
  cd $dirPath/packages/Python-3.5.2;
  CFLAGS="$CFLAGS -O3 -fPIC" CXXFLAGS="$CXXFLAGS -fPIC" ./configure;
  sudo make && sudo make install;
  cd $dirPath;
  sudo rm -rf $dirPath/packages/Python-3.5.2;
  sudo ln -sv /usr/local/nginx/sbin/python3 /usr/bin/python3;
  sudo ln -sv /usr/local/nginx/sbin/python3 /usr/local/bin/python3;
}
# 安装Python3.5.2
g7Install Python3.5.2 pythonIns "python3 -V";

# mysql安装函数
function mysqlIns() {
  if [ "$osinstaller" == "sudo yum install" ];
  then
    $osinstaller mariadb mariadb-server libmariadbclient* mysql-devel mariadb-devel;
    sudo systemctl enable mariadb.service;
  elif [ "$osinstaller" == "sudo apt-get install" ];
  then
    $osinstaller mariadb mariadb-server libmariadbclient*;
    $osinstaller mysql mysql-server libmysqlclient*;
  fi
}
# 安装Mysql5.6
g7Install MySQL5.6 mysqlIns "mysql --help";

# nginx安装函数
function nginxIns() {
  # http://nginx.org/download/nginx-1.11.3.tar.gz

  if [ ! -f $dirPath/packages/nginx-1.11.3.tar.gz ]
  then
    wget http://nginx.org/download/nginx-1.11.3.tar.gz -P $dirPath/packages;
  fi
  tar xvf $dirPath/packages/nginx-1.11.3.tar.gz -C $dirPath/packages;
  cd $dirPath/packages/nginx-1.11.3;
  ./configure --with-http_ssl_module;
  sudo make && sudo make install;
  cd $dirPath;
  sudo rm -rf $dirPath/packages/nginx-1.11.3;
  sudo ln -sv /usr/local/nginx/sbin/nginx /usr/local/bin/nginx;
  sudo ln -sv /usr/local/nginx/sbin/nginx /usr/bin/nginx;
}
# 安装nginx
g7Install NginX nginxIns "nginx -v";

# php安装函数
function phpIns() {
	if [ "$osinstaller" == "sudo yum install" ];
  then
    $osinstaller php php-fpm;
  elif [ "$osinstaller" == "sudo apt-get install" ];
  then
    $osinstaller php5 php5-fpm php5-cli spawn-fcgi;
  fi

  sudo cp $dirPath/../../../profile/nginx/php/php-fpm.conf /etc/php-fpm.conf;
  $osinstaller gettext 1>/dev/null;
}

if [ "$osinstaller" == "sudo apt-get install" ];
then
  # 安装PHP
  g7Install PHP5.6 phpIns "php5 -v";
else
  # 安装PHP
  g7Install PHP5.6 phpIns "php -v";
fi


# supervisor安装函数
function supervisorIns() {
  if [ ! -f $dirPath/packages/supervisor-3.2.0.tar.gz ]
  then
    wget https://pypi.python.org/packages/source/s/supervisor/supervisor-3.2.0.tar.gz -P $dirPath/packages;
  fi

  tar xvf $dirPath/packages/supervisor-3.2.0.tar.gz -C $dirPath/packages;
  cd $dirPath/packages/supervisor-3.2.0;
  sudo python2 setup.py install;
  cd $dirPath;
  sudo rm -rf $dirPath/packages/supervisor-3.2.0/;
}
# 安装supervisor
g7Install Supervisor3.2.0 supervisorIns "supervisord -v";

# uwsgi安装函数
function uwsgiIns() {
  if [ ! -f $dirPath/packages/uwsgi-2.0.12.tar.gz ]
  then
    wget http://projects.unbit.it/downloads/uwsgi-2.0.12.tar.gz -P $dirPath/packages;
  fi
  $osinstaller libxml*;
  tar xvf $dirPath/packages/uwsgi-2.0.12.tar.gz -C $dirPath/packages;
  cd $dirPath/packages/uwsgi-2.0.12/
  sudo CFLAGS="-O3 -fPIC" CC=gcc /usr/local/bin/python3 ./uwsgiconfig.py --build;
  sudo CFLAGS="-O3 -fPIC" CC=gcc /usr/local/bin/python3 ./uwsgiconfig.py --plugin plugins/python core py35;
  sudo mkdir -p /usr/local/lib/uwsgi 2>/dev/null;
  sudo cp -rf ./py35_plugin.so /usr/local/lib/uwsgi;
  sudo cp -rf uwsgi /usr/local/bin;
  cd ../;
  sudo rm -rf $dirPath/packages/uwsgi*/;
}
# 安装uwsgi
g7Install uwsgi uwsgiIns "uwsgi --version";

# bpython安装函数
function bPythonIns() {

  sudo /usr/local/bin/pip3 install bpython;
}
# 安装bPython
g7Install bPython bPythonIns "bpython -h";

# iPython安装函数
function iPythonIns() {

  sudo /usr/local/bin/pip3 install ipython;
}
# 安装iPython
g7Install iPython iPythonIns "ipython -h";

# tornado安装函数
function tornadoIns() {

  sudo /usr/local/bin/pip3 install tornado==4.2;
}
# 安装tornado

g7Install tornado tornadoIns "python3 -c \"import tornado\"";

# django安装函数
function djangoIns() {

  sudo /usr/local/bin/pip3 install django==1.9.1;
}
# 安装django
g7Install django djangoIns "python3 -c \"import django\"";

# django安装函数
function djangoAdminIns() {

  sudo sed -e 's/python/python3/' /usr/local/lib/python3.5/site-packages/django/bin/django-admin.py > /usr/local/bin/django-admin;
}
# 安装django
g7Install django-admin djangoAdminIns "django-admin";


# torndb安装函数
function torndbIns() {

  sudo /usr/local/bin/pip3 install torndb==0.3;
}

torndbOrg=" use_unicode=True,";
torndbTgt="";
sudo sed -i -e "s/$torndbOrg/$torndbTgt/g" /usr/lib/python3.5/site-packages/torndb.py 2>/dev/null 1>/dev/null;
sudo sed -i -e "s/$torndbOrg/$torndbTgt/g" /usr/local/lib/python3.5/site-packages/torndb.py 2>/dev/null 1>/dev/null;
sudo sed -i -e "s/$torndbOrg/$torndbTgt/g" /usr/lib/python3.5/dist-packages/torndb.py 2>/dev/null 1>/dev/null;
sudo sed -i -e "s/$torndbOrg/$torndbTgt/g" /usr/local/lib/python3.5/dist-packages/torndb.py 2>/dev/null 1>/dev/null;
# 安装torndb
g7Install torndb torndbIns "python3 -c 'import torndb'";

# pillow安装函数
function pillowIns() {
  $osinstaller libjpeg* libpng*;
  sudo /usr/local/bin/pip3 install pillow==3.1.0;
}
# 安装pillow
g7Install pillow pillowIns "python3 -c \"from PIL import Image\"";

echo "启动数据库...";
$mysqlCommand start;

# MySQLdb安装函数
function mySQLdbIns() {
  sudo /usr/local/bin/easy_install-3.5 $dirPath/packages/MySQL-for-Python-3.zip;
}
# 安装MySQLdb
g7Install MySQLdb mySQLdbIns "python3 -c \"import MySQLdb\"";

# pycrypto 安装函数
function pycryptoIns() {
	sudo pip3 install pycrypto;
}

# 安装pycrypto
g7Install pycrypto pycryptoIns "python3 -c \"import Crypto\""

# pyDes 安装函数
function pyDesIns() {
  sudo pip3 install pyDes;
}

# 安装pyDes
g7Install pyDesIns pyDesIns "python3 -c \"import pyDes\""

# pycrypto 安装函数
function pycryptoIns() {
  sudo pip3 install pycrypto;
}

# 安装pycrypto
g7Install pycrypto pycryptoIns "python3 -c \"import Crypto\""

# PyAPNs 安装函数
function pyAPNsIns() {
  mkdir pyAPNsIns;
  sudo rm -rf pyAPNsIns/*;
  cd pyAPNsIns;
  git clone https://github.com/djacobs/PyAPNs.git;
  cd PyAPNs;
  sudo python3 setup.py install;
  cd ../..;
  echo $pwd;
  sudo rm -rf pyAPNsIns;
}

g7Install pyAPNs pyAPNsIns "python3 -c \"import apns\""

# pyOpenSSL 安装函数
function pyOpenSSLIns() {
  sudo pip3 install pyOpenSSL;
}
g7Install pyOpenSSL pyOpenSSLIns "python3 -c \"import OpenSSL\""

function pytzIns() {
  sudo pip3 install pytz;
}
g7Install pytz pytzIns "python3 -c \"import pytz\""

echo "初始化环境完成, 重置服务"
sh $dirPath/G7PlatformStop.command;

echo "试图开启数据库服务";
$mysqlCommand start;
if [ $? -ne 0 ]
then
  echo "数据库服务打开失败";
fi

echo "初始化服务";
export PYTHONPATH=$(cd $dirPath/../../../../..; pwd)/G7Platform;python3 $dirPath/tools/djangoinitial.py;
echo "服务初始化完成";

sh $dirPath/G7PlatformStart.command;
