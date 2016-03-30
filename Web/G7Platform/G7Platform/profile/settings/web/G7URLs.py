#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

from G7Platform.main.site.Account.G7AccountReqHandlers import *
from G7Platform.main.site.Index.G7IndexReqHandlers import *
from G7Platform.main.site.Application.G7ApplicationReqHandlers import *
from G7Platform.main.site.Application.G7AppInstallReqHandlers import *
from G7Platform.main.site.G7Test.G7TestReqHandlers import *
from G7Platform.main.site.Feedback.G7FeedbackReqHandlers import *
from G7Platform.main.site.Account.G7AccountReqHandlers import *

# 接口url配置方法
def G7ApiPathURL(channel, path, className, version=None):

    if version == None:
        return (r"/api/{channel}/{path}".format(channel=channel, path=path), className)
    else:
        return (r"/api/{version}/{channel}/{path}".format(version=version, channel=channel, path=path), className)

# url配置信息

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
    G7ApiPathURL("application","upload",G7ApplicationReqHandler, version="1.0"),
    (r"/test", G7TestReqHandler),
    (r"/feedback", G7FeedbackReqHandler),
    (r"/login", G7AccountReqHandler),

    (r"/application/install/(?P<app_id>.*?).html", G7AppInstallReqHandler),
    (r"/application/install/(?P<plist_app_id>.*?).plist", G7AppPlistReqHandler),


]

urlList = apiURLList+webURLList
