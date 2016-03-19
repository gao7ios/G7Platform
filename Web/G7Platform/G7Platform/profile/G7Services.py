#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

import os
from os import path
import tornado
from xml.dom.minidom import Document
from G7Platform.profile.settings.G7Settings import *
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

    def __init__(self):
        self.nginxConfPath = nginx_conf_path
        self.nginxG7ConfPath = nginx_g7_conf_path
        self.superG7VisorG7ConfPath = path.join(profile_path,"supervisor")
        g7MakeDirs(self.superG7VisorG7ConfPath)
        g7MakeDirs(os.path.join(nginx_path, "log/error.log"), touch_file=True)
        g7MakeDirs(os.path.join(nginx_path, "log/access.log"), touch_file=True)
        import platform
        if "Ubuntu" in platform.platform():
            g7MakeDirs(os.path.join(nginx_path, "logs/error.log"), touch_file=True)
            g7MakeDirs(os.path.join(nginx_path, "logs/access.log"), touch_file=True)

        if "centos" in platform.platform():
            replacedText = ""
            with open(nginx_conf_path, "r") as f:
                import getpass
                replacedText = f.read().replace("#user  www-data;", "user  {user};".format(user=getpass.getuser()))

            with open(nginx_conf_path, "w") as f:
                f.write(replacedText)

        # 配置文件生成
        self.startConfigure()


    def nginxSetSyntax(self, key,value):
        return "map $args {key} {{ default {value}; }}\n".format(key=key ,value=value)

    def nginxSettingsConfigure(self, setting):
        return "".join([self.nginxSetSyntax(key, setting[key]) for key in setting.keys()])

    def supervisorSettingsConfugre(self, ports, groupname):
        if len(ports) == 0:
            ports = [debug_tornado_port]
        confHeaderString = "[supervisord]\nlogfile_maxbytes=50MB\nlogfile_backups=10\nlogfile={supervisor_log}\n \n\n[group:{groupname}]\nprograms={tornadoes}\n\n".format(supervisor_log=path.join(log_path,"supervisor/tornado.log"),groupname=groupname,tornadoes=",".join(["tornado-"+str(port) for port in ports]))

        programsList = [["tornado-{port}".format(port=port),self.supervisorProgramDict(port)] for port in ports]
        programsString = "\n\n".join([self.supervisorProgramSyntax(programName=programes[0],programsDict=programes[1]) for programes in programsList])

        return confHeaderString+programsString

    def supervisorProgramDict(self,port):
        g7MakeDirs(path.join(log_path,"supervisor/error.log"), touch_file=True)
        g7MakeDirs(path.join(log_path,"supervisor/out.log"), touch_file=True)

        return {
            "command":"/usr/local/bin/python3 ".format(project_path=project_path,django_path=django_path)+path.join(subproject_path,"main/main.py")+" --port="+str(port)+" --log_file_prefix="+tornado_log_path,
            "directory":project_path,
            "user":os.environ["USER"],
            "autorestart":"true",
            "redirect_stderr":"true",
            "stdout_logfile":path.join(log_path,"supervisor/out.log"),
            "stderr_logfile":path.join(log_path,"supervisor/error.log"),
            "loglevel":"info",
            "environment":"PYTHONPATH={project_path}:{django_path},DJANGO_SETTINGS_MODULE={django_project_name}.settings".format(project_path=project_path,django_path=django_path,django_project_name=django_project_name),
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
            with open(path.join(nginx_g7_conf_path,project_name.lower()+".conf.template"),"r") as f:
                f.seek(0)
                tornadoConfDefaultString = f.read()

            with open(path.join(nginx_g7_conf_path, project_name.lower()+".conf"),"w") as f:
                tornadoConfString = tornadoConfDefaultString + tornadoUpStreamString
                f.write(tornadoConfString)

            with open(path.join(self.nginxG7ConfPath, "variable.conf"), "w") as f:
                f.write(settingsString)

        # 配置supervisor
        def supervisorConfigure():
            with open(path.join(self.superG7VisorG7ConfPath,"supervisor.conf"),"w") as f:
                f.write(self.supervisorSettingsConfugre(tornado_ports,tornadoUpStreamName))

        def adminConfigure():
            g7AdmingXmlPath = os.path.join(project_path,"workspace/profile/uwsgi/"+django_project_name+"_profile.xml")
            host = "127.0.0.1"
            port = release_django_port
            listen = 80
            pythonpath1 = project_path  # G7Platform
            pythonpath2 = subproject_path
            pythonpath3 = subproject_path+"/main/"+django_project_name+"/"+django_project_name+"/"
            pythonpath4 = subproject_path+"/main/"+django_project_name+"/"
            pidfile = path.join(nginx_path,"pid/nginx.pid")
            limit_as = 512
            daemonize = log_path + "/django/django.log"   # logpath
            g7MakeDirs(daemonize, touch_file=True)
            childrenNodes = {
                "py-programname":"/usr/local/bin/python3",
                "chdir":django_path,
                "socket":host+":"+str(port),
                "listen":str(listen),
                "master":"true",
                "pidfile":pidfile,
                "processes":"8",
		        "plugin":"/usr/local/lib/uwsgi/py34_plugin.so",
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
        os.system("supervisord -c {conf_path};".format(conf_path=path.join(self.superG7VisorG7ConfPath,"supervisor.conf")))
        # os.system("sudo supervisorctl reload")

    def startNginxService(self):
        # phpFpmResult = os.system("sudo php-fpm 2>/dev/null 1>/dev/null;")
        # if phpFpmResult > 0:
        #     os.system("sudo service php5-fpm start;")

        os.system("uwsgi -x {uwsgi_conf_path};".format(uwsgi_conf_path=path.join(profile_path,"uwsgi/{project_name}_profile.xml".format(project_name=django_project_name))))
        os.system("sudo nginx -c {conf_path} -p {nginx_path}".format(conf_path=self.nginxConfPath, nginx_path=nginx_path))


    def killServices(self):
        pass

    def startServer(self):
        # shell脚本启动服务
        self.killServices()

        G7DatabaseServer().startServer()
        self.startSupervisorMonitor()
        self.startNginxService()


class G7DebugServer(G7Server):

    def tornadoServerStart(self,port):
        application = tornado.web.Application(urlList, static_path = static_path, template_path=template_path, debug=debug)
        application.listen(port)
        tornado.ioloop.IOLoop.current().start()

    def djangoServerStart(self,port):
        manage_path = path.join(django_path, "manage.py")
        os.system("python3 {manage_path} runserver 0.0.0.0:{debug_django_port} &".format(project_path=project_path,django_path=django_path,manage_path=manage_path,debug_django_port=port))

    def startServer(self):
        #启动配置，
        G7DatabaseServer().startServer()
        print("============开启django测试服务============\n")
        self.djangoServerStart(debug_django_port)
        print("========http://127.0.0.1:{port}=========\n".format(port=debug_django_port))

        print("============开启tornado测试服务============\n")
        print("========http://127.0.0.1:{port}=========\n".format(port=debug_tornado_port))
        self.tornadoServerStart(debug_tornado_port)


class G7DatabaseServer(G7Server):

    def startConfigure(self):
        manage_path = path.join(django_path, "manage.py")
        os.system("python3 {manage_path} makemigrations;".format(project_path=project_path,django_path=django_path,manage_path=manage_path))
        migrateid=os.system("python3 {manage_path} migrate;".format(project_path=project_path,django_path=django_path,manage_path=manage_path))
        if migrateid != 0:
            print("输入mysql中root用户密码:")
            script = "mysql -h {dbhost} -u root -Bse \"insert into mysql.user(Host,User,Password) values('{dbhost}','{dbuser}',password('{dbpassword}'));grant all on *.* to {dbuser}@{dbhost};flush privileges;\" -p 2>/dev/null".format(dbhost=dbhost,dbname=dbname,dbuser=dbuser,dbpassword=dbpassword)
            userexist = os.system(script)
            createDBSQL = "mysql -h {dbhost} -u root -Bse \"create database if not exists {dbname} default character set utf8;grant all privileges on {dbname}.* to {dbuser}@{dbhost} identified by '{dbpassword}';flush privileges;\" -p".format(dbhost=dbhost,dbname=dbname,dbuser=dbuser,dbpassword=dbpassword)
            dbCreate = os.system(createDBSQL)
            os.system("python3 {manage_path} makemigrations;".format(project_path=project_path,django_path=django_path,manage_path=manage_path))
            makemigrateid=os.system("python3 {manage_path} migrate;".format(project_path=project_path,django_path=django_path,manage_path=manage_path))


    def startServer(self):
        self.startConfigure()


class G7Service:

    def start(self):
        if debug == True:
            print(" DevelopMode:  [  debug   ] ")
            G7DebugServer().startServer()
        else:
            print(" DevelopMode: [  release  ] ")
            G7ReleaseServer().startServer()
