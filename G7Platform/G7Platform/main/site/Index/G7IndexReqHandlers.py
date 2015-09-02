#-*- coding: utf-8 -*-

from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler

class G7IndexReqHandler(G7APIReqHandler):

	def get(self):

		return self.render("test/test.html", title="测试")