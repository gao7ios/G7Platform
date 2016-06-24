#!/bin/bash
# debug模式
debug=1;

# 当前路径
dirPath=$(cd `dirname $0`; pwd);

osinstaller="brew install";
# 系统名称
sysOS=`uname -s`;

##### 工具  #####

# $1 软件名
# $2 安装函数
# $3 检测软件的shell语句
function g7Install() {
	echo " 检测 [ $1 ]...";
	eval $3 1>/dev/null 2>/dev/null;
	if [ $? -ne 0 ]
	then
		echo " [ $1 ]不存在, 开始安装...";
		$2;
		echo " [ $1 ] 安装成功
		";
	else
		echo " [ $1 ] 检测完成
		";
	fi
}

# brew安装函数
function brewIns() {
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
}
# 安装Brew
g7Install Brew brewIns "brew -v";

# wget安装函数
function wgetIns() {
	$osinstaller wget;
}
# 安装wget
g7Install wget wgetIns "wget --help";

# python安装函数
function pythonIns() {
	if [ $sysOS == "Darwin" ]
	then
		brew unlink python3;
		brew uninstall python3 --force;
		brew install readline;
		brew install zlib;
		brew install openssl
		brew install python3;
	fi
}
# 安装Python3.4.3
g7Install Python3 pythonIns "python3 -V";

# mysql安装函数
function mysqlIns() {
	mysqlUrl="http://cdn.mysql.com//Downloads/MySQL-5.6/mysql-5.6.28-linux-glibc2.5-x86_64.tar.gz";
	if [ $sysOS == "Darwin" ]
	then
		mysqlUrl="http://cdn.mysql.com//Downloads/MySQL-5.6/mysql-5.6.28-osx10.10-x86_64.tar.gz";
	fi

	if [ ! -f $dirPath/packages/mysql-5.6.28-osx10.10-x86_64.tar.gz ]
	then
		wget -P $dirPath/packages $mysqlUrl;
	fi

	sudo rm -rf /usr/local/mysql*;
	sudo rm -rf /usr/local/lib/libmysql*;
	sudo rm -rf /usr/local/bin/mysql*;
	sudo tar xvf $dirPath/packages/mysql-5.6.28-osx10.10-x86_64.tar.gz -C /usr/local/;
 	sudo mv /usr/local/mysql-5.6.28-osx10.10-x86_64/ /usr/local/mysql;
	sudo ln -sv /usr/local/mysql/bin/mysql* /usr/local/bin;
	sudo ln -sv /usr/local/mysql/lib/libmysql* /usr/local/lib;
	sudo ln -sv /usr/local/mysql/support-files/mysql.server /usr/local/bin/;
	sudo chown -R $USER:admin /usr/local/mysql;
	cd /usr/local/mysql;
	./scripts/mysql_install_db --user=$USER --basedir=/usr/local/mysql;
}
# 安装Mysql5.6
g7Install MySQL5.6 mysqlIns "mysql --help";

# nginx安装函数
function nginxIns() {
	$osinstaller zlib;
	$osinstaller openssl;
	$osinstaller pcre;
	brew tap homebrew/nginx;
	$osinstaller nginx;
}
# 安装nginx
g7Install NginX nginxIns "nginx -v";

# php安装函数
function phpIns() {
	if [ $sysOS == "Darwin" ]
	then
		php -v 2>/dev/null 1>/dev/null 0>/dev/null;
		if [ $? -ne 0 ]
		then
			brew tap homebrew/dupes;
			brew tap homebrew/versions;
			brew tap homebrew/home$osinstaller-php;
			brew install php56;
		fi
	else
		$osinstaller php;
	fi;
	sudo cp $dirPath/../../../profile/nginx/php/php-fpm.conf /etc/php-fpm.conf;
	$osinstaller gettext 1>/dev/null;
}
# 安装PHP
g7Install PHP5.6 nginxIns "php -v";

# supervisor安装函数
function supervisorIns() {
	if [ ! -f $dirPath/packages/supervisor-3.2.0.tar.gz ]
	then
		wget https://pypi.python.org/packages/source/s/supervisor/supervisor-3.2.0.tar.gz -P $dirPath/packages;
	fi

	tar xvf $dirPath/packages/supervisor-3.2.0.tar.gz -C $dirPath/packages;
	cd $dirPath/packages/supervisor-3.2.0;
	sudo python2.7 setup.py install;
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

	tar xvf $dirPath/packages/uwsgi-2.0.12.tar.gz -C $dirPath/packages;
	cd $dirPath/packages/uwsgi-2.0.12/;
	CPPFLAGS="-I/usr/local/opt/openssl/include -I/usr/local/opt/zlib/include" LDFLAGS="-L/usr/local/opt/openssl/lib -L/usr/local/opt/zlib/lib" CC=gcc python3 uwsgiconfig.py --build;
	CPPFLAGS="-I/usr/local/opt/openssl/include -I/usr/local/opt/zlib/include" LDFLAGS="-L/usr/local/opt/openssl/lib -L/usr/local/opt/zlib/lib" CC=gcc python3 uwsgiconfig.py --plugin plugins/python core py34;
	sudo mkdir /usr/local/lib/uwsgi 2>/dev/null;
	sudo cp -rf ./py34_plugin.so /usr/local/lib/uwsgi;
	sudo cp -rf ./uwsgi /usr/local/bin;
	cd ../;
	sudo rm -rf $dirPath/packages/uwsgi*/;
}
# 安装uwsgi
g7Install uwsgi uwsgiIns "uwsgi --version";


# bpython安装函数
function bPythonIns() {

	sudo pip3 install bpython;
}
# 安装bPython
g7Install bPython bPythonIns "bpython -h";

# iPython安装函数
function iPythonIns() {

	sudo pip3 install ipython;
}
# 安装iPython
g7Install iPython iPythonIns "ipython -h";

# tornado安装函数
function tornadoIns() {

	sudo pip3 install tornado==4.2;
}
# 安装tornado
g7Install tornado tornadoIns "python3 -c \"import tornado\"";

# django安装函数
function djangoIns() {

	sudo pip3 install django==1.9.1;
}
# 安装django
g7Install django djangoIns "python3 -c \"import django\"";

# django安装函数
function djangoAdminIns() {

	sudo sed -e 's/python/python3/' /usr/local/lib/python*/site-packages/django/bin/django-admin.py > /usr/local/bin/django-admin;
}
# 安装django
g7Install django-admin djangoAdminIns "django-admin";


# torndb安装函数
function torndbIns() {

	sudo pip3 install torndb==0.3;
torndbOrg=" use_unicode=True,";
torndbTgt="";
sudo sed -i -e "s/$torndbOrg/$torndbTgt/g" /usr/local/lib/python3*/site-packages/torndb.py;
}
# 安装torndb
g7Install torndb torndbIns "python3 -c \"import torndb\"";

# pillow安装函数
function pillowIns() {

	sudo pip3 install pillow==3.1.0;
}
# 安装pillow
g7Install pillow pillowIns "python3 -c \"from PIL import Image\"";

echo "启动数据库...";
mysql.server start;

# MySQLdb安装函数
function mySQLdbIns() {
	DYLD_LIBRARY_PATH="/usr/local/mysql/lib:-L/usr/local/mysql/lib/" sudo pip3 install $dirPath/packages/MySQL-for-Python-3.zip;
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
g7Install pyDev pyDesIns "python3 -c \"import pyDes\""


# PyAPNs 安装函数
function pyAPNsIns() {
	mkdir pyAPNsIns;
	rm -rf pyAPNsIns/*;
	cd pyAPNsIns;
	git clone https://github.com/djacobs/PyAPNs.git;
	cd PyAPNs;
	sudo python3 setup.py install;
}

g7Install pyAPNs pyAPNsIns "python3 -c \"import apns\""

# pyOpenSSL 安装函数
function pyOpenSSLIns() {
	sudo pip3 install pyOpenSSL;
}
g7Install pyOpenSSL pyOpenSSLIns "python3 -c \"import OpenSSL\""


echo "初始化环境完成, 重置服务"
sh $dirPath/G7PlatformStop.command;

echo "试图开启数据库服务";
mysql.server start;
if [ $? -ne 0 ]
then
	echo "数据库服务打开失败";
fi

echo "初始化服务";
export PYTHONPATH=$(cd $dirPath/../../../../..; pwd)/G7Platform;python3 $dirPath/tools/djangoinitial.py;
echo "服务初始化完成";

sh $dirPath/G7PlatformStart.command;
