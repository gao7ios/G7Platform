#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

from G7Platform.main.site.Account.G7AccountReqHandlers import *
from G7Platform.main.site.Index.G7IndexReqHandlers import *
from G7Platform.main.site.Application.G7ApplicationReqHandlers import *

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
]

urlList = apiURLList+webURLList
