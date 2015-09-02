#!/bin/sh

dirPath=$(cd `dirname $0`; pwd);
echo "输入软件安装命令如apt-get install,brew install, pacman -s,yum等.\n如果需要sudo，必须在命令前面添加sudo.\n不填写默认为brew install";
read osinstaller;
sysOS=`uname -s`;
sudo chmod a+w /usr/local/Cellar;
sudo chmod -R g+w /Library/Caches/Homebrew;
sudo chown -R $USER /usr/local;
sudo chown -R mysql:mysql /usr/local/opt/mysql/;
sudo chmod -R 755 /usr/local/opt/mysql/;

sh $dirPath/G7PlatformStop.command;

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
fi

brew remove mysql;
brew cleanup;
sudo rm -rf /usr/local/var/mysql;


mysql --help 2>/dev/null 1>/dev/null;
if [ $? -ne 0 ]
then
	$osinstaller mysql;
	sudo chown -R mysql /usr/local/var/mysql;
	unset TMPDIR;
	mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp;
	mysql.server start;
	/usr/local/Cellar/mysql/*/bin/mysql_secure_installation;
fi

sh $dirPath/G7PlatformStart.command;
