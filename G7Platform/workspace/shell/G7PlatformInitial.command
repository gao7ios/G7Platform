#!/bin/sh

debug=1;
dirPath=$(cd `dirname $0`; pwd);
echo "输入软件安装命令如apt-get install,brew install, pacman -s,yum等.\n如果需要sudo，必须在命令前面添加sudo.\n不填写默认为brew install";
read osinstaller;
sysOS=`uname -s`;
pythonurl="https://www.python.org/ftp/python/3.4.3/python-3.4.3-macosx10.6.pkg";
if [ -d "/usr/local/Cellar" ]
then
	sudo chmod a+w /usr/local/Cellar;
fi

if [ -d "/Library/Caches/Homebrew" ]
then
	sudo chmod -R g+w /Library/Caches/Homebrew;
fi

if [ -d "/usr/local/var/mysql" ]
then

if [ -d "/usr/local/var/mysql/" ]
then
sudo chown -R mysql:mysql /usr/local/var/mysql/;
sudo chmod -R 755 /usr/local/var/mysql/;
fi

if [ -d "/usr/local/opt/mysql" ]
then

sudo chown -R mysql:mysql /usr/local/opt/mysql/;
sudo chmod -R 755 /usr/local/opt/mysql/;

fi

sh $dirPath/G7PlatformStop.command;

if [ $debug -ne 0 ]
then
	if [ x$osinstaller == x"" ]; then
		osinstaller="brew install";
	fi;

	if [ $sysOS == "Darwin" ]
	then
		brew -v 1>/dev/null 2>/dev/null;
		if [ $? -ne 0 ]
		then
			sudo ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
		fi
	else
		pythonurl="https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tgz";
	fi;

	wget -V 1>/dev/null 2>/dev/null;
	if [ $? -ne 0 ]
	then
		$osinstaller wget;
	fi

	function pythoninitial() {
		wget $pythonurl -P $dirPath;
		if [ $sysOS == "Darwin" ]
		then
			echo "输入用户$USER密码:\n";
			echo dirPath:$dirPath;
			sudo installer -pkg $dirPath/python-3.4.3-macosx10.6.pkg -target /;
		else
			tar xvf $dirPath/Python-3.4.3.tgz;
			cd $dirPath/Python-3.4.3/;
			echo "输入root用户密码：";
			su;
			./configure --prefix /usr/local/bin/;
			make && make install;
		fi

		cd $dirPath;
		sudo rm -rf $dirPath/*ython-3.4.3*;

		reallink=/usr/local/bin/python3.4;
		if [ -L /usr/local/bin/python3.4 ]
		then
			reallink=$(readlink /usr/local/bin/python3.4);
		fi

		# sudo rm -rf /usr/local/bin/python;
		# sudo rm -rf /usr/bin/python;
		# sudo ln -sv $reallink /usr/local/bin/python;
		# sudo ln -sv $reallink /usr/bin/python;
		sudo ln -sv $reallink /usr/local/bin/python3;
		sudo ln -sv $reallink /usr/bin/python3;
		# if 	[ -f /usr/bin/python2.7 ]
		# then
		# 	sudo ln -sv /usr/bin/python2.7 /usr/local/bin/python2;
		# fi
		# sudo rm -rf /usr/bin/easy_install;
		sudo ln -sv /usr/local/bin/easy_install-3.4 /usr/bin/easy_install3;
		# sudo ln -sv /usr/local/bin/easy_install-2.7 /usr/bin/easy_install2;
	}

	defaultPyVersion=`python -V 2>&1|awk '{print $2}'|awk -F '.' '{print $1}'` 1>/dev/null 2>/dev/null;
	if [[ $defaultPyVersion != *[^0-9]* ]]&&[[ $defaultPyVersion != 0* ]]; then
		if [ $defaultPyVersion -ne 3 ]; then
			pythoninitial;
		fi
	else
		pythoninitial;
	fi

	mysql --help 2>/dev/null 1>/dev/null;
	if [ $? -ne 0 ]
	then
		echo "开始安装mysql";
		$osinstaller mysql;
		# sudo chown -R mysql /usr/local/var/mysql;
		# sudo chmod -R u+r /usr/local//var/mysql/;
		# sudo chmod -R u+w /usr/local//var/mysql/;
		# sudo chmod -R u+x /usr/local//var/mysql/;
		sudo chown -R mysql:mysql /usr/local/*/mysql/;
		sudo chmod -R 755 /usr/local/*/mysql/;
		unset TMPDIR;
		mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp;
		echo "启动myqsl";	
		mysql.server start;
		
		/usr/local/Cellar/mysql/*/bin/mysql_secure_installation;
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
		sudo easy_install pip;
		sudo easy_install3 pip;
		sudo ln -sv /usr/local/bin/pip3.4 /usr/local/bin/pip;
		sudo ln -sv /usr/local/bin/pip2.7 /usr/local/bin/pip2;
	fi
	
	$osinstaller gettext 1>/dev/null;

	supervisord -v 1>/dev/null 2>/dev/null;
	if [ $? -ne 0 ]
	then
		sudo pip install supervisor==3.1.3;
		sudo pip2 install supervisor==3.1.3;
	fi

	uwsgi --version 1>/dev/null 2>/dev/null;
	if [ $? -ne 0 ]
	then
		wget http://projects.unbit.it/downloads/uwsgi-2.0.10.tar.gz;
		tar xvf uwsgi-2.0.10.tar.gz;
		cd uwsgi-2.0.10/
		python3 CC=gcc ./uwsgiconfig.py --build;
		sudo CC=gcc python3 uwsgiconfig.py --plugin plugins/python core py34;
		sudo mkdir /usr/lib/uwsgi;
		sudo cp -rf ./py34_plugin.so /usr/lib/uwsgi;
		sudo cp -rf ./uwsgi /usr/local/bin;
		cd ../;
		sudo rm -rf uwsgi-2.0.10*;
	fi

	sudo CC=gcc pip3 install uwsgi==2.0.10 1>/dev/null;
	sudo pip3 install tornado==4.2 1>/dev/null;
	sudo pip3 install django==1.8.2 1>/dev/null;
	django-admin 2>/dev/null 1>/dev/null;
	if [ $? -ne 0 ];
	then
		sudo sed -e 's/python/python3/' /Library/Frameworks/Python.framework/Versions/3.4/lib/python3.4/site-packages/django/bin/django-admin.py > /usr/local/bin/django-admin;
	fi
	sudo pip3 install torndb==0.3 1>/dev/null;
	sudo pip3 install pillow 1>/dev/null;

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

else
	export PYTHONPATH=$(cd $dirPath/../../..; pwd)/G7Platform;python3 $dirPath/tools/djangoinitial.py;
fi