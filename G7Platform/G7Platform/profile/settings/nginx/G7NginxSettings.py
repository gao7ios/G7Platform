#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

from G7Platform.profile.settings.G7Settings import *
from G7Platform.profile.settings.nginx.G7TornadoNginxSettings import *
'''
$g7NginxConfPath
$nginxErrorLogPath
$nginxPidPath
$nginxUpStreamList
$includePath
'''

g7NginxConfPath = "$g7NginxConfPath"
nginxErrorLogPath = "$nginxErrorLogPath"
nginxPidPath = "$nginxPidPath"
nginxUpStreamList = "$nginxUpStreamList"
includePath = "$includePath"

G7NginxSetting = {
    g7NginxConfPath : path.join(profile_path,"nginx"),
    nginxErrorLogPath : path.join(log_path,"nginx/error.log"),
    nginxPidPath : path.join(profile_path,"nginx/pid/nginx.pid"),
    includePath : path.join(profile_path,"nginx/"+project_name.lower()+"/*.conf"),
}
