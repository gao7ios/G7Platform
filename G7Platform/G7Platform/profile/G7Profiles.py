#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

from xml.dom.minidom import Document
from G7Platform.profile.settings.G7Settings import *
from G7Platform.profile.settings.web.G7URLs import *

class G7Profile:

    database = None

    def __new__(cls, *args, **kwargs):
        if not hasattr(cls,'_inst'):
            cls._inst=super(G7Profile,cls).__new__(cls,*args,**kwargs)
        return cls._inst

    def __init__(self):

        # 测试模式
        self.debug = debug
        # 路径配置信息
        self.template_path = template_path
        self.static_path = static_path
        self.media_path = media_path
        self.project_path = project_path
        self.subproject_path = subproject_path
        self.project_name = project_name
        self.django_path = django_path
        self.django_project_name = django_project_name
        self.nginx_conf_path = nginx_conf_path
        self.nginx_path = nginx_path
        self.nginx_g7_conf_path = nginx_g7_conf_path
        self.log_path = log_path
        self.release_django_port = release_django_port
        self.release_tornado_port = release_tornado_port
        self.debug_tornado_port = debug_tornado_port
        self.debug_django_port = debug_django_port
        self.tornado_ports = tornado_ports
        self.profile_path = profile_path
        self.tornado_log_path = tornado_log_path

        self.dbname = dbname
        self.dbhost = dbhost
        self.dbuser = dbuser
        self.dbpassword = dbpassword

        # url链接配置
        self.urlList = urlList

        # 数据库服务启动

        # 全局定义
        self.defineMacro()


    def defineMacro(self):
        pass

