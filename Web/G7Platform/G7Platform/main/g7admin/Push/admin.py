from django.contrib import admin
from django.core.files.base import ContentFile
from OpenSSL import crypto
from django import forms
from Push.models import *

# Register your models here.
class G7PushProfileCreationForm(forms.ModelForm):
    """A form for creating new users. Includes all the required
    fields, plus a repeated password."""
    name = forms.CharField(label='名称', widget=forms.TextInput)
    p12File = forms.CharField(label='私钥(p12文件)', widget=forms.FileInput)
    p12Password = forms.CharField(label='私钥密码', widget=forms.PasswordInput)

    class Meta:
        model = G7PushProfile
        fields = ('name', 'password', 'p12File', 'p12Password', 'cerFile',)

    def save(self, commit=True):
        # Save the provided password in hashed format
        pushProfile = super(G7PushProfileCreationForm, self).save(commit=False)
        if pushProfile.p12Password != None and pushProfile.p12Password != "":
            p12 = crypto.load_pkcs12(open(pushProfile.p12File.path, "rb").read(), pushProfile.p12Password)
        else:
            p12 = crypto.load_pkcs12(open(pushProfile.p12File.path, "rb").read())

        pushProfile.private_pem_file.save(str(uuid.uuid3(uuid.uuid4(),str(time.time())).hex),ContentFile(crypto.dump_privatekey(crypto.FILETYPE_PEM, p12.get_privatekey())))
        pushProfile.public_pem_file.save(str(uuid.uuid3(uuid.uuid4(),str(time.time())).hex),ContentFile(crypto.dump_certificate(crypto.FILETYPE_PEM, p12.get_certificate())))

        if commit:
            pushProfile.save()
        return pushProfile

class G7PushProfileAdmin(admin.ModelAdmin):
    # The forms to add and change user instances
    add_form = G7PushProfileCreationForm
    
    # identifier = models.CharField(verbose_name=_(u"标识码"),
    #                          max_length=100,
    #                          default="",
    #                          blank=True,unique=True)

    # name = models.CharField(verbose_name=_(u"名称"),
    #                          max_length=100,
    #                          default="",
    #                          blank=False,unique=False)

    # p12file = models.FileField(upload_to="push/profile", verbose_name=_(u"p12文件"),blank=False,null=False)
    # p12password = models.CharField(verbose_name=_(u"p12文件密码"),
    #                          max_length=100,
    #                          default="",
    #                          blank=False,unique=False)
    # cerfile = models.FileField(upload_to="push/profile", verbose_name=_(u"cer文件"),blank=False,null=False)
    # private_pem_file = models.FileField(upload_to="push/profile/private", verbose_name=_(u"私钥文件"),blank=True,null=True)
    # public_pem_file = models.FileField(upload_to="push/profile/public", verbose_name=_(u"公钥文件"),blank=True,null=True)


    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('name', 'p12File', 'p12Password', 'cerFile')}
        ),
    )


admin.site.register(G7PushProfile, G7PushProfileAdmin)
