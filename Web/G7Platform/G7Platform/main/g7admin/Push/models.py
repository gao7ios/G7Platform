from django.db import models
from django.utils.translation import ugettext_lazy as _
import uuid
from django.conf import settings
from django.utils import timezone
import time, datetime
import random

# Create your models here.
class G7PushProfile(models.Model):
    
    identifier = models.CharField(verbose_name=_(u"标识码"),
                             max_length=100,
                             default="",
                             blank=True,unique=True)

    name = models.CharField(verbose_name=_(u"名称"),
                             max_length=100,
                             default="",
                             blank=False,unique=False)

    p12file = models.FileField(upload_to="push/profile", verbose_name=_(u"p12文件"),blank=False,null=False)
    p12password = models.CharField(verbose_name=_(u"p12文件密码"),
                             max_length=100,
                             default="",
                             blank=True, null=True)
    private_pem_file = models.FileField(upload_to="push/profile/private", verbose_name=_(u"私钥文件"),blank=True,null=True)
    public_pem_file = models.FileField(upload_to="push/profile/public", verbose_name=_(u"公钥文件"),blank=True,null=True)
    using = models.BooleanField(verbose_name=_(u"使用中"), default=True)

    class Meta:
        verbose_name = _(u"推送")
        verbose_name_plural = _(u"推送")
        app_label = 'Push'

    def __str__(self):
        return str(self.id)+"."+self.name


class G7PushNotificatinToken(models.Model):

    token = models.CharField(verbose_name=_(u"推送标识码"),
                             max_length=150,
                             default="",
                             blank=True,unique=True)

    class Meta:
        verbose_name = _(u"推送标识码")
        verbose_name_plural = _(u"推送标识码")
        app_label = 'Push'

    def __str__(self):
        return str(self.id)+"."+self.token
        