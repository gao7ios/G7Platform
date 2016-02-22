#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

from G7Platform.profile.settings.G7Settings import *

'''
$phpDomains
$phpFcgiPass
$phpStaticPath
$phpAdminStaticPath
$phpMediaPath
'''

phpDomains = "$phpDomains"
phpRootPath = "$phpRootPath"
phpFcgiPass = "$phpFcgiPass"
phpStaticPath = "$phpStaticPath"
phpAdminStaticPath = "$phpAdminStaticPath"
phpMediaPath = "$phpMediaPath"


G7PHPNginxSetting = {

    phpDomains : "localhost",
    phpRootPath : path.join(subproject_path,"main/php"),
    phpFcgiPass : "127.0.0.1:9000",
    phpStaticPath : static_path,
    phpAdminStaticPath : path.join(static_path,"admin"),
    phpMediaPath : media_path,
}
