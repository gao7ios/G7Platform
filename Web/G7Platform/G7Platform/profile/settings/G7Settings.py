#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

import os
from os import path
import sys

# 是否使用测试模式
debug = False 

# 端口

debug_tornado_port = 8884
debug_django_port = 8881

release_django_port = 8882

# tornado进程端口
tornado_ports = [
	8891,
	8892,
	8893,
	8894,
]

######################## 项目 ###########################

# 项目名
project_name = "G7Platform";

# 后台名
django_project_name="g7admin"

# 项目路径
project_path = path.realpath(path.join(path.dirname(__file__), "../../../../"+project_name))

# 核心代码路径
subproject_path = path.join(project_path,project_name)

# 模板路径
template_path = path.join(project_path,"template")

# 静态文件路径 包括静态图片资源，css，js
static_path = path.join(project_path,"static")

# 用户资源储存路径
media_path = path.join(project_path,"media")

# django 路径
django_path = path.join(subproject_path, "main/"+django_project_name)


####################### 部署 ###########################

# 工作区路径
workspace_path = path.join(project_path, "workspace")

# 配置路径
profile_path = path.join(workspace_path, "profile")

# 脚本路径
shell_path = path.join(workspace_path, "shell")

# 日志路径
log_path = path.join(workspace_path, "log")

# nginx 路径
nginx_path = path.join(profile_path, "nginx")

# nginx 主配置文件路径
import platform
osname = platform.uname()[0]
nginx_conf_path = path.join(nginx_path, "nginx.conf")
if osname == "Darwin":
	nginx_conf_path = path.join(nginx_path, "nginx_bsd.conf")

# nginx G7配置文件路径
nginx_g7_conf_path = path.join(nginx_path, project_name.lower())

tornado_log_path = path.join(log_path,"tornado/tornado.log")

# django管理器路径
django_manage_path = path.join(django_path,"manage.py")

def g7MakeDirs(path_name, touch_file=False):
	if len(os.path.splitext(path_name)[1]) > 0:
		if os.path.exists(os.path.dirname(path_name)) == False:
			os.makedirs(os.path.dirname(path_name), exist_ok=True)
		if touch_file == True and os.path.exists(path_name) == False:
			os.system("touch {path_name}".format(path_name=path_name))
	else:
		if os.path.exists(path_name) == False:
			os.makedirs(path_name, exist_ok=True)

g7MakeDirs(project_path)
g7MakeDirs(subproject_path)
g7MakeDirs(template_path)
g7MakeDirs(static_path)
g7MakeDirs(media_path)
g7MakeDirs(django_path)
g7MakeDirs(workspace_path)
g7MakeDirs(profile_path)
g7MakeDirs(shell_path)
g7MakeDirs(log_path)
g7MakeDirs(nginx_path)
g7MakeDirs(tornado_log_path, touch_file=True)

########################### 数据库 ###########################

# 数据库命名不能超过14个长度
if debug == False:
	dbhost = "localhost"
	dbname = "g7platform"
	dbuser = "g7platform_user"
	dbpassword = "g7platform_password"
else:
	dbhost = "localhost"
	dbname = "g7platform"
	dbuser = "g7platform_user"
	dbpassword = "g7platform_password"


######################## 其他 ###############################

desPassword = "asdfasdf"
