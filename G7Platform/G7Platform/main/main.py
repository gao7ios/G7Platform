#-*- coding: UTF-8 -*-

import os
import sys
from os import path
from django.core.wsgi import get_wsgi_application
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.append(path.realpath(path.join(BASE_DIR,"../")))

from G7Platform.G7Globals import djangoload
djangoload()
from G7Platform.profile.G7Services import G7DebugServer

if __name__ == "__main__":

    from G7Platform.profile.G7Services import G7DebugServer
    from G7Platform.profile.G7Profiles import *
    #define("port", default=8888, help="run on the given port", type=int)
    port = int(sys.argv[1].split('=')[1])

    if port == 0:
        exit(1)
    G7DebugServer().tornadoServerStart(port)
