#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

import os
import sys
import datetime
import uuid
import time
import json
import re
import tornado
import tornado.web

from os import path
from django.utils.translation import ugettext_lazy as _
from django.core.wsgi import get_wsgi_application
from G7Platform.profile.settings.G7Settings import *

def g7log(log):
    print(log)
    with open(path.join(log_path,"{log_name}.log".format(log_name=project_name)), "a") as f:
        logStr = "{project_name} Log At {datetime}: {log}\n".format(project_name=project_name,datetime=str(datetime.datetime.now()),log=str(log))
        f.write(logStr)

def djangoload():
    sys.path.append(django_path)
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", django_project_name+".settings")
    application = get_wsgi_application()

def identifierAuto():
    return str(uuid.uuid3(uuid.uuid4(),str(time.time())).hex)
