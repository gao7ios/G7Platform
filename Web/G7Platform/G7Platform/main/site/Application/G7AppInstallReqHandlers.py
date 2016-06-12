#-*- coding: utf-8 -*-

import tornado
import tornado.web

from Application.models import G7Application, G7Project
from Account.models import G7User
from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler
from G7Platform.G7Globals import *
from django.core.files.base import ContentFile
from django.conf import settings

from Application.models import *

class G7AppInstallReqHandler(G7WebReqHandler):
	"""
	应用包
	"""
	
	def get(self, app_id=""):
		''' 应用安装主页 '''
		
		try:
			app = G7Application.objects.get(identifier=app_id)
			if app == None:
				return self.write("包不存在"+str(app_id));
			else:
				return self.render("application/app_install.html", title=app.name, plist_info_url="https://"+self.request.host+"/application/info/ipa_info.plist?identifier="+app.identifier);
		except:
			self.write("包不存在");

		
class G7AppPlistReqHandler(G7APIReqHandler):
		
	def get(self):
		''' 组装plist '''
		try:
			plist_app_id = self.get_argument("identifier")
			app = G7Application.objects.get(identifier=plist_app_id)
			if app == None:
				return self.write("包不存在"+str(plist_app_id));
			else:
				return self.render("application/app_info.plist", domain="http://"+self.request.host, app=app);
		except:
			self.write("包不存在");