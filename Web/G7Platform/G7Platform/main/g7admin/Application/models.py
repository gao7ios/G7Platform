#-*- coding: utf-8 -*-

from django.db import models
from django.utils.translation import ugettext_lazy as _
import uuid
from django.conf import settings
from django.utils import timezone
import time, datetime
import random
# Create your models here.

class G7Project(models.Model):

    status_choices = (
                    (0,_(u"新建")),
                    (1,_(u"策划中")),
                    (2,_(u"设计中")),
                    (3,_(u"开发中")),
                    (4,_(u"测试中")),
                    (5,_(u"提审中")),
                    (6,_(u"审核中")),
                    (7,_(u"回归中")),
                    (8,_(u"发布")),
                   )

    type_choices = (
        (0,_(u"应用程序")),
        (1,_(u"客户端框架")),
        (2,_(u"服务端框架")),
        (3,_(u"插件")),
        (4,_(u"开源项目")),
        (5,_(u"开发工具")),
    )

    platform_choices = (
                    (0,_(u"通用")),
                    (1,_(u"iOS")),
                    (2,_(u"Android")),
                    (999,_(u"其他")),
                   )

    platform = models.IntegerField(verbose_name=_(u"目标平台"),
                                   default=0,
                                   choices=platform_choices,
                                   blank=True)

    project_type = models.IntegerField(choices=type_choices,
                                  verbose_name=_(u"类型"),
                                  default=0)

    project_status = models.IntegerField(choices=status_choices,
                                    verbose_name=_(u"状态"),
                                    default=0)
    project_id = models.IntegerField(verbose_name=_(u"产品id"),default=0,blank=False,null=False)

    latest_version = models.CharField(verbose_name=_(u"最新版本"),max_length=200, default="0.0",blank=True,null=True)
    latest_inner_version = models.IntegerField(verbose_name=_(u"最新内部版本"),default=0,blank=True,null=True)
    latest_build_version = models.CharField(verbose_name=_(u"最新编译版本"),
        default=0,
        blank=True,
        null=True,
        max_length=200)

    name = models.CharField(max_length=150, default="", blank=False,verbose_name=_(u"名称"))
    description = models.TextField(verbose_name=_(u"产品简介"),default="",null=True,blank=True)
    applications = models.ManyToManyField("Application.G7Application",
                                     verbose_name=_(u"应用"),
                                     blank=True,
                                     related_name="projects")

    icon = models.ImageField(verbose_name=_(u"图标"),
        upload_to="project/icon/",
        default="project/icon/default_icon.png")

    owner = models.ForeignKey(settings.AUTH_USER_MODEL,
                             verbose_name=_(u"拥有人"),
                             related_name='+',
                             db_constraint=False,
                             null=True,
                             blank=True)

    members = models.ManyToManyField(settings.AUTH_USER_MODEL,
                                    verbose_name=_(u"成员"),
                                    related_name='projects',
                                    db_constraint=False,
                                    blank=True)

    identifier = models.CharField(verbose_name=_(u"标识码"),
                             max_length=100,
                             default="",
                             blank=True,unique=True)

    bundleID = models.CharField(max_length=200,
        default="",
        blank=False,
        null=False,
        verbose_name=_(u"标识符(BundleID)"),
        unique=True)

    create_at = models.DateTimeField(verbose_name=_(u"创建时间"), auto_now_add=timezone.now())
    modified_at = models.DateTimeField(verbose_name=_(u"更新时间"), auto_now=timezone.now())

    def icon_preview(self):
        return '<img src="{icon_url}" width="40px" height="40px" />'.format(icon_url=self.icon.url)

    icon_preview.short_description = _('图标')
    icon_preview.allow_tags = True

    def toJsonDict(self, host="127.0.0.1"):
# platform_choices = (
#                     (0,_(u"通用")),
#                     (1,_(u"iOS")),
#                     (2,_(u"Android")),
#                     (999,_(u"其他")),
#                    )
        platformText = "通用"
        if self.platform == 1:
            platformText = "iOS"
        elif self.platform == 2:
            platformText = "Android"
        elif self.platform == 999:
            platformText = "其他"

        installHost = host
        if "http://" in host:
            installHost = host.split("http://")[1]



        retJsonDict = {
                    "latestAppIdentifier":self.applications.last().identifier,
                    "latestAppInstallUrl":"itms-services://?action=download-manifest&url="+"https://"+installHost+"/application/info/"+self.applications.last().identifier+".plist",
                    "identifier":self.identifier,
                    "bundleId":self.bundleID,
                    "createAt":str(self.create_at),
                    "modifiedAt":str(self.modified_at),
                    "iconUrl":host+self.icon.url,
                    "projectDescription":self.description,
                    "latestVersion":self.latest_version,
                    "latestInnerVersion":str(self.latest_inner_version),
                    "latestBuildVersion":str(self.latest_build_version),
                    "pid":self.project_id,
                    "platform":platformText,
                    "name":self.name,
                    "status":self.project_status,
                    "projectType":self.project_type,
                }
        if self.owner != None:
            retJsonDict["ownner"] = self.owner.toJsonDict(host)

        return retJsonDict


    class Meta:
        verbose_name = _(u"产品")
        verbose_name_plural = _(u"产品")
        app_label = 'Application'

    def __str__(self):
        return str(self.id)+"."+self.name


class G7Application(models.Model):

    project_type_choices = (
        (0, _(u"未知(ids默认为0)")),
        (1,_(u"iPhone/iTouch版本")),
        (2,_(u"HD版本，仅适用iPad/iPad2")),
        (3,_(u"通用版本，适用iOS系列")),
    )

    user = models.ForeignKey('Account.G7User', verbose_name=_("用户"), blank=True, null=True)
    project_id = models.IntegerField(verbose_name=_(u"产品id"),default=0,blank=False,null=False)
    project_type = models.IntegerField(verbose_name=_(u"产品类型"), choices=project_type_choices, default=0, null=True,blank=True)
    channel = models.IntegerField(verbose_name=_(u"渠道"),default=0,blank=False,null=False)
    inner_version = models.IntegerField(blank=False, default=0, verbose_name=_(u"内部版本"),null=False)

    name = models.CharField(max_length=150, verbose_name=_(u"名字"))
    identifier = models.CharField(verbose_name=_(u"标识码"),
                                 max_length=100, default="",
                                 blank=True, unique=True)
    file = models.FileField(upload_to="application/package", verbose_name=_(u"ipa包文件"),blank=True,null=True)
    dsymFile = models.FileField(upload_to="application/package", verbose_name=_(u"dsym包文件"),blank=True,null=True)
    version = models.CharField(blank=True, default="0.0", verbose_name=_(u"版本"), max_length=150)
    icon = models.ImageField(verbose_name=_(u"图标"), upload_to="application/icon/", default=settings.MEDIA_URL+"application/icon/default_icon.png", blank=True)
    create_at = models.DateTimeField(verbose_name=_(u"创建时间"),  auto_now_add=timezone.now())
    modified_at = models.DateTimeField(verbose_name=_(u"更新时间"), auto_now=timezone.now())
    bundleID = models.CharField(max_length=200, default="", blank=True, null=True, verbose_name=_(u"标识符(BundleID)"))
    description = models.TextField(verbose_name=_(u"说明"), blank=True, null=True, default="")
    build_version = models.CharField(verbose_name=_(u"编译版本"),default="0", max_length=200)
    frameworks = models.ManyToManyField("Application.G7Application",verbose_name=_(u"使用到的框架"), blank=True, related_name="applications")

    def toJsonDict(self, host="127.0.0.1"):

        
        installHost = host
        if "http://" in host:
            installHost = host.split("http://")[1]

        jsonDict = {
                    "appInstallUrl":"itms-services://?action=download-manifest&url="+"https://"+installHost+"/application/info/"+self.identifier+".plist",
                    "identifier":self.identifier,
                    "bundleId":self.bundleID,
                    "createAt":str(self.create_at),
                    "modifiedAt":str(self.modified_at),
                    "iconUrl":host+self.icon.url,
                    "appDescription":self.description,
                    "channel":self.channel,
                    "innerVersion":str(self.inner_version),
                    "buildVersion":str(self.build_version),
                    "pid":self.project_id,
                    "name":self.name,
                    "fileUrl":host+self.file.url,
                    "dsymFileUrl":host+self.dsymFile.url,
                    "version":self.version,
                    "projectType":self.project_type,
                }

        if self.user != None:
            jsonDict["user"] = self.user.toJsonDict(host)

        return jsonDict


    def icon_preview(self):
        return '<img src="{icon_url}" width="40px" height="40px" />'.format(icon_url=self.icon.url)

    icon_preview.short_description = _('图标')
    icon_preview.allow_tags = True

    class Meta:
        verbose_name = _(u"应用")
        verbose_name_plural = _(u"应用")
        app_label = 'Application'

    def __str__(self):
        if self.modified_at != None:
            return str(self.id)+". "+self.name+"_Build{build_version} At ({time})".format(time=self.modified_at.replace(tzinfo=datetime.timezone.utc).astimezone(tz=None).strftime("%Y-%m-%d %H:%M:%S"),build_version=self.build_version)
