#-*- coding: utf-8 -*-

from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler

from Application.models import *

class G7IndexReqHandler(G7WebReqHandler):
	'''
		首页
	'''
	def get(self):
		return self.render("index/index.html", title="首页")


class G7BlogReqHandler(G7WebReqHandler):

	def get(self):
		return self.render("index/blog.html", title="博客")

class G7ContactReqHandler(G7WebReqHandler):

	def get(self):
		return self.render("index/Contact.html", title="联系方式")

class G7SingleReqHandler(G7WebReqHandler):

	def get(self):
		return self.render("index/single.html", title="个人")


class G7AppIndexReqHandler(G7WebReqHandler):

	def get(self):
		plist_info_url = ""
		try:
			app = G7Application.objects.latest("modified_at")
			plist_info_url="https://"+self.request.host+"/application/info/"+app.identifier+".plist"
		except:
			pass
			
		return self.render("appindex/index.html", plist_info_url=plist_info_url)
