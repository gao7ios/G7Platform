#-*- coding: utf-8 -*-

from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler
import json
from G7Platform.G7Globals import *
from Application.models import G7Application,G7Project
from django.forms.models import model_to_dict

class G7TestReqHandler(G7APIReqHandler):
    '''
        首页
    '''
    def get(self):
        resultData = {"requestData":self.paramsJson, "User-Agent1":self.httpHeadersJson}
        self.responseWrite(0, "请求成功", data=resultData)




    def post(self):
        resultData = {"requestData":self.paramsJson, "User-Agent1":self.httpHeadersJson}
        print(resultData)
        self.responseWrite(0, "asdfasdf2", data=resultData)

