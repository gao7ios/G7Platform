#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

from G7Platform.main.site.Account.G7AccountReqHandlers import *
from G7Platform.main.site.Index.G7IndexReqHandlers import *
from G7Platform.main.site.Application.G7ApplicationReqHandlers import *

version = 1.0

def G7ApiPathURL(channel, path, className):
    return (r"/api/{version}/{channel}/{path}".format(version=version, channel=channel, path=path), className)

# url配置信息

apiURLList = [
	    (r"/", G7IndexReqHandler),
]

webURLList = [
    G7ApiPathURL("application","upload",G7ApplicationReqHandler),
]


urlList = apiURLList+webURLList
