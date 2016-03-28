from django.db import models

from django.utils.translation import ugettext_lazy as _
from django.conf import settings
from Account.models import G7User
# Create your models here.

class G7FeedbackModel(models.Model):

    username = models.CharField(verbose_name=_(u"联系人姓名"),max_length=200,default="",blank=True,null=True)
    contact = models.CharField(verbose_name=_(u"联系方式"),max_length=200,default="",blank=True,null=True)
    context = models.CharField(verbose_name=_(u"反馈内容"),max_length=2000,default="",blank=False,null=False)

    class Meta:
        verbose_name = _(u"反馈")
        verbose_name_plural = _(u"反馈")
        app_label = 'Feedback'

    def __str__(self):

        return str(self.username)


