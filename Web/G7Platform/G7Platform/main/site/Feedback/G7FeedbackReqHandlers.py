#-*- coding: utf-8 -*-

from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler
from Feedback.models import G7FeedbackModel

class G7FeedbackReqHandler(G7APIReqHandler):

    def get(self):
        username = self.paramsJson.get("username")
        contact = self.paramsJson.get("contact")
        context = self.paramsJson.get("context")
        try:
                feedback = G7FeedbackModel(username=username, contact=contact, context=context)
                feedback.save()
                self.responseWrite(0, "提交成功", data={})
        except:
                self.responseWrite(1, "提交失败", data={})
        

        	

        	
