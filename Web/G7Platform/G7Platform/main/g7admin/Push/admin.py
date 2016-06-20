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
    password = forms.CharField(label='密码', widget=forms.PasswordInput)
    p12File = forms.CharField(label='私钥(p12文件)', widget=forms.FileInput)
    p12Password = forms.CharField(label='私钥密码', widget=forms.PasswordInput)
    cerFile = forms.CharField(label='公钥(cer文件)', widget=forms.FileInput)
    
    class Meta:
        model = G7PushProfile
        fields = ('username',)

    def save(self, commit=True):
        # Save the provided password in hashed format
        pushProfile = super(G7PushProfileCreationForm, self).save(commit=False)
        if pushProfile.p12Password != None and pushProfile.p12Password != "":
            p12 = crypto.load_pkcs12(open(pushProfile.p12File.path, "rb").read(), pushProfile.p12Password)
        else:
            p12 = crypto.load_pkcs12(open(pushProfile.p12File.path, "rb").read())

        pushProfile.private_pem_file.save(str(uuid.uuid3(uuid.uuid4(),str(time.time())).hex),ContentFile(crypto.dump_privatekey(crypto.FILETYPE_PEM, p12.get_privatekey())))
        cer = crypto.load_certificate(crypto.FILETYPE_ASN1, open(pushProfile.cerFile.path, "rb").read())
        pushProfile.public_pem_file.save(str(uuid.uuid3(uuid.uuid4(),str(time.time())).hex),ContentFile(crypto.dump_certificate(crypto.FILETYPE_PEM, cert.get_certificate())))

        if commit:
            pushProfile.save()
        return pushProfile

class G7PushProfileAdmin(admin.ModelAdmin):
    # The forms to add and change user instances
    add_form = G7PushProfileCreationForm
    

admin.site.register(G7PushProfile, G7PushProfileAdmin)
