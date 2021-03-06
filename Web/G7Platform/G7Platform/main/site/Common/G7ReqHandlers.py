#-*- coding: UTF-8 -*-
__author__ = 'helios'

from G7Platform.G7Globals import *
from G7Platform.core.database.G7DBSession import G7DBSession
from G7Platform.profile.settings.G7Settings import template_path, static_path
from G7Platform.core.results.G7ResultAsistances import G7ResultAsistance
from django.db import connection, connections

class G7ReqHandler(tornado.web.RequestHandler):
    static_path = static_path
    template_path = template_path
    tableName = ""
    session = G7DBSession()
    

    def __init__(self, application, request, **kwargs):
        super(G7ReqHandler, self).__init__(application, request)
        self.tableName = ""

    def on_finish(self, *args, **kargs):
        self.session.close()
        for c in connections.all():
            try:
                c._commit()
            except:
                pass

        if connection.connection and not connection.is_usable():
            # destroy the default mysql connection
            # after this line, when you use ORM methods
            # django will reconnect to the default mysql
            del connections._connections.default

        return

    def prepare(self):

        if connection.connection and not connection.is_usable():
            # destroy the default mysql connection

            # after this line, when you use ORM methods
            # django will reconnect to the default mysql
            del connections._connections.default


        for c in connections.all():
            try:
                c._commit()
            except:
                pass

        return

#数据库操作
    def dbGet(self, items, condition):
        return self.session.get(self.tableName, items, condition)

    def dbInsert(self, params):
        return self.session.insert(self.tableName, params)

    def dbUpdate(self, params, condition):
        return self.session.update(self.tableName, params, condition)

    
