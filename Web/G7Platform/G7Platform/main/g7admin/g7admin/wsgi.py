#!/usr/local/bin/python3

"""
WSGI config for g7admin product.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproduct.com/en/1.8/howto/deployment/wsgi/
"""

import os

import platform
from django.core.wsgi import get_wsgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "g7admin.settings")

application = get_wsgi_application()
