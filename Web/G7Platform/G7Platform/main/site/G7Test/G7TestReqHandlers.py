#-*- coding: utf-8 -*-

from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler
import json
from G7Platform.G7Globals import *

class G7TestReqHandler(G7APIReqHandler):
    '''
        首页
    '''
    def get(self):
        resultData = {"requestData":self.paramsJson, "User-Agent1":self.httpHeadersJson}
        g7log(resultData)
        self.responseWrite(0, "asdfasdf1", data={"test1":"test2"})

    def post(self):
        resultData = {"requestData":self.paramsJson, "User-Agent1":self.httpHeadersJson}
        g7log(resultData)
        self.responseWrite(0, "asdfasdf2", data=resultData)
