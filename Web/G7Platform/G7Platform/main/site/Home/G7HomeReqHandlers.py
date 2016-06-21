#-*- coding: utf-8 -*-

from Application.models import *
from Account.models import *
from Push.models import *
from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler

class G7HomeInitialReqHandler(G7APIReqHandler):

    def initialConfigure(self):
        return self.responseWrite(0)

    def fetchClientConfigure(self):

        if self.httpHeadersJson != None:
            token = self.httpHeadersJson.get("token")
            if  token != None and type(token) == type("") and token != "" and len(G7PushNotificatinToken.objects.filter(token=token)) == 0:
                G7PushNotificatinToken(token=token).save()

    def get(self):
        self.fetchClientConfigure()
        return self.initialConfigure()

    def post(self):
        self.fetchClientConfigure()
        return self.initialConfigure()

