#-*- coding: utf-8 -*-

from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler

class G7FeedbackReqHandler(G7APIReqHandler):

    def post(self):
        resultData = {"requestData":self.paramsJson, "User-Agent1":self.httpHeadersJson}
        g7log(resultData)
        self.responseWrite(0, "asdfasdf2", data=resultData)

        	

        	
