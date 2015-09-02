# -*- coding: utf-8 -*-
__author__ = 'yuyang'
from G7Platform.G7Globals import *
djangoload()
from G7Platform.profile.G7Services import *

import os
import sys
from os import path

def get_secret_key():

    curdir = str(path.realpath(path.dirname(__file__)))
    startProject = os.system("cd {curdir};sudo django-admin startproject {django_project_name} 2>/dev/null;".format(curdir=curdir,django_project_name=django_project_name))
    if startProject == 0:
        settingsStr = ""
        secretKey = ""
        orig_secretKey = ""
        with open("{curdir}/{project_name}/{project_name}/settings.py".format(curdir=curdir,project_name=django_project_name),"r") as f:
            f.seek(0)
            settingsList = f.readlines()
            for line in settingsList:
                if "SECRET_KEY" in line:
                    secretKey = line
        with open("{django_path}/{project_name}/settings.py".format(django_path=django_path,project_name=django_project_name),"r") as f:
            f.seek(0)
            settingsStr = f.read()
            f.seek(0)
            settingsList = f.readlines()
            for line in settingsList:
                if "SECRET_KEY" in line:
                    orig_secretKey = line

        new_settingsStr = settingsStr.replace(orig_secretKey,secretKey)
        with open("{django_path}/{project_name}/settings.py".format(django_path=django_path,project_name=django_project_name),"w") as f:
            f.write(new_settingsStr)
        os.system("sudo rm -rf {curdir}/{django_project_name}".format(curdir=curdir,django_project_name=django_project_name))
    else:
        print("目录{curdir}已存在{django_project_name}或者当前计算机未安装Django".format(curdir=curdir,django_project_name=django_project_name))


def create_superuser():
    G7DatabaseServer().startServer()
    print("是否创建admin超级用户[Y/n]：\n")
    sys.stdout.flush()
    needSU = input()
    if needSU == "Y":
        os.system("python3 {django_path}/manage.py createsuperuser;".format(django_path=django_path))

if  __name__ == "__main__":
    get_secret_key()
    create_superuser()