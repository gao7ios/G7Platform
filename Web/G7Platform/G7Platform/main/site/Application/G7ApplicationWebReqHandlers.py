#-*- coding: utf-8 -*-

import tornado
import tornado.web

from Application.models import G7Application, G7Product
from Account.models import G7User
from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler
from G7Platform.G7Globals import *
from django.core.files.base import ContentFile
from django.conf import settings

from Application.models import *

class G7ApplicationPackagePostWebReqHandler(G7WebReqHandler):
    """
    应用包
    """
    
    def get(self):
        return self.render("application/post_package.html", title="Mars-应用提交", users=G7User.objects.all());

    def post(self):
        pass