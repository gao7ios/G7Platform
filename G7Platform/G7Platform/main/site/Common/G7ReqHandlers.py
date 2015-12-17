#-*- coding: UTF-8 -*-
__author__ = 'helios'

from G7Platform.G7Globals import *
from G7Platform.core.database.G7DBSession import G7DBSession
from G7Platform.profile.settings.G7Settings import template_path, static_path
from G7Platform.core.results.G7ResultAsistances import G7ResultAsistance
from django.db import connections

class G7ReqHandler(tornado.web.RequestHandler):
    static_path = static_path
    template_path = template_path
    tableName = ""

    def __init__(self, application, request, **kwargs):
        super(G7ReqHandler, self).__init__(application, request)
        self.tableName = ""

    def on_finish(self, *args, **kargs):
        for c in connections.all():
            try:
                c._commit()
            except:
                pass
        return

    def prepare(self):
        for c in connections.all():
            try:
                c._commit()
            except:
                
                pass
        return

#数据库操作
    def dbGet(self, items, condition):
        return G7DBSession().get(self.tableName, items, condition)

    def dbInsert(self, params):
        return G7DBSession().insert(self.tableName, params)

    def dbUpdate(self, params, condition):
        return G7DBSession().update(self.tableName, params, condition)

    @property
    def params(self):
        if self.get_argument('params') == None:
            return ""
        return self.get_argument('params')

    @property
    def paramsJson(self):

        try:
            if desText.__len__() == 0:
                return {}
            else:
                return json.loads(self.params)

        except:
            return {}

    def responseWrite(self,code=0, message="", data={}):
        self.write(G7ReqHandler.responseDataText(code, message, data))

    def responseDataText(code=0, message="", data={}):

        responseData = G7ResultAsistance.resultErrorDataWrapperToJson(code,data)
        if code == 0:
            responseData = G7ResultAsistance.resultSuccessDataWrapperToJson(message, data)

        responseDataText = json.dumps(responseData)
        return responseDataText
