#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

from G7Platform.G7Globals import *
from Account.models import G7User
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler

class G7AccountReqHandler(G7WebReqHandler):

	def get(self, *args, **kwargs):
		self.write("Hello G7Platform")