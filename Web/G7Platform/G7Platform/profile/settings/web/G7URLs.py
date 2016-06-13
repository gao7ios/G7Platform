#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

import tornado

from G7Platform.main.site.Account.G7AccountReqHandlers import *
from G7Platform.main.site.Index.G7IndexReqHandlers import *
from G7Platform.main.site.Application.G7ApplicationReqHandlers import *
from G7Platform.main.site.Application.G7AppInstallReqHandlers import *
from G7Platform.main.site.Application.G7AppInstallReqHandlers import *
from G7Platform.main.site.G7Test.G7TestReqHandlers import *
from G7Platform.main.site.Feedback.G7FeedbackReqHandlers import *
from G7Platform.main.site.Account.G7AccountReqHandlers import *
from G7Platform.main.site.Application.G7ProjectReqHandlers import *

# 接口url配置方法
def G7ApiPathURL(channel, path, className, version=None):

    if version == None:
        return (r"/api/{channel}/{path}".format(channel=channel, path=path), className)
    else:
        return (r"/api/{version}/{channel}/{path}".format(version=version, channel=channel, path=path), className)

# url配置信息

serviceURLList = [    
    (r'/media/(.*)', tornado.web.StaticFileHandler, {'path': media_path}),
]

# 配置web地址列表
webURLList = [
	    (r"/", G7IndexReqHandler),
        (r"/blog", G7BlogReqHandler),
        (r"/contact", G7ContactReqHandler),
        (r"/single", G7SingleReqHandler),
        (r"/app/", G7AppIndexReqHandler),
]

# 配置接口列表
apiURLList = [

    (r"/test", G7TestReqHandler),

    G7ApiPathURL("application","upload",G7ApplicationUploadReqHandler, version="1.0"),

    G7ApiPathURL("project","list",G7ProjectListReqHandler, version="1.0"),
    G7ApiPathURL("project","mylist",G7MyProjectListReqHandler, version="1.0"),
    G7ApiPathURL("project","detail",G7ProjectDetailReqHandler, version="1.0"),

    G7ApiPathURL("application","list",G7ApplicationListReqHandler, version="1.0"),
    G7ApiPathURL("application","mylist",G7MyApplicationListReqHandler, version="1.0"),
    G7ApiPathURL("application","detail",G7ApplicationDetailReqHandler, version="1.0"),
    
    G7ApiPathURL("feedback","feedback",G7AccountProfileReqHandler, version="1.0"),

    G7ApiPathURL("account","login",G7AccountLoginReqHandler, version="1.0"),
    G7ApiPathURL("account","profile",G7AccountProfileReqHandler, version="1.0"),

    (r"/application/install/(?P<app_id>.*?)", G7ApplicationInstallReqHandler),
    (r"/application/info/(?P<plist_app_id>.*?).plist", G7ApplicationPlistReqHandler),
]

urlList = serviceURLList+apiURLList+webURLList
