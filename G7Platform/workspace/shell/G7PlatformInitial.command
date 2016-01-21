#!/bin/sh

# debug模式
debug=1;

# 当前路径
dirPath=$(cd `dirname $0`; pwd);

echo "输入软件安装命令如apt-get install,brew install, pacman -s,yum等.\n如果需要sudo，必须在命令前面添加sudo.\n不填写默认为brew install";

# 获取软件包管理器命令
read osinstaller;

# 系统名称
sysOS=`uname -s`;

# 关闭搞趣开发平台的服务
sh $dirPath/G7PlatformStop.command;

if [ x$osinstaller == x"" ]; then
	osinstaller="brew install";
fi

# python初始化
function pythoninitial() {
	# wget $pythonurl -P $dirPath;
	if [ $sysOS == "Darwin" ]
	then
		echo "输入用户$USER密码:\n";
		xcode-select --install
	fi
	$installer openssl
	$installer readline
	$installer pyenv --HEAD
	export PYENV_ROOT=/usr/local/var/pyenv
	pyenv install 3.4.3
}

if [ $sysOS == "Darwin" ]
then
	brew -v 1>/dev/null 2>/dev/null;
	if [ $? -ne 0 ]
	then
		sudo ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
	fi
fi;

wget -V 1>/dev/null 2>/dev/null;
if [ $? -ne 0 ]
then
	$osinstaller wget;
fi

python3 -V 2>/dev/null 1>/dev/null 0>/dev/null;
if [ $? -ne 0 ];
then
	pythoninitial;
fi

mysql --help 2>/dev/null 1>/dev/null;
if [ $? -ne 0 ]
then
	echo "开始安装mysql";
	mysqlUrl="http://cdn.mysql.com//Downloads/MySQL-5.6/mysql-5.6.28-linux-glibc2.5-x86_64.tar.gz";
	if [ $sysOS == "Darwin" ]
	then
		mysqlUrl="http://cdn.mysql.com//Downloads/MySQL-5.6/mysql-5.6.28-osx10.10-x86_64.tar.gz";
	fi

	if [ ! -f $dirPath/packages/mysql-5.6.28-osx10.10-x86_64.tar.gz ]
	then
		wget -P $dirPath/packages $mysqlUrl;
	fi

	tar xvf $dirPath/packages/mysql-5.6.28-osx10.10-x86_64.tar.gz -C /usr/local/;
	ln -sv /usr/local/mysql-5.6.28-osx10.10-x86_64/ /usr/local/mysql;
	ln -sv /usr/local/mysql-5.6.28-osx10.10-x86_64/bin/mysql* /usr/local/bin;
	ln -sv /usr/local/mysql-5.6.28-osx10.10-x86_64/lib/libmysql* /usr/local/lib;
	sudo chown -R mysql:mysql /usr/local/mysql*;
	echo "[client]
				port = 3306
				socket = /tmp/mysql.sock
				default-character-set = utf8

				[mysqld]
				collation-server = utf8_unicode_ci
				character-set-server = utf8
				init-connect ='SET NAMES utf8'
				max_allowed_packet = 64M
				bind-address = 127.0.0.1
				port = 3306
				socket = /tmp/mysql.sock" > /usr/local/mysql-5.6.28-osx10.10-x86_64/my.cnf;
	/usr/local/mysql-5.6.28-osx10.10-x86_64/scripts/mysql_install_db;
fi

nginx -v 2>/dev/null 1>/dev/null;
if [ $? -ne 0 ]
then
	$osinstaller nginx;
fi

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

sudo cp $dirPath/../profile/php/php-fpm.conf /etc/php-fpm.conf;

pip3 -V 1>/dev/null 2>/dev/null;
if [ $? -ne 0 ]
then
	wget https://raw.githubusercontent.com/pypa/pip/master/contrib/get-pip.py;
	sudo python3 get-pip.py;
	rm -rf get-pip.py;
	sudo ln -sv /usr/local/bin/pip3.4 /usr/local/bin/pip;
	sudo ln -sv /usr/local/bin/pip2.7 /usr/local/bin/pip2;
fi

$osinstaller gettext 1>/dev/null;

supervisord -v 1>/dev/null 2>/dev/null;
if [ $? -ne 0 ]
then
	sudo pip2 install supervisor==3.1.3;
fi

uwsgi --version 1>/dev/null 2>/dev/null;
if [ $? -ne 0 ]
then
	wget http://projects.unbit.it/downloads/uwsgi-2.0.10.tar.gz;
	tar xvf uwsgi-2.0.10.tar.gz;
	cd uwsgi-2.0.10/
	sudo CC=gcc python3 ./uwsgiconfig.py --build;
	sudo CC=gcc python3 uwsgiconfig.py --plugin plugins/python core py34;
	sudo mkdir /usr/lib/uwsgi;
	sudo cp -rf ./py34_plugin.so /usr/lib/uwsgi;
	sudo cp -rf ./uwsgi /usr/local/bin;
	cd ../;
	sudo rm -rf uwsgi-2.0.10*;
fi

sudo CC=gcc pip3 install uwsgi==2.0.10 1>/dev/null;

python3 -c "import tornado" 2>/dev/null 1>/dev/null;
if [ $? -ne 0 ];
then
	sudo pip3 install tornado==4.2 1>/dev/null;
fi

python3 -c "import django" 2>/dev/null 1>/dev/null;
if [ $? -ne 0 ];
then
	sudo pip3 install django==1.9.1 1>/dev/null;
fi

django-admin 2>/dev/null 1>/dev/null;
if [ $? -ne 0 ];
then
	sudo sed -e 's/python/python3/' /Library/Frameworks/Python.framework/Versions/3.4/lib/python3.4/site-packages/django/bin/django-admin.py > /usr/local/bin/django-admin;
fi

python3 -c "import torndb" 2>/dev/null 1>/dev/null;
if [ $? -ne 0 ];
then
	sudo pip3 install torndb==0.3 1>/dev/null;
fi

python3 -c "from PIL import Image" 2>/dev/null 1>/dev/null;
if [ $? -ne 0 ];
then
	sudo pip3 install pillow==3.1.0 1>/dev/null;
fi

sudo mysql.server start;
python3 -c "import MySQLdb" 2>/dev/null 1>/dev/null;
if [ $? -ne 0 ];
then
	sudo easy_install-3.4 $dirPath/packages/MySQL-for-Python-3.zip;
fi

python3 -c "import pyDes" 2>/dev/null 1>/dev/null;
if [ $? -ne 0 ];
then
	wget http://twhiteman.netfirms.com/pyDES/pyDes-2.0.1.zip -P $dirPath;
	unzip pyDes-2.0.1.zip -d $dirPath;
	cd pyDes-2.0.1/;
	sudo python3 setup.py install;
	cd ..;
	sudo rm -rf ./pyDes*;
fi

export PYTHONPATH=$(cd $dirPath/../../..; pwd)/G7Platform;python3 $dirPath/tools/djangoinitial.py;
