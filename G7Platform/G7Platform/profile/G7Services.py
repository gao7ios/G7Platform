#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

import os
from os import path
import tornado
from xml.dom.minidom import Document

from G7Platform.profile.G7Profiles import G7Profile
from G7Platform.profile.settings.web.G7URLs import urlList
from G7Platform.profile.settings.nginx.G7NginxSettings import G7NginxSetting
from G7Platform.profile.settings.nginx.G7PHPNginxSettings import G7PHPNginxSetting
from G7Platform.profile.settings.nginx.G7DjangoNginxSettings import G7DjangoNginxSetting
from G7Platform.profile.settings.nginx.G7TornadoNginxSettings import G7TornadoNginxSetting,tornadoUpStreamString,tornadoUpStreamName

class G7Server:

    def startConfigure(self):
        pass

    def startServer(self):
        pass

class G7ReleaseServer(G7Server):

    def __new__(cls, *args, **kwargs):
        if not hasattr(cls,'_inst'):
            cls._inst=super(G7ReleaseServer,cls).__new__(cls,*args,**kwargs)
        return cls._inst

    def __init__(self):
        self.nginxConfPath = G7Profile().nginx_conf_path
        self.nginxG7ConfPath = G7Profile().nginx_g7_conf_path
        self.superG7VisorG7ConfPath = path.join(G7Profile().profile_path,"supervisor")

        # 配置文件生成
        self.startConfigure()

    def nginxSetSyntax(self, key,value):
        return "geo {key} {{ default {value}; }}\n".format(key=key ,value=value)

    def nginxSettingsConfigure(self, setting):
        return "".join([self.nginxSetSyntax(key, setting[key]) for key in setting.keys()])

    def supervisorSettingsConfugre(self, ports, groupname):
        if len(ports) == 0:
            ports = [G7Profile().debug_tornado_port]
        confHeaderString = "[supervisord]\nlogfile_maxbytes=50MB\nlogfile_backups=10\nlogfile={supervisor_log}\n \n\n[group:{groupname}]\nprograms={tornadoes}\n\n".format(supervisor_log=path.join(G7Profile().log_path,"supervisor/tornado.log"),groupname=groupname,tornadoes=",".join(["tornado-"+str(port) for port in ports]))

        programsList = [["tornado-{port}".format(port=port),self.supervisorProgramDict(port)] for port in ports]
        programsString = "\n\n".join([self.supervisorProgramSyntax(programName=programes[0],programsDict=programes[1]) for programes in programsList])

        return confHeaderString+programsString

    def supervisorProgramDict(self,port):

        return {
            "command":"python3 ".format(project_path=G7Profile().project_path,django_path=G7Profile().django_path)+path.join(G7Profile().subproject_path,"main/main.py")+" --port="+str(port)+" --log_file_prefix="+G7Profile().tornado_log_path,
            "directory":G7Profile().project_name,
            "user":"root",
            "autorestart":"true",
            "redirect_stderr":"true",
            "stdout_logfile":path.join(G7Profile().log_path,"supervisor/out.log"),
            "stderr_logfile":path.join(G7Profile().log_path,"supervisor/error.log"),
            "loglevel":"info",
            "environment":"PYTHONPATH={project_path}:{django_path},DJANGO_SETTINGS_MODULE={django_project_name}.settings".format(project_path=G7Profile().project_path,django_path=G7Profile().django_path,django_project_name=G7Profile().django_project_name),
        }

    def supervisorProgramSyntax(self, programName,programsDict):
        headerString = "[program:{programName}]\n".format(programName=programName)
        return headerString+"\n".join(["{key}={value}".format(key=key,value=programsDict[key]) for key in list(programsDict.keys())])

    def startConfigure(self):

        # 配置nginx
        def nginxConfigure():
            settings = [
                G7NginxSetting,
                G7DjangoNginxSetting,
                G7PHPNginxSetting,
                G7TornadoNginxSetting,
            ]

            settingsString = "".join([self.nginxSettingsConfigure(setting) for setting in settings])

            tornadoConfDefaultString = ""
            with open(path.join(G7Profile().nginx_g7_conf_path,G7Profile().project_name.lower()+".conf.template"),"r") as f:
                f.seek(0)
                tornadoConfDefaultString = f.read()

            with open(path.join(G7Profile().nginx_g7_conf_path, G7Profile().project_name.lower()+".conf"),"w") as f:
                tornadoConfString = tornadoConfDefaultString + tornadoUpStreamString
                f.write(tornadoConfString)

            with open(path.join(self.nginxG7ConfPath, "variable.conf"), "w") as f:
                f.write(settingsString)

        # 配置supervisor
        def supervisorConfigure():
            with open(path.join(self.superG7VisorG7ConfPath,"supervisor.conf"),"w") as f:
                f.write(self.supervisorSettingsConfugre(G7Profile().tornado_ports,tornadoUpStreamName))

        def adminConfigure():
            g7AdmingXmlPath = os.path.join(G7Profile().project_path,"workspace/profile/uwsgi/"+G7Profile().django_project_name+"_profile.xml")
            host = "127.0.0.1"
            port = G7Profile().release_django_port
            listen = 80
            pythonpath1 = G7Profile().project_path  # G7Platform
            pythonpath2 = G7Profile().subproject_path
            pythonpath3 = G7Profile().subproject_path+"/main/"+G7Profile().django_project_name+"/"+G7Profile().django_project_name+"/"
            pythonpath4 = G7Profile().subproject_path+"/main/"+G7Profile().django_project_name+"/"
            pidfile = path.join(G7Profile().nginx_path,"pid/nginx.pid")
            limit_as = 300
            daemonize = G7Profile().log_path + "/django/django.log"   # logpath

            childrenNodes = {
                "py-programname":"python3",
                "chdir":G7Profile().django_path,
                "socket":host+":"+str(port),
                "listen":str(listen),
                "master":"true",
                "pidfile":pidfile,
                "processes":"8",
		"plugin":"/usr/lib/uwsgi/py34_plugin.so",
                "pythonpath1":pythonpath1,
                "pythonpath2":pythonpath2,
                "pythonpath3":pythonpath3,
                "pythonpath4":pythonpath4,
                "module":"wsgi",
                "profiler":"true",
                "memory-report":"true",
                "enable-threads":"true",
                "logdate":"true",
                "limit-as":str(limit_as),
                "daemonize":daemonize,
                }

            def g7AdminXmlBuilder(nodes={}, rootNodeName="", xmlpath=""):

                doc = Document()
                rootNode = doc.createElement(rootNodeName)
                doc.appendChild(rootNode)
                for keyName in list(nodes.keys()):
                    if "pythonpath" in keyName:
                        keyNode = doc.createElement("pythonpath")
                        valueNode = doc.createTextNode(nodes[keyName])
                        keyNode.appendChild(valueNode)
                        rootNode.appendChild(keyNode)
                    else:
                        keyNode = doc.createElement(keyName)
                        valueNode = doc.createTextNode(nodes[keyName])
                        keyNode.appendChild(valueNode)
                        rootNode.appendChild(keyNode)

                f = open(xmlpath,'w')
                f.write(doc.toprettyxml())
                f.close()

            g7AdminXmlBuilder(childrenNodes, "uwsgi", g7AdmingXmlPath)

        nginxConfigure()
        # supervisor配置初始化:supervisor-tornado
        supervisorConfigure()
        # admin 配置初始化:uwsgi-django
        adminConfigure()

    def startSupervisorMonitor(self):
        os.system("sudo supervisord -c {conf_path};".format(conf_path=path.join(self.superG7VisorG7ConfPath,"supervisor.conf")))
        # os.system("sudo supervisorctl reload")

    def startNginxService(self):
        os.system("sudo php-fpm;")
        os.system("uwsgi -x {uwsgi_conf_path};".format(uwsgi_conf_path=path.join(G7Profile().profile_path,"uwsgi/{project_name}_profile.xml".format(project_name=G7Profile().django_project_name))))
        os.system("sudo nginx -c {conf_path} -p {nginx_path}".format(conf_path=self.nginxConfPath, nginx_path=G7Profile().nginx_path))


    def killServices(self):
        pass

    def startServer(self):
        # shell脚本启动服务
        self.killServices()

        G7DatabaseServer().startServer()
        print("=====================开启正式服务=====================")
        self.startSupervisorMonitor()
        self.startNginxService()


class G7DebugServer(G7Server):

    def __new__(cls, *args, **kwargs):
        if not hasattr(cls,'_inst'):
            cls._inst=super(G7DebugServer,cls).__new__(cls,*args,**kwargs)
        return cls._inst

    def tornadoServerStart(self,port):
        application = tornado.web.Application(urlList, static_path = G7Profile().static_path, template_path=G7Profile().template_path, debug=G7Profile().debug)
        application.listen(port)
        tornado.ioloop.IOLoop.current().start()

    def djangoServerStart(self,port):
        manage_path = path.join(G7Profile().django_path, "manage.py")
        os.system("python3 {manage_path} runserver 0.0.0.0:{debug_django_port} &".format(project_path=G7Profile().project_path,django_path=G7Profile().django_path,manage_path=manage_path,debug_django_port=port))

    def startServer(self):
        #启动配置，
        G7DatabaseServer().startServer()
        print("============开启django测试服务============\n")
        self.djangoServerStart(G7Profile().debug_django_port)
        print("========http://127.0.0.1:{port}=========\n".format(port=G7Profile().debug_django_port))

        print("============开启tornado测试服务============\n")
        print("========http://127.0.0.1:{port}=========\n".format(port=G7Profile().debug_tornado_port))
        self.tornadoServerStart(G7Profile().debug_tornado_port)


class G7DatabaseServer(G7Server):

    def __new__(cls, *args, **kwargs):
        if not hasattr(cls,'_inst'):
            cls._inst=super(G7DatabaseServer,cls).__new__(cls,*args,**kwargs)
        return cls._inst

    def startConfigure(self):
        os.system("mysql.server start")
        manage_path = path.join(G7Profile().django_path, "manage.py")
        os.system("python3 {manage_path} makemigrations 2>/dev/null;".format(project_path=G7Profile().project_path,django_path=G7Profile().django_path,manage_path=manage_path))
        migrateid=os.system("python3 {manage_path} migrate 2>/dev/null;".format(project_path=G7Profile().project_path,django_path=G7Profile().django_path,manage_path=manage_path))
        if migrateid != 0:
            print("输入mysql中root用户密码:")
            script = "sudo mysql -h {dbhost} -u root -Bse \"insert into mysql.user(Host,User,Password) values('{dbhost}','{dbuser}',password('{dbpassword}'));grant all on *.* to {dbuser}@{dbhost};flush privileges;\" -p 2>/dev/null".format(dbhost=G7Profile().dbhost,dbname=G7Profile().dbname,dbuser=G7Profile().dbuser,dbpassword=G7Profile().dbpassword)
            userexist = os.system(script)
            createDBSQL = "sudo mysql -h {dbhost} -u root -Bse \"create database if not exists {dbname} default character set utf8;grant all privileges on {dbname}.* to {dbuser}@{dbhost} identified by '{dbpassword}';flush privileges;\" -p".format(dbhost=G7Profile().dbhost,dbname=G7Profile().dbname,dbuser=G7Profile().dbuser,dbpassword=G7Profile().dbpassword)
            dbCreate = os.system(createDBSQL)
            os.system("python3 {manage_path} makemigrations;".format(project_path=G7Profile().project_path,django_path=G7Profile().django_path,manage_path=manage_path))
            makemigrateid=os.system("python3 {manage_path} migrate;".format(project_path=G7Profile().project_path,django_path=G7Profile().django_path,manage_path=manage_path))


    def startServer(self):
        self.startConfigure()


class G7Service:

    def __new__(cls, *args, **kwargs):
        if not hasattr(cls,'_inst'):
            cls._inst=super(G7Service,cls).__new__(cls,*args,**kwargs)
        return cls._inst

    def start(self):
        if G7Profile().debug == True:
            print("====================debug====================")
            G7DebugServer().startServer()
        else:
            print("====================release====================")
            G7ReleaseServer().startServer()
