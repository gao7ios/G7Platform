#-*- coding: utf-8 -*-

from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler

class G7IndexReqHandler(G7WebReqHandler):

	def get(self):

		return self.render("test/test.html", title="测试")


class G7AppIndexReqHandler(G7WebReqHandler):

	def get(self):
		return self.render("appindex/index.html")
