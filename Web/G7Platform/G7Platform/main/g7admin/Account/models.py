#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

import uuid
from django.utils.translation import ugettext_lazy as _
from django.db import models
from django.contrib.auth.models import BaseUserManager, AbstractBaseUser, PermissionsMixin, Group, Permission,GroupManager
from django.conf import settings

class G7UserManager(BaseUserManager):
    def create_user(self, username, email, password=None):
        """
        Creates and saves a User with the given email, date of
        birth and password.
        """
        if not email:
            raise ValueError('邮箱必须填写')

        user = self.model(username=username, email=email)

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, username, email, password):
        """
        Creates and saves a superuser with the given email, date of
        birth and password.
        """
        user = self.create_user(username, email, password=password)
        user.is_admin = True
        user.save(using=self._db)
        return user

class G7Group(models.Model):

    creator = models.ForeignKey(settings.AUTH_USER_MODEL,
                                verbose_name=_('群组创建者'),
                                related_name="g7group1_set",
                                related_query_name="g7group1",
                                db_constraint=False)
    name = models.CharField(verbose_name=_('群组名'), max_length=80, unique=True)
    permissions = models.ManyToManyField(Permission,
        verbose_name=_('permissions'), blank=True)
    objects = GroupManager()
    # members = models.ManyToManyField(settings.AUTH_USER_MODEL, verbose_name=_('成员'),
    #     blank=True, related_name="groups", related_query_name="groups",)
    date_of_birth = models.DateField(auto_now=True,verbose_name=_(u"群组建立日期"))

    def natural_key(self):
        return (self.name,)

    class Meta:
        verbose_name = _(u"群组")
        verbose_name_plural = _(u"群组")
        app_label = 'Account'

    def __str__(self):

        return str(self.id)+"."+self.name

class G7User(AbstractBaseUser):

    objects = G7UserManager()

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ["email"]
        #性别选择
    sex_choices = (
                    (u"man",_(u"男")),
                    (u"female",_(u"女")),
                    (u"unknown",_(u"未知")),
                   )

#必须
    date_of_birth = models.DateField(auto_now=True,verbose_name=_(u"账户生成日期"))
    is_active = models.BooleanField(default=True,verbose_name=_(u"账户是否激活"))
    is_admin = models.BooleanField(default=False,verbose_name=_(u"是否是管理员"))

    userid = models.CharField(verbose_name=_(u"用户ID"),max_length=100,default="",blank=True)
    email = models.EmailField(verbose_name=_(u"邮箱"), max_length=255, unique=True)
    username = models.CharField(verbose_name=_(u"用户名"),max_length=255, default="", blank=False, unique=True)
    sex = models.CharField(verbose_name=_(u"性别") ,default=u"man", choices=sex_choices, blank=True, max_length=15)
    thumb = models.ImageField(verbose_name=_(u"头像") ,upload_to="user/thumbnails",default=settings.MEDIA_URL+"user/thumbnails/default_thumb.png")
    age = models.IntegerField(verbose_name=_(u"年龄") ,default=0)
    expires_time = models.DateTimeField(verbose_name=_(u"登陆过期时间"),auto_now_add=True, blank=True, null=True)
    usignature = models.CharField(verbose_name=_(u"用户登陆标识"),max_length=100, default="", blank=True)
    nickname = models.CharField(verbose_name=_(u"昵称"),max_length=255, default="", blank=True)
    clientid = models.CharField(verbose_name=_(u"客户端id"),max_length=100,default="", blank=True)
    realname = models.CharField(verbose_name=_(u"真实姓名"),max_length=255, default="", blank=True, null=True)
    job = models.CharField(verbose_name=_(u"职业"), max_length=100, default="无业游民")
    groups = models.ManyToManyField("Account.G7Group", verbose_name=_('群组'),
        blank=True, related_name="members")

    mobile = models.CharField(verbose_name=_(u"电话号码"), max_length=50, default="",null=True,blank=True)
    description = models.TextField(verbose_name=_(u"简介"), default="",null=True,blank=True)
    email_vip = models.BooleanField(verbose_name=_(u"VIP邮件接收者"), default=False)

    # mail_host = models.CharField(verbose_name=_(u"邮件发送主机"), default="", max_length=200, null=True, blank=True)
    mail_pwd = models.CharField(verbose_name=_(u"邮箱密码"), default="", max_length=200, null=True, blank=True)

    pgyer_ukey = models.CharField(verbose_name=_(u"蒲公英uKey"), default="", max_length=200, null=True, blank=True)
    pgyer_apiKey = models.CharField(verbose_name=_(u"蒲公英api_key"), default="", max_length=200, null=True, blank=True)

    def get_full_name(self):
        # The user is identified by their email address
        return self.username

    def get_short_name(self):
        # The user is identified by their email address
        return self.username

    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return True

    @property
    def is_staff(self):
        "Is the user a member of staff?"
        # Simplest possible answer: All admins are staff
        return self.is_admin

    def __iter__(self):
        pass

    class Meta:
        verbose_name = _(u"用户")
        verbose_name_plural = _(u"用户")
        app_label = 'Account'

    def __str__(self):
        if  self.realname != "":
            return str(self.id)+"."+self.realname
        else:
            return str(self.id)+"."+self.username
