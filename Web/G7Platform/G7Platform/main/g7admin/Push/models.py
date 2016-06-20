from django.db import models

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

    password = models.CharField(verbose_name=_(u"密码"),
                             max_length=100,
                             default="",
                             blank=False,unique=False)

    p12file = models.FileField(upload_to="push/profile", verbose_name=_(u"p12文件"),blank=False,null=False)
    p12password = models.CharField(verbose_name=_(u"p12文件密码"),
                             max_length=100,
                             default="",
                             blank=False,unique=False)
    cerfile = models.FileField(upload_to="push/profile", verbose_name=_(u"cer文件"),blank=False,null=False)
    private_pem_file = models.FileField(upload_to="push/profile/private", verbose_name=_(u"私钥文件"),blank=True,null=True)
    public_pem_file = models.FileField(upload_to="push/profile/public", verbose_name=_(u"公钥文件"),blank=True,null=True)
    
    