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

if [ x$osinstaller == x"" ]; then
	osinstaller="brew install";
fi

function pip3Install() {
	pipInstall 3 "$1" "$2" "$3"
}

function pip2Install() {
	pipInstall 2 "$1" "$2" "$3"
}

# pip3安装函数
function pipInstall() {
	echo pipInstall $1 $2 $3 $4
	echo "检测$2..."
	eval $(echo $3) 2>/dev/null 1>/dev/null;
	if [ $? -ne 0 ];
	then
		echo "$2不存在,开始安装$2"
		if [ ! $4 ];
		then
			sudo pip$1 install $2;
		else
			sudo pip$1 install $2==$4;
		fi
		echo "$2安装完成"
	else
		echo "$2正常,检测完毕"
	fi
}

# python初始化
function pythoninitial() {
	# wget $pythonurl -P $dirPath;
	if [ $sysOS == "Darwin" ]
	then

		echo "安装Python3.4.3......";

		$osinstaller openssl;
		$osinstaller readline;
		export LDFLAGS=-L/usr/local/opt/openssl/lib;
		export CPPFLAGS=-I/usr/local/opt/openssl/include;

		pythonUrl="https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tgz";
		if [ $sysOS == "Darwin" ]
		then
			pythonUrl="https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tgz";
		fi

		if [ ! -f $dirPath/packages/Python-3.4.3.tgz ]
		then
			wget -P $dirPath/packages $pythonUrl;
		fi

		tar xvf packages/Python-3.4.3.tgz -C packages;
		cd packages/Python-3.4.3;
		org0='#SSL=\/usr\/local\/ssl'
		org1='#_ssl _ssl.c'
		org2='#-DUSE_SSL -I$(SSL)/include -I$(SSL)/include/openssl'
		org3='#-L$(SSL)/lib -lssl -lcrypto'

		tgt0='SSL=\/usr\/local\/ssl'
		tgt1='_ssl _ssl.c'
		tgt2='-DUSE_SSL -I$(SSL)/include -I$(SSL)/include/openssl'
		tgt3='-L$(SSL)/lib -lssl -lcrypto'

		sed -i -e "s/"$org0"/"$tgt0"/g" Modules/Setup.dist;
		sed -i -e "s/"$org1"/"$tgt1"/g" Modules/Setup.dist;
		sed -i -e "s/"$org2"/"$tgt2"/g" Modules/Setup.dist;
		sed -i -e "s/"$org3"/"$tgt3"/g" Modules/Setup.dist;

		./configure;
		make;
		sudo make install;
		sudo rm -rf packages/Python-3.4.3/;
		cd $dirPath;
	fi
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

	sudo rm -rf /usr/local/mysql*;
	sudo rm -rf /usr/local/lib/libmysql*;
	sudo rm -rf /usr/local/bin/mysql*;
	sudo tar xvf $dirPath/packages/mysql-5.6.28-osx10.10-x86_64.tar.gz -C /usr/local/;
 	sudo mv /usr/local/mysql-5.6.28-osx10.10-x86_64/ /usr/local/mysql;
	sudo ln -sv /usr/local/mysql/bin/mysql* /usr/local/bin;
	sudo ln -sv /usr/local/mysql/lib/libmysql* /usr/local/lib;
	sudo ln -sv /usr/local/mysql/support-files/mysql.server /usr/local/bin/;
	sudo chown -R $USER:admin /usr/local/mysql
	cd /usr/local/mysql;
	./scripts/mysql_install_db --user=$USER --basedir=/usr/local/mysql;
	echo "请重启操作系统完成mysql的安装"
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

$osinstaller gettext 1>/dev/null;

pip2Install supervisor "supervisord -v" "3.1.3"

uwsgi --version 1>/dev/null 2>/dev/null;
if [ $? -ne 0 ]
then
	if [ ! -f $dirPath/packages/uwsgi-2.0.12.tar.gz ]
	then
		wget http://projects.unbit.it/downloads/uwsgi-2.0.12.tar.gz -P $dirPath/packages;
	fi

	tar xvf $dirPath/packages/uwsgi-2.0.12.tar.gz -C $dirPath/packages;
	cd $dirPath/packages/uwsgi-2.0.12/
	sudo CC=gcc python3 ./uwsgiconfig.py --build;
	sudo CC=gcc python3 uwsgiconfig.py --plugin plugins/python core py34;
	sudo mkdir /usr/local/lib/uwsgi 2>/dev/null;
	sudo cp -rf ./py34_plugin.so /usr/local/lib/uwsgi;
	sudo cp -rf ./uwsgi /usr/local/bin;
	cd ../;
	sudo rm -rf $dirPath/packages/uwsgi*/;
fi

pip3Install bpython "ipython --help-all"

pip3Install tornado "python3 -c \"import tornado\"" "4.2"

pip3Install django "python3 -c \"import django\"" "1.9.1"

echo "重置django-admin命令......"
django-admin 2>/dev/null 1>/dev/null;
if [ $? -ne 0 ];
then
	sudo sed -e 's/python/python3/' /usr/local/lib/python3.4/site-packages/django/bin/django-admin.py > /usr/local/bin/django-admin;
fi
echo "重置完毕"

pip3Install torndb "python3 -c \"import torndb\"" "0.3"
pip3Install pillow "python3 -c \"from PIL import Image\"" "3.1.0"

echo "启动数据库..."
	mysql.server start;

echo "检测MySQLdb..."
python3 -c "import MySQLdb" 2>/dev/null 1>/dev/null;
if [ $? -ne 0 ];
then
	sudo easy_install-3.4 $dirPath/packages/MySQL-for-Python-3.zip;
fi

echo "检测pyDes..."
python3 -c "import pyDes" 2>/dev/null 1>/dev/null;
if [ $? -ne 0 ];
then
	if [ ! -f $dirPath/packages/pyDes-2.0.1.zip ]
	then
		wget http://twhiteman.netfirms.com/pyDES/pyDes-2.0.1.zip -P $dirPath/packages;
	fi
	unzip $dirPath/packages/pyDes-2.0.1.zip -d $dirPath/packages;
	cd $dirPath/packages/pyDes-2.0.1/;
	sudo python3 setup.py install;
	cd $dirPath;
	sudo rm -rf $dirPath/packages/pyDes*/;
fi
echo "检测完毕"

echo "初始化环境完成, 重置服务"
sh $dirPath/G7PlatformStop.command;

echo "初始化服务";
export PYTHONPATH=$(cd $dirPath/../../..; pwd)/G7Platform;python3 $dirPath/tools/djangoinitial.py;
echo "服务初始化成功";

./G7PlatformStart.command
