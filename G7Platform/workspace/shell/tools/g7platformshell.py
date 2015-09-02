# -*- coding: utf-8 -*-
__author__ = 'yuyang'

from G7Platform.G7Globals import *
def start_g7platformshell(command="shell"):
	shellString = django_manage_path+" {command}".format(command=command)
	os.system(shellString)

if __name__ == '__main__':
	if len(sys.argv) == 2:
		commandString=sys.argv[1]
		start_g7platformshell(commandString)
	else:
		start_g7platformshell()