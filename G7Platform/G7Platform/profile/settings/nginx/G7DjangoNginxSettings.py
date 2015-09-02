#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

from G7Platform.profile.settings.G7Settings import *

'''
$djangoDomains
$djangoRootPath
$djangoUwsgiPass
$djangoStaticPath
$djangoAdminStaticPath
$djangoMediaPath
'''
djangoDomains = "$djangoDomains"
djangoRootPath = "$djangoRootPath"
djangoUwsgiPass = "$djangoUwsgiPass"
djangoStaticPath = "$djangoStaticPath"
djangoAdminStaticPath = "$djangoAdminStaticPath"
djangoMediaPath = "$djangoMediaPath"

G7DjangoNginxSetting = {

    djangoDomains : "localhost",
    djangoRootPath : path.join(subproject_path,"main/admin"),
    djangoUwsgiPass : "127.0.0.1:"+str(release_django_port),
    djangoStaticPath : static_path,
    djangoAdminStaticPath : path.join(static_path,"admin"),
    djangoMediaPath : media_path,
}
