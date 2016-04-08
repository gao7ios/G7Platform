from django.db import models
from django.utils.translation import ugettext_lazy as _
from django.conf import settings
from Account.models import G7User
#-*- coding: UTF-8 -*-
# Create your models here.

class MyTestModel(models.Model):
        """docstring for MyTestModel"""
        username = models.CharField(verbose_name=_(u"测试姓名"),max_length=200,default="",blank=True,null=True)
        contact = models.CharField(verbose_name=_(u"测试联系方式"),max_length=200,default="",blank=True,null=True)
        class Meta:
                verbose_name = _(u"测试1")
                verbose_name_plural = _(u"测试1")
                #app_label = _(u"124")
        def __str__(self):
                # 列表显示id和反馈内容，如: 1.反馈内容
                return str(self.id)+"."+self.username + self.contact