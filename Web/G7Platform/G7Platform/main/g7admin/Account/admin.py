#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

from django import forms
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin,GroupAdmin
from django.contrib.auth.forms import ReadOnlyPasswordHashField
from django.utils.translation import ugettext, ugettext_lazy as _
from django.contrib.auth.models import Group
from Account.models import G7User,G7Group
from django.db.models.fields.related import ManyToManyRel
from django.contrib.admin.widgets import RelatedFieldWidgetWrapper,FilteredSelectMultiple
from django.db.models.fields import FieldDoesNotExist
import uuid
class G7GroupForm(forms.ModelForm):

    members = forms.ModelMultipleChoiceField(
        queryset=G7User.objects.all(),
        required=False,
        widget=FilteredSelectMultiple(verbose_name=_(u'成员'),is_stacked=False),
        label=_(u"成员")
    )

    class Meta:
        model = G7Group
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        super(G7GroupForm, self).__init__(*args, **kwargs)

        if self.instance.pk:
            self.fields['members'].initial = self.instance.members.all()
            self.fields['members'].widget = RelatedFieldWidgetWrapper(
                                                FilteredSelectMultiple(_(u'成员'),False),
                                                G7User._meta.get_field('groups').rel,
                                                admin.site)
            self.fields['members'].queryset = G7User.objects.all()

    def save(self, commit=True):
        instance = super(G7GroupForm, self).save(commit=commit)
        if instance.pk:
            for member in instance.members.all():
                if member not in self.cleaned_data['members']:
                    instance.members.remove(member)
            for member in self.cleaned_data['members']:
                if member not in instance.members.all():
                    member.userid = uuid.uuid4().hex
                    member.usignature = uuid.uuid4().hex
                    member.clientid = uuid.uuid4().hex
                    instance.members.add(member)
            '''{'members': [<G7User: 1.root>], 'creator': <G7User: 1.root>, 'permissions': [], 'name': 'asdfasdfasdfasdf'}'''
        else:
            self.instance.creator = self.cleaned_data["creator"]
            self.instance.name = self.cleaned_data["name"]
            self.instance.save()
            for user in self.cleaned_data["members"]:
                user.userid = uuid.uuid4().hex
                user.usignature = uuid.uuid4().hex
                user.clientid = uuid.uuid4().hex
                user.groups.add(self.instance)
            for permission in self.cleaned_data["permissions"]:
                self.instance.permissions.add(permission)
        if commit:
            instance.save()

        return instance




class G7GroupAdmin(admin.ModelAdmin):

    form = G7GroupForm

    search_fields = ('name',)
    ordering = ('id',)
    filter_horizontal = ('permissions',)
    fieldsets = (
        ('介绍', {'fields': ("name", "creator")}),
        ('成员', {'fields': ('members',)}),
        ('权限', {'fields': ('permissions',)}),
    )

    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('name', 'members', 'permissions',)}
        ),
    )


    def formfield_for_manytomany(self, db_field, request=None, **kwargs):
        if db_field.name == 'permissions':
            qs = kwargs.get('queryset', db_field.rel.to.objects)
            # Avoid a major performance hit resolving permission names which
            # triggers a content_type load:
            kwargs['queryset'] = qs.select_related('content_type')

        return super(G7GroupAdmin, self).formfield_for_manytomany(db_field, request=request, **kwargs)



class UserCreationForm(forms.ModelForm):
    """A form for creating new users. Includes all the required
    fields, plus a repeated password."""
    password1 = forms.CharField(label='密码', widget=forms.PasswordInput)
    password2 = forms.CharField(label='重复密码', widget=forms.PasswordInput)

    class Meta:
        model = G7User
        fields = ('username',)

    def clean_password2(self):
        # Check that the two password entries match
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            raise forms.ValidationError("密码和重复密码必须相同")
        return password2

    def save(self, commit=True):
        # Save the provided password in hashed format
        user = super(UserCreationForm, self).save(commit=False)
        user.set_password(self.cleaned_data["password1"])
        user.userid = str(uuid.uuid3(uuid.uuid4(),str(time.time())).hex)
        user.usignature = str(uuid.uuid3(uuid.uuid4(),str(time.time())).hex)
        user.clientid = str(uuid.uuid3(uuid.uuid4(),str(time.time())).hex)

        if commit:
            user.save()
        return user


class UserChangeForm(forms.ModelForm):
    """A form for updating users. Includes all the fields on
    the user, but replaces the password field with admin's
    password hash display field.
    """
    password = ReadOnlyPasswordHashField(label=_("Password"),
        help_text=_("Raw passwords are not stored, so there is no way to see "
                    "this user's password, but you can change the password "
                    "using <a href=\"password/\">this form</a>."))


    class Meta:
        model = G7User
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        super(UserChangeForm, self).__init__(*args, **kwargs)
        f = self.fields.get('user_permissions', None)
        if f is not None:
            f.queryset = f.queryset.select_related('content_type')

    def clean_password(self):
        # Regardless of what the user provides, return the initial value.
        # This is done here, rather than on the field, because the
        # field does not have access to the initial value
        return self.initial["password"]


class G7UserAdmin(UserAdmin):
    # The forms to add and change user instances
    # The forms to add and change user instances
    form = UserChangeForm
    add_form = UserCreationForm

    # The fields to be used in displaying the User model.
    # These override the definitions on the base UserAdmin
    # that reference specific fields on auth.User.
    list_display = ('username', 'realname','email', 'email_vip', 'job')
    list_filter = ('is_admin',)
    ordering = ('id',)

    fieldsets = (
        (None, {'fields': ('username', 'password',"description")}),
        ('用户资料', {'fields': ("job",'sex','thumb','age','userid','nickname','realname',"mobile")}),
        ('小组', {'fields': ('groups',)}),
        ("邮件设置", {"fields": ( "email", "mail_pwd",)}),
        ("蒲公英", {"fields": ("pgyer_ukey", "pgyer_apiKey")}),
        ('权限', {'fields': ('is_admin', 'email_vip')}),
    )
    # add_fieldsets is not a standard ModelAdmin attribute. UserAdmin
    # overrides get_fieldsets to use this attribute when creating a user.
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('username', 'email', 'password1', 'password2')}
        ),
    )

    readonly_fields = ("userid",)

    def to_field_allowed(self, request, to_field):
        rv = super(G7UserAdmin, self).to_field_allowed(request, to_field)
        if not rv:
            opts = self.model._meta
            try:
                return opts.get_field(to_field)==opts.pk and len(opts.many_to_many)
            except FieldDoesNotExist:
                return False
        return rv

    search_fields = ('username',)
    filter_horizontal = ("groups",)


# Now register the new UserAdmin...
admin.site.register(G7User, G7UserAdmin)
admin.site.unregister(Group)
admin.site.register(G7Group, G7GroupAdmin)
