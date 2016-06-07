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
		
		apps = G7Project.objects.all()
		app = apps[0]
		return self.write(app.name)
		if app_id == None or app_id == "":
			return self.write("包不存在");
		else:
			
			return self.write("包1存在");
		


class G7AppPlistReqHandler(G7APIReqHandler):
		
	def get(self, plist_app_id=""):
		''' 组装plist '''
		return self.write("plist_app_id");