# -*- coding: utf-8 -*-
__author__ = 'yuyang'

from G7Platform.G7Globals import *
import os
def start_g7platformshell(filename, command="shell"):
	shellString = "cd "+django_path+";"+"python3 ./manage.py {command} 2>/dev/null;".format(command=command)
	signal = os.system(shellString)
	if signal != 0:
		print("请输入\'./{filename} help\'查看如何使用".format(filename=filename))

if __name__ == '__main__':
	if len(sys.argv) >= 3:
		commandString=sys.argv[2]
		if len(sys.argv) > 3:
			commandString += " "+sys.argv[3]
		start_g7platformshell(os.path.basename(sys.argv[1]), commandString)
	else:
		start_g7platformshell(os.path.basename(sys.argv[1]))
