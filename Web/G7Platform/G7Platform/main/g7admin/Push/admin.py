from django.contrib import admin
from django.core.files.base import ContentFile
from OpenSSL import crypto
from django import forms
from Push.models import *
from G7Platform.G7Globals import *
from io import TextIOWrapper

# # Register your models here.
# class G7PushProfileCreationForm(forms.ModelForm):
#     """A form for creating new users. Includes all the required
#     fields, plus a repeated password."""
#     push_name = forms.CharField(label='名称', widget=forms.TextInput)
#     p12_file = forms.CharField(label='私钥(p12文件)', widget=forms.FileInput)
#     p12_password = forms.CharField(label='私钥密码', widget=forms.PasswordInput)

#     class Meta:
#         model = G7PushProfile
#         fields = '__all__'

#     def save(self, commit=True):
#         # Save the provided password in hashed format

#         pushProfile = super(G7PushProfileCreationForm, self).save(commit=False)
        # if pushProfile.p12password != None and pushProfile.p12password != "":
        #     p12 = crypto.load_pkcs12(open(pushProfile.p12file.path, "rb").read(), pushProfile.p12password)
        # else:
        #     p12 = crypto.load_pkcs12(open(pushProfile.p12file.path, "rb").read())

        # pushProfile.private_pem_file.save(str(uuid.uuid3(uuid.uuid4(),str(time.time())).hex),ContentFile(crypto.dump_privatekey(crypto.FILETYPE_PEM, p12.get_privatekey())))
        # pushProfile.public_pem_file.save(str(uuid.uuid3(uuid.uuid4(),str(time.time())).hex),ContentFile(crypto.dump_certificate(crypto.FILETYPE_PEM, p12.get_certificate())))

#         if commit:
#             pushProfile.save()
#         return pushProfile


class G7PushProfileCreationForm(forms.ModelForm):

    class Meta:
        model = G7PushProfile
        fields = '__all__'


    def save(self, commit=True):

        p12file = self.cleaned_data.get("p12file")
        p12password = self.cleaned_data.get("p12password")
        g7log(dir(p12file.file))
        g7log(type(p12file))
        pushProfile = super(G7PushProfileCreationForm, self).save(commit=commit)
        if p12file != None:
            fileContent = p12file.file.read()
            if p12password != None and p12password != "":
                p12 = crypto.load_pkcs12(fileContent, p12password)
            else:
                p12 = crypto.load_pkcs12(fileContent)

            privateIdentifier = str(uuid.uuid3(uuid.uuid4(),str(time.time())).hex)
            publicIdentifier = str(uuid.uuid3(uuid.uuid4(),str(time.time())).hex)
            pushProfile.identifier = str(uuid.uuid3(uuid.uuid4(),str(time.time())).hex)
            g7log("publicIdentifier:{publicIdentifier}, privateIdentifier:{privateIdentifier}".format(publicIdentifier=publicIdentifier, privateIdentifier=privateIdentifier))
            pushProfile.private_pem_file.save(privateIdentifier,ContentFile(crypto.dump_privatekey(crypto.FILETYPE_PEM, p12.get_privatekey())))
            pushProfile.public_pem_file.save(publicIdentifier,ContentFile(crypto.dump_certificate(crypto.FILETYPE_PEM, p12.get_certificate())))

        if commit:
            pushProfile.save()

        return pushProfile


class G7PushProfileAdmin(admin.ModelAdmin):
    # The forms to add and change user instances
    form = G7PushProfileCreationForm

    fieldsets = (
        (None, {
            'fields': ('name', 'p12file', 'p12password', 'using')
        }),
        ('Advanced options', {
            'classes': ('collapse',),
            'fields': ('private_pem_file', 'public_pem_file', 'identifier'),
        }),
    )


    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('name', 'p12file', 'p12password', 'using')
            }
        ),
    )

    readonly_fields = ("identifier",)

class G7PushNotificatinTokenAdmin(admin.ModelAdmin):
    pass

admin.site.register(G7PushProfile, G7PushProfileAdmin)
admin.site.register(G7PushNotificatinToken, G7PushNotificatinTokenAdmin)
